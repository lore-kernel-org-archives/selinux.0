Subject: Re: Yet another question - newrole and xterm's
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Michael Reilly <michaelr@cisco.com>
Cc: SELinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <20031015191716.5478c74b.michaelr@cisco.com>
References: <20031015191716.5478c74b.michaelr@cisco.com>
Content-Type: text/plain
Message-Id: <1066307222.24561.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 16 Oct 2003 08:27:02 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-15 at 22:17, Michael Reilly wrote:
> I found this in newrole.te.
> # Failed reads to /proc cause no harm, so do not audit them
> dontaudit newrole_t proc_t:dir search;
> 
> changing the dontaudit line to this and reloading the policy
> allow newrole_t proc_t:dir search;

This is peculiar, as newrole.te also includes:
	can_setexec(newrole_t)

and can_setexec() includes:
	allow $1 proc_t:dir search;

So this permission should already be allowed.  In fact, I see the
following result in policy.conf without making any change:
$ grep 'allow newrole_t proc_t:dir' /etc/security/selinux/src/policy.conf
allow newrole_t proc_t:dir search;

I assume that the dontaudit rule is a legacy from the old SELinux,
before the /proc/pid/attr API, where newrole did not have a legitimate
need to access it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
