Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2VItHDo027903
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 13:55:17 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2VIpGTg010205
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 18:51:16 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j2VIruB9017521
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 13:53:56 -0500 (EST)
Subject: Cron /null fd:use use denials
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 31 Mar 2005 14:00:07 -0500
Message-Id: <1112295607.12948.69.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What's causing those?

audit(1112259892.387:9374931): avc:  denied  { use } for  pid=10993
exe=/usr/sbin/sendmail.sendmail path=/null dev=selinuxfs ino=245
scontext=system_u:system_r:system_mail_t
tcontext=system_u:system_r:init_t tclass=fd

audit(1112259892.551:9376543): avc:  denied  { use } for  pid=10996
exe=/usr/sbin/tmpwatch path=/null dev=selinuxfs ino=245
scontext=system_u:system_r:tmpreaper_t tcontext=system_u:system_r:init_t
tclass=fd

audit(1112259892.620:9377236): avc:  denied  { use } for  pid=10999
exe=/usr/sbin/logrotate path=/null dev=selinuxfs ino=245
scontext=system_u:system_r:logrotate_t tcontext=system_u:system_r:init_t
tclass=fd

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
