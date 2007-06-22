Subject: Re: [patch 1/3] libsemanage: genhomedircon replacement
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, Mark Goldman <mgoldman@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <467AE59E.2050501@tycho.nsa.gov>
References: <20070521095414.832619201@tresys.com>
	 <20070521095518.515998898@tresys.com>
	 <1179868119.9092.38.camel@localhost.localdomain>
	 <1180015458.3930.173.camel@tresys-winxppro>
	 <1180017921.2940.24.camel@localhost.localdomain>
	 <1180034401.3930.203.camel@tresys-winxppro>
	 <1180108369.6331.18.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BEFF95@exchange.columbia.tresys.com>
	 <1180137749.10334.18.camel@localhost.localdomain>
	 <4677F1BC.2000201@tresys.com>
	 <1182443353.11527.50.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588D01904@exchange.columbia.tresys.com>
	 <1182449086.11527.80.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588D01920@exchange.columbia.tresys.com>
	 <1182449898.11527.83.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588D01928@exchange.columbia.tresys.com>
	 <1182450900.11527.88.camel@localhost.localdomain>
	 <467AE59E.2050501@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 22 Jun 2007 11:22:14 -0400
Message-Id: <1182525734.3014.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-21 at 16:54 -0400, Eamon Walsh wrote:
> Karl MacMillan wrote:
> > On Thu, 2007-06-21 at 14:25 -0400, Joshua Brindle wrote:
> >> Karl MacMillan wrote:
> >>> On Thu, 2007-06-21 at 14:09 -0400, Joshua Brindle wrote:

[...]

> >> Not to mention running a python interpreter from a library is pretty
> >> lame.
> > 
> > Why? It's less lame than doing this string manipulation in C if you ask
> > me. Not to mention safer - the kind of string manipulation done for this
> > is perhaps the biggest source of exploitable flaws in software.
> 
> I'm going to do the unthinkable and agree with Josh,

Now, now, I agree with Josh all the time.

>  I think the 
> solution to this is to write correct code, not to give up and use a 
> scripting language.

Because writing correct code has worked so well for all of those other
projects with exploitable flaws . . .

>   I'm not a fan of the Python dependencies.
> 

Why?

> > 
> > [...]
> > 
> >>> Think about a process to verify untrusted data (like modules)
> >>> - it would be helpful to allow a separate process to examine
> >>> that data. Yes things like semodule will have full access but
> >>> allowing a lower-privileged process to handle some parts is desirable
> >>> in my opinion. 
> >> We already have a facility to run external apps that can do that. In
> >> semanage.conf just do:
> >>
> >> [verify module]
> >> path=/some/path/to/checker
> >> [end]
> >>
> >> Which has nothing to do with genhomedircon, genhomedircon is mutating
> >> the store, we should not be providing a facility to let random programs
> >> mutate the store arbitrarilly.
> > 
> > My point (that seems to be getting lost) is that genhomedircon is not an
> > arbitrary program. It's just part of libsemanage. Why shouldn't we allow
> > separate processes to mutate the store if they are built-in to
> > libsemanage?
> 
> Running helpers from a library is IMO a bad idea, because it's not easy 
> to completely insulate helper processes from the caller.  Caller could 
> get unexpected results from an ill-timed wait(2) call for example, or 
> not be expecting strange things in its process tree.
> 

I'm not convinced by this. First, we've been doing this for a long time
and haven't had a single problem. Second, libsemanage is not a typical
library (like, say, libm). Callers likely need to be fairly familiar
with how it works and use it carefully.

Other than being in-process, what are the other advantageous of writing
this in C (I've heard none). If it is just making it in-process why
don't we just embed the python interpreter :)

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
