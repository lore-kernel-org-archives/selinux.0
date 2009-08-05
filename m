Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n75EDtOq012910
	for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2009 10:13:55 -0400
Received: from e2.ny.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n75EEs0R020779
	for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2009 14:14:54 GMT
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n75E8DHk020843
	for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2009 10:08:13 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n75EDoP22457694
	for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2009 10:13:51 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n75EDm1n006497
	for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2009 08:13:50 -0600
Date: Wed, 5 Aug 2009 09:13:50 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Paul Moore <paul.moore@hp.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v1 1/2] lsm: Add hooks to the TUN driver
Message-ID: <20090805141350.GA353@us.ibm.com>
References: <20090804211304.10798.65601.stgit@flek.lan> <20090804212158.10798.34592.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090804212158.10798.34592.stgit@flek.lan>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Paul Moore (paul.moore@hp.com):
...
>  static int tun_attach(struct tun_struct *tun, struct file *file)
>  {
>  	struct tun_file *tfile = file->private_data;
> -	const struct cred *cred = current_cred();
> -	int err;
> +	int err = 0;
> 
>  	ASSERT_RTNL();
> 
> -	/* Check permissions */
> -	if (((tun->owner != -1 && cred->euid != tun->owner) ||
> -	     (tun->group != -1 && !in_egroup_p(tun->group))) &&
> -		!capable(CAP_NET_ADMIN))
> -		return -EPERM;
...

> @@ -935,6 +930,13 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
>  		else
>  			return -EINVAL;
> 
> +		if ((tun->owner != -1 && cred->euid != tun->owner) ||
> +		    (tun->group != -1 && !in_egroup_p(tun->group)))
> +			return -EPERM;
> +		err = security_tun_dev_attach(tun->sk);
> +		if (err < 0)
> +			return err;
> +

...

> +/**
> + * cap_tun_dev_attach - Determine if attaching to an TUN device is allowed
> + *
> + * Determine if the user is allowed to attach to an existing persistent TUN
> + * device, historically this has always required the CAP_NET_ADMIN permission.
> + */
> +int cap_tun_dev_attach(void)
> +{
> +	if (!capable(CAP_NET_ADMIN))
> +		return -EPERM;
> +	return 0;
> +}

The checks before and after this patch are not equivalent.  Post-patch,
one must always have CAP_NET_ADMIN to do the attach, whereas pre-patch
you only needed those if current_cred() did not own the tun device.  Is
that intentional?

Also as Eric said this patch needs to set the cap_ hooks.  This patch
isn't yet introducing the selinux hooks, so iiuc actually this patch should
always oops if CONFIG_SECURITY=y.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
