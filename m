Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78922101DB
	for <selinux@vger.kernel.org>; Thu,  4 Apr 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247788; cv=none; b=iwICrah9Gz1O8dG+OKC693PMPnzhhivhNjRlHW/oVb7CqEpE6P6LAOlZeIzaI+3rhvZx89OQAz3sm2NQlwq6bZ6qJ/OHhfJcdYkm9iryAdUt9yuFe3CiOyKV4h+6/XTGU/EYOMWd5wFsgYqYpQ6fk0hkisKcas5TPMdEn10YLoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247788; c=relaxed/simple;
	bh=aZvVNt8xYJrCJrmAd98etx0MXP6KwOuYZO8IAbJIWVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCd9dI4woLIZ13BX1Ug41I6C1+GMGO7NwoLMVs0sUbdYqNA4xaX7PdnwjNHN87GOW+o+Tkwcyh5u5H7CfRLuSstIxwJSs1Mvar2A0PI7I/O770EiDl1m4CS8CahKyCjyQK8xP6z/z8ChLeFGT6vzvFzET78QDNhwx2H4CdiPS+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ+POrX0; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ+POrX0"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbbc6e51d0so644376b6e.3
        for <selinux@vger.kernel.org>; Thu, 04 Apr 2024 09:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712247786; x=1712852586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkRtJWJLbX8A0kWXt6plgiIOMd/RPm3PO6Fz+z8Qs+c=;
        b=KJ+POrX0RL6V9NKwFgJf9dsltJtkCRRBsuDAIYwr7uXnscIpyRMd2CoStXXVWTAtWC
         9veSxcWkRNN9cvPBGFPcoverMajeEujYNoMhSqFBhydQCPp0bTNh8p9sXHmCmyUT0sj1
         3s7BvI8SY3tRaa3kCi/lPtYTCuG+MqB0fPFSc2wsSz+PLJTPCjurgipOLOOxs1QkWdO9
         FmA/2mdbF9krqDUBYA3QlDoqrMXu1tDxHl+fxdi2kAXc3yBOkkRXjXo8yetoNMQ3+UEi
         Lb0i8FLDiGeF10j7mf0WsasxWvPVPRqewjpOqyzcwA4NxFzwsNndZ4RUnuAdZheiordM
         gqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712247786; x=1712852586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkRtJWJLbX8A0kWXt6plgiIOMd/RPm3PO6Fz+z8Qs+c=;
        b=HeYGAhzYKh6OogCBwKGZIjnUaZXfdXDo+YscBMpKtIrQzOY6zzMpaDA9i8ef8veBZX
         BionjJ1vz7uLQvXF0+PojP/mD+4uie6zfFE6ZY5XBF7K353RAISKa+NvFoUoGyc1x8Rb
         kQjMBtSj1QXiuyhG/wNWSrQjwzU8zAwkCQ6+l8BWviINPIqAh47u36UzXwQONjLrBxEl
         SUFcDVu6zIOW8sCU0JKwrHBmergsGNJ9d72ixPoIKAEQffkKqR/ZPZUCWxoTs2CmIL2I
         6yXx//H+8SqwV4eOjrWwD78KTZlot9qSO32rBXxO8N2nws12OakTj3W5IwLgupU9cHQh
         Nfdw==
X-Gm-Message-State: AOJu0Ywo6A4rXiC4wwNQy0cjlguwLXUbSInSyApXxnrX6AOcyhbsPjuh
	TWxGdbJQNZohtAPrDaA1pxEtRmmmkQGFjRxkCai/xfbTPJ9HEglFyAaqDJM1V3USa7CN4/4jZyA
	1LV+hZwhjSxJV7w6g0M62OnH+T9ssgmes
X-Google-Smtp-Source: AGHT+IEVzD2Fg7cUK5AbFlayjy5wxSis3DcEhuGviKvkifCunZuU7eiKhDRGTzroOMnsc7JQg+7S9/l2drfcxHLngP4=
X-Received: by 2002:a05:6808:1183:b0:3c3:e4c7:d6c1 with SMTP id
 j3-20020a056808118300b003c3e4c7d6c1mr3374624oil.3.1712247786360; Thu, 04 Apr
 2024 09:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402152925.99781-1-cgoettsche@seltendoof.de> <CAP+JOzQruPoyL1YLLmfRR-nxTGGbXb91Zc7q__jreFMty0v4Fw@mail.gmail.com>
In-Reply-To: <CAP+JOzQruPoyL1YLLmfRR-nxTGGbXb91Zc7q__jreFMty0v4Fw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 4 Apr 2024 12:22:50 -0400
Message-ID: <CAP+JOzTukDxnt+ckOm3Q6cb1vwASM5s+KoJEEC2tC9qDqao1vw@mail.gmail.com>
Subject: Re: [PATCH 1/6] checkpolicy: include <ctype.h> for isprint(3)
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 3:35=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Tue, Apr 2, 2024 at 11:29=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Include the necessary header for isprint(3) to avoid an implicit
> > function declaration:
> >
> >     policy_scan.l: In function =E2=80=98yyerror=E2=80=99:
> >     policy_scan.l:342:13: warning: implicit declaration of function =E2=
=80=98isprint=E2=80=99 [-Wimplicit-function-declaration]
> >       342 |         if (isprint((unsigned char)yytext[0])) {
> >           |             ^~~~~~~
> >     policy_scan.l:36:1: note: include =E2=80=98<ctype.h>=E2=80=99 or pr=
ovide a declaration of =E2=80=98isprint=E2=80=99
> >        35 | #include "y.tab.h"
> >       +++ |+#include <ctype.h>
> >        36 | #endif
> >
> > This does not currently break the build cause -Werror is stripped for
> > the parsing code to avoid breakage on old flex/bison versions that migh=
t
> > not generate warning free code.
> >
> > Fixes: 39b3cc51350a ("checkpolicy: handle unprintable token")
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these six patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>
These six patches have been merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_scan.l | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index d7cf2896..62f28c11 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -22,6 +22,7 @@
> >
> >  %{
> >  #include <sys/types.h>
> > +#include <ctype.h>
> >  #include <limits.h>
> >  #include <stdint.h>
> >  #include <string.h>
> > --
> > 2.43.0
> >
> >
