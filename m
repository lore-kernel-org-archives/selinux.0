Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j33MuZDo025281
	for <selinux@tycho.nsa.gov>; Sun, 3 Apr 2005 18:56:35 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j33MsgSQ022676
	for <selinux@tycho.nsa.gov>; Sun, 3 Apr 2005 22:54:42 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j33Msh7j002663
	for <selinux@tycho.nsa.gov>; Sun, 3 Apr 2005 18:54:43 -0400 (EDT)
Subject: /dev/pts/x use denials
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sun, 03 Apr 2005 19:00:41 -0400
Message-Id: <1112569241.21383.37.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Strange denials:

/dev/pts/2 has context: sysadm_tmp_t.
Those happen intermittently, but I can't figure out when exactly.
I am logged in as a regular user, but su-ed to root. Usually accompanied
by a dac_override.

audit(1112568847.907:0): avc:  denied  { use } for  pid=22851
exe=/usr/bin/mplayer path=/dev/pts/2 dev=devpts ino=4
scontext=root:sysadm_r:sysadm_mplayer_t tcontext=phantom:staff_r:staff_t
tclass=fd
audit(1112568874.222:0): avc:  denied  { use } for  pid=22870
exe=/usr/bin/tvtime path=/dev/pts/2 dev=devpts ino=4
scontext=root:sysadm_r:sysadm_tvtime_t tcontext=phantom:staff_r:staff_t
tclass=fd
audit(1112568881.428:0): avc:  denied  { use } for  pid=22872
exe=/bin/bash path=/dev/pts/2 dev=devpts ino=4
scontext=root:sysadm_r:sysadm_mozilla_t tcontext=phantom:staff_r:staff_t
tclass=fd

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
