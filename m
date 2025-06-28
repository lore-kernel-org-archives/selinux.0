Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02571221D96
	for <selinux@vger.kernel.org>; Sat, 28 Jun 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751099870; cv=none; b=CPP7oiyv/8TCaTP/akG+FVk4UwibcJoIvUmgdWzoNQFbJ5V2F+U3DorYoWOQcCMcLmloH/vZjKGMoe2WMkPmUr6sfCNAZ7opvG2SDQuLPH5Md22dAKAnJWwz7CnOTsXIzzNTxBBzIdwwCx1WpF4pASgWySdO9BEFgjLYLzzAGvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751099870; c=relaxed/simple;
	bh=w4yElYlj7uFuZaCBHQmp9XD6hu3IosTEIdd0W8MFhKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R1Rs7hejNYTFZBxIyiCkUig6XpCuQVO/Svgs9G+o/6IE9gJcJQDJdKQ83I0T2bCNmMCeAHFhJeZpoEmgvZictvyDqQAah+iu6dxeZwW0XeLqeuU0w9YCQigPdQKrDXs4HuFFEDtfTxZMwfNGVjNDGVByVxbjHc3VGyy7JnjDnak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=FvUwXuYT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y3OCag75; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="FvUwXuYT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y3OCag75"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D4EE4EC02B4;
	Sat, 28 Jun 2025 04:37:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 28 Jun 2025 04:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751099865; x=1751186265; bh=GAt7pGWfmu
	NHRIU7WPYGI5ZTcm4SAtxuOFuR9wwUrlI=; b=FvUwXuYTR1yp2RSQeRiHJe91Qz
	7biFGOtH5uGdDR7oVrWFV8Qe9VjeRgPo9f5m7Y5mfLmjbMpf9QflsOXMUkDbid/q
	G8xCNoMGYmzwqnn2t12AqXYK5poaQoKubZQpDH7H1DMKwT+kLaWCB+ExBhXpwQbQ
	pLNtPV0z0dwlZtSQUBlL4e4uGEoluTeidoGnGSkU9Ah4PutErhZL4+Zg+Ov73t3u
	1+DvzrNxE418Z6RwZaibcXYQeypfuNEL8wtiMR1pbyN9MaLw3tJNu7h2vohsqLWM
	RNyA+om+WtkVSWlNd531QNpDy8HFOWsKbUlJg9BO6O0+mAhdWSICtE3ClSSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751099865; x=1751186265; bh=GAt7pGWfmuNHRIU7WPYGI5ZTcm4SAtxuOFu
	R9wwUrlI=; b=Y3OCag75WvZTN5VKEvmHgYVEbwr1f2m6exyAWn9erQJwm//YJf1
	F0zTHoowhkvq+b9ibJfB6tFlVdYgiAjaRULaxN0luN8DCrMK2JwiP6PJi66weYdl
	qgamW1963j2KjVco8CgDhCrH1Kz5LXUc5+qJy1IpgehxeFzjSPCCxpCbclk9Huar
	FD6vadeKUEy+IG9D1XkYdKcCP36cEP9xiri8SaxcGg6wczxjzHwLy/ThkyZOSklz
	/BRwC7qHekhwosMZsGfzuZZtJ7klMpTiZus6WEA0HLpYfbfBWC/E3K3SkrLEpSOD
	XhRZO6uAAHfm0a8KBenPZGhB/agYXAjzzxw==
X-ME-Sender: <xms:2KlfaERVpDhhfS8lUaez_1gY3G06DXauLfswhRv1SWed8fCSfDxPCQ>
    <xme:2KlfaByCOZ0G6dpgd7EmaDHTyeQrMm-A7v37rfQueqKf81L-OH6bR4oEH_JHayubl
    aKZvhtfpABGgiA3ig>
X-ME-Received: <xmr:2KlfaB3mkc1grR5oKga4_WGSgN17OjgU-AXQ9cq2K3D24jhGovu0_xFLIbBTFoV5-mWx55STKhk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkgggtsehgtderredttdejnecuhfhrohhmpeetlhihshhsrgcutfho
    shhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpedtkedvfedvvd
    etheehueeifeelieeggeefgedtvefgvdfhvdethedvkedtheevvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhephhhisegrlhihshhsrgdrihhspdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjfigtrghrthdvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepuggsuhhrghgvnhgvrheslhhinhhugidrmhhitghrohhsohhfthdrtgho
    mhdprhgtphhtthhopehnihgtohhlrghsrdhiohhoshhssehmgeigrdhorhhgpdhrtghpth
    htohepugifrghlshhhsehrvgguhhgrthdrtghomhdprhgtphhtthhopegvphgrrhhishes
    rhgvughhrghtrdgtohhmpdhrtghpthhtoheplhgruhhtrhgsrggthhesrhgvughhrghtrd
    gtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2KlfaIB0fCnUarR7Up5wdp-RVs5txCrpgqALMa3dtzSsCoMpqN__5g>
    <xmx:2KlfaNhe7BwyDEjoMH0wn5e84pZVxsVG3xrnpSa64gGjS5VRAvKQeQ>
    <xmx:2KlfaEoO4e0pHWIZwLrrbCsf5HvjfUrjE64mF3sE62tBiohyQ0U-qA>
    <xmx:2KlfaAgjf0b3c6ScKsM3SlI6y6-S1B-QDjosscCf5jK4RXsjLV9bvQ>
    <xmx:2alfaB4DukhfyOkmYoJ5JXgDVP3reQQYy20IrInHoQbC9fxHnvlGY-fC>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Jun 2025 04:37:44 -0400 (EDT)
Received: by sf.qyliss.net (Postfix, from userid 1000)
	id 45110262C1122; Sat, 28 Jun 2025 10:37:43 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, Petr Lautrbach <lautrbach@redhat.com>, Nicolas
 Iooss <nicolas.iooss@m4x.org>, Daniel Burgener
 <dburgener@linux.microsoft.com>, Dan Walsh <dwalsh@redhat.com>,
 eparis@redhat.com
Subject: Re: [PATCH 2/2] policycoreutils: use pkg-config for libsemanage
In-Reply-To: <CAP+JOzRh9UGXUkq2sgHxjK8105E3yOShVqbzEyUxZDSSXb2MLw@mail.gmail.com>
References: <87bjqebpre.fsf@redhat.com>
 <20250625104103.140498-1-hi@alyssa.is>
 <20250625104103.140498-2-hi@alyssa.is>
 <CAP+JOzTCEYA0x11_XP+8=O4Yixh7UgpO+JhRPRz_jutfL_-GMQ@mail.gmail.com>
 <877c0xfcoc.fsf@alyssa.is>
 <CAP+JOzRh9UGXUkq2sgHxjK8105E3yOShVqbzEyUxZDSSXb2MLw@mail.gmail.com>
Date: Sat, 28 Jun 2025 10:37:35 +0200
Message-ID: <87ms9s6z3k.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

James Carter <jwcart2@gmail.com> writes:

> On Fri, Jun 27, 2025 at 11:04=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>>
>> James Carter <jwcart2@gmail.com> writes:
>>
>> > On Wed, Jun 25, 2025 at 6:41=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wro=
te:
>> >>
>> >> libaudit and libbz2 are only required to be in the linker path for
>> >> static builds.  For dynamic builds, they'll be discovered through ELF
>> >> metadata.  pkg-config knows how to do the right thing in both cases,
>> >> so just use it rather than listing libsemanage's dependencies
>> >> manually.
>> >>
>> >> Fixes: da6cd3d8 ("Support static-only builds")
>> >> Closes: https://lore.kernel.org/r/87bjqebpre.fsf@redhat.com
>> >> Signed-off-by: Alyssa Ross <hi@alyssa.is>
>> >> ---
>> >>  policycoreutils/Makefile           | 3 ++-
>> >>  policycoreutils/semodule/Makefile  | 3 +--
>> >>  policycoreutils/setsebool/Makefile | 3 +--
>> >>  3 files changed, 4 insertions(+), 5 deletions(-)
>> >>
>> >> diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
>> >> index 7acd51dd..0f3d62f2 100644
>> >> --- a/policycoreutils/Makefile
>> >> +++ b/policycoreutils/Makefile
>> >> @@ -3,7 +3,8 @@ SUBDIRS =3D setfiles load_policy newrole run_init sec=
on sestatus semodule setseboo
>> >>  PKG_CONFIG ?=3D pkg-config
>> >>
>> >>  LIBSELINUX_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs libselinux)
>> >> -export LIBSELINUX_LDLIBS
>> >> +LIBSEMANAGE_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs libsemanage)
>> >> +export LIBSELINUX_LDLIBS LIBSEMANAGE_LDLIBS
>> >>
>> >
>> > I think that we actually want something like:
>> > ifeq ($(DISABLE_SHARED),y)
>> >     LIBSELINUX_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D../libselinux/src
>> > $(PKG_CONFIG) --libs libselinux --static)
>> >     LIBSEMANAGE_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D../libsemanage/s=
rc
>> > $(PKG_CONFIG) --libs libsemanage --static)
>> > else
>> >     LIBSELINUX_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D../libselinux/src
>> > $(PKG_CONFIG) --libs libselinux)
>> >     LIBSEMANAGE_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D../libsemanage/s=
rc
>> > $(PKG_CONFIG) --libs libsemanage)
>> > endif
>>
>> > As originally written, it is going to find the installed libselinux.pc
>> > and libsemanage.pc files which are not going to reflect any changes
>> > made to these files in the current build (I noticed this because your
>> > patch does make changes).
>>
>> I see.  It hadn't occurred to me that selinux userspace supported being
>> built all at once like this; I'd only seen all the components built
>> individually, which is evidently also what Petr is doing.  Your proposed
>> solution wouldn't be compatible with different components being
>> installed to different prefixes, which is how we do it in Nixpkgs, where
>> every package is installed to a unique prefix.
>>
>
> Obviously we want to support building everything separately as well as
> everything together.
>
> I think that this should work:
> LIBSELINUX_LDLIBS :=3D $(shell
> PKG_CONFIG_PATH=3D"$(PKG_CONFIG_PATH):../libselinux/src" $(PKG_CONFIG)
> --libs libselinux)
> LIBSEMANAGE_LDLIBS :=3D $(shell
> PKG_CONFIG_PATH=3D"$(PKG_CONFIG_PATH):../libsemanage/src" $(PKG_CONFIG)
> --libs libsemanage)
>
> Based on my testing:
> 1) If PKG_CONFIG_PATH is set, that will be searched first
> 2) If the pc files are not found, then "../libsemange/src" or
> "../libselinux/src" will be searched
> 3) If the pc files are still not found, then pkg-config will search
> using its defaults
>
> This seems like it should work regardless.
>
> BTW, I also tried using PKG_CONFIG_LIBDIR, but if that is set, then
> only that directory will be searched.

Looks sensible to me.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaF+pzwAKCRBbRZGEIw/w
omrNAP9vubyAxA0w26Dt5jHAIUfKaDFVZH28LzJ8Fjnz7RdFigD/fXg16oykagSZ
AfKRU0qZ/04cOHQEHnfudriC3SjLwAY=
=m6q6
-----END PGP SIGNATURE-----
--=-=-=--
