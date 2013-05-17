Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4HJ8rxO023585
	for <selinux@tycho.nsa.gov>; Fri, 17 May 2013 15:08:53 -0400
Subject: [PATCH] netlabel: improve domain mapping validation
To: netdev@vger.kernel.org
From: Paul Moore <pmoore@redhat.com>
Cc: linux-security-module@vger.kernel.org, vlad.halilov@gmail.com,
        selinux@tycho.nsa.gov
Date: Fri, 17 May 2013 15:08:50 -0400
Message-ID: <20130517190850.11148.51057.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The net/netlabel/netlabel_domainhash.c:netlbl_domhsh_add() function
does not properly validate new domain hash entries resulting in
potential problems when an administrator attempts to add an invalid
entry.  One such problem, as reported by Vlad Halilov, is a kernel
BUG (found in netlabel_domainhash.c:netlbl_domhsh_audit_add()) when
adding an IPv6 outbound mapping with a CIPSO configuration.

This patch corrects this problem by adding the necessary validation
code to netlbl_domhsh_add() via the newly created
netlbl_domhsh_validate() function.

Ideally this patch should also be pushed to the currently active
-stable trees.

Reported-by: Vlad Halilov <vlad.halilov@gmail.com>
Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 net/netlabel/netlabel_domainhash.c |   69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/net/netlabel/netlabel_domainhash.c b/net/netlabel/netlabel_domainhash.c
index d8d4243..6bb1d42 100644
--- a/net/netlabel/netlabel_domainhash.c
+++ b/net/netlabel/netlabel_domainhash.c
@@ -245,6 +245,71 @@ static void netlbl_domhsh_audit_add(struct netlbl_dom_map *entry,
 	}
 }
 
+/**
+ * netlbl_domhsh_validate - Validate a new domain mapping entry
+ * @entry: the entry to validate
+ *
+ * This function validates the new domain mapping entry to ensure that it is
+ * a valid entry.  Returns zero on success, negative values on failure.
+ *
+ */
+static int netlbl_domhsh_validate(const struct netlbl_dom_map *entry)
+{
+	struct netlbl_af4list *iter4;
+	struct netlbl_domaddr4_map *map4;
+#if IS_ENABLED(CONFIG_IPV6)
+	struct netlbl_af6list *iter6;
+	struct netlbl_domaddr6_map *map6;
+#endif /* IPv6 */
+
+	if (entry == NULL)
+		return -EINVAL;
+
+	switch (entry->type) {
+	case NETLBL_NLTYPE_UNLABELED:
+		if (entry->type_def.cipsov4 != NULL ||
+		    entry->type_def.addrsel != NULL)
+			return -EINVAL;
+		break;
+	case NETLBL_NLTYPE_CIPSOV4:
+		if (entry->type_def.cipsov4 == NULL)
+			return -EINVAL;
+		break;
+	case NETLBL_NLTYPE_ADDRSELECT:
+		netlbl_af4list_foreach(iter4, &entry->type_def.addrsel->list4) {
+			map4 = netlbl_domhsh_addr4_entry(iter4);
+			switch (map4->type) {
+			case NETLBL_NLTYPE_UNLABELED:
+				if (map4->type_def.cipsov4 != NULL)
+					return -EINVAL;
+				break;
+			case NETLBL_NLTYPE_CIPSOV4:
+				if (map4->type_def.cipsov4 == NULL)
+					return -EINVAL;
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+#if IS_ENABLED(CONFIG_IPV6)
+		netlbl_af6list_foreach(iter6, &entry->type_def.addrsel->list6) {
+			map6 = netlbl_domhsh_addr6_entry(iter6);
+			switch (map6->type) {
+			case NETLBL_NLTYPE_UNLABELED:
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+#endif /* IPv6 */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * Domain Hash Table Functions
  */
@@ -311,6 +376,10 @@ int netlbl_domhsh_add(struct netlbl_dom_map *entry,
 	struct netlbl_af6list *tmp6;
 #endif /* IPv6 */
 
+	ret_val = netlbl_domhsh_validate(entry);
+	if (ret_val != 0)
+		return ret_val;
+
 	/* XXX - we can remove this RCU read lock as the spinlock protects the
 	 *       entire function, but before we do we need to fixup the
 	 *       netlbl_af[4,6]list RCU functions to do "the right thing" with


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
