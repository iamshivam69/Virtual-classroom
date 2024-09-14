package studentmanagement.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import studentmanagement.model.Student;

@Repository
public interface StudentRepository extends JpaRepository<Student, Long> {

    // Custom query to find a student by email
    Student findByEmail(String email);
}