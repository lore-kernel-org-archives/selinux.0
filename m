Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA01337
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 08:37:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA07889
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 12:37:07 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA07881
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 12:37:02 GMT
Date: Tue, 28 May 2002 08:36:51 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: can_tcp_connect_to() macro
In-Reply-To: <20020526095926.5C1852657@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205280835200.1315-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 26 May 2002, Russell Coker wrote:

> What do you think about the following?
>
> #################################
> #
> # can_tcp_connect_to(client, server)
> #
> # Permissions for establishing a TCP connection TO a domain.
> #
> define(`can_tcp_connect_to',`
> allow $1 $2:tcp_socket connectto;
> allow $2 $1:tcp_socket recvfrom;
> ')

I don't understand the purpose of this macro.  It is insufficient to
authorize a TCP connection, and can_tcp_connect is already defined to
authorize a (one-way) connection between a client and a server.  The
connectto/acceptfrom permissions handle the unidirectional nature of the
connection.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
