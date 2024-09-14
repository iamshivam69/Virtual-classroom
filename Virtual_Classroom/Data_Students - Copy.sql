use data_virtual_class;
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255),
    role ENUM('admin', 'instructor', 'student') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Classes (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    instructor_id INT NOT NULL,
    class_name VARCHAR(100),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (instructor_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
CREATE TABLE Units (
    unit_id INT PRIMARY KEY AUTO_INCREMENT,
    class_id INT NOT NULL,
    unit_name VARCHAR(100),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id) ON DELETE CASCADE
);
CREATE TABLE Sessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    unit_id INT NOT NULL,
    session_name VARCHAR(100),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (unit_id) REFERENCES Units(unit_id) ON DELETE CASCADE
);

CREATE TABLE Lectures (
    lecture_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id INT NOT NULL,
    lecture_title VARCHAR(100),
    lecture_content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (session_id) REFERENCES Sessions(session_id) ON DELETE CASCADE
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    class_id INT NOT NULL,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id) ON DELETE CASCADE,
    UNIQUE (user_id, class_id)
);
CREATE TABLE Comments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    lecture_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    parent_comment_id INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (lecture_id) REFERENCES Lectures(lecture_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (parent_comment_id) REFERENCES Comments(comment_id) ON DELETE CASCADE
);

