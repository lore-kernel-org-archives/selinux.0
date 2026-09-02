Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E0486E6D
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365752; cv=pass; b=bIV8ghkvP1m6ea/miVo7idMHsvzgwT16yS15OsxL64sUkE+sGkIFqjTj8Gla79Rf/k0NRyMEPltRWNxF6XXsbwMALhMF38dbTWwxPRS2QIIb3gx5HsRPJiyQUcWMZTxre/CZeh/T0+eLMk2e+7AnSCHKHsWdmr2My9gdMXPVRyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365752; c=relaxed/simple;
	bh=NM37Cv5bp4WtYyolge7mrJ9JjdlD68GCMUG+JwnmElU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtNFkXdfUDPwEj+y0dQUhSwUc2cyqpRaBrodNn0QlQyq95Clqt9noxfNqe14jHLOLIJxFYyZBhANhzoKlIWOh7VPHsPuX0rpgYu6uy6uJTvWztwpNG1DmIeX/Os1wMmUXgZf1CrAuD0Dxx0A/R+9hhBmS6SbqJhT26/wdJ24agc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTQdJD41; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTQdJD41"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6b1b1d128a0so24041eaf.0
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 09:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788365749; cv=none;
        d=google.com; s=arc-20260327;
        b=eVOqgDWsD7210H3wiCnT2B38Po0492L27GYSMBU3VY7SM7uNLsp1FX43tyP7WFIYLe
         8oxf/IJ9wA/MF82/yoEeVdaiSXNb/L8g2Z1b55iBfS4Q+DHsQL6av3xj5XPwGxEXe2k/
         c+Ov0EK27WIG538LMA5wuhOx4suyaOlTu5VTCt5Uo4+6qsJReA/UXXi91XgWzhL8OfIf
         JkdEdoSl3hDiJodcGSH6U2pQbIFjevwzkvlzaVn6xpIsgb757hz9GOUCU8EZDqbZAtTa
         c9Na0WyjShvuFXAY5j2oG4y+yOCGqM2vXGGYF2NdSdMqenNxr1cB0zOzNFL2bpH/hkCI
         Hmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NM37Cv5bp4WtYyolge7mrJ9JjdlD68GCMUG+JwnmElU=;
        fh=XCM8fo7IfM89sTn06SjGxcUqBXOhXzH4qY9c7awlrP0=;
        b=DccE/AW6BWdYulLg2ff8hrPYtwNuH6sHQyl+yNQHZajwx/TpXOhOrZJzYiW5uqzjHW
         6n9/0uzou5XhM+0qPBYlH6Ap5cJt1P7uk8UsMg1sAgpxGIFcVs4vHDyuU0/rKSxE96yE
         SfneXGUCf9bqGCqyAfypz+odNix3mti1RFPwpYlRLi9gICir/5hjQ8WK7py3BkWpt4qF
         ZL8x1RRuRBwsyqkfnlAsCKKItSHfkhC+OyLBCnqcCN+hIxuhcUDXUAP7U9Xcu7r7IkgA
         A2KCpCWZMqLmGy6u99zEsiUf70cKmPiAMZE5Y+f3qrYKq/r9XRX4SnI2g4Fn4MDXWnW2
         i5qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788365749; x=1788970549; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NM37Cv5bp4WtYyolge7mrJ9JjdlD68GCMUG+JwnmElU=;
        b=qTQdJD41buW9er4j40168FGXvOUyeX1errqkA4dl0ZMKN73WjPHgi+s8umw9lmy5qY
         ALeBDGTYEXiCw5D44YGCRu9ttWIv0z7a7dk19ZGIrqNjrJguYkKKtd+Q7IyhK1DOfQUO
         UvY0d7kFT0iAq73h6svD0Y1WMR6uHtluayQHoOpBNlrf0FnpxJy/3B5gjUjTkcLDED4D
         5LHBKUUb+WtudHpgKRn0Uuc2K40NNP1RMwLn++UteNbFc0y4xU4txahFEDqj71VcMABK
         YWrmcitjHLvYIV5FL2BO1156Sp7zIScOvOTOWATVKmkUD1dDuOCHeLxAsfEjgtAUCPlm
         mx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365749; x=1788970549;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NM37Cv5bp4WtYyolge7mrJ9JjdlD68GCMUG+JwnmElU=;
        b=peeUfaGfaJctTaqeiTAZpw3gWaOmLVL8Y5mefK59GjA7+4bQOEBIMCoKrF92ZdHFmm
         6weppIGw5vb8aQdYRyQ2D1sYYPFTOqOcLicT5SVBIMyvgn5KNwZTWiHYSrrrbzK47EUB
         YzPVo2dRVhD2rs5JGZYRgcqBPTFlliD7bRdPz8DMiPUSU+rRGzVcUJrX4ww1NAdGbLd4
         VxMIQSQhI9wJh7Md7c4DOjT/804iYYs6mUzoEXY5i6P9alLPFwtLxWXEJNzACdjXPYfw
         vLsOG19GSdRvxuulloTn3RLApfNVcXqLgL0Ut0ieBzfipuxmWUSD0W3xSx+gn1flgVwn
         7bsg==
X-Gm-Message-State: AFuF++nEdUfkucZnUzilgP9YXlyjXGLpPT3fxlfmJOzRwgyKieDpiWot
	84a/DlPC8NHw7LEeYo7XfzwkLS03K0qZmfhBen6lcMXn/avV++0RWk5yj0iWBlhxJ2DIN36ONRG
	6j3MaCexmNR+ozZr3YeMHbs6XXp16EJw=
X-Gm-Gg: AR+sD13VD/xLGrJXfaGzc/ucQKDttG6f5q9R/7t186y5FGHN6RvbQeR7Y7+zveG8NOT
	4AgDs7I07F14AE3ibo+kfjhWt7OHoR4lZj0PfpCba/yHeAiPTzGfdYQUdvze9FdS4Hozqya7hry
	esgD3IFojl7sHPUT+wQGGOGVGDPPnv/CR57juR2eC77zS7CDG8PolCw4GisxqoQiddSkGegr3wc
	NUN2XPwyFPAQnyRMGzhk6yQoqi5mFE1wuBJtJtn/ac1TRdJ5pgpYkgU2Xu5XdHM7FpJX5fO0ROr
	exfpbTzrF5ZXeznmF2T3IRruJdGN84DGXWklMotQ8As3
X-Received: by 2002:a05:6820:1886:b0:6b1:3534:a5bf with SMTP id
 006d021491bc7-6b5854bb7c9mr201672eaf.14.1788365749196; Wed, 02 Sep 2026
 09:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902113834.2886601-1-vmojzis@redhat.com> <CAEjxPJ7HOKL5RSO9xSXO=ZhFfAA5kNQr-Qjggxrg0bQbsTsTVA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7HOKL5RSO9xSXO=ZhFfAA5kNQr-Qjggxrg0bQbsTsTVA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 2 Sep 2026 12:15:38 -0400
X-Gm-Features: AcwNN1XkCXCmBHhZb69ajwlmcj1IICtB-o4mKRzUWS0r5vyGzkRRqFxNJiwKDyA
Message-ID: <CAEjxPJ5rhYXh8FRSXhoYryM3YLWT=+BARBTe+xQf+XSYCg0E7g@mail.gmail.com>
Subject: Re: [PATCH] libsemanage/genhomedircon: reject users with a relative
 home directory
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 11:21=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Sep 2, 2026 at 7:38=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wr=
ote:
> >
> > If a user's home directory in the password database is empty or
> > otherwise does not start with "/" (e.g. because of a broken NSS lookup
> > or a malformed passwd entry), the HOME_DIR template ends up being turne=
d
> > into a regular expression such as "/.+", which matches any path on the
> > filesystem. This causes genhomedircon to generate a file context that
> > relabels far more of the filesystem than intended. Skip such users
> > instead of using their home directory to build the regex.
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Do we care if there are other questionable things in the user's home
> directory field, e.g. regex metacharacters?

Thanks, merged.
