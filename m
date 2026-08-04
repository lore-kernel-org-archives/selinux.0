Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F093DD537
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847960; cv=pass; b=ssccwg607DY/FuPevMqIalc3wBRAluCmSJwwaUw48GvQJapbcis95RB0omVqJwKmqJQfL38utAwFC/ZJHlTNb3u6oPt0SvYco8jiHAXsx2I8SGR+lNJQkvEbvXh9UoGWg4EZyRgMZfXHCyhnxkHtwpgq+rbB9NAmaBu55bE6/rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847960; c=relaxed/simple;
	bh=2ZMghy5YOmWWGHwDPGCeIG+KXFeexP0HWIjHB/FDUso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFr5+EyRWgU/Le6ocu6kr49HwtZ8vCou88axjscJ2Q5gfVs/ril8HDrs8RxPprWtfXs8Evo5INJibcT5RiMtgViBErDhAMYbftdb2/Me3VMhrWO0Sw6oN50z5+1pDzkEu1sNMWf6PqJR1VGBR94C7vytdL+c9jrIC+TrIBxXJ1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5at9N7C; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5at9N7C"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-448b69cfc6dso4235043fac.3
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 05:52:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785847954; cv=none;
        d=google.com; s=arc-20260327;
        b=bQ1DrX5md5OipZilqFOOuY+zL/VIuW8caARcPya3v4gRJvcJfbIAMWCK6jELLZuJMP
         oSf7erjZ5yQSybc4587Fotc/30jM5QrHcgd+UQ49BHPofhsGksAE/H4uaTolXupl8FCf
         wQwGYPlnfGTK/byN2gxF8AgN/mAv3zpKnI65tM2gJFKo6J6joUooWG8Hz5NKGD+fC+oJ
         HoRV7BLPm9zKRjqe7VVfw8ew6DbgCo2y4NPN3DyZRTi6zpBsKPec4zAL81bUuhgoIbpZ
         B5nhIIArp8BWUybXHhczsmd2rtqxKsRn2gwOOAEiszA4QZA8qDk+qq+OA9IMTbjVHrIY
         azbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UPyQhymApT6uW7o9PTOr4apu4O0zPYoYJms1yJEg26U=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=KebpeDVOu3qqHN1cL21XW6Glgb5H3vtTtYj+0DvvEVkqRcDrlSwMbJ2D4mSkECYFKv
         3aPzDvqkkvVRcWMOUG4sCXa/l/aVV1DhppJJbzTjfa5kqi5ikDDxODVV9S6wKqdwUMYv
         Fo9XiYKQuqnqKQ6mXENKPRNOnGs2GslX2Js9YtisoPMSd8RDJGoXC3xp0loYFVpIgG9A
         esNNskBqWdAWul7ZGKQDYNQ5lYme3NRNCidSy0CesSsvgVH/tiD0/SygGKf1nJmeBlu6
         nVyBKDY51apoqrWvg3erRCT+s+0KtMPIoN7ryk+nhF3b5grCtWE8YYnMYE3tO/JlOfyV
         8X/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785847954; x=1786452754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UPyQhymApT6uW7o9PTOr4apu4O0zPYoYJms1yJEg26U=;
        b=H5at9N7Ckv6ZsWMdPrqmqcfOkVSMR1HvvVIqJtI2B/oW/VsJR5/UrdJEis6D59JIK+
         HDHCc1NDsLRTPiVv8Xx2nBAYzD/yefA1UmZqtCPeXVirg4ms4qZ8XnmNGscXb5ozhbpF
         OvNOu5SXqA1CVHaIrvecuhnv2TWUNZogDHysGQJK1zEASrprhxS5r4nJwswmjUFakJl/
         1aGodNalN8Y25W7uCAwz0GAQvY5k1QtGB21kuMJTW739ypzKM1vd+CJaWjq+uEe3JIB/
         XUHaLUF3NSj1xT77OHuDK7j8Y6FuEagzbGrx5UjkEu6iE7RNiyqbMa6q2Rg8mnkb8YTq
         VYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785847954; x=1786452754;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UPyQhymApT6uW7o9PTOr4apu4O0zPYoYJms1yJEg26U=;
        b=BRsEi38fPt3dO1H4/rdaGaCmAlafAjgygrTxYq1f5uJ6YGQBPLXqBTPIMvvH8FTzPl
         btPVOs+56hOZ7uV15e/7rKajZfBdL/3OBUEKsDEaeDl1kHpjHTvxCOzMYbURRwxS3dBI
         7FDYCM8ajdBx36A1P3r8uNxgwn5oxIemDYm3NZZB3iX+AUXVUEVhQ9tgG3qG3dUMSHwf
         3JSs61EL8Vj9V3EuyPHLaf1bYEVDyJP8P7C3+s35nC2Ln2tJH8gNoLpoBhL2M6Kr+jeE
         NKhbpv7g1BvKobihl+XMHlbNyKm6CwgedY0q3OSKkZySDEALMb1HhF6Ih7Vu81KY912t
         dudQ==
X-Gm-Message-State: AOJu0Yz2c/Y157SoEAPtybB9w5hcikW2JivB0iNbDCLvKAuXm401Ucov
	9fjMg24UtTWicc0fKQ5GNIzjCvkpbxGT+3EGQZ6rm67DKqCcLG8X5yEZGdCKibhLH+aH/n+X+Tm
	H7ayqbjtsfG58SVVOcql8DAwheYPVssIpBw==
X-Gm-Gg: AR+sD10+MHywfMlZoc/8dD/X4x3tHuB/DtnVQSeJasiZlx639oHmCHmXQILpho2PkH/
	93eW3USB0N+YXjxc3wf7GUg37xfIP0R0BPwroNW+U4x1y3tHoOTK52iLpRS+9bpMndV2rt5wOgw
	a+YMpgNK7uOo/6S40j2HqhwfLn3Lt400Jq0ztqA2RAPEivNEjGgY9bOwqQV9JjFsbpjWkuRkm+2
	XfZNG8g95c6VrwP8jJJG+m32wC5lPqCOiB31/+lyAbsj8xZUDF/19yo0LrysGfAjk4L4koM5lxd
	n32uqrRjJO2IYV00SpbiCqks/IR/kAfX8s0iifO6D0zP
X-Received: by 2002:a05:6871:2ea3:b0:435:16e9:f288 with SMTP id
 586e51a60fabf-45905e46f85mr20022367fac.20.1785847954449; Tue, 04 Aug 2026
 05:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804122505.54855-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260804122505.54855-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 4 Aug 2026 08:52:23 -0400
X-Gm-Features: AUfX_mz-Cr_lnI3RLxbSRQyhgN60DPPtb256z9HZY3AT65H5-Z2Bjb3Z2JFQAG8
Message-ID: <CAEjxPJ4ZGDkQE2eiQ-PUFJ_qG5aHEOE+w4GMh+qXNuNmPMSpqw@mail.gmail.com>
Subject: Re: [PATCH v2] .github/workflows/cifuzz.yml: update branch and upload-artifact
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 8:25=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The cifuzz workflow was still using the old master branch,
> which was recently deleted. Switch it to the main branch.
> It was also using upload-artifactv3 which is no longer
> supported. Update to v4.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Since this obviously hasn't been running for some time (was never
updated when we switched from master to main), it would be good if
someone could confirm whether we actually still need or care about it.

> ---
> v2 updates the upload-artifact action version too.
>
>  .github/workflows/cifuzz.yml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/.github/workflows/cifuzz.yml b/.github/workflows/cifuzz.yml
> index c4e592c5..c3b57e27 100644
> --- a/.github/workflows/cifuzz.yml
> +++ b/.github/workflows/cifuzz.yml
> @@ -3,10 +3,10 @@ name: CIFuzz
>  on:
>    push:
>      branches:
> -      - master
> +      - main
>    pull_request:
>      branches:
> -      - master
> +      - main
>  jobs:
>    Fuzzing:
>      runs-on: ubuntu-latest
> @@ -33,7 +33,7 @@ jobs:
>            report-unreproducible-crashes: true
>            sanitizer: ${{ matrix.sanitizer }}
>        - name: Upload Crash
> -        uses: actions/upload-artifact@v3
> +        uses: actions/upload-artifact@v4
>          if: failure() && steps.build.outcome =3D=3D 'success'
>          with:
>            name: ${{ matrix.sanitizer }}-artifacts
> --
> 2.55.0
>
