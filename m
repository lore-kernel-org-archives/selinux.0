Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4VKgJNO020462
	for <selinux@tycho.nsa.gov>; Wed, 31 May 2006 16:42:19 -0400
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4VKgGLq023249
	for <selinux@tycho.nsa.gov>; Wed, 31 May 2006 20:42:17 GMT
Date: Wed, 31 May 2006 16:42:14 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
cc: jmorris@redhat.com, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, dhowells@redhat.com
Subject: Re: [PATCH] selinux: Kernel access key retention support for SELinux
In-Reply-To: <1149097853.2517.0.camel@moss-tarheels.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0605311635470.7334@d.namei>
References: <1149097853.2517.0.camel@moss-tarheels.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 31 May 2006, Michael LeMay wrote:


> +static void selinux_key_free (struct key *k)

Please don't leave a space between the function name and the parentheses.  
I know this is probably confusing, because unfortunately the LSM code 
does, but it's not consistent with the SELinux code nor most of the rest 
of the kernel.

> +	if (perm == 0) {
> +		return 0;
> +	}

No need for the braces.

>  static struct security_operations selinux_ops = {
>  	.ptrace =			selinux_ptrace,
>  	.capget =			selinux_capget,
> @@ -4404,6 +4457,12 @@ static struct security_operations selinu
>  	.xfrm_state_free_security =	selinux_xfrm_state_free,
>  	.xfrm_policy_lookup = 		selinux_xfrm_policy_lookup,
>  #endif
> +
> +#ifdef CONFIG_KEYS
> +	.key_alloc = selinux_key_alloc,
> +	.key_free = selinux_key_free,
> +	.key_permission = selinux_key_permission,
> +#endif

Inconsistent indenting of the functions with existing code.


> +   S_(SECCLASS_KEY, KEY__VIEW, "view")
> +   S_(SECCLASS_KEY, KEY__READ, "read")

What's the difference between reading and viewing a key?



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
