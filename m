Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA03695
	for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2003 10:24:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA29480
	for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2003 15:21:38 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id PAA29476
	for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2003 15:21:37 GMT
Message-Id: <200301061531.KAA12084@moss-shockers.ncsc.mil>
Date: Mon, 6 Jan 2003 10:31:28 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: kerberos and selinux
To: selinux@tycho.nsa.gov, ian.willis@sge.net
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Just wondering if anyone has done any work with selinux and kerberos or 
> selinux and bind polices.

There is a policy for bind included in the example policy.  See 
selinux/policy/domains/program/named.te.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
