Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k01FcxXf029983
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2006 10:38:59 -0500 (EST)
Received: from e32.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k01Fcv1Z022091
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2006 15:38:57 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k01FcwiN026199
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2006 10:38:58 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k01FbhSr237562
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2006 08:37:43 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k01Fcv67010623
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2006 08:38:57 -0700
Date: Sun, 1 Jan 2006 09:38:56 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: linux-security-module@wirex.com, "SELinux(NSA)" <selinux@tycho.nsa.gov>
Subject: Re: SELinux metadata protection
Message-ID: <20060101153856.GA15767@sergelap.austin.ibm.com>
References: <43B6C9E3.8020406@kaigai.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43B6C9E3.8020406@kaigai.gr.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting KaiGai Kohei (kaigai@kaigai.gr.jp):
> It seems a bit curious behavior for me. Why can an unauthorized process
> be allowed to know whether the file exists or not ?
> I think it's worthwhile to conceal the existence of files from unauthorized
> processes.

This behavior is also necessary for meeting the new medium robustness
protection profiles.

> Thanks, any comments please, and have a good year :)

Haven't looked at the patch in detail, but the following stood out to me:

> --- linux-2.6.14.5-selinux/fs/readdir.c	2005-12-26 19:26:33.000000000 -0500
> +++ linux-2.6.14.5-selinux.mp/fs/readdir.c	2005-12-29 20:26:55.000000000 -0500
> @@ -33,7 +33,11 @@ int vfs_readdir(struct file *file, filld
>  	down(&inode->i_sem);
>  	res = -ENOENT;
>  	if (!IS_DEADDIR(inode)) {
> -		res = file->f_op->readdir(file, buf, filler);
> +		/* NOTE:
> +		   When LSM was not enable, security_file_readdir()
> +		   is same as 'file->f_op->readdir()'. 
> +		*/
> +		res = security_file_readdir(file, buf, filler);
>  		file_accessed(file);

I don't like this - the dir->f_op->readdir should not be done inside
a function which claims to be a security check.  Plus the added code
doesn't have a return value of it's own.  So why not stay closer to usual
linux code and do something like

	security_prep_readdir();
	res = file->f_op->readdir(file, buf, filler);

inside vfs_readdir(), where security_prep_readdir() is defined away
in the non-LSM case, and is 

> +static inline void security_file_readdir (struct file *dir, void *buffer, filldir_t filler)
> +{
> +	security_filldir_t private;
> +
> +	private.dir = dir;
> +	private.buffer = buffer;
> +	private.filler = filler;

in the LSM case?

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
