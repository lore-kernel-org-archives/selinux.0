Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA07738
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 16:42:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA06950
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 20:41:27 GMT
Received: from mail.lemuria.org ([213.191.74.130])
        by jazzband.ncsc.mil  with ESMTP id UAA06946 for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 20:41:27 GMT
Received: from unicorn.lemuria.org (b067114.adsl.hansenet.de [62.109.67.114])
	by mail.lemuria.org (Postfix) with ESMTP id 8B95FBB8B
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 22:36:13 +0200 (CEST)
Date: Thu, 18 Apr 2002 22:40:00 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
Message-ID: <20020418223959.B11358@lemuria.org>
References: <20020418171532.B6551@lemuria.org> <Pine.GSO.4.33.0204181124100.5560-100000@raven> <20020418182137.A7029@lemuria.org> <20020418182807.E89D630028@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020418182807.E89D630028@lyta.coker.com.au>; from russell@coker.com.au on Thu, Apr 18, 2002 at 08:28:07PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 18, 2002 at 08:28:07PM +0200, Russell Coker wrote:
> > Of course. The real-life problem is that I would prefer to reach this
> > goal without major changes to apache or the environment. The regular
> > workings of apache don't allow for anything like this, if for no other
> > reason then the fact that the children "hang around" after they have
> > one request done to handle the next ones. Anything else and you drown
> > in fork() overhead.
> 
> That's easy to solve.  Such children hang around for a certain amount of time 
> and then exit if they aren't being used.  Just like the model Apache uses for 
> it's own processes.

I know all this. I've been a sysadmin for apache servers for a couple
of years.

The point is that the reuse of children makes the "fork and change UID"
approach impractical. It works for SSH, but not for apache.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
