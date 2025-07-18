from flask import Flask, render_template, request, redirect, session
from flask_mysqldb import MySQL
import os

# Initialize Flask app
app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Secret key for session management

# MySQL Configuration
app.config['MYSQL_HOST'] = 'localhost'         # MySQL server host
app.config['MYSQL_USER'] = 'root'              # MySQL username
app.config['MYSQL_PASSWORD'] = 'shree-krishna'  # MySQL password
app.config['MYSQL_DB'] = 'faculty_db'          # MySQL database name

mysql = MySQL(app)  # Initialize MySQL extension

@app.route('/')
def faculty_home():
    # Render the home page for faculty directory
    return render_template('faculty_home.html')

@app.route('/showfaculty')
def show_faculty():
    # Display paginated list of faculty members
    page = request.args.get('page', default=1, type=int)  # Current page number from query parameter
    per_page = 6  # Number of faculty records per page
    offset = (page - 1) * per_page  # Calculate offset for SQL query

    cur = mysql.connection.cursor()

    # Get total number of faculty records for pagination
    cur.execute("SELECT COUNT(*) FROM faculty")
    total_records = cur.fetchone()[0]
    total_pages = (total_records + per_page - 1) // per_page  # Calculate total pages

    # Fetch faculty records for the current page
    cur.execute("SELECT id, name, title, department, photo FROM faculty LIMIT %s OFFSET %s", (per_page, offset))
    faculty_list = cur.fetchall()

    # Render faculty list template with pagination data
    return render_template('faculty_list.html', faculty=faculty_list, page=page, total_pages=total_pages)

@app.route('/faculty/<int:id>', methods=['GET', 'POST'])
def view_profile(id):
    cur = mysql.connection.cursor()

    # If form submitted, handle feedback OR rating
    if request.method == 'POST':
        name = request.form.get('name') or "Anonymous"
        comment = request.form.get('comment')
        stars = request.form.get('stars')

        # If stars are given, it's a rating
        if stars:
            stars = int(stars)
            if 1 <= stars <= 5:
                cur.execute(
                    "INSERT INTO ratings (faculty_id, stars, comment) VALUES (%s, %s, %s)",
                    (id, stars, comment)
                )
                mysql.connection.commit()
        # Otherwise treat as feedback only
        elif comment:
            cur.execute(
                "INSERT INTO feedback (faculty_id, name, comment) VALUES (%s, %s, %s)",
                (id, name, comment)
            )
            mysql.connection.commit()

    # Get faculty info
    cur.execute("SELECT * FROM faculty WHERE id = %s", (id,))
    faculty = cur.fetchone()

    # Get feedback list
    cur.execute("SELECT name, comment, timestamp FROM feedback WHERE faculty_id = %s ORDER BY timestamp DESC", (id,))
    feedback_rows = cur.fetchall()
    feedback_list = [
        {'name': row[0], 'comment': row[1], 'timestamp': row[2]}
        for row in feedback_rows
    ]

    # Get average rating
    cur.execute("SELECT AVG(stars) FROM ratings WHERE faculty_id = %s", (id,))
    avg_rating = cur.fetchone()[0]

    # Get all ratings
    cur.execute("SELECT stars, comment, timestamp FROM ratings WHERE faculty_id = %s ORDER BY timestamp DESC", (id,))
    ratings_rows = cur.fetchall()
    ratings_list = [
        {'stars': row[0], 'comment': row[1], 'timestamp': row[2]}
        for row in ratings_rows
    ]

    return render_template(
        'faculty_profile.html',
        faculty=faculty,
        feedback_list=feedback_list,
        avg_rating=round(avg_rating or 0, 1),
        ratings_list=ratings_list
    )



@app.route('/about')
def about():
    # Render the about page
    return render_template('faculty_about.html')


@app.route('/search')
def search():
    query = request.args.get('query', '').strip()

    if not query:
        return redirect('/showfaculty')

    cur = mysql.connection.cursor()

    # Filter by name OR title OR department
    cur.execute("""
        SELECT id, name, title, department, photo 
        FROM faculty 
        WHERE name LIKE %s OR title LIKE %s OR department LIKE %s
    """, (f"%{query}%", f"%{query}%", f"%{query}%"))

    results = cur.fetchall()

    return render_template('faculty_list.html', faculty=results, page=1, total_pages=1)


@app.route('/admin_search')
def admin_search():
    # Only allow if logged in as admin
    if not session.get('admin'):
        return redirect('/login')

    query = request.args.get('query', '')
    if not query.strip():
        return redirect('/admin_dashboard')

    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT id, name, title, department, photo 
        FROM faculty 
        WHERE name LIKE %s OR title LIKE %s OR department LIKE %s
    """, (f"%{query}%", f"%{query}%", f"%{query}%"))
    
    results = cur.fetchall()

    # Render admin dashboard with search results
    return render_template('admin_dasboard.html', faculty=results)


@app.route('/add', methods=['GET', 'POST'])
def add_faculty():
    # Add a new faculty member (admin only)
    if not session.get('admin'):
        return redirect('/login')  # Redirect if not logged in as admin

    if request.method == 'POST':
        # Get form data from the request
        name = request.form['name']
        title = request.form['title']
        department = request.form['department']
        email = request.form['email']
        phone = request.form['phone']
        bio = request.form['bio']
        photo = request.files['photo']

        filename = photo.filename
        photo.save(os.path.join('static/photos/', filename))  # Save uploaded photo

        # Insert new faculty record into the database
        cur = mysql.connection.cursor()
        cur.execute("""INSERT INTO faculty 
                       (name, title, department, email, phone, bio, photo) 
                       VALUES (%s, %s, %s, %s, %s, %s, %s)""",
                    (name, title, department, email, phone, bio, filename))
        mysql.connection.commit()
        return redirect('/admin_dashboard')
    return render_template('add_faculty.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Hardcoded admin check
        if username == 'admin' and password == 'admin123':
            session['admin'] = True
            return redirect('/admin_dashboard')

        # Faculty or Student check from database
        cur = mysql.connection.cursor()
        cur.execute("SELECT id, username, password, role FROM users WHERE username = %s", (username,))
        user = cur.fetchone()

        if user and password == user[2]:  # If you use hashing, check with hash instead
            session['user_id'] = user[0]
            session['username'] = user[1]
            session['role'] = user[3]
            return redirect('/showfaculty')  # After login, go to faculty list
        else:
            error = 'Invalid credentials'
    return render_template('login.html', error=error)


@app.route('/admin_dashboard')
def admin_dashboard():
    # Admin dashboard showing all faculty records
    if not session.get('admin'):
        return redirect('/login')
    cur = mysql.connection.cursor()
    cur.execute("SELECT id, name, title, department, photo FROM faculty")
    faculty = cur.fetchall()
    return render_template('admin_dasboard.html', faculty=faculty)

@app.route('/edit/<int:id>', methods=['GET', 'POST'])
def edit_faculty(id):
    # Edit faculty details (admin only)
    if not session.get('admin'):
        return redirect('/login')

    cur = mysql.connection.cursor()

    if request.method == 'POST':
        # Get updated data from the form
        name = request.form['name']
        title = request.form['title']
        department = request.form['department']
        email = request.form['email']
        phone = request.form['phone']
        bio = request.form['bio']

        # Update faculty record in the database
        cur.execute("""
            UPDATE faculty
            SET name=%s, title=%s, department=%s, email=%s, phone=%s, bio=%s
            WHERE id=%s
        """, (name, title, department, email, phone, bio, id))
        mysql.connection.commit()
        return redirect('/admin_dashboard')

    # Fetch current faculty data for editing
    cur.execute("SELECT * FROM faculty WHERE id = %s", (id,))
    faculty = cur.fetchone()
    return render_template('edit_faculty.html', faculty=faculty)

@app.route('/delete/<int:id>')
def delete_faculty(id):
    # Delete a faculty record (admin only)
    if not session.get('admin'):
        return redirect('/login')
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM faculty WHERE id = %s", (id,))
    mysql.connection.commit()
    return redirect('/admin_dashboard')


@app.route('/forgot-password', methods=['GET', 'POST'])
def forgot_password():
    message = ''
    if request.method == 'POST':
        email = request.form['email']

        cur = mysql.connection.cursor()
        cur.execute("SELECT id FROM users WHERE username = %s", (email,))
        user = cur.fetchone()

        if user:
            temp_password = "Admin@123"  # Replace with secure generation in production
            cur.execute("UPDATE users SET password = %s WHERE username = %s", (temp_password, email))
            mysql.connection.commit()
            message = f"A temporary password has been set to '{temp_password}'. Please login and change it."
        else:
            message = "Email not found in system."
        cur.close()

    return render_template('forgot_password.html', message=message)

if __name__ == '__main__':
    # Run the Flask app in debug mode
    app.run(debug=True)