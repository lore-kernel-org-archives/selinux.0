From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] selinux: change the handling of unknown classes
Date: Fri, 8 Jan 2010 09:42:32 -0500
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        russell@coker.com.au, amworsley@gmail.com,
        Eric Paris <eparis@parisplace.org>
References: <20091218183016.9365.621.stgit@flek.lan> <1262901683.2821.141.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1262901683.2821.141.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201001080942.33039.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 07 January 2010 05:01:23 pm Stephen Smalley wrote:
> If allow_unknown==deny, SELinux treats an undefined kernel security
> class as an error condition rather than as a typical permission denial
> and thus does not allow permissions on undefined classes even when in
> permissive mode.  Change the SELinux logic so that this case is handled
> as a typical permission denial, subject to the usual permissive mode
> logic.  This change only affects the kernel permission checking;
> userspace requests for access computations will still return errors upon
> invalid classes, since the userspace AVC handles mapping of classes and
> permissions for userspace object managers.
> 
> Also drop the 'requested' argument from security_compute_av() and
> helpers as it is a legacy of the original security server interface and
> is unused.
> 
> Based in part on a patch by Paul Moore <paul.moore@hp.com>.
> 
> Reported-by: Andrew Worsley <amworsley@gmail.com>
> Signed-off-by: Stephen D. Smalley <sds@tycho.nsa.gov>

Thanks :)  I do have one question (below) ...

> @@ -924,56 +899,48 @@ static int security_compute_av_core(u32 ssid,
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
> 
>  	read_lock(&policy_rwlock);
> 
> +	avd->allowed = 0;
> +	avd->auditallow = 0;
> +	avd->auditdeny = 0xffffffff;
> +	avd->seqno = latest_granting;
> +	avd->flags = 0;
> +
>  	if (!ss_initialized)
>  		goto allow;
> 
> -	requested = unmap_perm(orig_tclass, orig_requested);
>  	tclass = unmap_class(orig_tclass);
>  	if (unlikely(orig_tclass && !tclass)) {
>  		if (policydb.allow_unknown)
>  			goto allow;
> -		rc = -EINVAL;
>  		goto out;
>  	}

Since we don't check for a permissive domain until security_compute_av_core() 
I assume this means that an unknown class will still cause problems for 
permissive domains when the system as a whole is in enforcing mode - or am I 
missing something?

> -	rc = security_compute_av_core(ssid, tsid, tclass, requested, avd);
> +	(void) security_compute_av_core(ssid, tsid, tclass, avd);
>  	map_decision(orig_tclass, avd, policydb.allow_unknown);
>  out:
>  	read_unlock(&policy_rwlock);
> -	return rc;
> +	return;
>  allow:
>  	avd->allowed = 0xffffffff;
> -	avd->auditallow = 0;
> -	avd->auditdeny = 0xffffffff;
> -	avd->seqno = latest_granting;
> -	avd->flags = 0;
> -	rc = 0;
>  	goto out;
>  }
 

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
