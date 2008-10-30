Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9U4HIZD002869
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 00:17:18 -0400
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9U4FhhG000951
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 04:15:45 GMT
Message-ID: <4909351B.5090805@ak.jp.nec.com>
Date: Thu, 30 Oct 2008 13:16:27 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: sakaia@jp.fujitsu.com
Subject: README in libselinux
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I got a question on the secure os users mailing-list in Japan.
He said that he is interested in sVirt patches but not good at the way
to apply the security policy of SELinux on userspace object manager, so
it makes him hesitate to comment for the patches.

We know great manpages are provided yet, but a structured documentation
to implement SELinux aware userspace object managers is not well known.
It is not unclear whether it should be included within README, or not.

However, an official guidance for developers should be considered.

Any comment?
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
