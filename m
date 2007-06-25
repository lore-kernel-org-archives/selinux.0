Subject: Re: regarding privilege granting
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Steve G <linux_4ever@yahoo.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <736334.35671.qm@web51504.mail.re2.yahoo.com>
References: <736334.35671.qm@web51504.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 12:07:52 -0400
Message-Id: <1182787672.27126.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-25 at 08:22 -0700, Steve G wrote:
> >> 1) Education. We've been telling users all along that SE Linux does not 
> >> grant permissions. It adds restrictions on top of DAC. To change that 
> >> now would likely confusion the casual user.
> >
> >Being able to fully manage privileges/capabilities based on Role-Based
> >Access Control and Type Enforcement has been a design goal from day one,
> >and was identified as such back in 2000.
> 
> Even if it was a design goal, that does not help with what everyone has been
> trained to understand. We've been telling people that SE Linux is safe to use
> since it does not grant any permissions, it just takes away.
> 

It's simple to retain this property - just don't allow anything with the
cap_override object. It isn't hard to check policy (in source or binary
form) for this object and it is even possible to write a verification
app for the module system to prevent the installation of modules that
include cap_override permissions.

> >  In fact, people new to SELinux are often surprised that we don't already
> > provide them with a way to give capabilities to specific programs without
> > them running as uid 0 (even initially);
> 
> I think they are surprised because the assume the worst and later are relieved to
> find out that DAC still has first vote and they still understand their system and
> can control access rights without having to learn SE Linux policy.
> 

I'm not so sure about this, but I don't think the core issue here is
user perception.

> 
> >> 2) Nothing security relavent happens without root. All of the trusted 
> >> databases require uid 0 to write to them. In some cases to read. All 
> >> applications that need special permissions have been carefully arranged to
> >> start as root and drop capabilities as they can.
> >
> >Many users don't want to have to run everything security-relevant as
> >root (even initially);
> 
> They all do. The system will not work any other way. Do you realize how many apps
> do a capability check by: if (getuid() != 0)   all those apps would break in a 
> new privilege granting scheme.
> 

Steve's point, however, is that this is a _bad_ thing. Any tool that
helps remove this unsafe behavior is helpful to security.

> >Again, this is not fundamentally different than file capabilities in terms 
> >of non-root have privs.
> 
> I don't care for that either. But its probably more likely to meet compliance
> issues since it can probably be worked into a 'find' command to scan the system
> for programs with elevated privileges.
> 

See below.

> 
> >> 3) In the few places where setuid must be used, these programs have 
> >> undergone review dozens of times for flaws. No one allows them without
> >> much review. If SE Linux gets into the business of granting privs, then I
> >> doubt people would give the apps the extra amount of review that they 
> >> should get.
> >
> >Writing SELinux policy is not easier / more prone to abuse than setting
> >the suid bit on a binary or setting file capabilities on it.
> 
> I think you are missing my point. Because there is no good way to find the apps
> with elevated privileges, admins will not do reviews to see if those apps are
> using the special powers securely. 
> 

Of course there is an easy way to find applications with elevated
privileges. Find the domains with cap_override permissions (perhaps
using sesearch), find the entrypoints to that domain, and then find all
executables labeled with those entrypoints.

I'm pretty surprised that you are making the argument that these method
of granting capabilities is harder to analyze. SELinux allows you to
understand exactly what domains have the capabilities in exactly which
situations. Since executable code is tightly bound to the domains
already finding executables that can run with additional capabilities it
not hard.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
