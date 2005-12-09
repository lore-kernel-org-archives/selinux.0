Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jB9EQrMA019645
	for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2005 09:26:53 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jB9EIupK001942
	for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2005 14:18:56 GMT
Subject: Re: Latest Ref Policy Diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4398A239.1080005@redhat.com>
References: <4398A239.1080005@redhat.com>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 09:21:48 -0500
Message-Id: <1134138108.8185.39.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-12-08 at 16:14 -0500, Daniel J Walsh wrote:
> Major change in targeted policy is about to hit.  Basically we are going 
> to turn off allow_execmod, allow_execmem, and allow_execstack by default 
> for unconfined_t programs.

I just have a question about this hunk:

> @@ -79,6 +75,8 @@
>  
>  ifdef(`targeted_policy',`
>         unconfined_domain_template(xdm_t)
> +       allow xdm_t self:process execmem;
> +        unconfined_domtrans(xdm_t)
>  ',`
>         allow xdm_t xdm_lock_t:file create_file_perms;
>         files_create_lock(xdm_t,xdm_lock_t)

Shouldn't the execmem be outside of the ifdef, since if it needs this,
it will need it regardless of the policy type?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
