
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Aliens</title>
        <script src="js/jquery-2.2.3.min.js"></script>
        <link href="css/style.css" type="text/css" rel="stylesheet" />
        <script>
            $tblAliens = null;
            var intervalAllAliens = null;
            var alienList = [];
            //every time bullet moves, iterate thorugh array to see if it hit alien position
            //when hit, make null or check if already null
            
            $(document).ready(function(){
                $tblAliens= $('#tblAliens');
                drawAllAliens();
                intervalAllAliens = setInterval(moveAllAliens, 500);
                
                for(var i=0; i< alienList.length; i++){
                    //compare bullet with $alien.position
                }
            });
            
            function drawAllAliens(){
                for(var i=0; i < 3; i++){
                    $tr = $('<tr></tr>');
                    for(var k=0; k < 10; k++){
                        $td = $('<td></td>');
                        $alien = $('<img >');
                        $alien.attr('src', 'images/alien.jpg');
                        $alien.attr('class', 'alien');
                        alienList.push($alien);
                        $alien.attr('id', 'alien');
                        $td.append($alien);
                        $tr.append($td);
                    }
                    $tblAliens.append($tr);
                }
            }
            
            function moveAllAliens(){
                var pos = $tblAliens.position();
                var 
                if(){
                    
                }
                $tblAliens.css("left", (pos.left + 10) +"px");
            }
        </script>
    </head>
    <body>
        <table id="tblAliens">
            <tr></tr>
        </table>
    </body>
</html>
