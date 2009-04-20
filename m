Subject: Re: access(2) vs. SELinux
From: Eric Paris <eparis@redhat.com>
To: jwcart2@epoch.ncsc.mil
Cc: Joshua Brindle <method@manicmethod.com>,
        Chad Sellers <csellers@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1240255715.2841.67.camel@moss-lions.epoch.ncsc.mil>
References: <C60D0537.A684E%csellers@tresys.com>
	 <49EC8841.7050305@manicmethod.com>
	 <1240240273.2562.67.camel@localhost.localdomain>
	 <1240253727.2841.53.camel@moss-lions.epoch.ncsc.mil>
	 <1240254515.2562.113.camel@localhost.localdomain>
	 <1240255715.2841.67.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 20 Apr 2009 15:49:49 -0400
Message-Id: <1240256989.2562.201.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-04-20 at 15:28 -0400, James Carter wrote:
> On Mon, 2009-04-20 at 15:08 -0400, Eric Paris wrote:
> > On Mon, 2009-04-20 at 14:55 -0400, James Carter wrote:
> > > On Mon, 2009-04-20 at 11:11 -0400, Eric Paris wrote:
> >  
> > > > I strongly and vehemently oppose any solution that is a blanket
> > > > dontaudit on access calls, even if there is a flag to dontdonaudit.
> > > > This might be fine in "secure" shops where everyone understands and is
> > > > willing to suffer some extra SELinux pain but not here.  If SELinux gets
> > > > in the way it better scream to high heavens for my customers.
> > > > 
> > > 
> > > I think that what we need is a check to see if the domain is allowed to
> > > call access() on the object.  If it is not allowed, then a denial is
> > > generated; if it is, then the results of the desired permission check is
> > > returned, but denials are not audited.
> > > 
> > > This would better reflect what is actually happening.  When a domain
> > > calls access(), it is really reading the security properties of the
> > > object.
> > 
> > Your still just talking about a big global dontaudit hammer on the
> > EACCESS people get back from access().  Not only that, you propose a new
> > permission every domain needs of which I don't see any security benefit
> > (outside of maybe helping make sure people can't probe policy willy
> > nilly).
> > 
> If you don't care whether or not someone is probing the policy, then why
> not just always use the _noaudit interfaces?

>From where I sit, I don't care if people probe the policy.  The problem
I want to solve is that we have dontaudit rules against what I consider
valuable resources.  (eg: shadow and krb5 files)

But, I certainly understand why others might care (which is the lesser
of the two reasons I don't like the _noaudit, interface on access()).
So I think my kernel patch prototype allows the policy to decide where
it cares about probing and where it doesn't.

> What is the security benefit of the access_* permissions?  It looks like
> they are only going to be used to determine if a denial should be
> generated.

Very little security benefit other than we can remove all of the
dontaudit rules trying to read shadow_t.  Instead we'll have dontaudit
rules for trying to probe if you can read shadow_t.  Actually trying to
read shadow_t would begin to generate a denial.  Today neither activity
would generate a denial.  access_* permissions would have NO meaning
other than in the dontaudit case (could also do auditallow)

Let me summarize where I'm coming from.

Problem:
Many programs use access() to chose which code path to use thus
requesting permissions granted by DAC, but we choose to deny through
SELinux policy.  Thus we currently must dontaudit all read, write, and
execute for these situations.

Eric's Restrictions on solutions:
If SELinux denies access SELinux must is some way inform the user that
it denied access.

Other's Restrictions:
Do not make tool chain significantly more brittle?
Maintain ability to detect probing of security policy?

Am I missing something?  Does my latest kernel prototype meet these
needs?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
