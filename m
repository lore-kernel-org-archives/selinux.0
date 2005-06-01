Subject: Re: [Patch 2/3] Loadable policy module infrastructure
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <1117628736.32745.31.camel@moss-spartans.epoch.ncsc.mil>
References: <1117128424.3482.20.camel@localhost>
	 <1117628736.32745.31.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 09:02:09 -0400
Message-Id: <1117630930.17444.4.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-06-01 at 08:25 -0400, Stephen Smalley wrote:
> 
> Is this an attempt to preserve type value ordering to allow easier
> comparison of the resulting binary policies before and after the
> patch?
> Shouldn't matter if using sediff, right?  I'd advise just dropping it.

Yes, it was added so that we could ensure the binaries created are the
same. sediff can verify much of the policy is the same but it still
doesn't analyze every piece of policy (eg, constraints, ocontexts, MLS)
so even though sediff showed no difference we wanted to ensure the
policies were indeed identical. I had every intention to drop this after
everyone was satisfied that it was creating policies correctly :)

Joshua


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
