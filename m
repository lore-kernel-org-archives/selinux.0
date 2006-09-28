Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8SK5VBX028467
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 16:05:31 -0400
Received: from e33.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8SK4QbB018368
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 20:04:26 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8SK5Vov024153
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 16:05:31 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8SK5VRR347306
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 14:05:31 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8SK5VSl030948
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 14:05:31 -0600
Message-ID: <451C2B03.1060300@us.ibm.com>
Date: Thu, 28 Sep 2006 15:05:23 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: Linux Audit <linux-audit@redhat.com>, lspp-list <redhat-lspp@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] newrole auditing of failures due to user actions
References: <451C2473.7050102@us.ibm.com>
In-Reply-To: <451C2473.7050102@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael C Thompson wrote:
> This patch introduces two new point in the code where audit records are 
> generated for newrole. Both points are when the attempt to newrole fails.

Forgot to copy the SELinux mailing list.

> The first point is when the default type could not be determine for the 
> specified role - this is audited because, as sgrubb pointed out, it is 
> currently non-tracked path to probe the policy.
> 
> The second point is when the desired context to change to is invalid.
> 
> There record format remains unchanged. Failing to validate the desired 
> context will result in the old and new contexts being recorded intact to 
> the log. For the default type, the old and new contexts have not yet 
> been obtained, so they are recorded in the log as XXX_context=?
> 
> Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>
> 
> ----
> 
> 
> 
> ------------------------------------------------------------------------
> 
> --- policycoreutils-1.30.29/newrole/newrole.c	2006-09-14 07:07:26.000000000 -0500
> +++ policycoreutils-1.30.29.orig.dev/newrole/newrole.c	2006-09-28 14:21:27.000000000 -0500
> @@ -47,7 +47,9 @@
>   *
>   *************************************************************************/
>  
> +#ifndef _GNU_SOURCE
>  #define _GNU_SOURCE
> +#endif
>  #include <stdio.h>
>  #include <stdlib.h>		/* for malloc(), realloc(), free() */
>  #include <pwd.h>		/* for getpwuid() */
> @@ -394,6 +396,41 @@
>  		cap_free(new_caps);
>  	}
>  }
> +
> +/* Send audit message */
> +int send_audit_message(int success, security_context_t old_context,
> +			security_context_t new_context, const char *ttyn)
> +{
> +	char *msg = NULL;
> +	int rc;
> +	int audit_fd = audit_open();
> +
> +	if (audit_fd < 0) {
> +		fprintf(stderr, _("Error connecting to audit system.\n"));
> +		rc = -1;
> +		goto out;
> +	}
> +	if (asprintf(&msg, "newrole: old-context=%s new-context=%s",
> +				old_context ? old_context : "?",
> +				new_context ? new_context : "?") < 0) {
> +		fprintf(stderr, _("Error allocating memory.\n"));
> +		rc = -1;
> +		goto out;
> +	}
> +	rc = audit_log_user_message(audit_fd, AUDIT_USER_ROLE_CHANGE,
> +			msg, NULL, NULL, ttyn, success);
> +	if (rc <= 0) {
> +		fprintf(stderr, _("Error sending audit message.\n"));
> +		rc = -1;
> +		goto out;
> +	}
> +	rc = 0;
> +out:
> +	free(msg);
> +	close(audit_fd);
> +	return rc;
> +}
> +
>  #endif
>  
>  /************************************************************************
> @@ -536,6 +573,9 @@
>  	if (role_s && !type_s) {
>  		if (get_default_type(role_s, &type_s)) {
>  			fprintf(stderr, _("Couldn't get default type.\n"));
> +#ifdef LOG_AUDIT_PRIV
> +			send_audit_message(0, old_context, new_context, ttyn);
> +#endif
>  			exit(-1);
>  		}
>  #ifdef CANTSPELLGDB
> @@ -715,6 +755,9 @@
>  
>  	if (security_check_context(new_context) < 0) {
>  		fprintf(stderr, _("%s is not a valid context\n"), new_context);
> +#ifdef LOG_AUDIT_PRIV
> +		send_audit_message(0, old_context, new_context, ttyn);
> +#endif
>  		exit(-1);
>  	}
>  
> @@ -874,30 +917,8 @@
>  		exit(-1);
>  	}
>  #ifdef LOG_AUDIT_PRIV
> -	/* Send audit message */
> -	{
> -		char *msg;
> -		int rc;
> -		int audit_fd = audit_open();
> -		if (audit_fd < 0) {
> -			fprintf(stderr,
> -				_("Error connecting to audit system.\n"));
> -			exit(-1);
> -		}
> -		if (asprintf(&msg, "newrole: old-context=%s new-context=%s",
> -			     old_context, new_context) < 0) {
> -			fprintf(stderr, _("Error allocating memory.\n"));
> -			exit(-1);
> -		}
> -		rc = audit_log_user_message(audit_fd, AUDIT_USER_ROLE_CHANGE,
> -					    msg, NULL, NULL, ttyn, 1);
> -		if (rc <= 0) {
> -			fprintf(stderr, _("Error sending audit message.\n"));
> -			exit(-1);
> -		}
> -		free(msg);
> -		close(audit_fd);
> -	}
> +	if (send_audit_message(1, old_context, new_context, ttyn))
> +		exit(-1);
>  #endif
>  	freecon(old_context);
>  	execv(pw->pw_shell, argv + optind - 1);
> 
> 
> ------------------------------------------------------------------------
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
