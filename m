Subject: Re: Ver 4(Re: Ver3(Re: [patch] reducing size of libselinux(ver 2)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
Cc: selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <20070511140530.66290212.ynakam@hitachisoft.jp>
References: <20070507133423.3bd2463a.ynakam@hitachisoft.jp>
	 <1178738679.3504.25.camel@moss-spartans.epoch.ncsc.mil>
	 <20070510181218.0499cd05.ynakam@hitachisoft.jp>
	 <1178802414.3504.98.camel@moss-spartans.epoch.ncsc.mil>
	 <20070511140530.66290212.ynakam@hitachisoft.jp>
Content-Type: text/plain
Date: Fri, 11 May 2007 09:49:09 -0400
Message-Id: <1178891349.3504.185.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-05-11 at 14:05 +0900, Yuichi Nakamura wrote:
> On Thu, 10 May 2007 09:06:54 -0400
> Stephen Smalley  wrote:
> > Looks mostly sane to me.  Some comments:
> Thank you.
> 
> > - libselinux/utils/Makefile needs to properly handle the DISABLE_AVC and
> > DISABLE_BOOLS options - some of those utilities won't build with your
> > cut-down version of libselinux so a make EMBEDDED=y at the top of
> > libselinux will fail.
> I fixed utils/Makefile.

Hmm...I don't like the duplicated definitions - they should just go into
the top-level Makefile and be exported, ala:

Index: libselinux/Makefile
===================================================================
--- libselinux/Makefile	(revision 2435)
+++ libselinux/Makefile	(working copy)
@@ -1,3 +1,17 @@
+DISABLE_AVC ?= n
+DISABLE_SETRANS ?= n
+DISABLE_RPM ?= n
+DISABLE_BOOL ?= n
+
+ifeq ($(EMBEDDED),y)
+	override DISABLE_AVC=y
+	override DISABLE_SETRANS=y
+	override DISABLE_RPM=y
+	override DISABLE_BOOL=n
+endif
+
+export DISABLE_AVC DISABLE_SETRANS DISABLE_RPM DISABLE_BOOL
+
 all: 
 	$(MAKE) -C src 
 	$(MAKE) -C utils

> > - Is DISABLE_BOOLS still worthwhile?  Especially since I removed much of
> > that code already as part of removing the legacy booleans/users support
> > for setlocaldefs?
> I think in some cases people do not use booleans.
> So I leave DISABLE_BOOLS option in Makefile, but it is "n" by default.

No, either you use it by default for EMBEDDED=y or it gets removed
altogether.  We don't want options that will rarely get tested.

I'm also not keen on the separate _stub.c files as I think they will
prove painful to maintain.  booleans_stub.c shouldn't be needed at all
if you wrap the preservebools block in load_policy.c with an #if, and
setrans_client_stub.c can be folded into setrans_client.c using an
#if..#else..#endif.  That makes the Makefiles simpler too.

> > - With the elimination of libsepol as a fixed dependency for libselinux,
> > we can go back and remove -lsepol from a number of the Makefiles (e.g.
> > libselinux/utils, several of the policycoreutils) and we can later
> > eliminate it for the patched selinux userland packages (like coreutils -
> > it would be nice if things like mv worked without libsepol present as
> > they don't need it).
> For now I fixed utils/Makefiles.
> 
> ---
> Below is patch ver 4.
> I rewrote it for trunk.

Suggestion:  Next time you post a version of the patch, make it a clean
submission, i.e. drop the prior discussion, provide an updated summary
of what the patch does, etc.  And you might consider splitting into two
separate patches, as the part that switches libselinux to dlopen'ing of
libsepol is independent of the DISABLE* options.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
