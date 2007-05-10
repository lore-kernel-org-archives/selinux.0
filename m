Subject: Re: Ver3(Re: [patch] reducing size of libselinux(ver 2)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
Cc: selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1178802414.3504.98.camel@moss-spartans.epoch.ncsc.mil>
References: <20070507133423.3bd2463a.ynakam@hitachisoft.jp>
	 <1178738679.3504.25.camel@moss-spartans.epoch.ncsc.mil>
	 <20070510181218.0499cd05.ynakam@hitachisoft.jp>
	 <1178802414.3504.98.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 10 May 2007 12:11:38 -0400
Message-Id: <1178813498.3504.109.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-10 at 09:06 -0400, Stephen Smalley wrote:
> On Thu, 2007-05-10 at 18:12 +0900, Yuichi Nakamura wrote:
> > Thank you for review and idea !
> > 
> > On Wed, 09 May 2007 15:24:39 -0400
> > Stephen Smalley wrote:
> > <snip>
> > > Remove the fixed dependency on libsepol from libselinux by
> > > having it use dlopen() and friends and provide graceful fallbacks
> > > in the absence of libsepol.
> > <snip>
> > > -	if (vers > kernvers) {
> > > +	if (vers > kernvers && policydb_to_image) {
> > Here, 
> > I think policydb_to_image is not so good to indicate whether libsepol is used or not. 
> > I think  it is better to prepare flag that indicates whether libsepol functions are used or not.
> > I prepared "int usesepol" flag to indicate whether libsepol functions are used or not.
> 
> That's true - dlsym() technically can return NULL even upon success.
> 
> > Please see new patch.
> 
> Looks mostly sane to me.  Some comments:
> - libselinux/utils/Makefile needs to properly handle the DISABLE_AVC and
> DISABLE_BOOLS options - some of those utilities won't build with your
> cut-down version of libselinux so a make EMBEDDED=y at the top of
> libselinux will fail.
> - Is DISABLE_BOOLS still worthwhile?  Especially since I removed much of
> that code already as part of removing the legacy booleans/users support
> for setlocaldefs?
> - Could likely introduce a DISABLE_SETRANS that reduces setrans_client.c
> to trivial stubs in the embedded case (no translation daemon likely
> there, right?).
> - Could likely introduce a DISABLE_RPM that drops rpm.o from the
> library.
> - With the elimination of libsepol as a fixed dependency for libselinux,
> we can go back and remove -lsepol from a number of the Makefiles (e.g.
> libselinux/utils, several of the policycoreutils) and we can later
> eliminate it for the patched selinux userland packages (like coreutils -
> it would be nice if things like mv worked without libsepol present as
> they don't need it).

One other comment:  The policyrep branch is primarily for the policy
representation work; we have also been merging patches that involve
incompatible interface changes to it so that the entire branch can be
rolled over to trunk with a single bump in the .so version.  This patch
doesn't really fall into either of those categories and could go
straight to trunk if you wanted to have it sooner (as policyrep will
take time to mature before it can be merged to trunk).  Of course, to do
that, you'd have to re-base and deal with the legacy
sepol_genbools/genusers calls in the trunk version as well.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
