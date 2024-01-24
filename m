Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED4133402
	for <selinux@vger.kernel.org>; Wed, 24 Jan 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706127216; cv=none; b=nk4753uYmJqLai8Hpnt6XknweO4Iuqje4Ia1R1uTvuJQAjK351fbzIbHrdf2Gdibvmv17KVFl9q0ZLYsizYs8oRzeyI6USYxL9rE+LPaL5qlo5qfF/xC4O05y9zstAwKS95oVf7i9TfE46sCtDrO94KkVkrbhFXEnqgfqH1F1Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706127216; c=relaxed/simple;
	bh=y1tXtxiqROgQHcZTx99aN2O25/q7fxctC3LuGmvxzuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EDRwqOn3Nm4k08bFILGcNE7txBqx3VVsdGaWSxnEPf35sDQOejU7uvNbmRM9jzj/IxQcy+WjicozxnFhzafA9qV2F120aoQJEzHsSof86gBgp0LW56/uOYQ17fYy08Zt7zBeNV4aA4WwrhGuDS301lOS1/fMrk8Rqow7JiPfnYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiBgRlNw; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiBgRlNw"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2906855ac5fso2579204a91.3
        for <selinux@vger.kernel.org>; Wed, 24 Jan 2024 12:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706127214; x=1706732014; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1tXtxiqROgQHcZTx99aN2O25/q7fxctC3LuGmvxzuE=;
        b=WiBgRlNwPW7RIlWJRle2BpWMzAZ4uICVjRG/kI0WTzDl/OqhHsWZLZ81abFroQLZVd
         s05iotjP5tWisOwrnDGWFEGIGg72OsUaQTS1Oxz0n9EoRpYM6oJvBRHYhq8ZnKgOx/rJ
         sDfrn0S7u3TMV8RataHzAMJd5FgydNONkpfAVqeS4reS3ie9o1VaXq3C38A4y1mxKGb8
         g4h34HQvkxTR2oiF1Z8lSNKUmMqvxAILxMPfbcYndbnKYyaI/5JmS3j0oyo2iLrNPgF2
         21/F+65tIiYSfQB9JDBGxcC2AXxO8Qg5EedkUB750lxaVtQuwDNXPIm3GLGrk+VleEMQ
         /9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706127214; x=1706732014;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1tXtxiqROgQHcZTx99aN2O25/q7fxctC3LuGmvxzuE=;
        b=D+oegPxXowOpWZUeccbpnJJmo3uSVwGbnBVwZmUXb8vHslDeeunwYaNQSK9c5Nbdlx
         7PTEwMHW0HMz8OahPlQlj/+j55vOAlreebiYmbfdyFXSD6/SwzP/YoNSMELqMPsZDM/g
         2wVLtNshD7q0qaNHPMJCyhF+ckQ2kG86W8JyRHs501JnLdOEeNdUPJmP9yg84ZXrblN1
         kDDjTMT46r7xd3Xxa7DZ0U7w9M5pU22YcndGfyCzVbg+k+e9gZhUgxevaNZ6KZbLKSrj
         0VZIM/15uB9KmEUmR2PmujkdQtQUoHtL4KXXAPZh2ulK7mUOMepvwDnaLoNxWvzB2OdP
         l1xQ==
X-Gm-Message-State: AOJu0YxtN7p8rDT4Brjki5csw4qQz5lvpbRABIZeAdpRL5rPBu5vSGqy
	FwSJtik2HdKFqjVJ3ZAlx8su2EK/5L1TrxVlpO9TPmLWhHI7l4y0yZlOUc6PhI2sQf5slF/5hTa
	kM7SH2SOsfNTpuGrKNJNsQ10IxDg=
X-Google-Smtp-Source: AGHT+IH7dLqM5+OKrkixpb8kIGwAm8jvvAWxvLd5F50HemK7yresXtQ9Eh/J9Se64eKgiu8TChbnq60No2VCfEMfGdI=
X-Received: by 2002:a17:90a:128c:b0:290:5ad4:db7 with SMTP id
 g12-20020a17090a128c00b002905ad40db7mr80927pja.65.1706127213813; Wed, 24 Jan
 2024 12:13:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 24 Jan 2024 15:13:22 -0500
Message-ID: <CAEjxPJ46kPOA3N7PAgqWs-z74siF7bMoGSU254dYReQwFCNoXA@mail.gmail.com>
Subject: Re: selinux-testsuite nfs tests?
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 1:42=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> So the recent discussion regarding questionable setting of
> isec->sclass in inode_setxattr and inode_setsecurity that was
> introduced by the labeled NFS support patch made me wonder about the
> state of the selinux-testsuite nfs tests. Trying to run those on a
> current kernel fails even before getting to the tests themselves
> because the attempt to relabel the files to test_file_t fails with
> Operation not supported errors. Anyone know when this last worked?

Looks like this has been reported for Fedora kernels here,
https://bugzilla.redhat.com/show_bug.cgi?id=3D2257983
as a regression from 6.6.2 to 6.6.3 and later.
