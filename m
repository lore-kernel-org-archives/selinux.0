From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 3/6] SELinux: deterministic ordering of range transition rules
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Wed, 13 Oct 2010 17:50:14 -0400
Message-ID: <20101013215013.17293.18247.stgit@paris.rdu.redhat.com>
In-Reply-To: <20101013215002.17293.43060.stgit@paris.rdu.redhat.com>
References: <20101013215002.17293.43060.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Range transition rules are placed in the hash table in an (almost)
arbitrary order.  This patch inserts them in a fixed order to make policy
retrival more predictable.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/policydb.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index aa5a2fd..97fb0cf 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -185,9 +185,19 @@ static u32 rangetr_hash(struct hashtab *h, const void *k)
 static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
 {
 	const struct range_trans *key1 = k1, *key2 = k2;
-	return (key1->source_type != key2->source_type ||
-		key1->target_type != key2->target_type ||
-		key1->target_class != key2->target_class);
+	int v;
+
+	v = key1->source_type - key2->source_type;
+	if (v)
+		return v;
+
+	v = key1->target_type - key2->target_type;
+	if (v)
+		return v;
+
+	v = key1->target_class - key2->target_class;
+
+	return v;
 }
 
 /*


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
