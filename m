Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F083B75801
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638156; cv=pass; b=KMmPdgETzaP6it6ykX8Jl0AI9SiEypz9PLr6DnB8YNdFm7BWd8rpnmhgy+5YIttiyumMaHvSTeX7Np6AsTlCgsLChIaYn1J3lC+jAScSU+dGJn0tfBVg50mour83uXya8JrBgXzJZxZpljSgUqbnbolmoLvjrsqT2kK12WHiDF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638156; c=relaxed/simple;
	bh=h4nheIj/aaZ9Ywzwp8g/mNY6DKCTlL+KWfKQSYLEv9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dz7+HJbAzBi3F/vWUR/hLhNgWlOdYuG9SC1wtycb47KBypALRCadfmpkNm2Y5jylINWWTst5BHbNXwyY2pPiTNJgkThsYgKaWKmMA6oFswLDHxqfBWSyrgoAM0M118ld+4lKRBG9L+p6Mntm2bjRd94WQKN52U5P7Hc22Sw4kzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzLtbLtt; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzLtbLtt"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca88130e09aso7040427a12.3
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638154; cv=none;
        d=google.com; s=arc-20260327;
        b=OrMRIvo8oqNHa7S4CIInSCJ5V9Wo39oDfSbBO+HV1jrT4i4Oj0n1PY6CzESg1Erbut
         C6PeHOTclUtmSwzYdnno54TNXzlx1BhyrCMR20KBbhjBlr4TJgt+wEB+rQgFi/Hula9w
         +WNcP65Tsrgy00VdXAfcN+XvAZsEWOr+NUsiIyFPu3JD966jhkALkkjA4StMZCoVEnR2
         +B+s5fwnA+oyImO3b/D1D37QKYPYG9GUXp3H/qEAhAx/r+PahODRtAr/CH9dnHJbUuHK
         e72xoWcHQqxOQy7muYFPuDxrE4xlhImjSt03lqrAv6vej4XjzjcFzu/lPiWhhhzqZ+WP
         dnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kos/rVB04tH63Ds+UPstSQEocAMfj8Mmmfr/tIxwjvc=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=QVJ0PpbCZC7X44HXd+NsBk6Lhyos7g1ZMFh+0md4pR8gfG7n87hUgruHICORNIlcXv
         TGQzTKN/VsYSAPh4VcWzH7kwLRwth5uYlZbN8kqixuhvzmM98t2eepvaWHI7My/g8Rrq
         JJjrqrLtdP0ieyXmaBIiVQK/7uTRWkBxzGRZp493/UMBX3YVPFcAwj6ReFdmDkBzgyJC
         rSZLZz5AfwzfKSXfhBYC4j+U0MfqHHM6iIcoQX4bsCUIFHx6yMQU/5sB/3GkfH7JGx3s
         RI6zEfQhqjFFjjgqpHGd85dOBQC2HrAA6PRUUMaJqFeecm2mf4JA/zd6KiTfupCfRC5B
         B+ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638154; x=1785242954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kos/rVB04tH63Ds+UPstSQEocAMfj8Mmmfr/tIxwjvc=;
        b=GzLtbLttLevSgxBqEHrMDGbgH2GESTTpC2UmKKCFQZkaBTIBMOwxVJxVD4buyO+eZs
         ljiGzkb1cq7xwj9K2bQEDeMBfEEb2AbR4unQgg3Q6l+mhRFLX4agWV86Onu9Go/Nl4Tq
         ilDwpkzq6Wc0/wQRP1QBPaJGZbDu5TpCrLY+6STY+IJRMIXGVwa4lWpNlcL/OhSd4OCE
         qKqSaxOAX4nYwIx8fULmU9DOplNoVfOWGg74HoKBsZJpJYbyLYYHTfuVDl0fM9XhOlqQ
         xjNc2kE1/A0nbIJ8nfL64ZfosKAd0OKbe0FsUcZiACT96HqygsI8lkJLePjNvMMo+112
         7jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638154; x=1785242954;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kos/rVB04tH63Ds+UPstSQEocAMfj8Mmmfr/tIxwjvc=;
        b=dCykGsv5Njkiw7Hl50IEmnAT9tllHV1Xf2/v4YWxpdJeAgz64xqqlHIQI0zxPc3DPL
         3dZFU6r0/dnxraVtK1ZM0Yr5gsfvA/fQtXYKcuwBt44E4ZRW1ZUxYFnsAsKw27jRmuMV
         ZuTwB7SFp1MrVprVaU56YdymPpFQqHlVAu+dGczNG9syw06iMS66wOPMHmtwy5I9t9Sc
         9VoSPpMiXEQdmv8Yu7vEH10UrbBlMTTb7bhEA/cJV3hgYEVlftTc/1Ia0mu7lyTti05R
         Zy4Svsj7fFr7tpH1NW0RVShwnZznKiS+DcxnXWjVCXUarsQa6NmbouLgnBP/lwYq9Gbt
         LYBw==
X-Gm-Message-State: AOJu0YwBqjXSbjg8Z8iWfvZnRYujD2sVWmv/KklcDyOeLnm1uzhCgzx3
	d1ROq4SIESGzFTiddAIQ6wIetRx1oJsNmNeqtGQEokqIkx+UtogEI436IP79wZp/ZtExxQm0AYE
	WwmZhHx1Za1fgOi5AI5onZ2XoYYJCK5GS9A==
X-Gm-Gg: AfdE7cnq1/VQT1pYU2CMnLFtU2VrM7UkIj/BYPtpXPZ4Wzlc7tQokjvnxXbHN0u1/yD
	FjHdHNlSMtkWwkdOVpiTff+PM6QCpkxe7wBdzqDuj+RvZOG8jpCh+jXwPjCGF6dLgpdvL0LIys2
	C4gWK1NTVvBRDDjSgoXIFrmz2E3PhIH9dR8/u/2uOxikhFALUsOBzHT2aRhUZd2dZSJU6TE1D4N
	c4CKMlvIKttTQJpiWYOhpGr9nnLwaAEnk7/3zwo74LEJ0/tzW15QOC767LxzJnvsIeAw4t0
X-Received: by 2002:a05:6300:4047:b0:3c3:8d4c:668a with SMTP id
 adf61e73a8af0-3c3ad9ecd08mr17082032637.75.1784638154308; Tue, 21 Jul 2026
 05:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716125803.7023-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260716125803.7023-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:49:03 -0400
X-Gm-Features: AUfX_mxHRf6SqTKrRHwmqkfOxjJL7Oz8DDY0fuXCwpxFd8s8i7fb5bT0EH-dFKw
Message-ID: <CAEjxPJ4VVMffTYyg3+u4PQg3OTXe08YcC4yYH=2NSnY3gMBM4A@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils/run_init: handle NULL from crypt() in
 non-PAM build
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 8:58=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> crypt() returns NULL on error, so check for NULL and treat as if
> authentication failed in that case.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  policycoreutils/run_init/run_init.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_in=
it/run_init.c
> index bb9593ad..89921b23 100644
> --- a/policycoreutils/run_init/run_init.c
> +++ b/policycoreutils/run_init/run_init.c
> @@ -213,6 +213,8 @@ static int authenticate_via_shadow_passwd(const struc=
t passwd *p_passwd_line)
>         encrypted_password_s =3D
>                 crypt(unencrypted_password_s, p_shadow_line->sp_pwdp);
>         memset(unencrypted_password_s, 0, strlen(unencrypted_password_s))=
;
> +       if (!encrypted_password_s)
> +               return 0;
>
>         /* Return 1 (authenticated) iff the encrypted version of the user=
's *
>          * input password matches the encrypted password stored in the   =
   *
> --
> 2.55.0
>
