Subject: Re: Starting applications from initrc in a user's context?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: mike@theptrgroup.com, SElinux <SELinux@tycho.nsa.gov>
In-Reply-To: <200501042103.15885.russell@coker.com.au>
References: <41CAE132.3020504@theptrgroup.com>
	 <200501042103.15885.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1105548854.22495.136.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 11:54:14 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-04 at 05:03, Russell Coker wrote:
> Allowing the role to be changed requires adding privrole to the attributes of 
> domain initrc_t.  In that case either the identity system_u must be permitted 
> to have the role user1_r or initrc_t also needs the privuser attribute so it 
> can launch a process with a different identity.

Role changes also require a role allow rule, e.g.
allow foo_r bar_r;

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
