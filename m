Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i85DtBrT017609
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 09:55:12 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i85Dt7t0029979
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 13:55:11 GMT
Subject: Re: Additional rule files
From: Erich Schubert <erich@debian.org>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200409052031.05813.russell@coker.com.au>
References: <1094260356.29689.44.camel@wintermute.xmldesign.de>
	 <200409052031.05813.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 05 Sep 2004 15:54:58 +0200
Message-Id: <1094392498.22073.19.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> Why does fnord need a different policy?  Are the actions of different web 
> servers that different?  (this is a serious question not a rhetorical 
> question)

Well, apache contains a lot of stuff. Fnord and tcpserver are much
smaller applications that would allow a fine-grained definition of
rules. (one of the reasons i don't like apache that much is that it
contains a huge amount of stuff you usually do not use)

On the other side, fnord can for example run chrooted.

Here's a short overview of the typical fnord setup:

system init (minit / daemontools etc.) runs the tcp daemon and the
multilog daemon, and sets up the logging pipe from tcp daemon to the
logging daemon.

tcpsvd listens on the specified port and handles concurrency and reaping
of timeout children. it can (should) setuid/setgid after binding the
socket.

sslio can be used as client, providing ssl encryption. sslio can again
setuid/setgid/chroot and will then run the next client

fnord is a single-shot webserver, designed for chroot operation.
(using sendfile and such)

http authentication is done using another process.

Using all these different applications allows for much better privilege
separation. For example, the web server doesn't need to read the ssl
certs. Neither does it need write access to the log files, just to the
logging socket. Neither does it need auth capabilities.

> We can create some attributes to have multiple web servers work well with the 
> rest of the policy as I have already done with mail servers.  But first we 
> need a reason to do so.

I havn't looked at the apache policy enough yet. I'll do so.
We probably won't need such extra rules in each file by having a
cgi_domain macro or such. Differences for web server can probably be
handled in that macro.

Greetings,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
           There are only 10 types of people in the world:           //\
           Those who understand binary and those who don't           V_/_
   Die kürzeste Verbindung zwischen zwei Menschen ist ein Lächeln.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
