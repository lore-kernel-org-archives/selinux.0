Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5A0j5rT024002
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 20:45:05 -0400 (EDT)
Received: from abyss.simplyaquatics.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5A0j2Qd021326
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 20:45:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by abyss.simplyaquatics.com (Postfix) with ESMTP id 9F8C63A4063
	for <selinux@tycho.nsa.gov>; Wed,  9 Jun 2004 19:44:55 -0500 (CDT)
Received: from TECRAS1 (simplyaquatics.com [209.192.116.78])
	by abyss.simplyaquatics.com (Postfix) with ESMTP id 15C043A4063
	for <selinux@tycho.nsa.gov>; Wed,  9 Jun 2004 19:44:55 -0500 (CDT)
From: "Ed Street" <edstreet@street-tek.com>
To: "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: RE: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Date: Wed, 9 Jun 2004 20:44:54 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <20040609214126.GF5727@lkcl.net>
Message-Id: <20040610004455.15C043A4063@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I know under SID the stock postfix rules works 100% correctly with no
augmentation.

Ed

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
Behalf Of Luke Kenneth Casson Leighton
Sent: Wednesday, June 09, 2004 5:41 PM
To: SE-Linux
Subject: [debian] postfix chroot setup from /etc/init.d/postfix isn't
working.

hi,

debian's postfix init.d script does a whole stackload of
things like copy over /etc/localtime, /etc/services.

it's rather scary.

... and it doesn't work.

by disabling the chroot (setting SYNC_CHROOT="") i managed
to get postfix to start (and it works)

i don't know if i was supposed to have these enabled, but
i have added them to the end of the postfix.te file (which
came up during an "enforcing=no" boot)

	allow postfix_cleanup_t postfix_cleanup_t:capability { sys_chroot };
	allow postfix_local_t mail_spool_t:dir { remove_name };
	allow postfix_local_t mail_spool_t:file { create unlink };
	allow postfix_master_t postfix_master_t:capability { sys_chroot };
	allow postfix_pickup_t postfix_pickup_t:capability { sys_chroot };
	allow postfix_qmgr_t postfix_qmgr_t:capability { sys_chroot };


p.s. yes i tried an exim4 setup with those execve child renaming
tricks and it's all got horribly pear-shaped...


---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.698 / Virus Database: 455 - Release Date: 6/2/2004
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
