Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CE0C433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 21:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B79464DA1
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 21:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbhBHVjq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Feb 2021 16:39:46 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:44888
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235075AbhBHVjP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Feb 2021 16:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1612820307; bh=Q7zZkn6P0wWWWJWZ46SUkSjWemyqunuQ3tz5FK+Cyys=; h=Subject:To:References:From:Cc:Date:In-Reply-To:From:Subject:Reply-To; b=Vu0wt+Vwp2h9k+3MGsbqaUjlLiX4nKztfQiWZEgvNVDnPjbEYlu488oVez6lcCpqmDSCfnY+o6xvqQjyRYCdaM66urpaiK2Jrn8Ck/wISHZs2kiIRBK/QtIpmmJx7lvsYAR3wzuNNegzEo2nTSA5b9yml1qwD0TtY3cswtbXFJWa/gjAnxkRFAumaMYMgcjS/pGE3Ho92Tq6DAYV/kOU3TRQ41dB52kj3yhFNnAojS+MaJBeuv59lqLQQK4YamDAWLCuzXXjmY0UcvuJ58hddvP9VzWONjcHwP623hNZWC1AOadlpdTQ31SeQ6M+57SnxwtZabIqKa11nWkwRFzAFw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1612820307; bh=a+DE9wAJnB4SrmVJaynqUpPXJiSuYecZNmBd+bG2OOu=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=jDOqHo2OaW9zWT2QFC50CpxMCJqGo4+qUkXDbaaqtdwfMJIEqF3JwRObQnAl0InuAIgIVOnEKg3SAwOUQdhOUhGu9vMezdXPeBcKcGOINm+YgYcVIg5OuiLrxsYIR/1yIjVGWFpAfQsgBiQNC/Jsf1w3KiObv/vNTwo5ZOnlVD0UBBaGxqd9yK5A5LlZ4xrA49HfOU5SWFrSOQy914wQkXA2pWsUKrfFISiGHr9r3TEw66cTSS8lxZ+R+nkQSCujBQPoUmKLCaUW6j/fcUVO5ap6KmNalOKZePRQNsxku9U7c0p+MBpAyY50XM8NwPQGydw8vhVJ5VIf6VJUI5ZHOg==
X-YMail-OSG: O7By5VcVM1mIIK1AqKzZdONcvRzVh9BKiM9OHrwYGxkv1fYA.OhKYif_jW4NPJU
 4p8rdmawZJKL2vkR90rb6HjYflXTrmmiRZpBzskwGdFTj1xRDWkHNWIeg.Wh_dWzCAAtt6vTIP.0
 9lcD6YqffDWcLD7p24kfkIoRgaCj4pq4jy2g_Sevsgu_wGRNGwo_iC2dJYvqleJ53JdRdcEJLKsz
 uOZ2aFetX_QLYCImMuQYO2DjacC1PG5MVhtXv4fD6vHpCCw2asnv5U8ZF_D90y3cqWeJTlPYn.gm
 LsVr09dc7T3UIiGlSN82NIuodFGKamRrXMmxJYXdPakQ2t5NXVkfJU16Yd8rKK2B0fe_NC5KZdjP
 pYmgH1LRrVRiOPJXZDXyQ_QsWauQeYyPJt12.fFk0tqpUZwvne_.wXhMAy6xURZEHxr0qLpExtsX
 xOwGV5F4jR08gjO2I83ioyxULwDdsj1xIrF7Dqw.bxf4KBP2FWb6egvZJ3bsUuXRi0WXRqiVs4qY
 vLtDg_0sOnuO.imAKR4svI3IJSKj4SJ2zmplC3AxIjZ.N3q9Hg_W0mm3BLgnLFyLu_nztwbVfa74
 MnK0_cAbhU_njkmIl_IdfXGrY6MTaJRTGw_GuK_EfEo_Hc9_UygDVFrmwNllaZg.XI3yZwMXWrR1
 uoZMjMzeIrW1iCcf.EZaIFJbaVBxVX0UOjIm7700zU916JJBVcTKeUzSfuysblaBZ7nud26x3OjP
 doUgwzOZ33fDBBBbB6k00MwgMIP8MBh1w3g7DE1knTb5BqEvDOSKPNobBjhS5b0igR_H9evL_hdK
 9u0GJySTUSyDlXHNlEBxT7Qosxg6gqRjpluc_04IyzSmk9P9Y8Xr1b1Ujrobcfcu0zJk9VznxI18
 QoBlhCaVBVhDLQ3gOFHJT_COahWmvDkdCoPyTILdHovY7R.Zm3Yinx_EnKh.JzzqVeVSRL9MSw9i
 jEnwXJB0CggmMMmmrJKnZMd9Unj1Dj6apYvdk.dJgM_tWsdT1V0KGh5Mp8epkg4hf6F3Z.UvxpeJ
 mZQBCElivPJwm8XcNbNG8FQx.P_AMofX91KYRDPK2xJIjWqfskYjbBTCkzu.bKrOVmyBFVNlSrQx
 8.aJjnbRx61iMt4EoygcfaQJOZBMC3hlGbsuvCBywTkKvRM2XXnVgrgP5R0Jqyd5lTmYhDRNpk.f
 hxNwBQC9s4SgvZYjR1pBmXFBXnWn79ARW_uHASLz1rGawO6R8b6H3BRO8Dz4M0X46XKwP61EBywo
 84PLSOYpfFky7QFwIMhm01RAR_Kisc1gDiwWszgiSkf8s0uGacII9vi79YM6W2wrP7JgW4MheNx7
 c2uy3wjenbC0GToiUCLrbGyZpxndPpUGg2Fp7Uc7tdZwaeHaEg4Buk8rqv0n9ECFYXyaFJDYA1uP
 bRQWJCbCS8xjEJdxODvLXCTzfoflebBFJiUDJef2Ef_61LXZ5tKDSGZ2BLO6QG2pitsllHAwdUZ8
 pp2UlFQ8bHat1FhTpSA5UN16cKE0MsabjjtfvRS7Y9ZL9T_5nmieyrO.EnDN9bENXbSgUpyJcyqj
 r6dKQpX_thsx1nVsbho2weRwtyYLx40gX81EvNx69aBvi1Hx28kfocfiacmpPVPTLAZt1Uy.7MUi
 TZz7qn3ROaSI5QL._c3ajuioG14p6B_V41daDih__fro1C2blkJCxu.Qn.GgHt4qf2wpswlPgkD1
 qZT9RTYT2vfEjTHoFUY8i0PKgS.CcsRXHM4q6Ad5MmuUBEwJCNa7EFolgkCZCNlNKGbL5hNhg18n
 IAZwDTSDeZry5lvsJhLLt9dMypwTryeYr4jQt5YWJdChrj5Cx_s7CtDkZYSg9GsxbEg5rVWgY9c5
 Oo0V7PWvIC91CI9nbdyXDGerUiEYIDvzbo4T3KkbIsHPWcCHj.942hs0XjH49vF5WNBgnMgAPxIi
 yqpkYjgYtSlxrcE1i5GUITUcE_JbFKGBjy.nkxnYiIf8DrGdGv9_TrbpNFbp3z2NVhZaDE6sRPte
 Admxiof3iBsR74.5SDNd5OLg.h56uNg7gcKXEwdwFPvBD8izxFzUcIgWzE3IgIln0W4YRN4hvFre
 fxqG5_g2W4H9pWFq7.2zrdNDK.X.zu2HK_.YsS6j23z5GhteuhpTYzYX1f1qb.MixBrjT2waiqDp
 .SdqiBPTvNd9p4sceI0Z.XMpbuFqnSDxLgkdETdi9GSJwcf0CF5pJ04l_NBZkRY6tphOQJQAaFFf
 V0djnWPVrf82h.k0za04e9UQO.5xpgH4RZ2a_c7yXE5GffeDUfyUlHFpz0Ow_t_huqiW6mPhSlMo
 LMxtPMGhGq80LH1sjcFbfAJFOhJgqm2X6v9zvmrPn3ZHJYbtIdyjAxGfr39esQ7MVUyd5nICjMro
 swTu_.zPhEXBLN4Ay_RxXqvyiiuCMrqA3.N14QaYeqAcvING7LB5jn1lfJTtn2b4ZXYsf0997V5D
 _bly8igYsjuPvJ3DgshsSCO3U_BPEaB_DT3BPgV.R_C3YdheAq7D8U3JIywtpN5HcY2M4kCpXmG6
 0Aev9dRvFy6koXKzmAgl_auvOT2yl5sFHkuZlS8nNjGFsa2c.84PVkbrUDMyzq22lblzcgprLpco
 I
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 8 Feb 2021 21:38:27 +0000
Received: by smtp403.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0d78ea132eeb99c17ba4c5e60bf9fdeb;
          Mon, 08 Feb 2021 21:38:23 +0000 (UTC)
Subject: Re: Recommended value in CONFIG_LSM option on SELinux system?
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        linux-security-module@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>
References: <CAJfZ7=nKqT7mmE73r1K3YjBak=OmPACmDi5ccX=SzKhT9=vJ-g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <30320add-03dd-202c-caf4-bf947a7c2bdf@schaufler-ca.com>
Date:   Mon, 8 Feb 2021 13:38:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=nKqT7mmE73r1K3YjBak=OmPACmDi5ccX=SzKhT9=vJ-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17648 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/8/2021 12:35 PM, Nicolas Iooss wrote:
> Hello,
>
> Recently there was a bug in Arch Linux where SELinux was no longer
> enabled after booting [1], because the default kernel configuration
> changed recently [2]:
>
> -CONFIG_LSM=3D"lockdown,yama"
> +CONFIG_LSM=3D"lockdown,yama,bpf"

Neither of these settings will enable SELinux by default.

> By doing so, setting "security=3Dselinux" on the kernel command line
> seemed to break the system, because reading /proc/$PID/attr/current
> resulted in "Invalid argument" errors.

Is this in addition to an "lsm=3D" specification on the command line?

> Replacing "security=3Dselinux"
> with "lsm=3Dselinux,lockdown,yama,bpf" fixed the issue and everything i=
s
> now fine, but now I am wondering: how should CONFIG_LSM (and option
> "lsm" on the kernel command line) be set, on a system which is using
> SELinux?

CONFIG_SECURITY_SELINUX=3Dy
CONFIG_DEFAULT_SECURITY_SELINUX=3Dy
CONFIG_LSM=3D"lockdown,yama,selinux"

> Such information is lacking from the documentation [3] [4]. Therefore
> I took a look at Fedora [5] and RHEL [6]:
>
> * Fedora uses CONFIG_LSM=3D"yama,loadpin,safesetid,integrity,selinux,sm=
ack,tomoyo,apparmor",
> which was the default value until Linux 5.4 [7].
> * RHEL uses CONFIG_LSM=3D"yama,integrity,selinux".
>
> It seems to be strange to have an "outdated" configuration value in
> the configuration file, but this could be fine if the new modules are
> not expected to be used without the kernel being booted with a
> "lsm=3D..." option.

Keeping the "outdated" configuration values is necessary for
compatibility. We never intended that specifying either of
security=3D or lsm=3D on the boot line be required. Because there
is no way to maintain the old behavior of security=3Dselinux
while allowing security=3Dlockdown,yama,selinux we had to introduce
lsm=3D.=20

> But there is something that I did not understand: setting
> "lsm=3Dselinux,lockdown,yama,bpf" worked, /sys/kernel/security/lsm
> showed "capability,selinux,lockdown,yama,bpf", but this violated what
> the documentation stated [3]:
> "A list of the active security modules can be found by reading
> /sys/kernel/security/lsm. This is a comma separated list, and will
> always include the capability module. The list reflects the order in
> which checks are made. The capability module will always be first,
> followed by any =E2=80=9Cminor=E2=80=9D modules (e.g. Yama) and then th=
e one =E2=80=9Cmajor=E2=80=9D
> module (e.g. SELinux) if there is one configured."
>
> Is "lsm=3Dselinux,lockdown,yama,bpf" really problematic?

The documentation is out of date regarding the "major" module
having to be last. That was true before the lsm=3D option was introduced.=


>
> TL;DR: It would be very helpful if there were some clear guidelines
> which were documented in the kernel documentation about how to
> configure CONFIG_LSM on SELinux systems.

Thanks for the feedback. We are at a mid-point in the development of
module stacking. It's not too late to make things better based on your
experience.

>
> Thanks,
> Nicolas
>
> [1] https://github.com/archlinuxhardened/selinux/issues/81
> [2] https://github.com/archlinux/svntogit-packages/commit/69cb8c2d28841=
81e799e67b09d67fcf7944d8408
> [3] https://www.kernel.org/doc/html/v5.11-rc7/admin-guide/LSM/index.htm=
l
> [4] https://www.kernel.org/doc/html/v5.11-rc7/admin-guide/LSM/SELinux.h=
tml
> [5] https://src.fedoraproject.org/rpms/kernel/blob/dd9f5d552f96c5171a0f=
04170dbca7e74e8d13c7/f/kernel-x86_64-fedora.config#_3232
> [6] https://src.fedoraproject.org/rpms/kernel/blob/dd9f5d552f96c5171a0f=
04170dbca7e74e8d13c7/f/kernel-x86_64-rhel.config#_2834
> [7] commit https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/commit/?id=3D000d388ed3bbed745f366ce71b2bb7c2ee70f449
>

