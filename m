Message-ID: <430B5AC3.1090200@tresys.com>
Date: Tue, 23 Aug 2005 13:20:03 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: serue@us.ibm.com, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 3/6] libsepol: resource leaks in policydb.c
References: <20050822160238.GC4191@sergelap.austin.ibm.com> <1124802949.7874.23.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1124802949.7874.23.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Mon, 2005-08-22 at 11:02 -0500, serue@us.ibm.com wrote:
>  
>
>>This patch fixes 2 resource leaks found by Coverity in policydb.c.
>>
>>	1. in avrule_read(), the 'cur' element has been malloc'ed
>>	but not yet added to the avrule->perms list at one point
>>	whene we jump to bad:
>>
>>	2. 'key' is not freed in one case in scope_read().
>>
>>The second point makes me wonder - is scope_destroy() fully
>>implemented?  It takes 'key' as an argument, but does nothing with
>>it.  Same with its third arg.  Of course, they both have attribute
>>unused...
>>    
>>
>
>I'm merging this patch at present, but I think you are correct about
>scope_destroy being ambiguous in its usage - either it shouldn't take
>the key as an argument at all, or it should free it.  Given that
>scope_destroy is also being used in a hashtab_map call by
>policydb_destroy to free the scope, I'd think we would want it to free
>the key.  Joshua?
>
>  
>
You are right, I'm currently testing this patch but I think it's correct (this is before Serge's patch).

Index: policydb.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/libsepol/src/policydb.c,v
retrieving revision 1.19
diff -u -r1.19 policydb.c
--- policydb.c  18 Aug 2005 20:42:25 -0000      1.19
+++ policydb.c  23 Aug 2005 15:04:09 -0000
@@ -970,8 +970,9 @@
        }
 }
 
-int scope_destroy(hashtab_key_t key __attribute__ ((unused)), 
hashtab_datum_t datum, void *p __attribute__ ((unused)))
+int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p 
__attribute__ ((unused)))
 {
+       free(key);
         scope_datum_t *cur = (scope_datum_t *) datum;
         if (cur != NULL) {
                 free (cur->decl_ids);
@@ -2374,8 +2375,7 @@
        return 0;
         
  cleanup:
-        free(key);
-       scope_destroy(NULL, scope, NULL);
+       scope_destroy(key, scope, NULL);
        return -1;
 }
 
@@ -2518,26 +2518,26 @@
         if (p->policy_type == POLICY_MOD) {
                 /* Get the module name and version */
                 if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
-                        return -1;
+                        goto bad;
                 }
                 len = le32_to_cpu(buf[0]);
                 if ((buf = next_entry(fp, len)) == NULL) {
-                        return -1;
+                        goto bad;
                 }
                 if ((p->name = malloc(len + 1)) == NULL) {
-                        return -1;
+                        goto bad;
                 }
                 memcpy(p->name, buf, len);
                 p->name[len] = '\0';
                 if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
-                        return -1;
+                        goto bad;
                 }
                 len = le32_to_cpu(buf[0]);
                 if ((buf = next_entry(fp, len)) == NULL) {
-                        return -1;
+                        goto bad;
                 }
                 if ((p->version = malloc(len + 1)) == NULL) {
-                        return -1;
+                        goto bad;
                 }
                 memcpy(p->version, buf, len);
                 p->version[len] = '\0';
@@ -2574,7 +2574,7 @@
                 free(p->global);
                 p->global = NULL;
                 if (avrule_block_read(p, &p->global, info->sym_num, fp) 
== -1) {
-                        return -1;
+                        goto bad;
                 }
                 for (i = 0; i < info->sym_num; i++) {
                         if ((buf = next_entry(fp, sizeof(uint32_t))) == 
NULL) {

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
