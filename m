Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j75KYkOb003880
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 16:34:46 -0400 (EDT)
Received: from ccerelbas04.cce.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j75KQfrI010223
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 20:26:41 GMT
Message-ID: <42F3CBB0.4060304@hp.com>
Date: Fri, 05 Aug 2005 16:27:28 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Cc: jkim@TrustedCS.com, chanson@TrustedCS.com,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: [PATCH] Fix the range_transition rule
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Below is a patch to libsepol/src/expand.c to fix a problem with MLS 
range transitions.  The problem is that the function expand_module() 
reassigns numeric values for the types when copying them and the routine 
used to copy the range transitions, range_trans_clone(), simply copied 
the old type values leading to bad values in the resulting policy file.

This fix uses the old type value to look up the type name in the old 
symbol table and then uses the type name to lookup the new type value.

--- libsepol-1.7.9/src/expand.c.orig    2005-08-05 15:33:26.000000000 -0400
+++ libsepol-1.7.9/src/expand.c 2005-08-05 16:14:18.000000000 -0400
@@ -1349,11 +1349,21 @@ static int range_trans_clone(expand_stat

          while (range != NULL) {
                  range_trans_t *new_range;
+                type_datum_t *type;
+                char *type_name;
+
                  if ((new_range = malloc(sizeof(*new_range))) == NULL) {
                          goto out_of_mem;
                  }
-                new_range->dom = range->dom;
-                new_range->type = range->type;
+
+                /* convert the range_transition domain and type */
+                type_name = state->base->p_type_val_to_name[range->dom 
- 1];
+                type = hashtab_search(state->out->p_types.table, 
type_name);
+                new_range->dom = type->value;
+                type_name = state->base->p_type_val_to_name[range->type 
- 1];
+                type = hashtab_search(state->out->p_types.table, 
type_name);
+                new_range->type = type->value;
+
                  if (mls_level_clone(&new_range->range.level[0], 
&range->range.level[0]) == -1 ||
                      mls_level_clone(&new_range->range.level[1], 
&range->range.level[1])) {
                          goto out_of_mem;


-- 
. paul moore . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. paul.moore@hp.com                                      hewlett packard
. (603) 884-5056                                          linux security

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
