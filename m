Message-ID: <42F766CA.9070102@tresys.com>
Date: Mon, 08 Aug 2005 10:06:02 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov, jkim@TrustedCS.com,
   chanson@TrustedCS.com, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] Fix the range_transition rule
References: <42F3CBB0.4060304@hp.com>  <42F4DB2D.2040002@tresys.com> <1123509256.13654.158.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1123509256.13654.158.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Sat, 2005-08-06 at 11:45 -0400, Joshua Brindle wrote:
>  
>
>>Thanks, however this should probably be using the typemap that already 
>>does this sort of thing.
>>something like new_range->type = state->typemap[type->value - 1] should 
>>work correctly.
>>    
>>
>
>How about this patch?
>
>Index: libsepol/src/expand.c
>===================================================================
>RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/expand.c,v
>retrieving revision 1.2
>diff -u -p -r1.2 expand.c
>--- libsepol/src/expand.c	2 Aug 2005 18:32:15 -0000	1.2
>+++ libsepol/src/expand.c	8 Aug 2005 13:49:45 -0000
>@@ -1352,8 +1352,8 @@ static int range_trans_clone(expand_stat
>                 if ((new_range = malloc(sizeof(*new_range))) == NULL) {
>                         goto out_of_mem;
>                 }
>-                new_range->dom = range->dom;
>-                new_range->type = range->type;
>+                new_range->dom = state->typemap[range->dom-1];
>+                new_range->type = state->typemap[range->type-1];
>                 if (mls_level_clone(&new_range->range.level[0], &range->range.level[0]) == -1 ||
>                     mls_level_clone(&new_range->range.level[1], &range->range.level[1])) {
>                         goto out_of_mem;
>
>  
>
That looks correct.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
