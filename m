Date: Tue, 16 Oct 2007 14:34:11 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, "Serge E. Hallyn" <serue@us.ibm.com>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: Re: Dealing with 64-bit capabilities
Message-ID: <20071016193411.GC4115@sergelap.austin.ibm.com>
References: <1192549264.8702.113.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1192549264.8702.113.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> Given that Serge has put out a RFC patch on lsm and lkml for extending
> capabilities to 64 bits, we should likely finalize how we want to handle
> them in SELinux.
> 
> Extending the access vector to 64-bits isn't a good idea IMHO, as it
> will waste quite a bit of space throughout the AVC and the security
> server policydb.
> 
> In the past we've talked about introducing a second capability class and
> access vector for the higher 32 capabilities, and optionally providing
> syntactic sugar in checkpolicy so the user doesn't have to think about
> it as two separate classes.
> 
> Possible kernel patch below to define the new class and change
> task_has_capability to use it for the higher capabilities.  Comments?

Looks reasonable.  Note that if STRICT_CAP_T_TYPECHECKS were
set your use of kernel_cap_t would trigger errors.  near as
I can tell that isn't ever done, but still to get around that
you'd just do

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0753b20..2e2f6f8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1043,6 +1045,9 @@ static int task_has_capability(struct task_struct *tsk,
>  {
>  	struct task_security_struct *tsec;
>  	struct avc_audit_data ad;
> +	kernel_cap_t mask = CAP_TO_MASK(cap);

	kernel_cap_t mask = to_cap_t(CAP_TO_MASK(cap));

> +	u16 sclass;
> +	u32 av;	
> 
>  	tsec = tsk->security;
> 
> @@ -1050,8 +1055,14 @@ static int task_has_capability(struct task_struct *tsk,
>  	ad.tsk = tsk;
>  	ad.u.cap = cap;
> 
> -	return avc_has_perm(tsec->sid, tsec->sid,
> -			    SECCLASS_CAPABILITY, CAP_TO_MASK(cap), &ad);
> +	if (cap < 32) {
> +		sclass = SECCLASS_CAPABILITY;
> +		av = mask;

		av = cap_t(mask);

> +	} else {
> +		sclass = SECCLASS_CAPABILITY2;
> +		av = mask >> 32;

		av = cap_t(mask) >> 32;

which should generally compile away to nothing.

thanks,
-serge

> +	}
> +	return avc_has_perm(tsec->sid, tsec->sid, sclass, av, &ad);
>  }
> 
>  /* Check whether a task is allowed to use a system operation. */
> diff --git a/security/selinux/include/class_to_string.h b/security/selinux/include/class_to_string.h
> index e77de0e..30d5cf6 100644
> --- a/security/selinux/include/class_to_string.h
> +++ b/security/selinux/include/class_to_string.h
> @@ -64,3 +64,10 @@
>      S_(NULL)
>      S_("dccp_socket")
>      S_("memprotect")
> +    S_(NULL)
> +    S_(NULL)
> +    S_(NULL)
> +    S_(NULL)
> +    S_(NULL)
> +    S_(NULL)
> +    S_("capability2")
> diff --git a/security/selinux/include/flask.h b/security/selinux/include/flask.h
> index a9c2b20..a19c166 100644
> --- a/security/selinux/include/flask.h
> +++ b/security/selinux/include/flask.h
> @@ -50,6 +50,7 @@
>  #define SECCLASS_KEY                                     58
>  #define SECCLASS_DCCP_SOCKET                             60
>  #define SECCLASS_MEMPROTECT                              61
> +#define SECCLASS_CAPABILITY2                             68
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
