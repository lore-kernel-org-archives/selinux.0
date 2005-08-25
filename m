Subject: Re: [PATCH 3/6] libsepol: resource leaks in policydb.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: serue@us.ibm.com, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <430B5AC3.1090200@tresys.com>
References: <20050822160238.GC4191@sergelap.austin.ibm.com>
	 <1124802949.7874.23.camel@moss-spartans.epoch.ncsc.mil>
	 <430B5AC3.1090200@tresys.com>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 13:02:10 -0400
Message-Id: <1124989330.3873.113.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-08-23 at 13:20 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> 
> >On Mon, 2005-08-22 at 11:02 -0500, serue@us.ibm.com wrote:
> >>The second point makes me wonder - is scope_destroy() fully
> >>implemented?  It takes 'key' as an argument, but does nothing with
> >>it.  Same with its third arg.  Of course, they both have attribute
> >>unused...
> >>    
> >>
> >
> >I'm merging this patch at present, but I think you are correct about
> >scope_destroy being ambiguous in its usage - either it shouldn't take
> >the key as an argument at all, or it should free it.  Given that
> >scope_destroy is also being used in a hashtab_map call by
> >policydb_destroy to free the scope, I'd think we would want it to free
> >the key.  Joshua?
> >
> >  
> >
> You are right, I'm currently testing this patch but I think it's
> correct (this is before Serge's patch).

Yielded a double free in /sbin/init, load_policy, and checkpolicy due to
pointer aliasing in symtab_insert.  Patch below should fix.

Index: libsepol/src/util.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/util.c,v
retrieving revision 1.3
diff -u -p -r1.3 util.c
--- libsepol/src/util.c	2 Aug 2005 18:32:15 -0000	1.3
+++ libsepol/src/util.c	25 Aug 2005 16:40:14 -0000
@@ -186,13 +186,18 @@ int symtab_insert(policydb_t *pol, uint3
          * create it */
         scope_datum = (scope_datum_t *) hashtab_search(pol->scope[sym].table, key);
         if (scope_datum == NULL) {
+		hashtab_key_t key2 = strdup((char*)key);
+		if (!key2)
+			return -ENOMEM;
                 if ((scope_datum = malloc(sizeof(*scope_datum))) == NULL) {
+			free(key2);
                         return -ENOMEM;
                 }
                 scope_datum->scope = scope;
                 scope_datum->decl_ids = NULL;
                 scope_datum->decl_ids_len = 0;
-                if ((rc = hashtab_insert(pol->scope[sym].table, key, scope_datum)) != 0) {
+                if ((rc = hashtab_insert(pol->scope[sym].table, key2, scope_datum)) != 0) {	
+			free(key2);
 			free(scope_datum);
                         return rc;
                 }


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
