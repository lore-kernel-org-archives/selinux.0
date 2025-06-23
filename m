Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCF21E1A05
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704479; cv=none; b=Qzee7w1HfXJBQL/RIxNDnWBzIyoqUyaZx5ijYIq0YeC3QrkxyX5AxSfjf8vTmPikub2625F0KeWHFRdjR5eBhyqi+y8EBakLuUVlpDtGwxlC24n8ah951CVPIzr3cDukrgvBrlG12anADKaHKK1UITeLQTb0hwtV9SvGD2szWLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704479; c=relaxed/simple;
	bh=UMQkSrKeogDHpOguy5owwExHo5umKKPICnZkY/G8uAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5peSYFUxthVilbgD6nKy7x6RiIfPQyItiw8a9ATyqF05PtCxX2qK1WZwM6GcnYnSo9j51Kw9Ef+iGSAzcqifNeSOXKpLY7yB6dzfhWluEx3Ki+Jti2FfzQClmSm5ODngiIf2TywsLtP1ZqJSjleOKU5v72rxPLmmAI86ypwMFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkSVxHbH; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkSVxHbH"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-87f234ba1abso763349241.1
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 11:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750704476; x=1751309276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tG2UgvzMg8KEBwJ3xFYbZFVk9rTypxSJcV1n9qzIZnM=;
        b=EkSVxHbH+L/GzKWEgjrGGxI0iwdwxvYwBQYtquGqJ5ykeQVyDDfhMpxP4fE8lKqKkD
         +6h0i41D2Ow82g+SF5I1U3iZMrGa/GoP0uVSLv88tZLDwZ2bKsqpXpPOFE54mB3zMc8o
         EtCECznlE4o2BVm6WGl4OemrmyzAlyZdvQs2c1sAtF8bY/Z7wuPU0ppRgavuCCObMg3X
         j4VDfUku9dkjFlIwCYAbRmC4YhrkrF/SH9ZclXKK8hrmd2OnMf7JjDvBaJK8KyLqhz0B
         e9Cir6XVrqNfZnxX/qYr+9JekMJKWHhPCAr9nOBOlCI6R4EnKl3IrHJk4ouHhtUw/yF8
         o3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704476; x=1751309276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tG2UgvzMg8KEBwJ3xFYbZFVk9rTypxSJcV1n9qzIZnM=;
        b=e2fkJsXr+cm4NiyY7JnS/roZCjmBACGBkxbyrnPSDDAKKN13xBOoqsoPYe0LJ26GU8
         QicEVrkzxwd0r1ZpCCZN5MhgEaj5za7MgJVZNuaTXt6xgcr8dq+2DQJ5BGJLKTiDs2Bo
         fCaOBxU38n8DSlag+cazP7+f9nF/93mVZiyDDGS0G2PCvh1Sz9M7ySzfRhnyF7MSUqUN
         qgbozEDlPCS0LFjnovK1jvxCui1kHYnkHZAKj67yKOeHrydnwXUGpq4DPZyit7Sn8Kgi
         JCPgbEss03Fgxma+DgNixMMc3159gvPdMHeK8WbOW1eRruduKm7d7jOQ503cl7Wi1HrL
         XB+w==
X-Gm-Message-State: AOJu0Yy71X90bzf3FvEBoaQOa4VYx9T/7ANyKQ/LInha3dDbuHje8PoM
	QstzwFNphV1z1qapnkPAaSqmAThnZRTm4fcZ/r3HwZ4P+XMBsF4M11zOXX9abJZfdqOvbnmVLlW
	OIdlZw0jII5Ww5K9Ov8Xpm4n5hAZZ5nk=
X-Gm-Gg: ASbGncsMGLtiFpuMy9InGgI+XTQqAptO+rW5kwAukuPfIGaOZQlWtWL4KIz2qD0XpAe
	zwkVr5aYmr40Sdz5tmUJr/tzTs6VWk0ngD8uNCi7MknuHehCwtr30DJjq6Hybks2rZwjbG33KNM
	Lo1fPQKuWJdfGrFq7y3Dw80bO/wbYc3HX2wxPH2Tzy
X-Google-Smtp-Source: AGHT+IHdMD/G3wxVLjLFXM0CESy602uYc3eEUKONnwqpPJr/m/AcdQBYNlzVV/ZCVMZ2jgCofL5V0fh9E74OkztweVQ=
X-Received: by 2002:a05:6102:f0e:b0:4e6:d911:dd84 with SMTP id
 ada2fe7eead31-4e9c2f56aa1mr7384602137.22.1750704476328; Mon, 23 Jun 2025
 11:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613185820.122384-1-jwcart2@gmail.com> <CAEjxPJ6BrtiUX05-GnyJWPe5RTUWA=Cy-p=c9LEz7B9faGwk=A@mail.gmail.com>
In-Reply-To: <CAEjxPJ6BrtiUX05-GnyJWPe5RTUWA=Cy-p=c9LEz7B9faGwk=A@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 23 Jun 2025 14:47:45 -0400
X-Gm-Features: Ac12FXzVHxMldItUQNXmR763hogOFdD1Ag7-HQAaFKZftKNSnNFnPvMORne2T4Y
Message-ID: <CAP+JOzSNaw7icpy4zQotGAA+wT5D3+72rfAhfYhUCXyhReCYkw@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: Ignore missing field initializers in swig
 generated code
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 10:36=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jun 13, 2025 at 2:58=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > The code generated by swig causes multiple warnings about missing field
> > initializers. A sample follows:
> >     semanageswig_wrap.c: In function =E2=80=98swig_varlink_type=E2=80=
=99:
> >     semanageswig_wrap.c:1514:5: warning: missing initializer for field =
=E2=80=98tp_versions_used=E2=80=99 of =E2=80=98PyTypeObject=E2=80=99 {aka =
=E2=80=98const struct _typeobject=E2=80=99} [-Wmissing-field-initializers]
> >      1514 |     };
> >           |     ^
> >
> > Add "-Wno-missing-field-initializers" to SWIG_CFLAGS to ignore these
> > warnings.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

This patch has been merged.
Jim

> > ---
> >  libsemanage/src/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> > index 1357ec71..fa3449fb 100644
> > --- a/libsemanage/src/Makefile
> > +++ b/libsemanage/src/Makefile
> > @@ -58,7 +58,7 @@ CFLAGS ?=3D -Werror -Wall -W -Wundef -Wshadow -Wmissi=
ng-noreturn -Wmissing-format-
> >           -fno-semantic-interposition
> >
> >  SWIG_CFLAGS +=3D -Wno-error -Wno-unused-but-set-variable -Wno-unused-v=
ariable -Wno-shadow \
> > -               -Wno-unused-parameter -Wno-missing-prototypes
> > +               -Wno-unused-parameter -Wno-missing-prototypes -Wno-miss=
ing-field-initializers
> >
> >  override CFLAGS +=3D -I../include -I../../libselinux/include -D_GNU_SO=
URCE
> >  RANLIB ?=3D ranlib
> > --
> > 2.49.0
> >
> >
