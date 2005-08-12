Subject: [patch 1/2] Fix memory leaks in libsepol/checkpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Joshua Brindle <jbrindle@tresys.com>
Content-Type: text/plain
Date: Fri, 12 Aug 2005 16:38:57 -0400
Message-Id: <1123879137.23483.117.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These patches fix some memory leaks in libsepol and checkpolicy detected
by valgrind.  To help detect such leaks, I changed checkpolicy to free
the policydbs prior to exit rather than just letting exit handle the
final release of memory.  This required altering checkpolicy to avoid
pointer aliasing for the constraint expressions to allow
policydb_destroy to work cleanly.  I haven't finished tracking down all
of the memory leaks reported by valgrind yet, so this is just a start.

The first patch fixes several leaks in libsepol, including:
- leak of temporary expanded avtabs used for assertion checking
(possibly should be saved in the policydb for re-use with the hierarchy
checking code and write compatibility code),
- leak of avrules in various places (avrule_destroy doesn't free them),
- leak in policydb_index_classes upon multiple calls to it

 src/assertion.c |    6 +++++-
 src/link.c      |    1 +
 src/policydb.c  |    8 +++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

Index: libsepol/src/assertion.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/assertion.c,v
retrieving revision 1.2
diff -u -p -r1.2 assertion.c
--- libsepol/src/assertion.c	11 Aug 2005 15:43:14 -0000	1.2
+++ libsepol/src/assertion.c	12 Aug 2005 20:06:58 -0000
@@ -170,10 +170,14 @@ int check_assertions(policydb_t *p, avru
         }
 
 	if (errors) {
-		fprintf(stderr, "%d assertion violations occured\n", errors);	
+		fprintf(stderr, "%d assertion violations occured\n", errors);
+		avtab_destroy(&te_avtab);
+		avtab_destroy(&te_cond_avtab);
 		return -1;
 	}
 
+	avtab_destroy(&te_avtab);
+	avtab_destroy(&te_cond_avtab);
         return 0;
 
 oom:
Index: libsepol/src/link.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/link.c,v
retrieving revision 1.3
diff -u -p -r1.3 link.c
--- libsepol/src/link.c	11 Aug 2005 15:43:15 -0000	1.3
+++ libsepol/src/link.c	12 Aug 2005 19:24:59 -0000
@@ -915,6 +915,7 @@ static int copy_avrule_list(avrule_t *li
  cleanup:
         write_error(state, "Out of memory!");
         avrule_destroy(new_rule);
+	free(new_rule);
         return -1;
 }
 
Index: libsepol/src/policydb.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/policydb.c,v
retrieving revision 1.22
diff -u -p -r1.22 policydb.c
--- libsepol/src/policydb.c	12 Aug 2005 19:02:12 -0000	1.22
+++ libsepol/src/policydb.c	12 Aug 2005 20:04:23 -0000
@@ -321,6 +321,7 @@ void avrule_list_destroy(avrule_t *x)
                 cur = next;
                 next = next->next;
                 avrule_destroy(cur);
+		free(cur);
         }
 }
 
@@ -604,6 +605,7 @@ static int (*index_f[SYM_NUM]) (hashtab_
  */
 int policydb_index_classes(policydb_t * p)
 {
+	free(p->p_common_val_to_name);
 	p->p_common_val_to_name = (char **)
 	    malloc(p->p_commons.nprim * sizeof(char *));
 	if (!p->p_common_val_to_name)
@@ -612,11 +614,13 @@ int policydb_index_classes(policydb_t * 
 	if (hashtab_map(p->p_commons.table, common_index, p))
 		return -1;
 
+	free(p->class_val_to_struct);
 	p->class_val_to_struct = (class_datum_t **)
 	    malloc(p->p_classes.nprim * sizeof(class_datum_t *));
 	if (!p->class_val_to_struct)
 		return -1;
 
+	free(p->p_class_val_to_name);
 	p->p_class_val_to_name = (char **)
 	    malloc(p->p_classes.nprim * sizeof(char *));
 	if (!p->p_class_val_to_name)
@@ -2037,8 +2041,10 @@ static avrule_t *avrule_read(policydb_t 
 
         return avrule;
 bad:
-        if (avrule)
+        if (avrule) {
                 avrule_destroy(avrule);
+		free(avrule);
+	}
         return NULL;
 }
 



-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
