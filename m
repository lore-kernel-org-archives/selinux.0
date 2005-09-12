Subject: Re: After talking to some people at Red Hat, they feal the
	translation library should be plugable
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1126542118.2999.153.camel@moss-spartans.epoch.ncsc.mil>
References: <4325A695.8050802@redhat.com>
	 <1126542118.2999.153.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 12 Sep 2005 12:46:08 -0400
Message-Id: <1126543568.2999.162.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-09-12 at 12:21 -0400, Stephen Smalley wrote:
> I thought we were going to introduce a Linux user -> { SELinux user,
> <context data> } mapping and deal with the mapping outside of libselinux
> entirely, in pam_selinux or wherever appropriate.  So pam_selinux would
> perform the lookup and pass the resulting pair to an extended version of
> get_default_context, which would generate the final context based on the
> inputs and the policy.  The <context data> could include a default role
> and a MLS range, but would just be an opaque string as far as
> pam_selinux is concerned.

Correction:  We agreed to put the lookup support for the new mapping
into libselinux (because we lost the argument about glibc nss/nscd
service for SELinux), but I think we still wanted to maintain a
separation between the lookup function that deals with the Linux user
and the extended get_default_context function that deals with the
SELinux user and auxiliary context data, with pam_selinux (and similar
code, like the openssh selinux patch and cron selinux patch) calling the
lookup function first and then passing its results to the extended
get_default_context function.  Yes?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
