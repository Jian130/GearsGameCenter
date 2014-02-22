
//client network layer

//can send data in binary
	//json object

	var gameStateObject;
	var recievedObject;
	var wsPort;

	//init connection
	var connection;
	//sendOut(gameStateObject);
	//to close connection connection.close();
	window.onload = function() {
		console.log("loading!");
		//window.alert("loading!");
		//check preconditions for web socket support
		if (window.MozWebSocket)
	    {
	        console.log('using MozillaWebSocket');
	        window.WebSocket = window.MozWebSocket;
	    }
	    else if (!window.WebSocket)
	    {
	        console.log('browser does not support websockets!');
	        return;
	    }
		gameStateObject = {message1: "test", message2:"test2"};
		wsPort = (window.location.port.toString() === "" ? "" : ":"+window.location.port);
		/*if (wsUri.value === "") {
        	wsUri.value = "ws://" + window.location.hostname.replace("www", "echo") + wsPort;
    	}*/
		connection = new WebSocket('ws://echo.websocket.org');//,soap, xmpp);
		connection.onopen = function(event) { onConnection() };
		connection.onerror = function(errror) { connectionError(error) };
		connection.onmessage = function(object) { recieveObject(object)};
		connection.onclose = function(event) { onCloseEvent() };

		//sendOut(gameStateObject);		
	}

	//connection error handling
	function connectionError(error) {
		console.log("connection error: " + error);
		alert(error);
		document.getElementById("#yolo").innerHTML = error;
	}
	//initial connection sequence
	function onConnection() {
		console.log("connected");
		sendOut(gameStateObject);
	}
	function onCloseEvent() {
		console.log("closing");
	}
	function recieveObject(input) {
		//convert JSON
		console.log(input);
		recievedObject = JSON.parse(input.data);
		console.log(recievedObject);
		//other data handling here
	}
	function sendOut(object) {
		if(connection.readyState == 1)
		{
			connection.send(JSON.stringify(object));
		} else {
			console.log("connection not ready!");
		}
	}

	//window.addEventListener("load", echoHandlePageLoad, false);
