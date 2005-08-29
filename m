Subject: Re: conditional name_bind permission check
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Spencer Shimko <sshimko@tresys.com>
Cc: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <200508261430.03861.sshimko@tresys.com>
References: <200508261430.03861.sshimko@tresys.com>
Content-Type: text/plain
Date: Mon, 29 Aug 2005 09:23:56 -0400
Message-Id: <1125321836.2179.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-08-26 at 14:30 -0400, Spencer Shimko wrote:
> While developing policy for an application we expected to see a 
> name_bind denial message at a certain point.  The message was not
> appearing in the audit logs.  Further exploration showed the avc_has_perm
> call was wrapped in a conditional that excluded the port range in question.  
> In security/selinux/hooks.c the avc_has_perm is only called if the
> following condition is met:
> 
> if (snum&&(snum < max(PROT_SOCK,ip_local_port_range_0) ||
>         snum > ip_local_port_range_1))
> 
> PROT_SOCK is defined as 1024 in the kernel.  ip_local_port_range_0
> and ip_local_port_range_1 are macros that expand to the port range
> specified in the /proc/sys/net/ipv4/ip_local_port_range sysctl interface.
> So this prevents the name_bind permission from being checked on those 
> ports reserved for local use.  What is the reason for not checking this 
> range?

Those port numbers are used to automatically bind.  Hence, while we
_could_ technically prevent their use on an explicit bind(2) call (but
writing policy governing such usage would be insane as any and every
application may try using such ports), we wouldn't be able to prevent
their use internally by the kernel for auto-binding of unbound sockets
upon other operations.  It would only offer illusory control to control
that port range upon bind(2).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
