Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA04704
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 07:28:45 -0500 (EST)
From: j.logsdon@lancaster.ac.uk
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA18449
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 12:25:54 GMT
Received: from parmenides.zen.co.uk (parmenides.zen.co.uk [212.23.8.69])
	by jazzswing.ncsc.mil  with SMTP id MAA18445
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 12:25:53 GMT
Received: from localhost (j.logsdon@localhost)
	by quantex-research.com (8.8.7/8.8.7) with ESMTP id MAA00495
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 12:31:20 GMT
Date: Wed, 22 Jan 2003 12:31:19 +0000 (GMT)
To: selinux@tycho.nsa.gov
Subject: Accounting ...
Message-ID: <Pine.LNX.4.10.10301221218030.8352-100000@mercury.quantex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi

It strikes me that SE Linux can also answer another question re
accounting.  Since each program can have it's domain, when it is executed
it should be possible to calculate the usage as opposed to the usual Unix
acct approach which considers all programs to be the same.  Thus use of
individual programs can be monitored.

Am I understanding things correctly and is there another 'approved' way of
doing such things?  The alternative of doing a ps or top episodically is
very expensive in overhead and estimating usage by the PID

TIA

John


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
