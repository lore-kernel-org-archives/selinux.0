Message-ID: <442C277C.6010906@redhat.com>
Date: Thu, 30 Mar 2006 13:46:20 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: sds@tycho.nsa.gov
CC: James Morris <jmorris@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fix file descriptor leak
References: <442AEF1E.9020503@redhat.com> <1143738031.24555.222.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1143738031.24555.222.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2006-03-29 at 15:33 -0500, Daniel J Walsh wrote:
> diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.c libsemanage-1.6.2/src/semanage_store.c
> --- nsalibsemanage/src/semanage_store.c	2006-03-10 09:48:01.000000000 -0500
> +++ libsemanage-1.6.2/src/semanage_store.c	2006-03-29 14:20:16.000000000 -0500
> @@ -1159,6 +1159,8 @@
>  		ERR(sh, "Could not open direct %s at %s.", lock_name, lock_file);
>  		return -1;
>  	}
> +	fcntl(fd, FD_CLOEXEC, 0);
> +
>  	if (sh->timeout == 0) {
>  		/* return immediately */
>  		origtime.tv_sec = 0;
>
> Shouldn't that be:
> 	fcntl(fd, F_SETFD, FD_CLOEXEC)?
>
>   
yes

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
