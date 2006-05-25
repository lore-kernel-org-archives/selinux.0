Subject: Re: Bugs with bool_ids usage (libsepol)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Cedric Roux <Cedric.Roux@eurecom.fr>, selinux@tycho.nsa.gov
In-Reply-To: <1147283537.22880.52.camel@jackjack.columbia.tresys.com>
References: <Pine.LNX.4.44.0605101702540.19909-100000@perignan.eurecom.fr>
	 <1147283537.22880.52.camel@jackjack.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 11:06:55 -0400
Message-Id: <1148569615.20976.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-10 at 13:52 -0400, Karl MacMillan wrote:
> On Wed, 2006-05-10 at 17:17 +0200, Cedric Roux wrote:
> > Dear SELinux people,
> > 
> > there is a bug with the way you handle bool_ids in libsepol.
> > For example, we see this code:
> >         for (i = 0; i < needle->nbools; i++)
> >                 new_node->bool_ids[i] = needle->bool_ids[i];
> > in libsepol-1.12/src/conditional.c:cond_node_find
> > The only problem is that bool_ids is defined as:
> >         uint32_t bool_ids[COND_MAX_BOOLS];
> > with:
> > #define COND_MAX_BOOLS 5
> > in libsepol-1.12/include/sepol/policydb/conditional.h
> > 
> > But we have that nbools may be bigger than COND_MAX_BOOLS.
> > That would result in a funny behavior if someone somewhere
> > on this little planet decided to put more than COND_MAX_BOOLS
> > boolean variables in an if statement, don't you think?
> > 
> > I tried to do some tests.
> > 
> > With something like (manipulating policy.conf from refpolicy):
> >     if (ftpd_is_daemon && secure_mode && secure_mode_insmod && 
> >         allow_cvs_read_shadow && allow_execmem && allow_kerberos && 
> >         allow_smbd_anon_write && allow_ypbind && allow_execmod) {
> >            DO_SOMETHING
> >     }
> > checkpolicy crashes on a malloc (so I need 9 boolean variables for a
> > malloc to be very unhappy with the state of the heap).
> > 
> > You should do something about this I think.
> > 
> > I didn't get the point with the bool_ids yet, so I don't know
> > how to fix that. Maybe do something like:
> >         for (i = 0; i < min(needle->nbools, COND_MAX_BOOLS); i++)
> > is the solution, maybe not. It's up to you!
> > 
> > Anyway you will need to check every usage of bool_ids.
> > 
> 
> Thanks for the bug report. The code in question is making an incorrect
> assumption about what COND_MAX_BOOLS is used for. That vaguely named
> define is not intended to limit the number of unique booleans in a
> conditional expression. The only limit in conditional expressions should
> be the stack depth.
> 
> I should be able to get a patch to fix this out sometime soon.

Patch below has been committed to the selinux sourceforge tree.

Index: libsepol/src/conditional.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/conditional.c,v
retrieving revision 1.15
diff -u -p -r1.15 conditional.c
--- libsepol/src/conditional.c	5 May 2006 18:54:47 -0000	1.15
+++ libsepol/src/conditional.c	25 May 2006 13:36:41 -0000
@@ -26,6 +26,8 @@
 
 #include "private.h"
 
+#undef min
+#define min(a,b) (((a) < (b)) ? (a) : (b))
 
 /* move all type rules to top of t/f lists to help kernel on evaluation */
 static void cond_optimize(cond_av_list_t **l) {
@@ -155,7 +157,7 @@ cond_node_t *cond_node_find(policydb_t *
 	}
         new_node->cur_state = cond_evaluate_expr(p, new_node->expr);
         new_node->nbools = needle->nbools;
-        for (i = 0; i < needle->nbools; i++)
+        for (i = 0; i < min(needle->nbools, COND_MAX_BOOLS); i++)
                 new_node->bool_ids[i] = needle->bool_ids[i];
         new_node->expr_pre_comp = needle->expr_pre_comp;
         new_node->true_list = NULL;
Index: libsepol/src/link.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/link.c,v
retrieving revision 1.18
diff -u -p -r1.18 link.c
--- libsepol/src/link.c	28 Apr 2006 18:34:46 -0000	1.18
+++ libsepol/src/link.c	25 May 2006 13:36:23 -0000
@@ -33,6 +33,9 @@
 
 #include "debug.h"
 
+#undef min
+#define min(a,b) (((a) < (b)) ? (a) : (b))
+
 typedef struct policy_module {
         policydb_t *policy;
         uint32_t num_decls;
@@ -1017,7 +1020,7 @@ static int copy_cond_list(cond_node_t *l
                         cur_expr->bool = module->map[SYM_BOOLS][cur_expr->bool - 1];
                 }
                 new_node->nbools = cur->nbools;
-                for (i = 0; i < cur->nbools; i++) {
+                for (i = 0; i < min(cur->nbools, COND_MAX_BOOLS); i++) {
                         uint32_t remapped_id = module->map[SYM_BOOLS][cur->bool_ids[i] - 1];
                         assert(remapped_id != 0);
                         new_node->bool_ids[i] = remapped_id;


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
