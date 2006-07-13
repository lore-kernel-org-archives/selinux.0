Message-ID: <44B667C6.20905@trustedcs.com>
Date: Thu, 13 Jul 2006 10:33:26 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>
Subject: [PATCH] selinux: fix memory leak
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a possible memory leak when a policydb structure
is destroyed.

Signed-off-by: Darrel Goeddel <dgoeddel@trustedcs.com>

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 0111990..f03960e 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -644,10 +644,18 @@ void policydb_destroy(struct policydb *p
 	kfree(lra);
 
 	for (rt = p->range_tr; rt; rt = rt -> next) {
-		kfree(lrt);
+		if (lrt) {
+			ebitmap_destroy(&lrt->range.level[0].cat);
+			ebitmap_destroy(&lrt->range.level[1].cat);
+			kfree(lrt);
+		}
 		lrt = rt;
 	}
-	kfree(lrt);
+	if (lrt) {
+		ebitmap_destroy(&lrt->range.level[0].cat);
+		ebitmap_destroy(&lrt->range.level[1].cat);
+		kfree(lrt);
+	}
 
 	if (p->type_attr_map) {
 		for (i = 0; i < p->p_types.nprim; i++)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
