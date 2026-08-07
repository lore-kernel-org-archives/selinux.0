Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3B4756CC
	for <selinux@vger.kernel.org>; Fri,  7 Aug 2026 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106003; cv=pass; b=uGmFtTt3VB04ZnNDZSpTT9VnIULuZbiy3NwCSptTaE0M8+dMRMqO9c5Lakw9POfviNgFq+W8RoaUG72BFM3sKDPgBcCEMkTfnamJVfAcLq1GeEi45SgZml/b5CT5CMROrbl3YZXMnLu3L60VuTndzTCqdkZ5pOwo8Fl4dPexXDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106003; c=relaxed/simple;
	bh=LAcx5NyHrsAhMdewxXt3FV0z4HIy8yqpnX2anGS4Deg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTcUIs6BXnjJ6HVKpVGw26PBoRmLKS7rufW97J6aVKAM1+k80P1VNSfKb91e/EsRH/gyUqmLFbYP2UMXR6XUgqBFwArenvcYtvA9+7fk3/pBNRXWGAH0+EEGPAxdlC7N/+Zkvb9U1G5EJh7Dm0a1Ln0rBTSRj4FgmZQ+tCP7tCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B90RM8TN; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B90RM8TN"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6b031d400feso305379eaf.1
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2026 05:33:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786105989; cv=none;
        d=google.com; s=arc-20260327;
        b=ndaIrwCb1OVI5xnhuU6+ScDEBMZiIg2KtyQHIqqVJHg86mIdCIy1gSgZdCy1AAf30D
         ebO+ODQAwaVfZLcjk6HkMrB2kVqeGKmOqSUFESNwOEODdSHIlzuuOHvH97PN7J9EHMRC
         yEObW00nOE8nyjf31shfHQEt4sTj1XlzCvKHM3qAXC8kreZ/kqU0gAL2qSZBOYIaGPvG
         pY55H7x39bX3HOPrdbrl+8tDropuSCG6QCbvHCeaYhq813ypLljBdjD/ZEMw0RE5542x
         GnnnWJL332xJdDwljckqRYzWL+l7Ox8bcn3wOwEXXhokDnxvSs0gYPi2G1JBjNkPZGmP
         q2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LAcx5NyHrsAhMdewxXt3FV0z4HIy8yqpnX2anGS4Deg=;
        fh=nRnzhT6DP80pF4gsFXYam5FK82Nya5Ydl0jv/aHNY4k=;
        b=jLjEHpGnTpqA+GdIU0iwM0f1Ms5S6doUJEANRyX1FWB6pAJ7LgdQVzoebN25PbuT9E
         9RDD4Ve/LLgmvTF6WP3FSkh5Tz9wWp/EASoAm8XZ/usFR+ss0DVwWMjS+8G6KQvQz/nE
         qVTSiI08BA6LUuKqOsphhpQvZRTE/LFRRyRhN9M8zeSbmHR51Bk08y83ZuQOsCkcbouq
         FfThSI5SlNLhGlTTeTvGhW5YZdcXvQ3hybv6Ta8eoClLJeg5EzXw5XFpDn8gs/GkN+Lp
         h7EyfjbaZYHQ0Kz5FTp0RHfjJ5NbN91S/84lVO3s0/dSsFgV7R8te68/SbRu3qSqIN18
         I8wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786105989; x=1786710789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LAcx5NyHrsAhMdewxXt3FV0z4HIy8yqpnX2anGS4Deg=;
        b=B90RM8TNS50gDF+buNv4qil3Qez2lDRH0BimMFRT9mkMNY/i75nB8Q+QWj28Rqak8D
         NZZAWPzNRb9nlkAadX2mmIytF/G9uG3S6al4/utnopzVw7ygQ0k++xisMPbgcXYqIkbg
         rYnmA639mtEDtYk5oLgri5/ztsBFMAGz4SFU9xoaZ47Sb+Jf3EW9gk2rsfqhKSPAtsJc
         zEVijv7Q9Y0w9bj0uFAvbIYPLMHXs5yXSJTIAWf528KnOnZyCyn8H7Ylw0qTwJO+GHVt
         czb2/bXrKX+mVwJ/rna0ZioITA2PBlxLdS3/UtvrjJY89IhlGQjCBmixj2RY+u2RCamI
         XTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786105989; x=1786710789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LAcx5NyHrsAhMdewxXt3FV0z4HIy8yqpnX2anGS4Deg=;
        b=ocasTeie5Cg2nkshLxXCGZViT53XaDKWiFVpv2FvAucBmo58v5O4xm/Qbwijcf8tZ/
         mUhXUTlHNMIcgt4hGw6vi6t4pxaVX9c9GQd//5CXTAf04gwqVZPiJz+m/qHPsZNDDd7O
         SNCXpeIOAu8mUYOM3NH5nYXrAC8H5eWre7fgqR8KNeNGsEjY18syjrfIiCxn5jgNceFc
         /mbfQBOIuAqcjU+t86BOdTzW0HUAEjkmvvu7PRsDHudcpSdk55nEMYm9NlN8KNEMF0e9
         0hXhIboUXCTnfblVbPsC6cgO+VYV/RN+bTOJk0Nnr/ihc9Mv2hbr5TNyi2dt4yewIX8b
         U9xg==
X-Gm-Message-State: AOJu0YzLJ4svT3R8lfl5JjYjfV2cVDdHOSgDgZq/AC5QS+mfHu4IcAV6
	kDex6okibtRRU+fAv3BnrM+KiVOHhe++bwxSVnOXlLJNR2k3yIlrppfNu7y4CgxBbxRkSv9DeXh
	oIhkk4la9CBTvFuzqGsnskwmg8W3FNRctSw==
X-Gm-Gg: AR+sD10noCl3DN3mk7Gf2eGim5EHZSE04D5WujVYMh4/2j4tepXXlHohA/YCYvRuuaq
	BO35fMyKT3Wu2WHVILIbXyKN6sc8Vn1uTUh5XxOZhtw+0ZI7jE7k0jy37VJgt563Dv185CPCgvC
	nQyYwQyOxlWc+NWl9GZuhkQuIw3pa59aJy/nMYg4cBgpOoJLraDOE3oGfajKzkqepsxIhCBig7B
	wczb+P5MMQgUDhW1WPSeaFMQTbm1A0EYBd2xjAm39Gsh3IVCKvsinuYPMKPdueYJbFa9swt/CkX
	AjASTmyswiCcAz+3aLvhkTscakLP/x9y2garEwU18Y+p
X-Received: by 2002:a4a:ec4c:0:b0:6aa:f920:6b1a with SMTP id
 006d021491bc7-6ae96d026demr11012083eaf.16.1786105989388; Fri, 07 Aug 2026
 05:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806143044.42884-1-lautrbach@redhat.com> <CAEjxPJ4-sSa-9NA=FokRGM-HQFOzwFwTjPwHLoKJvy_Ky8pkGA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4-sSa-9NA=FokRGM-HQFOzwFwTjPwHLoKJvy_Ky8pkGA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 7 Aug 2026 08:32:57 -0400
X-Gm-Features: AUfX_myn0zm0G42GsohXJ-Z5rxZxWDnuSe-DdfxZH5z2XTYKjF6OoESue9fjKS4
Message-ID: <CAEjxPJ5qgVR1GFQVE86tA76magZiUV9kCV1vw78L+EDZ5KPUqQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Replace PyString_FromString with
 PyUnicode_FromString for SWIG 4.5.0 compatibility
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, =?UTF-8?B?Sml0a2EgUGxlc27DrWtvdsOh?= <jplesnik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:06=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 6, 2026 at 10:36=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > SWIG 4.5.0 removed Python 2 C API compatibility macros (PyInt_*,
> > PyString_*, SWIG_Python_str_*) from its runtime header pyhead.swg.
> > These macros previously mapped deprecated Python 2 C API names to their
> > Python 3 equivalents.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/538
> > Authored-by: Jitka Plesn=C3=ADkov=C3=A1 <jplesnik@redhat.com>
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
