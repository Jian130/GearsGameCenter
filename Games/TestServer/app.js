/*
// web server
var connect = require('connect');
connect.createServer(
    connect.static('public')
).listen(3000);
*/

// communication server
// Scream server example: "hi" -> "HI!!!"
var WebSocketServer = require('ws').Server
  , wss = new WebSocketServer({port: 8001});
wss.broadcast = function(data,cws) {
    for(var i in this.clients){
    	//if(this.clients[i]!=cws)
    		this.clients[i].send(data);
    }
        
};
var wsclients=[];
var clientids=[0];
var mazeID=10;
function getuserid(wsc){
	for(var i in wsclients){
		if(wsclients[i].ws==wsc){
			var myid=wsclients[i].id;
			wsclients.splice(i,1);

			return myid;
		}
	}
}
wss.on('connection', function(ws) {
	
	
	var id=clientids[clientids.length-1]+1;
	var pair={ws:ws,id:id}
	wsclients.push(pair);
	clientids.push(id);
	var newuser={user_id:id,mazeID:mazeID}
	ws.send(JSON.stringify(newuser));
    console.log('connected');
    function getWsClientIndex(cid){
    	for(var index in wsclients){
    		var wc = wsclients[index];
    		if(wc.id==cid)
                return index;

    	}
    }


	ws.on('close', function() {
	    console.log('disconnected');
	    var msg={type:'disconnected',userid:getuserid(ws)};
        var cid=getuserid(cid);
	    mywc=getWsClientIndex(cid);
	    wsclients.splice(mywc,1);

	    wss.broadcast(JSON.stringify(msg));
	});
    ws.on('message', function(message) {
        console.log('received: %s', message);
        //
        message=JSON.parse(message);
        console.log(message.type);
        if(message.type=="broadcast"){
            wss.broadcast(JSON.stringify(message.value));
        	
            console.log(message.value);
        } 	
       	else if(message.type=="setUser"){
       		wss.broadcast(JSON.stringify({Total:wsclients.length}));
       	}
        
    });

    //ws.send('something');
});
