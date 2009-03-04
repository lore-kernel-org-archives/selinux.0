Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n24B4kgp000352
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 06:04:47 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n24B4iBp025878
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 11:04:45 GMT
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 11BDA18097
	for <selinux@tycho.nsa.gov>; Wed,  4 Mar 2009 22:04:37 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id DB74B22699
	for <selinux@tycho.nsa.gov>; Wed,  4 Mar 2009 22:04:35 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: gnome and dbus
Date: Wed, 4 Mar 2009 22:04:30 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200903042204.34105.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

type=AVC msg=audit(1236164018.240:156): avc:  denied  { execute_no_trans } for  
pid=6554 comm="dbus-daemon" path="/usr/lib/gnome-vfs-2.0/gnome-vfs-daemon" 
dev=hda2 ino=393873 
scontext=unconfined_u:unconfined_r:system_dbusd_t:s0-s0:c0.c1023 
tcontext=system_u:object_r:lib_t:s0 tclass=file

So what would this gnome-vfs-daemon program be and why would a dbus-daemon 
process be running it?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
