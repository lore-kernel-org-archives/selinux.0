Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8777F3B2FDB
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687528; cv=pass; b=KgaKAO3e/YP9JBWI5QjthUmlehxpfLYqnOtCeS/SQDS6LgWARf5eEqlas6W4Z+JgXHAZs5EL2rNvajYGKQBFaHK5wo9ZETTDeb9y+B/kw1TdFNvH8g+lilOXzj7P7dJeRlnN9mjhQKLd7EBfU6yMdp4FkgsLQF3PV0t9tXiwTlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687528; c=relaxed/simple;
	bh=QXEI8oqoCkUwwEMYy4g17CjnCAXAK/roqi7qx1npq4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8oOntHqGl2unvaY7z+wyUMcAYHDPlvKB3EHr0PAudIcl+RfmtL4C7YzVZ6PpGP7twEaW1/vQP6ZctslcUgJhJA8vVjA51kWXd0QsnmJ5hvDzgKrHbVjK2cs4zuIhHQwIeBfZTnY7UDOl5T+XuF7Tm/Lw4x1/PRCgpFb9Ob4pd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY7j+qRU; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY7j+qRU"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b48ced973dso175762e87.1
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 12:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787687524; cv=none;
        d=google.com; s=arc-20260327;
        b=RiwTYH8nx9mv6F2sDvwGUElXNW8VKKygMONarQWIYNVWOyAICILcikMzdwBdkZ+1Sg
         FSQPEngmLWCxrEkGxtCccjQI9vzYOE5M8oJjTYVSsVhSuJX1xwiGy1XHi2KU+Uv8aG6I
         8vsZf+7oUwwQoZxl9//aJUAxjKpLE9Q9ryUnEG6nUVkdmqQxbxWCMaQBoTuZMMHvdVj2
         wRgxD59kBwDdc/wSLqjEJfr7FoA8m6+rbwJGJeMePeh0RZvtA5yFKKbk7tnDatqPwuWA
         MA618aqkkjEJZ+izI49QkAOnZ/WCQEirvMCnIQeyBKdfrMfZywGznhaOGFNHjmIzVmPx
         Nixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tac00RdzqDWN69Kc3HHz9E0fGo4VzG15dPS1ME1Oclw=;
        fh=9qqehjuxnn2X0mJ7hQbZg99PSLTxs4BCAql4/69ZoU8=;
        b=HRrh4j6ohpwrN779Cx9Nfn/+clteBvPFJ6O1p1THmOkpDKv7p/zT/UlXL0wGuDy8dH
         j9tNjBJmjFYS0kHCgky8kBaT9VDHKYN53fGA03TEyR3uaFDxBBNlpAFZGJJ3FQHcAhG6
         m0sWL+SxFmhGFEeKpBsMSpKHNqbZZ0mr9Vfbk12f2vtI8+GXTBgujddjPt8OuPfBaypw
         UMT5UASkUAe1xCb41CnTMlCM2bWCXBzBpHLUY6dBOrgAJPzdNF8zyBvfHXjUXOn3uCUc
         6iZkeHhRaATDobQUzk6k1pKFju5XMjfbIEQynuhVNF4Xj7QgZjYyCwfTNPj/2dsAikOq
         Dpsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787687524; x=1788292324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tac00RdzqDWN69Kc3HHz9E0fGo4VzG15dPS1ME1Oclw=;
        b=mY7j+qRU1mdzAt8CSAqGR6z9Lv6hZzeUrC4cnKucSqwK97qN3UiNFI2rf2fzdnORVF
         lECt9KHzdbCNTcdRi2Mpt4EhhY1FYY8f0PnG86gK6MzJ09v1BgMbM2TIYD/TvPOz1dMZ
         P55cOOppNaWGmCYy5Yco/if9QOlYVDusxGACES2C60/wnKQ+rApEpF84wPb4V9oaDino
         8XVDNJoD2kb8WQ3O7RUQKbLGMl4KNknb0xM4y5MhFHSixyrXkEmEswYp74TR/6W/CdwV
         zgzY8GreGp0vhuBm1GB46ClBvieIeR1xrhtY0sfCmpslslWwhb06dNM78EkSbOMNrpsF
         5tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787687524; x=1788292324;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tac00RdzqDWN69Kc3HHz9E0fGo4VzG15dPS1ME1Oclw=;
        b=HwTfSK77A8uJL1Nvxe3aH90rT4INyKyTvW3b7Ov7BpERyoulop5IgXOWwxmLiGa+cA
         mlrlNHkkftyU2MoSQt1JVTrZgrzj7ITGktDNSvpG5hDmLWpk5fa1XQfY95mWbcJ/qzMO
         hGqTEGV8yQ+tI7WIAF8Ai5q/3rYeCPRSybqaGYIjNUHs8HP0vEqceMbJJxFiH6FIxYiW
         SIhauk+eHfO3mErLrcWbEdK/IVXAWvxi0n+8YoPaOPf7n6uz644PYQet5uxSOEybNutU
         mk3dA7IWyRbNwDit6KMjLpdDZg6as070fjXLxPWVNdNJapEqDVwTYvSrJZyscLJZPFFA
         vqyQ==
X-Gm-Message-State: AFuF++kQVVHSMjPhhqtGk1L0nV/5LiHMoy2FSkcAUP22nW/xkLNIxdNH
	iEK4JQ0EDQDAiGr0GC7t3Y7NAOZe/5tyr3IHGO/MZwSeQSIS4/iJ6oARxlUz66+bvaGaxGQYbhV
	mzkjqkGdHrprDoRoGD5xEZ03Z+mZ16Tc=
X-Gm-Gg: AR+sD12NvhKlbbfCDedz0jsPJ+Xn5b1Ux3FM5mclpgcxkaZH+hO+uv81+C3seZKPeFr
	CS1Jgf/hFnEXSZKgcXOp8Va0Hg6iE6lFLHGLvD3pd7WdcTsRmG0mSIV3VX6cnRhJc6SQDYvlrT+
	fgGfpvzZDkObCamJE9h9oTREP8GII0MUpOGG54S0mkeIEWeakpF67RKH+W4NcnB0+eEPhZAQA/m
	7tylHVEgeFEJf6lEm7V8cDd+rnvcEDpOjbrg52yqTbJUCLXnKCKWatttrF+oGSPxypCl+IdXPFZ
	emuPfi0Vp/MkF4XVpTb+tn1wbdH3efhr53zgBuqt4Ragfyy1yzST
X-Received: by 2002:a05:6512:689:b0:5b0:1dd0:f238 with SMTP id
 2adb3069b0e04-5b4a8fdaaf5mr176308e87.2.1787687524098; Tue, 25 Aug 2026
 12:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825180358.89854-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260825180358.89854-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 25 Aug 2026 15:51:51 -0400
X-Gm-Features: AcwNN1Wkgcp79xncBIBRp6o4SF36JU7b7N12c-lEAdtEDpI-uSeSCRycmCjJjjg
Message-ID: <CAP+JOzT86cPNuLw2gygoMAMYWbgE6OYdPz_ur7tWBvaZ3Em2+w@mail.gmail.com>
Subject: Re: [PATCH] libselinux: sefcontext_compile: include limits.h
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 2:04=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> limits.h is needed for PATH_MAX; the absence of this #include
> breaks the USE_PCRE2=3Dn build.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/utils/sefcontext_compile.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sef=
context_compile.c
> index f8115026..e504b508 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -5,6 +5,7 @@
>  #include <stdio.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include <limits.h>
>
>  #include <selinux/selinux.h>
>  #include <sepol/sepol.h>
> --
> 2.55.0
>
