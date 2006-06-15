MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Type transition rules in conditionals
Date: Thu, 15 Jun 2006 15:41:14 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588210A4F@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "selinux-dev" <selinux-dev@tresys.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

<snip>
> 
> More details would be helpful, e.g.:
> - Where precisely is the problem code in the expander?  

Expand.c:expand_terule_helper

The current code just continues when it sees a duplicate, even if the
duplicate is in a different conditional.
The patch I tried was something like this
-                        if (oldtype == remapped_data)
-                                return 1;
+                       /* ignore duplicates if this is unconditional or
if te rule is in a conditional
+                        * and this is in another conditional */
+                       if (oldtype == remapped_data && (conflict == 1
|| node->parse_context == cond)) {
+                               return 1;

This seems to work correctly (retains type_trans that are in different
conditionals)

> What was the change you tried (patch)?

In the security server I did this (which is wrong since it needs to loop
through all entries to check for conflicts)

@@ -628,7 +629,8 @@ static int cond_insertf(avtab_t *a __att
                                }
                        }
                } else {    
-                       if (avtab_search(&p->te_cond_avtab, k)) {
+                       avd = avtab_search(&p->te_cond_avtab, k);
+                       if (avd && d->data != avd->data) {
                                printf("security: conflicting type rules
when adding type rule for true.\n");
                                goto err;
                        }

> - Why can't it be handled in the same manner as in a monolithic build?

It is handled the same, the only difference is the order that the
type_transitions are 

> - Why doesn't the existing support for non-unique entries in 
> the avtab for conditionals handle this already?

The code only handles non-unique entries for type_trans on each side of
the same conditional. The code assumes everywhere that if there is
another it's a conflict.

> - Why doesn't the existing loop in compute_sid handle this already?
> 

Sorry, it does appear to have the loop already:

677         if(!avdatum) {
678                 node = avtab_search_node(&policydb.te_cond_avtab,
&avkey, specified);
679                 for (; node != NULL; node =
avtab_search_node_next(node, specified)) {
680                         if (node->datum.specified & AVTAB_ENABLED) {
681                                 avdatum = &node->datum;
682                                 break;
683                         }
684                 }
685         }



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
