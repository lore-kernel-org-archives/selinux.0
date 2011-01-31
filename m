Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0V8EnMW000850
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2011 03:14:50 -0500
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p0V8El3A017084
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2011 08:14:48 GMT
Received: from mailgate3.nec.co.jp ([10.7.69.160])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id p0V8Ejw2012345
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2011 17:14:45 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id p0V8Ej109772 for selinux@tycho.nsa.gov; Mon, 31 Jan 2011 17:14:45 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
	by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id p0V8Ei0x001001
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2011 17:14:44 +0900 (JST)
Message-ID: <4D466F3B.6090906@ak.jp.nec.com>
Date: Mon, 31 Jan 2011 17:13:47 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Tiny version of SE-PostgreSQL got merged
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A few days ago, a tiny initial version of SE-PostgreSQL got merged
in the v9.1 development cycle at this commit: http://bit.ly/gF2QPQ

Although it omits various features which I planned at first, it
seems to me an ambitious first step.
PostgreSQL has shifted to provide a set of facilities to implement
label based mandatory access control, such as security label support
on database objects or security hooks being available for plug-in
modules.

The current version of SE-PostgreSQL is implemented as a plugin
module that utilizes these hooks (but only a limited places are
covered), then it asks SELinux in kernel whether the required
access shall be allowed, or not.

In the next development, I'd like to expand its access control coverage
using more fine grained security hooks. Right now, DDL permissions are
restrictions. Also, row-level security is in-progress feature.

I have much things to do for the v9.2 or v9.3, however, I'd like to
appreciate people who have given me many feedbacks since 2006

Thanks,
-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
