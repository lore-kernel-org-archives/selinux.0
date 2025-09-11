Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD082ED84C
	for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757629458; cv=none; b=O22pZmrRb1eRTHp+fCWTlbTkHcbv74dXCRupE4Gdt6dQLD+IS3PbwpnY207u1KkKFVWOozAH9/U4I5qMzfeo0f8or0aSoN3olGQhC6GOYoH2RE1sADDFA97Cua1ZQ1mCoOb7emwS9H4/QNqN+1N7ghWiVfXG1g/RjJ+d+qsfgzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757629458; c=relaxed/simple;
	bh=TOxHreosBJoREHUrSH/7ROAH34Ey9FkDleUQJ3zjuXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOUyTNPIARRBHW+jnTTkYhgVJhdCUQsWTzYez8hi/tUk3tGACz3QBEQy3f0kCx3jSsUMlCi83MS/APrMnLLKKxxaoObSoRv4TVNEVMIcJE5CfNcob7H8vPvA4BTYGFxSY0sI+E1IJh4pnyPHcRBZjjHPrQtStS5YJfXyfwdlGec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZHz9Uczx; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZHz9Uczx"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b52047b3f19so915626a12.2
        for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 15:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757629456; x=1758234256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOxHreosBJoREHUrSH/7ROAH34Ey9FkDleUQJ3zjuXo=;
        b=ZHz9Uczxsowl9SabhL2InyavZ32WiFjBKVQPDfuF7ns3735rqGF3gkyciwuXWq9vNa
         U8IyRTE7jeMKHiW1L2xsFnJOiFhiKO4GNpyYXw6EynDuY929/HF7UK36hGFX04nu+iBY
         qkNWJzoHqly90C5rI9LVdf/gQfWDjWUWBsImkaY94QHK4iHWNeEv/+4TaBb0YWHsDcNI
         r2zDKP71OPspCBVUPJX1YVdMDzjRfA1+TpccM0v4dorya8MiTHBqYOlS+m6VGzPXsHI6
         L7qf1bymIOCgyn4OHTGrgsoVsPAvr7jryqLz7c5MFs9pR+TA1eaEh80Jxay7B3z8e1UF
         OqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757629456; x=1758234256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOxHreosBJoREHUrSH/7ROAH34Ey9FkDleUQJ3zjuXo=;
        b=ZNwnDKY+t3ToVTNOlDuwK8baBxZ85f40VhA5o0ZNLnT9gjixXqHOn/OsHSuQVA9fFd
         6q2EAgWLMnLOyHE5xbomv24xJY3LBOxiOCOYIU97DLwquHnnkDX5Y9pLurTAfeAwif3+
         9AQXmtrJ8eTZ15YK4+rpzqj6OERvt6srz4kb3oZ+LbHT27EshcFEES6vXPgs55FG3RbK
         5WX4dZcIasUj/GJuCKMy/DOg8q1lbnTc/gMNXf5uMFEEMdJ8cgdonOvvMgLASqw6+IQp
         CxDZiPDha6cn7d/XGRQBY3RNWPxyyskDikv0gPv7MFFAbcYoEqBLgOWCjQqfaG2pezDA
         HYnQ==
X-Gm-Message-State: AOJu0YzbQsgKebPs1nS+kjXYuR944YTuTKdiL/KinaiHFWgSc7tvNN7T
	bUrAcm1awa3cHrbQEipijPWjzJcHdQCQRZ7jOVWLcyAeCuuxCS5sfZWz19RASY9DscYuwZqYhY5
	6yrUi1xSFnY1cAGl7V01s0vvLk+ZnURL4aGsLW0hU
X-Gm-Gg: ASbGncvyjVHOXmA7bCFedhYQyjRHqXnu+uNUNCAEv9/nAjW6dZkCmRIgJiev/RIqnZr
	+rpXsJ29FXPB8TQXNti/x2SzcWWqdSAf4Fv1CMo90z6oDYWtJwjBuoNxRS2x58Fy4RWJyqhrH5w
	H8W4ohtWLqMuJj60Tm0EGCQCfiUP/2zmIrYVU9lfAiqbwz6AmPrIRK08cFGkYLLcvo4+6KUxbmR
	NCX+HyTqRQT3/Sf9A==
X-Google-Smtp-Source: AGHT+IFwAAU8D9+qMEnnOqzN+PqllufMoDEh+StKDbwMsV21cf2HN9BAvkgaeC+TDiDMKA9ufKYoxn/esG1aoNHXsZw=
X-Received: by 2002:a17:90b:56cb:b0:327:fd85:6cd2 with SMTP id
 98e67ed59e1d1-32de4f87920mr708852a91.24.1757629455898; Thu, 11 Sep 2025
 15:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903192426.215857-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ4ctFLY=_AUaNso_a4XJ8AziRoebR2ExFss_s3qNnYhJA@mail.gmail.com> <CAEjxPJ695zmnpiLLOHkLxt5HVPhFNRZ9Bu+o4khvFwFX3TLpVQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ695zmnpiLLOHkLxt5HVPhFNRZ9Bu+o4khvFwFX3TLpVQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Sep 2025 18:24:04 -0400
X-Gm-Features: Ac12FXwV7w6xqK--CqU45N_j2zE09QKW8-h7v_y52jV-oYM1_3xbDyMuphzE_CU
Message-ID: <CAHC9VhThEdr1F+8+FiMwMZkYROT9Lyox5Pyvf8mkBPYYRX6WKw@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm,selinux: introduce LSM_ATTR_UNSHARE and wire it
 up for SELinux
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	omosnace@redhat.com, john.johansen@canonical.com, serge@hallyn.com, 
	casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 10:01=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Sep 4, 2025 at 10:41=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Sep 3, 2025 at 3:28=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > In the hopes of nudging the conversation in [1] in a more focused
> > > direction with a goal of getting SELinux namespaces upstreamed, this
> > > RFC provides a starting point for a concrete discussion. This is RFC
> > > only and has only been build-tested thus far ...
>
> Gentle ping on this RFC, happy to update and re-submit whenever.

It's in my queue at least, but so are many other things at the moment.

--=20
paul-moore.com
