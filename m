Subject: Re: policy hierarchy patch
From: Joshua Brindle <jbrindle@tresys.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
In-Reply-To: <42556015.6090405@trustedcs.com>
References: <1112631282.19526.18.camel@localhost>
	 <1112635440.7629.125.camel@moss-spartans.epoch.ncsc.mil>
	 <1112643447.19527.30.camel@localhost>  <4251BA1E.9040406@trustedcs.com>
	 <1112709782.19531.39.camel@localhost> <425320BD.5050207@trustedcs.com>
	 <425456F1.5000905@trustedcs.com>
	 <1112877155.27110.15.camel@moss-spartans.epoch.ncsc.mil>
	 <42556015.6090405@trustedcs.com>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 17:03:53 -0400
Message-Id: <1112907833.19565.9.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-04-07 at 11:30 -0500, Darrel Goeddel wrote:
> Stephen Smalley wrote:
> > On Wed, 2005-04-06 at 16:38 -0500, Darrel Goeddel wrote:
> > 
> >>Here is a version that I am happy with.  There were only a few minor fixes from
> >>the past patch.  As before, this patch is relative to Joshua's
> >>hierarchy-backport patch, and it should be applied when that patch is applied to
> >>keep mls processing working in the policy compiler.  I haven't really looked
> >>over Joshua's patch with a fine tooth comb, but it sure has been working nice
> >>for me.  Anybody see anything wrong with the mls patch (or suggestions)?
> > 
> > 
> > The original hierarchy patch also collapsed the identifier and
> > user_identifier together, thereby allowing "-" to occur in any
> > identifier.  As a result, if someone specifies s0-s9 in the policy
> > without whitespace, it will be incorrectly interpreted as an attempt to
> > specify a level named "s0-s9".  Further, nothing prevents someone from
> > defining a level or category name that includes a "-" presently.
> > Options are to revert the change from the original patch that collapsed
> > identifier and user_identifier together (only adding "." to identifier,
> > not "-") or to add further handling to the action routines to deal with
> > it.
> > 

Out of curiousity, why are sensitivity ranged specified with '-' and
category ranged specified with '.'?

I think this is correct, not just because of the explanation above but
because this may cause issues with space sensitivity in type sets, ie
{ foo-bar } is the same as { foo -bar } now, but wouldn't be with this
patch. I'll fix this and send out a patch tomorrow.


Joshua


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
