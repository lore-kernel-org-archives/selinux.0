Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA12845
	for <selinux@tycho.nsa.gov>; Tue, 30 Apr 2002 20:57:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA11037
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 00:55:52 GMT
Received: from coffeesaur2.evoserve.com (evoworks.evoserve.com [210.16.10.5])
	by jazzswing.ncsc.mil  with ESMTP id AAA11033
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 00:55:51 GMT
Received: from evoworks.evoserve.com (localhost [127.0.0.1])
	by coffeesaur2.evoserve.com (Postfix) with ESMTP id B6485812E3
	for <selinux@tycho.nsa.gov>; Wed,  1 May 2002 08:57:34 +0800 (PHT)
To: selinux@tycho.nsa.gov
Subject: successfull avc_toggle
Date: Wed, 01 May 2002 08:57:34 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
Message-Id: <20020501005734.B6485812E3@coffeesaur2.evoserve.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I can go into enforcing mode mode now without being logged out. The
policy is too restrictive though and i added some allow lines to the 
policy.

domains/admin.te:
allow sysadm_t getty_t:fd { use };
allow sysadm_t devfs_t:chr_file { getattr };

domains/programs/getty.te:
allow getty_t devtty_t:lnk_file { read };

is this ok?
ordiinary user can not login yet. root can use ssh.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
