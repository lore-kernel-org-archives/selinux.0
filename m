Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA22004
	for <selinux@tycho.nsa.gov>; Sun, 2 Dec 2001 17:21:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA15821
	for <selinux@tycho.nsa.gov>; Sun, 2 Dec 2001 22:21:52 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA15817
	for <selinux@tycho.nsa.gov>; Sun, 2 Dec 2001 22:21:50 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Justin Smith <jsmith@mcs.drexel.edu>, selinux@tycho.nsa.gov
Subject: Re: X windows with i810 chip
Date: Sun, 2 Dec 2001 23:21:31 +0100
References: <1007308295.1903.0.camel@jsmith.org>
In-Reply-To: <1007308295.1903.0.camel@jsmith.org>
MIME-Version: 1.0
Message-Id: <20011202222132.14963353193@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2 Dec 2001 16:51, Justin Smith wrote:
> avc:  denied  { read write } for  pid=1215 exe=/usr/X11R6/bin/XFree86
> path=/dev/mem dev=03:01 ino=25224
>    scontext=jsmith:user_r:user_t
>    tcontext=system_u:object_r:memory_device_t
>    tclass=chr_file
>
>
>
> I have been unable to enable this access (perhaps there's a 'neverallow'
> coded for it). Any suggestions would be appreciated! (I really need  X
> windows --- to the extent that I would have to discontinue using SELinux
> if it prohibits it).
>
> Is there a way to allow memory access for a RESTRICTED range of
> addresses (if so, a hacker would at most be able to display pictures on
> the screen)?  (Maybe this would require assigning types to PARTS of a
> device, ranges of bytes).

The idea of changing ACLs whenever a hardware device changes it's settings 
(can potentially change at reboot, in future with hot-swap PCI it could 
change at run time) is unappealing.

Why not use VESA frame buffer and then run the FBDEV X server?  Setting the 
ACL to allow read/write access to /dev/fb/* is pretty safe.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
