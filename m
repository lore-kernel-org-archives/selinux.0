Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA09181
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 02:33:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id GAA06204
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 06:31:23 GMT
Received: from mail.lemuria.org ([213.191.74.130])
	by jazzswing.ncsc.mil  with ESMTP id GAA06200
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 06:31:22 GMT
Received: from unicorn.lemuria.org (b067114.adsl.hansenet.de [62.109.67.114])
	by mail.lemuria.org (Postfix) with ESMTP id 6FF38BB8B
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 08:26:41 +0200 (CEST)
Date: Fri, 19 Apr 2002 08:30:28 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
Message-ID: <20020419083028.D11674@lemuria.org>
References: <20020418171532.B6551@lemuria.org> <20020418182807.E89D630028@lyta.coker.com.au> <20020418223959.B11358@lemuria.org> <20020418214702.BC6CE44E3E@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020418214702.BC6CE44E3E@lyta.coker.com.au>; from russell@coker.com.au on Thu, Apr 18, 2002 at 11:47:02PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 18, 2002 at 11:47:02PM +0200, Russell Coker wrote:
> > The point is that the reuse of children makes the "fork and change UID"
> > approach impractical. It works for SSH, but not for apache.
> 
> Sure it'll work for Apache!
> 
> On an active web server you don't have equal access to all domains, and each 
> domain will have it's own load spikes.  So if you have co-processes staying 
> around for 30 seconds after being used then you won't have too many running 
> at once.

Sorry, but this is very much impractical in any real-life situation. 
First of all, it would require that apache keep track of which process has 
dropped to what UID and hands off incoming requests according to that table, 
which needs to get updated at each fork and each SIGCHLD.
Two, it also requires that apache handles load independently for each
UID, instead of globally for the whole server, including spare servers
to start or kill, request-handling and forking of new processes. In
short, a total rewrite of a critical component.
Three, on any mass-hosting server, it will drive memory requirements
through the roof within minutes. My company has webservers with
thousands of users. If just 10% of them get accessed at any given time, 
something a few search engine crawls can easily accomplish, we'll have 
several hundred apache instances hanging around, and that is without 
taking into account spare servers.
Four, you would have to fork() much more often than right now. The sole
reason for apache's spare server concept is that forking is so
expensive, so apache tries to avoid it at all costs. Anything that
introduces a considerable increase in forks can not be a good thing.


Which is why I'm trying to do what I need to do without any forks and
without digging deep into apache's heart. Our discussion gave me an
idea or two that I'll be testing. Thanks for the input.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
