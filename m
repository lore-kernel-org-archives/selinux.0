Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0S3CPRb003405
	for <selinux@tycho.nsa.gov>; Tue, 27 Jan 2004 22:12:25 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0S3B8xr022512
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 03:11:09 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id i0S3B8Yc022509
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 03:11:08 GMT
Subject: Re: Has something changed on Dan Walsh's site?
From: Tom Ziebro <tziebro@redhat.com>
To: Mark Shakespeare <mshakes@llnl.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <p06020419bc3b1448ee02@[128.115.96.64]>
References: <p06020419bc3b1448ee02@[128.115.96.64]>
Content-Type: text/plain
Message-Id: <1075259527.2829.8.camel@pcp01854918pcs.hyatsv01.md.comcast.net>
Mime-Version: 1.0
Date: 27 Jan 2004 22:12:08 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mark-


> I tried a fresh install of SeLinux on top of a new Fedora build.
> Using Dan Walsh's selUpgrade script.....used to work a week ago.

Those dependencies look like they are coming from packages on Fedora
Core 2. You are building on Fedora Core 1.

> ./selUpgrade: line 55: cd: /etc/security/selinux/src/policy/domains: 
> no such file or directory

You also might be missing some packages: policy* / libselinux, and
checkpolicy.


Tom Ziebro
Red Hat, Inc.
tziebro@redhat.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
