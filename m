Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3P3MAI4012312
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 23:22:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3P3LiVf011315
	for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2003 03:21:44 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h3P3LQ4D011281
	for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2003 03:21:42 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Robert Bihlmeyer <robbe@orcus.priv.at>, selinux@tycho.nsa.gov
Subject: Re: broad domains
Date: Fri, 25 Apr 2003 13:21:07 +1000
References: <87n0ilej7x.fsf@orcus.priv.at>
In-Reply-To: <87n0ilej7x.fsf@orcus.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304251321.07207.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 20 Apr 2003 17:11, Robert Bihlmeyer wrote:
> I started work on a generic X client domain, but now I get the feeling
> that this may not be the right way to go. As I have to add this
> permission for this client, and that permission for that program, the
> domain gets quite broad. Maybe these generic domains are a mistake?

Which generic domains are you referring to?

Why do you want to add a special domain for X clients?

For good X security we need something like Cluster Mode Workstation 
http://www.ornl.gov/~jar/cmw4me.pdf .  Many people have been talking about 
writing an X proxy or modifying the X server and/or window manager for such 
things.  But nothing has been done yet.

> A have the same problem with the games domain provided in the default
> policy (or at least in Russell's package). As is, it doesn't fit half
> the stuff in my /usr/games.

How does it not fit them?

> On the other hand, having a domain for every teensy toy out there
> seems a bit excessive.

Yes, it becomes a management nightmare which isn't good for security.

> BTW, can't setfiles assume some default user & role if none is given?
> Repeating system_u:object_r: a million times is superflous.

I did that once and Steve convinced me to stop doing it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
