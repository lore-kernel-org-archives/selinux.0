Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j06ETUIi008807
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 09:29:30 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j06ETXoP011177
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 14:29:33 GMT
Received: from twoface.columbia.tresys.com (twoface.columbia.tresys.com [10.1.13.32] (may be forged))
	by gotham.columbia.tresys.com (8.12.8/8.12.8) with ESMTP id j06ETS8R006422
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 09:29:28 -0500
Subject: passwd using getprevcon() for enforcement
From: Joshua Brindle <method@gentoo.org>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 06 Jan 2005 09:29:41 -0500
Message-Id: <1105021782.972.9.camel@twoface>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was wondering why Fedora's passwd is patched to use getprevcon()? It
seems to me that enforcing policy on a types previous context is very
broken behavior. Shouldn't the patch enforce on the current context and
have different passwd types for privileged users (i seem to remember
that there was a passwd_t and sysadm_passwd_t but that might have been
old-api).

Joshua Brindle	


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
