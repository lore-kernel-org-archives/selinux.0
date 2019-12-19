Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAD0C43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 20:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF4624679
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 20:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OYeobTUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfLSUwG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:52:06 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:36128
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726959AbfLSUwG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 15:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576788723; bh=NKTGQyuiQjRuma7Z/GXX4iK4Yr58PcjucLdjmq6cdJk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=OYeobTUZrWpc/tylVE8A0zdwcFFAJ3b6zmJTC4duwDm5lQLc949dymXh+89NxL9et3KhelvQH4mts8uH8crMPBkOvmt3pzGvOy0MCjWjlKohIdLTvWua/YcqClQeW9X0STfXG2F/iOx319ov/U5QQiT3BL37ZHmYBvTbx9Q/H2/65UCeR0Sv0qV/Fg38zhamajEAmT7w8K2Fye+zY19jx8J33eomrFI6e7dBZPpi9G0s3XfIPdtA0YyyMOX1RiOuqIRSoI+O4VYnsRBDeJFF3RZpSDbGX29nZKPjfOd1IpAVceSsqyluJ7jO8z4BYgmnM8U/ky0kUa8cIsEM1FaLMQ==
X-YMail-OSG: DTIbJMMVM1mpFGSKaGAkAMj7hzSwEjcVZqbX9uaoSpyEGUpV74dEoO3vhWzSW0E
 MjTtwhJbgnhrdGnBxToH6KLEAd463B_msjV5.VVwyou9HcCaUt71bP782RSP4_XkPGKTqpUhnWFM
 cYs7ypbFeePCL08odh2c2yRQZXbJvWxwovTom.vx5r2yX5bnXC3n9DugZhwQsjxzKrDvzqRR74Gz
 u3IyZEuHzSmyDtFh293OGgKbvYnnEA67hxyefN0cYO89QeE8L2h7yUVHLPSFN.OGV_PTDZguAHps
 Ra0YWygrSxhbHl5H2KIas8zb5wEUQ_Q_GOR5uvfw9y_7.dJJ4j5XOj_ea.9CgujT6vJhoaiNZt0v
 zRsrbr2fq1HoYJPCz.y2yzfmmFxnQFM_L7R7IDWeS5IYeZd48GzLUU0qG5RohVdH_q.VljJPign8
 D9yKqslrivM7_RrmlDp7BKO2TR4DAm8P.djt.z87gKkZyTsqxblyAZeMFiV5uhJe.bH_MyHDwmI6
 9krwxzAbEEHRjxxRxu_XNyY_zVUEMF2ystM.5DWg1w_dUYGSBrSwoVD2SNZd.kYjT37uOwXI1PsZ
 2G_NY_XuX8V5OpjM5PelhN822Z3HBXeihQwEfM5s3APNnyBwH495IjGFKzW4S1gfZF8ixTPdVzSY
 pzuJVQE8Ia_rZQ1O5lL3B2KTKerwsZVs1QmJz1f99muxNEuCN5bePzgxzMmWICRMFfApO7pVpeeM
 gGumoddQYdhEhPgOEYh9eloU9hZpRIEsco534L5zqB7Twn06Cfl2atBbuA26n6Xh5R9xA8Vm_AK1
 9t3Rj9ULA9oYZgO7j_a9QKHw.VpL.qY4Z1fzmVss9_qbgmuY6qw1rHkIxlFJJYbPQsW7A6mv8F0m
 47AogHyc6KlVCuw_XiElC80ayrqLjOaFDNB773bQTRylRMzy8sWu6XE.jHY2WCLN0uv..11e5DP9
 KVeh_3fesJeB_pVBWvDXikE1fS0C7HJxvA9rUAl9HwLY64EFsYWOf.IL832AG5_7qdqnTtlBlRU2
 19LsVJhiiAyoLMiDwWZUOcQBypH.Ae2ZlJM7U00Rtgf9kr93UdgY7gN6gPHjdZNjsCVqTA2CpmlB
 9fYPDJAHARCofpj4xltc5PoeiK8Rel1JR0QsJF3Zv14N.uJck5egffp9ET24yNWQqJ6.hOCfaQBY
 sy6OYM8JVkH_IwmgNc6cubuYhms0.cLHEntM1MzU4scVvUEY2ubjB1WXonnuFYdeSB6flTNtvWLO
 _FXFDjv5vnh0Z.YzzeKRxaIFW.oFv7nxfO3JUw2dO3PBMPmXjQ47UvZb4oTSw7Pg3wEeSu6perT9
 .XyGi22JoFEEX4r48EguO7pJiHNuC9NSoHHZFaILcc7SeijSVK0f1wwhXuKgdAJxikOJd6n_S.QP
 XNe7Xx_kcZXjqLm5fjvZPLKiqnxnZ__wXtrc7bw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 19 Dec 2019 20:52:03 +0000
Received: by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ebf999f0b40d143b13beb4d37c89972a;
          Thu, 19 Dec 2019 20:52:01 +0000 (UTC)
Subject: Re: [PATCH v12 23/25] NET: Add SO_PEERCONTEXT for multiple LSMs
To:     John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Simon McVittie <smcv@collabora.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, Casey Schaufler <casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-24-casey@schaufler-ca.com>
 <56b96440-a304-42b6-1515-1ad2659b2581@tycho.nsa.gov>
 <e7aa3b6f-cee1-6277-21dd-77a4db9bbc2b@tycho.nsa.gov>
 <a522de22-ba62-a24d-24f7-b69418e7ec0b@tycho.nsa.gov>
 <20191219121939.GA1291250@horizon>
 <55b5c889-ff38-38c4-578e-ec4211b837a4@tycho.nsa.gov>
 <93912039-e64e-cc56-20fc-095accf6c4dd@tycho.nsa.gov>
 <20191219164831.GA1308552@horizon>
 <16af7932-a57b-1454-18ca-c2ff6e6b302d@tycho.nsa.gov>
 <a828a629-cdb8-57c3-8c6e-9b080842ec05@canonical.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <abea0322-cf44-c37f-35c3-955adb8a455d@schaufler-ca.com>
Date:   Thu, 19 Dec 2019 12:51:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <a828a629-cdb8-57c3-8c6e-9b080842ec05@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/19/2019 11:27 AM, John Johansen wrote:
> On 12/19/19 9:02 AM, Stephen Smalley wrote:
>> On 12/19/19 11:48 AM, Simon McVittie wrote:
>>> On Thu, 19 Dec 2019 at 10:00:31 -0500, Stephen Smalley wrote:
>>>> Looks like userspace is generally forgiving of whether the terminati=
ng NUL
>>>> byte is included or omitted by the kernel (with different behaviors =
for
>>>> SELinux - always included, Smack - omitted by /proc/pid/attr/current=
 but
>>>> included in SO_PEERSEC, and AppArmor - omitted for /proc/pid/attr/cu=
rrent
>>>> but includes a terminating \n, omitted for SO_PEERSEC but no termina=
ting
>>>> \n), and procps-ng explicitly tests for printable characters (but tr=
uncates
>>>> on the first unprintable character).
>>> Because LSM people have told me in the past that the '\0' is not
>>> conceptually part of the label, the D-Bus specification and reference=

>>> implementation already assume that its presence or absence is irrelev=
ant,
>>> and normalize to a canonical form (which happens to be that it append=
s a
>>> '\0' if missing, to be nice to C-like languages, but I could equally
>>> have chosen to strip the '\0' and rely on an out-of-band length count=
).
>>>
>>> By design, SO_PEERCONTEXT and /proc/pid/attr/context don't (can't!)
>>> preserve whether the label originally ended with '\0' or not (because=

>>> they are designed to use '\0' as a terminator for each label), so the=
se
>>> new kernel interfaces are already a bit closer than the old kernel
>>> interfaces to how D-Bus represents this information.
>>>
>>> The problematic case is AppArmor's terminating '\n' on
>>> /proc/pid/attr/current, because when I asked in the past, I was told
>>> that it would be (unwise but) valid to have a LSM where "foo" and "fo=
o\n"
>>> are distinct labels.
>> I don't agree with that stance, but obviously others may differ.
>>
> Its not so much a stance as a reality. The LSM allowed anything except
> \0 values as part of the interface and there was no documentation
> to set expectations beyond what the code allowed.
>
> This could be tightened.
>
>>> If that hypothetical LSM would make procps-ng lose information (becau=
se
>>> procps-ng truncates at the first unprintable character), does that ch=
ange
>>> the situation any? Would that make it acceptable for other LSM-agnost=
ic
>>> user-space components, like the reference implementation of D-Bus, to=

>>> assume that stripping a trailing newline from /proc/pid/attr/context
>>> or from one of the component strings of /proc/pid/attr/current is a
>>> non-lossy operation?
>> IMHO, yes.=C2=A0 In fact, looking further, I see that systemd's src/li=
bsystemd/sd-bus/bus-creds.c:bus_creds_add_more() reads /proc/pid/attr/cur=
rent with its read_one_line_file() helper which ultimately uses read_line=
_full() and treats EOF, \n, \r, or \0 as terminators and truncates on fir=
st such occurrence.
>>
> fun
>
>>>>>> =C2=A0=C2=A0=C2=A0 If this new API is an opportunity to declare th=
at LSMs are expected
>>>>>> =C2=A0=C2=A0=C2=A0 to put the same canonical form of a label in
>>>>>> /proc/$pid/attr/context and
>>>>>> =C2=A0=C2=A0=C2=A0 SO_PEERCONTEXT, possibly with a non-canonical v=
ersion (adding '\n' or
>>>>>> =C2=A0=C2=A0=C2=A0 '\0' or similar) exposed in the older /proc/$pi=
d/attr/current and
>>>>>> =C2=A0=C2=A0=C2=A0 SO_PEERSEC interfaces for backwards compatibili=
ty, then that
>>>>>> would make
>>>>>> =C2=A0=C2=A0=C2=A0 life a lot easier for user-space developers lik=
e me.
>>>>> I'm all for this but the current implementation reuses the same
>>>>> underlying hooks as SO_PEERSEC, so it gets the same result for the
>>>>> per-lsm values.=C2=A0 We'd need a separate hook if we cannot alter =
the
>>>>> current AppArmor SO_PEERSEC format.
>>> If AppArmor was going to change the format of one of its interfaces
>>> (or deviate from it when implementing new interfaces), I'd actually
>>> prefer it to be /proc/pid/attr/current that changed or was superseded=
,
>>> because /proc/pid/attr/current is the one that contains a newline tha=
t
>>> consumers are meant to ignore.
>>>
>>> For what it's worth, libapparmor explicitly removes the newline, so t=
his
>>> only matters to LSM-agnostic readers like D-Bus implementations, and =
to
>>> lower-level AppArmor-aware readers that use the kernel interfaces dir=
ectly
>>> in preference to using libapparmor.
>> Deferring to the AA maintainer(s) to speak to this.
> I will look into what I can do. If we can ditch the trailing \n, that w=
ould
> be best. I tried to do that once before and we ran into some problems a=
nd
> I had to revert the change. But that was a long time ago and we can pro=
bably
> get away with doing it now.

I would be happy to define and document that the compound context does
not include trailing \n. There are no existing security modules or
user space that would be impacted. No one uses /proc/self/attr/context
or SO_PEERCONTEXT yet. If AppArmor is happy with stripping the \n I
think we're good to go.


