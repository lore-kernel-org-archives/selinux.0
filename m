Subject: Re: [PATCH] disallow * and ~ in rules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1119552466.8955.22.camel@localhost>
References: <1119543471.8955.5.camel@localhost>
	 <1119549285.28493.173.camel@moss-spartans.epoch.ncsc.mil>
	 <1119552466.8955.22.camel@localhost>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 15:00:28 -0400
Message-Id: <1119553228.28493.197.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-23 at 14:47 -0400, Joshua Brindle wrote:
> I agree that neverallow has very legitimate reasons for * but dontaudit
> and auditallow are a little less clear. Perhaps auditallow should allow
> *, it's conceivable that someone would want to audit all access to an
> object (though in the current policies and reference policy * would have
> the same net effect as domain with fewer avtab entries). This may not be
> the case for all policies though. The attached patch disallows it in all
> rule types but neverallow. 

Yes, I think requiring people to use an attribute like domain or
file_type is preferable anyway; otherwise you end up with massive
explosion in the set of rules for a lot of types that can't possibly be
used in that manner anyway.

> I forgot to mention constraints, which currently allow * and ~, any
> thoughts on this?

I'd exclude * and ~ entirely in type sets except for neverallow.  In
every other case, we should be using type attributes (like domain or
file_type) and type set exclusion rather than * or ~.   For permission
sets, I think they are useful.  For role sets, I'm not sure - we don't
have a parallel to attributes for roles, so there is no easy way to say
all roles or all roles except X,Y,Z in any other way.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
