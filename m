Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA01055
	for <selinux@tycho.nsa.gov>; Thu, 21 Nov 2002 14:04:38 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA12145
	for <selinux@tycho.nsa.gov>; Thu, 21 Nov 2002 19:02:29 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-189.nas-smoothtransition.com [66.95.157.189] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id TAA12141
	for <selinux@tycho.nsa.gov>; Thu, 21 Nov 2002 19:02:29 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>, <selinux@tycho.nsa.gov>
Subject: RE: login (new default_contexts, run-time detection)
Date: Thu, 21 Nov 2002 14:03:48 -0500
Message-ID: <001f01c29190$bc347db0$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200211211510.KAA18104@moss-shockers.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> In fact, this would seem to be an issue as well for your install-src 
> policy Makefile target; at present, it would leave old .te 
> files from the former policy that might have been removed in the new
policy.

Yup you're right...I'll put it on my list to try to submit another
patch.  Probably just delete any existing policy src directory before
installing new.  Simple change

> I'd suggest just checking for default_contexts.

OK, sounds like a plan.  At least that's easy!

Thanks Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
