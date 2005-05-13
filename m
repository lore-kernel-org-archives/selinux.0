Subject: Re: Busted by constraints.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050512203716.29136.qmail@web31604.mail.mud.yahoo.com>
References: <20050512203716.29136.qmail@web31604.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 13 May 2005 07:16:04 -0400
Message-Id: <1115982964.3576.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-05-12 at 13:37 -0700, Casey Schaufler wrote:
> I seriously doubt this would be a "simple" tool.
> Two months after the event are you absolutely sure
> you are going to have all the information you need
> to reconstruct the policy and file system context
> that was in force at the time of a particular
> access attempt?

Everything we need to reproduce the denial is included in the audit
message (i.e. the relevant security contexts and object information)
except for the policy itself.  So all you need is the audit log and the
policy that was in effect at the time, and you can reproduce the
computation.  I'll make a simple patch to libsepol and a trivial utility
that does this.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
