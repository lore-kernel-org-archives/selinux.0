Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3DNPwI4018071
	for <selinux@tycho.nsa.gov>; Sun, 13 Apr 2003 19:26:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3DAKvq0018547
	for <selinux@tycho.nsa.gov>; Sun, 13 Apr 2003 10:20:57 GMT
Received: from lyta.coker.com.au (c16702.sunsh1.vic.optusnet.com.au [210.49.228.68])
        by jazzband.ncsc.mil  with ESMTP id h3DAKkMi018532 for <selinux@tycho.nsa.gov>; Sun, 13 Apr 2003 10:20:57 GMT
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id B04EB620
	for <selinux@tycho.nsa.gov>; Sun, 13 Apr 2003 20:20:48 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: important patch for init.te
Date: Sun, 13 Apr 2003 18:14:59 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200304131815.00210.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems that /sbin/init really wants to talk to itself via fifo's.  If it 
can't do so then something that a libc6 package upgrade on Debian does will 
trigger init into going into boot mode (after which it doesn't reap zombies 
and generally your system doesn't work properly).

While I still haven't tracked down the cause of this, and it's only been shown 
to be a real problem when doing libc6 upgrades at the moment (which is only 
possible on Debian), it still needs to be changed as a priority.

I have just killed several machines in the process of upgrading them before I 
tracked this one down (if you tell dselect to upgrade 30+ packages and walk 
away while it's doing so then by the time you get back the evidence of where 
the problem originated will be obscured).

--- current/domains/program/init.te     2003-04-04 08:50:17.000000000 +1000
+++ default/domains/program/init.te     2003-04-13 18:04:43.000000000 +1000
@@ -62,6 +62,7 @@
 # Create unix sockets
 allow init_t self:unix_dgram_socket create_socket_perms;
 allow init_t self:unix_stream_socket create_socket_perms;
+allow init_t self:fifo_file rw_file_perms;

 # Permissions required for system startup
 allow init_t bin_t:dir { read getattr lock search ioctl };
@@ -75,7 +76,7 @@

 # Modify utmp.
 allow init_t var_run_t:file rw_file_perms;
-allow init_t initrc_var_run_t:file rw_file_perms;
+allow init_t initrc_var_run_t:file { setattr rw_file_perms };

 # For /var/run/shutdown.pid.
 type init_var_run_t, file_type, sysadmfile, pidfile;


-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
