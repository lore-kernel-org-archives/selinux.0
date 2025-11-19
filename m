Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3EE36E54D
	for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567911; cv=none; b=Gjyy7PI2LAXJCT0PVeTZ9dS7MLRso8wbvEXUAiMRHGns5Mj8rJQ/Q9rRRXq8kzEgesV9WLzRlZMJSVH4inpXWkPYPECEJ5IsAhQLMITj7hmGOGzGeiivr0rYCJNpO1hFWr6JRf9uYIuMKK/+DMV4lf0eQZL7SY0WfAiJBDVvzcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567911; c=relaxed/simple;
	bh=2gR5ULm+glr0Dm3I3W6bRqYffySo+/kDmW3kvipIsZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfsJTyFVGPZ8Aq3Zwcp6dpNSGFWvf4hs6k5RgZA4LDyqH8yaoZPs48wMJjGit7nWRTlvK8lIYsBZ3QVOB+IYdoR3pqJVcFGQ4JxLGdfy2JooIDVXHR+0dkd0i9IT7plRTNmvVTsDv+rj9t/lmRloWGQ7RNPfzg/OB3QELfvmDLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiHc5zQ+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiHc5zQ+"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-340c39ee02dso5888328a91.1
        for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 07:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763567909; x=1764172709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bk3QZII8lvNSLfoqbiY7jbyLX9l1dR25BxCdzLuhkA8=;
        b=kiHc5zQ+9Gx+rITqHuP2h9P6ZrrRkwLu2QqP3eI6X8mjlS1YPlrZsktkFUN8exZquU
         VgQpd/AzQW1Ag6xQz9fT38ppJC/fGLen2c1rFKqjAE83DiLUn8z3jdxDgP0Ux9Df5xLq
         r49EmF6RTMkxO2fPJL8/knJ1w1x7ZIlduxFuwNl1Ra9uHneR4B4C5vaj71K/BSMsvPxp
         iTFrS9zBBs+oBJeirOtK/OOxnoDuhY6i2lXlANwthxNG9CtCm7eDWDncKZjc7vATqcZ+
         doaXxhb2II8B+swm/aPNWmxwydq7ZR0rDF5HpL3Heh7On6I/LxJUdvBbrwsSBb/61d29
         xhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567909; x=1764172709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bk3QZII8lvNSLfoqbiY7jbyLX9l1dR25BxCdzLuhkA8=;
        b=jD6ohqXoGiselYMoR+KiGpZrbfCMevBheOhbXEimgT0E3FdDZRdU652FjaaDrEWmX7
         txP05GmqQMyPe3AHpsSH/QQvh4O2y0CNIPckf7TD8fN2vEkYtvhFU60Xg9l5Fz3CVWOx
         Z4N/eUYscv9aVtgvoGApFqcc9vQLAFAXI1dnGwwtdn3Bo6nKb8Wi3A/QKUVOa4+ipXwD
         oEtKWCY79q2fy9f1ytWPTH7qz8qK8JxQ6nr1gw8pz3F2+M/mwU7a3jplAD6yzd0qwhkF
         q69Okr4z7tA0l+19iSYLHNYxmBWJBMDqxDlx514IMlKaGk0vKF3hqooC4w2mcGlo365V
         r/Xw==
X-Gm-Message-State: AOJu0YzUrFkFnvW0xz0TKKybtbhxElld0XS2ok6SgYzOHA1F/pwec7Ab
	uZKjVvrkFaKWA6IPuTEW8tOMHBKOgV5vt7tBpR1FEtVBQOqElH3owh1Owl/n/yn+EswYAK97ale
	ZNiF40MKA/oT0hpN0byunhLqLIqVXlFHmbA==
X-Gm-Gg: ASbGncuK8NEKNEj4Nh2JQGDBGTnYuCwa/AQcRTomncnojnj9rxQD0W0jysv4w4IX80q
	PG5bo7LNK8M6JyYphRWaT+y33ZxYSQvUQZYJLjGf+8V74HLcyssdsxDE9C4Shg8eBHFyHxVEWTg
	o6ckzMG7XYXBX6q9J3PxSQKuBR+LoNGYLMkFMzm8GvrXcOubrvO4oy5qUDU6EayRbq5HOPkxj0D
	xtHK38S8xSlNIUFf6/Tz3kOJUfTKg7BRfAPmGvObZw7KrcG+CPM8DB3gsUz0Xy0orre7sk=
X-Google-Smtp-Source: AGHT+IG4OBMlyCfBeMaD/5dKx9Zyb93iAHqjm/Q5/0VWRdBHOyc2xxDCBwbD8BiZVrrgkd/QHpJcPzvP0lchLMjOZVk=
X-Received: by 2002:a17:90b:3fc8:b0:340:b1b1:3d28 with SMTP id
 98e67ed59e1d1-343fa75a9cdmr22631287a91.25.1763567908634; Wed, 19 Nov 2025
 07:58:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119020334.521449-4-paul@paul-moore.com> <20251119020334.521449-5-paul@paul-moore.com>
 <CAHC9VhQaR9r9uWuJ4h_HoDtyGu1M2tU+ASkWxsFOf6OR_thNUw@mail.gmail.com>
In-Reply-To: <CAHC9VhQaR9r9uWuJ4h_HoDtyGu1M2tU+ASkWxsFOf6OR_thNUw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 19 Nov 2025 10:58:15 -0500
X-Gm-Features: AWmQ_bkw_D743T7RDlmanvfIZoiV0KHhnqduEmK5oDP563y2C7tISZofWVMxxuI
Message-ID: <CAEjxPJ6U-dvDbA7zVx+Y-mQyS6sFCT=K_nr=wQo3=R10qRAYAg@mail.gmail.com>
Subject: Re: [PATCH 2/3] selinux: move avdcache to per-task security struct
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 10:50=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Tue, Nov 18, 2025 at 9:03=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > From: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > The avdcache is meant to be per-task; move it to a new
> > task_security_struct that is duplicated per-task.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f ("selinux: reduce path =
walk overhead")
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/hooks.c          | 31 ++++++++++++++++++-------------
> >  security/selinux/include/objsec.h | 13 +++++++++++--
> >  2 files changed, 29 insertions(+), 15 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/include/objsec.h b/security/selinux/inclu=
de/objsec.h
> > index e71ce352bc97..6cc5104fd2f2 100644
> > --- a/security/selinux/include/objsec.h
> > +++ b/security/selinux/include/objsec.h
> > @@ -177,6 +181,11 @@ static inline struct cred_security_struct *selinux=
_cred(const struct cred *cred)
> >         return cred->security + selinux_blob_sizes.lbs_cred;
> >  }
> >
> > +static inline struct task_security_struct *selinux_task(const struct t=
ask_struct *task)
> > +{
> > +       return task->security + selinux_blob_sizes.lbs_task;
> > +}
>
> FYI, I just noticed this and fixed it, but selinux_task() needed to be
> wrapped to fit under 80 characters.

Ok, wasn't sure since we didn't wrap selinux_cred() but I guess it is
just on the edge of 80.
