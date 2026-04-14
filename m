Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE8A1FF7C8
	for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188175; cv=pass; b=iVJKOlgGIkKFy8Asml3JcWrsAR9LWNaszQv7V4jGDWWYl4vaDiPuUz3lljsFDWWdFIUlDpx1WR+7R19rRQSJicO4CMXXiJStjy5YbVrTwEEHa2WoViVXJnwaOQaXn5cLns7rgAcLYhYGuwbdH8QJ04jKO9dgDe9XKqVgfK2Vyc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188175; c=relaxed/simple;
	bh=kvCyd8kBnsltpXayPwWH2jMNe+55z7BCIzdbGCTekv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmG4T9LEKuSEAfYrdoZwyTWPDSWoQUirznG5P3BWmKExIU0ZUbC1QbZ9QzyXVZWfqvxI632Ynt7u0sqGoakPtGYGdI9YdvOfnI300Xc5yEpAUcCs0ryU5P7MmoyBL6FPQS3Dk0XesVcGZldu2tPkQJKfXXwvY7TwnL9DvfbRN34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sKMCzho/; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKMCzho/"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38e7c3a2deaso20147661fa.2
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 10:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776188172; cv=none;
        d=google.com; s=arc-20240605;
        b=JcJ9OdF8uPBK2dtAIdv0jn1QswvwkjIlB4w7o/fcysY+O0sr2VSlPOrOKK3oihTeis
         YoBRb6vk1NprKl0P4w+yHrnINT+7WfxtuKLPTCFjXcnoWiMMdDdK0QDjz+zaYFRCR4jv
         o1zOThGtYMXcKQTGMFrEVWNxNNy8g11Kb7T1+s15tXnyQu3nMrM2thQk/MX8HlkGHuSk
         LIqV+6+t6UijFQULsiKleyL/DJ4TEcICfkIa7nn4oI/MCqm7+KROqlBE7a84Gz4D8XuH
         2KyOB3yIuMzWAQwv4O9prNwW1tMV1NF3w4vsGxVYWc9kVZBHJrdX0aGk08IIVdTS3kt0
         G7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U5sP+UBRm4y14HNkk2/jUsIoyOMycak9HFVNylxsIKo=;
        fh=nwsqwOmSYbkRgz7zW0weM3MmDX4ivPZDtWjpngAj+NA=;
        b=ibd4wmazo3YNFRr4KDiZ9joOudQE8TfBd7AqH6KBT+a5f2dL8TPHqmGbTvXJIUqCJn
         x9+5NRHJVJqMXxG4nJcrymX/U+hUyPmpkoKdDQM2x64WJldmr13xdPqw1n08twP64OhD
         d09YmHUtQoO5Lqp6XHNbz0n0hpCgvtguoa5R009HDshvBxdUnIZgDyxiema9+RNuYXop
         4aXPzTvkFqw1wErawapOKvsLaKO+e+YQQAa+EgdlLbapHahQsXbczimsmglFiW8wkwd2
         3KPVImCVdWcqb0+fLFvFYLKpJsaWAA5P10vrhqLK59RAcdRP9dUcj6rg5k4P20+SVW1Q
         GYGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776188172; x=1776792972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5sP+UBRm4y14HNkk2/jUsIoyOMycak9HFVNylxsIKo=;
        b=sKMCzho/c0i/4ciIs5Mfsa+BQw9YxwEzJQH5LGEiYu5yBxmX9XcyDAwYmVWOfRt62J
         xjfZZbbshjF5Mww4Km44NigkOp8GwQcSycsljfyyl9oh4FrcERq8/fvu6L2qoSmQKyKZ
         KjNMHJoBPGvLvJe7P8Cn+3VXuQSGTfkgj33wRyDlzcaO4uXPkk9Lcbb8fBwr/S9ye2CB
         aM9naJImEIOJX6vcJv/fRreaKQGkjJC779/X6WmFCT73dupcko/9QYnZEUMIYrKft0yf
         RTqKOeYo2SCgvAY7DMON80HqQ7QwBPtRYWEFm1BHdnttW4Lr9lbN/uzY36sd0wEYwt0/
         7QPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188172; x=1776792972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U5sP+UBRm4y14HNkk2/jUsIoyOMycak9HFVNylxsIKo=;
        b=IyT859rqehLLuohRoqPcm8RhnmovFJZth2VSK3ZHrT3OxSlU1qGEcGYioFdSDd/QXZ
         PivEndfPI1+MKBgsDn+2Tkz2WjjAoOxhQc7UwEXnXRdnPaibNKiZ2g/u7G5aRr4LoA4S
         Jj0msLOz073MomYHa1WbHHHnR9UQ1UCaikfmKcbQ8fafx9QGyXBkMUF2eCe6dvlYzwcR
         8VOSYuWjXVJvXuyKK9SuApZy1QrszCr7pyeEuUa9hg1r3atb+1WE9GAhRTsILrPgpxmx
         j+gbWpZx4XCFLIxGdq5mudaCN2qMOaBLV4m0jRg8ZyzgKFOqQ3z6Mj2ELIEDodXnGua3
         1jvA==
X-Forwarded-Encrypted: i=1; AFNElJ/1TU/zughNRok/kPXvyVEGuQx68GHp0iBvhac0S46kmDQbE0UEXlAkGf47liUwZFnOzG8T61TE@vger.kernel.org
X-Gm-Message-State: AOJu0YygQzMr2WFtBgJYYJAIZv3omO0LCOBa0byZnLyuzjm4L0l4gOzT
	t0A3Jq63T59zk2tfaqx6r2gstUZynl2+i70fVwXbKHre5THiBktluSj6lEBbBHXfAzkH/wA6wlL
	l1alfRedxetpjskMdmfa7OXCDwBSc6X8=
X-Gm-Gg: AeBDies0XKhR7s0n7Gh+OkZ1jTDmKgNCy0rxNo6nOrnqE9Kyj2LaLtkf9usjOZk7Arn
	9nyyMr3oKNal2HwRpLE9guM1brCMs6x4VNH+28atZkQFu+6KnwY8K4UXIRZUAYJXY1F3hBhbc64
	dV4L8487nbZA9QRvXxq6FIWWKy1GLZDi7dAuETLIGxy7pqTFR6EUn8O8v0GZfuGipYWVo260wdn
	tEhOfdKHokRifK0qxORiVaGjk6tofdUvPiu2VtZ/EG2jhD4jbADLn+BhTyAu/b7EnGur+9yqscx
	VPJC
X-Received: by 2002:a2e:8092:0:b0:38e:88fd:95f3 with SMTP id
 38308e7fff4ca-38e88fd9883mr14880731fa.9.1776188172072; Tue, 14 Apr 2026
 10:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311042511.2975567-1-tweek@google.com> <CAJ2a_Dd5JT14okamnSXq20pooM66RZ0HxmO97d1X2bZXJLXBGw@mail.gmail.com>
In-Reply-To: <CAJ2a_Dd5JT14okamnSXq20pooM66RZ0HxmO97d1X2bZXJLXBGw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 14 Apr 2026 13:36:01 -0400
X-Gm-Features: AQROBzC38YX9h71LtGdtng-caIAzEQ926Wi439ffOFaWgYLieMwlX4z4qJHSqRU
Message-ID: <CAP+JOzSq71Ty0Eb1HdxiXB1YeduL9DuuYaYKe2istsuU4rh8_g@mail.gmail.com>
Subject: Re: [PATCH] libselinux: do not log on unexpected escaped character
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 11:58=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Wed, 11 Mar 2026 at 05:25, Thi=C3=A9baud Weksteen <tweek@google.com> w=
rote:
> >
> > For file_contexts entries relying on PCRE2, there are multiple escaped
> > characters that are valid (e.g., \d). If such a character is identified=
,
> > a log message is emitted. While this may have been useful for debugging=
,
> > there is nothing actionable from that info message. Remove it.
> >
> > Fixes: 92306daf521 ("libselinux: rework selabel_file(5) database")
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Acked-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>

This patch has been merged.
Thanks,
Jim

> > ---
> >  libselinux/src/label_file.h | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> > index 8fcf74e3..13451680 100644
> > --- a/libselinux/src/label_file.h
> > +++ b/libselinux/src/label_file.h
> > @@ -231,7 +231,7 @@ static inline const char* file_kind_to_string(uint8=
_t file_kind)
> >   * Determine whether the regular expression specification has any meta=
 characters
> >   * or any unsupported escape sequence.
> >   */
> > -static bool regex_has_meta_chars(const char *regex, size_t *prefix_len=
, const char *path, unsigned int lineno)
> > +static bool regex_has_meta_chars(const char *regex, size_t *prefix_len=
)
> >  {
> >         const char *p =3D regex;
> >         size_t plen =3D 0;
> > @@ -275,8 +275,7 @@ static bool regex_has_meta_chars(const char *regex,=
 size_t *prefix_len, const ch
> >                         case ',':
> >                                 continue;
> >                         default:
> > -                               COMPAT_LOG(SELINUX_INFO, "%s:  line %u =
has unsupported escaped character %c (%#x) for literal matching, continuing=
 using regex\n",
> > -                                          path, lineno, isprint((unsig=
ned char)*p) ? *p : '?', *p);
> > +                               /* Unsupported escaped character, conti=
nuing using regex */
> >                                 *prefix_len =3D plen;
> >                                 return true;
> >                         }
> > @@ -343,7 +342,6 @@ static int regex_simplify(const char *regex, size_t=
 len, char **out, const char
> >                                 *p++ =3D regex[i++];
> >                                 break;
> >                         default:
> > -                               /* regex_has_meta_chars() reported alre=
ady the notable occurrences */
> >                                 free(result);
> >                                 return 0;
> >                         }
> > @@ -523,7 +521,7 @@ static int insert_spec(const struct selabel_handle =
*rec, struct saved_data *data
> >                 return -1;
> >         }
> >
> > -       has_meta =3D regex_has_meta_chars(regex, &prefix_len, path, lin=
eno);
> > +       has_meta =3D regex_has_meta_chars(regex, &prefix_len);
> >
> >         /* Ensured by read_spec_entry() */
> >         assert(prefix_len < UINT16_MAX);
> > --
> > 2.53.0.473.g4a7958ca14-goog
> >
>
