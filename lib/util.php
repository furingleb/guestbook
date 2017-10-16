<?php

function db_open()
{

    $servername = "localhost";                                // сервер БД
    $username   = "root";                                     // пользователь БД
    $password   = "";                                         // пароль пользователя БД
    $dbname     = "testdatabase";                             // Имя БД
    // подключимся к БД

    $db_conn = new mysqli($servername, $username, $password, $dbname);

    // проверка соединения к серверу
    if ($db_conn->connect_errno) {
        throw new Exception(printf("Not connect: %s \n", $db_conn->connect_error));
    } else {
        $db_conn->set_charset('utf8');
        return $db_conn;
    }

}


function clear_text($value,$db_c)
{
     $value = trim($value);
    // $value = strip_tags($value);
    // $value = htmlspecialchars($value);
     //$value = $db_c->real_escape_string($value);

    return $value;
}

?>