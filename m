Subject: Re: [RFC][PATCH] collect security labels on user processes
	generating audit messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov,
   Linux Audit Discussion <linux-audit@redhat.com>,
   James Morris <jmorris@namei.org>
In-Reply-To: <1139530450.12638.7.camel@localhost>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <1139530450.12638.7.camel@localhost>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 14:12:25 -0500
Message-Id: <1139857945.14253.112.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-09 at 18:14 -0600, Timothy R. Chavez wrote:
> Thanks.  Comments and feedback welcome.

> diff --git a/include/linux/selinux.h b/include/linux/selinux.h
> new file mode 100644
> index 0000000..7da2da3
> --- /dev/null
> +++ b/include/linux/selinux.h
> @@ -0,0 +1,70 @@
> +/*
> + * SELinux services exported to the rest of the kernel.
> + *
> + * Author: James Morris <jmorris@redhat.com>
> + *
> + * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2,
> + * as published by the Free Software Foundation.
> + */
> +#ifndef _LINUX_SELINUX_H
> +#define _LINUX_SELINUX_H
> +
> +#ifdef CONFIG_SECURITY_SELINUX
> +
> +struct sock;

You can omit the above struct declaration for your purposes, since you
aren't upstreaming the socket-related interfaces.

> +static inline int selinux_id_to_ctx(u32 ctxid, char **ctx, u32 *ctxlen)
> +{
> +	return 0;
> +}

I'd be inclined to return an error here; otherwise, the caller may
proceed to use *ctx and *ctxlen.  Or, if you want this to return 0 for a
graceful degenerate case (e.g. so that you don't need to check
selinux_available separately each time), I think you need to initialize
*ctx and *ctxlen as well to sane values.

BTW, traditionally, SELinux has viewed the terminating NUL as part of
the context string and thus as part of its length in bytes.  A
concession was made in the security server code to allow context strings
that lacked the terminating NUL when we migrated to xattrs because the
existing attr package did not include the terminating NUL (e.g. for
setfattr).

> diff --git a/kernel/audit.c b/kernel/audit.c
> index d95efd6..129b3da 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -460,11 +464,17 @@ static int audit_receive_msg(struct sk_b
>  			err = 0;
>  			ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
>  			if (ab) {
> +				if (selinux_available()) {
> +					err = selinux_id_to_ctx(sid, &ctx, &len);
> +					if (err < 0)
> +						return err;
> +				}

Is simply returning an error sufficient here?  What about the ab that
has already been allocated?

> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 96020d7..8b9eff4 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1120,6 +1120,9 @@ static int netlink_sendmsg(struct kiocb 
>  	NETLINK_CB(skb).dst_pid = dst_pid;
>  	NETLINK_CB(skb).dst_group = dst_group;
>  	NETLINK_CB(skb).loginuid = audit_get_loginuid(current->audit_context);
> +	err = security_task_getsecid(current, &NETLINK_CB(skb).secid);
> +	if (err < 0 && err != -EOPNOTSUPP)
> +		goto out;

Don't you need to kfree_skb(skb) too?  And perhaps the dummy function
should just set the sid to 0 and return 0 to avoid the extra test here
for -EOPNOTSUPP?  In fact, perhaps this hook should just return void,
thereby avoiding any need for error handling here?  In what case could
this fail, as no allocation is happening and no permission check occurs
from that hook (happens from security_netlink_send instead)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
