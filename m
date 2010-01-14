From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC][PATCH v2] selinux: change the handling of unknown classes
Date: Thu, 14 Jan 2010 14:48:39 -0500
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        russell@coker.com.au, amworsley@gmail.com,
        Eric Paris <eparis@parisplace.org>
References: <20091218183016.9365.621.stgit@flek.lan> <201001080942.33039.paul.moore@hp.com> <1262972586.13162.47.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1262972586.13162.47.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201001141448.39128.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 08 January 2010 12:43:06 pm Stephen Smalley wrote:
> If allow_unknown==deny, SELinux treats an undefined kernel security
> class as an error condition rather than as a typical permission denial
> and thus does not allow permissions on undefined classes even when in
> permissive mode.  Change the SELinux logic so that this case is handled
> as a typical permission denial, subject to the usual permissive mode
> and permissive domain handling.
> 
> Also drop the 'requested' argument from security_compute_av() and
> helpers as it is a legacy of the original security server interface and
> is unused.
> 
> Changes:
> - Handle permissive domains consistently by moving up the test for a
> permissive domain.
> - Make security_compute_av_user() consistent with security_compute_av();
> the only difference now is that security_compute_av() performs mapping
> between the kernel-private class and permission indices and the policy
> values.  In the userspace case, this mapping is handled by libselinux.
> 
> Based in part on a patch by Paul Moore <paul.moore@hp.com>.
> 
> Reported-by: Andrew Worsley <amworsley@gmail.com>
> Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>

...

> -static int security_compute_av_core(u32 ssid,
> -				    u32 tsid,
> -				    u16 tclass,
> -				    u32 requested,
> -				    struct av_decision *avd)
> +static void avd_init(struct av_decision *avd)
>  {
> -	struct context *scontext = NULL, *tcontext = NULL;
> -	int rc = 0;
> -
> -	scontext = sidtab_search(&sidtab, ssid);
> -	if (!scontext) {
> -		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> -		       __func__, ssid);
> -		return -EINVAL;
> -	}
> -	tcontext = sidtab_search(&sidtab, tsid);
> -	if (!tcontext) {
> -		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> -		       __func__, tsid);
> -		return -EINVAL;
> -	}
> -
> -	rc = context_struct_compute_av(scontext, tcontext, tclass,
> -				       requested, avd);
> -
> -	/* permissive domain? */
> -	if (ebitmap_get_bit(&policydb.permissive_map, scontext->type))
> -		avd->flags |= AVD_FLAGS_PERMISSIVE;
> -
> -	return rc;
> +	avd->allowed = 0;
> +	avd->auditallow = 0;
> +	avd->auditdeny = 0xffffffff;
> +	avd->seqno = latest_granting;
> +	avd->flags = 0;
>  }
> 
> +
>  /**
>   * security_compute_av - Compute access vector decisions.
>   * @ssid: source security identifier
>   * @tsid: target security identifier
>   * @tclass: target security class
> - * @requested: requested permissions
>   * @avd: access vector decisions
>   *
>   * Compute a set of access vector decisions based on the
>   * SID pair (@ssid, @tsid) for the permissions in @tclass.
> - * Return -%EINVAL if any of the parameters are invalid or %0
> - * if the access vector decisions were computed successfully.
>   */
> -int security_compute_av(u32 ssid,
> -			u32 tsid,
> -			u16 orig_tclass,
> -			u32 orig_requested,
> -			struct av_decision *avd)
> +void security_compute_av(u32 ssid,
> +			 u32 tsid,
> +			 u16 orig_tclass,
> +			 struct av_decision *avd)
>  {
>  	u16 tclass;
> -	u32 requested;
> -	int rc;
> +	struct context *scontext = NULL, *tcontext = NULL;
> 
> +	avd_init(avd);
>  	read_lock(&policy_rwlock);

The only thing that is jumping out at me right now is that you are calling 
avd_init() outside the policy lock and 'latest_granting' appears to be 
protected by the lock.  Maybe not a huge deal since it is just a scalar but 
thought I would mention it; the same applies below in 
security_compute_av_user().

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
