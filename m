Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D9A302CDA
	for <selinux@vger.kernel.org>; Thu,  4 Sep 2025 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998154; cv=none; b=u4pv2doo0s/GTLeVycjc0WLobo5ysE2/Sm2QcqEOjsapqbk0gnu4Sp+tr4q/O0x0T7xY35iNvo7v1kNBvX5SVfNvK0oyYd6QFR2bqMltL0If7qt0hK0n/CxvGplGhuNy+XrPDxblVk+0r10kY9BfRBAAd/0RHVa2yc4qP2dYiVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998154; c=relaxed/simple;
	bh=rQOdX11fY/fHZi+K6bP2GDUn5CrvijThfPeD38NULhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3Kk6fVK6zAvS78JhUtxyJIqYx3/wqulyNFc0MRvqMKmW6+S3pG1FfGwI0XmthALgzvcHyls87QP0GlBzL3vGy2GN7xRtGmmXNPGDOja8qnRT5+DFzZyGjdn2+3vvfJHvzmR7FhaZmR+BgEASOU9FWgtNYckhHhPDB5zVvTEsLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aFgTvYM4; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aFgTvYM4"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32b959b4895so557531a91.1
        for <selinux@vger.kernel.org>; Thu, 04 Sep 2025 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756998152; x=1757602952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxzYkAAG6UMXz1rkSuT85nC3lEMgcvO7jfMiH2T8sZ4=;
        b=aFgTvYM46urrRm5ftnbSp3MRQ9PEZy54WdzIwcXg5Nlt3jwlWh+22oAN/md0qmjnyS
         ui52aM00/N4PDSUgCeXUgC86RfpBAOQZBqeLnLBuMMI3b2nU7F83J8yMG9NM1oyOWbsV
         m223mZEJES0Awb4MNGeNpSAiR6uZLPgFd9dDm6YpD66sW/2ONtPd/DMqBU4GFKQ+PpjO
         lyI1xsNzySudvDIN1nwM9b0JxyWND+H3L9q6XKtU1W8xbxPW0n0DiJwyTH1g7YW0NsVO
         tOITLXiwSgnDJugc4lzJlcwNakhYqzakp6j/1pf6B1GNOk1ZPqE7lhpTAA9Kr7EYD/32
         ZMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998152; x=1757602952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxzYkAAG6UMXz1rkSuT85nC3lEMgcvO7jfMiH2T8sZ4=;
        b=eR8bfyVI/TKLJ/+yovKvufagQbwmWNqZ5DpDLpg2qXLB96BLGssecG8ZKPAaKIPozn
         8O8v+40u9juyTUhjyQ02/1xtlucGbA0SE0O/KtcOHk/en7juMQNRVN1p+w88/LshoweZ
         E5Xses88aJLGUfXD40+969pajq4jBmxlPJIXMUpRGg5p/TTm+bG4H6eCDQuIppLDZRzW
         PYGU0rbBifBc1AS5pu2VR8RR2rMC6G5RPbtuFnH08pABBIfOv/lSMlIAAv4PaglRPq4O
         P7aYJnDIe/ZPEluLgx4XJSARjdt/40+msxaDk9l5JPwG6X2jkVUmBur16i+BSZAc7TeU
         ZM8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQCIIqXEQwD/0DEB8Sym4VZA4hAZinIaoUE+ioCKqkz57+P6mOQeEqns685bDf7tqSHNi24ist@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6IYjWcBWSuFznx5A38huaBOmVBoL9uas8/RM88fn0iekv4qVd
	X9Cy9bklimOG3YFfOV1wFyhsAZYd4PdKuk/UL21WIWK3ornaAZqogqKP88hj0PyCR9k5fNSIyrt
	5X/fBfbX0YZTeP3C00zy1dSFiYJ+PvQE9SPMEigeh
X-Gm-Gg: ASbGncv34eIEy+Z44a2lEvxE1tsTR8bUg1Ne1baQh2MdZ0K4zrWqUjY28x8W26ZhBxU
	2ghYYhNOqtHsoFiDghAJshER4qodWNBWUkyvfTRbXHz2IElfMhW9mzzljPz4iFsz2WuyV+lvZ7U
	20Z/X0JdZL/NRcPH9E/ScQ9QVH1DuDRMySPATWJHDe94pKU/uzLCRp8gwbRsewvLoKm0p7vChkk
	YTw5+o53fM1Ew1lzw==
X-Google-Smtp-Source: AGHT+IEAZoSNI5gmsQNLG4iinYBMixnV3r+PQLV6m7zWI3vUPz0UY1/ZKtvhUIgn9uhbzTEGs0/nEBkt1LBYLBY/o3I=
X-Received: by 2002:a17:90b:3f8c:b0:32b:656f:5a66 with SMTP id
 98e67ed59e1d1-32b656f5bebmr7026394a91.27.1756998150183; Thu, 04 Sep 2025
 08:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-63-paul@paul-moore.com>
 <CAHC9VhSf=zo0BkTc_=Qqq59OMVHsMUs_OqcmSUK501LYpAdMYg@mail.gmail.com> <3be8c5b7-a5d1-497d-8fbd-c74c1e22034f@I-love.SAKURA.ne.jp>
In-Reply-To: <3be8c5b7-a5d1-497d-8fbd-c74c1e22034f@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Sep 2025 11:02:18 -0400
X-Gm-Features: Ac12FXwxDMTMo82EEp1hf0-OQH3hr6NRJdWpeIuq7lmxwN7eWIeeqwp0bLdTBH8
Message-ID: <CAHC9VhTJp91zfyz4C2jU8WFDH50V0mnEVGLcZKGhaVm6XQ_L8Q@mail.gmail.com>
Subject: Re: [PATCH v3 27/34] tomoyo: move initcalls to the LSM framework
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 5:53=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2025/09/04 5:32, Paul Moore wrote:
> > On Thu, Aug 14, 2025 at 6:54=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >>
> >> Reviewed-by: Kees Cook <kees@kernel.org>
> >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >> ---
> >>  security/tomoyo/common.h        | 2 ++
> >>  security/tomoyo/securityfs_if.c | 4 +---
> >>  security/tomoyo/tomoyo.c        | 1 +
> >>  3 files changed, 4 insertions(+), 3 deletions(-)
> >
> > Tetsuo, does this look okay to you?
> >
>
> Yes.

Thanks for reviewing, may I add your ACK?

--=20
paul-moore.com
