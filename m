Subject: Re: [patch 0/2] policy capability support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Todd Miller <Tmiller@tresys.com>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <47570BAC.3050705@manicmethod.com>
References: <20071205184848.180973622@tresys.com>
	 <200712051421.39624.paul.moore@hp.com>
	 <6FE441CD9F0C0C479F2D88F959B0158801455FBA@exchange.columbia.tresys.com>
	 <1196883697.16006.103.camel@moss-spartans.epoch.ncsc.mil>
	 <4757073B.70907@manicmethod.com>
	 <1196886844.16006.117.camel@moss-spartans.epoch.ncsc.mil>
	 <47570BAC.3050705@manicmethod.com>
Content-Type: text/plain
Date: Wed, 05 Dec 2007 15:50:06 -0500
Message-Id: <1196887806.16006.131.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-05 at 15:35 -0500, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Wed, 2007-12-05 at 15:16 -0500, Joshua Brindle wrote:
> >   
> >> Stephen Smalley wrote:
> >>     
> >>> On Wed, 2007-12-05 at 14:30 -0500, Todd Miller wrote:
> >>>       
> >>>> Paul Moore wrote:
> >>>>         
> >>>>> The discussion for this appears to have gone quiet (at least I
> >>>>> haven't seen anything else on this list).  Where do things currently
> >>>>> stand?
> >>>>>           
> >>>> At this point I'd be OK with requiring equivalence and throwing an error
> >>>> otherwise.  I do think that this will result in usability issues that we
> >>>> will have to address once people start using the caps.  However, with
> >>>> only
> >>>> a single cap defined so far it is not really possible to know how these
> >>>> will end up being used.
> >>>>         
> >>> We could try to come up with a solution at least for allowing clean
> >>> upgrades from F8 (w/o any caps) to F9 (likely w/ peer cap defined)
> >>> without requiring manual user intervention for dealing with local
> >>> modules.
> >>>
> >>>       
> >> This was my exact objection to using an intersection or equivalence. IMO 
> >> it is incompatible to require all modules to be the same and to also 
> >> require upgrades to work without manual intervention.
> >>
> >> Do you still think unioning is wrong?
> >>     
> >
> > Yes, I'm still against (automatic, default) unioning of the capabilities
> > by the linker - that is clearly not a safe default.  semodule could
> > possibly override that behavior based on an option though, at which
> > point the %post scriptlet in the policy rpm could use that option if we
> > wanted to force it w/o user intervention.
> >
> >   
> 
> And when a user installs a new module via audit2allow they have to know 
> to select --ignore-stuff-the-modules-say-and-do-something-else-anyway? I 
> don't like this idea either.

Shrug.  Then we'll just go with equivalence only, and the user will have
to remove local modules before upgrade.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
