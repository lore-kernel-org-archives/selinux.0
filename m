Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF91E515
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 02:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744338668; cv=none; b=BHzDJWniWMlOgH9pTS+BHyeEaK3rDCeZupOK15yypW+RuIK4gZmSCBgW1huUTIDZ91G9FtJtXbypFii2mIZM7MrjpT5O+I9SDr5g4ycJlMWn0VsGV8LUfmcpi+9hFkaHgTYP2S4p+TTJB3vcTQ+DFdgrpZaGFUJYB7WRd3b2//w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744338668; c=relaxed/simple;
	bh=cc5e2N+6H+tcjGaaKsPHIo72TMBB5vvw4D15hIgSMjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nePJlHM66sfsTJnu5liNRly2PK4IKqJvtRS3AyHHK+gasBtH3BBz60MfWiVQR7eV/UJWB4iPiylDzWvOKUwoF23tQvxMyzMstYTphHAZDqbLVmobgAni0mpkU9Z0+UELiKU8BDlNbrhlVPlqaYxJxvvUlww+adjmxoxEyf7YCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XMqmHjqE; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XMqmHjqE"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e6dea30465aso1323614276.1
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 19:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744338665; x=1744943465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNkKNP1Bw20PcmRVgsTkFbGsUkto8dq13qXkhzYeC/4=;
        b=XMqmHjqE9jNbfNBmZiGBP4E1KgVEZoPdZRsjgQnNvlM3tP68j0vZTY9CeeG0TQMYtn
         5mFsZka8dDK/A9OzrioKY/jCxyAuCyatWwHsZ3ThbJktpeYwwwPr+c3RsTWqWkmsj71+
         6gBAyQRsZkiTbUFHcquoHLvBHFLRAabreijy9c/WiQrJoOtPrtyuu7PLx8koYERMe91T
         fYFt3fqbn6GXUBfyM/ySKqeArxDt7/l289hCRVsD6e7y9JetyKYkVTRGy8KlnS3tSTmS
         iQH5NvG2gl4zL0DHaf6WGMyw1uaS+Qu6Rn3giyUAbdKslQGo5bPy31qbiurG+rYnubDi
         WejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744338665; x=1744943465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNkKNP1Bw20PcmRVgsTkFbGsUkto8dq13qXkhzYeC/4=;
        b=KwYecxm+j/86JZWniVjpy36l2sJfsD6eEBtLMYqKiDUuxyiZvVIQQ9AACpwHi+jVLo
         jLWfaPWSllix0UHVBd802LPUIjK+qhVwI7zeidDzrhM+SUcVtM+SbXMe/MnPaZIbCreK
         NZ4WTTzjAfd72rTRKAGjOieJBeRX7zvPDwwXsNtPBZiQNNdwXcmqBVrEnzT9dAhNRyj4
         OyU/ymn4jMX6ciR7AJy7/lb8yn7Fkc+DFNm0HDRuTqmRfciYeFdViQHyeftVQIa/QSWO
         02GEFHdNFh6E0353Bskc7BIBKW9ZKQBivcvBzhKzV8cuAdFdMc+vR+LSn5ULzmlHa8co
         tSNg==
X-Forwarded-Encrypted: i=1; AJvYcCV3NKVr1ptId4mPd8Vspeg/pLX7lgrQpQqJZZ7vAJ5dLuU0fPaeaNXsNJlvxNfcIBKBvHttR4ij@vger.kernel.org
X-Gm-Message-State: AOJu0YzoHDuhqkvohl4Icn7I0x+0Wz/SHqX1EPM026CqYTSvBBvMO5Pl
	mer3Qb046GwlLQ3CQF9Yq+bm0L4WYuUKyQUORtXwz2GI466dgEqhssxomJdYezzxgQC8TY1k5Ou
	3XzlzGhd/tQTT9skmQdRJyhmJHb4yTp9rOkub
X-Gm-Gg: ASbGncsfel/QSL25msyY48p2vQk8fjTO55+60LzGelkWby+tGheHfRAfhzqhuiVQpo2
	DajGpn1i49cSUAkwg5b1aLZ8mg2fYTmCe4dTV8BsMX3crMR54cJBEbvwmmvarLXvGGdzenH07Ah
	fP1Xg1mYn5l0VvfsK60P3AEw==
X-Google-Smtp-Source: AGHT+IGLmFFovthkCzz9zBGQUgYH6D8PODA4GkT138VS1bTfJxT4nmfLax5WnRDWztoeEsfK8XQd5OQOr2/L7Vnjktg=
X-Received: by 2002:a05:6902:2849:b0:e6b:834d:f0f5 with SMTP id
 3f1490d57ef6-e704dfff761mr1728571276.39.1744338664834; Thu, 10 Apr 2025
 19:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-51-paul@paul-moore.com>
 <202504091641.738FECED@keescook>
In-Reply-To: <202504091641.738FECED@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 22:30:53 -0400
X-Gm-Features: ATxdqUFcx8JbctC3F2mPuvKMKmLPfNyuoiYJRtlnAQbggL6SjsGiuCMVstB_u88
Message-ID: <CAHC9VhRZqdrzkiy9CrK+a8GT+vToymU75kH64fP7XOnp=76nYQ@mail.gmail.com>
Subject: Re: [RFC PATCH 20/29] smack: move initcalls to the LSM framework
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

On Wed, Apr 9, 2025 at 7:42=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Apr 09, 2025 at 02:50:05PM -0400, Paul Moore wrote:
> > As the LSM framework only supports one LSM initcall callback for each
> > initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
> > wrapped with a new function, smack_initcall() that is registered with
> > the LSM framework.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/smack/smack.h           |  6 ++++++
> >  security/smack/smack_lsm.c       | 16 ++++++++++++++++
> >  security/smack/smack_netfilter.c |  4 +---
> >  security/smack/smackfs.c         |  4 +---
> >  4 files changed, 24 insertions(+), 6 deletions(-)

...

> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index e09b33fed5f0..80b129a0c92c 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -5277,6 +5277,21 @@ static __init int smack_init(void)
> >       return 0;
> >  }
> >
> > +static int smack_initcall(void)
> > +{
> > +     int rc, rc_tmp;
> > +
> > +     rc_tmp =3D init_smk_fs();
> > +     if (rc_tmp)
> > +             rc =3D rc_tmp;
> > +
> > +     rc_tmp =3D smack_nf_ip_init();
> > +     if (!rc && rc_tmp)
> > +             rc =3D rc_tmp;
> > +
> > +     return rc;
> > +}
>
> This retains the existing behavior, but I think it'd be better to
> evaluate if the init_smk_fs() call can be tied to the fs init hook
> instead, yes? Then no new helper is needed, etc.

When doing this work I spotted a few LSMs where I think we could
consolidate multiple initcall types into one (or two?), but there was
enough in this patchset already I decided to leave that for another
day.

--=20
paul-moore.com
