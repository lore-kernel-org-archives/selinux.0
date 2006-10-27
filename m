MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: User object manager context location
Date: Fri, 27 Oct 2006 18:37:46 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015885146B9@exchange.columbia.tresys.com>
In-Reply-To: <1161979543.27616.35.camel@moss-lions.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <jwcart2@epoch.ncsc.mil>
Cc: <ewalsh@tycho.nsa.gov>, "Stephen Smalley" <sds@tycho.nsa.gov>,
        <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: James Carter [mailto:jwcart2@epoch.ncsc.mil] 
> 
> On Fri, 2006-10-27 at 15:13 -0400, Joshua Brindle wrote:
> > I still don't buy this, if for no other reason than the object 
> > labeling (even defaults) are owned by the application, not 
> semanage, 
> > not the policy. These are a resource of the application. What will 
> > matchpathcon return if there is no file for that object 
> class? Is it 
> > going to default to an initial sid that may not even make 
> sense for that object class?
> 
> Every object class should have its own default context.
> 

And that default context comes from here? I assume it should be the
object manager that determines the default context, how else would it
work? In that case storing the default context separate from the
"actual" contexts is strange anyway. "actual" here is a loose concept
since it could be authoritative (eg., policy server uses its context
file only) or not authoritative (eg., file contexts where the initial
contexts are stored with the policy but the real contexts are stored
with the object).

Not that it matters but I still haven't heard really compelling reasons
either way..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
