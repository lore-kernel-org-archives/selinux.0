Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC7EC433DB
	for <selinux@archiver.kernel.org>; Tue,  2 Feb 2021 18:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28F764E3F
	for <selinux@archiver.kernel.org>; Tue,  2 Feb 2021 18:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbhBBSLJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Feb 2021 13:11:09 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:38534
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238278AbhBBSHZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Feb 2021 13:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1612289198; bh=j8x44LpoTFfUH4HOzyDNCNzfG3hSJ0gj9lo3px1hSNo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=SOG3MkzI/xo4NHO773dKiJqmfifbW10ppO5VX0RDiEtsVo2tYzrW3vQKUAVMkNA5lIvQREOwdvy1OoVIqnmQ0shXGFSE4BsxQgpHUkyVipBSy4igv7D8oUF4p3OO1/Etx7BlLAOPJ+A3624Hh2xvrYNTAC31HVUqRN36gZdfm0MShcpXLZrFeDsGn2GbTVzfsJkLLyGZqpXAvmVVCJjeCweKLVOACnrLE7T8NOUXwQ3Z8ZQxxYpo3ix3xBG5ZkerR6nRqfk3FnnMDmKLBEHEUuu9CFbnBKy/PbYnqOSarHsIDWiJQMmnZRoYdxSAbD8ED9JVgN2/JzSwOT0ZwfxLdw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1612289198; bh=KsrlqM5OHzy9Aywsqwu8aQS1km6LVWfDIQYwYdfcds/=; h=Subject:To:From:Date:From:Subject:Reply-To; b=p4M/nKQ3YAoXqA//DTGYpdM6RKd+Xo0RUt8RwX2vhm1c5oTViGJrwxvkEmBDt8PaWdaWrItJ78O76dsceq+In8g5e208AkusaDmDrI5FnvX8vKAD2OqhVhp1Fk8c6vIv+lTQH6Fwp4qsOUHYxV5UBxeZ+Ak23fxuyGdjuDtbpYtE/nrPD8HGyPffXyNVlUzAuerv3zkRaKf1kSzHgtfVUiTA7JCvBW1zP1bg/cBubnu0DnVQIRYvOuXqnZTxD8+/hwGb0ealTR86Ka9mJgJd7g8LWdmuo2AoI2nyWDGIUEiKJHg3/I8QxaX8dfmjb7DWMFCymcgGiYk5H1RjvBdASQ==
X-YMail-OSG: cPypzh0VM1kMwv2Q4BIswcIGJhfwCxn6Shchaipebl27u6A.Af9a.DcAPg.WJrD
 x4Mz4rM1uoYhq.KY1SUqgiK294YKKfYi6aryGPPTFnSOr37TyBqlKY7u1FkN0Y.vaaeCyTEmm7RK
 8l5PE4XqSdr.X9U6WSo7EnS00zXHrVhRJV.Tx75QjBjcaJ6gXd8qCHykL7.2z8yglQRfaLuHIAGA
 ZNnc4kXiDHc0VGaanVuuBV99VobFladV69iDURM6dNkJPdt_Hnhq971uG4tqIq6DboY60AvyTozd
 ibQAeJs8gmKeeTpBoCXBhR0QiuBBaO6Ai3QHEsh8D19.ZXGnQjb7LZ5SkoPg1abzHr76V6XHuqEA
 mvVlRmXLPWkWlblSIkTWBgRxzNd8WxJYyuk10fqfrqhEor_W29XeBGreHZB9Hw25VLccYjnTRrJ8
 1OBKtYb1pRgMWfhWTGCVzH1qZ_Nm9fd7b77YIrUTFbOuQbECV0MF2uHtg9bnD4EdxJ8ODOKQzXmr
 nrz.hAMCyoR9.T63WVNkpdQ3sEcV3hVu4m7aZAH_itrJjjCwuqEyRQMXTMrvyuIYLut4Ys816QDN
 RCZdv5nRrR8s62vZNJm9aYVhOus6fNn24oRIgYotcFZvvBfXOKEUKCfbb6BjBtJbGzVwqAAdppdS
 qUQ3EbEEKucDjJRO5CHNo.3f8vfRMjHgbuucKCsf4KF_uRGEDikScMauo9_p4ZZvkJQ0kbYbkAiV
 LTY0aBWjos3WwgLZ0ORQES7bsKJSffqokJt1V44bEcekOz1qnZr33e6G6zP7717wRt9lf5RJL8xS
 aFJH75VMI39TG4GE.TWwPO0q83ADn3dF6VxuipAGCEOxWJNcuWKSA8kinSS257suWIG58USHt_Tt
 Z6d.V7rMlyDmuXeoNbuJRW5884aqQDLC8SFJ8fqu099ZfKtUnsnIQwU6KWbAHOuLutVybAJ6RJBZ
 iCaEXNK7nMO7a_nIM8IL321QfINSkwQnEVY3BDTcJme9ifKZWPEMUeHxyGmbzM8bdPmeb7o19h13
 EA5av_uoxLMartOAmen5OcgVWBXZ1mUFjYUa_4Lj0h_K5mj2MjsH0wk8guOM1lH6MUbShmNakNQJ
 g0pRXUFHFyRuEgE_lvDFgw_MAk2YXHPqk1kbrseELbeJ1rVqtjCuYNdkii2iWnbMVi3BCiflGbV7
 w49BEkfNuIMr0bi4ggSmVelV8YUeo8GnycuThWpXTcM_1YFQiPXCIJwlZ.fkbE0F.1UmR1R6ViTJ
 B6x7jFouqLuYoBQsUFmwZT2UnpUQKlBUhm4owCQ929q0FV8aprf8HKH75TXY1e1igfluJak6vj17
 FgpycGeK1xd.gMhZO6oD.Cdmm8g6hrH3rbt2nf4cebHhmi3PWSMaCPilMPIg5hXNWTs_fkDpi9AO
 y6BIxhzfytEpTFhqZEqfdKRqndIY9nbJ2G_IOf3_nRiAguq8a.SPEyxA1vDg_BS0JIBryG149d9L
 G6nOmpyZ1yy_.N4CbdPwUgvZkOBLyS17fEjd4vGfakOB6U9cbfQuW27e.8dM4btkBrVOzA3JtJrF
 WXBVjS3N_pUrGNqBrpacNG_u8bpKkbkeHyTLNqSpMeZauR06cBaCjVMT2Q0IRmEqllL5yZLgCKzH
 xxnhAY.3zmizzLQyTJ7X5AhZIr6g8DIrd7NHcMYkEYonccMGqUl0DOMHDS_bv7qFqeUPIlbMCnC0
 xcRJFDrRlHkglk8ynbA7na4ClINraCdIaxlQZH.A9q4tragNyt1r.Xl1bThFnbqV.SSEqVWczUQG
 L5gcR8CLSdHOsgCx4moX97boRoQ5sqqsRgE2MJpAqlHw352JXTIaKb82BA06UMkSUW.oCiyDvpI9
 ZeVpnSEdbVOTUziP2lpblX1HbxV8_2F0w.mA0uBQl7apFVrOEsQIxGKO5yFB_T2wC2AQY50hD.yv
 IehWRTp_ZuX1PxnKThFhZPkndKMHtZuF6jtbMvJs0t1Tt1EdynXxcHpj30ukiHon4XoEX7Dn5ecE
 uCZZQo8DHGULqvoM6fqUC0KUphsJksAV6h0wnCCgIXs1FWK8p6pNTpO8bZ81_BuHtAZh6eTZKmzO
 ralT___MZKfXBekMxkwmVl5_nX9_dlKirFIya7QLqqJdut25B.XFyz.tg02QxEDzyYK6kKNEuQ_x
 J8FMnxJJtlPXMa.VN6vOqN2G5_sdk36zd7fRTDFSi4H89J0dnGKrBEN5YJK1fxTbfd.nznIpi0YV
 fAPmpWK29uk.CaQN4F_8jOhfKCiMhV7P74odyTK3BOiTDiYpZMNND64h8TOYj7jMhnvAfTXtgPnZ
 alnhB75_P8ZyqJ3D9MaedP5afHKJ3R140VSCXAF90J.TK9JxA6K_PNmIyxLzHPvlLtPc6OKMJ_hB
 EOMdxdREKDzaIsF5VkHfUiTwD9voJVZW1M0B3xTqo0KP.iDYwSst2C6J.Z_8vKxpBKWejrT35Oqm
 DnjiNnEVS95a8gWJE4CEAsHokLw0xu9.9V9EenNj.tivumCMgqfMUPJ636f3gkjgAPmk98n5M.ua
 jfzXHF0iqp.t4ofq5pZmC_KeX7sbyyT35T9TjbY8NATMATTDU6cd5_.S4zjnPMo43eHkzgqdWzoa
 ZTkosvZBlpSkphV85dNzTWWFgEknX4LxwkIX1z.J_bCuGCR1JQDdPlA4D7.txzjPXbpYKBzD.JDA
 DwiVDKBbn2yTKSceYA9G8MK8ZxWbuNVaUHvIz8ifMC9KXdp6xwIwJzRWdibAIT2UlV3wTB112dvu
 LNJ_5ujqKyV2XXt6BtQIxnYOC2tBUphLOtjQByV.YuerFhDMzaXVEx.gjSZzu8xcQxVV44mIhsaS
 llYDdFU23ZsOTW.jMScmIq785tWfY3mmzkpLJHX4F5mwghNMYajtBMjrd6j0Ur_g5BiSkiLZopS8
 g7sdRxILm26sj84ClbjAZyPqZ.ieVOC0WGTDLuG9CjHmThjrTngkoCRzv.0_i9GrrVliKxCdEG66
 mwoSUFWYMVMIqe.3ByGHgIFns6NPSQq_znXT8f32_uLhVZQnrQ_KzySATQjWQ6JdKW5BZ7addHb2
 1IAsvzcrts2hpujDumdU1DYPzfkE6JTeJwsMXEe3D2bxClHKK7XjGAA2oMcuzZJQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 2 Feb 2021 18:06:38 +0000
Received: by smtp415.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2e19b6b38051dbf5ab33afec7d37668e;
          Tue, 02 Feb 2021 18:06:31 +0000 (UTC)
Subject: Re: [PATCH v24 00/25] LSM: Module stacking for AppArmor
To:     Topi Miettinen <toiwoton@gmail.com>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210126164108.1958-1-casey.ref@schaufler-ca.com>
 <20210126164108.1958-1-casey@schaufler-ca.com>
 <31ba0fe7-afdf-8f7d-e7a7-8f15d8c690a4@gmail.com>
 <c810406d-2197-9529-a8cb-2f289e9c248c@schaufler-ca.com>
 <c5c40a66-b36d-73ab-6c92-f4d1f5f4ad35@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3ac446c9-1af7-04dd-561d-6ec1dbb146b9@schaufler-ca.com>
Date:   Tue, 2 Feb 2021 10:06:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <c5c40a66-b36d-73ab-6c92-f4d1f5f4ad35@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17648 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/2/2021 9:12 AM, Topi Miettinen wrote:
> On 2.2.2021 17.30, Casey Schaufler wrote:
>> On 2/2/2021 4:05 AM, Topi Miettinen wrote:
>>> On 26.1.2021 18.40, Casey Schaufler wrote:
>>>> This patchset provides the changes required for
>>>> the AppArmor security module to stack safely with any other.
>>>
>>> In my test, when kernel command line has apparmor before selinux in l=
sm=3D entry, the boot is not successful with enforcing=3D1:
>>> systemd[1]: Failed to compute init label, ignoring.
>>> systemd[1]: Failed to set SELinux security context system_u:object_r:=
cgroup_t:s0 for /sys/fs/cgroup: Invalid argument
>>> systemd[1]: Failed to set SELinux security context system_u:object_r:=
pstore_t:s0 for /sys/fs/pstore: Invalid argument
>>> systemd[1]: Failed to set SELinux security context system_u:object_r:=
sysfs_t:s0 for /sys/firmware/efi/efivars: Invalid argument
>>> ...
>>> Failed to drop capability bounding set of usermode helpers: Operation=
 not permitted
>>> Failed to drop capability bounding set of usermode helpers.
>>> systemd[1]: Freezing execution.
>>
>> Systemd has extensive support for SELinux. That's good.
>> It doesn't have an understanding of what needs to be done
>> if SELinux is active but not the default security module
>> for interfaces including SO_PEERSEC and /proc/*/attr/*.
>> That's going to take some work.
>
> Ok. What will be the replacement for SO_PEERSEC? Systemd calls getsocko=
pt(fd, SOL_SOCKET, SO_PEERSEC, s, &n).

Dealing with SO_PEERSEC has been discussed at length, and I
wouldn't say that anyone is really happy with the conclusions.
The patch set presented uses the interface_lsm to determine
which module's data is presented in SO_PEERSEC. The interface_lsm
is controlled by writing the desired security module name to
/proc/self/attr/interface_lsm. The addition of SO_PEERCONTEXT,
which would contain all active security module data, has been
proposed as a follow-on but is not included in this patch set.

>
> Is the /proc part something that should be fixed on systemd side, or ca=
n perhaps the SELinux libraries hide this from applications?

It's unfortunate that the early days of the LSM where dominated
by the mindset that security had to be a complete solution. I
was in that camp myself for a good long time, but came to
recognize that attempting to solve all security problems for
everyone using one mechanism was destined to excess. Because
user-space development has assumed a single LSM for so long it's
hard to imagine that there won't need to be changes in both the
libraries and the programs. Because SELinux has the longest
history and most complete distribution integration it will also
have the most trouble with sharing the LSM stack.=20

>
>>
>>>
>>> Probably SELinux libraries can't find or set the labels for the PID1 =
or any file systems. Before the init label message, systemd calls getcon_=
raw(), getfilecon_raw(), string_to_security_class() and security_compute_=
create_raw(), so one of these don't understand the LSM stacking.
>>
>> That is correct.
>>
>>>
>>> Also the policy needs updating to handle process2:setdisplay:
>>> SELinux:=C2=A0 Permission setdisplay in class process2 not defined in=
 policy.
>>> SELinux: the above unknown classes and permissions will be denied
>>>
>>> With enforcing=3D0, many services start, but for example systemd-jour=
nald doesn't. This is probably related to the earlier problem with labels=
 (maybe libraries try to use SELinux labels where kernel wants AppArmor p=
rofiles):
>>> systemd[1]: Failed to set SELinux security context system_u:object_r:=
init_runtime_t:s0 for /run/systemd/units/invocation:systemd-user-sessions=
=2Eservice: Invalid argument
>>
>> This is also an artifact of systemd seeing AppArmor information
>> instead of SELinux contexts.
>
> Will SELinux libraries choose automatically the correct way to set labe=
ls in the future?

I expect so eventually. The SELinux developers have not been
especially enthusiastic about the prospect of module stacking.
Once it is available I expect to see some accommodation, but
not necessarily to the level you might like. The patch set here
is strongly influenced by the assumption that putting the most
highly integrated module first (SELinux on Fedora, AppArmor on
Ubuntu, Smack on Tizen, ...) is going to get you most of what
you need. Whoever wants to add Smack to Ubuntu is going to have
some work to do.

Stacking AppArmor with SELinux is a real use case in the container
world, but that's not the real focus of this effort. I have seen
several cases where security features have not been implemented
because they couldn't be added to a system that also required
SELinux, AppArmor or Smack. I have seen many proposals for changes
to existing security modules that where outside their scope just
because there was no other way.

>
>>>
>>> Switching the order so that apparmor is after selinux, boot is succes=
sful. Loading AppArmor profiles needs a permission from SELinux:
>>>
>>> Feb 02 08:53:15 audit[963]: AVC avc:=C2=A0 denied=C2=A0 { mac_admin }=
 for=C2=A0 pid=3D963 comm=3D"apparmor_parser" capability=3D33 scontext=3D=
system_u:system_r:initrc_t:s0 tcontext=3Dsystem_u:system_r:initrc_t:s0 tc=
lass=3Dcapability2 permissive=3D0
>>> Feb 02 08:53:15 audit[963]: AVC apparmor=3D"STATUS" operation=3D"prof=
ile_replace" info=3D"not policy admin" error=3D-13 profile=3D"unconfined"=
 pid=3D963 comm=3D"apparmor_parser"
>>> Feb 02 08:53:15 audit: AUDIT1420 subj_selinux=3Dsystem_u:system_r:ini=
trc_t:s0 subj_apparmor=3D=3Dunconfined
>>> Feb 02 08:53:15 audit[963]: SYSCALL arch=3Dc000003e syscall=3D1 succe=
ss=3Dno exit=3D-13 a0=3D7 a1=3D7a8f2ff04f80 a2=3D1e09 a3=3D0 items=3D0 pp=
id=3D961 pid=3D963 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fs=
uid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D=
"apparmor_parser" exe=3D"/usr/sbin/apparmor_parser" subj=3D? key=3D(null)=

>>> Feb 02 08:53:15 audit: PROCTITLE proctitle=3D2F7362696E2F61707061726D=
6F725F706172736572002D2D77726974652D6361636865002D2D7265706C616365002D2D0=
02F6574632F61707061726D6F722E64
>>> Feb 02 08:53:15 apparmor.systemd[963]: /sbin/apparmor_parser: Unable =
to replace "/lib/systemd/systemd-resolved".=C2=A0 Permission denied; atte=
mpted to load a profile while confined?
>>>
>>> This just seems to need TE rules for the apparmor_parser.
>>>
>>> Double equal sign in subj_apparmor=3D=3Dunconfined looks odd, should =
that be just one like subj_selinux?
>>
>> The audit code is reporting what AppArmor provides.
>> I agree that this looks odd.
>>
>>>
>>>
>>> Tools like ps, and KDE and Gnome System Monitors only show SELinux co=
ntext, but it would be nice if MAC contexts for all enabled LSMs were sho=
wn.
>>
>> I agree. How this should be done has been a topic of
>> lively debate for some time.
>>
>>>
>>> -Topi
>>
>> Thank you for this report. Which distribution are you using?
>> I have been testing with Fedora (SELinux + AppArmor) and Ubuntu
>> (AppArmor + Smack). I would be very interested to see how a
>> distribution that doesn't use systemd behaves.
>
> This is Debian with systemd, I'm using SELinux + TOMOYO + AppArmor.

Great to hear. Thanks again.


