Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7MH1SOb021342
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 13:01:28 -0400 (EDT)
Received: from e33.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7MGoKo5025444
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:50:21 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j7MGowf5393820
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:50:59 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7MGp6h5317122
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 10:51:06 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j7MGov2D024541
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 10:50:57 -0600
Date: Mon, 22 Aug 2005 07:05:36 -0500
From: serue@us.ibm.com
To: serue@us.ibm.com
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] add variable initializer
Message-ID: <20050822120536.GB25231@sergelap.austin.ibm.com>
References: <20050822114016.GA24949@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050822114016.GA24949@sergelap.austin.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry, this patch was in libsemanage.

-serge

Quoting serue@us.ibm.com (serue@us.ibm.com):
> The following patch fixes a bug found by Coverity:
> 
> 	It is possible to goto cleanup: before outfile is
> 	initialized.  At cleanup: we try to close(outfile)
> 	if it is not NULL.
> 
> Index: src/commit_api.c
> ===================================================================
> --- src.orig/commit_api.c
> +++ src/commit_api.c
> @@ -182,7 +182,7 @@ int semod_expand_sandbox(char *sandbox, 
>          char *kernel_filename = NULL;
>          sidtab_t sidtab;
>          struct policy_file pf;
> -        FILE *outfile;
> +        FILE *outfile = NULL;
>          if (policydb_init (&out, POLICY_KERN) == -1) {
>                  write_error (error_buf, error_buf_size, "Out of memory!");
>                  retval = -1;
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
