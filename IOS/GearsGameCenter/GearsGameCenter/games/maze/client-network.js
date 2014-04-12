
//client network layer

//can send data in binary
	//init objects
	// var recievedObject;	  // recieved json object
	var wsPort;

	var ID;
	//var mazeID;
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

		wsPort = "8081";
		var matches = document.URL.match(/http:\/\/([\d.]+)\/.*/);
        var ip = matches[1];
        
        console.log("IP: " + ip);
        
		connection = new WebSocket("ws://" + ip + ":" + wsPort);

		connection.onopen = function(event) { onConnection() };
		connection.onerror = function(error) { connectionError(error) };
		connection.onmessage = function(message) { receiveMessage(message) };
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
		// sendOut(gameStateObject);
	}

	function onCloseEvent() {
		console.log("closing");
	}

	function receiveMessage(message) {
		//convert JSON
		console.log(message);

		try {
			var receivedMessage = JSON.parse(message.data);
			

			if(receivedMessage.user_id != null)
			{
				ID = receivedObject.user_id;
				
				return;
			} else if (receivedMessage.action = "broadcasting") {
				recievedCallBack(receivedMessage.body);
				console.log(receivedMessage.body);
				console.log(receivedMessage.body.test);
			} else if (receivedMessage.action = "get_shared_memory") {
				receivedSharedMemory(receivedMessage.name, receivedMessage.body);
			} else if (receivedMessage.action = "user_list"){
				receivedUserlist(receiveMessage.body);
			}else {

				console.log("undefined action: " + receivedMessage.action);
			}

			console.log("Recevied Message " + receivedMessage);

		} catch(error) {
			console.log('message is not a JSON object');
		}
	}
	

	function getSessionID() {
		return ID;
	}

	function sendMessage(action, name, body) {
		var timestamp = new Date();

		var message = {
			"action": action,
			"timestamp": timestamp,
			"userID": null,
			"name": name,
			"body": body 
		}

		if(connection.readyState == 1)
		{
			connection.send(JSON.stringify(message));
		} else {
			console.log("connection not ready!");
		}
		console.log("SENT");
	}

	function broadcasting(body) {
		sendMessage("broadcasting", "message", body);
	}

	function setSharedMemory(name, body) {
		sendMessage("set_shared_memory", name, body);
	}

	function getSharedMemory(name) {
		sendMessage("get_shared_memory", name, null);
	}

	function setUser(name, property) {
		sendMessage("set_user", name, property);
	}

	function getUserList() {
		sendMessage("get_user_list", null, null);
	}
