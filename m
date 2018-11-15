Return-Path: <SRS0=eoah=N2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB611C43441
	for <selinux@archiver.kernel.org>; Thu, 15 Nov 2018 14:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B270B2086B
	for <selinux@archiver.kernel.org>; Thu, 15 Nov 2018 14:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B270B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbeKPAsc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:48:32 -0500
Received: from uphb19pa13.eemsg.mail.mil ([214.24.26.87]:34996 "EHLO
        usfb19pa16.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387839AbeKPAsc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Nov 2018 19:48:32 -0500
X-EEMSG-check-008: 143604888|USFB19PA16_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by usfb19pa16.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Nov 2018 14:40:24 +0000
X-IronPort-AV: E=Sophos;i="5.56,236,1539648000"; 
   d="scan'208";a="17871268"
IronPort-PHdr: =?us-ascii?q?9a23=3A33IvwhZahZt6oRhuHutUPTn/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsy8ZB7h7PlgxGXEQZ/co6odzbaO7Oa4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahY75+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+v9LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYNIPpUo4z7qlATrxWxGBOsCfvyxDFWiH/43a403e?=
 =?us-ascii?q?ovHg7J3gMvA90AvW/IrNj3LqoeTfy5wafKwDjFcvhY2S396I/Nch05vP+MQa?=
 =?us-ascii?q?x/cdLRyUYxEQPOk0ieqYn/MDOR0uQCrWia5PdnWOK0lmEnsBp8oiSvx8gwio?=
 =?us-ascii?q?nJgZgZylbf9Spj2oo1Ktq4SFBibNOiDZBeuSaaN45sTcMjRWFloCk6yrwauZ?=
 =?us-ascii?q?67YSgF044ryALYa/yCdYWD/xHtVP6JLDtli39od6izihav/US61OHxWde43E?=
 =?us-ascii?q?xXoidDj9LCrGoC1wbJ5ciCUvZ9+0Ch1iuR2A3L8eFEJFw0lbLcK5483r48jp?=
 =?us-ascii?q?oTvlrHHi/xgEj2kLWZdl8l+ui18OTreKnmp5+AOI90jQHyKKIuldCkAeskKA?=
 =?us-ascii?q?QOWmmb+eCk2L3i+032XqlKg+UrnqTWv53WP8QWqrOjDwNL3Ysv9QyzAyq+3N?=
 =?us-ascii?q?Qdh3YHLVZFeBydj4juPlHDOOv4Auqkg1m3jDdqx+zJPr3mApnXKHjDi63uca?=
 =?us-ascii?q?xy605b1go/1cpf6I5MCrEdPPLzXVf8tNvdDh8+KAy0xfzoB8lj2Y4FQ2KAHL?=
 =?us-ascii?q?KWMKPIvl+U/O4gP+6MZIoNsjbnN/cl/+LujWM+mVIFe6mo0oMXZGqiHvt8PU?=
 =?us-ascii?q?WZYGHhgtgEEWgQvwo+SPbmh0GFUT5Wf3yyRb4z5iknCIK6CofOXputj6KF3C?=
 =?us-ascii?q?e6GJ1We29HB0uSEXfnaYqEQe0AaCGMLc97lDwLS7yhR5Um1RG0uw/w06BnIf?=
 =?us-ascii?q?bM+i0EqZLj08B45/XJmhEv8Tx5FNyd3HuQT2Fwh28IQjg23KdloUNj0FuMza?=
 =?us-ascii?q?94g/lAH9xJ+/xJShs6NYLbz+FiDdDyXAHBc8yGSFahRdWmDjUxQcwrz9ASZE?=
 =?us-ascii?q?Z9HobqsheW+CymGbIX35mMH5o9+a/flyz2IsFmzX/N2YE7glUmS9cJPmqj0O?=
 =?us-ascii?q?o38RjLQZTAjUSxmKOjdKBa1ynIp0mZym/bh11VSA59V+3+WHkbYkbH5YDi6l?=
 =?us-ascii?q?jqU66lCbNhNBBIj8GFNP0ZOZXSkVxaSaK7a5zlaGWrljL1XE/Qyw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ALAABhhO1b/wHyM5BiGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYFaKWaBAieDeIgYjEgBAQIBAQaBCC2JBw6OIYF6MgYBg3pGAoNOIjQJD?=
 =?us-ascii?q?QEDAQEBAQEBAgFsHAyCNiQBgmIBBSMVNA0QCw4KAgImAgIhNgYBDAYCAQGCX?=
 =?us-ascii?q?j8BgWkDCA0PqBCBL4VAgkANghQFgQuKehd4gQeBOIJrglZFAgKBOYMqglcCi?=
 =?us-ascii?q?QM/hgw0To5mLgmGeYcAgyUGGJB2jS+BB4sXOIFVKwgCGAghD4MngicXg0qKc?=
 =?us-ascii?q?CEDMIEFAQGKYoJMAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Nov 2018 14:40:22 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wAFEeLtY018569;
        Thu, 15 Nov 2018 09:40:21 -0500
Subject: Re: Android kill capability denials
To:     Ondrej Mosnacek <omosnace@redhat.com>, nxp.ravi@gmail.com
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@tycho.nsa.gov>,
        Nick Kralevich <nnk@google.com>
References: <CACikiw1uNCYKzo9vjG=AZHpARWv-nzkCX=D-aWBssM7vYZrQdQ@mail.gmail.com>
 <CAFqZXNtDbRhPUw3HsQq+yn9h==_GUDXrNb3s+odD_uLgBq8=hw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <835d4746-71f4-d0de-5e57-da36a39843f2@tycho.nsa.gov>
Date:   Thu, 15 Nov 2018 09:42:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNtDbRhPUw3HsQq+yn9h==_GUDXrNb3s+odD_uLgBq8=hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/15/18 8:11 AM, Ondrej Mosnacek wrote:
> On Mon, Nov 12, 2018 at 7:56 AM Ravi Kumar <nxp.ravi@gmail.com> wrote:
>> Hi team ,
>>
>> On android- with latest kernels 4.14  we are seeing some denials which seem to be very much genuine to be address . Where kernel is trying to kill its own  created process ( might be for maintenance) .
>> These are seen in long Stress testing .  But  I dont see any one adding such rule in general so the question is  do we see any risk  which made us not to add such rules ?
>>
>> 1.   avc: denied { kill } for pid=2432 comm="irq/66-90b6300." capability=5 scontext=u:r:kernel:s0 tcontext=u:r:kernel:s0 tclass=capability permissive=0
>> 2.   avc: denied { kill } for pid=69 comm="rcuop/6" capability=5 scontext=u:r:kernel:s0 tcontext=u:r:kernel:s0 tclass=capability permissive=0
>> 3.   avc: denied { kill } for pid=0 comm="swapper/1" capability=5 scontext=u:r:kernel:s0 tcontext=u:r:kernel:s0 tclass=capability permissive=0
>> 4.   avc: denied { kill } for pid=4185 comm="kworker/0:4" capability=5 scontext=u:r:kernel:s0 tcontext=u:r:kernel:s0 tclass=capability permissive=0
>>
>> This is self capability any one in kernel context  should be able to do such operations  I guess.
> 
> The reference policy does contain a rule that allows this kind of
> operations, see:
> https://github.com/SELinuxProject/refpolicy/blob/master/policy/modules/kernel/kernel.te#L203
> 
> It is also present in the Fedora policy on my system:
> 
> $ sesearch -A -s kernel_t -t kernel_t -c capability -p kill
> allow kernel_t kernel_t:capability { audit_control audit_write chown
> dac_override dac_read_search fowner fsetid ipc_lock ipc_owner kill
> lease linux_immutable mknod net_admin net_bind_service net_broadcast
> net_raw setfcap setgid setpcap s
> etuid sys_admin sys_boot sys_chroot sys_nice sys_pacct sys_ptrace
> sys_rawio sys_resource sys_time sys_tty_config };
> 
> Therefore I would say it is perfectly fine to add such rule to your
> policy as well.

Android uses a completely different policy not based on the reference 
policy at all, and tries to limit even the kernel and init domains to 
least privilege.  There are a few reasons to limit even the kernel domain:

1) To protect kernel threads and kernel usermodehelpers from being 
tricked into misusing their privileges and ensuring that they always 
transition to a non-kernel domain upon executing a usermodehelper.

2) To render typical kernel exploits that just switch to the init cred 
or otherwise rewrite their cred to use SECINITSID_KERNEL from gaining 
full privileges.

There are no unconfined domains in Android policy.

I think we would at least want to know why the permission check is 
occurring, as it might reflect a kernel bug.  If you can get system call 
audit info, then you can see additional information that may be helpful.

