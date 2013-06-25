Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r5PLIEm2018719
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2013 17:18:20 -0400
Subject: [PATCH 1/9] selinux: fix problems in netnode when BUG() is compiled
 out
To: linux-security-module@vger.kernel.org, eparis@redhat.com,
        selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Tue, 25 Jun 2013 17:18:18 -0400
Message-ID: <20130625211818.5057.63.stgit@localhost>
In-Reply-To: <20130625211306.5057.31329.stgit@localhost>
References: <20130625211306.5057.31329.stgit@localhost>
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
