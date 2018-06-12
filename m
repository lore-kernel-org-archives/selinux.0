From: Peter Enderborg <peter.enderborg@sony.com>
To: <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
 Daniel Jurgens <danielj@mellanox.com>, Doug Ledford
 <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>
Date: Tue, 12 Jun 2018 10:09:08 +0200
Message-ID: <20180612080912.7827-10-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-1-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH 09/13] selinux: Cleanup printk logging in sidtab
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/ss/sidtab.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 5be31b7af225..fd75a12fa8fc 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -214,8 +214,7 @@ int sidtab_context_to_sid(struct sidtab *s,
 		}
 		sid = s->next_sid++;
 		if (context->len)
-			printk(KERN_INFO
-		       "SELinux:  Context %s is not valid (left unmapped).\n",
+			pr_info("SELinux:  Context %s is not valid (left unmapped).\n",
 			       context->str);
 		ret = sidtab_insert(s, sid, context);
 		if (ret)
@@ -253,7 +252,7 @@ void sidtab_hash_eval(struct sidtab *h, char *tag)
 		}
 	}
 
-	printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, longest "
+	pr_debug("%s:  %d entries and %d/%d buckets used, longest "
 	       "chain length %d\n", tag, h->nel, slots_used, SIDTAB_SIZE,
 	       max_chain_len);
 }
-- 
2.15.1
