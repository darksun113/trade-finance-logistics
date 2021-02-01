      $(document).ready(function() {
            var apitoken = $.cookie('apitoken');
            if(apitoken == null) {
                console.log("Not logged in yet.");
            } else {
                console.log("Login Successful");
            }

            $("#select").click(function() {
                $("#dropdown").toggle();
            });

            $("#dropdown ul li").click(function(evt) {
                evt.preventDefault();
                var li = evt.currentTarget;
                $("#select").val(li.firstChild.innerText);
                $("#orgname").val(li.firstChild.title);
                $("#dropdown").hide();
            });

            $("#dismissalert").click(function() {
               $("#alertbox").hide();
            });


            $("#submit").click(function() {
                    $.ajax({
                        type: "post",
                        url: "/login",
                        beforeSend: function() {console.log("Loging in...");},
                        timeout: 10000,
                        error: function(xhr, status, error) {
                            alert("Error: " + xhr.status + " - " + error);
                        },
                        contentType: "application/x-www-form-urlencoded",
                        dataType: "json",
                        data: {
                            username: $("#username").val(),
                            orgName: $("#orgname").val(),
                            password: $("#password").val()
                        },
                        success: function(data) {
                            if(data.success == true) {
                               console.log(data.message);
                               $.cookie('apitoken',data.token);
                               if(data.secret!=null) {
                                   $("#returnpass").text(data.secret);
                               }
                               $("#alertbox").show();
                            } else {
                                console.log("Failed to log in.");
                            }
                        }
                    });
            });


        });
