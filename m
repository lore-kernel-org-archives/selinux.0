Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5LNG0gA012189
	for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2005 19:16:00 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5LN6Skw018432
	for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2005 23:06:29 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id C83EDAEF84
	for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2005 23:25:33 +0100 (BST)
Received: from mail.nagafix.co.uk ([127.0.0.1])
 by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 30626-13 for <selinux@tycho.nsa.gov>;
 Tue, 21 Jun 2005 23:25:31 +0100 (BST)
Received: from [192.168.0.1] (unknown [81.1.93.24])
	by mail.nagafix.co.uk (Postfix) with ESMTP id C1877AEF83
	for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2005 23:25:30 +0100 (BST)
Subject: upgrade howto
From: antoine <antoine@nagafix.co.uk>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 22 Jun 2005 00:06:24 +0100
Message-Id: <1119395184.9416.31.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What is the safest way of upgrading libselinux and libsepol?

I attempted it a couple of weeks ago and had to resort to statically
linked copies of ls and tar to restore the previous version after the
upgrade broke my system. Clearly, I did something wrong. What is scary
is that a lot of the core system utilities are linked against libselinux
(ls, init, portage, etc) and that when I upgrade, it would seem that I
need to rebuild them (as just upgrading the library left them unusable)
- which is impossible without these basic tools... catch 22?

Note: this is on a Gentoo system where everything is compiled from
source and so a big rpm upgrade transaction is simply not an option
here.

Thanks
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
