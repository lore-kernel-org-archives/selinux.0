Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4492GI4023458
	for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 05:02:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4492F7R005153
	for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 09:02:15 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id h44921KP005150 for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 09:02:12 GMT
Date: Sun, 4 May 2003 19:01:34 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Subject: Re: ssh/login
Message-ID: <20030504090134.GB2483@snoopy.apana.org.au>
References: <20030501022414.GA13019@snoopy.apana.org.au> <1051793224.1377.64.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1051793224.1377.64.camel@moss-huskers.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 01, 2003 at 08:47:05AM -0400, Stephen Smalley wrote:
> Index: lsm-2.4/security/selinux/syscalls.c
> ===================================================================
> RCS file: /home/pal/CVS/lsm-2.4/security/selinux/syscalls.c,v
> retrieving revision 1.14
> diff -u -r1.14 syscalls.c
> --- lsm-2.4/security/selinux/syscalls.c	21 Mar 2003 16:07:05 -0000	1.14
> +++ lsm-2.4/security/selinux/syscalls.c	1 May 2003 12:36:15 -0000
> @@ -41,6 +41,10 @@
>  long sys_getsecsid(void) 
>  {
>  	struct task_security_struct *tsec;
> +	extern int ss_initialized;
> +
> +	if (!ss_initialized)
> +		return -ENOSYS;
>  
>  	tsec = current->security;
>  	return tsec->sid;

I can confirm that this patch works.

Thanks.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
