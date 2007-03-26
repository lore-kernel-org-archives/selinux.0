Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2QJhdH4023287
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 15:43:39 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2QJhbRM022645
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 19:43:38 GMT
Subject: Re: fix /dev/ub specification
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F02D99.7070202@redhat.com>
References: <45F02D99.7070202@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Mar 2007 15:44:14 -0400
Message-Id: <1174938254.28830.76.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 10:36 -0500, Daniel J Walsh wrote:
> plain text document attachment
> (nsaserefpolicy_policy_modules_kernel_storage.fc)
> --- nsaserefpolicy/policy/modules/kernel/storage.fc	2006-11-16 17:15:04.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/kernel/storage.fc	2007-03-08 08:42:37.000000000 -0500
> @@ -42,7 +42,8 @@
>  /dev/sjcd		-b	gen_context(system_u:object_r:removable_device_t,s0)
>  /dev/sonycd		-b	gen_context(system_u:object_r:removable_device_t,s0)
>  /dev/tape.*		-c	gen_context(system_u:object_r:tape_device_t,s0)
> -/dev/ub[a-z]		-b	gen_context(system_u:object_r:removable_device_t,mls_systemhigh)
> +/dev/tw[a-z][^/]+	-c	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
> +/dev/ub[a-z][^/]+	-b	gen_context(system_u:object_r:removable_device_t,mls_systemhigh)
>  /dev/ubd[^/]*		-b	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
>  /dev/xvd[^/]*		-b	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
