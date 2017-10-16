<?php
    require_once('../lib/util.php');
    $db_conn = db_open();

    $sql = "
        CREATE TABLE mytable(
            id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
            Username VARCHAR(255) NOT NULL,
            Email VARCHAR(255) NOT NULL,
            Homepage VARCHAR(255) DEFAULT NULL,
            `Text` TEXT NOT NULL,
            tags TEXT DEFAULT NULL,
            ipad VARCHAR(255) DEFAULT NULL,
            browser VARCHAR(255) DEFAULT NULL,
            sdate DATE NOT NULL,
            PRIMARY KEY (id)
    )
    ENGINE = INNODB
    AUTO_INCREMENT = 919
    AVG_ROW_LENGTH = 2409
    CHARACTER SET utf8
    COLLATE utf8_general_ci;";

    $db_res = $db_conn->query($sql);

    if ($db_res)
        echo "База данных успешно создана!";
    else "База данных не создана!";

?>