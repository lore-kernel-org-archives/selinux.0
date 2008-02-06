Date: Wed, 6 Feb 2008 11:15:00 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC][PATCH] selinux:  support 64-bit capabilities
Message-ID: <20080206171500.GB17288@sergelap.austin.ibm.com>
References: <1202314924.27371.163.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1202314924.27371.163.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks, Stephen.

I'd thought setfcap was already there, hence my only sending the patch
for refpolicy...

thanks,
-serge

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> 64-bit capability support has gone into mainline.
> Update SELinux to correctly handle 64-bit capabilities.
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e5ed075..fa4b021 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1278,6 +1278,8 @@ static int task_has_capability(struct task_struct *tsk,
>  {
>  	struct task_security_struct *tsec;
>  	struct avc_audit_data ad;
> +	u16 sclass;
> +	u32 av = CAP_TO_MASK(cap);	
> 
>  	tsec = tsk->security;
> 
> @@ -1285,8 +1287,17 @@ static int task_has_capability(struct task_struct *tsk,
>  	ad.tsk = tsk;
>  	ad.u.cap = cap;
> 
> -	return avc_has_perm(tsec->sid, tsec->sid,
> -			    SECCLASS_CAPABILITY, CAP_TO_MASK(cap), &ad);
> +	switch (CAP_TO_INDEX(cap)) {
> +	case 0:
> +		sclass = SECCLASS_CAPABILITY;
> +		break;
> +	case 1:
> +		sclass = SECCLASS_CAPABILITY2;
> +		break;
> +	default:
> +		return -EPERM;
> +	}
> +	return avc_has_perm(tsec->sid, tsec->sid, sclass, av, &ad);
>  }
> 
>  /* Check whether a task is allowed to use a system operation. */
> diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
> index 399f868..d569669 100644
> --- a/security/selinux/include/av_perm_to_string.h
> +++ b/security/selinux/include/av_perm_to_string.h
> @@ -132,6 +132,9 @@
>     S_(SECCLASS_CAPABILITY, CAPABILITY__LEASE, "lease")
>     S_(SECCLASS_CAPABILITY, CAPABILITY__AUDIT_WRITE, "audit_write")
>     S_(SECCLASS_CAPABILITY, CAPABILITY__AUDIT_CONTROL, "audit_control")
> +   S_(SECCLASS_CAPABILITY, CAPABILITY__SETFCAP, "setfcap")
> +   S_(SECCLASS_CAPABILITY2, CAPABILITY2__MAC_OVERRIDE, "mac_override")
> +   S_(SECCLASS_CAPABILITY2, CAPABILITY2__MAC_ADMIN, "mac_admin")
>     S_(SECCLASS_NETLINK_ROUTE_SOCKET, NETLINK_ROUTE_SOCKET__NLMSG_READ, "nlmsg_read")
>     S_(SECCLASS_NETLINK_ROUTE_SOCKET, NETLINK_ROUTE_SOCKET__NLMSG_WRITE, "nlmsg_write")
>     S_(SECCLASS_NETLINK_FIREWALL_SOCKET, NETLINK_FIREWALL_SOCKET__NLMSG_READ, "nlmsg_read")
> diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
> index 84c9abc..75b4131 100644
> --- a/security/selinux/include/av_permissions.h
> +++ b/security/selinux/include/av_permissions.h
> @@ -533,6 +533,9 @@
>  #define CAPABILITY__LEASE                         0x10000000UL
>  #define CAPABILITY__AUDIT_WRITE                   0x20000000UL
>  #define CAPABILITY__AUDIT_CONTROL                 0x40000000UL
> +#define CAPABILITY__SETFCAP                       0x80000000UL
> +#define CAPABILITY2__MAC_OVERRIDE                 0x00000001UL
> +#define CAPABILITY2__MAC_ADMIN                    0x00000002UL
>  #define NETLINK_ROUTE_SOCKET__IOCTL               0x00000001UL
>  #define NETLINK_ROUTE_SOCKET__READ                0x00000002UL
>  #define NETLINK_ROUTE_SOCKET__WRITE               0x00000004UL
> diff --git a/security/selinux/include/class_to_string.h b/security/selinux/include/class_to_string.h
> index b1b0d1d..bd813c3 100644
> --- a/security/selinux/include/class_to_string.h
> +++ b/security/selinux/include/class_to_string.h
> @@ -71,3 +71,4 @@
>      S_(NULL)
>      S_(NULL)
>      S_("peer")
> +    S_("capability2")
> diff --git a/security/selinux/include/flask.h b/security/selinux/include/flask.h
> index 09e9dd2..febf886 100644
> --- a/security/selinux/include/flask.h
> +++ b/security/selinux/include/flask.h
> @@ -51,6 +51,7 @@
>  #define SECCLASS_DCCP_SOCKET                             60
>  #define SECCLASS_MEMPROTECT                              61
>  #define SECCLASS_PEER                                    68
> +#define SECCLASS_CAPABILITY2                             69
> 
>  /*
>   * Security identifier indices for initial entities
> 
> -- 
> Stephen Smalley
> National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
