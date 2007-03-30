Subject: Re: [PATCH 2/3] libselinux: string and compute_create functions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <460D4D84.6040307@tycho.nsa.gov>
References: <460D495B.3060000@tycho.nsa.gov>
	 <460D4D84.6040307@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 15:30:46 -0400
Message-Id: <1175283046.5479.225.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-30 at 13:48 -0400, Eamon Walsh wrote:
> avc_compute_create function, same as security_compute_create but
> takes userspace AVC SID's.

Merged with fix described below.

> --
>  include/selinux/avc.h |   19 +++++++++++++++++++
>  src/avc.c             |   25 +++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> --
> Index: src/avc.c
> ===================================================================
> --- src/avc.c	(revision 2307)
> +++ src/avc.c	(working copy)
> @@ -1006,6 +1006,31 @@
>  	return rc;
>  }
>  
> +int avc_compute_create(security_id_t ssid,  security_id_t tsid,
> +		       security_class_t tclass, security_id_t *newsid)
> +{
> +	int rc;
> +	*ctx = NULL;

s/ctx/newsid/

> +	avc_get_lock(avc_lock);
> +	if (ssid->refcnt > 0 && tsid->refcnt > 0) {
> +		security_context_t ctx;
> +		rc = security_compute_create_raw(ssid->ctx, tsid->ctx, tclass,
> +						 &ctx);
> +		if (rc)
> +			goto out;
> +		rc = sidtab_context_to_sid(&avc_sidtab, ctx, newsid);
> +		if (!rc)
> +			(*newsid)->refcnt++;
> +		freecon(ctx);
> +	} else {
> +		errno = EINVAL;	/* bad reference count */
> +		rc = -1;
> +	}
> +out:
> +	avc_release_lock(avc_lock);
> +	return rc;
> +}
> +
>  int avc_add_callback(int (*callback) (uint32_t event, security_id_t ssid,
>  				      security_id_t tsid,
>  				      security_class_t tclass,

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
