Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660FEC433EF
	for <selinux@archiver.kernel.org>; Sat, 13 Nov 2021 13:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48FBF6112F
	for <selinux@archiver.kernel.org>; Sat, 13 Nov 2021 13:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhKMNzo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Nov 2021 08:55:44 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:36361 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231672AbhKMNzn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 13 Nov 2021 08:55:43 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DB94832009BD;
        Sat, 13 Nov 2021 08:52:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 13 Nov 2021 08:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        from:to:cc:subject:in-reply-to:references:date:message-id
        :mime-version:content-type; s=fm1; bh=B1Zsp7U+e2bQQbkjY5oasQLiW5
        cSmi1bsMUStOqMTFw=; b=IxLuS+eqXsJPqO49i5zgtD5jjudDJQAeptQmKnL93f
        Np2FtGXWcvHZGYNJ9ZEY3h3L/nzJLsWvt2GZTD5Aa9XRL9Mwy6ufuyB6TPaFIo3h
        P8lW+1jZfw4gEU7L6B4RFmIBJRLU5QKzjv+590ALqOQ3I0dSw+UjsCHBC4knieIM
        P4AKH8HX9ox9/R3Kly4Ecd7yuqaT5+uNtXbMEN1tVpliICrQzmKq8k502LJKjmhv
        SGcosH1vbIzNq+ApLsb4j0s9KYfyPVSzITMzzjg5rk1w1rtZo+l4Gd5GZCD24+/M
        H1MEqJps5iQ6+eSOvlov45bAs0VdoLiNb6k4XZn5Ke9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=B1Zsp7
        U+e2bQQbkjY5oasQLiW5cSmi1bsMUStOqMTFw=; b=AcDK23TmCLLPhHQZf247RK
        BxQxhipCWRMX+wuIRoHBO0sLiwPM8J9G3ATXvIUYbWqTkCo8vg8j9X5QrbBoJmvc
        1ihi1/GLnBRIV0Q8qrz6GpvFQ+Sh3xZNgLGMuhq4Vrt3yvUTEH3YruKi39deqd0/
        q1QWtsl/0xqr6gbJYkPwuZ/J2FIJTfJJ9j4k51UZPYCvAX4I4I54LFelSLi/EScn
        m8qNwH73VagZZMCkqzzYdaMcoDWHoqJdMPAnphz0vqXO9ucemgUAbt6CXjqB9YaM
        VJiRKU6GWYBhNZsVyPqikns2YneZIddcqMk0vZhZfECeGDuUkHw9ZdHtCsMBB9qA
        ==
X-ME-Sender: <xms:MsOPYc47BZp7EC3FJ71sN2XT9ulQV8GWuDpeLo89AQd2kb5p0MxUlA>
    <xme:MsOPYd6m01WQFkW12LhN8tm9PcqD0AJYVbuvcZ4H7NkZUpHgc653VKKbqTnQ1LiPC
    wkKKQT679cD81toEQ>
X-ME-Received: <xmr:MsOPYbfYEQNh_5X3nHBYIQwWIzDk05nAvBXkiTTj6Xfzk5N3_NuAxdoeTRR4B7kfQx66rRynOEGT6G96Sty0Ge8wr0w2hrk5rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvdehgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffujghffffkgggtsehgtderredttdejnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeegueduhf
    ehvdevjeehvdfgudfgvdduffeitefhtdevffelgefgtdffgfduudetgeenucffohhmrghi
    nhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:MsOPYRIc5RYZsqTeXH4FzxfCIGT2oXPwtOC-zzmvK5LDp2PE7UB4rg>
    <xmx:MsOPYQLkoE9JJjDb8Gr3JMC-QjGInq5arGlOVJjgSGbAcVr2S_SCyQ>
    <xmx:MsOPYSx9GeMk9ZvV_IMBiGLL_O5KvzhprtzoKSl9qO1Bmt2TpmTqSg>
    <xmx:MsOPYay1pp5RU6KiAJTpDE4vZC_OU96Ii8Irg2oIIt2FZitkIEw98Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Nov 2021 08:52:49 -0500 (EST)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id 9764A48B; Sat, 13 Nov 2021 13:52:47 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] Support static-only builds
In-Reply-To: <CAJfZ7=mmv1FxAP0FY=mDZvUDhQx3f4zzB0OHP-M-P1OWx_ZJjg@mail.gmail.com>
References: <20211111164229.9711-1-hi@alyssa.is>
 <CAJfZ7=mmv1FxAP0FY=mDZvUDhQx3f4zzB0OHP-M-P1OWx_ZJjg@mail.gmail.com>
Date:   Sat, 13 Nov 2021 13:52:37 +0000
Message-ID: <87lf1scgd6.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Thu, Nov 11, 2021 at 5:42 PM Alyssa Ross <hi@alyssa.is> wrote:
>>
>> Sometimes it's useful to have a static-only toolchain.  This can be
>> due to targetting some weird embedded platform, or it can be because
>> it ensures that no dynamic libraries are sneaking into a system that's
>> supposed to be 100% static due to non-cooperative build systems.  Most
>> build systems support static-only builds, e.g. autoconf provides a
>> --disable-shared configure option.
>>
>> libselinux's custom make-based build system did not support such an
>> option, so here I've added one.  Apart from the obvious changes, I had
>> to make the utilities that use libpcre link against it manually,
>> because that can't be inferred from the static libselinux.  For
>> downstream users of libselinux using pkg-config, this shouldn't be a
>> problem, because libselinux.pc already includes the Requires.private
>> line that specifies libpcre should be linked against as well.
>>
>> Signed-off-by: Alyssa Ross <hi@alyssa.is>
>
> Hello,
>
> Thanks for your patch. It is interesting (as a maintainer) to see that
> some SELinux users are still interested in having the static
> libraries, as in the past there were messages about users who only
> wanted the .so on their systems, if I remember correctly.
>
> Your patch looks right, except for one detail (which I put inline).
> Nevertheless I am wondering about how future changes will not break
> your use-case and I am thinking of adding a "DISABLE_SHARED=3Dy"
> configuration to our Continuous Integration system. More precisely it
> would be nice to have something similar to what is currently done to
> test various build configurations in
> https://github.com/SELinuxProject/selinux/blob/3.3/.github/workflows/run_=
tests.yml#L84-L94
> . Currently when I try to test it, it fails when linking
> libsemanage.so:
>
> /usr/bin/ld: /destdir/usr/lib/libselinux.a(seusers.o): warning:
> relocation against `stderr@@GLIBC_2.2.5' in read-only section `.text'
> /usr/bin/ld: /destdir/usr/lib/libselinux.a(seusers.o): relocation
> R_X86_64_PC32 against symbol `stderr@@GLIBC_2.2.5' can not be used
> when making a shared object; recompile with -fPIC
> /usr/bin/ld: final link failed: bad value
>
> This build failure is normal, as the files in libselinux.a are not
> compiled with -fPIC and cannot be integrated in libsemanage.so. Did
> you also modify libsemanage (and other tools) to also use the static
> libraries?

My purposes didn't require libsemanage, so I hadn't tried, but indeed I
wasn't able to build it.  The next version of my patch will add
DISABLE_SHARED support to libsemanage and policycoreutils as well.  I've
now also tested checkpolicy and semodule-utils, which worked without any
further changes.

> This failure also happens when linking the Python bindings (with "make
> install-pywrap"). Are you using bindings to Python or Ruby in your
> project?

No, and I'd expect that it wouldn't be possible, since I assume the
bindings have to be shared libraries so they can be dlopened by the
language runtimes?  Maybe it would be possible to link static binding
libraries with the interpreter, but I've never heard of anybody doing
that=E2=80=A6

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmGPwyYACgkQ+dvtSFmy
ccB/eQ//SWCHh3FNI3/Myv9rk6Hdu9uBiHf36/yfFg2LHPtrLRjRiqNkVB8iA3nQ
Rcy3cj4siRRPnBJCj3JBl+6Gf90A0xqhNHlzm0iWxY6fnsUk0L4GSudb53r8OvN6
jjGxebH0O0/cxbahNmSj4Q+x/mikPNfMriKIbAnEL6WH1ubehMSupwD6xZRTZasb
8CUnAP9UuXbJQI0bC/xPKFZES37i6wYqL/xMJfIpMrBZh3+wHbtkkGrTZmqB5A4Q
m42I6b6q+rizETbrcmXiokvR5uMZrZ61U4THw5yjgUw2ZpEg+EaYDgCJlG8InZiO
pwDGb73ooggOLULVRYxConUrmoHShZSLz75nQ2VW8E7pjsmF2S3wksCudxQr3s0o
V7x3MgZOU38gIvvXnD+HpwHF+u1iAnTVnUOjbmPVbY4OrHo8xQseFA3gpVhrYrjN
B8xj3oClO3tDuSdFlws/tOSHz0XFtsB0rU3ZftzMVohvSlEKqZ3mTG5ReBfU1a1b
lOr1S/x5c2yqZmkG18xlG+iq1va70G23miTiAx1/35keSQoyDtBit7Opsbijpa8b
6OlTU81b7YENjNLQKVkYiNoeRStMdnuMbBUUbcl3FvwQi2k5eliEhNW2qM1zWJNP
Ergy/DpwQu9RXYIcpvUr2SdCW4cPLN2awK6HteIoyxAworiupx8=
=e8S0
-----END PGP SIGNATURE-----
--=-=-=--
