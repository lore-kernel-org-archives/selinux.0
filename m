Return-Path: <SRS0=wrJH=Z7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF925C43603
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 16:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA8F20692
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 16:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="T6Jcjww6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfLIQc3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:32:29 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:44212
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbfLIQc3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Dec 2019 11:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1575909147; bh=v0Fh3Y4Sn63AVlvk8Cnam4m9z9ymD5Wc89ssc0mNTmg=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=T6Jcjww6yPdm3QprqwHwdOMzIf5bTwUkpn91NXse4Cq5IYoDarOOOmp9Al4uUfF5elqoUfzfcwMhEiF9LPc9E4/7BUMtxhbd3WRbd+GuD/EU0buJvhccI3gFzLtz2mHQsh+50MWP29Yqn8WAHcs+AHEsz+6SyuHznW1Wb4fCg06LNvwc8WIJzcXI93m1CuICjbH14JdYbn/DwFmwSTQEEgnwUXujtoHCQH6JPjXt/WnCetMXNpqSee6Tu8GyIw5Rjq7d1iQs1cY13nu6K5T7x48VoDpQ0Kc4NvCgX56nmXQxNPa5hlM2tk+vGQmKQynTFRZS/GnsEZPQfUkMGxjAjQ==
X-YMail-OSG: bt.xnEkVM1nWHHEIukOe8FDvdlrjqWrPZ4V0vwV2RbGg023OJ5lnI.hc5Wgle3H
 IY2xEkoeKjn1IQ896Lvtx9g.cMJDbciCBZ.ZUOcvj_L8lQEwZvXZUFrJKWWWTmI_uOqzPbyHAReR
 HJvwe.vOtAJ0iAnEFmEB..hZfoGzgHr0FlCX1sMFLhzUMiF8EwDIw7QkpP9mwhJNMqe_yNaff5d_
 RsTQbDBHX_JOEqLvwQ.ODfQDkWZGBIN7iRb8hEyJkRmDtLeijATb0t2nsL5HyxH_VXWdlkubyZtH
 qJnDpV5y2iGOLef3OeilqScGciawj6Mm0hD0rBVVoi4otccXCWSxXvvD.e0PMPAr38cqkoIn7O1T
 xyQka3yn4UwubGN88GKlbDNBE7jkrKzrik6fRGfKXiBGbjYs1jb0UKnrMQ_vvC4q1JyMUsPeTM0v
 ra9Oyz2shEO3m8K4Rof0DoOjw9DAQilwOsg9W4ThypM6MSj2DfOLkiOJ3aWe99eoahwVBdQ0FT6K
 4VfI0hHztOc_eE.cFsLP_IABx9yvtKmImJ_ZGLanIWiM_gpMNMNAZgPBJhoWJKZZrWBy.ClQT56r
 LwNqOKvMpXtTORgGoVrp5iLD0j4Lxyfb7TX_ZR.DbPUOMArOw6MwmSnffP_DACO7xF2p6BC.fl7S
 ZoqqAdXRd8UMw8nbuCqMXmJniPtTudWjiU20kAb4Rodqa.PCiLYxqu.gjcy0hYpPi5H4pa08gHzb
 Q4DJQfw69SIRonkj9M_s6hawuwTlnzTo7utMaRw6UB99tshsSsGOHBvz6i2lNnQLlfKrMbjBTASK
 7YqCQZeCltenREGjFmnfrPThjlfVKs4bNbSNU5FGaZrVGcJnKZMZ5u56JleO8Gveo7EmsySwBb0C
 gkPC6FbxwVRuWoxi2qRPeAZmRZlc_xUE53ETh7NIDzH9LMZDi4jICgNoewHvnemkB0PZ5cci7Xvz
 yBXFTvVVhQQM9yCcdj6nOS5A1pngYsJZ8bXo8vRjt72rj5caNUJRbMSjYtbUZGAN_XOIkmaJI8T6
 vTcTqJ3mY6AqjVHAVfPgs8KCLB.i572OmPknCKrFDqGkllEPmhydXKsAGwnVgGKBdl8OsuEmZnrK
 8HPe9mbDzoTQWngOE.sXLOyNfytC4os3mM78T1.4lX6NESM26ygL7wVfz_TbGwZJ8CVkNDD2oCrH
 PYYaT.02ltBVu1a0z1r0hPHItob0dFbwWFDMANxYWD9Uqq3WwpaqiclJFU8ZqSbIoE2o1Ft.Dnx2
 SRRaTHUGfxGAVwlUq40qG9ykYD8bZEDRJ7POel6k7kMXtrRGnRkp4Tb3np6Wpx1rkwTLTT1o0fqJ
 Op_1LEMJyFF7sVfZEa7txYxbJw7Z6pXvFdI3hf1ablBMbLw1w0Kl965WSvCoSaJe.wD5fpcBeaem
 NI46WsZ5GHiit4AopgAqprgsa
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 9 Dec 2019 16:32:27 +0000
Received: by smtp418.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ed804fa6435ca07c47d2d2ae6ea75bf3;
          Mon, 09 Dec 2019 16:32:23 +0000 (UTC)
Subject: Re: [PATCH] selinux: reorder hooks to make runtime disable less
 broken
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20191209075756.123157-1-omosnace@redhat.com>
 <23671223-f841-564c-6ae8-0401bce0fa20@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <3285ac79-5d26-71bf-6fd7-dc1895ee7bbc@schaufler-ca.com>
Date:   Mon, 9 Dec 2019 08:32:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <23671223-f841-564c-6ae8-0401bce0fa20@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/9/2019 5:21 AM, Stephen Smalley wrote:
> On 12/9/19 2:57 AM, Ondrej Mosnacek wrote:
>> Commit b1d9e6b0646d ("LSM: Switch to lists of hooks") switched the LSM=

>> infrastructure to use per-hook lists, which meant that removing the
>> hooks for a given module was no longer atomic. Even though the commit
>> clearly documents that modules implementing runtime revmoval of hooks
>> (only SELinux attempts this madness) need to take special precautions =
to
>> avoid race conditions, SELinux has never addressed this.
>>
>> By inserting an artificial delay between the loop iterations of
>> security_delete_hooks() (I used 100 ms), booting to a state where
>> SELinux is enabled, but policy is not yet loaded, and running these
>> commands:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 while true; do ping -c 1 <some IP>; done &
>> =C2=A0=C2=A0=C2=A0=C2=A0 echo -n 1 >/sys/fs/selinux/disable
>> =C2=A0=C2=A0=C2=A0=C2=A0 kill %1
>> =C2=A0=C2=A0=C2=A0=C2=A0 wait
>>
>> ...I was able to trigger NULL pointer dereferences in various places. =
I
>> also have a report of someone getting panics on a stock RHEL-8 kernel
>> after setting SELINUX=3Ddisabled in /etc/selinux/config and rebooting
>> (without adding "selinux=3D0" to kernel command-line).
>>
>> Reordering the SELinux hooks such that those that allocate structures
>> are removed last seems to prevent these panics. It is very much possib=
le
>> that this doesn't make the runtime disable completely race-free, but a=
t
>> least it makes the operation much less fragile.
>>
>> An alternative (and safer) solution would be to add NULL checks to eac=
h
>> hook, but doing this just to support the runtime disable hack doesn't
>> seem to be worth the effort...
>
> Personally, I would prefer to just get rid of runtime disable altogethe=
r; it also precludes making the hooks read-only after initialization.=C2=A0=
 IMHO, selinux=3D0 is the proper way to disable SELinux if necessary.=C2=A0=
 I believe there is an open bugzilla on Fedora related to this issue, sin=
ce runtime disable was originally introduced for Fedora.

I agree completely with Stephen. There was significant discussion at the =
time
of switching to hook lists about this. My recollection is that there was =
consensus
that removing security_delete_hooks() was the way of the future. If anyth=
ing was
to be done it would be removal. That was some time ago now, and something=
 may
have changed in the usage patterns. We have "Linux Security Modules" inst=
ead of
"Loadable Security Modules" in large part due to the inherent difficulty =
in
ensuring that removing a security policy implementation on the fly can be=

done safely, much less securely.=20


