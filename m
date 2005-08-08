Subject: Re: [PATCH] Fix the range_transition rule
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov, jkim@TrustedCS.com,
   chanson@TrustedCS.com, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <42F4DB2D.2040002@tresys.com>
References: <42F3CBB0.4060304@hp.com>  <42F4DB2D.2040002@tresys.com>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 09:54:16 -0400
Message-Id: <1123509256.13654.158.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-08-06 at 11:45 -0400, Joshua Brindle wrote:
> Thanks, however this should probably be using the typemap that already 
> does this sort of thing.
> something like new_range->type = state->typemap[type->value - 1] should 
> work correctly.

How about this patch?

Index: libsepol/src/expand.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/expand.c,v
retrieving revision 1.2
diff -u -p -r1.2 expand.c
--- libsepol/src/expand.c	2 Aug 2005 18:32:15 -0000	1.2
+++ libsepol/src/expand.c	8 Aug 2005 13:49:45 -0000
@@ -1352,8 +1352,8 @@ static int range_trans_clone(expand_stat
                 if ((new_range = malloc(sizeof(*new_range))) == NULL) {
                         goto out_of_mem;
                 }
-                new_range->dom = range->dom;
-                new_range->type = range->type;
+                new_range->dom = state->typemap[range->dom-1];
+                new_range->type = state->typemap[range->type-1];
                 if (mls_level_clone(&new_range->range.level[0], &range->range.level[0]) == -1 ||
                     mls_level_clone(&new_range->range.level[1], &range->range.level[1])) {
                         goto out_of_mem;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
