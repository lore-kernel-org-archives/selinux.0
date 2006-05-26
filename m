Subject: Re: libsepol and libselinux patches
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: SELinux-dev@tresys.com, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20060526160356.GC13467@sergelap.austin.ibm.com>
References: <20060523154424.GA13237@sergelap>
	 <1148499826.24463.533.camel@moss-spartans.epoch.ncsc.mil>
	 <20060526160356.GC13467@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 26 May 2006 16:01:44 -0400
Message-Id: <1148673704.20976.273.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-26 at 11:03 -0500, Serge E. Hallyn wrote:
> Ok, I believe the following patch addresses the above.  The decl chain
> should be handled by the avrule_block_list_destroy, so i think i'm
> freeing everything at this point.
> 
> thanks,
> -serge
> 

> @@ -1898,7 +1881,7 @@
>          size_t nel, nel2, len, len2;
>          genfs_t *genfs_p, *newgenfs, *genfs;
>          unsigned int i, j;
> -        ocontext_t *l, *c, *newc;
> +        ocontext_t *l, *c, *newc = NULL;
>  
>          buf = next_entry(fp, sizeof(uint32_t));
>          if (!buf)               
> @@ -1992,6 +1975,11 @@
>          return 0;
>  
>  bad:
> +	if (newc) {
> +		context_destroy(&newc->context[0]);
> +		free(newc->u.name);
> +		free(newc);
> +	}
>  	return -1;
>  }

Hmm...we still aren't handling the potential newgenfs leak, and we can't
easily move up the linkage for it or handle it on the bad path, so see
interdiff below.

>                  while (num_decls > 0) {
>                          if ((curdecl = avrule_decl_create(0)) == NULL) {
> +				free(curblock);
> +				if (*block)
> +					avrule_block_list_destroy(*block);
>                                  return -1;
>                          }

I don't think we want this.  Assuming that the caller ultimately does a
policydb_destroy (which in the libsepol case has migrated from
policydb_read error path to the callers due to the separation of
create/init from policydb_read for the shared APIs), we don't have to
destroy what is already in the block list.  And curblock may already
have multiple decls linked into it at this point, so we need to
avrule_block_destroy it.  See interdiff below.  avrule_decl_destroy also
needs to be made non-static for this to compile.

diff -u libsepol/src/policydb.c libsepol/src/policydb.c
--- libsepol/src/policydb.c	26 May 2006 19:00:20 -0000
+++ libsepol/src/policydb.c	26 May 2006 19:02:10 -0000
@@ -1439,6 +1439,7 @@
 			lc->next = c;
 		else
 			*nodep = c;
+
 		buf = next_entry(fp, (sizeof(uint32_t) * 2));
 		if (!buf)
 			return -1;
@@ -1889,19 +1890,21 @@
         nel = le32_to_cpu(buf[0]);
         genfs_p = NULL;         
         for (i = 0; i < nel; i++) {
-                newgenfs = calloc(1, sizeof(genfs_t));
-                if (!newgenfs) {        
-                        goto bad;
-                }                       
                 buf = next_entry(fp, sizeof(uint32_t));
                 if (!buf)       
                         goto bad;
                 len = le32_to_cpu(buf[0]);
+                newgenfs = calloc(1, sizeof(genfs_t));
+                if (!newgenfs)
+                        goto bad;
                 buf = next_entry(fp, len);
-                if (!buf)       
+                if (!buf) {
+			free(newgenfs);
                         goto bad;
+		}
                 newgenfs->fstype = malloc(len + 1);
                 if (!newgenfs->fstype) {
+			free(newgenfs);
                         goto bad;
                 }       
                 memcpy(newgenfs->fstype, buf, len);
@@ -1911,6 +1914,8 @@
                         if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
 				ERR(fp->handle, "dup genfs fstype %s", 
 					newgenfs->fstype);
+				free(newgenfs->fstype);
+				free(newgenfs);
                                 goto bad;
                         }       
                         if (strcmp(newgenfs->fstype, genfs->fstype) < 0)
@@ -1977,6 +1982,7 @@
 bad:
 	if (newc) {
 		context_destroy(&newc->context[0]);
+		context_destroy(&newc->context[1]);
 		free(newc->u.name);
 		free(newc);
 	}
@@ -2449,25 +2455,19 @@
                 num_decls = le32_to_cpu(buf[0]);
                 while (num_decls > 0) {
                         if ((curdecl = avrule_decl_create(0)) == NULL) {
-				free(curblock);
-				if (*block)
-					avrule_block_list_destroy(*block);
+				avrule_block_destroy(curblock);
                                 return -1;
                         }
                         if (avrule_decl_read(p, curdecl, num_scope_syms, fp) == -1) {
-				free(curblock);
-				if (*block)
-					avrule_block_list_destroy(*block);
 				avrule_decl_destroy(curdecl);
+				avrule_block_destroy(curblock);
                                 return -1;
                         }
                         if (curdecl->enabled) {
                                 if (curblock->enabled != NULL) {
                                         /* probably a corrupt file */
-					free(curblock);
-					if (*block)
-						avrule_block_list_destroy(*block);
 					avrule_decl_destroy(curdecl);
+					avrule_block_destroy(curblock);
                                         return -1;
                                 }
                                 curblock->enabled = curdecl;
only in patch2:
unchanged:
--- libsepol/include/sepol/policydb/avrule_block.h	7 Oct 2005 20:10:14 -0000	1.1
+++ libsepol/include/sepol/policydb/avrule_block.h	26 May 2006 19:02:10 -0000
@@ -23,8 +23,9 @@
 #include <sepol/policydb/policydb.h>
 
 extern avrule_block_t *avrule_block_create(void);
-extern avrule_decl_t *avrule_decl_create(uint32_t decl_id);
 extern void avrule_block_destroy(avrule_block_t *x);
+extern avrule_decl_t *avrule_decl_create(uint32_t decl_id);
+extern void avrule_decl_destroy(avrule_decl_t *x);
 extern void avrule_block_list_destroy(avrule_block_t *x);
 extern avrule_decl_t *get_avrule_decl(policydb_t *p, uint32_t decl_id);
 extern cond_list_t *get_decl_cond_list(policydb_t *p, 
only in patch2:
unchanged:
--- libsepol/src/avrule_block.c	7 Oct 2005 20:10:15 -0000	1.5
+++ libsepol/src/avrule_block.c	26 May 2006 19:02:10 -0000
@@ -41,8 +41,6 @@ static unsigned int symtab_sizes[SYM_NUM
 	2,
 };
 
-static void avrule_decl_destroy(avrule_decl_t *x);
-
 avrule_block_t *avrule_block_create(void)
 {
         avrule_block_t *block;
@@ -91,7 +89,7 @@ static void scope_index_destroy(scope_in
         free(scope->class_perms_map);
 }
 
-static void avrule_decl_destroy(avrule_decl_t *x)
+void avrule_decl_destroy(avrule_decl_t *x)
 {
         if (x == NULL) {
                 return;


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
