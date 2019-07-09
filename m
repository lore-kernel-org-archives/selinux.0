Return-Path: <SRS0=OcM+=VG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDAFC73C53
	for <selinux@archiver.kernel.org>; Tue,  9 Jul 2019 21:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CAE20656
	for <selinux@archiver.kernel.org>; Tue,  9 Jul 2019 21:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="VCzkbEsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfGIVg3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jul 2019 17:36:29 -0400
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:32486 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIVg3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jul 2019 17:36:29 -0400
X-EEMSG-check-017: 693588585|UCOL19PA11_EEMSG_MP9.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.63,472,1557187200"; 
   d="scan'208";a="693588585"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Jul 2019 21:34:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1562708062; x=1594244062;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Vu9B7jRWxhQ/VfSGoGaTKh8girEWFWU/ev8HIGh5lE4=;
  b=VCzkbEsX8kK06WWzKYMrx+7sNHkXG/paHNsMlfJ86rsqXBuUnOwelT76
   xkh2Dz1K3Lx3XQDCFv7CzHxpXTzqzAKOwZjbcm8KPhxCaewa2rLwtCbvl
   V/oRwqhuzyxITISSbI2CA3TdVxDHXxzJKIkhmW+suzn54dkG6CJYw/PYE
   JFhMnHoG5qS/3JlqhWydAzCUxGifpRSlV5BDBjLOwU4R545/OElHHwDJC
   LkTL51Viy+LbhZh/2F9wJxfrNGfh2CGtk/CVyzqFO5M3UXgwFQGjldEa3
   pQRwhwpSIdxPYB4tnJisSJcT3xSplgCGxanLCN9YHnc0MyH9fT9ncz9Dc
   A==;
X-IronPort-AV: E=Sophos;i="5.63,472,1557187200"; 
   d="scan'208";a="25534994"
IronPort-PHdr: =?us-ascii?q?9a23=3AjVhd2hQWKaGfkhXOQ1GNo5Y189psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YRCBt8tkgFKBZ4jH8fUM07OQ7/m6HzBbqszd+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAiooQnLucQbj4RuJrg+xx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipPDYOma4sEEvQPM+BWoYLgo1cCtBuzCA2pCO7p1zRGhGL53bci3u?=
 =?us-ascii?q?o8Dw/G0gwuEdEAvnvao9r6NrsdX++uwanUzjjOde9a1Svz5YXKdB0qvPGCXa?=
 =?us-ascii?q?h3ccrU0UQhCh/FgUuIqYzlITyV0PkGvXWe7+V6UeKvj3AoqgFsqTWo3ccjl5?=
 =?us-ascii?q?LJi5kJylHE6Sp5wIE1Kce+SE5ge9GoCpRQtyaEN4ZvRM4pXm9muCE/yrIcuJ?=
 =?us-ascii?q?67ejAHyJI7yB7Ed/OLaY2I4hPnVOuXPDx2h2pldaqiixu9/kWs0O3xWtSu3F?=
 =?us-ascii?q?pUoSdJjMPAum0L2hfO8MaIUOF98V2k2TuX0gDT7fxLLl4smKrALp4h3qYwlp?=
 =?us-ascii?q?0OsUTfBiP2mFv5jKuRdkg85uin8f7nYrT7pp+HLYN0lgH/Pbgumsy4G+g4NB?=
 =?us-ascii?q?QBX3OH9uim0b3j/En5TK1Ljv0wjKbZrIjXKdkUq6O2GQNY0psv5wyhAzqpzt?=
 =?us-ascii?q?gUh2QLIEpAeB2djojpP1/OIOr/Dfe6m1msiypkx+vdM739ApTCMnjDkLD7cb?=
 =?us-ascii?q?Z78E5T0hA/zd9Y55JKEr0BOu78WlfttNzECR80KxC7zPz8CNpj1oITQnmPDb?=
 =?us-ascii?q?OZMKzIrF+I6OYvLPeWZIMMpDnyMeIp6OLpjX88gVUdZ7Wm3YMLaHCkGfRrO1?=
 =?us-ascii?q?mWbmD3gtgfEWYGpBE+Q/DqiFKYTD5TaXKyULwm5jwgCYKmC5vDSZ6pgLCbwC?=
 =?us-ascii?q?i7GZhWbHhcCl+QCXfoa5mEW/AUZSKQJ89hlSYEVaKgS486zhyushX1y795Ie?=
 =?us-ascii?q?rV4CEYsojj1Ndt7e3JiR4y7SB0D9ia02yVS2F0n2UIRyI53axmukxy1EuM0b?=
 =?us-ascii?q?Vig/xZCdxS5+pFUgI9NZHB0ux6D879VxnffteGVlmmWM+qATIvQdIrxd8BfU?=
 =?us-ascii?q?J9F8+ljhDZ0CqgG6UVmKCTBJwo7qLc2GD8J91jxHbC1akhiUQmQ8RUOG24ia?=
 =?us-ascii?q?5w6RLTC5TKk0qHjaaqc7oT3CrX+GeE12qOs1lSUBRsXqXdQXAfekzWoMz65k?=
 =?us-ascii?q?zcUbCuEqgoMgxGyc6BMaZFdt3pjU9BRPfmOdTefmexl323BRaSybOGdJDqdH?=
 =?us-ascii?q?kF3CXBFEgElBge/XSBNQg+ACetuWDeDDtuFV31ZUPs6vdxqHWgQ0Ao1Q6KaU?=
 =?us-ascii?q?ph17y0+hEJn/OcT+kf0a4DuCcksz90Bkqy38rKC9qcoApsZL1cbs074FdIyG?=
 =?us-ascii?q?LZtgp9MoWjL698nF4edRp4v0f12hV2E4lAlc8qrG00wwZoMqKXylBBdy6C3Z?=
 =?us-ascii?q?/qILHXLHf98Aqta67OwlveysqZ+r8T6PQkrFXupBmpGVA/83VjyNRVy2GT5o?=
 =?us-ascii?q?jODAYLVJLxVUE39wJkqL3AfiY94IbU32V2Maaoqj/Cx84pBOw9xxakftdfNr?=
 =?us-ascii?q?6EFQDrH8IAGsihNe0qm0SyYxIeIu9d6a40MNm6d/ecxKGrO+Ngz3qaijFs6Z?=
 =?us-ascii?q?twwwq3/Cp1V+DM0oxNl/qRxQaWfyz3jF68vMT6g8VPbHcZGW/pjWDvDZVcd+?=
 =?us-ascii?q?tpdoYCFGmqLtefx9NiipqrUHldsBahAlQcws6yURybalH8mwpK2gBfpX2hhD?=
 =?us-ascii?q?v91DF/jisosrva2SvC3uDvXAQIN3QNR2R4i1roZ4+ugJRSR0Wsbg40hDO76k?=
 =?us-ascii?q?vggatWvqJyKy/UW0gbUTLxKjRZTqaotreEK/VK4ZcsvDQfBP+weniGW7X9pF?=
 =?us-ascii?q?0cyCqlEGxAkmNoPwq2s4n0ykQpwFmWK2x++T+AJJB9?=
X-IPAS-Result: =?us-ascii?q?A2CkAACRByVd/wHyM5BmHAEBAQQBAQcEAQGBVgQBAQsBg?=
 =?us-ascii?q?WcFKmpRATIohBySYE0BAQEBAQEGgQktiVyRFAkBAQEBAQEBAQErCQECAQGEQ?=
 =?us-ascii?q?AKCQyM3Bg4BAwEBAQQBAQEBBAEBbIU8DII6KQGCZwEFIw8BBTYLEAkCGAICF?=
 =?us-ascii?q?AwGAgJXBgEMCAEBF4JIPwGBdhQPkEyba4Eyg0SCA4MlgUeBDCgBi14XeIEHg?=
 =?us-ascii?q?TiCaz6EHnWCATqCWASMBQuHfIIIlD4JghmCH4Q3jSkGG4Isiy2KJ40wgTCYH?=
 =?us-ascii?q?CKBWCsIAhgIIQ87gmwJgkQXh2iGVSMDMAEBgQQBAYwVI4IuAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Jul 2019 21:34:20 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x69LYHgc028309;
        Tue, 9 Jul 2019 17:34:18 -0400
Subject: Re: [PATCH v5 15/23] LSM: Specify which LSM to display
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        "linux-audit@redhat.com" <linux-audit@redhat.com>
References: <20190703212538.7383-1-casey@schaufler-ca.com>
 <20190703212538.7383-16-casey@schaufler-ca.com>
 <6f593ae9-4c79-7a04-41a3-c04ebd689658@tycho.nsa.gov>
 <a3537a96-84d7-ad82-f76e-af0f44331c1b@schaufler-ca.com>
 <dbdcfb3d-a88a-67eb-a100-848f3335e9a3@tycho.nsa.gov>
 <1d62a67c-2096-5d8b-dad4-2e1c1c0ebc06@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c592f686-e026-642e-b8b3-bca08d0a0f05@tycho.nsa.gov>
Date:   Tue, 9 Jul 2019 17:34:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1d62a67c-2096-5d8b-dad4-2e1c1c0ebc06@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/9/19 5:18 PM, Casey Schaufler wrote:
> On 7/9/2019 11:12 AM, Stephen Smalley wrote:
>> On 7/9/19 1:51 PM, Casey Schaufler wrote:
>>> On 7/9/2019 10:13 AM, Stephen Smalley wrote:
>>>> On 7/3/19 5:25 PM, Casey Schaufler wrote:
>>>>> Create a new entry "display" in /proc/.../attr for controlling
>>>>> which LSM security information is displayed for a process.
>>>>> The name of an active LSM that supplies hooks for human readable
>>>>> data may be written to "display" to set the value. The name of
>>>>> the LSM currently in use can be read from "display".
>>>>> At this point there can only be one LSM capable of display
>>>>> active. A helper function lsm_task_display() to get the display
>>>>> slot for a task_struct.
>>>>
>>>> As I explained previously, this is a security hole waiting to happen. It still permits a process to affect the output of audit, alter the result of reading or writing /proc/self/attr nodes even by setuid/setgid/file-caps/context-changing programs, alter the contexts generated in netlink messages delivered to other processes (I think?), and possibly other effects beyond affecting the process' own view of things.
>>>
>>> I would very much like some feedback regarding which of the
>>> possible formats for putting multiple subject contexts in
>>> audit records would be preferred:
>>>
>>>      lsm=selinux,subj=xyzzy_t lsm=smack,subj=Xyzzy
>>>      lsm=selinux,smack subj=xyzzy_t,Xyzzy
>>>      subj="selinux='xyzzy_t',smack='Xyzzy'"
>>
>> (cc'd linux-audit mailing list)
>>
>>>
>>> Or something else. Free bikeshedding!
>>>
>>> I don't see how you have a problem with netlink. My look
>>> at what's in the kernel didn't expose anything, but I am
>>> willing to be educated.
>>
>> I haven't traced through it in detail, but it wasn't clear to me that the security_secid_to_secctx() call always occurs in the context of the receiving process (and hence use its display value).  If not, then the display of the sender can affect what is reported to the receiver; hence, there is a forgery concern similar to the binder issue.  It would be cleaner if we didn't alter the default behavior of security_secid_to_secctx() and security_secctx_to_secid() and instead introduced new hooks for any case where we truly want the display to take effect.
> 
> If the context is generated by security_secid_to_secctx() we
> retain the slot number of the module that created it in lsmcontext.
> We have to to ensure it is released correctly. If the potential
> issue you're describing for netlink does in fact occur, we can check
> the slot in lsmcontext to verify that it is the same.
> 
> security_secid_to_secctx() is called nowhere in net/netlink,
> at least not that grep finds. Where are you seeing this potential
> problem?

Look under net/netfilter.

> 
>>
>>>
>>>> Before:
>>>> $ id
>>>> uid=1002(sds2) gid=1002(sds2) groups=1002(sds2) context=staff_u:staff_r:staff_t:s0-s0:c0.c1023
>>>> $ su
>>>> Password:
>>>> su: Authentication failure
>>>>
>>>> syscall audit record:
>>>> type=SYSCALL msg=audit(07/09/2019 11:52:49.784:365) : arch=x86_64 syscall=openat
>>>>    success=no exit=EACCES(Permission denied) a0=0xffffff9c a1=0x560897e58e00 a2=O_
>>>> WRONLY a3=0x0 items=1 ppid=3258 pid=3781 auid=sds2 uid=sds2 gid=sds2 euid=root s
>>>> uid=root fsuid=root egid=sds2 sgid=sds2 fsgid=sds2 tty=pts2 ses=6 comm=su exe=/usr/bin/su subj=staff_u:staff_r:staff_t:s0-s0:c0.c1023 key=(null)
>>>>
>>>> After:
>>>> $ id
>>>> uid=1002(sds2) gid=1002(sds2) groups=1002(sds2) context=staff_u:staff_r:staff_t:s0-s0:c0.c1023
>>>> $ echo apparmor > /proc/self/attr/display
>>>> $ su
>>>> Password:
>>>> su: Authentication failure
>>>>
>>>> audit record:
>>>> type=SYSCALL msg=audit(07/09/2019 12:05:32.402:406) : arch=x86_64 syscall=openat success=no exit=EACCES(Permission denied) a0=0xffffff9c a1=0x556b41e1ae00 a2=O_WRONLY a3=0x0 items=1 ppid=3258 pid=9426 auid=sds2 uid=sds2 gid=sds2 euid=root suid=root fsuid=root egid=sds2 sgid=sds2 fsgid=sds2 tty=pts2 ses=6 comm=su exe=/usr/bin/su subj==unconfined key=(null)
>>>>
>>>> NB The subj= field of the SYSCALL audit record is longer accurate and is potentially under the control of a process that would not be authorized to set its subject label to that value by SELinux.
>>>
>>> It's still accurate, it's just not complete. It's a matter
>>> of how best to complete it.
>>>
>>>>
>>>> Now, let's play with userspace.
>>>>
>>>> Before:
>>>> # id
>>>> uid=0(root) gid=0(root) groups=0(root) context=staff_u:staff_r:staff_t:s0-s0:c0.c1023
>>>> # passwd root
>>>> passwd: SELinux deny access due to security policy.
>>>>
>>>> audit record:
>>>> type=USER_AVC msg=audit(07/09/2019 12:24:35.135:812) : pid=12693 uid=root auid=sds2 ses=7 subj=staff_u:staff_r:passwd_t:s0-s0:c0.c1023 msg='avc:  denied  { passwd } for scontext=staff_u:staff_r:staff_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:staff_t:s0-s0:c0.c1023 tclass=passwd permissive=0  exe=/usr/bin/passwd sauid=root hostname=? addr=? terminal=pts/2'
>>>> type=USER_CHAUTHTOK msg=audit(07/09/2019 12:24:35.135:813) : pid=12693 uid=root auid=sds2 ses=7 subj=staff_u:staff_r:passwd_t:s0-s0:c0.c1023 msg='op=attempted-to-change-password id=root exe=/usr/bin/passwd hostname=moss-pluto.infosec.tycho.ncsc.mil addr=? terminal=pts/2 res=failed'
>>>>
>>>> After:
>>>> # id
>>>> uid=0(root) gid=0(root) groups=0(root) context=staff_u:staff_r:staff_t:s0-s0:c0.c1023
>>>> # echo apparmor > /proc/self/attr/display
>>>> # passwd root
>>>> passwd: SELinux deny access due to security policy.
>>>>
>>>> audit record:
>>>> type=USER_CHAUTHTOK msg=audit(07/09/2019 12:28:41.349:832) : pid=13083 uid=root auid=sds2 ses=7 subj==unconfined msg='op=attempted-to-change-password id=root exe=/usr/bin/passwd hostname=moss-pluto.infosec.tycho.ncsc.mil addr=? terminal=pts/2 res=failed'
>>>>
>>>> Here we again get the wrong value for subj= in the USER_CHAUTHTOK audit record, and we further lose the USER_AVC record entirely because it didn't even reach the point of the permission check due to not being able to get the caller context.
>>>>
>>>> The situation gets worse if the caller can set things up such that it can set an attribute value for one security module that is valid and privileged with respect to another security module.  This isn't a far-fetched scenario; AppArmor will default to running everything unconfined, so as soon as you enable it, any root process can potentially load a policy that defines contexts that look exactly like SELinux contexts. Smack is even simpler; you can set any arbitrary string you want as long as you are root (by default); no policy required.  So a root process that is confined by SELinux (or by AppAmor) can suddenly forge arbitrary contexts in audit records or reads of /proc/self/attr nodes or netlink messages or ..., just by virtue of applying these patches and enabling another security module like Smack. Or consider if ptags were ever made real and merged - by design, that's all about setting arbitrary tags from userspace.  Then there is the separate issue of switching
>>>> display to prevent attempts by a more privileged program to set one of its attributes from taking effect. Where have we seen that before - sendmail capabilities bug anyone?  And it is actually worse than that bug, because with the assistance of a friendly security module, the write may actually succeed; it just won't alter the SELinux context of the program or anything it creates!
>>>>
>>>> This gets a NAK from me so long as it has these issues and setting the display remains outside the control of any security module.
>>>
>>> The issues you've raised around audit are meritorious.
>>> Any suggestions regarding how to address them would be
>>> quite welcome.
>>>
>>> As far as the general objection to the display mechanism,
>>> I am eager to understand what you might propose as an
>>> alternative. We can't dismiss backward compatibility for
>>> any of the modules. We can't preclude any module combination.
>>>
>>> We can require user space changes for configurations that
>>> were impossible before, just as the addition of SELinux to
>>> a system required user space changes. Update libselinux
>>> to check the display before using the attr interfaces and
>>> you've addressed most of the issues.
>>
>> Either we ensure that setting of the display can only affect processes in the same security equivalence class (same credentials)
> 
> In the process of trying to argue against your point I
> may have come around to your thinking. There would still
> be the case where a privileged program sets the display
> and invokes an equally privileged program which is "tricked"
> into setting the wrong attribute, but you have to put the
> responsibility for use of privilege on someone, somewhere.
> 
> I will propose a solution in the next round.
> 
>> or the security modules need to be able to control who can set the display.
> 
> That's a mechanism for a module to opt-out of stacking,
> and Paul has been pretty clear that he won't go for that.

It doesn't have to be used that way; it can just be used to limit the 
set of authorized processes that can set the display to e.g. trusted 
container runtimes.
