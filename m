Return-Path: <SRS0=OcM+=VG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5007C73C46
	for <selinux@archiver.kernel.org>; Tue,  9 Jul 2019 18:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7763920665
	for <selinux@archiver.kernel.org>; Tue,  9 Jul 2019 18:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="SM6XV75/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfGISNM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:13:12 -0400
Received: from usfb19pa15.eemsg.mail.mil ([214.24.26.86]:2190 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfGISNL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jul 2019 14:13:11 -0400
X-EEMSG-check-017: 233010412|USFB19PA15_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Jul 2019 18:12:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1562695977; x=1594231977;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=r2Syc4dVlrBOYhwpJv1XNLiFAnYfl3jJYHCbzUb+4CU=;
  b=SM6XV75/lfF0N8G6ria6GnY4+aXZiBEhhpp+Pn9tQSjVKBEqJrL22Lwg
   VibKjsEUMMokuLB3Run9Sm0MToT/P2V7+SFbIg/IKU23OClzQDORz0sXV
   dz4sBhhFancBzHc6Iju3KdAxOtEDJ1EONW4bv434B64xIG0Dt7vSQQUc9
   74DEK4TqUPbaMnXVrJ21pLn0dxiRc8ID4b6IzsVdsxCB+AiVlOsAdkJN0
   /+Fve+qkIdg+zFVQjP/GNY0oK6/cP7rBVuo6p2Dw6Q77xyHr+e4zI5ifV
   4+8KFWP8Yw7/IGyxmmTm79ediE8ZvEmzxrtjANH103cXZ9ylonlxbK6Ya
   w==;
X-IronPort-AV: E=Sophos;i="5.63,471,1557187200"; 
   d="scan'208";a="25519160"
IronPort-PHdr: =?us-ascii?q?9a23=3Ab7sgmxK2RnkDYn09JtmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXL/jyrarrMEGX3/hxlliBBdydt6sezbaM+Pm6AyQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagf79+Nhq7oRveusULn4duNLs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1YOqRayAA+hD/7txDBVnH/7xbA03f?=
 =?us-ascii?q?ovEQ/G3wIuEdwBv3vWo9rpO6kfSvy1warSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0sRGFovTw1yrwAuZ?=
 =?us-ascii?q?OjeigF1I8nyALFZ/yCcoiI5hTuX/uSLzdgnH9pZb2yihmo/UWg1+HwTNe43V?=
 =?us-ascii?q?lUoiZfj9XBsG0G2QbJ5cidUPR9+1+s2TOI1w/O9O5JOVs0la/HK545xb4wi4?=
 =?us-ascii?q?YTvVzDHiDonEX2i7ebdlk+9eiy6uTnf67mqoWAN450lg7+MqMulta5AeskKQ?=
 =?us-ascii?q?gBQ3KX+eG91L3n5UH5QbNKgeMqkqTBrZzXKssWqrS5DgNIyIov9RmyAym83N?=
 =?us-ascii?q?gFhXUHKUhKeBODj4jnIVHOJ/X4AO+kg1uxizdm3OzGP739DZXNKXjPirHhfa?=
 =?us-ascii?q?1n5EJGxwozys5f64pOCr4dOPLzRlPxtNvAAxAlKQO02PjoCdVm24MFRW2PAr?=
 =?us-ascii?q?WWML7csV+M+O0vOfCAa5MPtzrnN/cl4Pvuh2cjmVABZampwYcXaHegE/t6OU?=
 =?us-ascii?q?qZemTjg9cbHWcRogU+TPbliECMUT5XeXmyRbkx5jA9CIK6E4jDQpqhj6CG3C?=
 =?us-ascii?q?e+BpdWfHxJCkiQEXf0cIWJQ/UMaCeVIs97iDwEVKOhRpQn1R60sQ/11btnIv?=
 =?us-ascii?q?DT+i0CupLpzMJ16PHLlREu6Tx0CNyQ02WMT2Fyg2MJSCY63LthrkNh11eDy6?=
 =?us-ascii?q?l4g+BYFNBK4vNJVRo1NYPYz+NkEN3yRA3BccmTSFq8QdWpHysxTtQvzN8KeU?=
 =?us-ascii?q?p9HM+ijh/b1SqwH7AVj6CLBIAz8q/ExHj+OcJ9y3fA1Kk8gFgrWdVPNWK4ia?=
 =?us-ascii?q?5l7QTTBJDGk1+fl6m0caQQxinN9H2MzWCWpkFXTBZwUbnZXXAYfkbWrsr26V?=
 =?us-ascii?q?3ZT7CyDrQnNQhBxNWeJatKcN3pilBGRPb+ONTbeW6xnH2wBRmQzLOWcIXqY3?=
 =?us-ascii?q?kd3DnaCEUckQAT+naGNQ4kCiejpGLeDCZhFVT0Y0zy9+lzs2+0QVUyzwGNaU?=
 =?us-ascii?q?1h1qa69QQRhfCGV/wT2bcEsj87qzpoBFa9w87WC92Yqgp5YqpcZ9w94EpG1W?=
 =?us-ascii?q?LfrgB9PYKvL7pkhlEAdwR6pELu2wxzCoVHj8glsmkmzBFoJqKbzVNBbSmX0Y?=
 =?us-ascii?q?r2OrLJMGXy/givYbbM2l7CyNaW5rsP6PMgplX7pg6pC04i/m5/09ZPznuc4o?=
 =?us-ascii?q?zGDA8VUZL2SEY46QJ2qK3dYik4/4nUz2FjMbGosj/e3NIkHO8lyhemf9dCP6?=
 =?us-ascii?q?KIDRX9E9AHCMivNOwngEKpYQwZM+BS7qE0I9mqeOeB2K6ub65cm2eNhH9K8c?=
 =?us-ascii?q?hG2UKF6iR4R/SAi50M2PyJ9hCMVz7hglOsqIX8kMZPYjREWiK0wDPpFchKba?=
 =?us-ascii?q?17YIgPBH2GIsury9E4jJnoHzZa8Vm5HVId8MmgfBeTKVvn0kkY0UURvGzigi?=
 =?us-ascii?q?az0iZ1jyBsq62TwSjD6/rteQBBOWNRQmRmy1D2Lsz8lN0eXU61fyA3mxa/o0?=
 =?us-ascii?q?X33a5WoOJ4NWaAb11Pen3NM2x6Uqa2/oGHaspL5YJg5T5bS8ygcFuaTfj7uB?=
 =?us-ascii?q?Jc3CT9STgNjAsnfi2n782q1ydxj3iQeTMq8SvU?=
X-IPAS-Result: =?us-ascii?q?A2C5AgBF2CRd/wHyM5BmHAEBAQQBAQcEAQGBZ4FoBSpqU?=
 =?us-ascii?q?jIohByTLgEBAQEBAQaBNolbkRQJAQEBAQEBAQEBKwkBAgEBhEACgkMjOBMBA?=
 =?us-ascii?q?wEBAQQBAQEBBAEBbIU8DII6KQGCZgEBAQECASMPAQU2CxALGAICFAwGAgJXB?=
 =?us-ascii?q?gEMCAEBgl8/AYF2BQ8PrD+BMoNEggODJ4FHgQwoi18XeIEHgTiCaz6FE4I7g?=
 =?us-ascii?q?lgEjAULh3yCCJQ+CYIZgh+EN40pBhuCLIstiieNMIEwmB0hgVgrCAIYCCEPO?=
 =?us-ascii?q?4JsCYJEF4dohlUjAzABAYEEAQGMIoIuAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Jul 2019 18:12:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x69ICn3o030233;
        Tue, 9 Jul 2019 14:12:50 -0400
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
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <dbdcfb3d-a88a-67eb-a100-848f3335e9a3@tycho.nsa.gov>
Date:   Tue, 9 Jul 2019 14:12:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a3537a96-84d7-ad82-f76e-af0f44331c1b@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/9/19 1:51 PM, Casey Schaufler wrote:
> On 7/9/2019 10:13 AM, Stephen Smalley wrote:
>> On 7/3/19 5:25 PM, Casey Schaufler wrote:
>>> Create a new entry "display" in /proc/.../attr for controlling
>>> which LSM security information is displayed for a process.
>>> The name of an active LSM that supplies hooks for human readable
>>> data may be written to "display" to set the value. The name of
>>> the LSM currently in use can be read from "display".
>>> At this point there can only be one LSM capable of display
>>> active. A helper function lsm_task_display() to get the display
>>> slot for a task_struct.
>>
>> As I explained previously, this is a security hole waiting to happen. It still permits a process to affect the output of audit, alter the result of reading or writing /proc/self/attr nodes even by setuid/setgid/file-caps/context-changing programs, alter the contexts generated in netlink messages delivered to other processes (I think?), and possibly other effects beyond affecting the process' own view of things.
> 
> I would very much like some feedback regarding which of the
> possible formats for putting multiple subject contexts in
> audit records would be preferred:
> 
> 	lsm=selinux,subj=xyzzy_t lsm=smack,subj=Xyzzy
> 	lsm=selinux,smack subj=xyzzy_t,Xyzzy
> 	subj="selinux='xyzzy_t',smack='Xyzzy'"

(cc'd linux-audit mailing list)

> 
> Or something else. Free bikeshedding!
> 
> I don't see how you have a problem with netlink. My look
> at what's in the kernel didn't expose anything, but I am
> willing to be educated.

I haven't traced through it in detail, but it wasn't clear to me that 
the security_secid_to_secctx() call always occurs in the context of the 
receiving process (and hence use its display value).  If not, then the 
display of the sender can affect what is reported to the receiver; 
hence, there is a forgery concern similar to the binder issue.  It would 
be cleaner if we didn't alter the default behavior of 
security_secid_to_secctx() and security_secctx_to_secid() and instead 
introduced new hooks for any case where we truly want the display to 
take effect.

> 
>>
>> Before:
>> $ id
>> uid=1002(sds2) gid=1002(sds2) groups=1002(sds2) context=staff_u:staff_r:staff_t:s0-s0:c0.c1023
>> $ su
>> Password:
>> su: Authentication failure
>>
>> syscall audit record:
>> type=SYSCALL msg=audit(07/09/2019 11:52:49.784:365) : arch=x86_64 syscall=openat
>>   success=no exit=EACCES(Permission denied) a0=0xffffff9c a1=0x560897e58e00 a2=O_
>> WRONLY a3=0x0 items=1 ppid=3258 pid=3781 auid=sds2 uid=sds2 gid=sds2 euid=root s
>> uid=root fsuid=root egid=sds2 sgid=sds2 fsgid=sds2 tty=pts2 ses=6 comm=su exe=/usr/bin/su subj=staff_u:staff_r:staff_t:s0-s0:c0.c1023 key=(null)
>>
>> After:
>> $ id
>> uid=1002(sds2) gid=1002(sds2) groups=1002(sds2) context=staff_u:staff_r:staff_t:s0-s0:c0.c1023
>> $ echo apparmor > /proc/self/attr/display
>> $ su
>> Password:
>> su: Authentication failure
>>
>> audit record:
>> type=SYSCALL msg=audit(07/09/2019 12:05:32.402:406) : arch=x86_64 syscall=openat success=no exit=EACCES(Permission denied) a0=0xffffff9c a1=0x556b41e1ae00 a2=O_WRONLY a3=0x0 items=1 ppid=3258 pid=9426 auid=sds2 uid=sds2 gid=sds2 euid=root suid=root fsuid=root egid=sds2 sgid=sds2 fsgid=sds2 tty=pts2 ses=6 comm=su exe=/usr/bin/su subj==unconfined key=(null)
>>
>> NB The subj= field of the SYSCALL audit record is longer accurate and is potentially under the control of a process that would not be authorized to set its subject label to that value by SELinux.
> 
> It's still accurate, it's just not complete. It's a matter
> of how best to complete it.
> 
>>
>> Now, let's play with userspace.
>>
>> Before:
>> # id
>> uid=0(root) gid=0(root) groups=0(root) context=staff_u:staff_r:staff_t:s0-s0:c0.c1023
>> # passwd root
>> passwd: SELinux deny access due to security policy.
>>
>> audit record:
>> type=USER_AVC msg=audit(07/09/2019 12:24:35.135:812) : pid=12693 uid=root auid=sds2 ses=7 subj=staff_u:staff_r:passwd_t:s0-s0:c0.c1023 msg='avc:  denied  { passwd } for scontext=staff_u:staff_r:staff_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:staff_t:s0-s0:c0.c1023 tclass=passwd permissive=0  exe=/usr/bin/passwd sauid=root hostname=? addr=? terminal=pts/2'
>> type=USER_CHAUTHTOK msg=audit(07/09/2019 12:24:35.135:813) : pid=12693 uid=root auid=sds2 ses=7 subj=staff_u:staff_r:passwd_t:s0-s0:c0.c1023 msg='op=attempted-to-change-password id=root exe=/usr/bin/passwd hostname=moss-pluto.infosec.tycho.ncsc.mil addr=? terminal=pts/2 res=failed'
>>
>> After:
>> # id
>> uid=0(root) gid=0(root) groups=0(root) context=staff_u:staff_r:staff_t:s0-s0:c0.c1023
>> # echo apparmor > /proc/self/attr/display
>> # passwd root
>> passwd: SELinux deny access due to security policy.
>>
>> audit record:
>> type=USER_CHAUTHTOK msg=audit(07/09/2019 12:28:41.349:832) : pid=13083 uid=root auid=sds2 ses=7 subj==unconfined msg='op=attempted-to-change-password id=root exe=/usr/bin/passwd hostname=moss-pluto.infosec.tycho.ncsc.mil addr=? terminal=pts/2 res=failed'
>>
>> Here we again get the wrong value for subj= in the USER_CHAUTHTOK audit record, and we further lose the USER_AVC record entirely because it didn't even reach the point of the permission check due to not being able to get the caller context.
>>
>> The situation gets worse if the caller can set things up such that it can set an attribute value for one security module that is valid and privileged with respect to another security module.  This isn't a far-fetched scenario; AppArmor will default to running everything unconfined, so as soon as you enable it, any root process can potentially load a policy that defines contexts that look exactly like SELinux contexts. Smack is even simpler; you can set any arbitrary string you want as long as you are root (by default); no policy required.  So a root process that is confined by SELinux (or by AppAmor) can suddenly forge arbitrary contexts in audit records or reads of /proc/self/attr nodes or netlink messages or ..., just by virtue of applying these patches and enabling another security module like Smack. Or consider if ptags were ever made real and merged - by design, that's all about setting arbitrary tags from userspace.  Then there is the separate issue of switching
>> display to prevent attempts by a more privileged program to set one of its attributes from taking effect. Where have we seen that before - sendmail capabilities bug anyone?  And it is actually worse than that bug, because with the assistance of a friendly security module, the write may actually succeed; it just won't alter the SELinux context of the program or anything it creates!
>>
>> This gets a NAK from me so long as it has these issues and setting the display remains outside the control of any security module.
> 
> The issues you've raised around audit are meritorious.
> Any suggestions regarding how to address them would be
> quite welcome.
> 
> As far as the general objection to the display mechanism,
> I am eager to understand what you might propose as an
> alternative. We can't dismiss backward compatibility for
> any of the modules. We can't preclude any module combination.
> 
> We can require user space changes for configurations that
> were impossible before, just as the addition of SELinux to
> a system required user space changes. Update libselinux
> to check the display before using the attr interfaces and
> you've addressed most of the issues.

Either we ensure that setting of the display can only affect processes 
in the same security equivalence class (same credentials) or the 
security modules need to be able to control who can set the display.  Or 
both.
