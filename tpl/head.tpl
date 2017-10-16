<!doctype html>
<html lang="ru">
<head>
    <meta charset="utf-8"/>
    <title>Гостевая книга</title>
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/myjslib.js"></script>
    <script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"
            async defer>
    </script>

    <script type="text/javascript">
        var onloadCallback = function() {
           var grek = grecaptcha.render('GoogleK', {
                'sitekey' : '6LdDQCsUAAAAAIg8ROfAoAqhEGPNlevx7FeinGzz'
            });
        };
    </script>

    <script>
        $(document).ready(function () {

            var onloadCallback = function() {
                grecaptcha.render('html_element', {
                    'sitekey' : '6LdDQCsUAAAAAIg8ROfAoAqhEGPNlevx7FeinGzz'
                });
            };


            function GetScrollHeight() {
                var temp = Math.max(
                    document.body.scrollHeight, document.documentElement.scrollHeight,
                    document.body.offsetHeight, document.documentElement.offsetHeight,
                    document.body.clientHeight, document.documentElement.clientHeight
                );
                return temp;
            }

            var scrollHeight = 0, CHeigt = 0, scrollflag = 0, commentsoffset = 0, commentsadd = 0, iscomments = true;

            $(document).on("scroll", function () {
                if (iscomments == true) {
                    CHeigt = window.pageYOffset;
                    scrollHeight = GetScrollHeight();
                    if ((scrollHeight - CHeigt) < 868) {
                        scrollflag++;
                        if (scrollflag == 1) {
                            $.ajax({
                                url: 'ajax/getnews.php',
                                type: 'POST',
                                data: {'commentsoffset':commentsoffset,'cad':commentsadd} ,
                                dataType: "json",
                                beforeSend: function () {
                                    $('<img src="../img/load.gif"/>').appendTo('#load');
                                },
                                success: function (data) {
                                    for (var p in data) {
                                        var NewInsert = $('<tr></tr>');
                                        for (var t in data[p]) {
                                            NewInsert.append("<td>" + data[p][t] + "</td>");
                                        }
                                        NewInsert.appendTo('#ForTest');
                                    }
                                    scrollflag = 0;
                                    commentsoffset++;
                                    if (data.length < 5) {
                                        iscomments = false;
                                        $('<div class="col col-sm-12"><div class="endofcomments"> <h2>Сообщений больше нет!</h2> </div></div>').insertAfter('#ForTest');
                                    }

                                },
                                complete: function () {
                                    $('#load').children('img').remove();
                                }
                            }).fail(function () {
                                alert('Подгрузить новости не удалось!');
                            });
                        }
                    }
                }
            });


            $("#MoiPoisk").on("input", function () {

                var usreq = $(this).val();
                if (usreq.length >= 2) {
                    $.ajax({
                        url: '/ajax/search.php',
                        type: 'POST',
                        data:{'request':usreq},
                        dataType: "json",
                        success: function (data) {
                            if (data.length > 0) {
                                $('#result').remove();
                                $('<div id="result" style="background: green"><div class="col col-sm-12"><h3 id="pos">Результаты поиска:</h3></div></div>').insertAfter('#AddCommentForm');
                                $('<table class="table table-striped col col-sm-12 maintable" id="searchresult">' +
                                    '<tr id="DataTable">' +
                                    '<th>UserName</th> ' +
                                    '<th>Email</th> ' +
                                    '<th>Home Page</th> ' +
                                    '<th>Text</th> ' +
                                    '<th>Tags</th> ' +
                                    '<th>Date</th> ' +
                                    '<th>Ip</th> ' +
                                    '<th>Browser</th> ' +
                                    '</tr> ' +
                                    '</table>').appendTo('#result');

                                for (var p in data) {
                                    var NewInsert = $('<tr style="background: bisque"></tr>');
                                    for (var t in data[p]) {
                                        NewInsert.append("<td>" + data[p][t] + "</td>");
                                    }
                                    NewInsert.appendTo('#searchresult');
                                }
                            } else {
                                $('#result').remove();
                                $('<div id="result" style="background: green"><div class="col col-sm-12"><h3 id="pos">Результаты поиска: Нечего не найдено, попробуйте снова</h3></div></div>').insertAfter('#AddCommentForm');
                            }

                        }
                    }).fail(function () {
                        alert('Подгрузить новости не удалось!');
                    });
                }
                else {
                    $('#result').remove();
                }
            });


            $("#AddComment").click(function () {
                $('#AddCommentForm').slideToggle("slow");
            });

            $('#AddCommentSend').click(function () {

                var errors = [];

                var gkresponse = grecaptcha.getResponse();

                var SubmittedData = {
                    'username': $("input[name='username']").val(),
                    'email': $("input[name='email']").val(),
                    'homepage': $("input[name='homepage']").val(),
                    'text': $("textarea[name='text']").val(),
                    'tags': $("input[name='tags']").val()
                };

                if (SubmittedData['username'].length < 3){
                    errors.push('Неправильное имя пользователя!');
                }
                if (SubmittedData['email'].length < 3){
                    errors.push('Неправильный email!');
                }
                if (SubmittedData['text'].length < 3) {
                    errors.push('Введите комментарий!');
                }
                if (SubmittedData['tags'].length < 3 ) {
                    errors.push('Введите теги!');
                }

                if (gkresponse.length == 0){
                    errors.push('Пройдите каптчу!!!!!');
                }


                if (errors.length == 0) {
                    $.ajax({
                        url: '/ajax/addcomment.php',
                        type: "POST",
                        data: SubmittedData,
                        dataType: "json",
                        success: function (data) {
                            var NewInsert = $('<tr></tr>');
                            for (var p in data) {
                                NewInsert.append("<td>" + data[p] + "</td>");
                            }
                            NewInsert.css("background", "yellow");
                            alert("Сообщение успешно добавилось!!!");
                            grecaptcha.reset();
                           // $('#CommentForm').reset();
                            document.getElementById('CommentForm').reset();
                            NewInsert.insertAfter('#DataTable');
                            commentsadd++;
                            $("#AddComment").click();
                        }
                    }).fail(function () {
                        alert("Что-то пошло не так!");
                    });
                } else {
                    for (var k in errors)
                        alert(errors[k]);
                }
            });

        });
    </script>
</head>
<body>


