Return-Path: <SRS0=eoah=N2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B029C43441
	for <selinux@archiver.kernel.org>; Thu, 15 Nov 2018 15:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F45C20818
	for <selinux@archiver.kernel.org>; Thu, 15 Nov 2018 15:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F45C20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388019AbeKPBsS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:48:18 -0500
Received: from ucol19pa09.eemsg.mail.mil ([214.24.24.82]:5093 "EHLO
        ucol19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeKPBsS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Nov 2018 20:48:18 -0500
X-EEMSG-check-008: 792654790|UCOL19PA09_EEMSG_MP7.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,236,1539648000"; 
   d="scan'208";a="792654790"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Nov 2018 15:39:56 +0000
X-IronPort-AV: E=Sophos;i="5.56,236,1539648000"; 
   d="scan'208";a="17875039"
IronPort-PHdr: =?us-ascii?q?9a23=3AoNzU5hY0vuw5BSOVxq61ehn/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsq4bnLW6fgltlLVR4KTs6sC17KJ9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa/bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+YcIepUqo/wrEYMoxSjHwmhHP7hxD9WiH/43qM03e?=
 =?us-ascii?q?ouHg7E0wM8ENwDq2jUodbvOasOTey4wqvFwDPeZP1Wwzf9743Ifwg8r/GQQ7?=
 =?us-ascii?q?1wacrRxlcpFwjYk1uQrJbqPzeR1usTs2mQ8u1tVfmyhG48sAxxvjiuydssio?=
 =?us-ascii?q?nOnI4VzEvE+j9jzIY6It24Vld2bNi5G5VesCGaMpF5QsIkQ2xwtyY6y6EGuZ?=
 =?us-ascii?q?6mfCcR0pgo2xnfa/mBfoOV4RzjTP6cLSp3iX9qYr6yhwu+/VK+xuDzSMW4yk?=
 =?us-ascii?q?tGoyxYmdfWrH8NzQbc6s2fR/t4+UeuxCiA2hjI6uFBPUA0ja3bK4M9wrIolp?=
 =?us-ascii?q?ocr0DDHijulUXqlqCWbEQk+vWz6+j9frXnpoOTN49zig3kNKQhhte/DvgiPg?=
 =?us-ascii?q?gLXmib/fyw1Lzl/ULnXLVHluA6n6bWvZzAJckXu7S1DxFa34o98RqzEi+q0N?=
 =?us-ascii?q?ECknkGKFJFdgiHj4/sO1zWO/D3EOy/jk+wkDZr2//GPrrhDo/LLnjYirjtZ7?=
 =?us-ascii?q?l960lCyAYr19BQ+4pUCq0dIPL0QkLxs9nYDhgiMwyy2enoFMty25gEWW2RH6?=
 =?us-ascii?q?CZMLndsUOS6u0zJOmMYZcfuCzhJPg9+/7ukXg5lEcbfaimxZsbcmq4Ee54I0?=
 =?us-ascii?q?WYenfsjdIBHn0Lvgo6VuDllFqCUTtLbXaoQ608/i07CJ6hDYrbXYCinriB3C?=
 =?us-ascii?q?a9Hp1LaWFLEU6MEXj2eIWeQfsMazydItVnkjMaUbitUYgh1QuhtFyy970yCe?=
 =?us-ascii?q?zY4CAa/bfkz9587ODQ3UU18DtvCc2W3kmXQm10l39OTDgziuQ3p1xljE2Kz6?=
 =?us-ascii?q?lQjPlRFNgV7PRMASkgMpuJ9PB3E9D/XEr6e96NTFu3CoG9DSoZUsM6w9hIZV?=
 =?us-ascii?q?10XdqlkEaQjGKRH7YJmunTV9QP+aXG0i20fp8lxg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ALAACVku1b/wHyM5BiGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYFaKWaBAieDeIgYjEgBAQIBAQaBCAgliQcOjiGBejIGAYN6RgKDUCI0C?=
 =?us-ascii?q?Q0BAwEBAQEBAQIBbBwMgjYkAYJiAQUjDwEFNA0QCw4KAgImAgIhNgYBDAYCA?=
 =?us-ascii?q?QGCXj8BgWkDCA0PqBCBL4gADYIUBYELinoXeIEHgTgMgl+CVkUCAoE5gyqCV?=
 =?us-ascii?q?wKJAz+GQE6OZi4JhnmHAIMlBhiQdo0vgQeLFziBVSsIAhgIIQ+DJ4InF4NKi?=
 =?us-ascii?q?nAhAzCBBQEBimKCTAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Nov 2018 15:39:56 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wAFFdtgx026578;
        Thu, 15 Nov 2018 10:39:55 -0500
Subject: Re: Android kill capability denials
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Ondrej Mosnacek <omosnace@redhat.com>, nxp.ravi@gmail.com
Cc:     selinux@vger.kernel.org, SElinux list <selinux@tycho.nsa.gov>
References: <CACikiw1uNCYKzo9vjG=AZHpARWv-nzkCX=D-aWBssM7vYZrQdQ@mail.gmail.com>
 <CAFqZXNtDbRhPUw3HsQq+yn9h==_GUDXrNb3s+odD_uLgBq8=hw@mail.gmail.com>
 <835d4746-71f4-d0de-5e57-da36a39843f2@tycho.nsa.gov>
Message-ID: <0e19cb86-5fc6-5828-84b7-33042012ac83@tycho.nsa.gov>
Date:   Thu, 15 Nov 2018 10:42:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <835d4746-71f4-d0de-5e57-da36a39843f2@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/15/18 9:42 AM, Stephen Smalley wrote:
> On 11/15/18 8:11 AM, Ondrej Mosnacek wrote:
>> On Mon, Nov 12, 2018 at 7:56 AM Ravi Kumar <nxp.ravi@gmail.com> wrote:
>>> Hi team ,
>>>
>>> On android- with latest kernels 4.14  we are seeing some denials 
>>> which seem to be very much genuine to be address . Where kernel is 
>>> trying to kill its own  created process ( might be for maintenance) .
>>> These are seen in long Stress testing .  But  I dont see any one 
>>> adding such rule in general so the question is  do we see any risk  
>>> which made us not to add such rules ?
>>>
>>> 1.   avc: denied { kill } for pid=2432 comm="irq/66-90b6300." 
>>> capability=5 scontext=u:r:kernel:s0 tcontext=u:r:kernel:s0 
>>> tclass=capability permissive=0
>>> 2.   avc: denied { kill } for pid=69 comm="rcuop/6" capability=5 
>>> scontext=u:r:kernel:s0 tcontext=u:r:kernel:s0 tclass=capability 
>>> permissive=0
>>> 3.   avc: denied { kill } for pid=0 comm="swapper/1" capability=5 
>>> scontext=u:r:kernel:s0 tcontext=u:r:kernel:s0 tclass=capability 
>>> permissive=0
>>> 4.   avc: denied { kill } for pid=4185 comm="kworker/0:4" 
>>> capability=5 scontext=u:r:kernel:s0 tcontext=u:r:kernel:s0 
>>> tclass=capability permissive=0
>>>
>>> This is self capability any one in kernel context  should be able to 
>>> do such operations  I guess.
>>
>> The reference policy does contain a rule that allows this kind of
>> operations, see:
>> https://github.com/SELinuxProject/refpolicy/blob/master/policy/modules/kernel/kernel.te#L203 
>>
>>
>> It is also present in the Fedora policy on my system:
>>
>> $ sesearch -A -s kernel_t -t kernel_t -c capability -p kill
>> allow kernel_t kernel_t:capability { audit_control audit_write chown
>> dac_override dac_read_search fowner fsetid ipc_lock ipc_owner kill
>> lease linux_immutable mknod net_admin net_bind_service net_broadcast
>> net_raw setfcap setgid setpcap s
>> etuid sys_admin sys_boot sys_chroot sys_nice sys_pacct sys_ptrace
>> sys_rawio sys_resource sys_time sys_tty_config };
>>
>> Therefore I would say it is perfectly fine to add such rule to your
>> policy as well.
> 
> Android uses a completely different policy not based on the reference 
> policy at all, and tries to limit even the kernel and init domains to 
> least privilege.  There are a few reasons to limit even the kernel domain:
> 
> 1) To protect kernel threads and kernel usermodehelpers from being 
> tricked into misusing their privileges and ensuring that they always 
> transition to a non-kernel domain upon executing a usermodehelper.
> 
> 2) To render typical kernel exploits that just switch to the init cred 
> or otherwise rewrite their cred to use SECINITSID_KERNEL from gaining 
> full privileges.
> 
> There are no unconfined domains in Android policy.
> 
> I think we would at least want to know why the permission check is 
> occurring, as it might reflect a kernel bug.  If you can get system call 
> audit info, then you can see additional information that may be helpful.

I guess system call audit isn't relevant here since these are 
kernel-internal callers.

This still seems like a kernel bug though, because 
check_kill_permission() will return 0 without performing any capability 
or other permission checks if !si_fromuser(info).  So kernel callers 
shouldn't trigger such permission checks unless I missed something.
