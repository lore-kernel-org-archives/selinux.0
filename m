Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA28140
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 14:52:20 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA05954
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 19:49:07 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-195.nas-smoothtransition.com [66.95.157.195] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id TAA05950
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 19:49:05 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Wayne Salamon'" <wsalamon@tislabs.com>
Cc: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: convention for disabled/unused policy modules
Date: Tue, 25 Feb 2003 14:51:22 -0500
Message-ID: <003501c2dd07$656bfa40$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.LNX.4.33.0302251238350.1479-100000@vox.gw.tislabs.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>   Should we also push the corresponding .fc files into a unused
directory?
> The policy will build either way with the current system, but how
would
> you like to see it in the distribution?

I'm fine either way.  Right now the makefile won't include the .fc file
in the file_contexts file if there is not an associated .te file, so I
would vote for leaving it alone for simplicity's sake.  The fewer files
we have to moe around and manage the better.

Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
