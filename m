Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA21348
	for <selinux@tycho.nsa.gov>; Sun, 2 Dec 2001 10:54:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA04381
	for <selinux@tycho.nsa.gov>; Sun, 2 Dec 2001 15:54:13 GMT
Received: from jsmith.org (pool-141-158-40-161.phil.east.verizon.net [141.158.40.161])
	by jazzswing.ncsc.mil  with ESMTP id PAA04377
	for <selinux@tycho.nsa.gov>; Sun, 2 Dec 2001 15:54:12 GMT
Subject: X windows with i810 chip
From: Justin Smith <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 02 Dec 2001 10:51:35 -0500
Message-Id: <1007308295.1903.0.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

X windows presents special problems with this (unfortunately common)
graphics chip. Even with all of the standard allows declarations for X
windows (and a few extras), I get the following:



avc:  denied  { read } for  pid=1215 exe=/usr/X11R6/bin/XFree86
path=/dev/mem dev=03:01 ino=25224
   scontext=jsmith:user_r:user_t
   tcontext=system_u:object_r:memory_device_t
   tclass=chr_file

avc:  denied  { read write } for  pid=1215 exe=/usr/X11R6/bin/XFree86
path=/dev/mem dev=03:01 ino=25224
   scontext=jsmith:user_r:user_t
   tcontext=system_u:object_r:memory_device_t
   tclass=chr_file
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 261M
agpgart: Detected an Intel i810 E Chipset.
agpgart: detected 4MB dedicated video ram.
agpgart: AGP aperture is 64M @ 0xf8000000

avc:  denied  { read write } for  pid=1215 exe=/usr/X11R6/bin/XFree86
path=/dev/mem dev=03:01 ino=25224
   scontext=jsmith:user_r:user_t
   tcontext=system_u:object_r:memory_device_t
   tclass=chr_file



I have been unable to enable this access (perhaps there's a 'neverallow'
coded for it). Any suggestions would be appreciated! (I really need  X
windows --- to the extent that I would have to discontinue using SELinux
if it prohibits it). 

Is there a way to allow memory access for a RESTRICTED range of
addresses (if so, a hacker would at most be able to display pictures on
the screen)?  (Maybe this would require assigning types to PARTS of a
device, ranges of bytes).
-- 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
