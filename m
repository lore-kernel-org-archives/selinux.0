Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@redhat.com>
Cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@tresys.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
In-Reply-To: <1122903665.6573.281.camel@moss-spartans.epoch.ncsc.mil>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
	 <Lynx.SEL.4.62.0507311149080.22444@thoron.boston.redhat.com>
	 <1122903665.6573.281.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 08:52:12 -0400
Message-Id: <1123159932.13654.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-01 at 09:41 -0400, Stephen Smalley wrote:
> - We need to improve assertion checking time (neverallow rules), as it
> is significantly slowed by the lack of an expanded avtab.

This patch modifies the assertion checking code to expand the avtabs
prior to checking the assertions, leveraging the expand_avtab function
that was added by the prior patch to provide compatibility support for
writing older binary policy versions.  This appears to eliminate the
performance penalty introduced by the earlier patches for assertion
checking.

--- libsepol.a/src/assertion.c	2005-07-28 14:48:44.000000000 -0400
+++ libsepol/src/assertion.c	2005-08-04 07:47:31.000000000 -0400
@@ -82,49 +82,31 @@ static char *av_to_string(policydb_t *po
 
 /* These should probably return the error to the caller but it may get very long
    when there are lots of assertion violations, may try to fix this later */
-static int check_assertion_helper(policydb_t *p, unsigned int stype, unsigned int ttype,
-        class_perm_node_t *perm, unsigned long line)
+static int check_assertion_helper(policydb_t *p, 
+				  avtab_t *te_avtab, avtab_t *te_cond_avtab,
+				  unsigned int stype, unsigned int ttype,
+				  class_perm_node_t *perm, unsigned long line)
 {
         avtab_key_t avkey;
-        class_perm_node_t *curperm;
 	avtab_ptr_t node;
-	ebitmap_t *sattr, *tattr;
-	ebitmap_node_t *snode, *tnode;
-	unsigned int i, j;
+        class_perm_node_t *curperm;
 
 	for (curperm = perm; curperm != NULL; curperm = curperm->next) { 
+		avkey.source_type = stype + 1;
+		avkey.target_type = ttype + 1;
                 avkey.target_class = curperm->class;
 		avkey.specified = AVTAB_ALLOWED;
-		sattr = &p->type_attr_map[stype];
-		tattr = &p->type_attr_map[ttype];
-		for (i = ebitmap_startbit(sattr), 
-			     snode = ebitmap_startnode(sattr);
-		     i < ebitmap_length(sattr); 
-		     i = ebitmap_nextbit(sattr, &snode, i)) {
-			if (!ebitmap_node_get_bit(sattr, snode, i))
-				continue;
-			for (j = ebitmap_startbit(tattr), 
-				     tnode = ebitmap_startnode(tattr); 
-			     j < ebitmap_length(tattr); 
-			     j = ebitmap_nextbit(tattr, &tnode, j)) {
-				if (!ebitmap_node_get_bit(tattr, tnode, j))
-					continue;
-				avkey.source_type = i + 1;
-				avkey.target_type = j + 1;
-				for (node = avtab_search_node(&p->te_avtab, &avkey);
-				     node != NULL;
-				     node = avtab_search_node_next(node, avkey.specified)) {
-					if (node->datum.data & curperm->data)
-						goto err;
-				}
-
-				for (node = avtab_search_node(&p->te_cond_avtab, &avkey);
-				     node != NULL;
-				     node = avtab_search_node_next(node, avkey.specified)) {
-					if (node->datum.data & curperm->data)
-						goto err;
-				}
-			}
+		for (node = avtab_search_node(te_avtab, &avkey);
+		     node != NULL;
+		     node = avtab_search_node_next(node, avkey.specified)) {
+			if (node->datum.data & curperm->data)
+				goto err;
+		}
+		for (node = avtab_search_node(te_cond_avtab, &avkey);
+		     node != NULL;
+		     node = avtab_search_node_next(node, avkey.specified)) {
+			if (node->datum.data & curperm->data)
+				goto err;
 		}
 	}
 
@@ -141,9 +123,25 @@ err:
 int check_assertions(policydb_t *p, avrule_t *avrules)
 {
         avrule_t *a;
+	avtab_t te_avtab, te_cond_avtab;
         unsigned int i, j;
 	int errors = 0;
 
+	if (avrules) {
+		if (avtab_init(&te_avtab))
+			goto oom;
+		if (avtab_init(&te_cond_avtab)) {
+			avtab_destroy(&te_avtab);
+			goto oom;
+		}
+		if (expand_avtab(p, &p->te_avtab, &te_avtab) ||
+		    expand_avtab(p, &p->te_cond_avtab, &te_cond_avtab)) {
+			avtab_destroy(&te_avtab);
+			avtab_destroy(&te_cond_avtab);
+			goto oom;
+		}
+	}
+
 	for (a = avrules; a != NULL; a = a->next) {
                 if (!(a->specified & AVRULE_NEVERALLOW))
        			continue; 
@@ -155,13 +153,13 @@ int check_assertions(policydb_t *p, avru
                         if (!ebitmap_get_bit(&a->stypes.types, i))
                                 continue;
                         if (a->flags & RULE_SELF) {
-                                if (check_assertion_helper(p, i, i, a->perms, a->line))
+				if (check_assertion_helper(p, &te_avtab, &te_cond_avtab, i, i, a->perms, a->line))
                                         errors++;
                         }
                         for (j = ebitmap_startbit(&a->ttypes.types); j < ebitmap_length(&a->ttypes.types); j++) {
                                 if (!ebitmap_get_bit(&a->ttypes.types, j))
                                         continue;
-                                if (check_assertion_helper(p, i, j, a->perms, a->line))
+                                if (check_assertion_helper(p, &te_avtab, &te_cond_avtab, i, j, a->perms, a->line))
                                     errors++;
                         }
                 }
@@ -173,4 +171,8 @@ int check_assertions(policydb_t *p, avru
 	}
 
         return 0;
+
+oom:
+    fprintf(stderr, "Out of memory - unable to check assertions\n");	
+    return -1;
 }

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
