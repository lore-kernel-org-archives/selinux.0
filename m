Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E568416D16
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103338; cv=pass; b=pnbJl7D7iSx4ZdHaYL0q9MgbwBCPTLIay/ZW79jdh3Vsj3fixu7f54ZKbOZQ+F05HiI3kqa+1IBOtgRedqolUjRK3IksoCl8XVXCN/wl8ZDJl5+cMQLyQnFyrX8qsXO1pyWnQDHx4RAg9iayHMbUJ80hClSWrgav3Sl8G/s/0zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103338; c=relaxed/simple;
	bh=9/xuXOmuJpXi+H1yhxqx90zx1niAH1uCL47FvNNJCic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9TfIFLKdpFkHVi/uZvw1QyDM1j8oMbPuiI8gLFKaxIKhEDoWq/ER+8YFHNqwJl3cxpSOypb5Bc4eVBvKou8lHa9geW7fzyEd78HpLUYX5SIT9gpBCxGerttCji69mRhSIguLp6dTIWvKqjfbRpkRGTASGgq7QLSyRtnX9BQxEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGvUAYXw; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGvUAYXw"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-396775c2720so63038771fa.2
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 07:55:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781103335; cv=none;
        d=google.com; s=arc-20240605;
        b=lak6fOcJaKU1nlgOc/l0HwGq2WGKDIER9E0e9gy7tCagyS0kg08HsNjFiK/091c6Gh
         5vpe2RPTxNYGELGtgCz1DqKtSk0Hehh0XK2UbiDdcs7okHgZnVBBwNVJQ5zy4YZnIFbu
         JTnO0aE3Y8IQyqDERDyJUy/fjK457mBYmRNpcO4zdhKVGMnSWFKomUc4Dnx7Vx/AmqJO
         fKLs/nhs/k+r8mvgq9Mdfj4MDUyQOGWiTwvA4lxhaWJfBwO1c4n5PNrDZXWn0PbkxVPV
         vtgimL7Q1gm/Vd02EVNn6475KlW0yPkLZeJgTqJ9iI/Xxn51UWrEevvHSnl9HNZboz5c
         Mw7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ad2T5RIw1xalK8G0vTYAfMF1b04rPSvdV2YTrIJcKls=;
        fh=X5vnZCWuErBCX3HK8iUwBuHD6/CaNbIp7PYXEJ+WOF4=;
        b=guZj+wcrt4OufGnDuSJXAZ30+tpV5EvkIBHTPMq1d/8tTzIXKex8P0kRnUM83H348s
         xZI1xqHwJzjPdbPoCoMWdbsSMeQJgYQuWmGbjTwg8qeA5we5IRlu7ZbZJRyUO4jKLJ+L
         BziLUDg+sLuefkj1h+JGvI4XAbgcm8a8Vla12D89O1on7uGGIr0GD6fIr/REbSx5FbRD
         eT7H+8o/BZ87bR8iyo4uFPRfb3H3PRE/kR1BsKXpLHbFi8ZmlhyLXSTjlATMq3pvE2zD
         5xkmXOMIBlovR7WDZdf9H1Hg9fpv9WS3NLUZQgxNIKaTDiCMCXIAcS2W4rRxWTW1rQps
         ekiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781103335; x=1781708135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad2T5RIw1xalK8G0vTYAfMF1b04rPSvdV2YTrIJcKls=;
        b=KGvUAYXwHm9QlaSe+u/vXkeLFWBsf8+GUITbrQL9kSzlwyX3UjaHVtX1zM84b1rY+b
         5gsDW9MOxG9B1B36wpTiFzkJq2eDpT45dodtJLrTDAFUsEllzhmxYoX3bSYI5xodKx2m
         vdxVLKev8ck9/aI6agesviqqGm5wSMP8bVzu484KX/6BgwjWijqCDlHf9JzOPxE/9/tK
         ZM9QNBBKenIP4ec9WwrfRenr6Zf9r1AKZ/l3y+0LqwA/huTmXlvRRVSn66sRqF6H5FVO
         q3NWb/fq8PRSdIXL3XKn9VJV7q0li1TrjL1Sr16942o4bECyYgdfTDUjL5YKwXR0KsZL
         JkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781103335; x=1781708135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ad2T5RIw1xalK8G0vTYAfMF1b04rPSvdV2YTrIJcKls=;
        b=azfJjJ35Soud0+SfpftIjLcf8k6xJo0sCE7mn4SQxdpJCTrP+bP0quyz7XDgTmxGM8
         3uL3OHcfq4s/OlNcKydv5HDXYILu1d73kxRES9QNctFtUPOHRI1nzjL4Bl+cXpEHa955
         jzzPlqCg6yNJRfTqBq3NA6jhuWCla1wGFC1DUlYu1pMIDyQIqO7wV6vOjkdaU6LbCcWa
         KEiG56VxhNjJKOweoA9ozOkePw/IAAyDo2EgX9ffyjc3M/UZIa9eefK5QDSBdVmoMeDW
         l9iBSU+D4yLGqnfLBTowSpxd3DJpx5WV0fdF30ggeqf9sWV9siBFczvSYIBu7BYgiQZ5
         RLdQ==
X-Gm-Message-State: AOJu0Yzy5GEU3nnJ/sqv1hAopJe/zRxdUHoWeGJUb7ZZLja1Z9yrTAc/
	olumtKcmc3GD471vRi+GqhNzoyFAn2KYeRIFX/b/jUqH77hUJYDljduDLlklCeT13F81PA7banc
	caWOAqyYtQJ/8Ktws9eEjDrdaonjayQA=
X-Gm-Gg: Acq92OGq0Nnw03fct33dFLL9LbogVNOzSsiab54jGursdTbtvZXAtYTfquNgSMN+0hR
	2bfAxYHWuLlQW+4Qf5J7lqTxn28CID0Otwb9Cg5D71UHIZ2JYW95gya18LKjvEBO6GjVvn7HOad
	5RyC7OrWERhYEAqiiQQN0SxzL5GvEsup1aRBtVMXof3m9VQCO/9kW8FYoc+jebu9t60i0dkVzul
	9Y1UWPEN8lsfvAxHTDcRr30nnk+HCDG98ZK4NQxQbJe0aP5d7SUk+u1dp26aeLiZPafD+mkGye5
	TnIwY9c2+QC58Y8=
X-Received: by 2002:a2e:bc88:0:b0:396:95eb:160e with SMTP id
 38308e7fff4ca-396d09940cemr78567661fa.23.1781103335363; Wed, 10 Jun 2026
 07:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610122735.5486-1-stephen.smalley.work@gmail.com> <CAP+JOzTmX6+-YEC67s3pcxsX6ixYa1HY4YLMdvEXWiTV4ich9Q@mail.gmail.com>
In-Reply-To: <CAP+JOzTmX6+-YEC67s3pcxsX6ixYa1HY4YLMdvEXWiTV4ich9Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 10 Jun 2026 10:55:23 -0400
X-Gm-Features: AVVi8CfsYOvzjfXbYp8GTz86Nj2mjnJltg2KqVFFDabdw-0Cx-nvtRA5lHS8WMg
Message-ID: <CAP+JOzS3KMacQPOrd7U04p6b93w-ZH=dPfoSo_ByE_S_gvZ8Fg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: avoid out-of-bounds access on zero-length lines
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 10:15=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Wed, Jun 10, 2026 at 8:27=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: netliomax25-code <netliomax25@gmail.com>
> >
> > Several helpers read a line with fgets()/fgets_unlocked() and then inde=
x
> > buf[strlen(buf) - 1] to strip the trailing newline without checking the
> > line is non-empty.  A line beginning with a NUL byte is stored but yiel=
ds
> > strlen(buf) =3D=3D 0, so the index becomes buf[(size_t)-1].  Guard the =
index
> > with a non-empty check, matching the form already used in
> > get_ordered_context_list().
> >
> > Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/get_default_type.c     | 2 +-
> >  libselinux/src/is_customizable_type.c | 3 ++-
> >  libselinux/src/matchmediacon.c        | 2 +-
> >  libselinux/src/query_user_context.c   | 2 +-
> >  4 files changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_def=
ault_type.c
> > index e2186a19..8955c505 100644
> > --- a/libselinux/src/get_default_type.c
> > +++ b/libselinux/src/get_default_type.c
> > @@ -38,7 +38,7 @@ static int find_default_type(FILE *fp, const char *ro=
le, char **type)
> >                         errno =3D EINVAL;
> >                         return -1;
> >                 }
> > -               if (buf[strlen(buf) - 1])
> > +               if (buf[0] && buf[strlen(buf) - 1])
> >                         buf[strlen(buf) - 1] =3D 0;
> >
> >                 ptr =3D buf;
> > diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_=
customizable_type.c
> > index 0aa790e3..992747fb 100644
> > --- a/libselinux/src/is_customizable_type.c
> > +++ b/libselinux/src/is_customizable_type.c
> > @@ -44,7 +44,8 @@ static void customizable_init(void)
> >                         i =3D 0;
> >                         while (fgets_unlocked(buf, selinux_page_size, f=
p) &&
> >                                i < ctr) {
> > -                               buf[strlen(buf) - 1] =3D 0;
> > +                               if (buf[0])
> > +                                       buf[strlen(buf) - 1] =3D 0;
> >                                 list[i] =3D strdup(buf);
> >                                 if (!list[i]) {
> >                                         unsigned int j;
> > diff --git a/libselinux/src/matchmediacon.c b/libselinux/src/matchmedia=
con.c
> > index 3e7544b7..ca3d7980 100644
> > --- a/libselinux/src/matchmediacon.c
> > +++ b/libselinux/src/matchmediacon.c
> > @@ -26,7 +26,7 @@ int matchmediacon(const char *media, char **con)
> >                         fclose(infile);
> >                         return -1;
> >                 }
> > -               if (current_line[strlen(current_line) - 1])
> > +               if (current_line[0] && current_line[strlen(current_line=
) - 1])
> >                         current_line[strlen(current_line) - 1] =3D 0;
> >                 /* Skip leading whitespace before the partial context. =
*/
> >                 ptr =3D current_line;
> > diff --git a/libselinux/src/query_user_context.c b/libselinux/src/query=
_user_context.c
> > index 0a5e8315..c2196de2 100644
> > --- a/libselinux/src/query_user_context.c
> > +++ b/libselinux/src/query_user_context.c
> > @@ -85,7 +85,7 @@ static void get_field(const char *fieldstr, char *new=
field, int newfieldlen)
> >                 if (fgets(newfield, newfieldlen, stdin) =3D=3D NULL)
> >                         continue;
> >                 fflush(stdin);
> > -               if (newfield[strlen(newfield) - 1] =3D=3D '\n')
> > +               if (newfield[0] && newfield[strlen(newfield) - 1] =3D=
=3D '\n')
> >                         newfield[strlen(newfield) - 1] =3D '\0';
> >
> >                 if (strlen(newfield) =3D=3D 0) {
> > --
> > 2.54.0
> >
