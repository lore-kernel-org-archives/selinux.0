Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266E92248B9
	for <selinux@vger.kernel.org>; Tue,  7 Apr 2026 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572516; cv=pass; b=I1KyWp/Lsp8hYkq6Gq5nzNl6TpVJnWlY23OzSAP2Pi8XD54Nb81Ri/Y4xwQs/sSyxw/T8S9aCvaTZfuWNG+WFIRsPdb92iNOSHHB/bATS8TBtdDrBEv7VpVOTWl41qINT7zqZgiqH442OmCX1WDa5nBxhWJxhkWEFbXxNzTBdrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572516; c=relaxed/simple;
	bh=52zpGg3kueHgGet8IztKdLA8+tZp4VM8MiDQmi08+vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKGbhMwXBPIYvxiXje9Jv/3ydD9p7kGkp0y0KSH+gaiWzm/tkNyzBaJ7A9m5J5Yq8E7ibAKt/JKEeuOiipp76uRGVO3CiJf/CbEJciULFfFQQp/AWkhWR/uAWTB4XAruqU+Y0T07XkMnQeeTW9bw3kW9M9fHHQdwzm08Ivqy5JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MSeCwIrQ; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MSeCwIrQ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82a7539851fso2256450b3a.1
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2026 07:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775572512; cv=none;
        d=google.com; s=arc-20240605;
        b=h/Wfpg9pVMWX8gMcxxCHtRSB3FYfrvMkwRzDqNLPTGP6jIXdCP8EL3v67YvKNjrdb6
         yFa5nCB+bhSk+At39qo0jN3u4rxgSa8yrTQbn/fQU2WxZ7q4xRS9zVBOR8phKx8uxjpH
         +jfKNKyKDFq+EjzNTB4MAEV/K9sIJVSRg60rXiDy7XW2O54T+znFkmjhZPZccmMJNtR9
         3socUGgWgf5YYqWEEPu6ynVmTdIHR54X+9PSLbJaUzpeByPbYEekV2AIOVFjO4yVkjdw
         GaACXYajwIzEizSEvDb44FADLHr2URqmWNSYsleot7wy1J1yBlKxUdzxKfirKmCv/J2I
         bnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2qC5HIWFMfgCC7dxk8CsqfkMoXma/koXyhFD7US+Mog=;
        fh=QwveXCl4b+G6j4Q7gOO4rrvoWAm5II4AO5d8ewRstXg=;
        b=akiwpYAsZv2oUFmcXymJf3SDwSOfEpPp8Lsd+WTWU8KqiXVZbgSd6YCAGVxOk3RgQO
         JBFXIDXmQ+yu/v8wKxK4WIW9z4wQwZmFPxhVaZSLcv4KdxzIR67bZoFrOBJav4OnuCcS
         I7C4CBgS8P59AG/11t3B2xKo/Hq2hAlO9MhoR05mCH61rrnFibNFq8zYcxNlTclUQLqf
         m0L3BVKn2caqNegUc33wmRobitLBAgVRDSKHFdOXWLlqG2pSkvcEMpN4lWRGOJ5ARY/y
         9kmqazlbmC6QbdoVMZrknhgRBy/3JYxPk44Qrjjr3aLvLFRRG+Qzw96jmoguy2GA9hHI
         54qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775572512; x=1776177312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qC5HIWFMfgCC7dxk8CsqfkMoXma/koXyhFD7US+Mog=;
        b=MSeCwIrQe235ez7W8m6HlUnnYkAayZ4Ym0rsusDeGgjvysabx79GAswgymvMDwdX15
         FZci+n28iUiJBkB94aYRm7cQN12xS5bQ2IvJ7vp9ZFzi01QrgKVQbOKHprEKQycHOx8g
         SwVpNT39z5mwh+sxkYl8XfXHIQ9jVIlGYCnWPXnZEZpiWl4+pK++qko+6KngzKrbFYmN
         zgQHd4/KTK9qCjAsNh4izeax1jtfpXnjJn6T9gERrt5c5odoNSP2z1QDpX+Z7Erj5g4t
         g4zNjphNUV2pniRnLFMWEo9qP5FZzGWUsKuGfgyxQNrK71fbqKDP8i8JNOaOfLepmYl+
         xAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572512; x=1776177312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2qC5HIWFMfgCC7dxk8CsqfkMoXma/koXyhFD7US+Mog=;
        b=qhjRZ0Tm0+MZSb0N22p/H7UffitJGpEemTu2ocSzFKHRh/wnScMyI04DRe4fPu06rO
         7J0QARwhM2Qfx5cHZaVqNN+S48FEVjNdgNURaZ9S6a0uGAuXYBrnznkBDb6IN47+hHtp
         A7+ZimxZ7ExztNKXBrbH90pWR9hW5kAKskhcisJ3fae7HPY9bGosP/Yc52JllIoj3ikc
         eas7hxU3YN30zTnrfPM3u2jUrigzjG1rni2rMvSeoWOILY0TrI2Hd/JiEDhsKi5zdoZR
         9vE4BgtHJYIxkICfOXrbnXyz+6XI2+4qjuw8Exzz8715KBRQ2VcmKB/kuxZrWTPUGAl0
         NvMw==
X-Forwarded-Encrypted: i=1; AJvYcCVuk2WiCtKday01/w9+nP07QCeIdm8D0oMfGSqWtAiJSn/7RYGmR6etJeUo31xJxlnijozMKbxw@vger.kernel.org
X-Gm-Message-State: AOJu0YyLVIuNauMra7v4UgHdneCcnby5nNh5zeMbvJHwHmQVA6BUytxu
	cs/ZJVBjBrSNIsiflXSXcrrAmKAbE+nmlm1sae6hhp2tpBIaeejTOiomlDftzvQSrX2CcQSqeQd
	XVDDO5I03hSNqkwjpjzWoMb0APGNrU6lBLbd3zXm1
X-Gm-Gg: AeBDietikeye3zLpFfSoJF6Y+TVn4GzqDJy8bbC8vAty73L+Jse3z0LHRlYI6YBEOEw
	yK+pmXXxMEoOqW/Jhu284qinJhvDP76qUOtrrlR3Dy/86yQGlDxvhU9EpGfz0Cwp9o6jNEtbNJg
	nLNSJ8hOzCa0fyJzYggkKMYHJ4ewANIViyCFXcDJpJetIOeEOBaOmzSRwTVoqyfRo56wUd+Gnn0
	7MNji+ooVJPI31MkSvtGFZliB/q9lAQKJLLXeRXnbMsE4CWDFQaE0MdBLUX/0xC6Dx0tkYuCgu6
	xv+zLeI=
X-Received: by 2002:a05:6a20:a91f:b0:39f:75a6:16e3 with SMTP id
 adf61e73a8af0-39f75a642ddmr6186836637.2.1775572512468; Tue, 07 Apr 2026
 07:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
 <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Apr 2026 10:35:00 -0400
X-Gm-Features: AQROBzCbJor8xEV12qkCxYwq58fXkfkjQP4svTBOSHpDEN5glYblz9lJ5v7xffk
Message-ID: <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 8:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > The existing SELinux security model for overlayfs is to allow access if
> > the current task is able to access the top level file (the "user" file)
> > and the mounter's credentials are sufficient to access the lower
> > level file (the "backing" file).  Unfortunately, the current code does
> > not properly enforce these access controls for both mmap() and mprotect=
()
> > operations on overlayfs filesystems.
> >
> > This patch makes use of the newly created security_mmap_backing_file()
> > LSM hook to provide the missing backing file enforcement for mmap()
> > operations, and leverages the backing file API and new LSM blob to
> > provide the necessary information to properly enforce the mprotect()
> > access controls.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Do you have tests for these changes showing the before and after (i.e.
> failing without your patches, passing with them)? I tried running an
> earlier set from Ondrej but they failed.

A few months ago I sent you and Ondrej some feedback on those early
tests from Ondrej, but yes, I also had problems with Ondrej's tests.
I've been using a hacked up combination of the existing tests, some of
Ondrej's additions, and an additional debug/test patch to ensure the
labeling is correct.  It's far from ideal, but I didn't invest time in
test development as I assumed Ondrej would continue his efforts there
(unfortunately it doesn't appear that he has?), and I wanted to focus
on getting a solution as soon as possible for obvious reasons.

--=20
paul-moore.com
