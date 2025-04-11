Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B926F47F
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 01:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334162; cv=none; b=GfRlL/hMTVlWdX0I06qsN8ei+pLJhiSHSEQrgcpzK6pClnogyP2ZUkgy/wmxuimYYnM8he97/VpkgdVTmjw+91Bj2y1rJSD3j+3Uc6qRNtr8SbhN09OGC4Zz6ifPsWFq9jCxXt8D1ADAXdNGEy7Z5ylOkk5pN7HhNKNQCBEMfBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334162; c=relaxed/simple;
	bh=lBPIZgDjYNMb48Z4Mwlnz1IsLqFyEQ1b6hG4ISfsj1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkVCg2ZYCW7f/y2+ZWWg25sv/E7efh7388ix0EmzcxiBm9ll8bjh4diByQV+eViCRcsvJCxIVg0Z35VuCI+HVYv+N5yU5x/Jl7pm5Or0HSu/PLapSQdTQD8buFuJhK9rfmMAsohvT5viiNUBC3c3rc23gYUcDCWbE88hgwpzDJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EmOS1+8a; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EmOS1+8a"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7053f85f059so13061017b3.2
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 18:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744334158; x=1744938958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00loi0C+OFsshohTzr6gSdl2M7eE6uzuKOYDlg5tDms=;
        b=EmOS1+8aZu1vnj9BsRF8mYthb5aa+cCvRGG9Lg+X5ZDCWBIDQ2Wo8Z4X1OgOFvyCSK
         NkjC05TsKQH18F7AYMKuQ7Ve0JRMLMhvTj4Zc3BAv9vMiqZ9Brex5Pnx/uEPoVfj58VO
         qxifvv3b6tS1zooNgIToQ4J/vhFZEk4EDfG8fL5zZrR0AKEU1DYGNws7z1XudNfdjr7L
         StAZY+elohfgv34ff4xMhPAcPXBZ/VfKgxBhZ3gvKX9VdL9Cb4E7bddSdrdU+bn5pwVw
         WA8KaysW7jPL4QJh1LJnb8pNFkPl39AsZRZJJ/Al2iXzm9bnDbePtuZ9ZbdpkppCftCe
         nd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744334158; x=1744938958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00loi0C+OFsshohTzr6gSdl2M7eE6uzuKOYDlg5tDms=;
        b=a9bXn2Cye9ImEMQ8pCSpHNL5KhdBLoRkGW0YUxH8ncaWRLBxKcAoBOpcwHXRk+C5L4
         OdZpudpAWN3QL93olePWXeaHElctRhKKJ65f9kGUtDQ4O2OgDWWEMOOMuxQg3g+1HPj6
         0Iu7f5Eiu3d783h2g+LhrpPrz72qfqjfZyRD2VaBDXtgCk6lRJRpi9wlXj6ozxDMYz4F
         uRH5WFAbaNnlhdb6y++PL56iXvB+8nf8cwSD50EEqAidSDMeUQrxFE57ylc5ql58TE3k
         DQNr9liKRFhck3+0PDs+Xxvrv5HYqwrPk1QvifIXrCtXXgMUMRp7BgRSY9sEgzuRc9ME
         xg+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEPm6zS9NSeAwL3skVz68AjUIp/LVuUosz3tE/s7JM74aRlrjvMTLyfpsme5lt3Yy/wqIx8beU@vger.kernel.org
X-Gm-Message-State: AOJu0YwFof9vpc+yDxZ128btdxHp9uI5F8jVta/nJJlPSwIcErAOQmvk
	Xqb5AilHAZxvybXj2wWejHhXzxQe4ca5qZTy4q7ZgH+8cFUEcSB4maTkK3X/CMfhAej4TQep4DN
	XMpwCNu9BLf/babtdg0SXmgwnS0nJqCQzyggx
X-Gm-Gg: ASbGncsJQ3DZYsyHEMTagsiud7ibGA1WLrUKMzsGXOKR2JDyd4vsfPLt1LuUkWyjD3S
	ZbGZvyApiZ5IxezfLkey3CDIZnjb0g67i1kjban+8lYOTxDiZ4Fl/58cqNvmDooBMVbNjJfQ4k0
	Z16S9ptCGXNR3SRiYikNPmp5kD05cOrTJi
X-Google-Smtp-Source: AGHT+IGFQRMjV4KveohCvg0mQjBfpOondU4UQqt51pas0249PJWFesgkAqqXsRgxE7lW8QGHdZcVbAsgShQCJua7tRs=
X-Received: by 2002:a05:690c:6208:b0:6f8:c7e5:9dc8 with SMTP id
 00721157ae682-705599ea187mr16134737b3.21.1744334158267; Thu, 10 Apr 2025
 18:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-49-paul@paul-moore.com>
 <202504091639.A12E1A853E@keescook>
In-Reply-To: <202504091639.A12E1A853E@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 21:15:47 -0400
X-Gm-Features: ATxdqUEYpxUuObD3cxIQmBNboanrLKhkbyDK9XA6AouK1bP7m71B9mlRSJmg24c
Message-ID: <CAHC9VhTR=ee4SGuvDbFj-dtevVFN3Pm-tVhtMLpHsiYB24Xxcw@mail.gmail.com>
Subject: Re: [RFC PATCH 18/29] loadpin: move initcalls to the LSM framework
To: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 7:39=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Apr 09, 2025 at 02:50:03PM -0400, Paul Moore wrote:
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Reviewed-by: Kees Cook <kees@kernel.org>

Do you mind if I convert this into an Acked-by?  Generally speaking I
put more weight behind a Reviewed-by tag, but in the case of Loadpin
you are the maintainer and I'd much prefer an Acked-by.  While I'm
always happy to get more reviews on a patch, the primary reason for
CC'ing you directly was to get ACKs on the LSMs you maintain :)

--=20
paul-moore.com
