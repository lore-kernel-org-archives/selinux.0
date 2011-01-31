Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0VA94l9006900
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2011 05:09:04 -0500
Received: from ams-iport-1.cisco.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p0VA933A003149
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2011 10:09:04 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Tiny version of SE-PostgreSQL got merged
Date: Mon, 31 Jan 2011 11:09:00 +0100
Message-ID: <0B31D28E10F4FA489A0261135B94A14804A456B3@XMB-AMS-109.cisco.com>
In-Reply-To: <4D466F3B.6090906@ak.jp.nec.com>
References: <4D466F3B.6090906@ak.jp.nec.com>
From: "Ger Lawlor (gelawlor)" <gelawlor@cisco.com>
To: "KaiGai Kohei" <kaigai@ak.jp.nec.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm only new to SeLinux, but will have requirements around PostgreSQL.
Can you give me some background and info on why 
This SE-PostgresQL exists? Is it specific to this database, or are there
similar projects for other database types?
Was it not possible to label files within a default installation? Was
this insufficient for Postgres security?

Thanks,
Ger.

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of KaiGai Kohei
Sent: Monday, January 31, 2011 8:14 AM
To: selinux@tycho.nsa.gov
Subject: Tiny version of SE-PostgreSQL got merged

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
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
