Subject: RE: User object manager context location
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Joshua Brindle <jbrindle@tresys.com>
Cc: ewalsh@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885146B9@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885146B9@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 15:43:37 -0500
Message-Id: <1162241017.25643.65.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-27 at 18:37 -0400, Joshua Brindle wrote:
> > From: James Carter [mailto:jwcart2@epoch.ncsc.mil] 
> > 
> > On Fri, 2006-10-27 at 15:13 -0400, Joshua Brindle wrote:
> > > I still don't buy this, if for no other reason than the object 
> > > labeling (even defaults) are owned by the application, not 
> > semanage, 
> > > not the policy. These are a resource of the application. What will 
> > > matchpathcon return if there is no file for that object 
> > class? Is it 
> > > going to default to an initial sid that may not even make 
> > sense for that object class?
> > 
> > Every object class should have its own default context.
> > 
> 
> And that default context comes from here? 

I'm sorry, I think you lost me.  Where is "here"?
I don't think any of this would be handled by semanage.

> I assume it should be the
> object manager that determines the default context, how else would it
> work? 

I don't think that I've been clear.

What I mean by a default context is something like an initial sid used
by the kernel.  The kernel always has something that it can use that is
guaranteed to be valid and that is independent of the policy.  It seemed
like userspace object managers could use something like that.  

What I had envisioned is that there would be some function that, given
the security class, would return the string representation of the
default context (or the user-space sid, which is a struct) for that
class.  The policy would have some way to define the default context for
each object class.

D-Bus uses the context of the system bus for its default context, GConf
could use the context of the configuration server for its default
context, and talking to Eamon, it doesn't seem like he needs this sort
of thing for the X server, so maybe there really isn't a need for this
after all.

> In that case storing the default context separate from the
> "actual" contexts is strange anyway. "actual" here is a loose concept
> since it could be authoritative (eg., policy server uses its context
> file only) or not authoritative (eg., file contexts where the initial
> contexts are stored with the policy but the real contexts are stored
> with the object).
> 
> Not that it matters but I still haven't heard really compelling reasons
> either way..
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
