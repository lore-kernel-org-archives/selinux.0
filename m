Message-Id: <20071107205047.102519666@manicmethod.com>
Date: Wed, 07 Nov 2007 15:50:47 -0500
From: "Joshua Brindle" <method@manicmethod.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, paul.moore@hp.com
Subject: [patch 0/2] policy capabilities and netpeer support
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset adds support for policy capabilities to the toolchain/compiler and adds the netpeer capability key.

I'm not sure how to best proceed with the sepol_setup_capability code since I'm not sure how we are going to toggle future capabilit
ies. If anyone has ideas for how to generalize the setup code please let me know.

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
