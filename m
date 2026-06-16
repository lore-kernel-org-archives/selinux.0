Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF2344D88
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637637; cv=pass; b=QCq9siBnajENy5Nxn5bt/QSepVFQx2CC4eo8DTBghJDqBuouQHC7V7QhJnBooOSd0JKm0xgpHFlPLAexG/IFALnJSWAP4ktkyUkZftuwDGT7JGCaSgsjFOQQDdYOmnysHoo48vf90TlCN/RnbxuyzSRBkqre/ZptfL+YDaeTkKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637637; c=relaxed/simple;
	bh=o36b4LkYIZbJX6JfRWvDBTNPeD4lF+nJJL/MJJ3F2dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbUbQordz3I2Ny5E4Xicg+mtNOAqOx8ab6FwrsufEDe9bidWkRJVpDmsKxchAc+gffO4TLDiq0LOLD510RfXy9BWfMgNjNPnPluZs+O8yuKjCe0x0hxL/I8cA8kW7QguKNMsNxtIRDGW5hYtn0ipMQJrUMSoV51zruKKQszC/EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcPJcYo+; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcPJcYo+"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so3451645a91.2
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 12:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781637636; cv=none;
        d=google.com; s=arc-20240605;
        b=bxx7dggEM1CTwyBlPk0b8ftCMmcu6YaBL1VtoD3d97CAK3V8YGDHvWDTCmRS236ae5
         QMBsB+5h5/B7LzcJMABwv9uo+r10PEoQzqxOl0QXh/34NPKzLbLbViib5aeKm2TMbf5E
         MP0JBMDmWxSGBJwtLiSQN3fpyFJkBz+XQYKg6JDixnn0Bs0cv7lCp2bvLQGIVaaDBSPl
         0g7W7RuLWtkJKVenjaZr9C+6690jJqTJu/sjPtqCjkgfX+q6pfZavoeOfQjPVhKJelMD
         p0WGHEAcwFJNuF7flshZhoiUVOc/Fjh8fXgqhURwjEeByYNAJBEW2y6RD59CfMshHJ/P
         Ye/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o36b4LkYIZbJX6JfRWvDBTNPeD4lF+nJJL/MJJ3F2dw=;
        fh=jRyevUK2w2AHXbqDg68JL/TGkgAfqiBixLBAah9ARNM=;
        b=RnRA/FdtiEW2bMDqYr+/Nna+I/88DDCG9YpEniEdtBEff9/hVdi+QVfq5HMklhwe/+
         hNH00mMZ+4VKXbugcKmiKo/pLwDsdC46NEC4H3auIQlJazsF8WLJYC7/xbxxa9JKJtzX
         MgbCnwOpKtq1Ivh5ZOXING3cNlN7Fxz79iKt/U6N0PncwzFr8tk9fAup+i8xe7ulZlke
         A/Zd/MsCCbWoZrrv3Uw9m9KVrBCgmqJ0EUlZX/YEq3/FVmUQJfDa5j2JDkOMIoxLNRzh
         HXLm/DPx21eMEt3p5+daYa3djxJ6wDfg1DseB8sIAlRLmvk8fi/iR5GHSbbWXVtvZ9t9
         3mQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781637636; x=1782242436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o36b4LkYIZbJX6JfRWvDBTNPeD4lF+nJJL/MJJ3F2dw=;
        b=NcPJcYo+TdmB5gQiAAUZMYcY9pSzbtNLihFpOQdyyJVCceKQTGy+sGBLnw653DTnIg
         /gQ9ZqUbWH29aD+bLaa7yP4w1ok3Dxgkdtw708pvdsqUOejz7dSC5u5+ibAhJVHWV+jr
         ygGYrG2U3ISKtcSCQTo8AJruG86FJaTqX+63WoCxIlTlfa4MEBJxojsIIGts5Nhy1lDQ
         NQtlANF++VkNJONTmvSSNkYkNz0Vvx+pjKjbhwrlkFiyrDYF2ByJgsK6qTOaCnHilHIA
         k4kKhq2P5oPqafx6ciA+Z8OcA78CTVwTLnHerx0H0X6njq5ugPXFq59PZ0u7RXDKp8Ld
         Xv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781637636; x=1782242436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o36b4LkYIZbJX6JfRWvDBTNPeD4lF+nJJL/MJJ3F2dw=;
        b=Fqrsx7PLrFPUe952p+cJvck9QVudHt4YNJCNt935lrY9nVE4TZGIn0yOd6mr7CQzap
         TxuPjo2CqPCrg4BPSvKrBcB7mVWzzo9aUr9JrsZnBMzTziVtqnjmBWSl/i9F2HY4OaNP
         bW1kCQ4g67mW3MTHU/x+xbLT8hLZnGAniNVwtlLHGRVkfKN/fQBDZlVNf1KuhfxV7rQ9
         xEFLxegzDz6DrwJHK4ihLo00MC9l7Xku1NdWAYRiwIn/cxAEk/23HUBzDS5dPggiEK65
         MV/Evlcr3QbxWs+BbIuKiniipO6fG3xVmgEzca+xh6mlHOWDir+PYMWIsour7pTC1NhS
         OxEw==
X-Gm-Message-State: AOJu0YxqIeZw8A1KUhf9h0KowZ38+h9eV+jWPGw1XMzAgCO+vtKjSkhn
	lGEDm2KG5/xNXT49dnGO99/Gs/b86P4mTU3siMi/rYf0fLoT3gVZmKIqhuMQhLz+tpAteYjCyIq
	bkKYeRd7IlBfzwrxG1HBhVhBS1lotsnE=
X-Gm-Gg: Acq92OHvrLjlN61pC4Om6i2IzCjTmlxL7l1f3oslb2mDjbelqGS/VTnxEDskk9HvxR1
	2LD4M2wTBkcUsz7JZ4BXhFmXV+Tfy9ajbYMEAdlG6dDV3eJJtlqd+5utGogs69nUauhqc5jTPNS
	jXHiXOGOml4YCLhA22jixO+LNVAakXIoqO9D+WLzqWQ2Y+QBcU8vKIiKcyr6KzUs7piXYiyRBiG
	qAYCjrzReEDAIGifXXuxCNZ7L87vWYrsMttktWSw2gxwjiHnPlW65hT4/fJ3Wp+C2InvDhvR/uL
	8Bbzd+E=
X-Received: by 2002:a17:90b:5408:b0:36b:7ad1:df70 with SMTP id
 98e67ed59e1d1-37c930e1a19mr756686a91.2.1781637635473; Tue, 16 Jun 2026
 12:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615122840.42032-1-stephen.smalley.work@gmail.com> <CAP+JOzRhFeA=EUt4nu=Y60w=xusmB59EyZAabGqfoibR7-vc0w@mail.gmail.com>
In-Reply-To: <CAP+JOzRhFeA=EUt4nu=Y60w=xusmB59EyZAabGqfoibR7-vc0w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 16 Jun 2026 15:20:24 -0400
X-Gm-Features: AVVi8Cc0cuwRqXhHL0Kw4mTaKIymIHQWI09dXNkxqPIaFjHb9DZi4Lec3ro4obo
Message-ID: <CAEjxPJ59OD8LWmMWq_pV85GMAWpiH6EP=vcuO=E8mGUrvnOrxA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: cast to unsigned char in ctype calls
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 9:50=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jun 15, 2026 at 8:28=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: netliomax25-code <netliomax25@gmail.com>
> >
> > Passing a plain char to the <ctype.h> functions is undefined when the
> > value is negative (C11 7.4p1). On platforms where char is signed, a byt=
e
> > >=3D 0x80 from a module name, seusers/file_contexts entry, CIL identifi=
er
> > or IP token sign-extends to a negative int. Cast to unsigned char befor=
e
> > each isspace/isalnum/isalpha/isdigit call, as libselinux already does.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/pull/525
> > Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
