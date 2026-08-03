Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B97642C4ED
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780818; cv=pass; b=G2ZP/vo5uaJQWhzM8vJs0liuTm+3AKfWLk01lpKSJhA/EWfIsB+fxMACc+R8jTqn8zS107fxDtSLJNaf5QnCT9t9JgIjqZYGRclZVt/uTDJ/ibIKC2UC4F5fLFNON1ppnP6MN6y0K+ShwSWBMvi6RT17vI3NTVDa4DnHX9y8Vvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780818; c=relaxed/simple;
	bh=nvc8/KLeKTIVRH74ejOgKK7eB/pim5gBD+2p2DdqqkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJ216Ou9pXKK62LsOXil+AWEHi8rTtOEwKVSlE61bGMsJx4B0K+hs1PMllFTaRZ1plvOAWAQNtYQYXsS98A8gIFcKvlSZm0fgARl+kE63BHJgag8BUXGmzXEvtYm9WR59SlVlBeUfl8w96hVNc2aKG9EtMacjCCzkp68KNkE8Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlFgWH+m; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlFgWH+m"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-448cf99c133so219923fac.1
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 11:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785780816; cv=none;
        d=google.com; s=arc-20260327;
        b=hrWxiZMCb9GsQ68JG5DcYzUlgr/r2F9Dy/XCGu2dz/V785cyc1SIaL1zrtZVqxlrd/
         47XFVRhjaP3qS2lyriA0AGvNJP2BwceYO8rkGbDqXUCkVuU+bPL5JyoBy2507u+2XxqV
         ELGLLqDj2w0ywwkgJRU+gpLjyW3i+jvY1xCdz9kqMeMSRVadWv6py11rJ+eAfo0lAsHH
         ZK8BYP0yMgiIkbjEUBlzxUypq0oN8EyFn6UZMuEMg8RJzGLm+KRUa12V+K9JTRLAk3nV
         8W89dHeLwthPIBzO56uSGlDNfcvarFE1n92NlRkOjuYFyVE9no1ZYu02H3MH4xM8Z+GK
         tAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8zjXowrHLH4MpXiWzu7KTO5rZ07JLvRm0kpkUmLmU5I=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=KOcvU1udxaoliliI1mTp/MIIsTDqowObETb7roE8tM9/xAyFFl00MTs2wsPKfaEhYf
         sj9lgr5nNEGJZU3lwoDJwF5LdXWeI8ZOQ/eJ9K2sqWZyTBqnKMHVx2ZWIm55AMUc1JeC
         g5ZfReOV1K7bPVYYAmizgNDUPdlNWJftFUgLKk6UVkqSWgPj1ZKz+dvSSTbTzBrEfpcS
         LyIlnWTZXCNvxIukKGDYi3ppl6EPOt0+OgFOKPvd07JqlG80jj/ZvNEnaln1DjmO/emv
         IYcC15DEzGCCsl0wqKFzi0wi1Dq1cRluAfko6hxgXaASJvqrdyy6zGO2aDKCXpy/PzLG
         Mo3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785780816; x=1786385616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8zjXowrHLH4MpXiWzu7KTO5rZ07JLvRm0kpkUmLmU5I=;
        b=JlFgWH+mQlsqeRmbpFnJ533kNmkvqIxrUR2oyxDt9ku+Ixz1g3nqDW0HRcM+RF6BZV
         iPrm4gfhoAmHtRttomRCnyLcVCTtG7uWKtnb/H3fg9R0R+p0AT7z/FXYIKJGEhKf2FVA
         kOrizDqbt9x6/SIzxE6jK6rHxy8vGf/dAawvqiL82V4JotywHZZ7UgoyatTY5HouXpMY
         01r5FBS3OnJBS9aMvhiSNtVElZS9WFjm4bzyjYeQK4lcKbD8gsBg38fpB0oz5QH0J07s
         aRrgUQqeyFRNS2mbvw03qMqshFoGY+3dfFryxN22QmCBqT2ZAzqtzifa/GmQ7MhhWIzM
         z1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785780816; x=1786385616;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zjXowrHLH4MpXiWzu7KTO5rZ07JLvRm0kpkUmLmU5I=;
        b=hQ/UDxFxWzEdy4hX2o8ToI784sQ4se4YJYOpWOAMDcdvMSQTIjsZAK+2T/0SMwZz6h
         G6peEEr3GSSHgv0D5GioIicY9kPEiT9483ZaFGL7vqlQdqPchQl19wVBgBP+ntGAiTq+
         e/O1oZYk/tNCFoeMXjk3Ajde8gXU3MlEbaW58DjdscdL2s5f6iMW5q2siSR62e/Xaa+R
         KjMTh+Cz/G/ihzhpdtajQDC58sgNX0bwV0XZF5360+YGW5w9b6fqpkxcrxs0M9LG1XLc
         mgn6nlIRbvhDZL0RJ7ve/vIfhwkIrxBxGWL7ZHDhNb7fYuILXvdWZoBlPF++78010JD9
         V1/Q==
X-Gm-Message-State: AOJu0Yze0rH3NegVyxzAbHdKe12tXtpF+89F0EaoVDqXOYBKKGaEr2f8
	G3hdPtVTYcI/GqtLMweMy2KTmWzmYTnoAWj9wfqvSw97xlDyW7WWSEmLZPqSUewwgxhrG/cp344
	kpL1YX2XuFDy4O7AY/5MIBS87LWkQxQ8cKg==
X-Gm-Gg: AR+sD10zb6KvIsQXkfHdsumrOBr8tX6oJ3GmoxV7fTyxPkEwji3SeF8gYOnTXHHLKvG
	eaY7Vs7AJhbByMf3UiJzLQv39RA7WZAjhAiuI17nu5vnZdj0vmQhNXSVh3sVs3wBXA5lOgnEo54
	EFO07NnS6gC60UHTekIsd3mAYsgJCPeMaNejQTo/14O96SagKVhYMa+MUcimb+RPPW8bpkmi9Ei
	gYdFtX/ksuw2QTuqDk6jC0wqd5KJ/x+dP+vL1ZvcfVONwEzrEHx8Pb96Y6MVUD0OoVhR0UwH/ou
	Md3REI/vV5se8A2Gvkrxfg7JwZfkVMZ+jQ2rS40uaw+7t30CsrADCT3N
X-Received: by 2002:a05:6870:a24c:b0:424:801:49fe with SMTP id
 586e51a60fabf-45978b86172mr466938fac.8.1785780815911; Mon, 03 Aug 2026
 11:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803140007.41237-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260803140007.41237-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 3 Aug 2026 14:13:24 -0400
X-Gm-Features: AUfX_myWe0pZyvgcCpB_quRkp-tplD5nHwfeL0kw5Qfxx7X0OlhVggiHt5DMIV0
Message-ID: <CAEjxPJ6choPWCKXV2k-Fv4_SAuZ43HfBBd2q_=1ryoPegemDvQ@mail.gmail.com>
Subject: Re: [PATCH v2] README.md: fix CIFuzz badge link to refer to a
 specific workflow
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 10:00=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> We already had separate links for the other CIFuzz actions, so
> just make this one reference the check format workflow.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Disregard - there is a cifuzz.yml workflow but it wasn't running
anymore since master was deleted.

> ---
>  README.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/README.md b/README.md
> index 08e82d0c..6f1bfcc8 100644
> --- a/README.md
> +++ b/README.md
> @@ -5,7 +5,7 @@ SELinux Userspace
>  [![Run Tests](https://github.com/SELinuxProject/selinux/actions/workflow=
s/run_tests.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actio=
ns/workflows/run_tests.yml)
>  [![Run SELinux testsuite in Testing Farm](https://github.com/SELinuxProj=
ect/selinux/actions/workflows/tf_testsuite.yml/badge.svg)](https://github.c=
om/SELinuxProject/selinux/actions/workflows/tf_testsuite.yml)
>  [![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/b=
adges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/inde=
x.html#selinux)
> -[![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/work=
flows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/acti=
ons/workflows/cifuzz.yml)
> +[![Check Format](https://github.com/SELinuxProject/selinux/actions/workf=
lows/check_format.yml/badge.svg)](https://github.com/SELinuxProject/selinux=
/actions/workflows/check_format.yml)
>
>  SELinux is a flexible Mandatory Access Control (MAC) system built into t=
he
>  Linux Kernel. SELinux provides administrators with a comprehensive acces=
s
> --
> 2.55.0
>
