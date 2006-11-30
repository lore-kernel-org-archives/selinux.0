Message-ID: <456F05F4.8090507@tresys.com>
Date: Thu, 30 Nov 2006 11:25:24 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch for restorecond to not report an error if filesystem does
 not support XATTR
References: <456E073D.8050109@redhat.com>
In-Reply-To: <456E073D.8050109@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Caused by NFS Home directories.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> diff --exclude-from=exclude --exclude POTFILES.in --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/restorecond/restorecond.c policycoreutils-1.33.5/restorecond/restorecond.c
> --- nsapolicycoreutils/restorecond/restorecond.c	2006-11-16 17:14:28.000000000 -0500
> +++ policycoreutils-1.33.5/restorecond/restorecond.c	2006-11-29 12:44:06.000000000 -0500
> @@ -210,9 +210,10 @@
>  			}
>  
>  			if (fsetfilecon(fd, scontext) < 0) {
> -				syslog(LOG_ERR,
> -				       "set context %s->%s failed:'%s'\n",
> -				       filename, scontext, strerror(errno));
> +				if (errno != EOPNOTSUPP) 
> +					syslog(LOG_ERR,
> +					       "set context %s->%s failed:'%s'\n",
> +					       filename, scontext, strerror(errno));
>  				if (retcontext >= 0)
>  					free(prev_context);
>  				free(scontext);
> @@ -225,8 +226,9 @@
>  		if (retcontext >= 0)
>  			free(prev_context);
>  	} else {
> -		syslog(LOG_ERR, "get context on %s failed: '%s'\n",
> -		       filename, strerror(errno));
> +		if (errno != EOPNOTSUPP) 
> +			syslog(LOG_ERR, "get context on %s failed: '%s'\n",
> +			       filename, strerror(errno));
>  	}
>  	free(scontext);
>  	close(fd);

It sounds like this is caused by configuration errors, why wouldn't it 
check that the files/dirs being watched have xattr support before adding 
them to the watch list?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
