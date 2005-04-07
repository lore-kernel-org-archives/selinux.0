Subject: Re: policy hierarchy patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
In-Reply-To: <425456F1.5000905@trustedcs.com>
References: <1112631282.19526.18.camel@localhost>
	 <1112635440.7629.125.camel@moss-spartans.epoch.ncsc.mil>
	 <1112643447.19527.30.camel@localhost>  <4251BA1E.9040406@trustedcs.com>
	 <1112709782.19531.39.camel@localhost> <425320BD.5050207@trustedcs.com>
	 <425456F1.5000905@trustedcs.com>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 08:32:35 -0400
Message-Id: <1112877155.27110.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-04-06 at 16:38 -0500, Darrel Goeddel wrote:
> Here is a version that I am happy with.  There were only a few minor fixes from
> the past patch.  As before, this patch is relative to Joshua's
> hierarchy-backport patch, and it should be applied when that patch is applied to
> keep mls processing working in the policy compiler.  I haven't really looked
> over Joshua's patch with a fine tooth comb, but it sure has been working nice
> for me.  Anybody see anything wrong with the mls patch (or suggestions)?

The original hierarchy patch also collapsed the identifier and
user_identifier together, thereby allowing "-" to occur in any
identifier.  As a result, if someone specifies s0-s9 in the policy
without whitespace, it will be incorrectly interpreted as an attempt to
specify a level named "s0-s9".  Further, nothing prevents someone from
defining a level or category name that includes a "-" presently.
Options are to revert the change from the original patch that collapsed
identifier and user_identifier together (only adding "." to identifier,
not "-") or to add further handling to the action routines to deal with
it.

It also looks like you have double free error upon encountering an
undefined sensitivity name in a user declaration.

As a minor note, I suppose that the 'make mlsconvert' should also change
MLS=y in the Makefile so that you don't have to do that as an extra
step.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
