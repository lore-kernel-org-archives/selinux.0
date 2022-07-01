Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D32BC43334
	for <selinux@archiver.kernel.org>; Fri,  1 Jul 2022 20:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiGAUnd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Jul 2022 16:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiGAUnb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Jul 2022 16:43:31 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCD71AF12
        for <selinux@vger.kernel.org>; Fri,  1 Jul 2022 13:43:30 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id i17so4875830qvo.13
        for <selinux@vger.kernel.org>; Fri, 01 Jul 2022 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bigbadwolfsecurity-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aUouAVxhFAYVTwjCkh7rKspH85fPiOHCQg6cVLi9Zq8=;
        b=U1QudZLpv2bKNqrrJuVUL4QdHBPksHeKoGibGXIVubjoemzUjeaM9Gd47Fu01ihp7o
         obMgKCptRNu0+zDE2rcchbiAoCn9Sevc0ClKW6R5EqVu/7w28jkgfuiN2naSVibj3nN0
         RKoTa0yL3JWPHn5xO/9LQ5Eoe5E8un8WDua6sv5FJMSUXA1kpIa9OZCc5sS9riRxv/Vs
         GEs7dcxX3zzdPqY2k0JPOayAJAEPpve6h5tXvrYdJOo1/FgOGfoQEErE71ONHU4tcd5g
         yVBHT/BhHf4iPXfAGpzpJgP+1BWyaaLimPdcbI1opqhLjKnUVhwW97QJwXuyezXUZCFq
         d4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aUouAVxhFAYVTwjCkh7rKspH85fPiOHCQg6cVLi9Zq8=;
        b=zjGFU8A3ktWru1OlwEsYNy+uhiIu1UEIAIwyPyby7kY5PA2rZsJ/3EKhbMjf6degEk
         flzOV04msoCY8g71lzAxJsOnyHmBNPz0QHYwuvbL1MhHOYxkGIa7EI+sqyXuQ5p+fkPu
         1czjQkueyesC+s23fft/I9tY623xuy5dezVxeYF5Ed98vO/bh7fHOMmXdF6AZKggywFy
         6tEMBZgK4hIb4cU++elfmMQbwDjkgMsrI12YByYLDmkkEtzR7z91CzzkDqPwDXkhBwKC
         vtkmSEQKNveaXuB5ZkwusCX10Xf800Z4TMzMSxv28hLoMsCdOqh3/Zc/uPmEyWZUTxKg
         8WFg==
X-Gm-Message-State: AJIora8KEExq2s0wq5QcY3P0vqea1kXcjq+ZUIp1pT/7/7vbKIkr0ub8
        FZggyBIKEBNSrRQWtnQxy5wGgQ==
X-Google-Smtp-Source: AGRyM1v0LOof+dqUGe3ugAgU5zi2pFbfJCzM724czDEGZlaMCs1M4y2on/9EAgQ0vkHBjepnvIKUeg==
X-Received: by 2002:a05:6214:410e:b0:470:4609:c87c with SMTP id kc14-20020a056214410e00b004704609c87cmr19184767qvb.62.1656708209239;
        Fri, 01 Jul 2022 13:43:29 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b058:3a8e:44f3:3d01:c06c:2293])
        by smtp.gmail.com with ESMTPSA id f30-20020ac840de000000b00315110b47bcsm15316622qtm.22.2022.07.01.13.43.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jul 2022 13:43:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: What is "fscon" statement in a base policy?
From:   Karl MacMillan <karl@bigbadwolfsecurity.com>
In-Reply-To: <CAJ2a_De9=CoyWS=EEgWHpbzoXK6O1H21Lwf_hMFfFUtGBMUfJg@mail.gmail.com>
Date:   Fri, 1 Jul 2022 16:43:27 -0400
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2260DCB6-94DC-4540-982D-9747F5789624@bigbadwolfsecurity.com>
References: <CAJfZ7=mP2eJaq2BfO3y0VnwUJaY2cS2p=HZMN71z1pKjzaT0Eg@mail.gmail.com>
 <CA+EEuAiG1B8i1xTt+K1QO1UPgynZVYiRkiLTY6nTVi9Rm4uA1A@mail.gmail.com>
 <CAJ2a_De9=CoyWS=EEgWHpbzoXK6O1H21Lwf_hMFfFUtGBMUfJg@mail.gmail.com>
To:     =?utf-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



> On Jul 1, 2022, at 5:26 AM, Christian G=C3=B6ttsche =
<cgzones@googlemail.com> wrote:
>=20
> On Fri, 1 Jul 2022 at 03:58, Karl MacMillan =
<karl@bigbadwolfsecurity.com> wrote:
>>=20
>> Hi Nicolas,
>>=20
>> I believe these are described on page 19 of the old "A Security =
Policy
>> Configuration for the Security-Enhanced Linux" [1].
>=20
> Quote from 7.2 File System Contexts:
>=20
>    Currently, this configuration is unused.
>=20
>> There is still support for these in the kernel [2], so it seems =
unwise to me to drop
>> them even if they are not used in policies.
>=20
> git log -S OCON_FS lists
>=20
>    335c818c5a7a can: mcp251xfd: move chip FIFO init into separate file
>    55e5b97f003e can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI =
CAN
>    875347fe5756 can: mcp25xxfd: add regmap infrastructure
>    cee74f47a6ba SELinux: allow userspace to read policy back out of =
the kernel
>    1da177e4c3f4 (tag: v2.6.12-rc2) Linux-2.6.12-rc2
>=20
> and grepping the source shows
>=20
>    $ grep -Rw OCON_FS security/selinux/
>    security/selinux/ss/policydb.h:#define OCON_FS          1 /*
> unlabeled file systems */
>    security/selinux/ss/policydb.c: if (i =3D=3D OCON_ISID || i =3D=3D =
OCON_FS ||
>    security/selinux/ss/policydb.c:                 case OCON_FS:
>    security/selinux/ss/policydb.c:                 case OCON_FS:
>=20
> OCON_FS is only used while parsing a policy and on cleanup, but there
> is no actual usage, e.g. for OCON_FSUSE:
>=20
>    security/selinux/ss/services.c: c =3D =
policydb->ocontexts[OCON_FSUSE];
>=20
> So for me fscon is not used at all.
>=20

Your assessment is better than mine - thanks for digging deeper. What a =
shame that code is in-kernel then since it does nothing and there was =
likely never a policy that had these.=20

Karl

>> Good catch though!
>>=20
>> Karl
>>=20
>> 1. =
https://media.defense.gov/2021/Jul/29/2002815735/-1/-1/0/SELINUX-SECURITY-=
POLICY-CONFIGURATION-REPORT.PDF
>> 2. =
https://github.com/torvalds/linux/blob/master/security/selinux/ss/policydb=
.h#L228
>>=20
>> On Thu, Jun 30, 2022 at 5:05 PM Nicolas Iooss <nicolas.iooss@m4x.org> =
wrote:
>>>=20
>>> Hello,
>>>=20
>>> While studying some malloc calls in libsepol and checkpolicy, I
>>> stumbled upon function define_fs_context(), which allocates a
>>> fixed-size buffer in
>>> =
https://github.com/SELinuxProject/selinux/blob/956bda08f6183078f13b70f6aa2=
7d0529a3ec20a/checkpolicy/policy_define.c#L4631-L4637
>>>=20
>>>    newc->u.name =3D (char *)malloc(6);
>>>    if (!newc->u.name) {
>>>        yyerror("out of memory");
>>>        free(newc);
>>>        return -1;
>>>    }
>>>    sprintf(newc->u.name, "%02x:%02x", major, minor);
>>>=20
>>> As major and minor are unsigned int (so 32-bit integers) without any
>>> value checking, there seems to be a possible heap buffer overflow
>>> issue. This function is called when parsing a fscon statement in a
>>> "base" policy. So I copied tmp/base.conf from a build of the =
Reference
>>> Policy, added "fscon 1000 1000 system_u:object_r:unlabeled_t
>>> system_u:object_r:unlabeled_t" right after "sid security
>>> system_u:object_r:security_t" (the order of the statements matters),
>>> and ran:
>>>=20
>>>    $ checkpolicy -o test.pol base.conf
>>>    *** buffer overflow detected ***: terminated
>>>    Aborted (core dumped)
>>>=20
>>> For whatever it's worth, the stack trace of this abort tells that =
the
>>> buffer overflow occurs in a call to __sprintf_chk(): my gcc compiler
>>> seems to be "smart enough" to find out that the size of newc->u.name
>>> was 6, and it replaced sprintf() with __sprintf_chk() to ensure that
>>> the buffer was not written past its bounds.
>>>=20
>>> Now, I can submit a patch to fix this issue, for example by =
replacing
>>> malloc()+sprintf() with asprintf() and by checking that major and
>>> minor are below 256. But before doing so, I was wondering: what is
>>> this fscon syntax? I have never encountered it, did not find any
>>> policy using it, and I am wondering whether we could instead drop =
its
>>> support and remove function define_fs_context() from checkpolicy.
>>>=20
>>> Thanks,
>>> Nicolas
>>>=20

