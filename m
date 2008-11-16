Message-ID: <4920B3C1.4000405@manicmethod.com>
Date: Sun, 16 Nov 2008 18:58:57 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>
Subject: Re: This policy causes checkmodule to segfault.
References: <491DE60C.3040205@redhat.com>
In-Reply-To: <491DE60C.3040205@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> policy_module(test, 1.0)
>
> gen_require(`
>   type a_t;
> ')
> type b_t alias a_t;
>   

Well, this doesn't look good. There are a couple issues here. The first 
is that when we changed the symtab_insert behavior to allow require then 
declare we missed the alias case, the patch below should fix that. The 
second problem is that type_write now treats primary as a boolean value 
(as of the typebounds patch). A while back we made primary not 
necessarily a boolean in the module case where an alias had a value 
already and we needed to keep track of what the primary value was. The 
typebounds patch combined multiple fields into a 'properties' bitmap, 
which includes primary, so the value is now lost.

We can change the module format to keep the primary field around, this 
particular piece of code is getting increasingly more confusing though 
(write.c:970)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 25b06c1..8c04767 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -983,6 +983,7 @@ static int add_aliases_to_type(type_datum_t * type)
        char *id;
        type_datum_t *aliasdatum = NULL;
        int ret;
+       uint32_t val;
        while ((id = queue_remove(id_queue))) {
                if (id_has_dot(id)) {
                        free(id);
@@ -1000,7 +1001,7 @@ static int add_aliases_to_type(type_datum_t * type)
                aliasdatum->s.value = type->s.value;
 
                ret = declare_symbol(SYM_TYPES, id, aliasdatum,
-                                    NULL, &aliasdatum->s.value);
+                                    &val, &aliasdatum->s.value);
                switch (ret) {
                case -3:{
                                yyerror("Out of memory!");
@@ -1017,6 +1018,17 @@ static int add_aliases_to_type(type_datum_t * type)
                        }
                case 0:
                case 1:{
+                              /* ret == 1 means the alias was required 
and therefore already
+                               * has a value. Set it up as an alias 
with a different primary. */
+                               type_datum_destroy(aliasdatum);
+                               free(aliasdatum);
+                              
+                               aliasdatum = 
hashtab_search(policydbp->symtab[SYM_TYPES].table, id);
+                               assert(aliasdatum);
+                               aliasdatum->primary = type->s.value;
+                               aliasdatum->flavor = TYPE_ALIAS;
+
+                               free(id);
                                break;
                        }
                default:{





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
