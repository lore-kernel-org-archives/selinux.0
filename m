Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0OKr4sj029518
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 15:53:04 -0500 (EST)
Subject: Re: libselinux rpm_execon should not fail in permissive mode.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41F55E02.6090302@redhat.com>
References: <41F03552.90806@redhat.com>
	 <1106596929.3298.9.camel@moss-lions.epoch.ncsc.mil>
	 <41F55E02.6090302@redhat.com>
Content-Type: text/plain
Message-Id: <1106599610.19246.255.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 24 Jan 2005 15:46:50 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-24 at 15:43, Daniel J Walsh wrote:
> diff --exclude-from=exclude -N -u -r nsalibselinux/src/rpm.c libselinux-1.21.1/src/rpm.c
> --- nsalibselinux/src/rpm.c	2004-11-09 09:13:54.000000000 -0500
> +++ libselinux-1.21.1/src/rpm.c	2005-01-24 15:24:33.000000000 -0500
> @@ -41,8 +41,10 @@
>  	rc = setexeccon(newcon);
>  	if (rc < 0) 
>  		goto out;
> -	rc = execve(filename, argv, envp);
>  out:
> +	if ( ( rc == 0 ) || 
> +	     (security_getenforce() == 0 ))
> +	  rc = execve(filename, argv, envp);
>  	context_free(con);
>  	freecon(newcon);
>  	freecon(fcon);

What failure are you encountering in permissive mode?  Possibly the file
might lack a context and we should handle that more cleanly, but I
wouldn't recommend this patch.  The setexeccon() shouldn't fail in
permissive mode.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
