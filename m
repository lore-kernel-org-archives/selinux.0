Subject: Re: [PATCH] newrole: fix for newrole hanging on some serial
	consoles
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Linda Knippers <linda.knippers@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <45DDB4CD.7040308@hp.com>
References: <45DDACEE.20205@hp.com>  <45DDB4CD.7040308@hp.com>
Content-Type: text/plain
Date: Thu, 22 Feb 2007 11:07:47 -0500
Message-Id: <1172160467.14363.416.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-22 at 10:20 -0500, Linda Knippers wrote:
> Reposting to fix a whitespace problem and adjust the patch location.
> 
> Signed-off-by: Linda Knippers <linda.knippers@hp.com>

Thanks, merged into -stable and -trunk.

> 
> --- policycoreutils-1.33.12/newrole/newrole.c	2007-02-20 13:32:46.000000000 -0500
> +++ policycoreutils-1.33.12.ljk/newrole/newrole.c	2007-02-22 10:20:39.000000000 -0500
> @@ -636,11 +636,12 @@ static int relabel_tty(const char *ttyn,
>  	}
>  
>  	/* Re-open TTY descriptor */
> -	fd = open(ttyn, O_RDWR);
> +	fd = open(ttyn, O_RDWR|O_NONBLOCK);
>  	if (fd < 0) {
>  		fprintf(stderr, _("Error!  Could not open %s.\n"), ttyn);
>  		return fd;
>  	}
> +	fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
>  
>  	if (fgetfilecon(fd, &tty_con) < 0) {
>  		fprintf(stderr, _("%s!  Could not get current context "
> @@ -1127,15 +1128,18 @@ int main(int argc, char *argv[])
>  		fprintf(stderr, _("Could not close descriptors.\n"));
>  		goto err_close_pam;
>  	}
> -	fd = open(ttyn, O_RDONLY);
> +	fd = open(ttyn, O_RDONLY|O_NONBLOCK);
>  	if (fd != 0)
>  		goto err_close_pam;
> -	fd = open(ttyn, O_RDWR);
> +	fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
> +	fd = open(ttyn, O_RDWR|O_NONBLOCK);
>  	if (fd != 1)
>  		goto err_close_pam;
> -	fd = open(ttyn, O_RDWR);
> +	fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
> +	fd = open(ttyn, O_RDWR|O_NONBLOCK);
>  	if (fd != 2)
>  		goto err_close_pam;
> +	fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
>  
>  	/*
>  	 * Step 5:  Execute a new shell with the new context in `new_context'. 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
