Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98674E237D
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618095; cv=pass; b=H/BPGtX1lh4TJyJrVVVgLfLXYEQrGFOqGtPrIx3D/x0El4mUH7FXSs3Qp7wpSaaiBJn9tyja0kCN18TfV/mPhY2EgIqDPCPXlhrHCQ0El9GGowWQIuMteKOWFN9LRkPaHon5C63x9The+TVUM07ZrdwLoG6IQzF4UajrPRvbJGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618095; c=relaxed/simple;
	bh=sb6Yhtd9OThMzPjDs/Z9GpHMhl6Xo3LJGvg0DU/5KrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAlWRUPbktzspzF7o78QpubZoh08zfuqQW1pJEECMg5QbRGaV1NzEKAjnWuAKsxPKZqIWnu99Kd2Fv9EHFrk349LPUBUwD+J6+oJcMu8b9Eg+jnHHhtxfaU3bCQaI7dFqhvNl4OTsioFHu3+x+DtRV/3xCEJMlXIRVHpJeipNQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GinR3fOu; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GinR3fOu"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a859892080so26356517b3.2
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 10:54:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790618093; cv=none;
        d=google.com; s=arc-20260327;
        b=Vt3yEB64NG6lU+JmNZoc2+PIXkRXLlXmzCM1m2mbVX5DJxedln2Z/JYavL+RgU2Wdx
         k2o/qT67ycsuvuSNY9WyvWWyUV4sy6v5cUCbWCdl46pM3+kzxfL/BXFVSwpLDwbJ3D1Y
         Zs+LB+DMqxUwsOUdJIQ0p2Nmh0CvYYZz+8iqtjTeD4ija2bE8Hrwyta8Llcff9h9R9mT
         vJBT3l6wL41ZdMhtnUNKOUvnHgA3T8AHvh5FPNQpjzS16nQlkMHXpVL9AdB0zG7vLWqL
         R21niG68eXBpvz1IPWQiH9cNYeZ+iJ//dUHmeXAmeQ94WAInnytOtwGmkst0dc8vfesy
         Kk4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sb6Yhtd9OThMzPjDs/Z9GpHMhl6Xo3LJGvg0DU/5KrY=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=E27l3MYTJncgXMYgVcpBvk0NLe8973s35NO2BGR6KCKjXmahgSuNYefAX0aqKZuYf5
         u8ASziVYbz6FHSt8bFmS2WH+o58Sabh85E2cRDgRDK/B3ZN52KHEDvCcopWG5fSWRDDX
         q851C+yUIb6Bzw3P2J8zRbJ7QFNrN4TFy1iHzOFBTmXxpKoR45BoCqp+7spFQ8EO59jP
         KKASf+1LFY4S6m1WGrePoCD06aC3eoe4qSHZVAfB2U7FJrOmdWy1+F8iH9VeEw92xeU1
         9Ucizh+KufvOhMplYESAu+pUtlVRPDTh3ApD73Dko3p2WNEXQMRFIpokypF8kM8PfaWf
         LmqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790618093; x=1791222893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sb6Yhtd9OThMzPjDs/Z9GpHMhl6Xo3LJGvg0DU/5KrY=;
        b=GinR3fOu8btQ3NPTG9uepRE3DYbTafIKPGa8v4aw4xEqFs9yF2wWvYPuvzgMn203hW
         Bhz9jBTWU1lWWq8diqIfOpaKJu7Os+N5gRuZHs8CTY/2olFE/yj5jF5tl0IwV9yrQMXD
         1d21gOWkKkVC9CxWfRU5IOi1B6pfduSZMpgL48bas8NbCKxIYnSdAQVKOI2vws/LHqOw
         FZcg4gpPNa9aVviTqEXJaJprH4eWnvgYICiFrvJtvwSyCMFqXUi0E8L9UOto5rWPvTCg
         D16lMTxu/jOR/Pbblf+YyDuoa2rJA/fKHjtD94xzU4qcDXzsOn9Mw4wvKVne6G51YqaE
         SFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618093; x=1791222893;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sb6Yhtd9OThMzPjDs/Z9GpHMhl6Xo3LJGvg0DU/5KrY=;
        b=xqucIHjEi61QLqRQxTvsmjLtX6kcXAatI/CklQmUdnuJ2juOsQJ73yO5wCYwO99UP6
         bKAFA+ePFsL0m0mDcOm9v2fsawEkBCfoxSQH1jgAz6nrV1UekrMThlcl6M6mc90Zv/4Q
         qTlVUXMUjJRTWBLhX2MGcawE4qrc3S2fh08QLrhXekZnZNEgqX1tfQj1ZB4Vz74ENBTT
         sHWmxmVzBhmEH1G8LuyUaS2iN9YtCOCf6d1AsA80v++fXkjMzgyVH8GJLZ7AWz4e3n8E
         VdgusnCUB/VNlBuIxX8KT13HygztOKx5HYIMm4WpOBmAoBZnuGj6LN0vPKrik4xy4hu5
         J5mg==
X-Gm-Message-State: AFq9FYJFjgvxKDqUXXjTNbAuxUKOld4rHFvfmUR5gZ7pF+qNpGS9EdyJ
	uJhKX6UC+ynfi5nwzsHSBc9hTCBrRqaZ4OtSmFJ1A0V/nwILvNHJm3el7SoAr/TRb0C7wtoKgZa
	KrzWc1LPVJKVCF48nf9voOQiGjL5uMH0=
X-Gm-Gg: AYBFou10lqTxxifPYivM0ROYWXzFXYto1M8DjLrj4+KoMhCF2NDeeORWzAgRazAfV0G
	cWDRRvOXgXKDWncpZKavwZXxbdsxg+rgeRQwxlIvYnLyh2OBYBLszgVVKpntFL+a/aetm8+3R5R
	0sbVlnulqMLcgZHetsogBRMyG9iDKWjVJFmeLgeSXyQTWCXLR/33LnANWYrd7Mugaux13dP/UKv
	F0vq7XlY/xFCt2OMjC8+/zefDHOfZLJMEwJanJJPtUovCuvmRS6woH1vfQeB8CYoUIPj2w44P+X
	QgFQXi4l6jecGRFrP9yVr5JagVwIV0ehjH86k5hANhVu6guvwFdAfwirQn5z2m4+SA==
X-Received: by 2002:a05:690c:c608:b0:873:5bd1:98cf with SMTP id
 00721157ae682-8a64ecffbd7mr43320427b3.65.1790618092942; Mon, 28 Sep 2026
 10:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928165253.2388012-1-cgoettsche@seltendoof.de>
 <20260928165253.2388012-3-cgoettsche@seltendoof.de> <CAEjxPJ7HzmQz5tfwCgru+qWNLpC4mHMKzQsOXKhuGJFUCgorRw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7HzmQz5tfwCgru+qWNLpC4mHMKzQsOXKhuGJFUCgorRw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Sep 2026 13:54:40 -0400
X-Gm-Features: AclHuK_G4EdA1FL2xHeW0tzNonSYMYX_6F-yw5FlZlCmdajhxP2n2qeIBOh1YyM
Message-ID: <CAEjxPJ6aWQYLrVdxLcEO6SNw1DbR6LQ3URXszzMsjoR715gxdg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] selinux: bounds-check role and user membership
 bitmaps at load
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 1:49=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Sep 28, 2026 at 12:53=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > role->dominates, role->types and user->roles are read as ebitmaps but
> > their set bits are never checked against the role and type symbol
> > tables. A bit naming an undefined value is silently accepted, and an
> > out-of-range one is used to index those tables later; in particular
> > role_bounds_sanity_check() passes such a bit straight to sym_name(),
> > reading p->sym_val_to_name[] out of bounds on a crafted bounded role.
> >
> > Validate the three bitmaps in policydb_index() once every symbol table
> > is populated (roles are read before types, so this cannot be done in
> > role_read()).
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

I don't appear to have received patches 2/3 or 3/3 as of yet although
I did get sashiko responses to both.
Not sure why. Regardless, you or Paul can feel free to add my Acked-by
to the ones I see on patchwork and lore.
