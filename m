Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1CFcYL9023794
	for <selinux@tycho.nsa.gov>; Sat, 12 Feb 2005 10:38:34 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1CFbuKI019115
	for <selinux@tycho.nsa.gov>; Sat, 12 Feb 2005 15:37:56 GMT
Received: from [192.168.2.96] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j1CFbsZ1006559
	for <selinux@tycho.nsa.gov>; Sat, 12 Feb 2005 10:37:55 -0500 (EST)
Subject: shm denials
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sat, 12 Feb 2005 10:39:03 -0500
Message-Id: <1108222744.23018.5.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I'm wondering if the following are caused by the Nvidia driver I use.
This is GL stuff trying to use shmat()/shmdt(). The first is a GL game.
The last few are GL screensavers shipped by Fedora. The denials are
annoying. Can anyone with Mesa GL test to see if Nvidia's library is
causing this? 

audit(1108172859.969:0): avc:  denied  { execute } for  pid=17617
comm=ut2004-bin path=/SYSV00000000 (deleted) dev=tmpfs ino=46366738
scontext=user_u:user_r:user_t tcontext=user_u:object_r:user_tmpfs_t
tclass=file

audit(1108172873.539:0): avc:  denied  { write execute } for  pid=17617
comm=ut2004-bin path=/SYSV00000000 (deleted) dev=tmpfs ino=38338560
scontext=user_u:user_r:user_t
tcontext=system_u:object_r:xdm_xserver_tmpfs_t tclass=file

audit(1108185116.592:0): avc:  denied  { write } for  pid=18105
comm=bubble3d path=/SYSV00000000 (deleted) dev=tmpfs ino=38338560
scontext=user_u:user_r:user_t
tcontext=system_u:object_r:xdm_xserver_tmpfs_t tclass=file

audit(1108199240.780:0): avc:  denied  { write } for  pid=20961
comm=blinkbox path=/SYSV00000000 (deleted) dev=tmpfs ino=38338560
scontext=user_u:user_r:user_t
tcontext=system_u:object_r:xdm_xserver_tmpfs_t tclass=file

audit(1108204054.842:0): avc:  denied  { write } for  pid=22418
comm=morph3d path=/SYSV00000000 (deleted) dev=tmpfs ino=38338560
scontext=user_u:user_r:user_t
tcontext=system_u:object_r:xdm_xserver_tmpfs_t tclass=file

audit(1108207062.099:0): avc:  denied  { write } for  pid=22597
comm=gflux path=/SYSV00000000 (deleted) dev=tmpfs ino=38338560
scontext=user_u:user_r:user_t
tcontext=system_u:object_r:xdm_xserver_tmpfs_t tclass=file

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
