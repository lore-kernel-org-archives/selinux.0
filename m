Message-ID: <7B2A7784F4B7F0409947481F3F3FEF8304ACC386@eammlnt051.lmc.ericsson.se>
From: "Eric Gingras (LMC)" <Eric.Gingras@ericsson.ca>
To: "SELinux Mailing list (E-mail)" <SELinux@tycho.nsa.gov>
Subject: Sockets permissions
Date: Tue, 15 Oct 2002 17:59:22 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I'm trying to configure a small and simple Client/Server application.
Basically, the server create a socket and print the messages he receive on
it. The client connect to the socket and send "Hello Server" in repetition.
The code of those two applications is at the end of this message.

I've created a new domain for each of them. Running them as
sysadm_u:sysadm_r in permissive mode they work fine. In enforcing mode, they
both start and execute, but the messages don't achieve destination.  If I
start them both and shift between permissive and enforcing, messages go
through when in permissive and don't when in enforcing...

I've give the following permissions to the Client:

	can_network(HTTPClient_t)
	allow HTTPClient_t HTTPServer_t:socket_class_set rw_socket_perms;

And the following permissions to the Server:

	can_network(HTTPServer_t)
	allow HTTPServer_t HTTPClient_t:socket_class_set
create_socket_perms;

where HTTPClient_t is the type of the client and HTTPServer_t is the type of
the server.


What am I missing ???

Thank you,

Eric Gingras



Server Code :

int main()
{
	int sock;
	int err;
	struct sockaddr_in ad;
	char buff[20];

	printf("Listen side\n");
	sock = socket(PF_INET, SOCK_DGRAM,0);
	printf("listen socket = %d\n",sock);

	memset(&ad,0,sizeof(ad));
	ad.sin_family = AF_INET;
	ad.sin_port = htons(50001);
	ad.sin_addr.s_addr = inet_addr("127.0.0.1");
	err = bind(sock,(struct sockaddr *)&ad,sizeof(ad));
	printf("bind = %d\n",err);

	while(1)
	{
		err = recv(sock,buff,12,MSG_WAITALL);
		if(err <= 0) break;
		buff[12] = 0;
		printf("%s\n",buff);
	}
	return 0;
}


Client Code :

int main()
{
	int sock;
	int connid;
	struct sockaddr_in ad;

	sock = socket(PF_INET, SOCK_DGRAM,0);

	printf("socket = %d\n",sock);
	memset(&ad,0,sizeof(ad));
	ad.sin_family = AF_INET;
	ad.sin_port = htons(50001);
	ad.sin_addr.s_addr = inet_addr("127.0.0.1");

	printf("addr = %x\n", ad.sin_addr.s_addr);
	connid = connect(sock,(struct sockaddr*)&ad,sizeof(ad));
	printf("connect = %d\n",connid);

	while(1)
	{
		send(sock,"Hello Server",12,0);
		sleep(1);
	}
	return 0;
}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
