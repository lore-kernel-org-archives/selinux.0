Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA05953
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2001 18:57:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA16157
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2001 22:57:27 GMT
Received: from smtp2.abac.com (smtp2.abac.com [216.55.128.11])
	by jazzband.ncsc.mil  with ESMTP id WAA16153
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2001 22:57:26 GMT
Received: from steve.computer.org (01-042.039.popsite.net [64.24.107.42])
	by smtp2.abac.com (8.10.1/8.10.1) with ESMTP id f6OMvdn66451
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2001 15:57:40 -0700 (PDT)
Message-Id: <4.3.2.7.2.20010724165057.00a965d0@mail1.abac.com>
Date: Tue, 24 Jul 2001 16:57:43 -0600
To: selinux@tycho.nsa.gov
From: Steve Eckmann <eckmann@computer.org>
Subject: 8.3 filenames
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

My selinux kernel displays only 8.3 filenames for floppy and cdrom
drives, but non-selinux kernels display "longnames". I've encountered
this anomaly with every selinux installation that I've tried, over
RH6.2 and RH7.1. I've built a lot of linux kernels and haven't seen
this problem before. I guess I'm doing something wrong with filesystem
configuration, but what?

Steve


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
