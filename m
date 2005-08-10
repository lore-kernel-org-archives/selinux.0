Subject: Re: checkpolicy constraints bug
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1123687001.3018.72.camel@moss-spartans.epoch.ncsc.mil>
References: <200508102332.48483.russell@coker.com.au>
	 <1123687001.3018.72.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-4VI1pyPZtQ+fiOJ3Ujom"
Date: Wed, 10 Aug 2005 13:49:44 -0400
Message-Id: <1123696184.3018.126.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-4VI1pyPZtQ+fiOJ3Ujom
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-08-10 at 11:16 -0400, Stephen Smalley wrote:
> On Wed, 2005-08-10 at 23:32 +1000, Russell Coker wrote:
> > constrain process transition
> >       ( r1 == r2 or ( t1 == privrole and t2 == userdomain )
> > ifdef(`crond.te', `
> >          or (t1 == crond_t and t2 == user_crond_domain)
> > ')
> > ifdef(`userhelper.te',
> >       `or (t1 == userhelperdomain)')
> > ifdef(`postfix.te', `
> > ifdef(`direct_sysadm_daemon',
> >       `or (t1 == sysadm_mail_t and t2 == system_mail_t and r2 == system_r )')
> > ')
> >        or (t1 == priv_system_role and r2 == system_r )
> >         );
> > 
> > 
> > The above section in the constraints file for the strict policy works with 
> > checkpolicy version 1.23.1-1 (FC4 release) but fails with 1.25.3-1 (latest 
> > rawhide).
> 
> Yes, reproduced it here as well.  Looks like a bug in the module
> expansion code for constraint sets.  I have a patch in testing now.

Ok, I believe that the patch below fixes this bug; the constraint
expansion code was erroneously clobbering non-type sets and leading to a
failure of the last clause of the constraint, preventing the transition.
This is being committed to libsepol 1.7.12, and checkpolicy will require
a rebuild since it links with the static lib.

-- 
Stephen Smalley
National Security Agency

--=-4VI1pyPZtQ+fiOJ3Ujom
Content-Disposition: attachment; filename=libsepol-fixconstraint.patch
Content-Type: text/x-patch; name=libsepol-fixconstraint.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libsepol/ChangeLog
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/ChangeLog,v
retrieving revision 1.43
retrieving revision 1.44
diff -u -p -r1.43 -r1.44
--- libsepol/ChangeLog	8 Aug 2005 13:56:09 -0000	1.43
+++ libsepol/ChangeLog	10 Aug 2005 17:36:37 -0000	1.44
@@ -1,3 +1,6 @@
+1.7.12 2004-08-10
+	* Fixed bug in constraint_node_clone handling of name sets.
+
 1.7.11 2004-08-08
 	* Fix range_trans_clone to map the type values properly.
 
Index: libsepol/VERSION
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/VERSION,v
retrieving revision 1.38
retrieving revision 1.39
diff -u -p -r1.38 -r1.39
--- libsepol/VERSION	8 Aug 2005 13:56:09 -0000	1.38
+++ libsepol/VERSION	10 Aug 2005 17:36:37 -0000	1.39
@@ -1 +1 @@
-1.7.11
+1.7.12
Index: libsepol/libsepol.spec
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/libsepol.spec,v
retrieving revision 1.40
retrieving revision 1.41
diff -u -p -r1.40 -r1.41
--- libsepol/libsepol.spec	8 Aug 2005 13:56:09 -0000	1.40
+++ libsepol/libsepol.spec	10 Aug 2005 17:36:37 -0000	1.41
@@ -1,6 +1,6 @@
 Summary: SELinux binary policy manipulation library 
 Name: libsepol
-Version: 1.7.11
+Version: 1.7.12
 Release: 1
 License: LGPL
 Group: System Environment/Libraries
Index: libsepol/include/sepol/constraint.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/include/sepol/constraint.h,v
retrieving revision 1.4
retrieving revision 1.5
diff -u -p -r1.4 -r1.5
--- libsepol/include/sepol/constraint.h	6 Jul 2005 17:24:49 -0000	1.4
+++ libsepol/include/sepol/constraint.h	10 Aug 2005 17:36:39 -0000	1.5
@@ -72,8 +72,6 @@ struct policydb;
 
 extern int constraint_expr_init(constraint_expr_t *expr);
 extern void constraint_expr_destroy(constraint_expr_t *expr);
-extern int expand_constraint(constraint_expr_t *expr, constraint_expr_t *dest_expr,
-                             uint32_t *typemap, struct policydb *pol);
 
 #endif	/* _CONSTRAINT_H_ */
 
Index: libsepol/src/constraint.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/constraint.c,v
retrieving revision 1.3
retrieving revision 1.4
diff -u -p -r1.3 -r1.4
--- libsepol/src/constraint.c	2 Aug 2005 18:32:14 -0000	1.3
+++ libsepol/src/constraint.c	10 Aug 2005 17:36:40 -0000	1.4
@@ -35,49 +35,3 @@ void constraint_expr_destroy(constraint_
         }
 }
 
-static int expand_constraint_bit(constraint_expr_t *expr __attribute__ ((unused)), constraint_expr_t *dest_expr,
-                                 int bit, uint32_t *typemap) {
-        if (typemap != NULL) {
-                if (ebitmap_set_bit(&dest_expr->names, typemap[bit] - 1, 1)) {
-                        return -1;
-                }
-        }
-        else {
-                if (ebitmap_set_bit(&dest_expr->names, bit, 1)) {
-                        return -1;
-                }
-        }
-        return 0;
-}
-
-int expand_constraint(constraint_expr_t *expr __attribute__ ((unused)), constraint_expr_t *dest_expr,
-                      uint32_t *typemap, policydb_t *pol) {
-         ebitmap_t e;
-         unsigned int i, j;
-         if (type_set_expand(expr->type_names, &e, pol)) {
-                 ebitmap_destroy(&e);
-                 return -1;
-         }
-         for (i = ebitmap_startbit(&e); i < ebitmap_length(&e); i++) {
-                 if (!ebitmap_get_bit(&e, i))
-                         continue;
-                 if (pol->type_val_to_struct[i]->isattr) {
-                         ebitmap_t *attr = &pol->type_val_to_struct[i]->types;
-                         for (j = ebitmap_startbit(attr); j < ebitmap_length(attr); j++) {
-                                 if (ebitmap_get_bit(attr, j) &&
-                                     expand_constraint_bit(expr, dest_expr, j, typemap)) {
-                                         ebitmap_destroy(&e);
-                                         return -1;
-                                 }
-                         }
-                 }
-                 else {
-                         if (expand_constraint_bit(expr, dest_expr, i, typemap)) {
-                                 ebitmap_destroy(&e);
-                                 return -1;
-                         }
-                 }
-         }
-         ebitmap_destroy(&e);
-         return 0;
-}
Index: libsepol/src/expand.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/expand.c,v
retrieving revision 1.3
retrieving revision 1.4
diff -u -p -r1.3 -r1.4
--- libsepol/src/expand.c	8 Aug 2005 13:56:11 -0000	1.3
+++ libsepol/src/expand.c	10 Aug 2005 17:36:40 -0000	1.4
@@ -230,31 +230,22 @@ static int constraint_node_clone(constra
         		new_expr->expr_type = expr->expr_type;
         		new_expr->attr = expr->attr;
         		new_expr->op = expr->op;
-                        /* If the constraint expression indicates a
-                           type name, remap the corresponding 'names'
-                           bitmap from old to new by way of the
-                           typemap.  Note that if a name is actually
-                           an attribute, one needs to remap the
-                           /components/ of that attribute as well. */
         		if (new_expr->expr_type == CEXPR_NAMES) {
                                 if (new_expr->attr & CEXPR_TYPE) {
-                                        if (expand_constraint(expr, new_expr,
-                                                              state->typemap, state->base)) {
-                                                goto out_of_mem;
-                                        }
-                                }
-                                else {
-                                        if (ebitmap_union(&new_expr->names,
-                                                           &expr->names)) {
+					/* Type sets require expansion and conversion. */
+					if (expand_convert_type_set(state->base,
+								    state->typemap,
+								    expr->type_names,
+								    &new_expr->names)) {
+						goto out_of_mem;
+					}
+				} else {
+					/* Other kinds of sets do not. */
+                                        if (ebitmap_cpy(&new_expr->names,
+							&expr->names)) {
                                                 goto out_of_mem;
                                         }
                                 }
-                                if (expand_convert_type_set(state->base,
-                                                            state->typemap,
-                                                            expr->type_names,
-                                                            &new_expr->names)) {
-                                        goto out_of_mem;
-        			}
         		}
         		if (expr_l) {
         			expr_l->next = new_expr;

--=-4VI1pyPZtQ+fiOJ3Ujom--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
