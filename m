Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7167C241665
	for <selinux@vger.kernel.org>; Fri,  1 May 2026 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777655732; cv=pass; b=Y6YvuKa07x1sOCadAD++tu+/G79J8b+2e/6q2w5bd+vhmYMIzWiBXC5K3UwOiweezSno3BwR7ZJ+inumC7a48Qo/Zq3K8MCUE4826u/HkriD/AFYH84Whi1oj8f79TaCWaKhudGMuy+rrDq/ZGXpBRk62l8Mgi7mwSbs+46mfQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777655732; c=relaxed/simple;
	bh=aoOFXsKhspIiKaSrSc8l787/rwmK/bY3nGFRexQq7HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPYwwCg3wdW/Lr1xOUxfiTJHamhZ6c1oqOu4ohmQ/WjdNuURTEFnTzCg45NE4ybXgsRuBoaI+vhermvDQZIyygP5LNi3r5GDR/y4/WTed5hwp4tNG7Mb4g1Z6KhoRdIJv4iBASozCI2vGsKQ1wzdPPM8hACX8SXcYNHbcYaGsMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZl6fZz2; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZl6fZz2"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so1390832a91.1
        for <selinux@vger.kernel.org>; Fri, 01 May 2026 10:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777655730; cv=none;
        d=google.com; s=arc-20240605;
        b=EPEs4n1WYKZuDDHJt6s8ZrB/BR8YQU+kt/+Y5T6iW98cYm5tSNRSdyyXIGrom6n0Ze
         CXw95jTgCfqYVP2Ao3jEudjHkQCb9+TSeBPPESehDSDeHJfnwjjbSSdCwVwVo/SC74SV
         hoJ17Wm5jNBlw9L5EiMpAH6s9y4t79/vVa2hI/OoqKH4B4fR8zChCpeJozHRyer8DeIE
         PvRjgfTGwDVI2MMVqkd3X/A9IWVXEO4jOzVP0qJUWXQPUpEsXDOH/H6s6hKIx8iQ8pH5
         j1TA0Dw47APMmNO4HVdyYetFln9qkVXo8dAwyi1i/VGuutxTSkR2n/1x/RfnkUmF68re
         lv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zqQoHJ3EvP6nauXExOfRBANsbuziggJDyOkNd85FjNg=;
        fh=XjqZIoGAjhwncvHDfP+ecOKbgC7jCgwBYP7HdSZW1fI=;
        b=GAdjnxAZ2IS0TOHAY/jQ1pa2oLpAT0Wv/vPufzUdLjCHveHTeu+wIoXyBZGUQf9J7c
         z/OAygIMjkW7hyOPcsaJq+FN3AO1U9to/W1nFm/5q1ZHWMWYKtOAhWdLF2C7zigR5NSO
         IoraKKrM2ZSWeK6YSnYhK3P9t1BmQuvN7IJ6pcjHdkcKUgSFrGSXAm4+NZWvgoPbMXIv
         Wq0+JUDMWRIbNsk6BfPrAfn38dfk3VeVG17Ojjk/2PPKAfvxNZ4Yg8pjbM3CgGkFXvbf
         wew5cYBK8I/A+Fr33wV+6UAn8agQaJy04hSfL/qVQXZjRLfWETup8T/99WkHpuVd8CgU
         6uLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777655730; x=1778260530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqQoHJ3EvP6nauXExOfRBANsbuziggJDyOkNd85FjNg=;
        b=rZl6fZz2mDS7Tf3YjmK0djMKnNOEj3VT2zIrj/mRKTv408HK/ekFlEvAThUpXAeARx
         n7CQmbToRYd738pkO9yxmKwmptSs769rocGWxoE+h1/dpO2byGGhbE9pwYUt/GbREdbo
         wBYt7tMwGS3GdDTh50uGlUdyslOFNdfhLkcAUAm1M5QjZ2N6WjXRArRC2kO2xm7dH8W4
         XIgyKhlzwPG7ExYe9APcMuJnxpIthstARa6YDAQ32oawC7OaLso7dMc6dbqJRtsL2WJh
         jh2D71QDvXcrU+Uzi3vWgd17tcLkGE5d0lvrhK//f6BQ+3yH8YgKZN/GBefqC+ima5+M
         WIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777655730; x=1778260530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zqQoHJ3EvP6nauXExOfRBANsbuziggJDyOkNd85FjNg=;
        b=r1TSK96Vxpml20c9n/df1UB846378x655HSbAGq88w5gAZo4HGvWkz0hysqD/3Uc6s
         YSDzI6NITo9clIvtj4kk4EdimAcd95nwLlaaKleobZY7wqj7vSc5QI/oSS0hvvDE9DVR
         Z45D3apSljEpz0ZAAzM6GvJA5C2xFIzjbB3zIBx/Cvsk8NgSJe0q6mhblaKbKcxYjw3F
         FMnszgaovk6JqUiIf3h2o5My1muxYzuRm3cO0rh9Fr3GkIkdt8chgplC3smpYw7u2WWV
         o7AYTcR8NWCmRajUsZ7DIC/afaJMpTd9m85BQ5+SsSoNeuNyNB8XpNhGpW1x8MrVG+ue
         6DpQ==
X-Gm-Message-State: AOJu0YxddGbrUQknFdGwbV3f2LCE9bpiD3+Xn+9sNOPMnzge3crDbuzR
	GxVKeVjxRn34rQilaiQaiTwZLCMw5qq8eqZh7x4ZKZC9yOVrmEBr9bxyoQ0wPWcCqw5l8s+7eYM
	j/a9dLb0D6BUIdJVGY5Ayst4lVXhLNCg=
X-Gm-Gg: AeBDietgxp7zXxW4pakAjAHUukon1pmI/Bf8BLcZK4zYV0qiAxhp8opHSaFgu/bk+1+
	mmgIwMdaXOWQ9/miM8R2pmAapJFCjSwsSYbijY1GsR7uHMTlaeVgAPduDtrlsximyeHuNut9ZSK
	Yd8OeL77rtM8vyxlVXULFySlpM3Q9KqNeHGmmOAGFkGtTGrTx5WSheHrsNhBCnzrMO/HOgC5i0Z
	AUMCSPI3xRhSDCAm0r/3+SuuiwXYzwsYcdPgymseXiJT6f5qPxMuxhF/LNpcOsmlgk8hh6DX56I
	dQl3LgXPHqs+ibFWjQ==
X-Received: by 2002:a17:90b:5546:b0:35f:c46f:2b0 with SMTP id
 98e67ed59e1d1-3650ce2a69bmr93595a91.14.1777655726518; Fri, 01 May 2026
 10:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511173055.406906-1-cgoettsche@seltendoof.de> <20250511173055.406906-11-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-11-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 1 May 2026 13:15:15 -0400
X-Gm-Features: AVHnY4I5PLxZ_vt128bhIoaFv5g0NPhydeslFZxafMmcHbtzRzEks_AeLamrfYc
Message-ID: <CAEjxPJ6UUU6sHHCVYfVFs+Q-UTYaJY+AVLeVaECFt0=i8iPHRw@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] selinux: more strict bounds check
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org, 
	Casey Schaufler <casey@schaufler-ca.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Takaya Saeki <takayas@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Validate the types used in bounds checks.
> Replace the usage of BUG(), to avoid halting the system on malformed
> polices.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/policydb.c | 29 +++++++++++++++++++++++++++--
>  security/selinux/ss/policydb.h |  1 +
>  security/selinux/ss/services.c |  3 +++
>  3 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 4559c8918134..7774f6da2ebe 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1020,6 +1020,15 @@ bool policydb_class_isvalid(const struct policydb =
*p, u16 class)
>         return true;
>  }
>
> +bool policydb_user_isvalid(const struct policydb *p, u32 user)
> +{
> +       if (!user || user > p->p_roles.nprim)
> +               return false;

s/p_roles/p_users/
