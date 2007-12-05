Subject: RE: [patch 0/2] policy capability support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Todd Miller <Tmiller@tresys.com>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <jbrindle@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158801455FBA@exchange.columbia.tresys.com>
References: <20071205184848.180973622@tresys.com>
	 <200712051421.39624.paul.moore@hp.com>
	 <6FE441CD9F0C0C479F2D88F959B0158801455FBA@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 05 Dec 2007 14:41:37 -0500
Message-Id: <1196883697.16006.103.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-05 at 14:30 -0500, Todd Miller wrote:
> Paul Moore wrote:
> > The discussion for this appears to have gone quiet (at least I
> > haven't seen anything else on this list).  Where do things currently
> > stand?
> 
> At this point I'd be OK with requiring equivalence and throwing an error
> otherwise.  I do think that this will result in usability issues that we
> will have to address once people start using the caps.  However, with
> only
> a single cap defined so far it is not really possible to know how these
> will end up being used.

We could try to come up with a solution at least for allowing clean
upgrades from F8 (w/o any caps) to F9 (likely w/ peer cap defined)
without requiring manual user intervention for dealing with local
modules.

There are however plenty of other ways in which a policy upgrade can
break at present.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
