Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E62248A0
	for <selinux@vger.kernel.org>; Fri, 13 Feb 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770995809; cv=pass; b=oU6v5HDaBD2Tz2MU3zW6LSI7hSooXB8q3Qr7S12RdrV4qAUC2k9BOFuYfPQR3DwCoD8mVntqm5rE7mf6JHSaHKcLTUeUnxufkXTVjic2rO+eiiWcRxdOpWhKLRtUBXbNyyfq3+RC0I3Nowmkr7HbYJnRE+SBU9atEJBpX7+S20o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770995809; c=relaxed/simple;
	bh=JLD4XXgvHER2VWFZd12U/T1muup48PAGsqXkfRPJfn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMDThE5r1bWr7tz8UQ8dx8rFTGQ/E/Lsql4UFBFvngKRPpuh6VMH4s6W2ipjqcXSH9MyYiPuduYXAOV1v5Ollih6H4Fs/vp88HUAlMa9ld8bJRWGt1QfP9gU5Shx0CYvyUe4Ou1xaLssMY09bciR0dPxX0r9yMUY+qasglLAlvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/QNqifw; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/QNqifw"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38709888abeso8363361fa.1
        for <selinux@vger.kernel.org>; Fri, 13 Feb 2026 07:16:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770995806; cv=none;
        d=google.com; s=arc-20240605;
        b=IFvKzz6slMhl+xOiN/3RUfJVa3sjRyQOIgDA99W+zXOezu/wQ1SV7TlKWTzzpXCA90
         d8vKsKWL9KUFzXXr4FUK57NIqjQPknHlVZYfiJBMA4oKE0rvmyFyAWVkM38+PWS67YN+
         sexLttq2gQuuGY3suG4fJEyBcEebAPLZKXfgadR/LxaIin1SFTRrl0Y1YPQkH+hXOotF
         FIiAkn8UuCVYMRIS11HuumDERvg2m4byZsWhWhK1W+VDAfEmpf4U5RePJluO8AjeSyni
         9Gxna4ztiZZGdxI5hmwO82IcEHPsH8EBkMDmnWg1ffWyXyutaHS1uElBmw29JfsHNIX2
         T1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhR52EB0YhqM+GByFIZObRpkvkeaRHhsRg4V2ZeKpE0=;
        fh=ooIMotml3ewNkiNY6/CIs0xIV4XdBVqir4cIKtdRah8=;
        b=jFNrL3XZzbG/PGV32ENd3fcF3PgJo0G3eOqOzpJOzXMY75fqovcnfSsultsGHa99xN
         iz3wkOe3wAEsRyuUKqWUxt0o7SpnNXUL2NJfrLzx6FWzUFLYLfQsKnWSYS5NOQRpvotp
         gO6IC6QhILGKzN7yA0sPqVWF7iCkyuJ2284fsPZRc9CVlJF78dIDDgMI9PE5c8Km4Als
         LNswvvftrGmuUiyuMTcj7DC94WkA/d2ttAtqBTk4p+TaOSAdfTTKictypnnqR50rajpN
         IykijhxOH4OiBSV0AuLbJhxUS0dl9CXN4PCYjsbPfbV6XZQ+0wdQM1A5hzfqly/M+OhF
         J9Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770995806; x=1771600606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhR52EB0YhqM+GByFIZObRpkvkeaRHhsRg4V2ZeKpE0=;
        b=B/QNqifwky8MuBP+uQhqSHyveBdXNCRgRQ/rEr1GPgVXKCcqu7ombnbvU0gt+qcKCB
         qdopL6aF+FCt8IgDSlRKejLPW8/FtkThwgvLLMsfu8UCF8n6hGg3riyk8bmM8Ejhfwn1
         WRMH0BSul2DLdYmJhLOntBb85h7ccYLPaM1bAjYZHGAdNlqinpM1vaXMkZTQT420pHiq
         sagMLqrp5LKQrOofQ5dUadB3kdjD5UaaChoplZwTgIWWPYsMkLFm8sOq0BHZ3z1Y6ElL
         gAakT3JLmEweVgrdyKWNpeEO1fH7KCmPT6WiZJsQWwmwqD2pp0yV2/ptrRwA2VP8ECwA
         q8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770995806; x=1771600606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhR52EB0YhqM+GByFIZObRpkvkeaRHhsRg4V2ZeKpE0=;
        b=ECyWJKY51ElCbTM5eYYJPlB3XFMSeclEIaiUNeY1VLy7fuPQvKMmnOSgs/ROTZuhvK
         Blfzy7I89dp/+qvctxZkQeg0PY2W68iCVgvKkIJlV/JOo3s2mkywFrEQV2WqFkXIAXrd
         tjsM6Ct/wtC/01CmPW3A2hFXmTGDf68uahpQ2Ns0vdPsnhzixph/nXAba1fdxx2SGOJF
         QttyUtcC/6yT1NTDA6mWEWJpjCmI1NJYXCSobk771w9bMVY/SpA63e5WPVwAWU/GQVFZ
         9O80ur5W3UHJge40ubNr5crfLcLfxtqZNrz40Px517RG9zPZpHfykqVu7RacMlOAd+dK
         aNlg==
X-Gm-Message-State: AOJu0YxN6wGTX9u67Ro6HmIE2tmIptzfaioJSMmDKloMNbCvlCSD5d+k
	hJVZAxfk74rehczkIaUHftUrOF8eRIAaH8xUS4ntTlTxLwi/+3ogNDyFsvCr1cOJiS62VhG/GPk
	kbMpv/Ceq/SNgemUt7a27rmF7pdFaSVA=
X-Gm-Gg: AZuq6aJFrd6MQC6n0t1Cd4Uwh5kaSK/0m++qMMeNupOBvKzh7QQm4zwQZ//mWob2EWv
	ebL/jo4a5pJywQSpDvSwqxhN58ymyk3FnA/PW30Z/nTe+uNKy6QmbKM2+DQ8a36BtI3wdwg7Jra
	RtmsKoOZ7yogCOqIrMSQDOppiwqCamKk6+auBET0fGGKkBKiSfSsmqhaUomMCLzew7NGkrIK7vl
	9I4aM94g01tM6YGEPpB6PwhBsU1Fl5OsKUD1cbJ9SJosK1F4vQJOVye8sRZ09TdJ0O538cye3tg
	iN9x3KzDQdbJ52E=
X-Received: by 2002:a2e:bea0:0:b0:385:c10f:122 with SMTP id
 38308e7fff4ca-388104ed1f4mr8120541fa.3.1770995806299; Fri, 13 Feb 2026
 07:16:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202141043.85962-1-cgoettsche@seltendoof.de> <20260202141043.85962-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260202141043.85962-2-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 13 Feb 2026 10:16:35 -0500
X-Gm-Features: AZwV_QiT6Ygy2Sgfk424TwW3mF9DvTWb1ygsm9Fdk2Cd3atouivP-lq6q-hU7oI
Message-ID: <CAP+JOzQN3G+xiN77vzcTnbboca3EEFNfRHY-_NDvyJFrPH7m-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: prefix ruby objects with interpreter
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Helmut Grohne <helmut@subdivi.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 9:19=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Avoid cache mismatches when multiple ruby versions are available,
> exactly like the libsemanage Makefile.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 0dbba7f4..a9bfe069 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -40,7 +40,7 @@ SWIGCOUT=3D selinuxswig_python_wrap.c
>  SWIGPYOUT=3D selinux.py
>  SWIGRUBYCOUT=3D selinuxswig_ruby_wrap.c
>  SWIGLOBJ:=3D $(patsubst %.c,$(PYPREFIX)%.lo,$(SWIGCOUT))
> -SWIGRUBYLOBJ:=3D $(patsubst %.c,%.lo,$(SWIGRUBYCOUT))
> +SWIGRUBYLOBJ:=3D $(patsubst %.c,$(RUBYPREFIX)%.lo,$(SWIGRUBYCOUT))
>  SWIGSO=3D$(PYPREFIX)_selinux.so
>  SWIGFILES=3D$(SWIGSO) $(SWIGPYOUT)
>  SWIGRUBYSO=3D$(RUBYPREFIX)_selinux.so
> --
> 2.51.0
>
>
