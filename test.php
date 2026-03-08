<?php
require_once 'config.php';

try {
    // Test connection
    echo "Database connection successful!<br>";

    // Test query
    $stmt = $pdo->query("SELECT COUNT(*) as user_count FROM users");
    $result = $stmt->fetch();
    echo "Number of users: " . $result['user_count'] . "<br>";

    // Test categories
    $stmt = $pdo->query("SELECT COUNT(*) as cat_count FROM categories");
    $result = $stmt->fetch();
    echo "Number of categories: " . $result['cat_count'] . "<br>";

    // Test equipment
    $stmt = $pdo->query("SELECT COUNT(*) as equip_count FROM equipment");
    $result = $stmt->fetch();
    echo "Number of equipment: " . $result['equip_count'] . "<br>";

    echo "All tests passed!";

} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>