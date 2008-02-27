Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1RE2Gkc029280
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 09:02:16 -0500
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1RE2EDp023566
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 14:02:15 GMT
Date: Thu, 28 Feb 2008 01:01:31 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
cc: Daniel J Walsh <dwalsh@redhat.com>
Subject: Speaking of networking...
Message-ID: <Xine.LNX.4.64.0802280057060.14155@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Any further thoughts on how to push the secmark integration forward?

The secmark table patch should allow MAC rules to be administered 
independently, and I know there has been some demand for the new (well, 
now not so new) networking controls.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
