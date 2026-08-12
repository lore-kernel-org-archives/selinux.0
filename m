Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A380C389115
	for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551703; cv=pass; b=TEVzZF9UAqErfDtWAxxehL9+NdFcubOgkH+lpI5dn9y0JMmBaAg3jjVT0py6eVENzoG9uXEpo43/rpWajNi9C9+KPrms5ZnCE0UkLFjo6E1Db0aWeSbQJKahl3fyKpDdgW3e52lTr6C8VyGFqob7cpFdfXu9aYInh8oc6BoKfVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551703; c=relaxed/simple;
	bh=ogel9bNcv8wplAcAgcFmMoRc3wFChDKAdJ4PGpADGSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3yHnAnkbSxH2mO5FxswUOuM3XZrmB6TO7PDNv950PcULB3R2gbAQ/iEsZ0KU5+QpMJNBHiiejChXOKEGhFiMd6FPwM5djsAP9hjmnb6oMQkzk8zLS+xrLEG7nWg3eVDQCwAMZY6u6U5FynZu752VJ8YaNQN/0+2DtqQ+ftSX7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mwe4Ufpo; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mwe4Ufpo"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-44cd237446cso676982fac.1
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 09:21:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786551700; cv=none;
        d=google.com; s=arc-20260327;
        b=dB+u/Fs2ceNcfVKqHG8l9TXREEKS4tnT6W2/Y2IggR+ko2z3YBgO6f+h/csowL+idb
         aUHK+EF9oDSWJkxOFNZtAupDpB6WghBkcHDbygcioxhFvXjwvxfwrNGakDofh5k2DrTQ
         Ez2vPTAdrV9bZbZIIW1/P7+yMddT5eoBxWL9/LvuApBdaeoAjKfUkYthrTZ3HZmi3SxD
         JYkmNSyP6UWmK7+lXasqRTkH+ec0q0zr4C9gJWSz1zN/TPhR3185CBcUoMpSuaUXr6a/
         uAnC2GUub5MwHLXkH7STqysrruvc5tpKC7moiHoXVAKE3Ov2CixHwNYD8yD9nJfKp04N
         lsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ogel9bNcv8wplAcAgcFmMoRc3wFChDKAdJ4PGpADGSg=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=dEOLkrxV1s4Nb1E7cZtexPnpSQfkjZRy5ntfHP8CiGxcnSYtnMlcqOq7E4wVVYBXYc
         b2TSgKvSxx5o2jfLeXJEbGMRU0bOwGNjRRAt/2tc/dgO9Zqmzk/C4Il2o+EkqWU+cWos
         pcu1ta3zWG7NFwzYL81hGZ/JM+qZjzIDRAJSVv9ecI0KvT3ja8jEBrYbiiqIWEF2Tcg4
         mVtCpPFwi+etSVXqT6Sx04rVm2tClGUsGbJ9HQJS9ob/VJcSEhz5glPXZ6C1d2fxTPGx
         Kz8CXbcXTL+sx8wJ3ssUO4MZZh0nMBKpUfYhRMzUnK5F/yxMSk70HrZDwdxZGW8jipUV
         QOmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786551700; x=1787156500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ogel9bNcv8wplAcAgcFmMoRc3wFChDKAdJ4PGpADGSg=;
        b=Mwe4Ufpon/5jC3PPi6h8rQWFNW/a6nKyQC8clYOVgqLqWpo85+TKbLD0wdQdOrSl9y
         2QzEguo1wDH2zdPieCC6i9b9vRqsxd4zCO6mA2d+etUD0XMk7v8Rg0H7JN4oAZHDx4gP
         ZmjQiuv5XjXAEN+gcmSHMGxb7pqqBkU0VfQ41pwT6sM4Y2ToBCsGGQuZ+SNxhmcTfEQj
         9VW1nl08sbd1NXb77fnhqNHv9oZG74T3Mv++4+YwPszzcFzTqOr+mxSMDEuELXCfWWPv
         mvfm82F5s+TrOnjaHOE7E2o4F4H9LkFwY3ZQ0WDUrZrjf0KnbERG+pSKOPSHw+YPkpn+
         OxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551700; x=1787156500;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ogel9bNcv8wplAcAgcFmMoRc3wFChDKAdJ4PGpADGSg=;
        b=i4ApEIVOFGY0+YmCpZUN6ATScWFQRIUE1NiAfqGtQvQY065xCk9MnVGtxKC1Z4jWiG
         OmC8KdcqwDEV7FG/6ZkQec5IFokkDFkBDpkjueiYbQ3+09DWXjz9MRajOGtvYLe1zN2i
         Og6JQTrB6Ve200nevrFpi6RLDqaHwMLq++GA210tXgsE1nCCAzysXcCFPmNkTYpAFcQC
         E1AH+p/qe+GWyBWvCOygpSYAOJE6r0ft4L3L2i56khcECNppBkmlA65plBWJPiAmr0qr
         mtEZSVgCC+fY/lHNf6Pi82oo/Ou8gsd62S8ubJ6buUeMvozs2YQ6mV3YiB29ozNA5t0T
         RHsg==
X-Gm-Message-State: AOJu0Yy+nUoIFuZkaxzd8jLn+LlLm+H+n+4alaryDr2I5XUsW579Lqlr
	jjPM/kdFA6m7IJ6FjeLFTwL8HE8zFfzPUtGQjvb/fIMsBBajISjSrIGkcxWw+awoBI6ttuUhIbS
	z/44pxDoEgsr3f0HKOzIvBoy7ls0avTCbDg==
X-Gm-Gg: AR+sD10VJd+BL4Hvn0h0ycb3NdKCCijBCmqr3l7Rm89bd7j3oyTsihBx58jn//dXvPf
	mlMn2Ux2hN4g6payjrFcJhPBkSTGB03M8aQeO25VAbgaKmSZkUUnkQ+4HDjXdENB7AtSeTi0d2d
	J2oeAXcdUionWYzDoN0EZcM+Y0xrbxob2iMYLFWhuc+OI8W3ltEcGlr+wAHXoq79cYW5dzJTr5c
	hBLf0xPraxyGbYlwhFlK2VDfx1lFMXSosgDiMlfYXCp3hl2tZ/vY55Ea9lVo+Rcrabe8vLa4V+h
	Ch6QMFzC1v17kkaxpmyAZZ9g9RSwnUQk4Kcio7zsPgC1
X-Received: by 2002:a05:6870:880b:b0:44c:ebe0:f50 with SMTP id
 586e51a60fabf-45e3eb1d7f3mr5311039fac.14.1786551700245; Wed, 12 Aug 2026
 09:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812155831.16467-1-jwcart2@gmail.com> <CAEjxPJ4oMi6HuVhPrnzOqC45j27TaN7uzhncpjb1sYgnqebw+w@mail.gmail.com>
In-Reply-To: <CAEjxPJ4oMi6HuVhPrnzOqC45j27TaN7uzhncpjb1sYgnqebw+w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 12 Aug 2026 12:21:29 -0400
X-Gm-Features: AUfX_my2osWfOSfn4xeB0mtL4bFRx2A4w9_MuclJ_rUAzbaP07Xsd89j4aY0ykU
Message-ID: <CAEjxPJ4pj-jndmE810wGNFWM9JSBi42dphfv4bZswrS1hFwUjg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Free context on genfscon wildcard error in kernel_to_*
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 12:14=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 12, 2026 at 11:58=E2=80=AFAM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > A policy with the policy capability genfs_seclabel_wildcard should
> > have all of its genfscon paths end with "*" (which is added for
> > backwards compatibility when compiling the policy). When converting
> > a kernel policy to CIL or a policy.conf, an error occurs if the
> > genfscon path does not end with "*". On this error path the context
> > is not freed in either kernel_to_cil or kernel_to_conf.
> >
> > Free the context when exiting with an error for a genfscon path not
> > ending with a "*" when required.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
