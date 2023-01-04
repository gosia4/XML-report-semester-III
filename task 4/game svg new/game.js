(function(){
    /* constants */                                           //<1>
    var width = 400,  //viewBox width in px
        height = 300, //viewBox height in px
        nShapes = 80,  //number of confetti pieces to draw
        //timeLimit = 15,    //total time in seconds
        gameboard = document.getElementById("gameboard"), //the SVG
        timer = document.getElementById("timer"), //for time remaining
        scoreboard = document.getElementById("scoreboard"), //counter
        misses = document.getElementById("misses"), //<g> for misses, we adding missing diamonds
        svgNS = gameboard.namespaceURI;
    
    var score = 0; //number of pieces collected so far
    
    while(true){
        var difficultyLevel = prompt("Choose the difficulty. Type 'easy' or 'hard' to begin: ")
        switch (difficultyLevel) {
            case 'easy':
                entryError = false
                timeLimit = 15
                break
            case 'hard':
                entryError = false
                timeLimit = 8
                break
        }
        if(entryError) alert("There is no difficulty lavel with this name. Please choose again.")
        else break
    }


    /* initialize */
    gameboard.setAttribute("viewBox", [0,0,width,height]);
    for (var i=0; i<nShapes; i++) {
        var use = document.createElementNS(svgNS, "use");//namespace svg; use-copy of elements,
        use.setAttribute("class", "clickable");
        use.setAttributeNS("http://www.w3.org/1999/xlink", 
                           "href", "#gem");//namespace, reference to the diamonds in svg
        use.setAttribute("fill", randomColor() );
        use.setAttribute("x", Math.random()*width);
        use.setAttribute("y", Math.random()*height);
        gameboard.appendChild(use);
    }
    var endTime = Date.now() + timeLimit*1000;
    updateTime();                                      //<5>
    var timerInterval = setInterval(updateTime, 100);//time updating every 100 mili seconds
    updateScore();
    gameboard.addEventListener("mouseup", checkClick);   //<7>, klikanie myszką diamencików, (listening for click events)
    
    function randomColor() {
        /* returns a random color with at least 70% saturation
           and 40-80% lightness (for drawing on dark background) */
        var hue = Math.random()*360,
            sat = 70 + Math.random()*30,                       //<8>
            light = 40 + Math.random()*30;//ładniejsza barwa kolorów
        return "hsl(" + hue+"," + sat+"%," + light+"% )";//Hue-saturation-lightness model, cylindrical-coordinate representation of colors
    }
    var last5seconds = false;
    function updateTime() {
        var timeLeft = endTime - Date.now();
        if (timeLeft <= 0) {
            endGame();                                         //<9>
            timeLeft = 0;
            timer.removeAttribute("aria-live");//koniec migania czasu
        }
        if ((!last5seconds)&&(timeLeft <= 5000)) { 
            //less than 5 seconds left, miganie
            timer.setAttribute("aria-live", "polite");
            //document.getElementById('aria-live').getAnimations() 
            last5seconds = true;
        }
        timer.textContent = (timeLeft/1000).toFixed(1);
    }
    function updateScore() {
        scoreboard.textContent = score.toFixed(0);
    }
    function endGame() {
        clearInterval(timerInterval);
        gameboard.removeEventListener("mouseup", checkClick);    //<9>
        document.documentElement.setAttribute("class", "game-over");
    }

   

//We check if the element we clicked was the diomand or just gameboard (in this case we make a circle)
    function checkClick(event) {//check what was clicked, 
        var element = event.target;// || event.target.correspondingUseElement; node gdzie dodałam listenera, odwołuje się do use element
        if (element.getAttribute("class")=="clickable") {
            element.setAttribute("class", "clicked");
            score++;
            updateScore();
        }
        else {
            // create a point for the click location
            var clickPoint = gameboard.createSVGPoint();
            clickPoint.x = event.clientX;
            clickPoint.y = event.clientY;
            
            /* convert it to the coordinate system
               of the `misses` group element */
            var missPoint = clickPoint.matrixTransform(
                misses.getScreenCTM().inverse() );
            
            /* add a circle element centered at that point */
            var circle = document.createElementNS(svgNS, "circle");
            circle.setAttribute("class", "miss");
            circle.setAttribute("r", 4);
            circle.setAttribute("cx", missPoint.x);
            circle.setAttribute("cy", missPoint.y);
            misses.appendChild(circle);
        }
    }
    })();