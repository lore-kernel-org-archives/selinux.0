Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i59LiBrT023064
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 17:44:12 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i59Li9Qd016961
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 17:44:09 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 9 Jun 2004 21:44:06 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BYAEC-0001dB-25
	for selinux@tycho.nsa.gov; Wed, 09 Jun 2004 21:03:20 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BYAp4-0004up-5r
	for selinux@tycho.nsa.gov; Wed, 09 Jun 2004 21:41:26 +0000
Date: Wed, 9 Jun 2004 21:41:26 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Message-ID: <20040609214126.GF5727@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
