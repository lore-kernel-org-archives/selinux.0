Message-Id: <200506281541.j5SFfQqc029318@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Frank Mayer'" <mayerf@tresys.com>
Cc: <ivg2@cornell.edu>, "'James Morris'" <jmorris@redhat.com>,
   <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: RE: file contexts and modularity
Date: Tue, 28 Jun 2005 11:41:25 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1119638453.12865.128.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Stephen Smalley
> Sent: Friday, June 24, 2005 2:41 PM
> To: Frank Mayer
> Cc: 'Karl MacMillan'; ivg2@cornell.edu; 'James Morris'; selinux@tycho.nsa.gov;
> 'Daniel J Walsh'
> Subject: RE: file contexts and modularity
> 
> > If we go ahead and keep attributes around (as we have in the loadable module
> > work), then the savings can be much greater, but we'd have to study the
> > performance impacts better. The implementation changes would also be more
> > radical. For example the same sample policy above that had ~300K allow rules
> > in the binary policy had only ~27K allow rules in the source policy before
> > expansion. Some rules will expand anyway because of multiple classes, but I
> > believe most expansion is due to attribute expansion.
> 
> Yes, I think we should investigate this idea, despite its impact on the
> existing code, as it should significantly reduce the number of avtab
> nodes.
> 

I went ahead and investigated this a little empirically. I horribly hacked
checkpolicy to not expand attributes on avtab insertion and then compared the
number of nodes generated with this and a non-hacked compiler using the latest
FC4 strict policy. Results:

attributes inserted: 33473
attributes expanded: 402196

Obviously this would be quite an improvement. Out of curiosity, I also looked at
datum usage - i.e., how many of the 3 datums were used on average. Single means
single datum (e.g., there was only an allow rule), double means two (e.g. there
was an allow and an auditallow), etc. Results:

attributes inserted: single: 33473 double: 2943 triple: 0
attributes expanded: single: 381570 double: 20626 triple: 0

The lack of triple made me wonder whether the packing was in fact working - it
is not that surprising, but it is suspicious. So I created a small test case and
verified that it is possible to use all three datums by inserting and allow,
dontaudit, and auditallow with the same keys (not that this makes sense).

Patch below (not really useful - just a hack).

Karl
 
---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

diff -ruNp --exclude='*~' setest-2/checkpolicy/checkpolicy.c
sf-cvs/selinux-usr/checkpolicy/checkpolicy.c
--- setest-2/checkpolicy/checkpolicy.c	2005-06-28 11:25:11.000000000 -0400
+++ sf-cvs/selinux-usr/checkpolicy/checkpolicy.c	2005-06-24
13:15:38.000000000 -0400
@@ -63,7 +63,6 @@
 #include <stdio.h>
 #include <errno.h>
 #include <sys/mman.h>
-#include <assert.h>
 
 #include <sepol/policydb.h>
 #include <sepol/services.h>
@@ -450,73 +449,6 @@ int change_bool(char *name, int state)
 	return 0;
 }
 
-void compute_avtab_stats(avtab_t *a, uint32_t *du, uint32_t *ae)
-{
-	int i;
-	avtab_ptr_t cur;
-	uint32_t avtab_entries;
-	uint32_t datum_usage[3];
-	uint32_t tmp;
-	
-	avtab_entries = 0;
-	datum_usage[0] = datum_usage[1] = datum_usage[2] = 0;
-	
-	for (i = 0; i < AVTAB_SIZE; i++) {
-		cur = a->htable[i];
-		for (; cur != NULL; cur = cur->next) {
-			avtab_entries++;
-			tmp = cur->datum.specified & AVTAB_AV;
-			if (tmp) {
-				switch (tmp) {
-				case AVTAB_AV:
-					datum_usage[2]++;
-					break;
-				case AVTAB_ALLOWED:
-				case AVTAB_AUDITALLOW:
-				case AVTAB_AUDITDENY:
-					datum_usage[0]++;
-					break;
-				default:
-					datum_usage[1]++;
-				}
-			} else {
-				switch (tmp) {
-				case AVTAB_TYPE:
-					datum_usage[2]++;
-					break;
-				case AVTAB_TRANSITION:
-				case AVTAB_MEMBER:
-				case AVTAB_CHANGE:
-					datum_usage[0]++;
-					break;
-				default:
-					datum_usage[1]++;
-				}
-			}
-		}
-	}
-	
-	*ae += avtab_entries;
-	du[0] += datum_usage[0];
-	du[1] += datum_usage[1];
-	du[2] += datum_usage[2];
-}
-
-void compute_stats(policydb_t *p)
-{
-	uint32_t avtab_entries;
-	uint32_t datum_usage[3];
-	
-	avtab_entries = 0;
-	datum_usage[0] = datum_usage[1] = datum_usage[2] = 0;
-	
-	compute_avtab_stats(&p->te_avtab, datum_usage, &avtab_entries);
-	compute_avtab_stats(&p->te_cond_avtab, datum_usage, &avtab_entries);
-	
-	printf("number entries: %d using %f mb\n", avtab_entries,
((((float)avtab_entries) * sizeof(struct avtab_node)) / 1024) / 1024);
-	printf("single: %d double: %d triple: %d\n", datum_usage[0],
datum_usage[1], datum_usage[2]);
-}
-
 int main(int argc, char **argv)
 {
 	sepol_security_class_t tclass;
@@ -683,7 +615,7 @@ int main(int argc, char **argv)
 		cond_check_type_rules();
 		cond_optimize_lists(policydb.cond_list);
 
-		//check_assertions();
+		check_assertions();
 		if (policydb_errors) 
 			exit(1);
 
@@ -692,12 +624,11 @@ int main(int argc, char **argv)
 			fprintf(stderr, "%s:  policy lacks new netlink classes,
unable to generate policy version %d\n", argv[0], policyvers);
 			exit(1);
 		}
-#if 0
+
 		if (hierarchy_check_constraints(&policydb, error_msg,
sizeof(error_msg))) {
 			fprintf(stderr, "%s\n", error_msg);
 			exit(1);
 		}
-#endif
 
 		/* remove type attributes */
 		hashtab_map_remove_on_error(policydb.p_types.table, 
@@ -710,7 +641,6 @@ int main(int argc, char **argv)
 		exit(1);
 
 	printf("%s:  policy configuration loaded\n", argv[0]);
-	compute_stats(&policydb);
 
 	if (outfile) {
 		printf("%s:  writing binary representation (version %d) to
%s\n",
diff -ruNp --exclude='*~' setest-2/checkpolicy/policy_parse.y
sf-cvs/selinux-usr/checkpolicy/policy_parse.y
--- setest-2/checkpolicy/policy_parse.y	2005-06-28 11:38:33.000000000 -0400
+++ sf-cvs/selinux-usr/checkpolicy/policy_parse.y	2005-06-24
13:15:38.000000000 -0400
@@ -1493,7 +1493,6 @@ static int define_attrib(void)
 	}
 	memset(attr, 0, sizeof(type_datum_t));
 	attr->isattr = TRUE;
-	attr->value = ++policydbp->p_types.nprim;
 	ret = hashtab_insert(policydbp->p_types.table,
 			     id, (hashtab_datum_t) attr);
 	if (ret) {
@@ -1822,7 +1821,7 @@ static int set_types(ebitmap_t *set,
 		free(id);
 		return -1;
 	}
-#if 0
+
 	if (t->isattr) {
 		/* set or clear all types with this attribute,
 		   but do not set anything explicitly cleared previously */
@@ -1843,7 +1842,6 @@ static int set_types(ebitmap_t *set,
 			}
 		}
 	} else {
-#endif
 		/* set or clear one type, but do not set anything
 		   explicitly cleared previously */	
 		if (!(*add)) {
@@ -1857,9 +1855,7 @@ static int set_types(ebitmap_t *set,
 			yywarn(errormsg);
 #endif
 		}
-#if 0
 	}
-#endif
 
 	free(id);
 	*add = 1;

> --
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
