Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAEKCgIi019896
	for <selinux@tycho.nsa.gov>; Sun, 14 Nov 2004 15:12:43 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAEKBGcp027531
	for <selinux@tycho.nsa.gov>; Sun, 14 Nov 2004 20:11:17 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 6ED50BF2F
	for <selinux@tycho.nsa.gov>; Sun, 14 Nov 2004 20:12:36 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CTQuK-0007UK-LA
	for selinux@tycho.nsa.gov; Sun, 14 Nov 2004 20:23:32 +0000
Date: Sun, 14 Nov 2004 20:23:32 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions
Message-ID: <20041114202332.GO5031@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i hope people don't mind me pointing out what may appear to be obvious:

q: how do you stop an attacker circumventing a program with this
seteuid-like dynamic context transition capability, such that the
attacker can make the program transition anywhere anytime to an
arbitrarily chosen domain?

answer: by restricting the domains to which the transition may occur.

q: how would you do that?

answer: by providing something similar to domain_auto_trans() which is
instead adding a level of indirection.  so, instead of the newly
proposed function (let's call it selinux_change_domain) specifying the
new domain as its argument, you instead specify an intermediate handle.

so you'd have in the policy:

dynamic_handle "samba_as_root" samba_root_t
dynamic_handle "samba_as_user" samba_user_t

dynamic_auto_trans(samba_t, "samba_as_root")
dynamic_auto_trans(samba_root_t, "samba_as_user")

then, inside smbd, you call, at the appropriate point:

	selinux_change_domain("samba_as_user")

then, the job of the selinux_change_domain() function is to not only
check that you have permission to make dynamic transitions, but
also that you are in the samba_root_t domain - and to do a lookup
onto the dynamic_handle to find out what domain to transition to.


otherwise, you run the risk of a circumvented program being able to
transition to unconfined_t - or anything that they damn well choose.

i trust that this has been considered in the design of the new dynamic
transition function?

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
