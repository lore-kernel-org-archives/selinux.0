Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Chad Sellers <csellers@tresys.com>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <Line.LNX.4.64.0706141334280.19226@localhost.localdomain>
References: <C296F304.23443%csellers@tresys.com>
	 <Line.LNX.4.64.0706141334280.19226@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 14 Jun 2007 13:47:06 -0400
Message-Id: <1181843226.17547.669.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-14 at 13:35 -0400, James Morris wrote:
> On Thu, 14 Jun 2007, Chad Sellers wrote:
> 
> > Yes, it's definitely an interesting scenario, when a program can succeed in
> > enforcing but fail in permissive. Though it might help us convince more
> > people to run in enforcing ;-)
> 
> ITYM "convince more people to disable SELinux"

Actually, the funny thing there is that selinux=0 would have the same
effect if you had stripped the suid bits.  Those applications would
_only_ work with selinux enabled and enforcing.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
