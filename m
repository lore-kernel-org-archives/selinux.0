Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BDE41B8EB
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747111; cv=pass; b=C4sqW0+NuAMs7i2/JHXN5O8Z1etP6afZpvhAlF0P51Rj7cv7JMlZOzJQFKhz9NNKXS2XXOCoYiJ6dgcJILVJRgAwcQ5KM8+gdtJmdaRftMOrhjKnrnZ5JaLnryFVhx+29o+IPzshJOATFOWvnwF/eSQhUyDCGTxK/kXxf5OCfJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747111; c=relaxed/simple;
	bh=CX535Z9pL1z1E6F4DV2I1+erK4rravbiED3+mmhGDts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtCJ+C1QVrxbrv/lZxkGsv3kd8X08UglaatFeqqd8DliCo4Wm2ccPZ+eJ1ZOGkOxCodIST4u96BjVABv6T9k+Api0l+uGObJ5b9gK0HeXTM+aS75PCss9sjbUKzEuTnT0pE/YV654HUol8jOa8Jeo3oVWho2H6QvOl/DX1VKbHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rIkfyhzn; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIkfyhzn"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb29ed2bbdso745512a34.2
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 05:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787747108; cv=none;
        d=google.com; s=arc-20260327;
        b=p1yLLAQ7asFEy3eiIPSl3nTm/4bz0axpmGhVAkghMHTvx0H8Qi84HON6SI/dR7eHBH
         hmFf5bkV7j+3xsJvKJ/SmUWcGKFhIYL7CI1n02O5dlacPCZKypcv1JoA+ot0Csc7LNCy
         c/MiGftRhMCdBfTYNgAa4ESgxRtAW7teuKJVYqxjVBXbjXIM2ugSeNhVi8+yrP9Wcp7u
         k9zrZz5MisC/4Yjx7TyVGbztDLZD+hiMY6xBUbKENQP3ucQdEZ4k0JAdHUDPQgi3rYlQ
         JZ8JPT+RmNtAMAfarn8QvGu0dg68ISYw/G20rAWZ8xTqKoOFwJlDtj1jTHPEEY9P5Q9A
         Vpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=70i4I0lUhrNtmogS+KFPnWWUPrxQ2Vfu1dpUtqLB9gE=;
        fh=7+QOJrX0reqoTSCiDyCe+ResJzkpTNgCkbawPxCyrOc=;
        b=UfdO7sOxKs5A75wXiSrAnJXeyBQ/OFXTq215Ca7PmlGXVJ+om+FP8cXTVFoCnZOkOI
         QJ2DZ4BfAAu3520rkMntRJeeXCqZOeiGuC2bhTGSLuKRfG9npMfq2OZ0RO9k4xg4URo6
         zi71SKen2J+Xnw2oB5NT7rchh9DiQR6I5ayuuLbYi6OKXn12qisbDImFCwys9uuOpTgP
         IyMU3bIDHVZIjjM34ArWWC/dPM7mYhl0Xd15ZQynI9nOxC+o95ACMmM7dyewCWzvJOn5
         Uz/NExj26iH+0M6vizkzGdqSYnVBbmSpje3vmkHVpgKDCuouYZ76WJVviYVKguJxGUcZ
         QOMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787747108; x=1788351908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=70i4I0lUhrNtmogS+KFPnWWUPrxQ2Vfu1dpUtqLB9gE=;
        b=rIkfyhznJVBD5Pt/LPVRg3++RGNAl/LKpXJUVC3bf6VGllorKCRPC8awqVrhJdnNjj
         zdnKVVaRTje+MRTTETcmQgfZCvLLlsiKTqZSXFq7Z/Kza2ou2a0VmY0AllRej8LzU3BL
         pDmZqi387HjoyrUvMNIPRtgjdi+e+1cAd9xn3nU3hF8NVz7dCwYFLgm651Q18zWG6bTR
         TM1zpt3BA2SQ0BPdvfH/RplBksccwM6zbbDfBAH/IW3RSSDYlBlnsYfobvTQeVhyWxxN
         8meQ+qf5bztyowlZsfMrixaLbkuA/8tWgUyHVZfTrTT4AVtHVQtk7tShCh5zuPT207yQ
         1aTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787747108; x=1788351908;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=70i4I0lUhrNtmogS+KFPnWWUPrxQ2Vfu1dpUtqLB9gE=;
        b=evikihRdQ+nnpmGnKRF3Cxy+ylJ+yVGTfJ6UyIA2tfJK2tH/ya5pMxUF6LDU0E2uuy
         nPE4LxcnYE0EMhXSU28Igl6qYHbtPiFUTU10mz7fgSrGfGQyviSpZvNbR+JPaTtczQN3
         kEd6YBjIswAUZgCtinQHxr+V6kA+hzE9iaYETRr0SdqZCt7V65tN/g1vucXaOQ4Yu0oK
         yGipTqS7xD/XcUkQPi1ZmzjKNQaLbKsK83qbWOWyELDfnF/JiYRioGtKhdQDiXjo16Zr
         tBCZZX3PLopFntlr88bOcXiZfJQrrr/xkqnlkv7xEixnmHX/i9dLU69BdX0VXjRJxi5L
         w32Q==
X-Gm-Message-State: AFuF++n7glF5TX6Be2qv5geZa5swxklRUlo3C4BfmZ5T+dfuC9i/aAj8
	VuLCyrmUBKKDPeUaXfEau/WZUWjsbkmWiIqRQL55WJlvhTySI/jeUGQufnp8bJu7xyf4CtN9o9I
	JwT0UHW4P/RPe7GYvsWYQnqYfm6CzEoo=
X-Gm-Gg: AR+sD13KA+tSrBPzBETt0fPfrQV/qEJRguuAotsRMegc25OxX+kykPgODjw4xTxrmM3
	FiO+8dIaI7ZTLaj7S1GYm2L2K5j5NJUsNZ6TM7LCQCtj6vluwFs9jyDpxJ2H30G3e7Fi7cPgk4V
	J2sIfQOMTDkq/U+7FDU6QwPjOMykjOK4wwR8edmchTSxaiynarvaeShzijsa8NqEIXRYvBIb+su
	Bgx6HW3963Tb38hvuLHPXemAmWJFVgOm0ep16r+wNujBjgddSd8K8Pcus9LBVSislVKs+WfOLNq
	EdF2fsYfHi+6fAfC8fu63A4buVoHr/qxFnUPk57SvDYOjQ==
X-Received: by 2002:a05:6820:c2c2:20b0:6b1:404f:6eb4 with SMTP id
 006d021491bc7-6b1a0424049mr4676778eaf.9.1787747108259; Wed, 26 Aug 2026
 05:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825130640.85223-1-stephen.smalley.work@gmail.com> <CAP+JOzRTBsXcHb2PU43c7Ar+3=RDwkHpmyGxc-GQpQO+XKx+zQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRTBsXcHb2PU43c7Ar+3=RDwkHpmyGxc-GQpQO+XKx+zQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 26 Aug 2026 08:24:56 -0400
X-Gm-Features: AcwNN1ULB0FCTsXB27n0VqqV8Hm97LWJdB4zqfQt_FGQjSpwhw2Q3P4owtvaS7w
Message-ID: <CAEjxPJ6L17b9O8ojm6jn=0QrZ2kM2qWrNCUNDgHzjQbHDTC=JA@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: fix operator precedence in flavor check
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:59=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Tue, Aug 25, 2026 at 9:06=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > get_local_type() and get_local_role() intend to reject an existing
> > symbol whose flavor disagrees with the caller's isattr, but:
> >      if (dest->flavor !=3D isattr ? TYPE_ATTRIB : TYPE_TYPE)
> > parses as:
> >      if ((dest->flavor !=3D isattr) ? TYPE_ATTRIB : TYPE_TYPE)
> > since !=3D takes precedence over ?:. This happens to be equivalent to
> > the intended check today becase TYPE_TYPE is 0 and TYPE_ATTRIB is 1,
> > matching the isattr values, and TYPE_ALIAS is rejected either way. Add
> > the parentheses so that the code reads as intended and stays correct
> > if the constants ever change.
> >
> > No functional change.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.
