Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8NLGVsJ015221
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 17:16:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8NLGU2R022163
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 21:16:30 GMT
Received: from dymwsm13.mailwatch.com (dymwsm13.mailwatch.com [204.253.83.37])
        by jazzband.ncsc.mil  with ESMTP id h8NLGT1A022160 for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 21:16:30 GMT
Received: from mwsc0215.mw4.mailwatch.com (mwsc0215.mw4.mailwatch.com [204.253.83.251])
	by dymwsm13.mailwatch.com (8.12.9/8.12.9) with ESMTP id h8NLGTC1011750
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 17:16:29 -0400
Received: from ecpo1.azell.com (ecpo1.azell.com [136.1.7.4])
	by dymwsm10.mailwatch.com (8.12.9/8.12.9) with ESMTP id h8NLGS64008650
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 17:16:29 -0400
Message-ID: <F5441DDE18FFD9418974338018C522B718BDAB@na1fcm61.dearborn.ford.com>
From: "Inger, Slav (S.B.)" <vinger@ford.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Sample SELinux policy that's equivalent to standard root?
Date: Tue, 23 Sep 2003 17:16:27 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I hope this is the right mailing list to ask this question.  Here's my setup:  a freshly compiled Linux 2.6.0-test3-selinux1, using a default policy supplied in selinux-usr/policy.  What I would like to do is, instead of starting with the most restrictive mode and easing my way to less restrictive, I'd like to start with a relaxed root access policy (i.e. start with root as "God" even in enforced mode, as is the case with standard Linux) and tighten up from there.  So my question is, does anyone know where I could get the configs for a policy with root rights equivalent to that on a standard Linux system?  TIA.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
