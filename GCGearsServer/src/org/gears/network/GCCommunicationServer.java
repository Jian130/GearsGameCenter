package org.gears.network;

import java.net.InetSocketAddress;
import java.net.UnknownHostException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;

import org.gears.DataObject;
import org.gears.GCUser;
import org.gears.GCUserList;
import org.java_websocket.WebSocket;
import org.java_websocket.handshake.ClientHandshake;
import org.java_websocket.server.WebSocketServer;

public class GCCommunicationServer extends WebSocketServer {

	private HashMap<WebSocket, GCUser> userList;
	
	public GCCommunicationServer( int port ) throws UnknownHostException {
		super( new InetSocketAddress( port ) );
		this.initialize();
	}

	public GCCommunicationServer( InetSocketAddress address ) {
		super( address );
		this.initialize();
	}
	
	private void initialize()
	{
		this.userList = new HashMap<WebSocket, GCUser>();
	}
	
	@Override
	public void onClose(WebSocket arg0, int arg1, String arg2, boolean arg3)
	{

	}

	@Override
	public void onError(WebSocket arg0, Exception arg1)
	{

	}

	@Override
	public void onMessage(WebSocket sourceSocket, String data)
	{
		DataObject obj = new DataObject();
		obj.parseJson(data);
		
		if (obj.getAction().equals("broadcasting"))
		{
			this.broadcast(sourceSocket, data);
		}
		else if (obj.getAction().equals("set_user") || obj.getAction().equals("add_user"))
		{
			this.addUser(sourceSocket, data);
		}
		else if (obj.getAction().equals("set_user_property"))
		{
			
		}
	}

	@Override
	public void onOpen(WebSocket arg0, ClientHandshake arg1)
	{
		
	}
	
	private void broadcast(WebSocket sourceSocket, String data)
	{
		Collection<WebSocket> sockets = this.connections();
		for (Iterator<WebSocket> iterator = sockets.iterator(); iterator.hasNext();) 
		{
			WebSocket socket = iterator.next();
			if (socket != sourceSocket)
			{
				socket.send(data);
			}
		}
	}
	
	private void broadcastUserList()
	{
		GCUserList list = new GCUserList();
		list.setUserList(this.userList.values());
		
		Collection<WebSocket> sockets = this.connections();
		for (Iterator<WebSocket> iterator = sockets.iterator(); iterator.hasNext();) 
		{
			WebSocket socket = iterator.next();
			socket.send(list.getJson());
		}
	}
	
	private void addUser(WebSocket sourceSocket, String data)
	{
		if (!this.userList.containsKey(sourceSocket))
		{
			GCUser newUser = new GCUser();
			this.userList.put(sourceSocket, newUser);
		}
		
		GCUser user = this.userList.get(sourceSocket);
		user.parseJson(data);
		this.updateHost();
		this.broadcastUserList();
	}
	
	private void updateHost()
	{
		boolean curr = true;
		Iterator<GCUser> iterator = this.userList.values().iterator();
		while (iterator.hasNext())
		{
			GCUser user = iterator.next();
			if (curr)
			{
				user.setIsHost("1");
				curr = false;
			}
			else
			{
				user.setIsHost("0");
			}
		}
	}

}
