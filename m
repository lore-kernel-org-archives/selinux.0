Subject: Re: PAM security transitions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vikram Ambrose <Vikram.Ambrose@windriver.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48AF21C3.9020506@windriver.com>
References: <48AF21C3.9020506@windriver.com>
Content-Type: text/plain
Date: Mon, 25 Aug 2008 07:45:25 -0400
Message-Id: <1219664725.2721.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-08-22 at 16:29 -0400, Vikram Ambrose wrote:
> I've been messing around with various modules and installations and I've 
> come across a strange PAM problem. Without any SELinux support in 
> pam.d/login, root's shell gets system_r:local_login_t

Yes, we stopped patching login directly a long time ago, and thus use of
pam_selinux is required to get login session contexts set properly.

> But then using: pam_selinux.so close/open, root's shell gets 
> root:staff_r:system_chkpwd_t
> 
> I have another installation with the same pam config, but it gets the 
> correct root:sysadm_r:sysadm_t context. This system uses a different policy.
> 
> Trying to debug this. Any ideas why one of my boxes gets the wrong 
> domain after login?

Based on your own description, it is presumably a bug in the policy on
that system.  pam_selinux should map the Linux user to a SELinux user
via the seusers mapping, then ask the kernel for a list of reachable
security contexts for that SELinux user from the calling context (e.g.
system_u:system_r:local_login_t), then order that list based on the
default_contexts file's entry for the calling context.

libselinux/utils/getdefaultcon will let you exercise much the same
logic, e.g.
	getdefaultcon vikram system_u:system_r:local_login_t

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
