Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8CH9BNs014420
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2005 13:09:11 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8CH6R7C005447
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2005 17:06:27 GMT
Subject: Refpolicy loadable modules
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 12 Sep 2005 13:09:47 -0400
Message-Id: <1126544987.18007.9.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've committed the support for building loadable modules to reference
policy sourceforge cvs.  Refpolicy can now build build a base module,
and some of the remaining modules can be built.  However, there are
still a few issues to be worked out with some of the modules.  For
example, require blocks cannot be in conditions yet, so any module that
has conditional policy will most likely not compile right now.
Otherwise, anyone looking to work with loadable modules now has a policy
to work with.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
