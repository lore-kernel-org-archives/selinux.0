Return-Path: <SRS0=VZrA=O4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7992C43387
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 09:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C462184C
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 09:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IOapViQ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S0bOpw8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbeLSJM3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:12:29 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40585 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727987AbeLSJM3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Dec 2018 04:12:29 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id EDBE522269;
        Wed, 19 Dec 2018 04:12:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 19 Dec 2018 04:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=lrF7x1BISefAbJ7J18hAwcdiiRX
        sVYI13/L9abn/uHo=; b=IOapViQ4UvOuQVbcYDLOsZEKumqlojE/h/IJjIzcTib
        Q6QJo4qq+lG1NWS1nQ9VaGjC5cKXnkQ1DDfYf5HjQm8lzhjekcau9bogoGAfFJOK
        j8sPT7Vntf2GCqAzNcgKp/1zdN0B/K8N/wI4ZQnbHggNGOSnHVpap2dEWl7a2Ynq
        BgD7E2uHRvLnUGa734Aw8za5TJLreE/X/FcbljUc424fNpBTGlOAkpbd4mTTN8Dg
        KtzPaa9Vcf5NIUjKsiMWb7XCCtW4JC4SSfDWUUEDMam/WRhHFbcwqE+cQrcrIATI
        EDEuNI/N4UpBuv086NdPFCmmerE1Yq07MD8rNmWYBiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lrF7x1
        BISefAbJ7J18hAwcdiiRXsVYI13/L9abn/uHo=; b=S0bOpw8DOdEJxfzzWTNkYQ
        2WqBtwClC4QM5L2+AM/x42CZ9U4R2Ic4rQEnRJbjsTtG9+QK+TPVM1bkwR+U9jqg
        KAD5h8MBWpInm8ycEOqVwZv0PraeEy12yqBWiTrSFmto5QSJCp8+Xfsc0qRAGl2M
        x8nStpeg5EUM6n9OQaAsMODKKMowtwfyCv+ZrmVcomNoEknv76/SAE2N4CioxQhE
        vxa48wWxzNulsCqxijtrPv/ewyJRAVdwO7/Caxu1Meh7qplCqH63tyra8b3F3C54
        A697mGcP2OvJ4mMOgDhy+H/dZ1vSSzEzPY54/cpbxl45Ax5sHTFE47YXkWauLtVw
        ==
X-ME-Sender: <xms:egsaXEa3jW3FyFSSEfuThwEs0PhcKZTlNwItzAR0hzREKTCy1poLYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudejtdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedttden
    ucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtug
    gjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcu
    oehpshesphhkshdrihhmqeenucfkphepkeelrddugedrfeehrdehvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:egsaXF_2LbaBkjV_-KUVQ2t-xhG-meH_ZkKXlpqrK6VqXgXsDyzJMQ>
    <xmx:egsaXAqeYnNDf18BzMU9ZIajHWWWWxBesd1rfS5kvLuTlcKeYduqvg>
    <xmx:egsaXIGYIcoigSkCfOP_0nWCHIdlsfwZXOp5H79AXA2jgmsBIapagg>
    <xmx:ewsaXIsMZuQvNG3WZjs9-OJ20T-mU0WjmgbycxpYuESRmO_Eva1M9g>
Received: from NSJAIL (x590e2334.dyn.telefonica.de [89.14.35.52])
        by mail.messagingengine.com (Postfix) with ESMTPA id F0706100E5;
        Wed, 19 Dec 2018 04:12:25 -0500 (EST)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id aa0ab8f8 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 19 Dec 2018 09:12:23 +0000 (UTC)
Date:   Wed, 19 Dec 2018 10:12:24 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>,
        James Carter <jwcart2@tycho.nsa.gov>
Subject: Re: [PATCH 1/2] Makefile: fix _FORTIFY_SOURCE redefined build error
Message-ID: <20181219091224.GA1887@ncase>
References: <1544736761-7920-1-git-send-email-william.c.roberts@intel.com>
 <a31ecb59-e330-08c8-95d3-8c9fe5a4022d@tycho.nsa.gov>
 <877d53f9-3296-368c-979f-cf73cfc50ebb@tycho.nsa.gov>
 <CAFftDdofWyE747=fFUXj8v8bN3aipgguWVziDpOhd9_VVsasmQ@mail.gmail.com>
 <CAFftDdr+1zWpGeBgpfhQ02fbfhCD2F5_F0mUTB2zQobKpANg8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <CAFftDdr+1zWpGeBgpfhQ02fbfhCD2F5_F0mUTB2zQobKpANg8g@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 18, 2018 at 08:03:54AM -0800, William Roberts wrote:
> Patrick,
>=20
> Hoping you could maybe weigh in on your choice for bypassing the
> compiler driver with -Wp and not setting _FORTIFY_SOURCE to something
> like 1 or 2?
>=20
> I'm seeing this issue on Ubuntu 16.04.5:
> <command-line>:0:0: error: "_FORTIFY_SOURCE" redefined [-Werror]
>=20
> gcc version:
> gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
>=20
> My thought is to undef/redef _FORTIFY_SOURCE in CFLAGS and set the
> level to 2. Setting CFLAGS via the env/make arg will override this
> behavior
> and use CFLAGS as is.

I used "-Wp" simply because it was existing previously, so I just
stuck to what was there already. The original issue I had was
that Gentoo Hardened, as Jason notes, already defines
_FORTIFY_SOURCE as part of the compiler spec. Due to that, I was
seeing a lot of warnings.

So I set the flag to a simple define without setting a specific
value, which _seemed_ to let the issue go away. But going back to
the initial issue, this didn't seem to have solved it correctly.
Dunno what I've been doing back then to not see the warnings
after my change anymore, but I noticed that they have resurface
recently.

So I guess the real fix would be to redefine the value by first
undef'ing it and then redefining it to the desired value. And I
do agree that in that case, we should simply revert to
_FORTIFY_SOURCE=3D2.

Patrick

> On Fri, Dec 14, 2018 at 8:02 AM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Fri, Dec 14, 2018 at 6:32 AM Stephen Smalley <sds@tycho.nsa.gov> wro=
te:
> > >
> > > On 12/14/18 8:43 AM, Stephen Smalley wrote:
> > > > On 12/13/18 4:32 PM, bill.c.roberts@gmail.com wrote:
> > > >> From: William Roberts <william.c.roberts@intel.com>
> > > >>
> > > >> Certain builds of gcc enable _FORTIFY_SOURCE which results in the =
error:
> > > >> <command-line>:0:0: warning: "_FORTIFY_SOURCE" redefined
> > > >> <command-line>:0:0: note: this is the location of the previous def=
inition
> > > >>
> > > >> Correct this by undefining it first and redefining it. Also, the p=
revious
> > > >> command line option was using -Wp which passing the value *AS IS* =
to the
> > > >> pre-processor rather than to the compiler driver. The C pre-proces=
sor has
> > > >> an undocumented interface subject to change per man 1 gcc. Just us=
e the
> > > >> -D option as is.
> > > >
> > > > See commit ca07a2ad46be141dad90d885dd33a2ac31c6559a ("libselinux: a=
void
> > > > redefining _FORTIFY_SOURCE") for why we don't specify a value for
> > > > _FORTIFY_SOURCE here.  Not sure about the -Wp,-D vs -D rationale.
> >
> > I'm not 100% convinced that the patch is the best solution or the commi=
t message
> > is describing the problem correctly. I could also be understanding it
> > wrong here.
> > The man page is saying not to bypass the compiler driver via -Wp, and I=
 don't
> > see a good reason for it either.
> >
> > See my comments below, they feed back into this.
> >
> > >
> > > I guess the issue here is that we want to provide sane defaults for
> > > building without breaking the build when others specify their own
> > > definitions and without weakening those definitions.  By undefining a=
nd
> > > re-defining, it seems like we might weaken existing builds that were
> > > specifying 2.
> >
> > We conditionally assign to CFLAGS via ?=3D operator. Thus, CFLAGS and t=
he
> > corresponding addition of EXTRA_CFLAGS which contains the undef/def
> > is not appended. CFLAGS specified via the environment or as an argument=
 to
> > make will cause this assignment not to occur (via ?=3D semantics) and w=
hatever
> > they specify for CFLAGS is sent to CC.
> >
> > Here is some sample output:
> > make CFLAGS=3D'-D_FORTIFY_SOURCE=3D2'
> > cc -D_FORTIFY_SOURCE=3D2 -I../include -D_GNU_SOURCE -DNO_ANDROID_BACKEND
> >  -fPIC -DSHARED -c -o stringrep.lo stringrep.c
> >
> > With that said, *i think its safe* to bump it back to '-D_FORTIFY_SOURC=
E=3D2'
> >
> > >
> > > >
> > > >>
> > > >> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > >> ---
> > > >>   libselinux/src/Makefile   | 2 +-
> > > >>   libselinux/utils/Makefile | 2 +-
> > > >>   2 files changed, 2 insertions(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > > >> index 977b5c8cfcca..ee55bd0dbff7 100644
> > > >> --- a/libselinux/src/Makefile
> > > >> +++ b/libselinux/src/Makefile
> > > >> @@ -64,7 +64,7 @@ ifeq ($(COMPILER), gcc)
> > > >>   EXTRA_CFLAGS =3D -fipa-pure-const -Wlogical-op
> > > >> -Wpacked-bitfield-compat -Wsync-nand \
> > > >>       -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=
=3Dnfc
> > > >> -Wsuggest-attribute=3Dconst \
> > > >>       -Wsuggest-attribute=3Dnoreturn -Wsuggest-attribute=3Dpure
> > > >> -Wtrampolines -Wjump-misses-init \
> > > >> -    -Wno-suggest-attribute=3Dpure -Wno-suggest-attribute=3Dconst
> > > >> -Wp,-D_FORTIFY_SOURCE
> > > >> +    -Wno-suggest-attribute=3Dpure -Wno-suggest-attribute=3Dconst
> > > >> -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D1
> > > >>   else
> > > >>   EXTRA_CFLAGS =3D -Wunused-command-line-argument
> > > >>   endif
> > > >> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> > > >> index d06ffd66893b..64ab877015c6 100644
> > > >> --- a/libselinux/utils/Makefile
> > > >> +++ b/libselinux/utils/Makefile
> > > >> @@ -30,7 +30,7 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k
> > > >> -Wformat-security -Winit-self -Wmissi
> > > >>             -Wformat-extra-args -Wformat-zero-length -Wformat=3D2
> > > >> -Wmultichar \
> > > >>             -Woverflow -Wpointer-to-int-cast -Wpragmas \
> > > >>             -Wno-missing-field-initializers -Wno-sign-compare \
> > > >> -          -Wno-format-nonliteral
> > > >> -Wframe-larger-than=3D$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE \
> > > >> +          -Wno-format-nonliteral
> > > >> -Wframe-larger-than=3D$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE
> > > >> -D_FORTIFY_SOURCE=3D1 \
> > > >>             -fstack-protector-all --param=3Dssp-buffer-size=3D4
> > > >> -fexceptions \
> > > >>             -fasynchronous-unwind-tables -fdiagnostics-show-option
> > > >> -funit-at-a-time \
> > > >>             -Werror -Wno-aggregate-return -Wno-redundant-decls \

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAlwaC3gACgkQEXxntp6r
8Syz2Q//cBYyfID7ejtmdNJ1X2K1YBR7gil6Ez37q116Fw9RjJ8S30kv6JjB1vQs
oehbhPTO5PIMRrD6mk/DFdR2S6c5y7CcBXUEiCP8U9fdl6mjHqohRyMRYSMkL8IB
2VA72j+U/EYgJE5VBJjbE8PGY7Tf6uAaXxPiiMb2kXEUi7sOuGrXAejPAKuE9J1+
42hjX8c2fjaM2GyfK5HA7wDw7bXqZX9ABJqVkHe3rxncJlHBRE4rl/P8JtwjMKCZ
CrLsNx6C7STpkmecS3z4jnjiFo9k5WkpT0IXnNtAE117pVG9N+GzhQ7jul1djbKH
P2fDl74+Qt30kseZxuHNmw2kmMxt9rffBaH0/VO2P4hntQIw4niogYGKSDt3aqpz
DbM0uCHpYmjLFLN4gODC2t02Xx5RVcrJuxTJ7cv/R1rt7V0xVa4hD55vuxZkcU8y
s9WXB2ZOuL+aoklm0T3jkWOiAjysY8qxHhphCJtkQBDU2fPVKg2OJ7xPFHCKkhwS
lUfUSFVaTb7IFEJ+5LJlV8p7YfdXo/kPK3ZXZin0tkgWQInfCxu3NAvH+jyLRJ7G
oI5jLDMR9xtcg212oM7ykBYip6ksXPRnEMzXaxk4TImvKf3hlTlsLspxDw+1mNuI
foOCVWWC+vJtoK7fKDOlY/2JlvcqCVjEMAVIw41RsN1b8LsBhbA=
=urrO
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
