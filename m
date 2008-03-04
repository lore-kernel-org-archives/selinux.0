Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m24KEiA5003399
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 15:14:44 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m24KEfGg003135
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 20:14:41 GMT
Subject: Re: [PATCH] Refpolicy: Add new permissions for open perms
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Eric Paris <eparis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1204211398.3206.68.camel@localhost.localdomain>
References: <1204211398.3206.68.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 15:11:59 -0500
Message-Id: <1204661519.14217.30.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-02-28 at 10:09 -0500, Eric Paris wrote:
> Add new permissions for open permissions.  This patch does not enable or
> make use of those new permissions.  I'll leave that for a future patch
> from the policy people.

Merged.

> diff -Naupr serefpolicy-3.3.0.orig/policy/flask/access_vectors serefpolicy-3.3.0/policy/flask/access_vectors
> --- serefpolicy-3.3.0.orig/policy/flask/access_vectors	2008-02-25 17:00:34.000000000 -0500
> +++ serefpolicy-3.3.0/policy/flask/access_vectors	2008-02-26 17:36:05.000000000 -0500
> @@ -125,6 +125,7 @@ inherits file
>  	reparent
>  	search
>  	rmdir
> +	open
>  }
>  
>  class file
> @@ -133,6 +134,7 @@ inherits file
>  	execute_no_trans
>  	entrypoint
>  	execmod
> +	open
>  }
>  
>  class lnk_file
> @@ -144,16 +146,23 @@ inherits file
>  	execute_no_trans
>  	entrypoint
>  	execmod
> +	open
>  }
>  
>  class blk_file
>  inherits file
> +{
> +	open
> +}
>  
>  class sock_file
>  inherits file
>  
>  class fifo_file
>  inherits file
> +{
> +	open
> +}
>  
>  class fd
>  {
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
