From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 4/6] SELinux: drop useless (and incorrect) AVTAB_MAX_SIZE
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Wed, 13 Oct 2010 17:50:19 -0400
Message-ID: <20101013215019.17293.57396.stgit@paris.rdu.redhat.com>
In-Reply-To: <20101013215002.17293.43060.stgit@paris.rdu.redhat.com>
References: <20101013215002.17293.43060.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

AVTAB_MAX_SIZE was a define which was supposed to be used in userspace to
define a maximally sized avtab when userspace wasn't sure how big of a table
it needed.  It doesn't make sense in the kernel since we always know our table
sizes.  The only place it is used we have a more appropiately named define
called AVTAB_MAX_HASH_BUCKETS, use that instead.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/avtab.c |    4 ++--
 security/selinux/ss/avtab.h |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 929480c..77a917c 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -266,8 +266,8 @@ int avtab_alloc(struct avtab *h, u32 nrules)
 	if (shift > 2)
 		shift = shift - 2;
 	nslot = 1 << shift;
-	if (nslot > MAX_AVTAB_SIZE)
-		nslot = MAX_AVTAB_SIZE;
+	if (nslot > MAX_AVTAB_HASH_BUCKETS)
+		nslot = MAX_AVTAB_HASH_BUCKETS;
 	mask = nslot - 1;
 
 	h->htable = kcalloc(nslot, sizeof(*(h->htable)), GFP_KERNEL);
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index cd4f734..32bd8b3 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -85,7 +85,6 @@ void avtab_cache_destroy(void);
 #define MAX_AVTAB_HASH_BITS 11
 #define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
 #define MAX_AVTAB_HASH_MASK (MAX_AVTAB_HASH_BUCKETS-1)
-#define MAX_AVTAB_SIZE MAX_AVTAB_HASH_BUCKETS
 
 #endif	/* _SS_AVTAB_H_ */
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
