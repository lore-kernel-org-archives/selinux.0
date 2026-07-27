Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB33BF69E
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175224; cv=pass; b=ix7beSUrt0oxlI6ZYySdgmRc5lF/mA8eGWUJ/0tZ7J0d43cQUuNeXcGj2fuFdel8ztjOzOe3q4Y1rdgpKqHppcLkreovH9z78lFHfQkfQwO7WZrbODbh+n8qjnfFBTCVwjhkmG+znQ8Sz7E+esygwMQGTh6Mh+dvbpgAuFGqidM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175224; c=relaxed/simple;
	bh=UDNKvV3uDldGDQOjcdFHMnrV1VI4r5vyGP9pkN8zd7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0NMgg5BXnLoXyPFI4c95B3pvJ9LrAifXlweHTHGSpnfzn5HLW9qBZbnc3jgpsAh/OXhaWboN+9cFUoUAQ2AJcr0sZ/JSYzvA8qZGQ6xSpmWwq7jrG3akb9Dz8fPqtl+gl/tuEujsGm0GBqywYhr5r4l7ShCyDQsv4NIYynzLZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2N5upHU; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2N5upHU"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6ab015de764so849725eaf.3
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 11:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785175221; cv=none;
        d=google.com; s=arc-20260327;
        b=r3LhTOjyC407Y6/3xJ4LXkdXCh/Kb0PGD0Sej+vfLSbz7qUcVyeyP7elKh1Ijj8dhv
         lAfUnMBRz3Qhw6fLlCUqAYnl9kQ81RB2fv8X6FsEb467bjjRyukyUbke6HyWORMk7F66
         GsH9gKlQtKa2sbnLFFM4WlIaF6grhXsTxfu2vo4kuyyOGtdhfyzDN8knxjENi7RO/p3h
         +Lr8wKhkg3bHwK+NIZs1qmt1Q9l9PYBtbzmlbD5mp4hpifyc60suNvIjX59NCgfFkXz4
         9fUp79Wg+6/PQaCcfPlVXQYYStxSADM5Bdy3HbwDsUSxnfsR85us8JnpUdZhRqqJ8xxS
         Mg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IWHbFRgg16ZKTprf0wcOyDLcP48CYLx04gGCYpghBO0=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=YZJEIS7otCgwwshQ3kcHcB9o/GOWhCJNjbVmcm+7wBCVpbervsxG19PpdODyDDLPtl
         ZddpbVQSn0Sqm+Qgx0/0M8WB9Ey86umYTat+ec9ZyFBMOi3O+wEw3gQK6EUn3TDsFKLm
         7+ZIw9u1T8pUrzLZjIzrVrlGocsN2WWG7vcQyhhx2PSJ0Byho7tn2nmyi2+E9rVBfJd9
         JW+B0tdDff7YShbExa+mLr2NJp8fz90zFmQhm3Qa1RkTaBd7VEgjv6AtjhqBv4UO2Cw5
         Xa6YH71XWGFWT8ebdfhhRXkBlLM8LQGWDUqMGoN8F86tb0lsEKoR2ZNhMK8zOVOGJj9X
         Pf4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785175221; x=1785780021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IWHbFRgg16ZKTprf0wcOyDLcP48CYLx04gGCYpghBO0=;
        b=A2N5upHUw21GmuFY9kqd6NTVFQHIWl/Ij+2pCObcgIdbowNo1a09R/6mSQ1qTl+KlI
         naEBw6Dj5fzkW3+2cBApNHb7S6EAiPkcfYXTfNCB+CIrbDVmRG0Bh4IiUYH7xdB8C+59
         VeFA5aYSvR6EXyz/1uOf5qaZnZTdeOKj5u0O44b+APYP22dXY8hPhiKiii5VhRr4R/OZ
         IRjXdXNNyL/Gg8d5xPamqLs8Y3YTROMyn/TWvzOR8ytZfTwpxPAtqqxV8oT+j4GqGkci
         s3ZYwRY1MwPel4ih+mmvG6X/acLJvgyk4KAdkR2ad09s+N2RfAY4la7p8XcuyCRfaVfx
         A22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785175221; x=1785780021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IWHbFRgg16ZKTprf0wcOyDLcP48CYLx04gGCYpghBO0=;
        b=Bmgq7k86nyQ1r2x+2ubP5b/4ZALC4EIk/Zvnh5vuy3AVwQ9uDwxVkvyzRYhKHe94rH
         qP0D6VU0z2emOyuzGMvX01NAIl8S3ISgG9C0c7X8SbI+DgEf3zdTQLR+pH6TFwSVnVw5
         MVlFqeCxD6fzcJOOzo51V8UDXgzw1G41KfHg7wx1QVJxxZcAXdnraWyLM1Es9IPAmRsi
         J4E8PjONQzOyu1ZzKsWBdNEMiZEdUAPYdOKDVZVSNptPjCt8nfPtyGCUo6oYSWm16ebb
         Yh7vpYeLEzqLPn+UqAjeX4rb4EGZD3RVpVlqZp+IF9CP0Do9IyvB0MAr2S/ydr9QTgS2
         DxyQ==
X-Gm-Message-State: AOJu0Yy5fZVLYViu7lXxA/YGRPKqYXZ3p/CgqOsPzbF1Kj2ptCj6w/OZ
	Rcv54DP9959u116nT1jeJiLwhatL1bW3oSGrlaaNi0OFH1NfW12GAcPfG9dvLfVicvu0K/aGz6u
	bheJ1Dt62an1+kO6c2XmsWRipTWG38Hw=
X-Gm-Gg: AR+sD11lsLOeE30E+RE6Ptj3jKMUg+V8HneLUnSsJcW5vBPebHPQdusB9o6D6rVU9js
	eQBPE4Yf800B5Xh3mDw6mFGMFtk416G+Rqc3lkZ1kZxLHwXQK2ktxNojvVo4AB9XJ97m/KZO0y6
	F15cH3Us/JRCnE/fc8jcsdfrhwRnrGRblMYvnUxRF+EYDdOURLiJljGAa4CrkfTz/p2ZfkZfMKV
	bTbzBV+wwIc7lD0pq9m/LsFJwkdQfba/L90BmcobcXXO9YnGNgwM+2J4s5eiA==
X-Received: by 2002:a05:6820:83c2:10b0:6aa:e33f:5032 with SMTP id
 006d021491bc7-6ac90dc3f31mr356136eaf.40.1785175221570; Mon, 27 Jul 2026
 11:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727152518.2495266-1-akkohli@redhat.com> <20260727152518.2495266-3-akkohli@redhat.com>
 <CAEjxPJ7UXCc3DWaAcpmVqL-Dz5eHCCsHWX+4dYkfw-CUFEhSzw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7UXCc3DWaAcpmVqL-Dz5eHCCsHWX+4dYkfw-CUFEhSzw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jul 2026 14:00:10 -0400
X-Gm-Features: AUfX_mwzJwvL9QVI1VaGji_RoN1t-rUmMluWzt9dFhIVvHjeHUJEx4n6_Yw-K5I
Message-ID: <CAEjxPJ6kzkE_Or8PQT6bAvNzOOdD4qd5bVyUDAeusfbtc9ramw@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkpolicy: add robustness tests for large policy inputs
To: Akhil Kohli <akkohli@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 1:53=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 27, 2026 at 11:44=E2=80=AFAM Akhil Kohli <akkohli@redhat.com>=
 wrote:
> >
> > Add expect_robust to the checkmodule negative harness so oversized
> > generated .te and .conf sources are exercised without crashing or
> > hanging. Also cover a module with a large attribute membership set.
> >
> > Fixtures are generated at runtime to keep the repository small. Test
> > size is tunable via LARGE_TE_ALLOWS, LARGE_CONF_ALLOWS,
> > HUGE_ATTR_TYPES, and BAD_DATA_STRESS.
> >
> > Also fix expect_* to return 0 after counting a failure so set -e
> > does not stop the suite early. Same bug affected the older cases;
> > exit status is still non-zero when FAIL !=3D 0.
> >
> > Signed-off-by: Akhil Kohli <akkohli@redhat.com>
> > ---
> >  .../tests/test_checkmodule_negative.sh        | 178 +++++++++++++++++-
> >  1 file changed, 170 insertions(+), 8 deletions(-)
> >
> > diff --git a/checkpolicy/tests/test_checkmodule_negative.sh b/checkpoli=
cy/tests/test_checkmodule_negative.sh
> > index 6d289a4c..ed7202f5 100755
> > --- a/checkpolicy/tests/test_checkmodule_negative.sh
> > +++ b/checkpolicy/tests/test_checkmodule_negative.sh
> > @@ -136,6 +150,138 @@ expect_fail_unreadable() {
> >         echo ""
> >  }
> >
> > +robust_exit_is_crash() {
> > +       rc=3D"$1"
> > +
> > +       # Fatal signals: SEGV (139), ABRT (134), ILL (132), BUS (135), =
FPE (136).
> > +       case "${rc}" in
> > +       132|134|135|136|139)
> > +               return 0
>
> You omitted KILL (137), so OOM-kill would pass as finished safely.
> Not sure that's your intent.

Also these patches break CI,
https://github.com/stephensmalley/selinux/actions/runs/30291360086/job/9006=
1649922
