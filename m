Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFFC2AF1D
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134173; cv=pass; b=YRSkXZ6XVOLHMHRoN9xYqZ8dUDTFXNQDto9LZIMvSivImkEuKUnNEvgGeCGpiQ2D7eJVOMaH3Tj/7tSObgS3V3Wxu745gkJ/fzwWBrV1zNG/eFEa33mYXjpYlCya8vdiwBipnszA0TgX6zGjTSfwaUDWpuk+i/2Lhnk7KI2v8cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134173; c=relaxed/simple;
	bh=Zm+i024rNIkOGZFA2Xze48RBmG+m2ZBxIfypnMcdmHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDH68iU4uUR7v3qATsVWpK8bxRR2KeQ8m6HRiSObcd71lO0lNW4jErLMmSL7Id/DZCpxvLyA9Zeog1+XDJZYbvFxcX1Hx2SF2/3c2u8O1HQ+AXcbIL86NEt8ZGMVbNhQ968fTW912yp3G/gSdgrX/7MJJsN3yb6JBr9ry8whMik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWg7I2gW; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWg7I2gW"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3695bf7d082so2479985a91.0
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 12:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779134171; cv=none;
        d=google.com; s=arc-20240605;
        b=OUOZepgUdc9J/0gmBfM0mblILaaWjPUD6XACA+uWcY0/FEekaXU/86FNYPfNfmlC2U
         UMFU3LBUTwuyhGEe0m2RZm1+0GLGCtEF3Krqe1BPmUolouMyOU8vy4ufhlmy/2GGXlmC
         n4AhLzmkYJzPA2jJVtJNAHiUiolKE+XWEoihKclWqiixBt18e8YdxRa5yQBN4dWU0gQ3
         hJv1s+jXi4t6yQ3HWxjNXmjZJR+dXvyg3kJ1ip7N9UFc1b7ukZhaB5cxWUV3VjzySivu
         yzOaYihZuF3utxHCT6iLMmJodIlGu1o6mDz8Tnpfg30/gN8gwZAjahirowVzx5/WSR0I
         kvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FZklF3RGW5Df+yhJHQ23fbpccOmNRshlcLETot1EV4g=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=LPVZcFV5rdj1yo4COAhAjK/C/gVO94DoKBt4Pcol2kVM1XrRRR4lqZeihGQFVHcv2k
         CgvH9UgHeyyOy3Nuqd1V/fZQDC6CTu6irU+GgAm0xO7yuPKk8AEL3tLjsn+eiTig/vL8
         pB9t7Yzp/GvHqzp4U496shoMDTVh1a4lpaJaCXcvSDNdjnoOefVEz/+DKRjqcf8VhG7g
         1vH7JvOUlJdhDAi41ZZ7vYswIhoI4I4VIbEdxL/MfWid5WQeiw/4wYiZTGZm+AH+GD1P
         4TsOtEM6olF8Mb+LgzWygD55MPC9jAUUciuDajoSRhwCYnHNPlfQPO/tJ0n5J1pHYwwz
         QVQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779134171; x=1779738971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZklF3RGW5Df+yhJHQ23fbpccOmNRshlcLETot1EV4g=;
        b=BWg7I2gWtXIGYqSsxB+yjlQArUSHZ018eRYc8bbju2n6QDn+cXw36dPdVBgZAl1Y1E
         hXRbZd8ZhQmrj7YwLhH8866wntc1BF6sh8d18pOCi5GCZQcRxVGdjdnpla8jSMpjp0SG
         mPBMWBVX2KnQimSrR5IAJrGaR6/WF0OvhUTkT1qvOepOnPn5zqAt8lKnNtKtNojj7gR5
         i+Y7um+DI1Dbj27U+aEvkfitbTuNIQwiS51AGMRWXfJajHCcUqTIPAes3fMycQjzXaAC
         MBWtriybY2xzoIjQrBCCKrd6wKI87VkN9+p6C3DFjiZLEk1XaDWQtXFOrZF4QG9rUGzD
         XsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134171; x=1779738971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FZklF3RGW5Df+yhJHQ23fbpccOmNRshlcLETot1EV4g=;
        b=XayeEdK7tQf8Qe0DR7w7ElM4nFbr+FfjOEuJiZKP9ptiQ4truOD+lGXvbaRZ4O1tSa
         w6iM9rI4mgvJQSQUUZ3rSVLx59NVHBWFonAm5DG9iI9fWxqEkmzratLHMLNJmbAbGBdw
         hJZFv6+SXGCVHL5FUzrJXoOSHhfJNKlGpC/agTwrET1XNa8WdDs/QUZk3QQtslAkeLUN
         UIl8ZLX6Z7pp+V1gvBoBK6ojI+zjHx5zXVu39XSjVpTku1Im6DgoMibr2lo6yELEl7pU
         sRifCrOnxWYdOhKObsNyO88wDtJgygzGUSnLxZZMYhPhV4vbS3kWrEkp0BXB9u3kOlLR
         XOTg==
X-Gm-Message-State: AOJu0YwXjQ/f0djtyZyZakGUCByUq4vOaTAvrgvEiw7LsP3BxA3nzE9e
	YXKBZueMEcoht5RbkF/MvL8n6DGVNED0D08JYCkDFloBWlfoePw59F2ZjuR4SryzUvknqucA05V
	yEInoc02CJMJHeK53jj/wtszLUErmNGQQ6A==
X-Gm-Gg: Acq92OE0UruHAKrns76qtpJtLYd+1ywuRVL00etjb+x9OxeAVX8D4c2rhsprpMMkR2R
	h03kVHaBCST5bdKdciW9+DzVlK7kGIgwt/3wo+z2ZiI2F+Wua9x4MnYBPtgo3jwtoy1+AeDN1WD
	zS2m3mJn35/dL0FQE59iZ9FM5HkLFXynx+XFhcfuSgcYpiGXNlwRctkoZvIB2Nfo0iCWBGKOJzD
	lydfzAyu+MkLdsBtZ5X1WA8jSIMWWl19JxAZm0hcNU63DGSLo928Gv3dKe7BaBIB+IwKh0ZOLjw
	TEFtgaE=
X-Received: by 2002:a17:90a:501:b0:369:7421:6fb2 with SMTP id
 98e67ed59e1d1-3697421bfa4mr6986927a91.2.1779134171396; Mon, 18 May 2026
 12:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512135850.727406-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260512135850.727406-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 May 2026 15:56:00 -0400
X-Gm-Features: AVHnY4LcZt__X4Dp3s_GcZ8Ap85hk1I8oFAj4_7MebRVIlGdgal16CEqUMXhlQI
Message-ID: <CAEjxPJ7-0f3=P1tOsLpP899a07W7SZhn0OMPL7-_w9zRt7HOiQ@mail.gmail.com>
Subject: Re: [PATCH] restorecond: do not follow symlinks and do not relabel
 hard links
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 9:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Ensure that restorecond does not follow symlinks and that it
> does not relabel files with multiple hard links to prevent
> any misdirection if applied to user-writable directories.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  restorecond/utmpwatcher.c |   3 +-
>  restorecond/watch.c       | 150 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 142 insertions(+), 11 deletions(-)

Merged.
