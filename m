Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA0B3EDE68
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609216; cv=pass; b=n3HP+DBkST3OI20GHm9ig2KEOu1NGHm6ajIJchdmAberbaYcga8si4fG4+IAY8YjvhmrQPo/fmoREoXdSqlq17V11R+xmJrl5nboF2qD8nBMt0sDJ15TQlSeP9q71UzGlPOZ2c4gHUImW+7u6fj/aJis382sH8DNf7Fy4FoeQNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609216; c=relaxed/simple;
	bh=RsepkVlOQwK8tJflDJd+Bpgw+IpXVpQvgHN2zuwiyGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaqzF+iIlgqRiYVP6+nRh0R7YqZDqyzepc/53rmofHkRnyjr3Hz5mGm9vAqBu5Xtia7O0J6jg8DtGjeqBPLq2Vsg3OBBByPNyLAKI/f9aLsk156jvyzzJKlKtlNsG5hhRBHaPphukMSm7RilDBttpWe4hzUpfjniVECAqj4qiPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7LIrER/; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7LIrER/"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39378db197aso59768271fa.3
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 11:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778609214; cv=none;
        d=google.com; s=arc-20240605;
        b=S4pdQ9DUPg2Onz4NUfQTmCWnr5FumRmGhbjh74CghNzjSh5977qrpLmmkulSYWtfRD
         tq73iLkDMi32yQSMmvRy4QnTu1lhq4wnY406it/wWwDmspsLZVOvRemgMbnQzRn0YbqH
         oiRc67nwjDBj8exEXYxeZyLjXTSGy7m/ekjcsH1eIqSDKjdEmhA+xFwOLOdFnAgDwZ61
         tnLBh8uTE68XIi4ob1exQX2W1t++BBewdnMNSdMAI1vLsE6OgX5Bn7v+upix8kSqMgo1
         WUaQQuratxdMvdovTn0zTiRpybOiuoahCGD+n0QeBJ7pN7BzdBUDyEBdjCMIvUGbaXSa
         TOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P1RVcvH4nW/DRoZyk/ZmWs6zImOhmWezrI70+SM1q4o=;
        fh=bDTdOLWha1wSJ80FIQlGMR6lDDvw+8q6Rg7De9t/wfA=;
        b=K5SNg51LDyhy0K6fK6AoOEmro+Uf3nFXBSl/90FqfDlllkbXX6asKjKpB81GN63DJN
         Qbg1oVbbYg1O1HfLMPGcziEL/yR+wuKbhyA5ZZUD2wAmfTdqj61YWJzjFhkEkxh/ldJs
         K7RNh+XP+szeoA5xjlqqFNpTbdrZxRmBlWJJUm2mYuk7AhrNpHID3uj13fSo+50wmpj2
         +uT9AuJ6uFCZpMqJRzkNttqkcttcCvJBTTWCbIb/KbDAYXkZN/fndMqY9CRyN3suF4Fw
         pj9fm/rlfbpdiOXKbMPD/ymsQIedCb6WBqcbYP+7igwtMlcSmNa/on/IbGZ8QULWk85D
         uldw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778609214; x=1779214014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1RVcvH4nW/DRoZyk/ZmWs6zImOhmWezrI70+SM1q4o=;
        b=I7LIrER/vwOIbx/OKBjAHr6ShPAgx56IWASR7eQP72476EXVUNVM0n8pUMZ9Xp823S
         ti+he6wEAeg40QbiMTpPTIYbxVKwk1Ti9NJMLjg5ti5iSTFmjZ3hQKQkjQBj9Kq21eCE
         X6vfnLkV9l/fraWMsTgfC6xIFNjKpPg49jLUM03lM0GCS7WvZ4xxCsvoBIyGMC2+ibeL
         3FvayzJ9nbn64K+qEyt4w8S1aZXjjcD3V376n0XQWkIBeX4yh5asTz1gY+UD+OVMhegt
         cMZJBBPgzh8z1IuoZpPOu0GV3skJmYs+Gt3pKPAIFLzZH7kUmq0ew+YJKpUz5v7ciPqy
         U2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778609214; x=1779214014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P1RVcvH4nW/DRoZyk/ZmWs6zImOhmWezrI70+SM1q4o=;
        b=IFRUwhg7IjyHoGRCe/6p/6rr/rgHKpNGXF5J4Jmd6O4WK9hhDgcGmrfjlnd/zzBi8o
         J5QtvAWB8llSQUMI8r3Dxbrlnr4zOdFdBFWCL6lTQDD379eGJIfzYd0fOT2/3r9ChpF5
         tVY2THaz5FydlxMsMKrnVX6YFSV8XjwTIdOGEYfCHMczrNwvPExl1iuDr9m0w0H5rwuI
         ICcing8WuPqVWvCpVInS8t9fXWg5ANclu2zOrL839hQk/X5hFFlfxygpMTf9iATnrsGs
         rRg1y8PmwADE+DhjKtIxiqA5o1mjW+FG11IU7DARitf/xw/N4+mNWmUq430aZdFPL05E
         gWOw==
X-Forwarded-Encrypted: i=1; AFNElJ/Avk/h3zJ7f5VFnXZb+kvywd1Tni5Lpr8zfnOsDOxpZwH8W9ydf9ne6Hwlhf9LzyWnUySc5asb@vger.kernel.org
X-Gm-Message-State: AOJu0YzxqkW++pEWI5iRILl6ejKVivGWwGeX63valxk4Igfqooi0c/+Y
	jCYcE9xrrI/iERxoeSGKT4E+L8NgwtW8rlxxc23AguAf5plUIA6BNpXr+9Uh9kLffEJo1u8v9VO
	+ehp+CfFMSuoV05UVR/Bynjx1RB+LLa8=
X-Gm-Gg: Acq92OGgw4v9B/WjSkmI9kX0haBBPHiH9ZuIi8iQHq0ng/+2l9+TrkYOs+XB3pd22R9
	8WPz5RANhb2025ctDYAjbAQSfrXDnf8+B5WLgEYVnGhnU61bYVvF9fUchGRHTvEXtCLPdZ3nkSI
	JD0nJVVRM7BJiBWANwUy7Idbx49rX/X+mihQOW2kcApQd/1b91tsCNEYhorjc1LB9rNtIBof4x9
	QLeMXIjp06gBzrtsGJ/EgrB2x7f0S7v9JSMpTnAhBajxHRWd2Y8Kcgvyjez1u2fX+CttGAZoq3U
	zj0vGG9eNUXFuyw=
X-Received: by 2002:a05:651c:f07:b0:393:a639:49fd with SMTP id
 38308e7fff4ca-3944b586188mr7841fa.22.1778609213383; Tue, 12 May 2026 11:06:53
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330015148.1482594-1-tweek@google.com> <CAP+JOzS0p2d=43EiumHpe9ESQTjaYuk4tAhyD8Er44p7HUAjgg@mail.gmail.com>
 <87pl3b8o99.fsf@redhat.com> <CAP+JOzRNDtiagk0AG_WjX_weaNLJetTrHd+CazTVWuv+knhzaw@mail.gmail.com>
In-Reply-To: <CAP+JOzRNDtiagk0AG_WjX_weaNLJetTrHd+CazTVWuv+knhzaw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 12 May 2026 14:06:41 -0400
X-Gm-Features: AVHnY4KCXIK7PYjwBatZeyFefnR_J_pIdXutIICdim67OVeqKqOqraHCvEt9rhE
Message-ID: <CAP+JOzQSwABaGDUZGo+NK+_zqpm0e+0RONz+siFJcTZaC0oN1Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix off-by-one error in cats_ebitmap_len
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 9:47=E2=80=AFAM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Mon, May 4, 2026 at 6:25=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
> >
> > James Carter <jwcart2@gmail.com> writes:
> >
> > > On Sun, Mar 29, 2026 at 9:51=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek=
@google.com> wrote:
> > >>
> > >> In cats_ebitmap_len(), i-1 was incorrectly used instead of i for loo=
king up
> > >> category names at the end of a range. This resulted in an under-allo=
cation
> > >> of the buffer for the CIL representation of category ranges, which c=
auses
> > >> cats_ebitmap_to_str() to fail its safety check and return (null).
> > >>
> > >> This fix correctly uses i (the current bit index) to look up the nam=
e for
> > >> the category at the end of the range.
> > >>
> > >> Proof of Concept (PoC) Policy:
> > >>   class p sid kernel class p { f }
> > >>   sensitivity s0; dominance { s0 }
> > >>   category c0; category c1_very_long_category_name;
> > >>   level s0:c0.c1_very_long_category_name;
> > >>   mlsconstrain p { f } l1 =3D=3D l2;
> > >>   type t; allow t self:p { f };
> > >>   role r; role r types { t };
> > >>   user u roles r level s0 range s0 - s0:c0.c1_very_long_category_nam=
e;
> > >>   sid kernel u:r:t:s0 - s0:c0.c1_very_long_category_name
> > >>
> > >> Reproduction steps:
> > >>   1. checkpolicy -M -o poc.bin poc.conf
> > >>   2. checkpolicy -M -b -C -o poc.cil poc.bin
> > >>   3. cat poc.cil | grep userrange
> > >>      Before: (userrange u ((s0) (s0 (null))))
> > >>      After: (userrange u ((s0) (s0 (c0 c1_very_long_category_name)))=
)
> > >>
> > >> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > >
> > > Signed-off-by: James Carter <jwcart2@gmail.com>
> >
> > Was this supposes to be Acked-by?
> >
>
> Yes, sorry about that.
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > >> ---
> > >>  libsepol/src/kernel_to_cil.c | 4 ++--
> > >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_c=
il.c
> > >> index 06cf4498..49040ae4 100644
> > >> --- a/libsepol/src/kernel_to_cil.c
> > >> +++ b/libsepol/src/kernel_to_cil.c
> > >> @@ -1018,9 +1018,9 @@ static size_t cats_ebitmap_len(struct ebitmap =
*cats, char **val_to_name)
> > >>
> > >>                 len +=3D strlen(val_to_name[start]);
> > >>                 if (range > 2) {
> > >> -                       len +=3D strlen(val_to_name[i-1]) + strlen("=
(range  ) ");
> > >> +                       len +=3D strlen(val_to_name[i]) + strlen("(r=
ange  ) ");
> > >>                 } else if (range =3D=3D 2) {
> > >> -                       len +=3D strlen(val_to_name[i-1]) + 2;
> > >> +                       len +=3D strlen(val_to_name[i]) + 2;
> > >>                 } else if (range =3D=3D 1) {
> > >>                         len +=3D 1;
> > >>                 }
> > >> --
> > >> 2.53.0.1018.g2bb0e51243-goog
> > >>
> >
