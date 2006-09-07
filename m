Message-ID: <45004926.5010206@trustedcs.com>
Date: Thu, 07 Sep 2006 11:30:30 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: janak@us.ibm.com
CC: sds@tycho.nsa.gov, sgrubb@redhat.com, dwalsh@redaht.com, tmraz@redhat.com,
        ltcgcw@us.ibm.com, klaus@atsec.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] newrole: use pam session management services - v4
References: <1157403682.7223.16.camel@localhost.localdomain>
In-Reply-To: <1157403682.7223.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Janak Desai wrote:
> This patch updates newrole to allow it to use pam session mangement
> services. Currently newrole only uses the authenticaion services of
> pam. Session management services are needed to allow pam_namespace
> to appropriately reconfigure polyinstantiated namespace for the
> new session being established with newrole.
> 
> For newrole to work correctly with pam_namespace, in addtion to
> this patch, a patch to pam_namespace and a patch to the lssp 
> policy will also be required. These additional patches will be
> posted the selinux mailing list following this patch.
> 
> Changes since v3 of this patch, posted on 8/27/06:
>     1. Incorporated feedback to v2
>        a. Create/install an lspp version of newrole.pamd when
>           building with LSPP_PRIV=y
>        b. Removed duplicate definition of _GNU_SOURCE
>        c. Keep CAP_SYS_ADMIN, CAP_FOWNER, CAP_CHOWN and
>           CAP_DAC_OVERRIDE in permitted set and raise them in the
>           effective set prior to calling pam session management
>           functions.
>     2. Forward ported to the latest selinux subversion tree (version 2014)
>        on sourceforge and tested with fedora development package
>        policycoreutils-1.30.28-1.src.rpm.
> 
> Signed-off-by: Janak Desai <janak@us.ibm.com>

<snip>

> diff -Naurp policycoreutils/newrole/newrole.c policycoreutils+newrolepatch/newrole/newrole.c
> --- policycoreutils/newrole/newrole.c	2006-09-04 15:35:02.000000000 +0000
> +++ policycoreutils+newrolepatch/newrole/newrole.c	2006-09-04 16:14:06.000000000 +0000

<snip>

> @@ -821,6 +876,23 @@ int main(int argc, char *argv[])
>  		fsetfilecon(fd, tty_context);
>  		freecon(tty_context);
>  
> +#ifdef USE_PAM
> +#ifdef LSPP_PRIV
> +		change_pns_effective_caps(CAP_SET);
> +		rc = pam_close_session(pam_handle,0);
> +		if(rc != PAM_SUCCESS) {
> +			fprintf(stderr, "pam_close_session failed with %s\n",
> +				pam_strerror(pam_handle, rc));
> +			pam_end(pam_handle, rc);
> +			exit(-1);
> +		}
> +		change_pns_effective_caps(CAP_CLEAR);
> +#endif
> +
> +		/* We're done with PAM.  Free `pam_handle'. */
> +		pam_end(pam_handle, rc);
> +#endif
> +

Could we untangle the pam/lspp bits like I have below if we include
pam_permit as a session module in the "regular" pam config?  I think
that should take care of the case where we use pam, but do not have
any session management needs.  The use of pam_permit in this situation
seems perfectly acceptable to me.  This would give us real session
management capabilities via pam even if we are not using the lspp
configuration which requires privilege for pam_namespace.so.

#ifdef USE_PAM
#ifdef LSPP_PRIV
		change_pns_effective_caps(CAP_SET);
#endif /* LSPP_PRIV */
		rc = pam_close_session(pam_handle,0);
		if(rc != PAM_SUCCESS) {
			fprintf(stderr, "pam_close_session failed with %s\n",
				pam_strerror(pam_handle, rc));
			pam_end(pam_handle, rc);
			exit(-1);
		}
#ifdef LSPP_PRIV
		change_pns_effective_caps(CAP_CLEAR);
#endif /* LSPP_PRIV */

		/* We're done with PAM.  Free `pam_handle'. */
		pam_end(pam_handle, rc);
#endif /* USE_PAM */


> @@ -873,7 +945,21 @@ int main(int argc, char *argv[])
>  			new_context);
>  		exit(-1);
>  	}
> -#ifdef LOG_AUDIT_PRIV
> +
> +#ifdef LSPP_PRIV
> +	change_pns_effective_caps(CAP_SET);
> +
> +#ifdef USE_PAM
> +	/* Ask PAM to setup session for user running this program */
> +	rc = pam_open_session(pam_handle,0);
> +	if(rc != PAM_SUCCESS) {
> +		fprintf(stderr, "pam_open_session failed with %s\n",
> +			pam_strerror(pam_handle, rc));
> +		exit(-1);
> +	}
> +#endif
> +	change_pns_effective_caps(CAP_CLEAR);
> +

If the idea of using pam_permit is works out, then this section of code
would be re-bracketed as such:

#ifdef USE_PAM
#ifdef LSPP_PRIV
	change_pns_effective_caps(CAP_SET);
#endif /* LSPP_PRIV */
	/* Ask PAM to setup session for user running this program */
	rc = pam_open_session(pam_handle,0);
	if(rc != PAM_SUCCESS) {
		fprintf(stderr, "pam_open_session failed with %s\n",
			pam_strerror(pam_handle, rc));
		exit(-1);
	}
#ifdef LSPP_PRIV
	change_pns_effective_caps(CAP_CLEAR);
#endif /* LSPP_PRIV */
#endif /* USE_PAM */

#ifdef LSPP_PRIV
...do audit stuff...
#endif /* LSPP_PRIV */


We could alternatively just define the cap manipulation functions to do
nothing if LSPP_PRIV is not defined and call them unconditionally to
clean up the code a bit...

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
