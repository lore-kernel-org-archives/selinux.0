Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j144iV53005364
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 23:44:31 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j144iXOQ029929
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 04:44:34 GMT
Received: from [192.168.2.96] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j144iSeF028173
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 23:44:28 -0500 (EST)
Subject: How to install CVS wine
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 04 Feb 2005 01:44:20 -0500
Message-Id: <1107499460.29033.7.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

See, I used to have it under /src, but SElinux didn't like that, and
kept complaining. I moved it under ~/src and relabeled to user_home_t.
Now I do cvs update, build it as a regular user, and try to do:
su -c "make install". However, that doesn't work, because
the sysadmin can't run user_home_t scripts. Should the sysadmin be able
to run user_home_t scripts, or am I doing this the wrong way?

audit(1107498685.995:0): avc:  denied  { execute } for  pid=29007
exe=/usr/bin/make name=mkinstalldirs dev=dm-2 ino=16332
scontext=root:sysadm_r:sysadm_t tcontext=root:object_r:user_home_t
tclass=file

P.S. tools/wineinstall actually requires that wine be built as a regular
user, and installed as root.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
