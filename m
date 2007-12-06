Message-Id: <20071206213852.083412876@tresys.com>
Date: Thu, 06 Dec 2007 16:38:52 -0500
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Cc: method@manicmethod.com, Stephen Smalley <sds@tycho.nsa.gov>,
        dwalsh@redhat.com, paul.moore@hp.com, cpebenito@tresys.com,
        kmacmillan@mentalrootkit.com
Subject: [patch 0/2] policy capability support
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Updated policycap patch set based on recent discussion.  The consensus
seems to be to only allow policycaps in the base module.  This is now
enforced by the checkpolicy/checkmodule parser.

Signed-off-by: Todd C. Miller <tmiller@tresys.com>

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
