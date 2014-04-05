
//client network layer

//can send data in binary
	//init objects
function GameCenter(){


	var gameStateObject;  //json object to tx
	var recievedObject;	  // recieved json object
	var wsPort = "8001";

	var SessionID;
	//var mazeID;
	var connection;


	//to close connection connection.close();
	this.initial = function() {
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
		//gameStateObject = {message1: "test", message2:"test2"};
		
		var matches = document.URL.match(/http:\/\/([\d.]+)\/.*/);
        //var ip = matches[1];
        var ip="127.0.0.1";
        console.log("IP: " + ip);
        
		connection = new WebSocket("ws://" + ip + ":" + wsPort);

		connection.onopen = function(event) { onConnection() };
		connection.onerror = function(error) { connectionError(error) };
		connection.onmessage = function(object) { recieveObject(object) };
		connection.onclose = function(event) { onCloseEvent() };
	};

	this.broadcasting = function (object){
		sendOut({type:"broadcast",value:object});
	}

	this.setUser= function (object){
		sendOut({type:"setUser",value:object});
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
		//sendOut(gameStateObject);
	}

	function onCloseEvent() {
		console.log("closing");
	}

	function recieveObject(input) {
		//convert JSON

		try {
			recievedObject = JSON.parse(input.data);
			//it is a initiali ID packet
			/*
			if(recievedObject.user_id != null)
			{
				ID = recievedObject.user_id;
				mazeID = recievedObject.maze_id;
				return;
			}*/
		} catch(error) {
			console.log('message is not a JSON object');
			receivedObject = input;
		}

		console.log(recievedObject);
		//other data handling here

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

	this.initial();
}
