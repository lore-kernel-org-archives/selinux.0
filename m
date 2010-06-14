Subject: Re: [PATCH 4/4] SELinux: allow userspace to read policy back out
 of the kernel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20100611163723.18445.39397.stgit@paris.rdu.redhat.com>
References: <20100611163705.18445.78022.stgit@paris.rdu.redhat.com>
	 <20100611163723.18445.39397.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 14 Jun 2010 10:48:46 -0400
Message-ID: <1276526926.8863.23.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-06-11 at 12:37 -0400, Eric Paris wrote:
> There is interest in being able to see what the actual policy is that was
> loaded into the kernel.  The patch creates a new selinuxfs file
> /selinux/policy which can be read by userspace.  The actual policy that is
> loaded into the kernel will be written back out to userspace.

Why a new node vs a read op for /selinux/load?

> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
> 

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 1de60ce..2e022db 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3126,3 +3125,27 @@ netlbl_sid_to_secattr_failure:
>  	return rc;
>  }
>  #endif /* CONFIG_NETLABEL */
> +
> +/**
> + * security_read_policy - read the policy.
> + * @data: binary policy data
> + * @len: length of data in bytes
> + *
> + */
> +int security_read_policy(void *data, ssize_t *len)
> +{
> +	int rc = 0;
> +	struct policy_file file = { data, *len }, *fp = &file;
> +
> +	if (!ss_initialized)
> +		return -EINVAL;
> +
> +	read_lock_irq(&policy_rwlock);
> +	rc = policydb_write(&policydb, fp);
> +	read_unlock_irq(&policy_rwlock);
> +
> +	*len = (unsigned long)fp->data - (unsigned long)data;
> +
> +	return rc;
> +
> +}

Why _irq?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
