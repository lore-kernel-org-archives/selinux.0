Subject: Re: [patch 0/2] policy capability support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Todd Miller <Tmiller@tresys.com>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <4758684C.9040409@manicmethod.com>
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
	 <1196964486.27508.107.camel@moss-spartans.epoch.ncsc.mil>
	 <4758684C.9040409@manicmethod.com>
Content-Type: text/plain
Date: Thu, 06 Dec 2007 16:42:58 -0500
Message-Id: <1196977378.27508.235.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-12-06 at 16:23 -0500, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Thu, 2007-12-06 at 11:44 -0500, Joshua Brindle wrote:
> >   
> >> Stephen Smalley wrote:
> >>     
> >>> Overall, I have to wonder if we are really buying anything via
> >>> per-module capability declaration vs. per-policy.  The only reason you
> >>> tried to make it per-module was you were trying to drop distinctions
> >>> between base and non-base, right?  But maybe we shouldn't be so
> >>> concerned with having a notion of a base module even if we reduce the
> >>> differences between what is supported by base vs. non-base
> >>>       
> >> At first that was my reason but after talking it seems like doing it in 
> >> base is bad for the same reason that allowing a single module to turn on 
> >> a cap is. Why should base be able to turn on the cap if all the other 
> >> modules aren't written wrt the cap?
> >>     
> >
> > Upgrade of base usually reflects a full policy update, whereas inserting
> > a random module does not.  And if base doesn't work (e.g. doesn't have
> > the capabilities it requires), then the system likely won't boot or
> > function at all (modulo legacy rules).  I'm more comfortable with
> > letting base dictate the policy capabilities than other modules.
> >
> >   
> 
> I am not comfortable with base changing anything about other modules. If 
> base can turn on capabilities without regard to the modules being 
> installed then everything built as modules that uses network controls 
> (or whatever future caps affect) suddenly don't work. I also don't want 
> to just punt on this decision for now because we don't know the answer, 
> we'll have to answer it eventually if we successfully get rid of the 
> base vs. module distinction.

If you aren't comfortable with base enabling capabilities without regard
to the other modules, then you aren't comfortable with the union
proposal anymore.  So where does that leave you?  With Chris on the
intersection proposal?  See my comments there.

When does base get updated?  When we are updating the entire policy,
typically all in a single libsemanage transaction.  At what time do we
want to gain new capabilities?  When we are updating the entire policy.
What capabilities do we want audit2allow-generated modules to inherit?
The same as the base system policy.

Where would the policycap statements come from if we kept them
per-module?  From the policy_module definition provided by...the base
policy against which the module was built.

Maybe I'm missing something but it all leads back to the base module
providing the definitions, and if we're moving toward link-time
expansion of interfaces, then they'll end up coming from the base module
at link time anyway then.

As for base vs. non-base, I'm all for making non-base modules more
functional, but that doesn't mean that semodule -b is going away
(compatibility of user interfaces and all that) or that we can't retain
a notion of a special base module that defines certain policy-wide
properties (a useful thing, even if the rest of the policy is fully
modularized).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
