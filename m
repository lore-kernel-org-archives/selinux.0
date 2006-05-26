Date: Fri, 26 May 2006 11:03:56 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, SELinux-dev@tresys.com,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: libsepol and libselinux patches
Message-ID: <20060526160356.GC13467@sergelap.austin.ibm.com>
References: <20060523154424.GA13237@sergelap> <1148499826.24463.533.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1148499826.24463.533.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > --- libsepol/src/policydb.c.orig	2006-05-23 07:48:58.000000000 -0500
> > +++ libsepol/src/policydb.c	2006-05-23 08:36:50.000000000 -0500
> > @@ -1435,22 +1435,28 @@ static int read_cons_helper(policydb_t *
> >  		if (!c)
> >  			return -1;
> >  		buf = next_entry(fp, (sizeof(uint32_t) * 2));
> > -		if (!buf)
> > +		if (!buf) {
> > +			free(c);
> >  			return -1;
> > +		}
> This can be done more cleanly by linking c into the list early, and then
> just relying on policydb_destroy() by the caller to clean it up, as with
> much of the cleanup on failed policydb_read().  That appears to already
> be the case in the kernel code.

Ok, the appended patch takes the same approach as in the kernel,
extending this to the le links as well.

> > @@ -1949,23 +1963,23 @@ static int genfs_read (policydb_t *p, st
> >                          }
> >                          buf = next_entry(fp, sizeof(uint32_t));
> >                          if (!buf)
> > -                                goto bad;
> > +                                goto bad_freenewc;
> 
> I'd think we could do this in the same way (link newc early, along with
> its parent), although the kernel code appears to instead jump to an
> error path that uses an ocontext_destroy() helper to handle all cases.
> 
> > +bad_context:
> > +	context_destroy(&newc->context[0]);
> > +bad_freename:
> > +	free(newc->u.name);
> > +bad_freenewc:
> > +	free(newc);
> These could be collapsed into a single error path, right?  Initial
> calloc will put it into a valid state for all of this cleanup?

Ah, yes, ok, appended patch fixes that up.

> 
> > @@ -2461,14 +2481,17 @@ static int avrule_block_read(policydb_t 
> >                  num_decls = le32_to_cpu(buf[0]);
> >                  while (num_decls > 0) {
> >                          if ((curdecl = avrule_decl_create(0)) == NULL) {
> > +				free(curblock);
> >                                  return -1;
> >                          }
> 
> Appears to miss the prior next_entry() error path, and we need to do

Hmm.  Well my .c file didn't :)  I must have made the '.c.orig' backup
after I started fixing it up.

> more here since we may now have linked avrule_decl's into the block.
> avrule_block_destroy(), maybe.
> 
> >                          if (avrule_decl_read(p, curdecl, num_scope_syms, fp) == -1) {
> > +				free(curblock);
> >                                  return -1;
> >                          }
> 
> Need to deal with the allocated decl (avrule_decl_destroy?) and then the
> entire chain from the block.
> 
> >                          if (curdecl->enabled) {
> >                                  if (curblock->enabled != NULL) {
> >                                          /* probably a corrupt file */
> > +					free(curblock);
> >                                          return -1;
> >                                  }
> 
> Same issue.

Ok, I believe the following patch addresses the above.  The decl chain
should be handled by the avrule_block_list_destroy, so i think i'm
freeing everything at this point.

thanks,
-serge

--- policydb.c.orig	2006-05-26 09:42:50.000000000 -0500
+++ policydb.c	2006-05-26 10:32:01.000000000 -0500
@@ -1434,6 +1434,11 @@
 		c = calloc(1, sizeof(constraint_node_t));
 		if (!c)
 			return -1;
+
+		if (lc)
+			lc->next = c;
+		else
+			*nodep = c;
 		buf = next_entry(fp, (sizeof(uint32_t) * 2));
 		if (!buf)
 			return -1;
@@ -1449,76 +1454,54 @@
                                 free(e);
                                 return -1;
                         }
+			if (le) {
+				le->next = e;
+			} else {
+				c->expr = e;
+			}
+
 			buf = next_entry(fp, (sizeof(uint32_t) * 3));
-			if (!buf) {
-                                constraint_expr_destroy(e);
+			if (!buf)
 				return -1;
-			}
 			e->expr_type = le32_to_cpu(buf[0]);
 			e->attr = le32_to_cpu(buf[1]);
 			e->op = le32_to_cpu(buf[2]);
 
 			switch (e->expr_type) {
 			case CEXPR_NOT:
-				if (depth < 0) {
-					constraint_expr_destroy(e);
+				if (depth < 0)
 					return -1;
-				}
 				break;
 			case CEXPR_AND:
 			case CEXPR_OR:
-				if (depth < 1) {
-					constraint_expr_destroy(e);
+				if (depth < 1)
 					return -1;
-				}
 				depth--;
 				break;
 			case CEXPR_ATTR:
-				if (depth == (CEXPR_MAXDEPTH-1)) {
-					constraint_expr_destroy(e);
+				if (depth == (CEXPR_MAXDEPTH-1))
 					return -1;
-				}
 				depth++;
 				break;
 			case CEXPR_NAMES:
-				if (!allowxtarget && (e->attr & CEXPR_XTARGET)) {
-					constraint_expr_destroy(e);
+				if (!allowxtarget && (e->attr & CEXPR_XTARGET))
 					return -1;
-				}
-				if (depth == (CEXPR_MAXDEPTH-1)) {
-					constraint_expr_destroy(e);
+				if (depth == (CEXPR_MAXDEPTH-1))
 					return -1;
-				}
 				depth++;
-				if (ebitmap_read(&e->names, fp)) {
-					constraint_expr_destroy(e);
+				if (ebitmap_read(&e->names, fp))
 					return -1;
-				}
                                 if (p->policy_type != POLICY_KERN &&
-                                    type_set_read(e->type_names, fp)) {
-					constraint_expr_destroy(e);
+                                    type_set_read(e->type_names, fp))
                                         return -1;
-                                }
 				break;
 			default:
-                                constraint_expr_destroy(e);
 				return -1;
-				break;
-			}
-			if (le) {
-				le->next = e;
-			} else {
-				c->expr = e;
 			}
 			le = e;
 		}
 		if (depth != 0)
 			return -1;
-		if (lc) {
-			lc->next = c;
-		} else {
-			*nodep = c;
-		}
 		lc = c;
 	}
 
@@ -1898,7 +1881,7 @@
         size_t nel, nel2, len, len2;
         genfs_t *genfs_p, *newgenfs, *genfs;
         unsigned int i, j;
-        ocontext_t *l, *c, *newc;
+        ocontext_t *l, *c, *newc = NULL;
 
         buf = next_entry(fp, sizeof(uint32_t));
         if (!buf)               
@@ -1992,6 +1975,11 @@
         return 0;
 
 bad:
+	if (newc) {
+		context_destroy(&newc->context[0]);
+		free(newc->u.name);
+		free(newc);
+	}
 	return -1;
 }
 
@@ -2455,19 +2443,31 @@
                 }
                 
                 if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
+			free(curblock);
                         return -1;
                 }
                 num_decls = le32_to_cpu(buf[0]);
                 while (num_decls > 0) {
                         if ((curdecl = avrule_decl_create(0)) == NULL) {
+				free(curblock);
+				if (*block)
+					avrule_block_list_destroy(*block);
                                 return -1;
                         }
                         if (avrule_decl_read(p, curdecl, num_scope_syms, fp) == -1) {
+				free(curblock);
+				if (*block)
+					avrule_block_list_destroy(*block);
+				avrule_decl_destroy(curdecl);
                                 return -1;
                         }
                         if (curdecl->enabled) {
                                 if (curblock->enabled != NULL) {
                                         /* probably a corrupt file */
+					free(curblock);
+					if (*block)
+						avrule_block_list_destroy(*block);
+					avrule_decl_destroy(curdecl);
                                         return -1;
                                 }
                                 curblock->enabled = curdecl;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
