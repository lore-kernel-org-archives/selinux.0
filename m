From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] disallow * and ~ in rules
Date: Thu, 23 Jun 2005 15:29:07 -0400
Cc: selinux <selinux@tycho.nsa.gov>
References: <1119543471.8955.5.camel@localhost> <1119552466.8955.22.camel@localhost> <1119553228.28493.197.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1119553228.28493.197.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200506231529.07106.jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 23 June 2005 15:00, Stephen Smalley wrote:
> On Thu, 2005-06-23 at 14:47 -0400, Joshua Brindle wrote:
> > I agree that neverallow has very legitimate reasons for * but dontaudit
> > and auditallow are a little less clear. Perhaps auditallow should allow
> > *, it's conceivable that someone would want to audit all access to an
> > object (though in the current policies and reference policy * would have
> > the same net effect as domain with fewer avtab entries). This may not be
> > the case for all policies though. The attached patch disallows it in all
> > rule types but neverallow.
>
> Yes, I think requiring people to use an attribute like domain or
> file_type is preferable anyway; otherwise you end up with massive
> explosion in the set of rules for a lot of types that can't possibly be
> used in that manner anyway.
>

agreed.

> > I forgot to mention constraints, which currently allow * and ~, any
> > thoughts on this?
>
> I'd exclude * and ~ entirely in type sets except for neverallow.  In
> every other case, we should be using type attributes (like domain or
> file_type) and type set exclusion rather than * or ~.   For permission
> sets, I think they are useful.  For role sets, I'm not sure - we don't
> have a parallel to attributes for roles, so there is no easy way to say
> all roles or all roles except X,Y,Z in any other way.

in the constraint case * seems to be entirely unnecessary. However I'm not 
convinced that a compliment would never be useful in a constraint. 

As for roles, it certainly isn't an issue now but one can easily concieve a 
policy that creates a role for each user on the system. Then something like 
allow system_r * would actually make sense (err, more sense than now) but 
still isn't the best way, which would be adding the allow when the role is 
created. I don't think it's a problem to remove * and ~ from role sets, at 
least not yet.

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
