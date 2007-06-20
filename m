Subject: Re: Per Domain Permissive Mode
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <Line.LNX.4.64.0706200748250.22479@localhost.localdomain>
References: <4677EE5B.9030405@redhat.com>
	 <Line.LNX.4.64.0706191116580.15755@localhost.localdomain>
	 <Line.LNX.4.64.0706191118420.15755@localhost.localdomain>
	 <1182267849.21615.103.camel@localhost.localdomain>
	 <1182339790.15064.80.camel@moss-spartans.epoch.ncsc.mil>
	 <Line.LNX.4.64.0706200748250.22479@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 20 Jun 2007 09:09:44 -0400
Message-Id: <1182344984.15064.92.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-20 at 07:48 -0400, James Morris wrote:
> On Wed, 20 Jun 2007, Stephen Smalley wrote:
> 
> > Similar question applies to how we provide "unconfined" domains; to
> > date, we have done so by generating all of those allow rules, but that
> > is costly in policy (somewhat mitigated by use of attributes, but
> > limited especially as we add exception cases).
> 
> Do you know how much of the kernel memory we use for policy is used by 
> this?

Not offhand.  As an experiment, I tried building policy with and without
the unconfined module, but that doesn't seem to make a large difference
in the policy file size, so perhaps it isn't so significant anymore.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
