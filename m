Message-ID: <43342863.1020505@tresys.com>
Date: Fri, 23 Sep 2005 12:08:03 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [PATCH] sepol link.c fixes
References: <1127422373.21806.41.camel@twoface.columbia.tresys.com> <1127489714.27851.24.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1127489714.27851.24.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2005-09-22 at 16:52 -0400, Joshua Brindle wrote:
>  
>
>>The first patch fixes a NULL dereference, a memory leak (only the first
>>block of an avrule list was being freed instead of the whole list), and
>>makes merge_avrules static.
>>    
>>
>
>--- libsepol/src/link.c	2005-09-22 09:41:17.000000000 -0400
>+++ libsepol/src/link.c	2005-09-22 15:39:59.000000000 -0400
>@@ -1488,7 +1488,8 @@ static void enable_avrules(link_state_t 
>                                 continue;
>                         }
>                         while (depth_count-- > 0 && decl != NULL) {
>-                                if (is_decl_requires_met(state, decl, NULL)) {
>+                                struct missing_requirement req;  /* unused */
>+                                if (is_decl_requires_met(state, decl, &req)) {
>                                         decl->enabled = 1;
>                                         block->enabled = decl;
>                                         changed = 1;
>
>Why?  is_decl_requires_met already checks for req != NULL prior to
>dereferencing.
>  
>
Yes, this fix came from another feature and looks bogus anyway. Please 
drop this patch.

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
