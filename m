Subject: Re: [PATCH] disallow * and ~ in rules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <200506242324.33247.russell@coker.com.au>
References: <1119543471.8955.5.camel@localhost>
	 <200506241629.50884.russell@coker.com.au>
	 <1119612908.12865.11.camel@moss-spartans.epoch.ncsc.mil>
	 <200506242324.33247.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 09:29:44 -0400
Message-Id: <1119619784.12865.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 23:24 +1000, Russell Coker wrote:
> I just did a quick test and found a .3% size difference.  I'm surprised, I had 
> expected that as auditallow doesn't permit an operation the rules would not 
> result in anything in the binary policy for an operation which is not 
> permitted.  Does the current behavior really make sense?

checkpolicy isn't that smart, at least not presently ;)
Same core logic is shared for allow/auditallow/auditdeny/dontaudit, see
te_avtab_helper() in policy_parse.y.  Yes, we could have it optimize
away auditallow entries for which no corresponding allow entry exists.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
