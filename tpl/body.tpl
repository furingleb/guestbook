<div class="container-fluid" id="MainWrap" style="margin: auto 30px">
    <div class="row">

        <div class="col col-sm-12" style="margin-top: 30px">
            <h2>
                Гостевая книга
            </h2>
        </div>

        <div class="col col-sm-3">
            <input type="text" placeholder="Search" id="MoiPoisk">
        </div>

        <div class="col col-sm-12" id="AddComment">
            <h3>
                Добавить комментарий
            </h3>
        </div>


        <div class="col col-sm-6 AddCommentForm" id="AddCommentForm" style="display: none;">
            <div class="row">
                <form id="CommentForm" action="?" method="POST">
                    <div class="col col-sm-6">
                        <b>User Name</b>
                        <input type="text" name="username" value="" required>
                    </div>

                    <div class="col col-sm-6">
                        <b>Email</b>
                        <input type="email" name="email" required>
                    </div>

                    <div class="col col-sm-12">
                        <b>Home Page(url)</b>
                        <input type="url" name="homepage">
                    </div>

                    <div class="col col-sm-12">
                        <b>
                            Comment
                        </b>
                        <textarea name="text" required></textarea>
                    </div>

                    <div class="col col-sm-12">
                        <b>Tags</b>
                        <input type="text" name="tags" required>
                    </div>

                    <div class="col col-sm-12">
                        <div style="float: right">
                            <div id="GoogleK"></div>
                        </div>
                    </div>

                    <div class="col col-sm-4 col-sm-offset-8">
                        <a class="btn btn-primary btn-sm" id="AddCommentSend" style="width: 100%">
                            Send
                        </a>
                    </div>

                </form>
            </div>
        </div>

        <table class="table table-striped col col-sm-12 maintable" id="ForTest">
            <tr id="DataTable">
                <th>UserName</th>
                <th>Email</th>
                <th>Home Page</th>
                <th>Text</th>
                <th>Tags</th>
                <th>Date</th>
                <th>Ip</th>
                <th>Browser</th>
            </tr>
            {comments}
        </table>
        <div class="col col-sm-12">
            <div class="load" id="load">

            </div>
        </div>
    </div>
</div>