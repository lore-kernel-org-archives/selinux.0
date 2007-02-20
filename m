Subject: newrole O_NONBLOCK change (Was:  Re: policycoreutils patch)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB0AB8.3070803@redhat.com>
References: <45DB0AB8.3070803@redhat.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 11:17:41 -0500
Message-Id: <1171988261.14363.106.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 09:50 -0500, Daniel J Walsh wrote:
> newrole hangs on a attached terminal device.  Nonblocking allows it to 
> proceed.

Won't this have side effects on programs run from the newrole'd shell?
Should newrole open them with O_NONBLOCK and then clear it via fcntl
before exec'ing the child shell?

> plain text document attachment (diff)
> diff --exclude-from=exclude --exclude=sepolgen-1.0.0 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/newrole/newrole.c policycoreutils-2.0.1/newrole/newrole.c
> --- nsapolicycoreutils/newrole/newrole.c	2007-01-24 10:03:59.000000000 -0500
> +++ policycoreutils-2.0.1/newrole/newrole.c	2007-02-15 15:16:09.000000000 -0500
> @@ -640,7 +640,7 @@
>  	}
>  
>  	/* Re-open TTY descriptor */
> -	fd = open(ttyn, O_RDWR);
> +	fd = open(ttyn, O_RDWR|O_NONBLOCK);
>  	if (fd < 0) {
>  		fprintf(stderr, _("Error!  Could not open %s.\n"), ttyn);
>  		return fd;
> @@ -1131,13 +1131,13 @@
>  		fprintf(stderr, _("Could not close descriptors.\n"));
>  		goto err_close_pam;
>  	}
> -	fd = open(ttyn, O_RDONLY);
> +	fd = open(ttyn, O_RDONLY|O_NONBLOCK);
>  	if (fd != 0)
>  		goto err_close_pam;
> -	fd = open(ttyn, O_RDWR);
> +	fd = open(ttyn, O_RDWR|O_NONBLOCK);
>  	if (fd != 1)
>  		goto err_close_pam;
> -	fd = open(ttyn, O_RDWR);
> +	fd = open(ttyn, O_RDWR|O_NONBLOCK);
>  	if (fd != 2)
>  		goto err_close_pam;
>  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
