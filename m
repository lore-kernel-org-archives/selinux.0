Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA02169
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2002 20:21:19 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id BAA21498
	for <selinux@tycho.nsa.gov>; Sat, 9 Feb 2002 01:20:24 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id BAA21494 for <selinux@tycho.nsa.gov>; Sat, 9 Feb 2002 01:20:22 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id C0A479266A
	for <selinux@tycho.nsa.gov>; Sat,  9 Feb 2002 12:21:09 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 49DED32FDF1
	for <selinux@tycho.nsa.gov>; Sat,  9 Feb 2002 11:21:56 +1000 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: run_init - am I missing something?
Date: Sat, 9 Feb 2002 10:26:48 +1000
MIME-Version: 1.0
Message-Id: <20020209012156.49DED32FDF1@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems to me that run_init should just quietly change to 
system_u:system_r:initrc_t without asking for any passwords if run from
system_u:system_r:init_t.  That way the same /etc/init.d/* scripts can be 
used by the sysadmin to restart daemons and also for them to be started 
automatically on boot.

Is there anything I'm missing here?  Is there some need to do otherwise?

Also I've hacked my run_init to just run the program if it's run on a non-SE 
system so that the same start scripts can be used with an SE kernel or a 
non-SE kernel.  Any good reasons for not doing this?

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
