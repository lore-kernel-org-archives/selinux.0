Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4FF3EFD1A
	for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188019; cv=pass; b=D4gQekk8lfQZlkiGzarDCkI0hcb4BcUGaAADqIe+PcPeWdlbtGoVIXIlOAIuhAqeoT4gyZVqkloXZOVs+ceH/r4IBGuBfQDxTG1ipjyQZkkQkDJNzFNj61XWzsAtpm/Rq7euLjA7R4yuDYFgoYgJewusbe7MTq6Wb4ZZkULt6XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188019; c=relaxed/simple;
	bh=fiKkAnDf00WqkEK4FP3Tobl5pcny4UdtDRcPrlQ+BeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4U4pgJF1mQWUrgMtcp082/LB2Eo8Qtz1rEAlwOGRoYE+D9sCPt4p4QK5i0Biieo1W9IqHQHx7z5t4JMhc1ojr+jN0bWiWQDslF+waNsc14Js2kzyLUTu6kTwm4FMP30eM3HoIvsvCVi7WnoKKg0bq7IDhXstvEVoRy39F0fLVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTPlC6+u; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTPlC6+u"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38e9653b580so4911331fa.2
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 10:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776188017; cv=none;
        d=google.com; s=arc-20240605;
        b=iVVorKu1ovKMwU61VEXEY5orwBK+xcQtArkCZhlIavxmlSeQsOhKumNcHzS6iJu/kS
         st6m6qGOf2+P80HE+PMLvLG9vZpdn36446w1MUTRU6bebkC7uhp3oAJEB2pG2U8g3+ut
         MR2SyIKxkkvZfaWOC0WIdS8w//Vj3CPYnloe2715K7iM+vezMkdAskl0iWpSxeNuOwHg
         zMJnkhNMAlVANncsNLNLlmEl7TXztI5mmAaAaUoH9NfzTdGqs45dx8LQwuYxPpMgzVHV
         Z6pTWtumysjTX8i9Pb46B9dYbvE5R4VF39ssXK2Bpicy/Jsobhd6odiY3obb65NNQriH
         zStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iVfwR3rvIC2VQk12B+x0KOECBz4BHjVW2cqFhiLClSo=;
        fh=ooIMotml3ewNkiNY6/CIs0xIV4XdBVqir4cIKtdRah8=;
        b=N44XPbmZnjs8343/oC6fjb2es3CJ9q3oMGwps4/n3RI27PSk0cufdpKO0flTw4irXF
         i4UgPL3mp4kz4M7VPYtFQJ2jiuOfcZ1nTh+THCs0gHVHltKhrtqSMYtgzlkRFHoRstwW
         pEHRY2ssj3l2lmTMXRX1JFO9vLdlvwstOcfF5nOE/N1JdsCTc4SixQj7APCUJzxHo5XI
         ijv7dP3JBZrfK8AZgitOK/WPvU61i5fCPrNIUvIfaXlXiCn1APZ63bGQspx1rZVRchvY
         hDuTX42sOZr0/zdKI9SOTji7qeKX61CeUp5Juaj8mRwmmWeVa3l5kOcbKFMxREwX7KCa
         wZmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776188017; x=1776792817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVfwR3rvIC2VQk12B+x0KOECBz4BHjVW2cqFhiLClSo=;
        b=ZTPlC6+urQKhhNxEhk55YeTMIFGMPNA0xd/muOxRXBRcsbzqj30YnEvAw0KBhcVv3d
         QLczczVcauiSV4SoZz9YHcPsHv02kEuVflpnBpYvhpcs3hbk9bwG3D5gB6IAYgahwNhs
         TiTqgBp3T4JjAUhf1uo/fS4ORsdKbQiGYbHC7BGcM0gnZ1hQuw6LvfFEpYbA++TkVlAG
         XmZYKydUwKitWNLL7RNpzlTU9MG6RuSDTez3OgeCEp21JNGS8gt45fetDPNgLuni0Vpa
         02p/AYziFflcOMYPvaRXW0NJnSa9IjodBxk/BYEJEThxlJhUo6vY6Py2QrXhes5xbtSj
         f+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188017; x=1776792817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iVfwR3rvIC2VQk12B+x0KOECBz4BHjVW2cqFhiLClSo=;
        b=K15f+YN+QbF4zr3PCvZzBVKGhvxOVc41yS9Oc2iWa/5vmEL57JkxcGMWpZIEw4pCaC
         gwEiXqgmXKb3y5IuOCwkiH+I2V90sq2UNKFlu9yYKXEk9vPiHflQ/LX3KNJA/W3Pt2lP
         MYonYLceTcEm7059BG2FajxalVc2uDxrric1jIAnYqJoBn+248mSRHZ5l01nnltNQrzW
         oesSO97Cybm+qNHTSj0oAupmcDHGBRU1tHvkEqvnDaZnovgvGAInMC9lkgwG92yDgGzP
         SXFmqZUil3jvzrh9HeNuMjR27n2n3fmpO0iTKLqvC6365bEr7oQjNnGTO/R789ghK57+
         0MEw==
X-Gm-Message-State: AOJu0YzRZ4qA0kq/tOlxn8vtWQjfE8xnwPPZkr3Shvdd++rdAYodmBz0
	ivHed5qP0DQZetTs/yv5P/A7Pnj1PU0T0Ly+MBBrMlOIINwsGLmq5mJilXpoVb6F6nzdbXw6/iP
	oOvPPM4SwipK1adp7lBRBGGDOAbekQbw/Bg==
X-Gm-Gg: AeBDiet433pSFJYdOyZocO7+aUB+qsybu62+0ayjClFYx2chzVznBhmyZFHk7OcPkmR
	1k+EKvMxRn3R9Dpoe+cg76iSCbA0ej+8GWisOQjAW4Da/2brpsz8fKHK/Bz4euYgYSPD/4QAHLz
	+mNkjrk9eWMbYlSNNgsQu6JoT853goXYuee8s5CuHTQ79ImM7/vykMJrNFM1Xm4BdZi9/18/Y8d
	nQ/tJkOUF/NmOTTrHtwzLWpHGJ6pOjl+49NyUR6emg0ACOhHRZjK8o6csIahx+AZpffzCyFxE9T
	7dTT
X-Received: by 2002:a2e:b887:0:b0:38a:56d5:e2e0 with SMTP id
 38308e7fff4ca-38e4be967bdmr55654341fa.14.1776188016313; Tue, 14 Apr 2026
 10:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202141043.85962-1-cgoettsche@seltendoof.de>
 <20260202141043.85962-2-cgoettsche@seltendoof.de> <CAP+JOzQN3G+xiN77vzcTnbboca3EEFNfRHY-_NDvyJFrPH7m-w@mail.gmail.com>
In-Reply-To: <CAP+JOzQN3G+xiN77vzcTnbboca3EEFNfRHY-_NDvyJFrPH7m-w@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 14 Apr 2026 13:33:24 -0400
X-Gm-Features: AQROBzBGRWjyJDICUhXbHgjUclCY40GSshbVSu18hW8lSKttvZzItiU8IShElQM
Message-ID: <CAP+JOzRXg8-CKk7hFiq6Rv249FTH0n21mjRV2LDPLW7R8Ej1yw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: prefix ruby objects with interpreter
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Helmut Grohne <helmut@subdivi.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 10:16=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Mon, Feb 2, 2026 at 9:19=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Avoid cache mismatches when multiple ruby versions are available,
> > exactly like the libsemanage Makefile.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These two patches have been merged.
Thanks,
Jim

> > ---
> >  libselinux/src/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index 0dbba7f4..a9bfe069 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -40,7 +40,7 @@ SWIGCOUT=3D selinuxswig_python_wrap.c
> >  SWIGPYOUT=3D selinux.py
> >  SWIGRUBYCOUT=3D selinuxswig_ruby_wrap.c
> >  SWIGLOBJ:=3D $(patsubst %.c,$(PYPREFIX)%.lo,$(SWIGCOUT))
> > -SWIGRUBYLOBJ:=3D $(patsubst %.c,%.lo,$(SWIGRUBYCOUT))
> > +SWIGRUBYLOBJ:=3D $(patsubst %.c,$(RUBYPREFIX)%.lo,$(SWIGRUBYCOUT))
> >  SWIGSO=3D$(PYPREFIX)_selinux.so
> >  SWIGFILES=3D$(SWIGSO) $(SWIGPYOUT)
> >  SWIGRUBYSO=3D$(RUBYPREFIX)_selinux.so
> > --
> > 2.51.0
> >
> >
