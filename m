Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7QEnIrT013323
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 10:49:18 -0400 (EDT)
Received: from betta.xs4all.nl (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7QEnH0g015462
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 14:49:17 GMT
Received: from localhost (localhost [127.0.0.1])
	by betta.xs4all.nl (Postfix) with ESMTP id F181E4880
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 16:49:12 +0200 (CEST)
Message-ID: <1580.10.1.1.4.1093531747.squirrel@10.1.1.4>
Date: Thu, 26 Aug 2004 16:49:07 +0200 (CEST)
Subject: Req: patches against vanilla source
From: "Laurens Blankers" <lblankers@xs4all.nl>
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
References: 
In-Reply-To: 
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello all,

Applying the patches, provided on the website, to the source of the
various utilities results in rejects. Especially util-linux, which already
includes several selinux files which don't work well with the patch and
sysvinit causes a lot of problems.

Would it be possible to provide patches against the vanilla source?

TIA,

Laurens Blankers





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
