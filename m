Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071521BC2A
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779986934; cv=pass; b=O99qh56IhcHizBwkfyDBsbQTN873pJRITLgsIHa/0mJMOFp1TTiSQh1kdACNKl7/f15sJAxXCd5dchNT06MLGXN/fS18JujklgXMXdZcQrn1W2IcAt0UXFcQed2dX33N6anqTSepoc7VrZ9avIOXHa2EQ13MMalMwCyaqW3Mbrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779986934; c=relaxed/simple;
	bh=xgSK6zefrrLE4cPbDsJKTd/LEPUswaTbCqBtpTpXYmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2PrUsnlKPclDBJNOoViXV3eG21qgfmhuiHMxlzdhR9JHIk5+qW8atoW5Sg992iVdcObbERfS8pBHj0zqLOAOBdgZ+Yr5dRyO4v2faxfWYuZj0bGwrJkWKea2yisfcJei893lYlMDatWVH6YApnwxGeOWU9Kddbh2VGmQXyA+hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqdWldTE; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqdWldTE"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38e84ed22bdso143722721fa.2
        for <selinux@vger.kernel.org>; Thu, 28 May 2026 09:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779986931; cv=none;
        d=google.com; s=arc-20240605;
        b=ULZF7/ES+BRxMWiwXaE+6K77iVWz5cTde+shf4TmXBmDjAOGxVWVDRwK/CiqO3qIdW
         BSEgFQciuJO6MaX+1RUUfpTTNFaM85L/TTUW1W+AqsS6EyD6ag9QbD3P+d6/YLj6USUM
         mxqIqQTzKsDZIiJNu50yECQ4A3i061GZ7nlpRpfoGO7VkPxEiBIxhvIjwvOSC9VME/8i
         grPIcwgNLgfgtTkxUb6JuJuzKfuiIMaTykI/YvlE9ZxSt2kwoOTqX3QZLRu5el28BL93
         yamjjYygT9gWGHVSYY842bSD2TSx6cNXZ4FyEKYfHBCIQYDvTbGVXwfFrskq7gm+itLs
         pfFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F2k2CTrYQa3d+JYnIDgiPD5vboSZoiHHcPcxFJaXQQk=;
        fh=aeT4B329T+f5qu8AKJlNyYAsJtmTCTfCeBC2eKi9ibw=;
        b=NqZDK4zjy9nKCHISWmWp6UaXKgbPYB7U2KYkbOaHgGhHfjrblbU3hMh6hVzgym79YA
         yWwik049hqzFrO8myrHHUy8mqjmHKsLfp3oADVSATLKZiVs9No2BQPV3I9CTD5uhrndh
         3Hjrwkb9OdUQj/ceES5GnfEksffLZMt0AD2ezrAKdLqjZM/76LbJSelpq1DURxdCUCEp
         UUF9ePL/pgp9vu+cI8Lo8VVv/R4yeJjI+FZP1hvIYytTHL1q0fHBWOmRkONDYzZhQgSL
         KcSCc58uhYjBeD70EDNW4pLv/rPcitvEp+bx63YESB+C2u6l8iTi/BgHrsF3KGORaotv
         i7xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779986931; x=1780591731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2k2CTrYQa3d+JYnIDgiPD5vboSZoiHHcPcxFJaXQQk=;
        b=HqdWldTEDvsU4pZrpvtlp4AC3mmuFZ+0hUIUtM9wVnep1qJfhqx6RvdS1GkMDc7iZP
         fubR2TXBUCM8fZ4o3+1+jOpySbUMSa6A6Vj/fuHZ6HD05jauVQpQdxfaV+AU2ppypiwP
         yBXY1BOEepxAHG+QCFMzxHBtCfF+MSTzrL6uB5pynyexF6xU0jU7dLpz001Cd9b/a5i7
         JqveA6c75J6w/+4EIcKujQeLjuRQoV6f8utJd7ABZJbUm3Xa22EiQxZ7EKyF0y9L2r0Y
         62RZFjr7b62xqZ9bohSmphgc7iCynfbACy3FS/CX4H8tvEaBzL5hH6kJyP0A6Sw2NcUx
         hblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779986931; x=1780591731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F2k2CTrYQa3d+JYnIDgiPD5vboSZoiHHcPcxFJaXQQk=;
        b=ZFU1QmWAX6wUcEjed+aHXzlBcOmyxx2M+FBX03XaC6FeCKlSkmckUR3YemWGbsFmMz
         YNQ6BPkx06/6eex+e/CrGaiTCtxz6Tv2PEZu6MlREujQe/M7KWZsT5X8Al7cjfjmddf9
         GiGOqZos08fWnPRPrbxIHoTqh1RUay+12iV8+Z9RgB5yqgOJgwtGLfFIBJkWOOxjhCcP
         EDAi6faOMk3Hpkl7lftXYHsG9a29l6deLyL9sR1RlXB4COlG9bctdmmYwJYqHsYaDRzG
         feH1D32hu48PuXTBvHTr/8btBtOfn42g6rQ9WDHRsBa5cxFRkue2+iUrVTSOb1sIyMx4
         kyGA==
X-Gm-Message-State: AOJu0Ywhk7tl3i4bh2iSpkw6yPcRoJULOX+TKWc8Ba2zuVrKHOXCYwpu
	1WRN16LZ9QvF5o0zvsdHaj7nNUE8zL4AB7XFRgrbork8pON4BmKOOYhN3kMDexVXtk8gCkO1jGp
	7Bx6nTL8sq+hVPE6b016ESu3960ZkwfQ=
X-Gm-Gg: Acq92OGQNxJp6dgRdZGhoYoisL17hQUkCJ458DGJv3XQ8yICcLDs/86o6vmIZW96AIA
	lCGzHVw2L+0c2l7+QnGu7kOsww0J6bEaAdoXIiPzvFf9r55Wha1JObYtF07LnjEB1VS4/lmBmIP
	Md7J3c85pKfCNytNB9Qi1/NCT6zqd9YuOoYJnOA9vMH32NeCEQnDqmQf2b3DGPllk6xS1PhC2ci
	/nXyCzLmxM/dbcAF1IMQwI7a6SnjTV1O6vyxIrQrDgNFORTSK4RYMPMSKWFPVn4MJF1dUBsQiad
	mzOTKkP+uMz/QLI=
X-Received: by 2002:a2e:bcc4:0:b0:38b:e6c7:2c4d with SMTP id
 38308e7fff4ca-395d8c8b55fmr102438711fa.12.1779986931068; Thu, 28 May 2026
 09:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528151014.1281996-1-lautrbach@redhat.com>
In-Reply-To: <20260528151014.1281996-1-lautrbach@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 28 May 2026 12:48:39 -0400
X-Gm-Features: AVHnY4KY-divdalpRWiGNdHRAUVs3BwHI8Pjamp6iQ3xpDfMm-cj-CJBDD9xOz8
Message-ID: <CAP+JOzRzjCEU_7eZzTCJt_90t1tNR_7q7fX39bidJcaE6EGDaQ@mail.gmail.com>
Subject: Re: [PATCH] seclic/docs: fix statement definition of roletype
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, ra33it0 <sebastian@sporyon.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 11:24=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
>
> From: ra33it0 <sebastian@sporyon.io>
>
> Signed-off-by: ra33it0 <sebastian@sporyon.io>

The patch looks good, but we need the legal name in the sign-off.
Jim

> ---
>  secilc/docs/cil_role_statements.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/secilc/docs/cil_role_statements.md b/secilc/docs/cil_role_st=
atements.md
> index 2e1b40475d67..3e0688db2970 100644
> --- a/secilc/docs/cil_role_statements.md
> +++ b/secilc/docs/cil_role_statements.md
> @@ -51,7 +51,7 @@ Authorises a [`role`](cil_role_statements.md#role) to a=
ccess a [`type`](cil_type
>  **Statement definition:**
>
>  ```secil
> -    (role role_id type_id)
> +    (roletype role_id type_id)
>  ```
>
>  **Where:**
> --
> 2.54.0
>
>
