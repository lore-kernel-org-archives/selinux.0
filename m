Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB2IZgIi003577
	for <selinux@tycho.nsa.gov>; Thu, 2 Dec 2004 13:35:43 -0500 (EST)
Message-ID: <41AF6072.8000102@redhat.com>
Date: Thu, 02 Dec 2004 13:35:30 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Reissue previous patch
References: <41741A2C.8040408@redhat.com>	 <200410260138.19426.russell@coker.com.au>	 <20041025213122.GA2535@jmh.mhn.de>	 <200410270036.14935.russell@coker.com.au>	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>	 <4192A029.5050909@redhat.com>	 <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>	 <419CB2A8.7020504@redhat.com>	 <1101235934.7273.24.camel@moss-lions.epoch.ncsc.mil>	 <41A4B54F.3070709@redhat.com>	 <1101325733.12859.37.camel@moss-lions.epoch.ncsc.mil>	 <41ACE3E6.5030801@redhat.com>	 <1101995669.8032.20.camel@moss-lions.epoch.ncsc.mil>	 <41AF23B0.4020100@redhat.com> <1102002706.26015.117.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1102002706.26015.117.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2004-12-02 at 09:16, Daniel J Walsh wrote:
>  
>
>>I think this is caused by the resolver.  This is why I would like to get 
>>to the point of using
>>can_resolve() where we specify the exact port that you can connect to.
>>    
>>
>
>Aren't the udp_socket send_msg/recv_msg permissions sufficient for this
>purpose (check is between the socket context and the remote port
>context), i.e. you can say that it can only send_msg/recv_msg to
>dns_port_t:udp_socket?
>
>Likewise, in what cases is it not sufficient to use the tcp_socket
>send_msg/recv_msg permissions (i.e. when do you truly need the separate
>name_connect permission check that you proposed earlier)?
>
>  
>
I think you get into a problem where you are required to act as both a 
server and a client.  You end up with
a server rule saying that you can only receive packets from port 123, 
when you want to recieve from anywhere
but only send to 123, or you end up with the ability to send/receive 
anywhere and this overrides the ability to only connect to 123.
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
