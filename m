Subject: RE: [patch 1/3] libsemanage: genhomedircon replacement
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, Mark Goldman <mgoldman@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588D019AE@exchange.columbia.tresys.com>
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
	 <1182525734.3014.20.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588D019AE@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 22 Jun 2007 12:04:47 -0400
Message-Id: <1182528287.3014.29.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-06-22 at 11:31 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Thu, 2007-06-21 at 16:54 -0400, Eamon Walsh wrote:
> >> Karl MacMillan wrote:
> >>> On Thu, 2007-06-21 at 14:25 -0400, Joshua Brindle wrote:
> >>>> Karl MacMillan wrote:
> >>>>> On Thu, 2007-06-21 at 14:09 -0400, Joshua Brindle wrote:
> 
> > 
> > I'm not convinced by this. First, we've been doing this for a
> > long time and haven't had a single problem. Second,
> > libsemanage is not a typical library (like, say, libm).
> > Callers likely need to be fairly familiar with how it works and use
> > it carefully. 
> > 
> > Other than being in-process, what are the other advantageous
> > of writing this in C (I've heard none). If it is just making
> > it in-process why don't we just embed the python interpreter :)
> >
> 
> Wow, talk about hacky... Anyway, I've already told you the advantage.

Err - you mentioned generating labels for object managers (could be done
in genhomedircon) and the locking issues that I've addressed.

> We'll have to get rid of genhomedircon as it currently exists (as an
> independent user of libsemanage itself) and completely rewrite it to
> operate on the sandbox to get equivalent functionality.

That is a bit of an overstatement - I don't think the changes would be
hard.

>  The C rewrite is
> already complete and is consistent with the way the rest of libsemanage
> works (doing work in the sandbox in the library). Why should
> genhomedircon be different than any of the other activities libsemanage
> does on the files in the sandbox (including parsing, rewriting, etc)?
> 

Because this type of string manipulation is so painful in C. Can you
post a more recent patch - I just looked and couldn't find a new patch
that addressed the comments in the archives. The original version had
some fairly significant flaws, including potentially security relevant
flaws (which doesn't help the "let's just implement it correctly"
argument).

> IIRC running genhomedircon out of the library was always considered
> temporary until we got around to rewriting it to be a proper part of the
> library, I'm not sure why you are objecting so strongly, this is the
> natural progression. This also makes it much easier to use modular
> policy in embedded deployments since they often do not have python. With
> libpolicyrep being in c++ and libsemanage being completely in C one
> could use policy modules without python altogether (and even reimplement
> parts of semanage in C if that functionality were desired)

Removing the dependency is fairly nice - but I'm not convinced that
embedded environments will use modular policy.

I'm not totally against this - it's just that the C version is always
going to be ugly.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
