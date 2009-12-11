Subject: Re: [RFC PATCH v1] selinux: Fix security_compute_av() to not
 return unknown class errors when in permissive mode
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, russell@coker.com.au, amworsley@gmail.com
In-Reply-To: <20091211214213.5420.59860.stgit@flek.lan>
References: <20091211214213.5420.59860.stgit@flek.lan>
Content-Type: text/plain
Date: Fri, 11 Dec 2009 16:59:19 -0500
Message-Id: <1260568759.26597.163.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-12-11 at 16:42 -0500, Paul Moore wrote:
> It is possible security_compute_av() to return -EINVAL, even when in
> permissive mode, due to unknown object classes.  This patch fixes this by
> first checking to see if SELinux is in permissive mode or if the subject is
> a permissive domain, if either of these are true then security_compute_av()
> ignores the unknown class error and allows the operation to proceed.
> 
> Andrew: I've tested this patch to ensure it boots and does not regress my
> Fedora/Rawhide system but since I don't have a Debian system handy I'm not
> able to verify that this fixes your problem; could you please test this
> patch and report back?
> 
> Reported-by: Andrew Worsley <amworsley@gmail.com>
> Signed-off-by: Paul Moore <paul.moore@hp.com>
> ---
>  security/selinux/ss/services.c |   21 +++++++++++++++------
>  1 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index b3efae2..db88153 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -940,6 +940,7 @@ int security_compute_av(u32 ssid,
>  {
>  	u16 tclass;
>  	u32 requested;
> +	struct context *scontext;
>  	int rc;
>  
>  	read_lock(&policy_rwlock);
> @@ -949,12 +950,8 @@ int security_compute_av(u32 ssid,
>  
>  	requested = unmap_perm(orig_tclass, orig_requested);
>  	tclass = unmap_class(orig_tclass);
> -	if (unlikely(orig_tclass && !tclass)) {
> -		if (policydb.allow_unknown)
> -			goto allow;
> -		rc = -EINVAL;
> -		goto out;
> -	}
> +	if (unlikely(orig_tclass && !tclass))
> +		goto unknown_class;
>  	rc = security_compute_av_core(ssid, tsid, tclass, requested, avd);
>  	map_decision(orig_tclass, avd, policydb.allow_unknown);
>  out:
> @@ -968,6 +965,18 @@ allow:
>  	avd->flags = 0;
>  	rc = 0;
>  	goto out;
> +unknown_class:
> +	if (policydb.allow_unknown || !selinux_enforcing)
> +		goto allow;
> +	scontext = sidtab_search(&sidtab, ssid);
> +	if (scontext) {
> +		if (ebitmap_get_bit(&policydb.permissive_map, scontext->type))
> +			goto allow;
> +	} else
> +		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +		       __func__, ssid);
> +	rc = -EINVAL;
> +	goto out;
>  }
>  
>  int security_compute_av_user(u32 ssid,

Can we simplify this at all?  For example, I don't really think
sidtab_search() can ever fail anymore (it falls back to the unlabeled
SID, which has to be defined by the initial policy load).  I also think
we could just clear avd->allowed and return 0 rather than returning
-EINVAL in this case so that the existing avc_has_perm() logic would
proceed and check permissive mode on its own.  We likely should also
move the permissive map test earlier so that it always get applied
unconditionally.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
