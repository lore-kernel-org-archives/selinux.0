Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r34Ek3vi028145
	for <selinux@tycho.nsa.gov>; Thu, 4 Apr 2013 10:46:04 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r34Ek2D3003024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 4 Apr 2013 10:46:02 -0400
Subject: [PATCH v3] selinux: fix problems in netnode when BUG() is compiled
 out
To: selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Thu, 04 Apr 2013 10:46:00 -0400
Message-ID: <20130404144600.6650.16381.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When the BUG() macro is disabled at compile time it can cause some
problems in the SELinux netnode code: invalid return codes and
uninitialized variables.  This patch fixes this by making sure we take
some corrective action after the BUG() macro.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Paul Moore <pmoore@redhat.com>

---

In the process of cleaning up a local git tree I realized I had this
patch still sitting in my tree that for some reason hadn't been
merged upstream.  Originally sent back on December 5, 2012.
---
 security/selinux/netnode.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index c5454c0..03a72c3 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -166,6 +166,7 @@ static void sel_netnode_insert(struct sel_netnode *node)
 		break;
 	default:
 		BUG();
+		return;
 	}
 
 	/* we need to impose a limit on the growth of the hash table so check
@@ -225,6 +226,7 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 		break;
 	default:
 		BUG();
+		ret = -EINVAL;
 	}
 	if (ret != 0)
 		goto out;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
