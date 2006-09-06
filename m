Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k86GW8lB014346
	for <selinux@tycho.nsa.gov>; Wed, 6 Sep 2006 12:32:08 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k86GVOsu021156
	for <selinux@tycho.nsa.gov>; Wed, 6 Sep 2006 16:31:24 GMT
Subject: Re: Latest Diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <44FDE6BE.2010008@redhat.com>
References: <44FDE6BE.2010008@redhat.com>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 12:33:58 -0400
Message-Id: <1157560438.26420.16.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-05 at 17:06 -0400, Daniel J Walsh wrote:
> Bluetooth_helper hits the unlabeled_t:socket stuff

Unlabeled generic socket?  I don't see this in the patch, and it doesn't
make sense to me anyway.

> What is the problem with the following?
> 
> +',`
> +       ifdef(`enable_mls',`
> +               userdom_read_user_tmp_files(secadm, semanage_t)
> +       ',`
> +               userdom_read_user_tmp_files(sysadm, semanage_t)
> +       ')
>  ')

Can't use these prefixes here since they don't originate from this
module.

> Added validatefc to check file context against base.pp.
> 
> Only works on targeted policy since others have ROLE_home_dir_t and the 
> like.

I don't see this as being very useful since its only the base module.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
