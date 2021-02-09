Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E4BC433E0
	for <selinux@archiver.kernel.org>; Tue,  9 Feb 2021 16:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C18A64EAA
	for <selinux@archiver.kernel.org>; Tue,  9 Feb 2021 16:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhBIQIb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Feb 2021 11:08:31 -0500
Received: from sonic313-14.consmr.mail.ne1.yahoo.com ([66.163.185.37]:46656
        "EHLO sonic313-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232608AbhBIQI2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Feb 2021 11:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1612886861; bh=Sp1a+O4VbFCknadD6VmiosXTXuw21sBt02urpRN3Z5o=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject:Reply-To; b=CrtKw5NNZDlPyUgedWJV+Ad08uzjWiKKNNu4J2J59OsyxNQ9gnWycUciMHTeDC55Aq6iE1A1DKIBvEiPrLW7O1T+vMfpf9xlKQ0lRyQywN0aX13UHNEOZMQFKPPAj/qqFerOb4VbXQGfOxXDnNKsmAybFR1CBE6Ql+WPJUZMtg9whPN9awgMl25W91a/1fOo+ZVX+RaqceDI+d7ahV3r6hpVBq0FmVetr6fZAYl2TO5smxsXMitCkQfHqACGDmcz+/XSDdi/cNRPx29nm0C52ULz698iGZwQM85IPPLljgoHrC8N8/LHN8lRNNvAPlUG9OvTGA4/fcjUtCOQXMYhGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1612886861; bh=SGLM4FVKAebZ56DAe35Jqg5dgQktFuTzHokVKhLJomi=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=EhIIJIcpahqE0+HqyzDpgLOoc16HN3hZw01cCi97w04Yh/pXtIxEQUzktF0lZXVLzglFJ9gwP0iiRs7T8+/7kVsCYfrGzhh8TQaJmCYoakiKxXHGTCusYv9WZ70K/J4GntJ05UIPpgwxorHzZb69MJWmR52jjnt+Y5/3XHIyrWM9P8Swmg2GwpepUi/SOWAuzhXJGwBCtZd6G6TYK4WPDGHhBm5KURHagZKPXMUsczW7TgCwaneIgLeCd89fhCLHhZVPUWjVPUF8loB8/QYeoALbElIEbFje0ejs5GvzJMy5sUghF22+G/X2CjUoLes1wOFhRPCaGHpX5wztgffZiA==
X-YMail-OSG: bqa.bI8VM1lcTgl2cjWt8ms8cDpqZHtDw_nT1lwE.8Cc6xEgR9w7joCjzb166zr
 Pe7PgjX6jmdA9xA.mgq9o0jKK7OI.HgOFQfWq5rpblMpchl1ywGpoTASXcos4.RFQs.3htj.7IaQ
 XnnynziR350oJayqKM8pNvmjF_9PBjgCzLvAzKRF1dvKjpHv0GnTH7Leins0aKIdQhwx6LHRxwab
 sL53bCMluJaoLKMqxF5u9dWAAMYzN3zp0Q7ztUy2oKRyX1_v_pOsqMM25_pWOxQwrCDBR97yloGr
 rjbC66dpDHSk5zsK.cADKNPVAPl9T4LBZSLnDKDfyQjORsnNq2gVvzr3L9ZEMhwqsC2_9YMIFwnz
 7teeCIf_gT7ZI_plefZUon7YkRyj6Z9M1xBWY37NwlxNkKj6ADSHzu4kjp9ZyXZlZHyAoWocmVa0
 XdCqsh7MbHOqlf5I2DRxnIXlZkEQtZE6Yi1JmNAndV5_ISDFfxaU5PuGXbuViWb2eVJXR49aekHf
 bReVV0VaiaDd.yV7ECFg23K_uYi0AQrNU24ZVDR6Avqc1KuJ_aQHj4U266IPRj_by6otCnavRYgW
 S4ERdPRJHS3HNeU.0EH2oU_FY1dO1lm.1tWjBPAhpIOZJih0C_AVGOnr0nDcKbcAvkHqbEhPcn_E
 lho6.uj7d6HpAj7pnWumwC0jDh5W3Ge3yOIb6LrOum_J02YRPGJqvi3elxcb1hfRG7uJsrWIYT.J
 UBpdD7AFbse9DHxop8fPHUtCANS8kEySglLionw9EHg5dki9pRm8gwZ2d6zbwD0CrHVLaUHQY.u9
 XjnVRV7CucVuMCPb3NhomdYEFBi514kgilThoqy81qZIKK4i.znwELS2OixZv59cjjv7H8h9lXGm
 hDOa3jmVopU8JCDDGkSxuLQpi2p41YO7MLivWScTH9oIyYqGQWeEOGp87VhDrf68ScR40_EYRoZ0
 5Lh05eob.ZO42uhuo7wuNHhzIJGWatMQv2WJcasjDxD94jw9bArC_ZISIWIQjJmlLKipBVcElZt0
 GdyPr3KVW.l_ddUSH9ZLuVRl.ZG5rNhaerz4eNdnH_PHmhCGr6enwh3tOzrnBoYoM.kOxQZiFq6l
 Ha21zDoTNVjW2fXlcfF2wNsq0MuMEhAcJIZGYfq0uxCPPT2_V7Yyi.GjDtDip_6fAMDckevQawHi
 Wor_uGNFXF9wyvyw9FrD5QUqYJlenVKSeQlWF7.FgtYW7GNDnPryxOyA195FquaUChfTqcYu5fx7
 uS3M1SC5EPipBy82Y3YnFuDsrugDdkuTnF1OOGBh9oxNySe0b23YgEPJQXrTdt2S0VSbH7fpFh0.
 xsvPFVY0IldUXs41nCY.JEqm3pe9TleRlO_IDHuXf8B4vY1aa.bvgKLYUBYqEUAxOMqv9Zk6sFLe
 xRGAhQhT33MXpoOdv.xvkmcNa8TBHA6rFW7Mn7.kIClm4A05f45Ckb3yYIl216yyqODPmfUCG96S
 3VqGB8IkOZ7wNz6TwliT7mqmlp.Y9Onff82Oi.3NanpfhpcjFll819e2eM3bI4BOtvx7hDOx5ovM
 haAbbO7nGYIiYMRTeohNM2c7v5Qu4ZQUmiahawQ.pTE7Z8DBlh_PHL2BX.jf9XlxuHHsJvJwiwfr
 .k05_gc3S3a68ckf9IJpTx98Mmo6KY5bTy4iF6oLRypzkkXg9cn3Dyx.9NfZRvRYYlTlWNDoYsFJ
 mHPL.D3d5aS_uq8MHGvhwGJkIQYkMsggYHTeHfamLPh1rgCnsLBnQJrRirOwHjYg_O8YG4wGC0sS
 5gyugAYXr7JflLt8ZVOjqThT9eb28bBiBTNvCUnTot07Cul8VTSkdOJQoUFBRljnVIbrpHD88NNt
 v_MXIAPMfpOxBt.YlmlfetBtkUQxWRX5ueEA7f7krrjNq7YhLH.sSXiZ2USTVYTyMxLz8Omiud0H
 8EQWjtOfeNQlklbFM5MTS_fQ517tby5XzXXvPQhf7XZOl0wzoN3vw1NQ4J9rnC9Tci_IGYzZaDKP
 qjUQsHRsiQ3knLOhYKtn2PtPJw_N.nM5epWfoyxtpmj93jV1o7QssLKR0GDmwvavQdagFg719otZ
 3inkK1p1K5oT241OX_tzqEZiqXiP.bNsGhl6CxFVaehS5zI2qK3FZ.BgEpztNnCd4Adrs446VqyE
 q2DBsrAN.8QCvd3AITy.U5kcivPgHUrucJP4qCut68FkHNPyF_ZOiWNFHvuUdn0.KIfww8efGJ9f
 zUoV_2ajdEPN7nRcnxpqXX5v9j20jYik.t.f3Do78w.RT8PAlY6oyH1tDVqbe.Ahv.FIR0NenhgO
 j.58sJP6EgdRXVFMdWw0S1thGRTOs.bK5GGCH8TinDksBV62FYadjAmc5e85VVyHuHJgSSB1aktl
 gsIM2StdzbkdocIwo9A.Vv.vq57aimosrwPsEsT37XAMzfc2EiSwM61qFnqWbqtIkSsu927PiyRl
 c0J8yn5ETd9qyrioaopNv3l0_b6DOe0wf0clTnLyuypDuh9rVRPWa9LM1Wm56nGNPwebynM0xJhD
 zqRVE7.pvcnYl_Gle6WdJPJm2PhUog8tO_xVx0_4awOIa71dTmmLauOo4N9l0SEfp8VI-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Feb 2021 16:07:41 +0000
Received: by smtp408.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 71c451af067f8a130b6daa74d29ed983;
          Tue, 09 Feb 2021 16:07:36 +0000 (UTC)
Subject: Re: Recommended value in CONFIG_LSM option on SELinux system?
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        linux-security-module@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>
References: <CAJfZ7=nKqT7mmE73r1K3YjBak=OmPACmDi5ccX=SzKhT9=vJ-g@mail.gmail.com>
 <30320add-03dd-202c-caf4-bf947a7c2bdf@schaufler-ca.com>
 <CAJfZ7=nWJisw2RRW2AvFgpYKQK_PghudeBqiTQXNfedS2idP-Q@mail.gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d67a9faa-3438-81ba-f91c-69d485c28391@schaufler-ca.com>
Date:   Tue, 9 Feb 2021 08:07:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=nWJisw2RRW2AvFgpYKQK_PghudeBqiTQXNfedS2idP-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/8/2021 10:52 PM, Nicolas Iooss wrote:
> On Mon, Feb 8, 2021 at 10:38 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 2/8/2021 12:35 PM, Nicolas Iooss wrote:
>>> Hello,
>>>
>>> Recently there was a bug in Arch Linux where SELinux was no longer
>>> enabled after booting [1], because the default kernel configuration
>>> changed recently [2]:
>>>
>>> -CONFIG_LSM=3D"lockdown,yama"
>>> +CONFIG_LSM=3D"lockdown,yama,bpf"
>> Neither of these settings will enable SELinux by default.
>>
>>> By doing so, setting "security=3Dselinux" on the kernel command line
>>> seemed to break the system, because reading /proc/$PID/attr/current
>>> resulted in "Invalid argument" errors.
>> Is this in addition to an "lsm=3D" specification on the command line?
> My description of the issue was not very clear, my apologies. Here is
> another tentative.
>
> For some years, Arch Linux developers have been compiling their
> official kernel (https://archlinux.org/packages/core/x86_64/linux/ ;
> https://github.com/archlinux/svntogit-packages/tree/packages/linux/trun=
k)
> with CONFIG_SECURITY_SELINUX=3Dy even though SELinux was disabled by
> default.=20

That would imply you do not have CONFIG_DEFAULT_SECURITY_SELINUX=3Dy
That's completely reasonable.

> In order to use SELinux, users were required to install some
> packages (such as systemd with SELinux support) and to add "selinux=3D1=

> security=3Dselinux" to their kernel command line.=20

Sensible.

> Last week, the
> official Arch Linux kernel was updated to use
> CONFIG_LSM=3D"lockdown,yama,bpf".

This is a list of the modules to be active at boot if
they are available.

>  Booting a system with this kernel and
> "selinux=3D1 security=3Dselinux" was broken (D-Bus refused to start, as=

> well as all network services, because systemd failed to get some
> important SELinux contexts through /proc/$PID/attr/... files).=20

Because selinux isn't in the CONFIG_LSM list it is not
going to available from the command line.

> But
> using "selinux=3D1 lsm=3Dselinux,lockdown,yama,bpf" fixed this issue
> (before, there was no lsm=3D command line).

The security=3D and lsm=3D command line options should not be used
together. The lsm=3D option is the complete security module list.
The security=3D option only changes the "major" module for backward
compatibility.

>
>>> Replacing "security=3Dselinux"
>>> with "lsm=3Dselinux,lockdown,yama,bpf" fixed the issue and everything=
 is
>>> now fine, but now I am wondering: how should CONFIG_LSM (and option
>>> "lsm" on the kernel command line) be set, on a system which is using
>>> SELinux?
>> CONFIG_SECURITY_SELINUX=3Dy
>> CONFIG_DEFAULT_SECURITY_SELINUX=3Dy
>> CONFIG_LSM=3D"lockdown,yama,selinux"
>>
>>> Such information is lacking from the documentation [3] [4]. Therefore=

>>> I took a look at Fedora [5] and RHEL [6]:
>>>
>>> * Fedora uses CONFIG_LSM=3D"yama,loadpin,safesetid,integrity,selinux,=
smack,tomoyo,apparmor",
>>> which was the default value until Linux 5.4 [7].
>>> * RHEL uses CONFIG_LSM=3D"yama,integrity,selinux".
>>>
>>> It seems to be strange to have an "outdated" configuration value in
>>> the configuration file, but this could be fine if the new modules are=

>>> not expected to be used without the kernel being booted with a
>>> "lsm=3D..." option.
>> Keeping the "outdated" configuration values is necessary for
>> compatibility. We never intended that specifying either of
>> security=3D or lsm=3D on the boot line be required. Because there
>> is no way to maintain the old behavior of security=3Dselinux
>> while allowing security=3Dlockdown,yama,selinux we had to introduce
>> lsm=3D.
>>
>>> But there is something that I did not understand: setting
>>> "lsm=3Dselinux,lockdown,yama,bpf" worked, /sys/kernel/security/lsm
>>> showed "capability,selinux,lockdown,yama,bpf", but this violated what=

>>> the documentation stated [3]:
>>> "A list of the active security modules can be found by reading
>>> /sys/kernel/security/lsm. This is a comma separated list, and will
>>> always include the capability module. The list reflects the order in
>>> which checks are made. The capability module will always be first,
>>> followed by any =E2=80=9Cminor=E2=80=9D modules (e.g. Yama) and then =
the one =E2=80=9Cmajor=E2=80=9D
>>> module (e.g. SELinux) if there is one configured."
>>>
>>> Is "lsm=3Dselinux,lockdown,yama,bpf" really problematic?
>> The documentation is out of date regarding the "major" module
>> having to be last. That was true before the lsm=3D option was introduc=
ed.
>>
>>> TL;DR: It would be very helpful if there were some clear guidelines
>>> which were documented in the kernel documentation about how to
>>> configure CONFIG_LSM on SELinux systems.
>> Thanks for the feedback. We are at a mid-point in the development of
>> module stacking. It's not too late to make things better based on your=

>> experience.
> Thanks for your quick reply! Anyway it seems that my issue was caused
> by an incompatibility between selinux and bpf LSM. On my test system
> (running Linux 5.10.11):
>
> * Using "lsm=3Dselinux,lockdown,yama,bpf" works (SELinux is functional,=

> the system boots fine)
> * Using "lsm=3Dlockdown,yama,selinux,bpf" works too
> * Using "lsm=3Dlockdown,yama,bpf,selinux" does not work
> (/proc/$PID/attr/current raises "Invalid argument")

You can't (currently) use SELinux and BPF at the same time.
This is because the infrastructure does not support multiple
secid<->secctx translation hooks. You get the first one in the
list. BPF provides all hooks, so the SELinux hooks aren't
reached and the secid to secctx translation fails in the
"bpf,selinux" case. The "selinux,bpf" case appears to work,
but the BPF hook for security_secid_to_secctx() will never get
called. This may be acceptable for your use case. Patches to
allow for multiple callers of these hooks are under review.

> So it is important that "selinux" comes before "bpf" in CONFIG_LSM
> (and "lsm" parameter). This fact seems to be known, as "bpf" was added
> last in the default values of CONFIG_LSM options
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/security/Kconfig?h=3Dv5.11-rc7#n280).
> Is this documented somewhere? It is neither in
> https://www.kernel.org/doc/html/v5.11-rc7/bpf/bpf_lsm.html nor
> https://www.kernel.org/doc/html/v5.11-rc7/admin-guide/LSM/index.html.



>
> Nicolas
>
>>> Thanks,
>>> Nicolas
>>>
>>> [1] https://github.com/archlinuxhardened/selinux/issues/81
>>> [2] https://github.com/archlinux/svntogit-packages/commit/69cb8c2d288=
4181e799e67b09d67fcf7944d8408
>>> [3] https://www.kernel.org/doc/html/v5.11-rc7/admin-guide/LSM/index.h=
tml
>>> [4] https://www.kernel.org/doc/html/v5.11-rc7/admin-guide/LSM/SELinux=
=2Ehtml
>>> [5] https://src.fedoraproject.org/rpms/kernel/blob/dd9f5d552f96c5171a=
0f04170dbca7e74e8d13c7/f/kernel-x86_64-fedora.config#_3232
>>> [6] https://src.fedoraproject.org/rpms/kernel/blob/dd9f5d552f96c5171a=
0f04170dbca7e74e8d13c7/f/kernel-x86_64-rhel.config#_2834
>>> [7] commit https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux.git/commit/?id=3D000d388ed3bbed745f366ce71b2bb7c2ee70f449
>>>

