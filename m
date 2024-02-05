Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7E24F887
	for <selinux@vger.kernel.org>; Mon,  5 Feb 2024 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160057; cv=none; b=Prf+Frx7W9IabDiDvl+9oBfEDMMcuIShiGwAFUudp6k+gGo/gWgcFbVllTX0W29IvKNGIs4n7GrV7YuLEEQ5OC33TjxdrZT7OKZJn8U+iyPb9l+Bne6ZJ93ZaXUqbwEfaC+q2vrOSQx4WH9+mkae69yPjm+oLSZglalKMwzfWvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160057; c=relaxed/simple;
	bh=zKt0dtDiz7x0883oTYvPnjHPYRWM3zcw1qN4SNW3c00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iw/3Ev4cTlOKs6c3KvzM8NNKI7yA4OyTvJgpq6RtnRheAtqP47Mz1oJRfjGKyPZOCp6WEykjZH/ffHBnvUUcpYA0WE6dTb1TC4sk2PSBTOYllkcRwK3O3j220s1SZhxq6Nf4dxqIcTeFA8lLIoXR2tXR6+Wo0G59+Qo/7gVL+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhABRtrx; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhABRtrx"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so1924017e87.0
        for <selinux@vger.kernel.org>; Mon, 05 Feb 2024 11:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707160054; x=1707764854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puVHQYFKqHo1Bc+++uOhJJzfmrt/J/DjCHMx+mfQ4Qo=;
        b=BhABRtrx6FZIUEXmRkiEqe01ojeok9QhgJOr2RUTwAMi3Z/GXHrc+j/VwKkBAsVsMs
         xQLTG/TOFFMDedoxdxywJUq+vQNw7t0n+Ut0GDq6b82LRfsnDFGnF+ZUSYGg6f+9uWsp
         tZjGJF+9+izbi6m+az+CvBfNIgwWoQPpa/OCIwq21TbiV2zLRxfPtp3GzwqL/hPK0vxH
         xTfZIecfXXB6xmIYMglyLQhTZ+yqsQj7+I+my6F7oE7QdHKqgKvdwZYLhA62iixHYAI9
         aB8WnMsrLCAzKiEVHVSLgjkOvj83Iyl71Q5d7eQItj3Wew6jYis7+cshYGC1f0WbDlMV
         Sc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707160054; x=1707764854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puVHQYFKqHo1Bc+++uOhJJzfmrt/J/DjCHMx+mfQ4Qo=;
        b=ISIgJMiB8UcrgycePDVlguf4xvX/DYFxLLSvTLH88iPkApS45lu2JXX0ub59ymM5d6
         kGrhSBoZrzAw5RPrF8tAEWMnBVQH3D/cdz9BCz2zWRKcZ5M8GDcL0bkHLYHHDjMV759Y
         zpdSUE4B+67gyVAjC+WDt21mCNAPIub7IWmrMZjV+TtN19YgYro16YIw/uiP/QE57AOe
         I5htnl8GD0GLBfF02u0LOq70WCML8mqDPyUhSg5o0nRbmly9LcwUjRF6VDaU/ZtgOonm
         mt5oIAlwuDoYyum98FOqKyFo/kGESIRzEibAdds5JmAGRydE0nIYqAwcJKULLjcfW3CN
         2GXg==
X-Gm-Message-State: AOJu0YwAYwchwOlFOgPx4TTiQUalylPD72uRRIlCTfgfHqr1e5ONLi1L
	Cai8BS0MvFm4u+xMnoAyHeDWc84vCwkGYOSSm+QmCooCYL0dykgOJ74VQ1sFeHZduCg55EsqUwd
	B/lmIasUeqRdOagOYlmp6TAv+e8JRKzPC
X-Google-Smtp-Source: AGHT+IGok7UmMkY1NieH3YdLbC7FUmFnD9pO4Z+UqW79LzOizrmCtzqs+3JMl72XGMph/scCgbKTUCna4leEGSflCuE=
X-Received: by 2002:a05:6512:706:b0:511:4f8f:fcc2 with SMTP id
 b6-20020a056512070600b005114f8ffcc2mr80662lfs.14.1707160053508; Mon, 05 Feb
 2024 11:07:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108120029.38816-1-cgzones@googlemail.com>
In-Reply-To: <20240108120029.38816-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 5 Feb 2024 14:07:22 -0500
Message-ID: <CAP+JOzTe2jt0-M8Xfinxh62p8LVdngS1Zt4zvMu81b7V2D-ToQ@mail.gmail.com>
Subject: Re: [RFC PATCH] libselinux: disable capturing in fcontext matching
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 7:00=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The path of a file context definition is compared as a regular
> expression against actual pathnames.  Those definitions make frequently
> use of groups, like `(/.*)?`, which are capturing by default, causing
> the regex engine to extract and save the matched input.  Matching
> context definitions against pathnames only cares about whether it's a
> match or not, potential captures are never accessed.
>
> Compile regular expressions (in the default PCRE2 variant) with the flag
> PCRE2_NO_AUTO_CAPTURE to turn captured groups automatically into non
> captured ones, like `(/.*)?` into `(?:/.*)?`.  This saves some cycles
> during lookup operations (~1.5%).
>
> Only potential regression would be the advanced usage of backreferences
> or recursion/subroutine calls to numbered captures, which would need an
> update to use named captures instead.
>

I don't think a ~1.5% improvement is going to be worth the potential
for regressions. I don't know of any policy that makes use of capture
groups, but there probably is someone somewhere who does.

That being said, if others are strongly for it, I can be persuaded.

Jim


> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/regex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index 88d82fed..87423c48 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -80,7 +80,7 @@ int regex_prepare_data(struct regex_data **regex, char =
const *pattern_string,
>                 return -1;
>
>         (*regex)->regex =3D pcre2_compile(
> -           (PCRE2_SPTR)pattern_string, PCRE2_ZERO_TERMINATED, PCRE2_DOTA=
LL,
> +           (PCRE2_SPTR)pattern_string, PCRE2_ZERO_TERMINATED, PCRE2_DOTA=
LL | PCRE2_NO_AUTO_CAPTURE,
>             &errordata->error_code, &errordata->error_offset, NULL);
>         if (!(*regex)->regex) {
>                 goto err;
> --
> 2.43.0
>
>
