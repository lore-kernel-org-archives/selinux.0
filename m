Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6VGBVrT003373
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 12:11:34 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6VGAxHs006974
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 16:11:00 GMT
Subject: Re: policy version jumped to 18
From: Erich Schubert <erich@debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040731141841.GQ3378@lkcl.net>
References: <20040731120634.GK3378@lkcl.net>
	 <20040731141841.GQ3378@lkcl.net>
Content-Type: text/plain
Date: Sat, 31 Jul 2004 18:11:29 +0200
Message-Id: <1091290289.24888.4.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Luke,
when you use policy utilities and policy files for version 18 you
probably should upgrade your kernel to support verison 18, too.
I had the same problem; i hacked the makefile so the tools explicitely
generate a version 17 policy, but the better way to get the kernel patch
from the selinux homepage and just build a kernel with version 18.

Greetings,
Erich


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
