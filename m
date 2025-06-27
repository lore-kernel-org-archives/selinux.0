Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B951B78F3
	for <selinux@vger.kernel.org>; Fri, 27 Jun 2025 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751036700; cv=none; b=b80GZjjWfN8fqoqsVDw3XgbuV9n8EitZyONwleglrTO/gTaxjqz96DgIM7G+yIp/XIhNfBzBicTN1DuSo8YMFVK8dpLoZD1+/gXmIy4a2PU9bMa+mF/ADqrakp0GEZtlFvZiuq+VZCNO9SI3vPR5dYPnkfZKtK1rL7OQVbHaYWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751036700; c=relaxed/simple;
	bh=h1d6aWlfVrtf9thY1rmU5H+dW9ZumUai7h19Oh8EIP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BlyWGlbQmQ4tIEXduK6YSnEQKqBtEgLKn86fKVx8JPOvpus/AM3j35AsIMmhgu71/zQoiPTeb6AjzyR+0Ka7xFcy5pffS2ewnK9L0f5j+CNDvp1eNdXGCATldI6GhWNsVb3iIB68s8ju6alICqIR9kc27gUkFjxim7B4pv7I1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=ndAE2veD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CEtvVG5P; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="ndAE2veD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CEtvVG5P"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E39571D001B1;
	Fri, 27 Jun 2025 11:04:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 27 Jun 2025 11:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751036695; x=1751123095; bh=s8UKFs0tWL
	bzf7d68XsOZFUAZcngbQO6E5TH5hROxw8=; b=ndAE2veDmNd37Q5ewa1VNW8S+f
	dR/dw3IqImwsYQmyanbtpe3LLq3Cw2WFhXehQsj5PRybfHHnkSekovFfL8AYFAiG
	Aull1Zpzz/+esZ6p+aiTIWxz1qX8dPhGcNln501pD0vgnvi1eKNej/7fMSCTfrlq
	KmN12JSJ3yZJRvyLaz0jAlrnmW561B/luVNAgF8sAb24OAn1yUByt7UV5kjxxkCO
	NXWhsBYem1yR5wuHSybp19pvw78OLgX2KSaNyAS0zJEo7q/uh5eMecA5u48uWn75
	QOC9D09rfmlWtl7wJR3LrUxJrlG9OwijtcAdTg1PeimrsgZ96CdHmIw++0Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751036695; x=1751123095; bh=s8UKFs0tWLbzf7d68XsOZFUAZcngbQO6E5T
	H5hROxw8=; b=CEtvVG5P7HPmrBRiFmZIpxB9ejunA4/UxcuFx6ZA4eyv/cpy4w3
	EHduD/5v4JGvgkS+urlxHm7VxGQnFI0KbXw33KqSFhG2050ReuP81fGwhUbRG/H/
	x6wklBmeshEnq0Efr2kXba6M5oQaU+LDmKygPKRmj+1e1t2tmVrAK9f0RD6jPRt8
	xpSYdhDIIXh5YGFmWM0prO5cW7O+uLiVuQISXnsj5V/sNXJhFjPfVOlT2Aoi3naL
	2cNgAp5FzI3vZEOdg37RN6g76tjZ9UIGdczsMDsFeg/TIiJZJnpR6oidp3r06Nt2
	WUqzYeiBl7/hQSqAap12nh7Q8mnk+G0WKHA==
X-ME-Sender: <xms:F7NeaBOFVUUKlMkwLgQWJzh8H5TmOW0ZivcVwbiW0KwiKJx3J0jdXw>
    <xme:F7NeaD_XcsoP7BHdC20MUESLnm9xnBgsx5HRSxKR_DEVTmI8v7p2XddypEFab8kqA
    Fn_rWxfdT7KvHwrLw>
X-ME-Received: <xmr:F7NeaASYvGchGzIQpeg_WtYQAZy9NjxiLwi3-jm35xjy3llK0CT2hiVO76wer2F_Mmrqw6tcxyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffeekucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:F7NeaNu9c3z-4mOTWT5JWyVsbuEjrAr29d6EUDjPE05HIzkPJylqMA>
    <xmx:F7NeaJdcAibrRNGUcJk7lnGJbGAmYTw89O8KyPx9SzYM97zERrofdA>
    <xmx:F7NeaJ2ySxwQbY2Ehl-T7FktzoMeFkNdCk8bGjccBP4F0w3olZYFTg>
    <xmx:F7NeaF-sDVA4itAk9Snzezban8TEyVFZ0WCpz8OLFcgid0ekgBGF9Q>
    <xmx:F7NeaBFR8cC9_iipVrGjSqUKT2X-5mmlQfPjqgCUkfznJ6qq6GYQlUUq>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 11:04:54 -0400 (EDT)
Received: by sf.qyliss.net (Postfix, from userid 1000)
	id A4F35261C1A01; Fri, 27 Jun 2025 17:04:53 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, Petr Lautrbach <lautrbach@redhat.com>, Nicolas
 Iooss <nicolas.iooss@m4x.org>, Daniel Burgener
 <dburgener@linux.microsoft.com>, Dan Walsh <dwalsh@redhat.com>,
 eparis@redhat.com
Subject: Re: [PATCH 2/2] policycoreutils: use pkg-config for libsemanage
In-Reply-To: <CAP+JOzTCEYA0x11_XP+8=O4Yixh7UgpO+JhRPRz_jutfL_-GMQ@mail.gmail.com>
References: <87bjqebpre.fsf@redhat.com>
 <20250625104103.140498-1-hi@alyssa.is>
 <20250625104103.140498-2-hi@alyssa.is>
 <CAP+JOzTCEYA0x11_XP+8=O4Yixh7UgpO+JhRPRz_jutfL_-GMQ@mail.gmail.com>
Date: Fri, 27 Jun 2025 17:04:51 +0200
Message-ID: <877c0xfcoc.fsf@alyssa.is>
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

> On Wed, Jun 25, 2025 at 6:41=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>>
>> libaudit and libbz2 are only required to be in the linker path for
>> static builds.  For dynamic builds, they'll be discovered through ELF
>> metadata.  pkg-config knows how to do the right thing in both cases,
>> so just use it rather than listing libsemanage's dependencies
>> manually.
>>
>> Fixes: da6cd3d8 ("Support static-only builds")
>> Closes: https://lore.kernel.org/r/87bjqebpre.fsf@redhat.com
>> Signed-off-by: Alyssa Ross <hi@alyssa.is>
>> ---
>>  policycoreutils/Makefile           | 3 ++-
>>  policycoreutils/semodule/Makefile  | 3 +--
>>  policycoreutils/setsebool/Makefile | 3 +--
>>  3 files changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
>> index 7acd51dd..0f3d62f2 100644
>> --- a/policycoreutils/Makefile
>> +++ b/policycoreutils/Makefile
>> @@ -3,7 +3,8 @@ SUBDIRS =3D setfiles load_policy newrole run_init secon =
sestatus semodule setseboo
>>  PKG_CONFIG ?=3D pkg-config
>>
>>  LIBSELINUX_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs libselinux)
>> -export LIBSELINUX_LDLIBS
>> +LIBSEMANAGE_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs libsemanage)
>> +export LIBSELINUX_LDLIBS LIBSEMANAGE_LDLIBS
>>
>
> I think that we actually want something like:
> ifeq ($(DISABLE_SHARED),y)
>     LIBSELINUX_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D../libselinux/src
> $(PKG_CONFIG) --libs libselinux --static)
>     LIBSEMANAGE_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D../libsemanage/src
> $(PKG_CONFIG) --libs libsemanage --static)
> else
>     LIBSELINUX_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D../libselinux/src
> $(PKG_CONFIG) --libs libselinux)
>     LIBSEMANAGE_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D../libsemanage/src
> $(PKG_CONFIG) --libs libsemanage)
> endif

> As originally written, it is going to find the installed libselinux.pc
> and libsemanage.pc files which are not going to reflect any changes
> made to these files in the current build (I noticed this because your
> patch does make changes).

I see.  It hadn't occurred to me that selinux userspace supported being
built all at once like this; I'd only seen all the components built
individually, which is evidently also what Petr is doing.  Your proposed
solution wouldn't be compatible with different components being
installed to different prefixes, which is how we do it in Nixpkgs, where
every package is installed to a unique prefix.

> Also, I believe that "--static" is needed to generate the right libs
> for a static build.

I /think/ it's generally expected that if you want static builds you set
e.g. PKG_CONFIG=3D"pkg-config --static".  For example, a quick look at the
pkg-config autoconf macros tells me that they don't try to detect
whether to pass it or not, and in Nixpkgs we inject --static for static
builds.  Your proposal would also be a change in the meaning of
DISABLE_SHARED, which until now hasn't changed how anything is built,
just disabled things.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaF6zEwAKCRBbRZGEIw/w
ons+AQDO4/HOA8fj4pfuuyYXgznBq3gL0eyxqR6ip+XwzoeGDwD+Oa+aM2c4REKX
09NHz7hTtHDkRDfPvckSGoVKTVByZQo=
=SHlB
-----END PGP SIGNATURE-----
--=-=-=--
