Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like
	mkdir
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <meyering@redhat.com>
Cc: James Antill <jantill@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <871wrgcrbm.fsf@rho.meyering.net>
References: <87mzabgyrk.fsf@rho.meyering.net>
	 <1155747947.11138.18.camel@code.and.org>  <871wrgcrbm.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 16:00:19 -0400
Message-Id: <1156795219.22210.146.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-16 at 23:18 +0200, Jim Meyering wrote:
> James Antill <jantill@redhat.com> wrote:
> > On Fri, 2006-08-11 at 15:58 +0200, Jim Meyering wrote:
> >> For a little context on why, ...
> >> I'm also considering the xattr patch that's been floating around for
> >> years.  Currently it's part of SuSE's coreutils patch set.  It ensures
> >> that mv and cp -p preserve any (selected) XATTR attributes.
> >
> >  Note that I did a patch, which is different from the SuSE patch ... it
> > doesn't include the regexp handling but mv does Do The Right
> > Thing(tm)[1]:
> >
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=201088
> > http://people.redhat.com/jantill/patches/coreutils-5.97-xattrs.patch
> 
> Your patch looks good, but shouldn't it also preserve attributes
> on directories and other non-regular files?
> 
> Since I rarely use ACLs, I'm not in a good position to gauge the
> value of Andreas' cp option to select via regexp.
> 
> Also, in looking through your patch, I wondered if there is some scenario
> where it'd be worthwhile to attempt to preserve xattrs even if fchmod
> fails.  Or even to attempt to preserve xattrs *before* calling fchmod?
> 
> >  It also makes preservation of xattrs a hard error, unless it's because
> > of ENOTSUPP ... and there's no way to turn just preservation of xattrs
> > off (would you want this before accepting upstream)?
> 
> For upstream at least, the 5.9x branch is a bug-fix-only branch.
> New features like xattr support will go on the trunk.
> 
> What do you think about adding a new cp option: --preserve=xattr ?
> That would be in line with the --preserve=context option (added to cp)
> that's part of the SELinux patch.
> Which means it could be turned off via --no-preserve=xattr.
> 
> Currently, cp's --preserve option treats ACLs like mode bits.  I.e. both
> cp -p and cp --preserve=mode copy ACLs.  mv preserves ACLs, too.
> As mentioned before, failing to preserve an ACL has different consequences
> in cp -p (warn and exit nonzero) and mv (warn, but exit successfully).
> 
> So should cp have a separate --preserve=acl option, too?
> 
> This brings up the question of whether cp's -p should also
> imply --preserve=xattr.

Caveat:  A process may be able to copy a file and preserve its
discretionary attributes, but not its MAC/SELinux attribute.  That
shouldn't be fatal to the copy itself.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
