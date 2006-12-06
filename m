Message-ID: <4576FB84.9050200@mentalrootkit.com>
Date: Wed, 06 Dec 2006 12:19:00 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
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

In the absence of some mechanism to determine which file systems support 
labeling, do we want to merge this patch or something similar? Would it 
be better to remove files from the watch list if a fatal error is 
encountered?

Karl

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


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
