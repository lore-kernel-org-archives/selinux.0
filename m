Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA01609
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 07:00:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA21096
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 11:00:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA21092
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 11:00:29 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: can_tcp_connect_to() macro
Date: Sun, 26 May 2002 13:00:16 +0200
References: <20020526095926.5C1852657@lyta.coker.com.au> <20020526123632.A28379@lemuria.org>
In-Reply-To: <20020526123632.A28379@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020526110018.6E82D3BCD@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 26 May 2002 12:36, Tom wrote:
> On Sun, May 26, 2002 at 11:59:25AM +0200, Russell Coker wrote:
> > What do you think about the following?
>
> yes, please! also, a restriction on target ports may be very, very
> useful (e.g. "this user can surf the web or use telnet, but can't
> telnet to arbitrary ports")

The only thing my suggested new macro offers over the current 
can_tcp_connect() macro is that the connections are uni-directional.

For example I want to allow all users to connect to Squid, but I don't want 
to allow Squid to connect to them!

So you can currently limit what ports your user connects to, as long as you 
are happy for the owners of those domains to connect to your user.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
