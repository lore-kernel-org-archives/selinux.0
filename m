Subject: Re: segfault using dismod when linking modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <7e0fb38c0805011304i3f63a0d0g987473892a76abb2@mail.gmail.com>
References: <7e0fb38c0805011304i3f63a0d0g987473892a76abb2@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 02 May 2008 09:45:12 -0400
Message-Id: <1209735912.25678.510.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-05-01 at 16:04 -0400, Eric Paris wrote:
> Maybe someone else will know this pretty quickly.  I'm attaching a
> tiny little base.conf and base.mod and a tiny test.te and test.mod
> that I built.  When I try to link them together I get a segfault
> somewhere through user_fix_callback() -> mls_level_convert()
> 
> Anyway, maybe I'll get to looking at it tomorrow, but if anyone else
> who actually understands all of this has a chance to look let me
> know....

Looks like mls_level_convert() falls over dead if passed an "empty" user
declaration, which appears to happen when you specify a require on it
but not a declaration for it in your module, which is what you do in
test.te.  Patch below will at least fix the symptom - not sure whether
it will yield the expected end result though.

Index: trunk/libsepol/src/link.c
===================================================================
--- trunk/libsepol/src/link.c	(revision 2874)
+++ trunk/libsepol/src/link.c	(working copy)
@@ -864,6 +864,10 @@
 	if (!mod->policy->mls)
 		return 0;
 
+	/* Required not declared. */
+	if (!src->sens)
+		return 0;
+
 	assert(mod->map[SYM_LEVELS][src->sens - 1]);
 	dst->sens = mod->map[SYM_LEVELS][src->sens - 1];
 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
