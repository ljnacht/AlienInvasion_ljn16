<%-- 
    Document   : game
    Created on : Mar 22, 2016, 8:01:36 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alien Invasion</title>
        <script src="js/jquery-2.2.3.min.js"></script>
        <link href="css/style.css" type="text/css" rel="stylesheet" />
        
        <script>
            var windowWidth =0;
            var windowHeight =0;
            var direction = 1;
            $ship = null;
            $tblAliens = null;
            var intervalAllAliens = null;
            var alienList = [];
            var BULLET_WIDTH = 23; 
            var BULLET_HEIGHT = 33;
            var curBulletID = 1;
            var curAlienID = 0;
            var firedBullets = []; // initialize empty array that will hold bullet objects
            //every time bullet moves, iterate thorugh array to see if it hit alien position
            //when hit, make null or check if already null
            var alienArray = [];
            var aliensPos;
    
            $(document).ready(function(event){
                $tblAliens= $('#tblAliens');
                drawAllAliens();
                intervalAllAliens = setInterval(moveAllAliens, 100);
                
                windowWidth = $(document).width();
                windowHeight = $(document).height();
                $ship = $('#ship');
                $ship.css('top', (windowHeight - $ship.height() - 30) + "px");
                $ship.css('left', (windowWidth / 2 - $ship.width() / 2) + "px");
                $(document).keydown(function(e){
                    moveShip(e);
                    e.preventDefault();
                });
                
            });
            
            function saveScore(point){
                var url = "ws/ws_alienwrite?x="+pos.left+"&y="+pos.top;
                  
                $.post(url, function(data){
                    //console.log(data);
                });
            }
            
            function moveShip(e){
                $shipLimits = $(window).width() - 60;
                 switch(e.which){
                        case 32: //fire bullet
                            createBullet();
                        break;
                     
                        case 37: //left
                            var pos = $ship.position();
                            if(pos.left > $shipLimits*-1){
                                pos.left -= 10;
                                $ship.css('left', pos.left + 'px');
                                saveShipPosition($ship.position());
                            }
                        break;
                        
                        case 39: // right
                            var pos = $ship.position();
                            //console.log(pos);
                            if(pos.left < $shipLimits){
                                pos.left += 10;
                                $ship.css('left', pos.left + 'px');
                                saveShipPosition($ship.position());
                            }
                        break;
                        
                        default: return; //exit for other keys
            }
        }
        
            function createBullet(){
                // Create image object
                $bulletObj = $('<img>');
                
                // Set attributes for the image object
                $bulletObj.attr({
                    "id" : "bullet_" + curBulletID,
                    "src" : "images/bullet.png"
                });
                
                var initBulletX = $ship.position().left + $ship.width() / 2 - BULLET_WIDTH / 2;
                var initBulletY = $ship.position().top - BULLET_HEIGHT;
                // Set CSS position for the image object
                $bulletObj.css({
                    "position" : "absolute",
                    "width" : BULLET_WIDTH + "px",
                    "height" : BULLET_HEIGHT + "px",
                    "top" : initBulletY + "px",
                    "left" : initBulletX + "px"
                });
                
                $('body').append($bulletObj);
                /*
                 * Create bullet object as a JSON object.  Look carefully at the properties.
                 * intervalID property will store timer interval ID
                 * bulletObj property stores the actual jQuery image object representing
                 * an individual bullet
                 */
                var bullet = {
                    "bulletID" : curBulletID,
                    "intervalID" : 0,
                    "bulletObj" : $bulletObj
                }
                
                // Increment global variable
                curBulletID++;
                
                // Save bullet into a global array
                firedBullets.push(bullet);
                
                /*
                 * This is a major difference from what we did in class.
                 * Note that setInterval can take more than two arguments
                 * Each argument after the time interval is an argument that gets
                 * passed to the moveBullet function.  
                 * See documentation: 
                 * https://developer.mozilla.org/en-US/docs/Web/API/WindowTimers/setInterval
                 */
                bullet.intervalID = setInterval(moveBullet, 100, bullet);
            }
            //end createBullet()
            
            function moveBullet(bullet){
                // Get the jQuery bullet object from the DOM
                $firedBullet = $('#bullet_' + bullet.bulletID);
                
                // Get current Y position
                var posY = $firedBullet.position().top;
                var posX = $firedBullet.position().left;
                
                
                // Get new position - move by 10 pixels up along Y-axis
                var newPosY = posY - 10;
                
                var aliensBottom = aliensPos.top + 112;
                var aliensRight = aliensPos.left + 400;
                
                //bullet is within alien section
                if(newPosY > aliensPos.top && newPosY < aliensBottom && posX > aliensPos.left && posX < aliensRight){
                    clearInterval(bullet.intervalID);
                    $firedBullet.remove(); 
                    firedBullets.shift();
                    $tblAliens.css('display','none');
                    saveScore(1);
                    endGame(true);
                }
                // Once the bullet is 5px away from the top, remove it
                else if(newPosY > 5){
                    $firedBullet.css("top", newPosY + "px");
                }
                else{
                    /* 
                     * Clear interval - it's easy because the interval is 
                     * now a property of the bullet JSON object
                     */
                    clearInterval(bullet.intervalID);
                    $firedBullet.remove(); // Remove bullet from the DOM
                    firedBullets.shift(); // Remove first element of the bullets array
                    saveScore(-1);
                    
                }
                
            }
            //end moveBullet
            
            
        
        // ******************************** ALIEN STUFF ********************************
            function drawAllAliens(){
                for(var i=0; i < 3; i++){
                    $tr = $('<tr></tr>');
                    for(var k=0; k < 10; k++){
                        $td = $('<td></td>');
                        $alien = $('<img >');
                        $alien.attr('src', 'images/alien.jpg');
                        $alien.attr('class', 'alien');
                        $alien.attr('id', 'alien_'+curAlienID);
                        $td.append($alien);
                        $tr.append($td);
                        
                        var alienObj ={
                            "id" : 'alien_'+curAlienID,
                            "hit" : false
                        }
                        
                        alienArray.push(alienObj);
                        curAlienID++;
                    }
                    $tblAliens.append($tr);
                }
            }
            
            function moveAllAliens(){
                aliensPos = $tblAliens.position();
                var pos = $tblAliens.position();
                $aliensLimits = windowWidth - $('#tblAliens').width();
                $shipPos = $ship.position();
                
                //aliens reached the ship
                if($shipPos.top < aliensPos.top + 112){
                    endGame(false);
                }
                //going right
                else if(direction == 1){
                    if(pos.left < $aliensLimits){ //keep going right
                        $tblAliens.css("left", (pos.left + 10) +"px");
                    }else{ //at the end
                        direction = 0;
                        $tblAliens.css("top", (pos.top + 10) +"px");
                    }
                }
                //going left
                else{
                    if(pos.left > 0){ //keep going left
                        $tblAliens.css("left", (pos.left - 10) +"px");
                    }else{ //at the end
                        direction = 1;
                        $tblAliens.css("top", (pos.top + 10) +"px");
                    }
                }
                
                
            }
            
         /******************* GAME END STUFF ****************/
         function endGame(ifWon){
             $.get('js/webservice.json', function(data){
                 
             });
            //if game is won 
            if(ifWon){
                 
            }//if game is lost
            else{
                
            }
         }
        </script>
    </head>
    <body>
        <div id="gameboard">
            <table id="tblAliens"></table>
            <img src="images/ship.png" id="ship" />
        </div>
        
    </body>
</html>
