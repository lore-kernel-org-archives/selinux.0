Subject: Re: [PATCH] sepol link.c fixes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1127422373.21806.41.camel@twoface.columbia.tresys.com>
References: <1127422373.21806.41.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 23 Sep 2005 11:35:14 -0400
Message-Id: <1127489714.27851.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-22 at 16:52 -0400, Joshua Brindle wrote:
> The first patch fixes a NULL dereference, a memory leak (only the first
> block of an avrule list was being freed instead of the whole list), and
> makes merge_avrules static.

--- libsepol/src/link.c	2005-09-22 09:41:17.000000000 -0400
+++ libsepol/src/link.c	2005-09-22 15:39:59.000000000 -0400
@@ -1488,7 +1488,8 @@ static void enable_avrules(link_state_t 
                                 continue;
                         }
                         while (depth_count-- > 0 && decl != NULL) {
-                                if (is_decl_requires_met(state, decl, NULL)) {
+                                struct missing_requirement req;  /* unused */
+                                if (is_decl_requires_met(state, decl, &req)) {
                                         decl->enabled = 1;
                                         block->enabled = decl;
                                         changed = 1;

Why?  is_decl_requires_met already checks for req != NULL prior to
dereferencing.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
