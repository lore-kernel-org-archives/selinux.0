From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] disallow * and ~ in rules
Date: Fri, 24 Jun 2005 16:29:46 +1000
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux <selinux@tycho.nsa.gov>
References: <1119543471.8955.5.camel@localhost> <1119552466.8955.22.camel@localhost> <1119553228.28493.197.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1119553228.28493.197.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200506241629.50884.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 24 June 2005 05:00, Stephen Smalley <sds@tycho.nsa.gov> wrote:
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

I agree for dontaudit, but disagree for auditallow.

Sometimes when debugging policy issues I want to see all the accesses to an 
object.  Writing rules that cover everything can be a drag, and running apol 
also takes time.  It's a lot easier to just do: auditallow * foo_t:file *;

> sets, I think they are useful.  For role sets, I'm not sure - we don't
> have a parallel to attributes for roles, so there is no easy way to say
> all roles or all roles except X,Y,Z in any other way.

Having role attributes would be handy.

The in_user_role() macro is a gross hack, role attributes would remove the 
need for it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
