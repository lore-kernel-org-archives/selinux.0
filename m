Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7QBohOb023634
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2005 07:50:43 -0400 (EDT)
Subject: Re: [PATCH] remove selinux stacked ops
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: James Morris <jmorris@namei.org>, linux-security-module@wirex.com,
   selinux@tycho.nsa.gov
In-Reply-To: <20050825225104.GC7762@shell0.pdx.osdl.net>
References: <20050825221732.GR7991@shell0.pdx.osdl.net>
	 <20050825225104.GC7762@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 07:48:26 -0400
Message-Id: <1125056906.5812.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-08-25 at 15:51 -0700, Chris Wright wrote:
> @@ -3620,13 +3523,6 @@ static int selinux_netlink_send(struct s
>  	return err;
>  }
>  
> -static int selinux_netlink_recv(struct sk_buff *skb)
> -{
> -	if (!cap_raised(NETLINK_CB(skb).eff_cap, CAP_NET_ADMIN))
> -		return -EPERM;
> -	return 0;
> -}
> -

Hmm...is removing this entirely safe?  Given that dummy is being
removed, and null ops are no longer being populated, don't we have to
ensure that we define a SELinux hook function for every cap_ function
and explicitly call that function?  Likewise, don't we now have to add a
settime hook to SELinux to preserve behavior?  Previously, it was
defaulting to the dummy hook, which conveniently called capable(), so it
ended up working regardless of whether SELinux was stacked with dummy or
capability.

> @@ -4278,14 +4138,12 @@ static struct security_operations selinu
>  	.vm_enough_memory =		selinux_vm_enough_memory,
>  
>  	.netlink_send =			selinux_netlink_send,
> -        .netlink_recv =			selinux_netlink_recv,

Ditto.

> @@ -4433,9 +4288,7 @@ static __init int selinux_init(void)
>  
>  	avc_init();
>  
> -	original_ops = secondary_ops = security_ops;
> -	if (!secondary_ops)
> -		panic ("SELinux: No initial security operations\n");
> +	original_ops = security_ops;
>  	if (register_security (&selinux_ops))
>  		panic("SELinux: Unable to register with kernel.\n")

At the point this is executed, security_ops == &default_security_ops;
hence...

> @@ -4568,8 +4421,8 @@ int selinux_disable(void)
>  
>  	selinux_disabled = 1;
>  
> -	/* Reset security_ops to the secondary module, dummy or capability. */
> -	security_ops = secondary_ops;
> +	/* Reset security_ops to the default */
> +	security_ops = original_ops;
>  
>  	/* Unregister netfilter hooks. */
>  	selinux_nf_ip_exit();

a runtime disable of SELinux by /sbin/init (upon finding
SELINUX=disabled in /etc/selinux/config) ends up leaving us with null
ops rather than the capability or dummy ops.  Thus, SELINUX=disabled
turns off all security ;(

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
