Message-ID: <4564B4E8.2000507@tresys.com>
Date: Wed, 22 Nov 2006 15:36:56 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: More  small fixes to policycoreutils
References: <6FE441CD9F0C0C479F2D88F959B015885C7D9F@exchange.columbia.tresys.com> <4564AE4C.6020305@redhat.com>
In-Reply-To: <4564AE4C.6020305@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Amy's patch for handling exit codes in newrole.
> 
> 
> ------------------------------------------------------------------------
> 
> diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/newrole/newrole.c policycoreutils-1.33.4/newrole/newrole.c
> --- nsapolicycoreutils/newrole/newrole.c	2006-11-20 12:19:55.000000000 -0500
> +++ policycoreutils-1.33.4/newrole/newrole.c	2006-11-22 14:11:25.000000000 -0500
> @@ -1068,11 +1068,16 @@
>  		 */
>  		int rc;
>  		int exit_code = 0;
> +		int status;
>  
>  		do {
> -			rc = wait(NULL);
> +			rc = wait(&status);
>  		} while (rc < 0 && errno == EINTR);
>  
> +		/* Preserve child exit status, unless there is another error. */
> +		if (WIFEXITED(status))
> +			exit_code = WEXITSTATUS(status);
> +
>  		if (restore_tty_label(fd, ttyn, tty_context, new_tty_context)) {
>  			fprintf(stderr, _("Unable to restore tty label...\n"));
>  			exit_code = -1;

Acked-By: Joshua Brindle <method@manicmethod.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
