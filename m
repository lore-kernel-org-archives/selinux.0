Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA0C2F363F
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109080; cv=pass; b=ftFMSePJ0lV1b+l4ZROJ0TxXEQKkTfjWhqlHlbPabIkJkArabZXLgXXQv08DZCSymAfJfjNPxFB7fniKG1sFOxtWgPWEqO14P7h++6QKqEK5nYJB0qyo8CS+AXzhrLpTQsX6tPeOjxQ+eukoIkNNoPDx3vueQuEHaSrjyxNcDwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109080; c=relaxed/simple;
	bh=mjg3tibAAVHnPY8KVFV956l+ZrAay6ma8BKVDIwf9sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnWRU10Z2gBuEDIusJfYjK9nE/Aqx8Coo5OcCHSsVRX9U64rlXejZTzSTSZ/Qfu6D1HaT0NxxNxeH3Wwe//Ks7Axg7rZmbddVYa6SjlYE5BdPj8xlCaGG0pvy/lvj2Ueu6WIQhfVGEtpYSELdzBn8ebtSjSqo1lRm0nV8n1uszg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8CY80oh; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8CY80oh"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so945067b3a.1
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 05:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779109075; cv=none;
        d=google.com; s=arc-20240605;
        b=Z+vPV/l4il1T/eLKO3Y3odsFFKXmMDr0u+1bsGu1NJLQkjcapVF1lQ7PXCs/iPxPSA
         iCqWhAMCTv+0leGDb1hS3CpGZVpFc4pBoJXud3M0jleq4eDaaMDtSxZ5QN/5LTqLvBuQ
         ULN623fy4q4EIPYzZeEyS35P/oFSIegGkem5+jZYykvDNS3VGfCsOp/CWQJafHPdmg5O
         j9gt+tOUi9RnE7AtW0M5gifpzZq1yfHn0G6O75DTmdbjT+k6iZIjAfj4N3ALMpjZ1rUh
         6/xjADBOagORxwkgBYO01BwgzZWzQebBpod5NaHmUAGwR6lZng2NTDXkOeV5afZecyaB
         C+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C89otC4ydC5e5Jrdc7c6S/9phLgrH2K4vpTWWkMhg4g=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=UBSc9D1bKkCrd0GDxPDiQQ4aaW3yOYeoJkqf0ZZUj6B3ls+FafJCoGWbWZiYvoaGHm
         aixOhQLAjAvyYQS+0C/Dkad7+15i5L+RDlGNKZb3TzuKrO8VKu4wmG3oMpLD5cGPSpCo
         v/uq2GEVALY/tC64xxFGcI2sK9b2MGtp1LSAmD8+jaMh22Gs1m8/nKFx54q8TJHeOLcE
         qf0fxgtRWlD2lNMRY21xVvOo1217wLS4xcLiJ+wGsVOJpiW3ZLQU0mAYBDfpsiZvTOXH
         hZSrJCOQ+qVg/ypQQPI88mAQtNBJHGUzBYxln4lqioX5niZRu5EQtYEkOUVqVXymYbtD
         oc6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779109075; x=1779713875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C89otC4ydC5e5Jrdc7c6S/9phLgrH2K4vpTWWkMhg4g=;
        b=N8CY80ohmgh40GEVuOx4/1KZnoOF1B2u/bQiVuq+B5yUlZJLYaMyz10RR955Tj9it/
         utq9uL9Ydh5xTMTH3JHyDdO2PWfKtdxl7DltXMw3IcYsbHJn8hzhprqxdQmciySAHjBX
         c8N35c1HaPpzwKDHrJDs6aUgbnlpxZ3r51takMtG+BFHJu1s3N/8eekQpLhKZeum7Ybd
         x6AHwRS2Rvum1xXosnRoNjM0M5vUHWobGlN1M53H7OjYnGoDCpTUAJmGYn2+pLsPt3Zm
         2KJtZTkidOEr2Jl5dp/M6Se6DD8fLB2xuOT0WSyh7bQRBfTIS5VoiO3vQOOawrXcKQxj
         kNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109075; x=1779713875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C89otC4ydC5e5Jrdc7c6S/9phLgrH2K4vpTWWkMhg4g=;
        b=Vom242knttVXua0YkWUZcj2yP+4xPRDRJBVOfQgEtAdE+MJRfRrvQlTl5bpugIGhCc
         dnwXp8fNYH0vmpOzbNAWCIrPdA5bNcNMVDEzn+QcumBYWtBOjwZuYH21QWMHiWSiy2qR
         PTaLj0I38Jhy3mSGhPKHjkCh0TCCI29hg9xihvuCCUfEktyFzES0XXkVSed9pwrS5D4T
         E27xM7ygFRhP+00fjcaNlk8eyE+sCoICZfqDu54s7UEKIvlNkkFdsqeTxsungw14gAM5
         Y7t7BFpAfKQaXnrqva+WqIU3/1llZ29jVOMp+az8wk5KvAZ0U9CHVMa8rXq4m4Iyex9x
         fPYw==
X-Gm-Message-State: AOJu0Yzq7Z8Jkwq7rfnBQTAYvPh9E4xySgCbnwkVxDVQT0UeGx8zSPGv
	gHtQwUPuewvIMWjV2Xfay+Z8V66XCK/0FxdAluuQDS73k0GKW1MsEmkZ/1xHKtKwiyQFcLzb2V8
	jCP3u9xHNw70qsqu7vb9HMkschHV7Sxs70A==
X-Gm-Gg: Acq92OFWPp8reurbAoD58kk2594a5kNQ+Hrk3buqQ6wN3fcu6Hz47caixYqn4NL3LJy
	wtRb54AR8Hm4T2XXdFIYPMAUDBaRiaRiTGhQ24dSzg2IH1ecpDJKugsjy2lXwrZCLegKdyB7D2I
	EvmXAWShfoNF4JjTKIjos34ZR/dchP5eCKyfl8IfvslepfT7dTW4RxVzMxRCOK6XEpJlKiwCqzq
	ehEyqKtZvQp7+FXvzUzD7eTMk1+BBrwx8nUfWnGwDvefa5Adg7wdjMw4nsL9i8LVthSQ9iN4kGS
	Jp29bVZEhz3H89VraQ==
X-Received: by 2002:a05:6a00:14ce:b0:835:36f5:17c9 with SMTP id
 d2e1a72fcca58-83f18d5c033mr17129418b3a.2.1779109075474; Mon, 18 May 2026
 05:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515120907.10699-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260515120907.10699-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 May 2026 08:57:44 -0400
X-Gm-Features: AVHnY4L-BH2ga6TJHYrKKcINZkhrlyYz0NXTgesgHmQXB40xTVvT3to16_LuLnA
Message-ID: <CAEjxPJ7FRta5Y4pqqCvwfzFoZ-Ej8fBVhcFMqYEGVY7u5iE5SA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage/tests: fix const correctness for test_utilities
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 8:09=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Fixes the following errors.
>
>  gcc -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror -I/tmp=
/destdir/usr/include -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-f=
ormat-attribute -I../src -I../include   -c -o test_utilities.o test_utiliti=
es.c
>   test_utilities.c: In function =E2=80=98test_semanage_basename=E2=80=99:
>   test_utilities.c:357:27: error: initialization discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifier=
s]
>     357 |         char *basename1 =3D semanage_basename("/foo/bar");
>         |                           ^~~~~~~~~~~~~~~~~
>   test_utilities.c:360:27: error: initialization discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifier=
s]
>     360 |         char *basename2 =3D semanage_basename("/foo/bar/");
>         |                           ^~~~~~~~~~~~~~~~~
>   test_utilities.c:363:27: error: initialization discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifier=
s]
>     363 |         char *basename3 =3D semanage_basename("/foo.bar");
>         |                           ^~~~~~~~~~~~~~~~~
>   test_utilities.c:366:27: error: initialization discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifier=
s]
>     366 |         char *basename5 =3D semanage_basename(".");
>         |                           ^~~~~~~~~~~~~~~~~
>   test_utilities.c:369:27: error: initialization discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifier=
s]
>     369 |         char *basename6 =3D semanage_basename("");
>         |                           ^~~~~~~~~~~~~~~~~
>   test_utilities.c:372:27: error: initialization discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifier=
s]
>     372 |         char *basename7 =3D semanage_basename("/");
>         |                           ^~~~~~~~~~~~~~~~~
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  libsemanage/tests/test_utilities.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/libsemanage/tests/test_utilities.c b/libsemanage/tests/test_=
utilities.c
> index 70a76fe7..d5d56d94 100644
> --- a/libsemanage/tests/test_utilities.c
> +++ b/libsemanage/tests/test_utilities.c
> @@ -354,21 +354,21 @@ static void test_slurp_file_filter(void)
>
>  static void test_semanage_basename(void)
>  {
> -       char *basename1 =3D semanage_basename("/foo/bar");
> +       const char *basename1 =3D semanage_basename("/foo/bar");
>         CU_ASSERT_STRING_EQUAL(basename1, "bar");
>
> -       char *basename2 =3D semanage_basename("/foo/bar/");
> +       const char *basename2 =3D semanage_basename("/foo/bar/");
>         CU_ASSERT_STRING_EQUAL(basename2, "");
>
> -       char *basename3 =3D semanage_basename("/foo.bar");
> +       const char *basename3 =3D semanage_basename("/foo.bar");
>         CU_ASSERT_STRING_EQUAL(basename3, "foo.bar");
>
> -       char *basename5 =3D semanage_basename(".");
> +       const char *basename5 =3D semanage_basename(".");
>         CU_ASSERT_STRING_EQUAL(basename5, ".");
>
> -       char *basename6 =3D semanage_basename("");
> +       const char *basename6 =3D semanage_basename("");
>         CU_ASSERT_STRING_EQUAL(basename6, "");
>
> -       char *basename7 =3D semanage_basename("/");
> +       const char *basename7 =3D semanage_basename("/");
>         CU_ASSERT_STRING_EQUAL(basename7, "");
>  }
> --
> 2.54.0
>
