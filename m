Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1O12LRb020672
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 20:02:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1O10klK026084
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 01:00:46 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i1O10jOX026014
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 01:00:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: roman.zillek@chello.at
Subject: Re: identity
Date: Tue, 24 Feb 2004 12:00:54 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20040223140412.BBXY2010.viefep15-int.chello.at@localhost>
In-Reply-To: <20040223140412.BBXY2010.viefep15-int.chello.at@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402241200.54504.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Feb 2004 01:04, <roman.zillek@chello.at> wrote:
> forgive me if this is complete nonsense in this context, but wouldn't it be
> possible to discriminate by means of I/O-descriptors for if you run
> interactive or interpretative ?

How do you differentiate a process running under script(1) from a process 
running from ssh?

Pseudo-ttys are used for too many things, you can't easily determine what use 
is being made of it unless you do something really ugly with looking at who 
has the master open (I doubt that we want to go there).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
