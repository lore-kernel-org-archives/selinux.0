Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBKGibnS031568
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2010 11:44:37 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id oBKGibiP029711
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2010 16:44:37 GMT
Date: Mon, 20 Dec 2010 11:44:35 -0500
Subject: Re: This patch move newrole to file capabilities and uses libcapng
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Message-ID: <C934F223.BBBC5%csellers@tresys.com>
In-Reply-To: <4D066A54.9020904@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/13/10 1:47 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> 
> diff --git a/policycoreutils/newrole/Makefile
> b/policycoreutils/newrole/Makefile
> index 6c19bd1..bd8e7a7 100644
> --- a/policycoreutils/newrole/Makefile
> +++ b/policycoreutils/newrole/Makefile
> @@ -50,7 +50,7 @@ ifeq (${NAMESPACE_PRIV},y)
>  endif
>  ifeq (${IS_SUID},y)
>      MODE := 4555
> -    LDLIBS += -lcap
> +    LDLIBS += -lcap-ng
>  else
>      MODE := 0555
>  endif
> diff --git a/policycoreutils/newrole/newrole.c
> b/policycoreutils/newrole/newrole.c
> index d191be6..071b393 100644
> --- a/policycoreutils/newrole/newrole.c
> +++ b/policycoreutils/newrole/newrole.c
> @@ -77,7 +77,7 @@
>  #endif
>  #if defined(AUDIT_LOG_PRIV) || (NAMESPACE_PRIV)
>  #include <sys/prctl.h>
> -#include <sys/capability.h>
> +#include <cap-ng.h>
>  #endif
>  #ifdef USE_NLS
>  #include <locale.h>        /* for setlocale() */
> @@ -90,6 +90,9 @@
>  #define PACKAGE "policycoreutils"    /* the name of this package lang
> translation */
>  #endif
>  
> +# define TRUE 1
> +# define FALSE 0
> +
>  /* USAGE_STRING describes the command-line args of this program. */
>  #define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l level ] [
> -p ] [ -V ] [ -- args ]"
>  
> @@ -538,69 +541,23 @@ static int restore_environment(int preserve_environment,
>   * Returns zero on success, non-zero otherwise
>   */
>  #if defined(AUDIT_LOG_PRIV) && !defined(NAMESPACE_PRIV)
> -static int drop_capabilities(void)
> +static int drop_capabilities(int full)
>  {
> -    int rc = 0;
> -    cap_t new_caps, tmp_caps;
> -    cap_value_t cap_list[] = { CAP_AUDIT_WRITE };
> -    cap_value_t tmp_cap_list[] = { CAP_AUDIT_WRITE, CAP_SETUID };
> -    uid_t uid = getuid();
> -
> -    if (!uid)
> -        return 0;
> -
> -    /* Non-root caller, suid root path */
> -    new_caps = cap_init();
> -    tmp_caps = cap_init();
> -    if (!new_caps || !tmp_caps) {
> -        fprintf(stderr, _("Error initializing capabilities, aborting.\n"));
> +    capng_clear(CAPNG_SELECT_BOTH);
> +    if (capng_lock() < 0)
>          return -1;
> -    }
> -    rc |= cap_set_flag(new_caps, CAP_PERMITTED, 1, cap_list, CAP_SET);
> -    rc |= cap_set_flag(new_caps, CAP_EFFECTIVE, 1, cap_list, CAP_SET);
> -    rc |= cap_set_flag(tmp_caps, CAP_PERMITTED, 2, tmp_cap_list, CAP_SET);
> -    rc |= cap_set_flag(tmp_caps, CAP_EFFECTIVE, 2, tmp_cap_list, CAP_SET);
> -    if (rc) {
> -        fprintf(stderr, _("Error setting capabilities, aborting\n"));
> -        goto out;
> -    }
> -
> -    /* Keep capabilities across uid change */
> -    if (prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0)) {
> -        fprintf(stderr, _("Error setting KEEPCAPS, aborting\n"));
> -        rc = -1;
> -        goto out;
> -    }
>  
> -    /* Does this temporary change really buy us much? */
> -    /* We should still have root's caps, so drop most capabilities now */
> -    if ((rc = cap_set_proc(tmp_caps))) {
> -        fprintf(stderr, _("Error dropping capabilities, aborting\n"));
> -        goto out;
> -    }
> +    uid_t uid = getuid();
> +    if (!uid) return 0;
>  
>      /* Change uid */
> -    if ((rc = setresuid(uid, uid, uid))) {
> +    if (setresuid(uid, uid, uid)) {
>          fprintf(stderr, _("Error changing uid, aborting.\n"));
> -        goto out;
> -    }
> -
> -    /* Now get rid of this ability */
> -    if ((rc = prctl(PR_SET_KEEPCAPS, 0, 0, 0, 0) < 0)) {
> -        fprintf(stderr, _("Error resetting KEEPCAPS, aborting\n"));
> -        goto out;
> -    }
> -
> -    /* Finish dropping capabilities. */
> -    if ((rc = cap_set_proc(new_caps))) {
> -        fprintf(stderr,
> -            _("Error dropping SETUID capability, aborting\n"));
> -        goto out;
> +        return -1;
>      }
> -      out:
> -    if (cap_free(tmp_caps) || cap_free(new_caps))
> -        fprintf(stderr, _("Error freeing caps\n"));
> -    return rc;
> +    if (! full) 
> +        capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
> CAP_AUDIT_WRITE);
> +    return capng_apply(CAPNG_SELECT_BOTH);
>  }
>  #elif defined(NAMESPACE_PRIV)
>  /**
> @@ -616,50 +573,25 @@ static int drop_capabilities(void)
>   *
>   * Returns zero on success, non-zero otherwise
>   */
> -static int drop_capabilities(void)
> +static int drop_capabilities(int full)
>  {
> -    int rc = 0;
> -    cap_t new_caps;
> -    cap_value_t cap_list[] = { CAP_AUDIT_WRITE, CAP_SETUID,
> -        CAP_SYS_ADMIN, CAP_FOWNER, CAP_CHOWN,
> -        CAP_DAC_OVERRIDE
> -    };
> -
> -    if (!getuid())
> -        return 0;
> -
> -    /* Non-root caller, suid root path */
> -    new_caps = cap_init();
> -    if (!new_caps) {
> -        fprintf(stderr, _("Error initializing capabilities, aborting.\n"));
> +    capng_clear(CAPNG_SELECT_BOTH);
> +    if (capng_lock() < 0)
>          return -1;
> -    }
> -    rc |= cap_set_flag(new_caps, CAP_PERMITTED, 6, cap_list, CAP_SET);
> -    rc |= cap_set_flag(new_caps, CAP_EFFECTIVE, 6, cap_list, CAP_SET);
> -    if (rc) {
> -        fprintf(stderr, _("Error setting capabilities, aborting\n"));
> -        goto out;
> -    }
>  
> -    /* Ensure that caps are dropped after setuid call */
> -    if ((rc = prctl(PR_SET_KEEPCAPS, 0, 0, 0, 0) < 0)) {
> -        fprintf(stderr, _("Error resetting KEEPCAPS, aborting\n"));
> -        goto out;
> -    }
> -
> -    /* We should still have root's caps, so drop most capabilities now */
> -    if ((rc = cap_set_proc(new_caps))) {
> -        fprintf(stderr, _("Error dropping capabilities, aborting\n"));
> -        goto out;
> +    uid_t uid = getuid();
> +    /* Change uid */
> +    if (setresuid(uid, uid, uid)) {
> +        fprintf(stderr, _("Error changing uid, aborting.\n"));
> +        return -1;
>      }
> -      out:
> -    if (cap_free(new_caps))
> -        fprintf(stderr, _("Error freeing caps\n"));
> -    return rc;
> +    if (! full) 
> +        capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
> CAP_SYS_ADMIN | CAP_FOWNER | CAP_CHOWN | CAP_DAC_OVERRIDE);
> +    return capng_apply(CAPNG_SELECT_BOTH);
>  }
>  
>  #else
> -static inline int drop_capabilities(void)
> +static inline int drop_capabilities(__attribute__ ((__unused__)) int full)
>  {
>      return 0;
>  }
> @@ -1098,7 +1030,7 @@ int main(int argc, char *argv[])
>       * if it makes sense to continue to run newrole, and setting up
>       * a scrubbed environment.
>       */
> -    if (drop_capabilities())
> +    if (drop_capabilities(FALSE))
>          return -1;
>      if (set_signal_handles())
>          return -1;
> @@ -1334,11 +1266,15 @@ int main(int argc, char *argv[])
>  
>      if (send_audit_message(1, old_context, new_context, ttyn))
>          goto err_close_pam_session;
> +    freecon(old_context); old_context=NULL;
> +    freecon(new_context); new_context=NULL;
> +
>  #ifdef NAMESPACE_PRIV
>      if (transition_to_caller_uid())
>          goto err_close_pam_session;
>  #endif
>  
> +    drop_capabilities(TRUE);
>      /* Handle environment changes */
>      if (restore_environment(preserve_environment, old_environ, &pw)) {
>          fprintf(stderr, _("Unable to restore the environment, "

Am I missing the file caps portion of this? This just looks like moving to
libcapng. I don't see anything related to file caps.

Thanks,
Chad


 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
