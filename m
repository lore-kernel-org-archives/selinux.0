From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: [RFC PATCH 0/2] Series short description
Date: Wed, 26 Sep 2007 12:00:09 -0400
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net> <200709252312.46945.paul.moore@hp.com> <1190813392.15779.58.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1190813392.15779.58.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709261200.09547.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 26 September 2007 9:29:52 am Stephen Smalley wrote:
> On Tue, 2007-09-25 at 23:12 -0400, Paul Moore wrote:
> > On Tuesday 25 September 2007 10:19:50 pm Joshua Brindle wrote:
> > > A while back someone (I can't remember if it was me or not) suggested a
> > > bitmap of policy capabilities that would be determined at compile time
> > > (eg., does this policy have conditional expressions? turn that bit on.
> > > Does this policy use class foo? turn that bit on, etc). Why is your
> > > version scheme better than something like that?
> >
> > Well, like I said earlier, forget the versioning scheme I proposed. 
> > However, for the sake or argument one advantage that I can see to a
> > version number or a capability bitmap (it would most likely need to be an
> > ebitmap to allow for future growth) is that it is much easier/quicker to
> > check in the security server.  Comparing two integers is much faster then
> > checking for a single bit in an ebitmap.
> >
> > That said, I agree that your idea of a policy capability bitmap is
> > interesting and would allow a lot of flexibility.  I'm just not sure the
> > implementation would be practical, but then again, you have much more
> > experience in the policy compiler/toolchain than I do.
>
> I think we'd need a separate content/feature version or bitmap from the
> format version.
>
> The bitmap seems better if we want to support independent selection of
> subsets.  The version seems better if we want to incrementally build
> upon each new feature and always require the prior ones to exist or to
> be obsoleted by the new one.

Okay, it looks like its probably at least worth investigating the bitmap 
concept with some RFC patches.

Josh, since you brought up the idea and you have a better grasp of the 
toolchain, can I talk/bribe/make-you-an-offer-you-can't-refuse into working 
up some patches for the toolchain if I come up with the matching kernel 
piece?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
