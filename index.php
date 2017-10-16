<?php
require_once('lib/util.php');
/*Гостевая книга

    Гостевая книга предоставляет возможность пользователям сайта оставлять сообщения на сайте.
    Все данные введенные пользователем сохраняются в БД MySQL, так же в базе данных сохраняются данные о IP пользователя и его браузере.
    Форма добавления записи в гостевую книгу должна иметь следующие поля:

    User Name (цифры и буквы латинского алфавита)                        – обязательное поле
    E-mail (формат email)                                                – обязательное поле
    Homepage (формат url)                                                – необязательное поле
    CAPTCHA (цифры и буквы латинского алфавита)                          – изображение и обязательное поле
    Text (непосредственно сам текст сообщения, HTML тэги недопустимы)    – обязательное поле
    Tags                                                                 - теги, (ключевые слова сообщения)

    Требования:
    +    Сообщения должны добавляться через AJAX.
    -   Сообщения должны выводится в виде таблицы, с возможностью поиска по следующим полям: User Name, e-mail, дата добавления, теги.
    +    Сообщения должны подгружаться на страницу при скроллинге, после прокрутки всех сообщений пользователю должно быть выведено сообщение о том, что сообщение в базе больше нет.
    */

$user_request_uri = strtolower($_SERVER['REQUEST_URI']);
$avd_base_uri     = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
$db_conn          = db_open();
$sql              = "SELECT * FROM mytable ORDER BY id DESC LIMIT 0,20;";
$db_res           = $db_conn->query($sql);
$comments         = '';
if ($db_res) {
    while ($r = $db_res->fetch_assoc()) {
        $comments .= file_get_contents('tpl/comments.tpl');
        foreach ($r as $k => $v) {
            $t        = "{" . $k . "}";
            $comments = str_ireplace($t, $v, $comments);
        }
    }
}

if (preg_match("/([^a-zA-Z0-9\.\/\-\_])/", $user_request_uri)) {
    throw new Exception('Указанная страница - ' . $avd_base_uri . ', не найдена!');
}
$user_request_uri = preg_split("/(\/|-|_|\.)/", $user_request_uri, -1, PREG_SPLIT_NO_EMPTY);
// выясним длину получившегося массива параметров
$l = count($user_request_uri);
if (($l === 0) or ($user_request_uri[0] === 'index')) {
    $user_request_path = '';
} else {
    throw new Exception('Указанная страница - ' . $avd_base_uri . ', недоступна!');
}


$response = file_get_contents('tpl/head.tpl');
$response .= file_get_contents('tpl/body.tpl');
$response .= file_get_contents('tpl/footer.tpl');
$response = str_replace('{comments}', $comments, $response);

echo $response;
?>