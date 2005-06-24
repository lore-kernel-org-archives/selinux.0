Subject: Re: [PATCH] disallow * and ~ in rules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <200506241629.50884.russell@coker.com.au>
References: <1119543471.8955.5.camel@localhost>
	 <1119552466.8955.22.camel@localhost>
	 <1119553228.28493.197.camel@moss-spartans.epoch.ncsc.mil>
	 <200506241629.50884.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 07:35:08 -0400
Message-Id: <1119612908.12865.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 16:29 +1000, Russell Coker wrote:
> I agree for dontaudit, but disagree for auditallow.
> 
> Sometimes when debugging policy issues I want to see all the accesses to an 
> object.  Writing rules that cover everything can be a drag, and running apol 
> also takes time.  It's a lot easier to just do: auditallow * foo_t:file *;

But that can just as easily be written as:
	auditallow domain foo_t:file *;
with no loss in what it truly provides (and definite improvement in the
size of the resulting policy).  Note that we aren't eliminating use of *
in permission sets, just in type sets and role sets.  The problem with *
in type sets is that you never truly want all types (except in
assertions checking for policy errors); you only want "all process
types, i.e. domain" or "all file types, i.e. file_type", etc.

> Having role attributes would be handy.
> 
> The in_user_role() macro is a gross hack, role attributes would remove the 
> need for it.

Hmm...need a list somewhere that tracks all requests for improvements to
the policy language...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
