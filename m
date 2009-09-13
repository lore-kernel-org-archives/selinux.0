From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 3/3] SELinux: flush the avc before disabling SELinux
To: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, mingo@elte.hu, dhowells@redhat.com
Date: Sat, 12 Sep 2009 22:54:23 -0400
Message-ID: <20090913025423.6583.62118.stgit@paris.rdu.redhat.com>
In-Reply-To: <20090913025409.6583.58777.stgit@paris.rdu.redhat.com>
References: <20090913025409.6583.58777.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Before SELinux is disabled at boot it can create AVC entries.  This patch
will flush those entries before disabling SELinux.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/avc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index f601246..1ed0f07 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -868,6 +868,8 @@ u32 avc_policy_seqno(void)
 
 void avc_disable(void)
 {
+	avc_flush();
+	synchronize_rcu();
 	if (avc_node_cachep)
 		kmem_cache_destroy(avc_node_cachep);
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
