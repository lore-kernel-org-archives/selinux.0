Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932662FDC5B
	for <selinux@vger.kernel.org>; Mon, 13 Oct 2025 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394082; cv=none; b=TcNoAtGf38nHNCysMMJdfDb79jAMU69La5fUsPvNOtl+Fo2QiGievLFknLhzcijUu5SHsplNLws6UP5TDDm5uYwYEVEsrmbGFaSqH5kvmq6DzYGVGszQ6jENqD7zOGFSRav/ZeGFec0IioJxp+qB0Ngd6EuAEQno0zv26q6rVFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394082; c=relaxed/simple;
	bh=U0b2FYuoZRm8Pxjx9RsW+UXje4fkTM4H5iZ/bJSnheg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcFkEgCbCkqXRnhN1+ebTz77+1i0ZmvmGJOlUc5TGRqVSlMAR9fh0NUzBqRutpV2zOAQHGHBpf9Zs298aJlzuMipf8xYcq+UKucSn92C0ZD3gscJUVSaVtFdWg/D1lKasf0mGfXQA2oaiso1KKK+P1dAxTTRZ3//uWVEWwg8Ezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MrOsC5OA; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MrOsC5OA"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3306d93e562so4736213a91.1
        for <selinux@vger.kernel.org>; Mon, 13 Oct 2025 15:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760394078; x=1760998878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QrVvuzGQFvU0hfzvyeDbWGCHPSfPo8gC4N1w4Q3nkM=;
        b=MrOsC5OAzJ9IRIPCe2MDCDZflQ8K3EN6TvxFg7ODB44iqeYyJnyghqdlXvsmZDWe81
         uoma5nCK41up70cN272rGONwApj8becxErZze51Bw/H4tAgmHvS7/X8Rlq/y35BCb+eM
         QN6SBJUl+fUkdBJQjqZKqUk9esZVpiepRm1zBRNOASnU/boPWVgdKub6T8fMh15HOLRj
         wb+tWmfdZ3bv+fnzgH4XrXgi1a9uI4/onnkwhB5VPUzsoe6Prdi6flsr9cri1UNdFeXW
         4/S2nIHfGAArwTAzLmDcSmcsJihezWZ/RtX1uC16lpsVGqlywPpCdcVUNoXI0YSWYe0o
         ocAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760394078; x=1760998878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QrVvuzGQFvU0hfzvyeDbWGCHPSfPo8gC4N1w4Q3nkM=;
        b=TyYgXN0n6mPuDm4ifyps7lRPz2rbuEoRJcLSPK1k173ZfwOvdBk0CXDuR/aHxJFDoK
         2OIK9zxlzpbsnFgEuxa/DpV3ydDHKnJjvXSc5kOL/GcZLGicM5PE+vd70lLHLJXq/0PH
         D7uZlPax8gbjsOPD5c++5SV+TlcyCAKOfMGXGIrmoZvqsYB5/dtIZCtjxU6TBQHOcx+w
         t4lDaYl9tPUDnRj7XKZZIYqXDImBe5dQ8N4i+cbMwZYfMga/1MFud354M0SWDED2TGVh
         K1lYWhiwyxDMZxknOmcFJRo0ElSFdTooz+J4GiQIM51ChHdvjsGENgKyJBVNHlX04jei
         kbEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6paSVQ8BCvkZW6/OCaPg0AriDF1gdyx8pA3mAZ4PkvLwDZ//itxL3ShjguVNWdeM17CZTaRcJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7dH2Ww5U88DfjmTVlq2lgqKXGB0s1IskI4DszFMkm9B+bB7F
	BU0Oau+wF81RDOod6SODsLXLVhFmNEO5afby6OOr86oeHdRnPTeG5rlu0Zt4LJM0AP7oJ7ZR1A/
	aSbfpyriVAn56Wvq6wVwoluSCWygVNbo8NERIxBAZ
X-Gm-Gg: ASbGncsm7WyqE5GbrxsIgAgqnTQ8bmyP4ipCJT4G6ZwtawTVAbIcHswSNnUjGnpTezC
	GYBMS6Ks3YE8GchS1u0F4ZrNvY6eqUHFOo+/ZOLwGvWHB6OeHJuODAPFPO4uN6bGPpzROOcP4ro
	t7EXmjz9854Gr/peOr1CRC9KiP1RWB5wsLIdCyb6Gud4KpDA4noCR2oXODdfuz2DrautPJO0eKF
	PPSbEdZ3eDmIn2MEZm+DmprxAF44zY1qKim
X-Google-Smtp-Source: AGHT+IGJj6wfIA3JgS5ivMxkaZ5cevk68TDvGU+RjQzOwOxB3VAdgwaSKuY91BI4oP64o4zu3+KGLQrIUftJOPtxttI=
X-Received: by 2002:a17:90b:4a52:b0:332:84c1:31de with SMTP id
 98e67ed59e1d1-33b513ced6emr28514559a91.25.1760394078550; Mon, 13 Oct 2025
 15:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001215643.31465-1-casey@schaufler-ca.com>
 <20251001215643.31465-3-casey@schaufler-ca.com> <CAEjxPJ48PiZ5ZOZbZjka5YeiBxaWFsCufoGcY_jEztM+wtEUCA@mail.gmail.com>
 <ec89959d-c3a0-403d-bfb0-7405639eb0cf@schaufler-ca.com> <CAEjxPJ5N+vGS4rhBJmCfoW+rUnjPm7TVAC9reRmu6YCaJWTO+Q@mail.gmail.com>
 <01879779-d529-40f2-8693-257cc598dcd7@schaufler-ca.com>
In-Reply-To: <01879779-d529-40f2-8693-257cc598dcd7@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 18:21:06 -0400
X-Gm-Features: AS18NWDHyfSLp4xj_ujKY48qVsLCMXrHD6EmUTyrztEFvgCIwupjgZrcRdxU_X0
Message-ID: <CAHC9VhSBxhiTvxPpHHqZJygDTTuMWOPFpQcoMSsvZD6Bueg0ZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] LSM: Allow reservation of netlabel
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 5:11=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 10/10/2025 12:53 PM, Stephen Smalley wrote:
> > On Fri, Oct 10, 2025 at 11:09=E2=80=AFAM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> On 10/9/2025 11:53 AM, Stephen Smalley wrote:
> >>> On Wed, Oct 1, 2025 at 5:56=E2=80=AFPM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:

...

> > But some security modules may not function correctly (or at all) if
> > secmark and/or netlabel are silently disabled on them, and the end
> > user needs a better way to express intent.

This is the point I was trying to make in patch 1/2 with secmarks, but
Stephen has captured the idea much better in the sentence above.  To
be clear, the argument applies to both secmarks and NetLabel.

> I'm open to suggestions. Would boot options lsm.secmark and lsm.netlabel
> be sufficient to address your concern?

No.  Please no.  We already have two LSM initialization related
command line parameters, and one of them is pretty broken and very
confusing in the new world of multiple LSMs (as an aside, does someone
want to kick off the work to deprecate "security=3D?").  Maybe we have
to go this route eventually, but let's keep it simple for right now; I
don't want to add a lot of user-visible APIs for something that is
pretty niche.

If you absolutely can't live with the "first one gets it" approach,
look at the no/wants/must idea in my patch 1/2 comments.  It would
require work in the individual LSMs to support it, but I'd rather try
that route first.

--=20
paul-moore.com
