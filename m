Subject: Re: [patch] reducing size of libselinux(ver 2)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
Cc: selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1178738679.3504.25.camel@moss-spartans.epoch.ncsc.mil>
References: <20070507133423.3bd2463a.ynakam@hitachisoft.jp>
	 <1178738679.3504.25.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 09 May 2007 15:31:17 -0400
Message-Id: <1178739077.3504.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-09 at 15:24 -0400, Stephen Smalley wrote:
> On Mon, 2007-05-07 at 13:34 +0900, Yuichi Nakamura wrote:
> > Hello.
> > 
> > I would like to submit patch again 
> > to reduce size of libselinux for embedded devices, as we discussed before.
> > http://marc.info/?t=117609454600002&r=1&w=2
> > This patch is for policyrep branch.
> <snip>
> > Index: libselinux/src/load_policy.c
> > ===================================================================
> > --- libselinux/src/load_policy.c	(revision 2429)
> > +++ libselinux/src/load_policy.c	(working copy)
> > @@ -15,6 +15,21 @@
> >  #include "policy.h"
> >  #include <limits.h>
> >  
> > +#ifdef DISABLE_SEPOL
> > +#include <sepol/policydb/policydb.h>
> > +/* selinux_mkload_policy needs them 
> > +   even when sepol is disabled. */
> > +int sepol_policy_kern_vers_min(void)
> > +{
> > +	return POLICYDB_VERSION_MIN;
> > +}
> > +
> > +int sepol_policy_kern_vers_max(void)
> > +{
> > +	return POLICYDB_VERSION_MAX;
> > +}
> > +#endif
> 
> I don't think we want to be including headers from under sepol/policydb/
> or replicating these functions here, and it occurs to me that we could
> all benefit from making the libselinux -> libsepol dependency optional
> at runtime, i.e. have libselinux dlopen() libsepol and only use its
> functions if present, as that would eliminate the unnecessary dependency
> on libsepol for many programs that only need libselinux.
> 
> Something like the patch below (compile-tested only).

Oops, requires the following patch on top of the first one.

diff -u policyrep/libselinux/src/load_policy.c policyrep/libselinux/src/load_policy.c
--- policyrep/libselinux/src/load_policy.c	(working copy)
+++ policyrep/libselinux/src/load_policy.c	(working copy)
@@ -104,8 +104,10 @@
 	policydb_to_image = sepol_policydb_to_image;
 #endif
 
-	vers = vers_max();
-	minvers = vers_min();
+	if (vers_max)
+		vers = vers_max();
+	if (vers_min)
+		minvers = vers_min();
 
       search:
 	snprintf(path, sizeof(path), "%s.%d",

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
