MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] libsemanage: free policydb before fork
Date: Mon, 4 Feb 2008 11:54:33 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880181EF0C@exchange.columbia.tresys.com>
In-Reply-To: <1202143295.3070.102.camel@moss-spartans.epoch.ncsc.mil>
References: <47A5311F.2020703@manicmethod.com> <6FE441CD9F0C0C479F2D88F959B015880181EED5@exchange.columbia.tresys.com> <1202143295.3070.102.camel@moss-spartans.epoch.ncsc.mil>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Joshua Brindle" <method@manicmethod.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Ok, patch below makes this change.
> 
> Index: trunk/libsemanage/src/semanage_store.c
> ===================================================================
> --- trunk/libsemanage/src/semanage_store.c	(revision 2783)
> +++ trunk/libsemanage/src/semanage_store.c	(working copy)
> @@ -911,14 +911,14 @@
> 
>  	/* no need to use pthread_atfork() -- child will not be using
>  	 * any mutexes. */
> -	if ((forkval = fork()) == -1) {
> +	if ((forkval = vfork()) == -1) {
>  		ERR(sh, "Error while forking process.");
>  		return -1;
>  	} else if (forkval == 0) {
>  		/* child process.  file descriptors will be closed
>  		 * because they were set as close-on-exec. */
>  		execve(e->path, argv, NULL);
> -		exit(EXIT_FAILURE);	/* if execve() failed */
> +		_exit(EXIT_FAILURE);	/* if execve() failed */
>  	} else {
>  		/* parent process.  wait for child to finish */
>  		int status = 0;

That's identical to what I have in my tree.  Works fine here.

Acked-By: Todd C. Miller <tmiller@tresys.com>

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
