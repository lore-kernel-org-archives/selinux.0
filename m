Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D638C3769FF
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205333; cv=pass; b=p3aR55Fh6Y3MeZEF0vQPjHAZsxG6+tKF1sAnEXh+Lgj3/c4c+dfkH7+YqsPpS2umPqWhYMNMZoyt6p5nyXY7VwFr5E6BgSezxh7lppUDVZ/hfmBnxGoBYXHZvzCQfY4g05XR9nv+3t3VmnGqyuo8l/5AfZmraCPK0fpbVzn9vQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205333; c=relaxed/simple;
	bh=NrytHuDEbkSXRzI2xvmMEyyTtyyolJ6qgmwZhazAWQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFXGSv5+/xv7OLnUD6l+QYKr7SBfYOs8kRFPHF1imefFD91F7QllGwvlwChPa7qDqI9+rw+1SHPmH2LjN/P2MShhK2wDkPpXe7i9KPvb/SBObDiur+cxvkonNn9aKPs+ocaAo/d7+AKCrf7CQEewXlPI6KOQl6iyXezRm5L8d5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fqr02jY/; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fqr02jY/"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e04df8c46so103440b3a.2
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 12:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788205331; cv=none;
        d=google.com; s=arc-20260327;
        b=KbQKxE/SnDQHdFTG29Gu9cECBgR6a2bJsE3f41gQIMw9JKAeVDW7Zqo78b7KW3T7wS
         0Sx4IkBeHN2uMiqAM6i1Kt2/2PbSk2HD4wkYUyu1sstpo7AZAtPSLd5I99ZXK5yO7Dei
         e2Bvow5wFcef7iH7gTz7uU3CUd7EuFKc0yX9TbUlpEr8Aavb5v9llsNDGbWXfmpTwn2J
         7XUOcHjCKVhX45sOtzj3RJtqKX5jOl/6/kzx3N2Xz18X9bggrKSi5jigGbx7mSF5OHMG
         iXBTrS3y/jgh7v3G72Ol2aZKBK7jDLiWZXbH9B8NZISmqOZOPKpNLlTztNrZSwwksCM4
         obIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+OZ5X4Sw4xrxb0udGLjz8UT1WuFGfh34pXc4E9e4RQk=;
        fh=BB2jUtAo46dQy6f/cOWBhaGgt+vRKnU+N0zbiM58YEQ=;
        b=opErCJydUVoikvii9jswzzjaPFuI2utQ3idn/lKVHNM8H7t58ZN7i19uY6l/t4jLwv
         se4c13hpni2WCnZlLvqCl+K81Zhq68Su4AydfPw1AYlG8viYzZk9q0JVyq0HKDmRgJd9
         R6kovvhpWDxKNlSiTbxuU6UzBoA9c0D9cOk59MMSWv8ykLbiTmdOyJ2FQ4xRiujdRYMS
         p8cLsc98TSB/WNaZOdY92jm+Gd27La2UiR7h41eZeobByCXOLLebEvQS7oqw0zk9Kyl1
         zO7n5rKcxyjSVfqBGG5iA1IcsrUjRMiMIEEMyYw9j8F0ptLpwhLPsBNtCI0gtmlEbqLI
         V7dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788205331; x=1788810131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+OZ5X4Sw4xrxb0udGLjz8UT1WuFGfh34pXc4E9e4RQk=;
        b=fqr02jY/WljUIP+q7Rurc0S3NOIThpoQ2wEjp2h1BtyIkW5zODx+zzu0Hd9R8RcuBW
         tiI71vI/SZ+scx9RrkbtjSj1V0aORoh+fHcPWw/V+u4hBDNy9l20bPewlxnXjhcchx71
         +wodSkjRdioKZDEg0BZIRIKQYEiaawlJp25LBiInCeToURAmm16iD2Ahl2o2zua0GXjK
         LmDUfnYWqQpoSDkX2Dt/z0DaJsuk6qQwgx19bp510DUVWqRyBlQPUvt1iD1fcJj83YcT
         Gp+LviUs8R31Dx1is3I2Ki+azzk7rBVBOkh5i6OF77EKqNjVH0DL0qT1UouGRiFvTKsx
         eUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788205331; x=1788810131;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+OZ5X4Sw4xrxb0udGLjz8UT1WuFGfh34pXc4E9e4RQk=;
        b=UfTRjMEqlE6X65ayWH++rSHpCKg4GN6afMJdHN3qoheQZOKn7vApZ+pDt2/oZM2QM8
         00MBIJtNUrECVO2L3bWc4n40vMwc5oIeYuByHGZSboA06zSQAiDKNibtpOmN4JJaswNZ
         dDpDnnxomdMlDtFqTkQkGr0YhfRPPJZK6ixjv7+CX8pLQp8jAQeyQJ67/GsYXfr/HnPf
         sZRQEGchGKZpfSq2WJcvdbpW9kdeEAFv8acNC3N5/j2TfCXYqSRutL5D5Ah3+lB70G7o
         y5k3yir4xuAKe/efTpPx45jkWYTrq4rgePKKQ28/jVJlxKtLheH0Q7pLaeHXtrf5oRvu
         UbqQ==
X-Forwarded-Encrypted: i=1; AHgh+RoPvhYYQpcE3xhOHfEdj4absietVxKmLtc59DWGH2LOL7aYAJzUwJQuh5PU6zIUg7F5D1diPE1o@vger.kernel.org
X-Gm-Message-State: AFuF++n3xuEhr9t+GD2fXvrG0kJaLrU6IRknhzTS/coqSpZm1jP5n83D
	BgvVGpJVoyUKHK+J3DnnmlnKAKgyq5IGiy2+1EAY/sU8Gy3cV9z9CWje8yg9K+woDQ90AySm8f7
	WkU8X5fmFWnWDKAtjM6bKijX0oJR/2B20+LIHvQN+
X-Gm-Gg: AR+sD12cxVlMiNcSGjp7kMYLkkeD+OrwG0H5grmUT5fqomjTl8kddse+BJTOX+ZxghJ
	4oZEU20LmE6ycbhZJwPza0OYBRFICn1gHXuYhUss9soRtkXOr+9hy5z6yD25Db8DM/Wc05nrQxC
	jqNtUEi71s4zT/dkC1coep59XmGV05bsVWf+wH8tXQWFzK4hvhcLmYdN7CvvTsO+wCMXqubd7tX
	x/sqnRU5lfeOEhqYc71xrraq0cLIYqVR/PcXWRipCHPQsYE2/MeUM08DT4oh/XQA0LSrtau8DHx
	Eaw4vdFJEq7rWSgtVfNIYhI1Z7JF4cmZFt6Sybd1gsWO
X-Received: by 2002:a05:6a00:2da7:b0:857:726d:2709 with SMTP id
 d2e1a72fcca58-857726d2dfemr25972524b3a.21.1788205331086; Mon, 31 Aug 2026
 12:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807191342.19500-2-stephen.smalley.work@gmail.com> <91948e3a164e672830c2fd1640bd7067@paul-moore.com>
In-Reply-To: <91948e3a164e672830c2fd1640bd7067@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 15:41:59 -0400
X-Gm-Features: AcwNN1VwmIPUA4zPApeDzWog3ECwGRYl7SLnfYI8yiGNr9oIznOKzdSRGbCFNFE
Message-ID: <CAHC9VhRAk7j9NPQ8btkpCuvubW7CJEsOLVF9GtNr79rKRQVocg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: tighten policydb_context_isvalid() checks
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 11:25=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> On Aug  7, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> >
> > policydb_context_isvalid() bounds each of user, role, and type but
> > does not require the value to be defined. A crafted policy can declare
> > more identifiers that it defines, so an initial SID or ocontext
> > context whose type is not defined can be inserted into the sidtab and
> > later reach type_attribute_bounds_av() from
> > context_struct_compute_av(), thereby reaching the
> > BUG_ON(!type_val_to_struct[type - 1]). A user with no datum can reach
> > context_struct_to_string() and thereby trigger strlen(NULL). The user
> > and role datums are already NULL-checked further down but only when
> > role is not OBJECT_R_VAL, so an object context can carry an undefined
> > value through.
> >
> > Use policydb_{role,user,type}_isvalid(), which check both the range
> > and that the value has a name, in place of the inline range checks.
> > The name and datum arrays are populated by *_index(), so a value with
> > a name also has a datum. This runs after policydb_index(), so the
> > arrays are populated. The now-redundant NULL guards on role and
> > usrdatum in the OBJECT_R_VAL block can then be dropped.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > v2 fixes a typo in the patch description.
> >
> >  security/selinux/ss/policydb.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
>
> Merged into selinux/dev-staging for now, will move to selinux/dev after
> the merge window closes.

This is now in selinux/dev, thanks!

--=20
paul-moore.com
