Message-Id: <20071205184848.180973622@tresys.com>
Date: Wed, 05 Dec 2007 13:48:48 -0500
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, paul.moore@hp.com, jbrindle@tresys.com
Subject: [patch 0/2] policy capability support
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a respin of the policy capability support patch that preserves
the policycaps in the final policy binary and includes support for
displaying policy caps in dispol/dismod.

I still need to address the equivalence vs. union issue.

 - todd

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
