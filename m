Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k79CLEbQ031638
	for <selinux@tycho.nsa.gov>; Wed, 9 Aug 2006 08:21:14 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k79CKuiG015154
	for <selinux@tycho.nsa.gov>; Wed, 9 Aug 2006 12:20:57 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7) with ESMTP id k79CL3CG015696
	for <selinux@tycho.nsa.gov>; Wed, 9 Aug 2006 08:21:03 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7/Submit) id k79CL3KU015695
	for selinux@tycho.nsa.gov; Wed, 9 Aug 2006 08:21:03 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7976SMu024539
	for <selinux@tycho.nsa.gov>; Wed, 9 Aug 2006 03:06:29 -0400
Received: from ercist.iscas.ac.cn (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7975wiG008939
	for <selinux@tycho.nsa.gov>; Wed, 9 Aug 2006 07:06:04 GMT
Subject: What the relationship of "users" file, "rolemap" file,
	"appconfig-strict/seusers" file and so on in Reference policy?
From: root <ldm@ercist.iscas.ac.cn>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 09 Aug 2006 14:57:08 +0800
Message-Id: <1155106628.2607.32.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Can anyone tell me what the relationship of the following files?

policy/users
policy/rolemap
config/appconfig-strict/seusers
config/appconfig-strict/root_default_contexts
config/appconfig-strict/default_contexts
config/appconfig-strict/default_type

Thanks!

I am configuring a port of Reference policy to SEBSD. I configured the
build.conf use strict policy, make reload, login as root. I got the
following message:

Your default context is user_u:sysadm_r:sysadm_t.
...:Determining SEBSD label for terminal /dev/ttyv0:Invalid argument

then still promote login:

...............................


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
