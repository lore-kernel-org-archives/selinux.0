Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA02535
	for <selinux@tycho.nsa.gov>; Sun, 5 May 2002 10:47:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA12714
	for <selinux@tycho.nsa.gov>; Sun, 5 May 2002 14:46:39 GMT
Received: from coffeesaur2.evoserve.com (postfix@evoworks.evoserve.com [210.16.10.5])
        by jazzband.ncsc.mil  with ESMTP id OAA12710 for <selinux@tycho.nsa.gov>; Sun, 5 May 2002 14:46:38 GMT
Received: from evoworks.evoserve.com (localhost [127.0.0.1])
	by coffeesaur2.evoserve.com (Postfix) with ESMTP id A353E8145A
	for <selinux@tycho.nsa.gov>; Sun,  5 May 2002 22:47:46 +0800 (PHT)
To: selinux@tycho.nsa.gov
Subject: preferred way to configure devfs contexts
Date: Sun, 05 May 2002 22:47:46 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
Message-Id: <20020505144746.A353E8145A@coffeesaur2.evoserve.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

devfs_context is fast becoming my preferred way to configure
/dev contexts. Can we do away with the hacked devfsd?

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
