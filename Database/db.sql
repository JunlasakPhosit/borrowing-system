-- Database schema for Borrowing Management System

-- Create users table
CREATE TABLE `users` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `username` varchar(50) NOT NULL,
    `password` varchar(255) NOT NULL,
    `role` enum('admin','user') NOT NULL DEFAULT 'user',
    `student_id` varchar(20) NULL,
    `first_name` varchar(100) NULL,
    `last_name` varchar(100) NULL,
    `profile_image` varchar(255) DEFAULT 'default.jpg',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create categories table
CREATE TABLE `categories` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(100) NOT NULL,
    `description` text NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create equipment table
CREATE TABLE `equipment` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `description` text NULL,
    `quantity` int(11) NOT NULL DEFAULT 0,
    `category_id` int(11) NOT NULL,
    `image` varchar(255) DEFAULT 'default.jpg',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create borrowings table
CREATE TABLE `borrowings` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `user_id` int(11) NOT NULL,
    `equipment_id` int(11) NOT NULL,
    `quantity` int(11) NOT NULL,
    `borrow_date` date NOT NULL,
    `return_date` date NULL,
    `status` enum('borrowed','returned') NOT NULL DEFAULT 'borrowed',
    `approval_status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
    `approved_by` int(11) NULL,
    `approved_at` timestamp NULL,
    `rejection_reason` text NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert sample data
-- Insert admin user (password: admin123)
INSERT INTO `users` (`username`, `password`, `role`, `first_name`, `last_name`) VALUES
('admin', '$2y$10$HYMbFpTM9JOyUws/qfyv4uufGJnmb1J.WIDhqYnxkZSVPadvVBgJy', 'admin', 'Admin', 'User');

-- Insert sample categories
INSERT INTO `categories` (`name`, `description`) VALUES
('คอมพิวเตอร์', 'อุปกรณ์คอมพิวเตอร์'),
('อุปกรณ์สำนักงาน', 'อุปกรณ์สำหรับการเรียน'),
('อุปกรณ์กีฬา', 'อุปกรณ์สำหรับการกีฬา'),
('อุปกรณ์ทั่วไป', 'อุปกรณ์ทั่วไป');

-- Insert sample equipment
INSERT INTO `equipment` (`name`, `description`, `quantity`, `category_id`) VALUES
('Laptop', 'Laptop for students', 5, 1),
('Projector', 'Projector for presentations', 2, 2),
('Basketball', 'Basketball for sports', 10, 3),
('Whiteboard Markers', 'Markers for whiteboard', 20, 4);