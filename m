Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0RK50Xf010071
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 15:05:00 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0RK4vC1011534
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 20:04:58 GMT
Subject: Re: Latest diff
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43D9BF9F.2010601@redhat.com>
References: <43D9BF9F.2010601@redhat.com>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 15:07:50 -0500
Message-Id: <1138392470.9344.150.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-27 at 01:37 -0500, Daniel J Walsh wrote:
> Want to drop sensitivity level on rpm and lvm when run by kernel or 
> sysadm_t at SystemHigh.

This seems to contradict what you have in the patch:

> @@ -86,7 +86,8 @@
>  ')
>  
>  ifdef(`enable_mls',`
> -# run init with maximum MLS range
>  range_transition kernel_t init_exec_t s0 - s15:c0.c255;
> +range_transition kernel_t lvm_exec_t s0 - s15:c0.c255;
>  range_transition initrc_t auditd_exec_t s15:c0.c255;
> +range_transition sysadm_t rpm_exec_t s0 - s15:c0.c255;
>  ')

Also, why are these needed instead of just using the MLS interfaces?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
