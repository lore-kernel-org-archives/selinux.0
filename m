Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA27701
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 14:57:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA29680
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 19:55:58 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id TAA29674
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 19:55:57 GMT
Message-Id: <200211072005.PAA07338@moss-shockers.ncsc.mil>
Date: Thu, 7 Nov 2002 15:05:13 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: can_network()
To: selinux@tycho.nsa.gov, tom@lemuria.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> speaking of that, shouldn't there be an every_domain_except_network
> domain? I'd love to use every_domain instead of all the lower macros,
> but it includes can_network(), which I don't want.

The goal is to largely eliminate the use of coarse-grained macros like
every_domain() [and even its immediate "children"], replacing them with
much finer-grained macros and/or individual rules to provide true least
privilege.  Naturally, this will have a cost in terms of maintaining the
policy.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
