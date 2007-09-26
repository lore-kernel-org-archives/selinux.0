Subject: Re: [RFC PATCH 0/2] Series short description
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Paul Moore <paul.moore@hp.com>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov
In-Reply-To: <46FAC2C5.70007@manicmethod.com>
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net>
	 <200709251838.58272.paul.moore@hp.com> <46F9C1C6.7090709@manicmethod.com>
	 <200709252312.46945.paul.moore@hp.com>
	 <1190813392.15779.58.camel@moss-spartans.epoch.ncsc.mil>
	 <46FAC2C5.70007@manicmethod.com>
Content-Type: text/plain
Date: Wed, 26 Sep 2007 16:32:08 -0400
Message-Id: <1190838728.15779.177.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-26 at 16:36 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Tue, 2007-09-25 at 23:12 -0400, Paul Moore wrote:
> >   
> >> On Tuesday 25 September 2007 10:19:50 pm Joshua Brindle wrote:
> >>     
> >>> It seems like we've gotten versioning of the policy wrong if this sort
> >>> of thing is necessary (two separate, slightly related version numbers).
> >>>       
> >> I don't think it's necessary to have these two version numbers, as Eric 
> >> pointed out earlier the existing policy version would work.  While I don't 
> >> have my "History of SELinux" book in front of me right now to know the 
> >> original intent of the policy version number, it appears to have been used to 
> >> signify policy capabilities on more than one occasion.
> >>     
> >
> > The policy version tells the kernel how to interpret the policy image.
> > It is primarily about the policy image format, not the policy content,
> > although it has been abused for the latter in some cases because we had
> > no other mechanism.
> >
> > Using the policy version as an indication of the policy content today is
> > problematic because the policy toolchain always generates the latest
> > version/format it supports independent of what the policy may have
> > contained, and at policy load time, the policy image is automatically
> > downgraded (by libselinux with help from libsepol) if necessary to the
> > latest version/format supported by the kernel.  So the kernel may not
> > even see the original version number that was built.
> >
> >   
> >>> A while back someone (I can't remember if it was me or not) suggested a
> >>> bitmap of policy capabilities that would be determined at compile time
> >>> (eg., does this policy have conditional expressions? turn that bit on.
> >>> Does this policy use class foo? turn that bit on, etc). Why is your
> >>> version scheme better than something like that?
> >>>       
> >> Well, like I said earlier, forget the versioning scheme I proposed.  However, 
> >> for the sake or argument one advantage that I can see to a version number or 
> >> a capability bitmap (it would most likely need to be an ebitmap to allow for 
> >> future growth) is that it is much easier/quicker to check in the security 
> >> server.  Comparing two integers is much faster then checking for a single bit 
> >> in an ebitmap.
> >>
> >> That said, I agree that your idea of a policy capability bitmap is interesting 
> >> and would allow a lot of flexibility.  I'm just not sure the implementation 
> >> would be practical, but then again, you have much more experience in the 
> >> policy compiler/toolchain than I do.
> >>     
> >
> > I think we'd need a separate content/feature version or bitmap from the
> > format version.
> >
> > The bitmap seems better if we want to support independent selection of
> > subsets.  The version seems better if we want to incrementally build
> > upon each new feature and always require the prior ones to exist or to
> > be obsoleted by the new one.
> >   
> 
> I've always wondered why we incrementally built features on and required 
> the prior ones even though they were completely unrelated. I like the 
> bitmap idea because it lets the compiler (or even the user in some cases 
> (?)) choose which features about the policy are in use and therefore 
> turned on. It would also let someone read a node in selinuxfs and see 
> what the current expected behavior is for the loaded policy. This 
> probably would have been the ideal way to handle compat_net (in fact, we 
> could go ahead and do that if it won't cause problems..)

Well, historically, as we added support for new things, new policies
took advantage of them immediately, and thus people tracked new features
monotonically as they updated their checkpolicy and policy.  Not
independent selection of them.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
