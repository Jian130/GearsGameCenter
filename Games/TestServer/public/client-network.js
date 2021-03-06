
//client network layer

//can send data in binary
	//init objects
	var gameStateObject;  //json object to tx
	var recievedObject;	  // recieved json object
	var wsPort;

	var ID;
	var mazeID;
	var connection;
	//to close connection connection.close();
	window.onload = function() {
		console.log("loading!");
		//check preconditions for web socket support
		if (window.MozWebSocket)
	    {
	        console.log('using MozillaWebSocket');
	        window.WebSocket = window.MozWebSocket;
	    }
	    else if (!window.WebSocket)
	    {
	        console.log('browser does not support websockets!');
	        alert('browser does not support websockets!');
	        return;
	    }
		gameStateObject = {message1: "test", message2:"test2"};
		wsPort = "8001";
		connection = new WebSocket('ws://bottlezz2002.info:8001');

		connection.onopen = function(event) { onConnection() };
		connection.onerror = function(error) { connectionError(error) };
		connection.onmessage = function(object) { recieveObject(object) };
		connection.onclose = function(event) { onCloseEvent() };
	}

	//connection error handling
	function connectionError(error) {
		console.log("connection error: " + error);
		alert(error);
		document.getElementById('test').innerHTML = error;
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
		try {
			recievedObject = JSON.parse(input.data);
			//it is a initiali ID packet
			if(recievedObject.user_id != null)
			{
				ID = recievedObject.user_id;
				mazeID = recievedObject.maze_id;
				return;
			}
		} catch(error) {
			console.log('message is not a JSON object');
			receivedObject = input;
		}
		//recievedObject = JSON.parse(input.data);
		//document.getElementById('test').innerHTML = recievedObject;
		console.log(recievedObject);
		//other data handling here
//dsfsdf
		recievedCallBack(recievedObject);
	}
	function sendOut(object) {
		if(connection.readyState == 1)
		{
			connection.send(JSON.stringify(object));
		} else {
			console.log("connection not ready!");
		}
		console.log("SENT");
	}
	function getSessionID() {
		return ID;
	}
	function getMazeID() {
		return mazeID;
	}

