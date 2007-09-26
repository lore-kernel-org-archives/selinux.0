Subject: Re: [RFC PATCH 0/2] Series short description
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Paul Moore <paul.moore@hp.com>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov
In-Reply-To: <46FA8C30.2020303@manicmethod.com>
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net>
	 <200709252312.46945.paul.moore@hp.com>
	 <1190813392.15779.58.camel@moss-spartans.epoch.ncsc.mil>
	 <200709261200.09547.paul.moore@hp.com>  <46FA8C30.2020303@manicmethod.com>
Content-Type: text/plain
Date: Wed, 26 Sep 2007 12:48:34 -0400
Message-Id: <1190825314.15779.124.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-26 at 12:43 -0400, Joshua Brindle wrote:
> Paul Moore wrote:
> > On Wednesday 26 September 2007 9:29:52 am Stephen Smalley wrote:
> >   
> >> On Tue, 2007-09-25 at 23:12 -0400, Paul Moore wrote:
> >>     
> >>> On Tuesday 25 September 2007 10:19:50 pm Joshua Brindle wrote:
> >>>       
> >>>> A while back someone (I can't remember if it was me or not) suggested a
> >>>> bitmap of policy capabilities that would be determined at compile time
> >>>> (eg., does this policy have conditional expressions? turn that bit on.
> >>>> Does this policy use class foo? turn that bit on, etc). Why is your
> >>>> version scheme better than something like that?
> >>>>         
> >>> Well, like I said earlier, forget the versioning scheme I proposed. 
> >>> However, for the sake or argument one advantage that I can see to a
> >>> version number or a capability bitmap (it would most likely need to be an
> >>> ebitmap to allow for future growth) is that it is much easier/quicker to
> >>> check in the security server.  Comparing two integers is much faster then
> >>> checking for a single bit in an ebitmap.
> >>>
> >>> That said, I agree that your idea of a policy capability bitmap is
> >>> interesting and would allow a lot of flexibility.  I'm just not sure the
> >>> implementation would be practical, but then again, you have much more
> >>> experience in the policy compiler/toolchain than I do.
> >>>       
> >> I think we'd need a separate content/feature version or bitmap from the
> >> format version.
> >>
> >> The bitmap seems better if we want to support independent selection of
> >> subsets.  The version seems better if we want to incrementally build
> >> upon each new feature and always require the prior ones to exist or to
> >> be obsoleted by the new one.
> >>     
> >
> > Okay, it looks like its probably at least worth investigating the bitmap 
> > concept with some RFC patches.
> >
> > Josh, since you brought up the idea and you have a better grasp of the 
> > toolchain, can I talk/bribe/make-you-an-offer-you-can't-refuse into working 
> > up some patches for the toolchain if I come up with the matching kernel 
> > piece?
> >   
> 
> I knew I should have kept my mouth shut :)
> 
> I'll try to get around to the toolchain patches this week. Some things 
> need to be settled, this will require a policy version bump to 22, and 
> we can either ignore all the capabilities we have now and start with 
> secid reconciliation or actually factor in all the capabilities we have 
> now into it. It will be easier short term to do the former, but possibly 
> better in the long term to do the latter.
> 
> The latter might have some crappy code in it, for example, in the reader 
> when reading the binary there would be something like:
> 
> if ((policyvers > POLICYDB_VERSION_BOOLS && policyvers < 
> POLICYDB_VERSION_CAPS) || (policyvers > POLICYDB_VERSION_CAPS && 
> ebitmap_get_bit(cap_bitmap, BOOL_CAP_BIT))
> 
> it gets ugly, if we just ignore what we have now it would look alot 
> nicer, though I still like the idea of being able to turn off 
> unnecessary checks when conditionals aren't used at all.

I'm not clear it is worth trying to apply this retroactively to the
existing "versions"/features, and it is both potentially much more
disruptive.  In the case where there are no conditional rules, the
avtab_search() will devolve trivially.  Similarly for constraints (and
MLS constraints aren't treated specially internally - they are just
added to the per-class constraints list).  I don't think we gain much by
omitting them altogether.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
