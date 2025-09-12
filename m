Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7026561D
	for <selinux@vger.kernel.org>; Fri, 12 Sep 2025 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679811; cv=none; b=ZXM9OB8jfqb8tjKsP9CNQPZN2shu3TDg+fnO5t3RT70/3I1h57UmpWsoG6bABmLyi+szYZdzg4cB5iwnfVbWqI1Ls0cIeve8NLFMIZoGUd0gK/8qxgyylBva5fKxH+uGAL4GvuCPqrmxTLTcfqgU6AOaktzvCKPWeAMt4AroILY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679811; c=relaxed/simple;
	bh=S1oPc2GKq8KfIf1Mc67HyoTZ7bK74Zl1+obV4SQ+uug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3fIMWBmWjon/x2lprCwiN9iASr6j0LntGyN0p42HjtOl5CaJEEjK2o3WktQC7sjHySxvCbazR9bYtBWNuRDXsP3cCVfD7QUgRY/jo9scpbSMJZlH4QUr/b8ykB4pq+G4UpPioNrFDyjK3VRSDaViUjG8ygeV1SroAzGzaMaRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR6UERgm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR6UERgm"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32da88701c7so1938309a91.0
        for <selinux@vger.kernel.org>; Fri, 12 Sep 2025 05:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757679810; x=1758284610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jk5aXXiLpcn48WsQx1TlS1mVz9lzg5cXcpwbqc7D6pY=;
        b=bR6UERgmjAMexNiImuZhyEwUw3WBqda9OiKsKIEVWvuAAdBkGsQOGoPzEE07UD5RpD
         XKmNq4+UHrVJvd+41k9KEBXhriwoGGkKJMnAIgTnm6I7mX/dETK1NI7s/Yv7JlGMT/d/
         BG4UmiMqKfOkWuVBXgUtZNM/phJZJV3mWhf3aEXJ+nislxIOCvaNBts0lL+1xiJ5KWGK
         1um7GAnb2YzziGHtK5YloVpZj5NczxsktMkObjz0piFBwTmK1CyLpEayUZwleGdTAclx
         YYdBEoaFpFM6YUeMV3ABMCfAgOrSaBK9Ym96XqJ6ZOII2BbtGhQzhdzAmDMwXvBz9dnn
         Cb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757679810; x=1758284610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jk5aXXiLpcn48WsQx1TlS1mVz9lzg5cXcpwbqc7D6pY=;
        b=Wnwlb3RtmpGz3bpeZTKc218U3l/AwWxBuHwJkJZya3ByHIuAWD4e032AOglMkkAqfe
         m1pAsvFWoftvqv9YGQi3X4HufQVtd+hrwB6e0skkFOezhYYbZ2S7eowlqUiPKhvGPdZl
         mVDEYGFiDLKCFFRs7gxN7O7Qe2y8NGvMQzAltCgLOUzMHzyGrZmemBEafdHiO90ntkY3
         6S/7XERwpFnZd0/XVlScOC1+i/mJ4uxIMdxAs0GDMp8s4XYq7tp2q0/mGnEMeLEBl8lA
         lzL0U3/2BOqmusDTCxLWlPIWeYd+Y1frBgzmvjLIYUiJm5KiXAZ0ZfOENWzkVIbprwQy
         3I0A==
X-Forwarded-Encrypted: i=1; AJvYcCVKbWZUINiqZv7iAJyzg0dmGDZAAKpjREDqDgnDHlHbKLUVg7czz37209P17hZBxcNTj1kOraOQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxOPhFKU5bdv1vcBOnOhry/d1iSfZ2tP1E0laeAhco/pOwWPrZV
	Sz4T9OqCUCOkphWXXDMtxvH6xypurPjEHhaQWHi1jqtzPj4SXWl2HlKVvVuw6BuFFSmj+7yvQQy
	76NCRm20fMTUMNri9XaO2XXrw2ZX2Sb9pPg==
X-Gm-Gg: ASbGnctGaMsfVYok5oOZpymhdwVRnPXkpYomI+Y3WUmcoBuM0Hvb/mMjHGPUZf8dx07
	CExtnPwDrOaWbz7Cj7tmSTMW8sHvtEJ3IEYsKIE+sv+FqrVuRbqWstrwybzm/RaDEpOnO1BfsIQ
	Ptz3KA+eBe+1Sgc8ehFjFG7j/hy4NhqM0SxSNzW3wIMCffc3+pDWnxg4FbvST8fqbHPB/XIP+ZX
	4/Wfew7Aoo3ZTeskQ==
X-Google-Smtp-Source: AGHT+IFBVy+u+bLkmXvhEFMxbFJNA24xfTduD/XNxZHgH/x+lwo5j6oeXfmMzKMjq/3IeluMaxK7RTnFHu6Ollx7nHs=
X-Received: by 2002:a17:90b:4c11:b0:32b:a6f6:9b7d with SMTP id
 98e67ed59e1d1-32de4f8c83cmr3074071a91.26.1757679809658; Fri, 12 Sep 2025
 05:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903192426.215857-2-stephen.smalley.work@gmail.com>
 <aMNVDOCjCBZZE8Kb@mail.hallyn.com> <CAHC9VhQYr_3WzG__RYs_mPtMqFCQz4wbrUnyGZeyKjCuEO93_Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQYr_3WzG__RYs_mPtMqFCQz4wbrUnyGZeyKjCuEO93_Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 12 Sep 2025 08:23:18 -0400
X-Gm-Features: Ac12FXz-6en58JzIGhC-vVkEnTHC8_1RjiAqK1v46Cg3xAoUI9a_K7ffirB-Ed4
Message-ID: <CAEjxPJ5K5Ki7uRa_aF=ULzHUChtbsBJX3nL3TZnL-Ak+G6kkaw@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm,selinux: introduce LSM_ATTR_UNSHARE and wire it
 up for SELinux
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, omosnace@redhat.com, 
	john.johansen@canonical.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Sep 11, 2025 at 7:02=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com=
> wrote:
> > On Wed, Sep 03, 2025 at 03:24:26PM -0400, Stephen Smalley wrote:
> > > In the hopes of nudging the conversation in [1] in a more focused
> >
> > Hi Stephen,
> >
> > what was [1] supposed to be here?  I can think of two possibilities,
> > but I'm not seeing it inline...
>
> I'm guessing Stephen was talking about the "LSM namespacing API" thread:
>
> https://lore.kernel.org/linux-security-module/CAHC9VhRGMmhxbajwQNfGFy+ZFF=
1uN=3DUEBjqQZQ4UBy7yds3eVQ@mail.gmail.com/

Yes, that was the link I intended to include in my message.
Most of that thread isn't necessary though to reviewing this RFC.
