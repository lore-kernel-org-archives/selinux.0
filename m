Subject: [PATCH] introduce schedule points in policydb_destroy()
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Mon, 04 Jun 2007 17:41:22 -0400
Message-Id: <1180993282.3950.79.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

During the LSPP testing we found that it was possible for
policydb_destroy() to take 10+ seconds of kernel time to complete.
Basically all policydb_destroy() does is walk some (possibly long) lists
and free the memory it finds.  Turning off slab debugging config options
made the problem go away since the actual functions which took most of
the time were (as seen by oprofile)

> 121202   23.9879  .check_poison_obj
> 78247    15.4864  .check_slabp

were caused by that.  So I decided to also add some voluntary schedule
points in that code so config voluntary preempt would be enough to solve
the problem.  Something similar was done in places like
shmem_free_pages() when we have to walk a list of memory and free it.
This was tested by the LSPP group on the hardware which could reproduce
the problem just loading a new policy and was found to not trigger the
softlock detector.  It takes just as much processing time, but the
kernel doesn't spend all that time stuck doing one thing and never
scheduling.

Someday a better way to handle memory might make the time needed in this
function a lot less, but this fixes the current issue as it stands
today.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 security/selinux/ss/policydb.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 0ac1021..f05f97a 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/errno.h>
@@ -598,6 +599,7 @@ void policydb_destroy(struct policydb *p)
 	struct range_trans *rt, *lrt = NULL;
 
 	for (i = 0; i < SYM_NUM; i++) {
+		cond_resched();
 		hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
 		hashtab_destroy(p->symtab[i].table);
 	}
@@ -612,6 +614,7 @@ void policydb_destroy(struct policydb *p)
 	avtab_destroy(&p->te_avtab);
 
 	for (i = 0; i < OCON_NUM; i++) {
+		cond_resched();
 		c = p->ocontexts[i];
 		while (c) {
 			ctmp = c;
@@ -623,6 +626,7 @@ void policydb_destroy(struct policydb *p)
 
 	g = p->genfs;
 	while (g) {
+		cond_resched();
 		kfree(g->fstype);
 		c = g->head;
 		while (c) {
@@ -639,18 +643,21 @@ void policydb_destroy(struct policydb *p)
 	cond_policydb_destroy(p);
 
 	for (tr = p->role_tr; tr; tr = tr->next) {
+		cond_resched();
 		kfree(ltr);
 		ltr = tr;
 	}
 	kfree(ltr);
 
 	for (ra = p->role_allow; ra; ra = ra -> next) {
+		cond_resched();
 		kfree(lra);
 		lra = ra;
 	}
 	kfree(lra);
 
 	for (rt = p->range_tr; rt; rt = rt -> next) {
+		cond_resched();
 		if (lrt) {
 			ebitmap_destroy(&lrt->target_range.level[0].cat);
 			ebitmap_destroy(&lrt->target_range.level[1].cat);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
