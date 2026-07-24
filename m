Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E2641D655
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902896; cv=pass; b=TOP6WFMgVzUVNhmr21sb4BTgeBU0BuIH1ngAl6Nt1/A2rSOswnP6FaCKzN4HUSgsJSdokkoMgZUcU/CIOpRIcsRGhKHeDBJDDNcuf+RNNBI31A8ptcF+XbRfzmzR+Pmg4VA3b6biWGfk7pTrSMb9gEx7Jk+wXVmufCV3pfVKJKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902896; c=relaxed/simple;
	bh=/iFzdwoO+3274JQ63nzAebyIT6RqGvxPN3nU7X5jw3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjXzw8RbZZ3NfNySopC0ggtKr2w/H3iaJUvOYG/tsuJHYHmps1/+lUwrleJgMHAoyEptHS0eEpg+NqKlLWv8r8YZr4HBI7A/B2R+pP91fmRLPzUICgmA593KQH5p/WLkW84pydkIQdyruuujDzYqex5SowGy1uVjEAOD4zhmd4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcwiIPjW; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcwiIPjW"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6aae244ef49so219409eaf.2
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 07:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784902893; cv=none;
        d=google.com; s=arc-20260327;
        b=gbmG7l2gI9XVqeMu4R/V7u+uSoevN/ULAa06y0NGptzrdPDfEqZcBqU27ixUqDLyum
         Meyz8FDzGGmtbdD0uzFISguln9RMp6etPzSA0sriqG6NPvPvK6w+PL66V7lBpxfrZvvt
         rk8KjRN2OswLd9jQA2wbWlbsq06WwpiSrnnZX/R/I6AMUWyBEFyHVKI+G7AIUyrC5tPw
         DMMKwZ/GnltIzlK99gxs5KTU+k1QgvA4ipON0FVhQ3W5A4kIqvZJy5n1d358dOmg1G8i
         PKQ+IDCJSEZChal3jEE5nj2XLHY5C0bXg0zjr9FD3JMTPfNXkto3pn5NDvn7VBkc/xBd
         HK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZlM5pgmpSW5NASekt1my/KuIdgPne7oM1T1n5ayTu3Q=;
        fh=o4EWA82M+vtfNglaTzMFhY8rIYTLnPpjxHW+AHnzuHs=;
        b=itsurw5iytoUOddYyOA6mVZq2C+TG2BAKjH1fPEbJC6uZ24WR3ZFmnJUomi787NGS6
         9i7sJ7z+1ZIISgY0ClWPAez3Xcu4kxke60QrTqG2vj4v2OT0gX7NZ71nsHFKsSZcoIAR
         7u1tobVNCw9R8zby/pV8757pfpVXH8e9cIdK/4TD8JFCD3CZ/K4pHjZbqVKH3uiZlTSM
         jryMKsa+1cLpClSqqwrIEq/15OI0rpPS4joSs40YB/5evhs96wEIMJpMaGOA7KXN6/p8
         lVuOjTuVJ0aq+iyj/HE4QBnSNTc5fGPHdLItpoTopD1QaM2CkhTRzE6sGElrzl/EKpVX
         7J3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784902893; x=1785507693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZlM5pgmpSW5NASekt1my/KuIdgPne7oM1T1n5ayTu3Q=;
        b=OcwiIPjWwMaLI0itoM/mCfShW/ThYUCBEjodxh1mi1E1GilXWtEcSTMSRVh6BiUFiW
         QeuRUzaU3Ls93UEhcHBYrJjvztjp4G0McmL2GqcJT8FqKFgYnLv8klmRMF4JodTovoTv
         anf0yjBdQVi0NToRNWgt/eqeH0+PGV/7VasnK8Fw7+hu4KzLInZ1l6BmVI1DJKNYw6Gu
         BVfCikcCWbEbs35GVDl//TnV3DN0zDeOXuzr5uDJI93rMBMeN37JVIt8XJjpkkqPEFOI
         09OxlhvWaNmIUl7P+7ybpyt69LyXOA6Dy0osvs82QYfgceNo0wIPnSXZiFZtVuiC4XJ/
         zE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784902893; x=1785507693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZlM5pgmpSW5NASekt1my/KuIdgPne7oM1T1n5ayTu3Q=;
        b=UQBRt0at5y9uJGS6bRy9YCVOfEf5SAh4lLHaVP3W6Hyn+hoPiG6PvLiMxvg1mtm9Z/
         E6yBHFm7CuLlkix1pHBBhoxJhmeyySLhHWXovL6/L/DWtjaMR0qO2EKi50qtiJ9O7yXE
         /ATsuR+ghjFe++dwTjZ6RhPUCfZk32N2Yw1OZDhc9Y9KvvdU5oOstyCYc/76FCVGONlw
         YcSt4rin7y8v5iRPmYsYp8iIouRzSCJG+8y1+ruIlOB/rgQRU8PRIl55PnDhsea7yDAs
         7LBKDl+G63Qqi91bLBgwuDliqSuuPEuCLbpumFFKfUv1AH6Yupq4Gl6t/NH4UAfy/CG2
         K7uw==
X-Gm-Message-State: AOJu0Ywz4u5Ck6ZCStz8nfQTZo1jjsWcJPAG3p8Gg6vkzyhszeK1qHFR
	y4Y001lN8BwD1Bi+5g9uFXi+2iO6wpuOayEaN45xfIUskeWbvLP6HfdElqMyYvtqi3C0VNJEUN1
	+7HY4sTB37zYjF4seX71ALeDYRr+HIN0=
X-Gm-Gg: AR+sD13uyQlUlqvJS/I52LkA2SqrLo7zMyVOJVbkkK3AhQObfLWgvLJHgN3ANtNiVcH
	L6sKqoRs/fqryj1ysxoThXoZJCUj3B+bX53JJth484V6VYptTRt/tgyj/MEl3GncHcp0ugwjG0s
	BweuvLpIm5IcrzzbAGMNdzqJkCVZ3E6yrG42ttQIeta5f/c1oK1AQk+uCse4QLq1PT5YQeOqCtM
	Aq+AvT5QDcO5/n43Jcdn7pkvA8e7aFtENn1ay77ktE9XwRlna6eApUmifkqqQ==
X-Received: by 2002:a05:6820:4c16:b0:6a1:8386:e2f3 with SMTP id
 006d021491bc7-6aad41a8592mr3973558eaf.52.1784902893370; Fri, 24 Jul 2026
 07:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720105606.305073-1-pmatyas@redhat.com> <20260721110839.431114-1-pmatyas@redhat.com>
 <CAEjxPJ7Bg8FV12YqHxOzHr+Z3za6M1hoCOV_OL68PJ1Jf23G+A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Bg8FV12YqHxOzHr+Z3za6M1hoCOV_OL68PJ1Jf23G+A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 10:21:22 -0400
X-Gm-Features: AUfX_mwkLZ8tZaSUX0UG8Ibmhc_yTvOXslZwu6PNLsuCTm-EB0zyP8JK0s_pdUA
Message-ID: <CAEjxPJ7oZ-t4g7f+mkBBFyWvU1i1fDCe3AN+ATnOMrTpuDDGgQ@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: add module package fuzzer
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 3:41=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jul 21, 2026 at 7:16=E2=80=AFAM Petr Matyas <p.matyas13@gmail.com=
> wrote:
> >
> > Add a libFuzzer target for the binary module package format
> > (.mod/.pp) read by sepol_module_package_read(). On a valid package,
> > also exercises sepol_module_package_to_cil() to cover the CIL
> > conversion path for module policies.
> >
> > The seed corpus contains a minimal module package produced by
> > checkmodule + semodule_package to give the fuzzer a structurally
> > correct starting point.
> >
> > Wire the new fuzzer into scripts/oss-fuzz.sh alongside the existing
> > libsepol and checkpolicy fuzzers.
> >
> > Signed-off-by: Petr Matyas <pmatyas@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged. Would also suggest having it call sepol_module_package_info()
to exercise that code path.

>
> > ---
> >  libsepol/fuzz/min_mod.pp              | Bin 0 -> 859 bytes
> >  libsepol/fuzz/module-package-fuzzer.c |  47 ++++++++++++++++++++++++++
> >  scripts/oss-fuzz.sh                   |  11 ++++++
> >  3 files changed, 58 insertions(+)
> >  create mode 100644 libsepol/fuzz/min_mod.pp
> >  create mode 100644 libsepol/fuzz/module-package-fuzzer.c
> >
> > diff --git a/libsepol/fuzz/min_mod.pp b/libsepol/fuzz/min_mod.pp
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..264bd4406bf94b1c0044d46=
d0ca82fcdc4716f88
> > GIT binary patch
> > literal 859
> > zcmb`FOA5k35Jbxl=3DuVd|J%Q*A+_=3D+~2MCyq;4dTjfQwu~Jg+OIFa^zEK*a~mbWhh*
> > zC(yS?b#DP+3;|pp)qMb9y%;ZdX?Yp1d{Q1=3D8^EZR_3@$y;IvDllTSJTW|Qf>?pS0_
> > zHBrrzoHHN0Jnz=3D6t<MgUaFAqvvv+Y3Wp+eUE^I&aR86ez;Ih;mqe31{=3D)Jy=3D*gJY=
M
> > z)YoZe5nJ0l^b4_C<_yiy`HMz`Zw0+SohO>SzP<k!{0FXMy?QKdaP72i-21Sn6|wj4
> > Fcmk%9EE)g+
> >
> > literal 0
> > HcmV?d00001
> >
> > diff --git a/libsepol/fuzz/module-package-fuzzer.c b/libsepol/fuzz/modu=
le-package-fuzzer.c
> > new file mode 100644
> > index 00000000..2516970b
> > --- /dev/null
> > +++ b/libsepol/fuzz/module-package-fuzzer.c
> > @@ -0,0 +1,47 @@
> > +#include <sepol/debug.h>
> > +#include <sepol/module.h>
> > +#include <sepol/module_to_cil.h>
> > +
> > +extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
> > +
> > +// set to 1 to enable more verbose libsepol logging
> > +#define VERBOSE 0
> > +
> > +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
> > +{
> > +       sepol_module_package_t *mod =3D NULL;
> > +       struct sepol_policy_file *spf =3D NULL;
> > +       FILE *devnull =3D NULL;
> > +
> > +       sepol_debug(VERBOSE);
> > +
> > +       if (sepol_policy_file_create(&spf))
> > +               goto exit;
> > +
> > +       sepol_policy_file_set_mem(spf, (char *)data, size);
> > +
> > +       if (sepol_module_package_create(&mod))
> > +               goto exit;
> > +
> > +       if (sepol_module_package_read(mod, spf, VERBOSE))
> > +               goto exit;
> > +
> > +       devnull =3D fopen("/dev/null", "we");
> > +       if (!devnull)
> > +               goto exit;
> > +
> > +       /* sepol_module_package_read() stores contexts sections as raw =
blobs
> > +        * without validating their text syntax; sepol_module_package_t=
o_cil()
> > +        * is the first place that parses them, so a graceful error ret=
urn here
> > +        * is expected behaviour for malformed input, not a bug. */
> > +       (void)sepol_module_package_to_cil(devnull, mod);
> > +
> > +exit:
> > +       if (devnull)
> > +               fclose(devnull);
> > +       sepol_module_package_free(mod);
> > +       sepol_policy_file_free(spf);
> > +
> > +       /* Non-zero return values are reserved for future use. */
> > +       return 0;
> > +}
> > diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
> > index 9376b6e4..08e06975 100755
> > --- a/scripts/oss-fuzz.sh
> > +++ b/scripts/oss-fuzz.sh
> > @@ -74,6 +74,17 @@ $CXX $CXXFLAGS $LIB_FUZZING_ENGINE binpolicy-fuzzer.=
o "$DESTDIR/usr/lib/libsepol
> >
> >  zip -j "$OUT/binpolicy-fuzzer_seed_corpus.zip" libsepol/fuzz/policy.bi=
n
> >
> > +## module package fuzzer ##
> > +
> > +# CFLAGS, CXXFLAGS and LIB_FUZZING_ENGINE have to be split to be accep=
ted by
> > +# the compiler/linker so they shouldn't be quoted
> > +# shellcheck disable=3DSC2086
> > +$CC $CFLAGS -c -o module-package-fuzzer.o libsepol/fuzz/module-package=
-fuzzer.c
> > +# shellcheck disable=3DSC2086
> > +$CXX $CXXFLAGS $LIB_FUZZING_ENGINE module-package-fuzzer.o "$DESTDIR/u=
sr/lib/libsepol.a" -o "$OUT/module-package-fuzzer"
> > +
> > +zip -j "$OUT/module-package-fuzzer_seed_corpus.zip" libsepol/fuzz/min_=
mod.pp
> > +
> >  ## checkpolicy fuzzer ##
> >
> >  make -C checkpolicy clean
> > --
> > 2.55.0
> >
> >
