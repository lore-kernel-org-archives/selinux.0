Subject: Re: [patch 0/2] policy capability support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Todd Miller <Tmiller@tresys.com>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <475826F2.1000601@manicmethod.com>
References: <20071205184848.180973622@tresys.com>
	 <200712051421.39624.paul.moore@hp.com>
	 <6FE441CD9F0C0C479F2D88F959B0158801455FBA@exchange.columbia.tresys.com>
	 <1196883697.16006.103.camel@moss-spartans.epoch.ncsc.mil>
	 <4757073B.70907@manicmethod.com>
	 <1196886844.16006.117.camel@moss-spartans.epoch.ncsc.mil>
	 <47570BAC.3050705@manicmethod.com>
	 <1196887806.16006.131.camel@moss-spartans.epoch.ncsc.mil>
	 <4757109B.2080209@manicmethod.com>
	 <1196954491.27508.15.camel@moss-spartans.epoch.ncsc.mil>
	 <475826F2.1000601@manicmethod.com>
Content-Type: text/plain
Date: Thu, 06 Dec 2007 13:08:06 -0500
Message-Id: <1196964486.27508.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-12-06 at 11:44 -0500, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > A typical module author won't know what capabilities his module
> > requires, and in at least common cases, the capabilities required will
> > actually depend on the implementations of the interfaces he is using.
> > Thus, a given refpolicy interface will likely include policycap
> > statements for the capabilities required by that interface, e.g. the
> > network permission interfaces would require the network_peer_controls
> > capability if they are implemented using those checks rather than the
> > legacy ones.
> >
> >   
> 
> either that or the policy_module macro will define all caps that the 
> refpolicy is written with respect to, this should fix audit2allow as well.

On second thought, doing it per-interface won't work because
capabilities have to be defined policy-wide under intersection or
equivalence and a module that doesn't involve network rules wouldn't get
the network peer capability if it didn't use the network interfaces.

But if using policy_module(), we are effectively just importing the
capabilities expected by the "base" policy into every module at module
build time (or link time if that is turned into a link-time interface),
in which case we might as well just import them from the base module at
link time rather than duplicating them into each individual modules and
creating more potential failure cases (e.g. building against different
versions of the headers).  If someone upgrades their "base" module to
one that enables a given capability, we can generally expect that they
want that capability used.  Whereas merely inserting a local module that
happened to get built against newer headers with network peer capability
really shouldn't override what the base wanted, IMHO.

Doing all of policy capability determination at module build time (for
other than base) also seems to set us up for the same kinds of problems
we've seen with changes to kernel classes/perms in the past - build a
module against newer headers and it could suddenly force on (union) or
off (intersection) a capability needed by the rest of the policy, or
just prevent module insertion (equivalence) altogether.  Whereas inherit
from base just works.

> > For raw audit2allow output (no refpolicy interface matching),
> > audit2allow itself has to determine the capabilities required and insert
> > policycap statements accordingly.  Do we still need to support that mode
> > of operation, or can we turn on -R by default going forward for
> > audit2allow so that we always use refpolicy interfaces?
> >
> >   
> 
> My main concern is audit2allow generated modules that have already been 
> generated and the source is no longer available. It would be ashame if 
> the people who are actually using selinux and generating local modules 
> don't get to take advantage of the new access control because they have 
> old non-upgradable modules.

Right, but inherit-from-base at link time solves that problem too.

> > Also interesting to think about how policycaps get determined for a
> > module in a world where refpolicy interfaces are link-time expanded
> > rather than compiled into the module - there the actual caps for the
> > module won't be known until link.
> >
> >   
> 
> Fortunately I think the module binary format will be long gone by the 
> time interfaces are link-time expanded so that may not be a problem.

Well, the point was that we then have a situation where the module
doesn't directly declare capabilities but instead inherits them from
another module at link time.

> > Overall, I have to wonder if we are really buying anything via
> > per-module capability declaration vs. per-policy.  The only reason you
> > tried to make it per-module was you were trying to drop distinctions
> > between base and non-base, right?  But maybe we shouldn't be so
> > concerned with having a notion of a base module even if we reduce the
> > differences between what is supported by base vs. non-base
> 
> At first that was my reason but after talking it seems like doing it in 
> base is bad for the same reason that allowing a single module to turn on 
> a cap is. Why should base be able to turn on the cap if all the other 
> modules aren't written wrt the cap?

Upgrade of base usually reflects a full policy update, whereas inserting
a random module does not.  And if base doesn't work (e.g. doesn't have
the capabilities it requires), then the system likely won't boot or
function at all (modulo legacy rules).  I'm more comfortable with
letting base dictate the policy capabilities than other modules.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
