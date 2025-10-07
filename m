Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9E1CDFD5
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851701; cv=none; b=nCvkXzGWBvep0PDni4SKU2RyxKJfDxA9hkQgqQZUO3/rHf2XfVCBDi4HhzlWWK7UQg9r/Hf2PuMn0jUhLDRxa14qIEsmprHHlyHf1o7Dk0foSuvr0Dl7736lSRzcQayS4wfmsHcoxYgQwnoC23tWASi/JxbNuN0XFOgoZsQXOPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851701; c=relaxed/simple;
	bh=yGre8HQWWuvykgyiNBnVLFg3Kk9VbycRlQb2Sly3CDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsUSp1EftwBmkIcGb5hPgiXfDFbIFQtppjx1HN9PKjuL9r5c2JnpduOK+zaAsZP32fv1pFbzKNLDrZa+cfCqLI9KOjBlhWM0mLyqvJSkhg03PqJ45iqjMrj9925KBguldubqGSiR7909B0I5z+BoBs1IvjXgTO0eH4vmMJ1XLdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXsW7ddz; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXsW7ddz"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33067909400so4834461a91.2
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 08:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759851700; x=1760456500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy8Ip9yz8WyB9AWpA1LpGnx0rxpIoJLxzPgHFHirDX4=;
        b=LXsW7ddzOae0zApXuCr0MLAglUIfEj+GQgZA7KEfB6R/9mr+jqDUEE4WNTu9u9B4Z3
         Tk5w6Y1XEYaBUh5pd1LlZSHoluf3O9LIWkkyJOjQ4w5reX+9kt2jF2Ef+k6Of3qgwykI
         9m85Wpq2bxaWbXoqW3u9ymRyXdMJsI3DVATMf8XdI7nrL1jYXpD3vaB9D08LM/l2xHIi
         oMByYxplhf5YkCODbcotJqKvBVdLJErpLSx796rwWzFIXmpJJK35/MzrIpBvtH/atCt3
         IMJL0M0ecnbId12sYF0D1B4an0lapvkjgz9KeTfoErpeP04WzpQU9ZEJLWm6xC42bala
         nJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759851700; x=1760456500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sy8Ip9yz8WyB9AWpA1LpGnx0rxpIoJLxzPgHFHirDX4=;
        b=IqvaT+uAmU3USStchyfer11j46dey5LA3kkA8navfXL9Zd3XPJyuuHpEqIapZWtKBT
         onwQdKfRqO4SnybLBt/hrTbYdQAgnOeHmR1HykfKmjVooXMzEe/s0Lr7BvXIvdfUiJI4
         6q17aCRpRV3P1SOxZFx6tgEQqLcAZ2O0u8l6/iMLJ7Y5K32wjLUce7lqeLJYU19GHHP2
         drPk/BuU0+4nTg0ZKWw5U1n1ktAUnnV/UmEwEXXB2b8fS2PyCciNe/nPvrkbY24XaaSr
         at5XWrKHBa1w3Ybpo10M2yjz3/6bo5IHXFP9ELky//MoTATUaviwT7i0VOiL+ByjUZRw
         oBGQ==
X-Gm-Message-State: AOJu0YwG2+KiS4knERNP8aFlD1zq4TOblCTKqTYp9h/Id7N82+8dU/gY
	GErjCG7LWqtE1WQrNb/crSxWjWwSEIv2unfNBsSoDm/pecZEZiELzb5vXhzm7kPRqSiUL0xIF0u
	cN2yOdkUwletlg3J+YXsfT8T9YIAtB1vQ+A==
X-Gm-Gg: ASbGncsP80o0vwmNsQNBh+348KQruV/ZZmTOyyk+amvPle5UZHUJqLDHmLd7LPbK5oc
	Or/g3mYOlrcQmhkHOrP8O7uUOF19u2L5ttzjTCseDTH8NH8zfR6VIOGJfi+zDiDX5GkDvcb3lNE
	rMBLVctOnqG+goVIczws+n4TpDXf5XHSEOi7tIFt5uIUtGxdM8CSQGVgdihsrtiebXYoUZrJcF9
	mEwgPor3eXEDwdq7Sak7eEMA8gvivXhfp10Q4MAvA==
X-Google-Smtp-Source: AGHT+IFDMl6/tf0XfG5u5UbmdKOv2v6+alA+b4UKncJbPEaCyPeg+ASJCxEq8+w4QrnL7U36FeHOHclAeFBwX0JyAG4=
X-Received: by 2002:a17:90b:38c6:b0:32e:f1c:e778 with SMTP id
 98e67ed59e1d1-339c2707b92mr20806200a91.3.1759851699478; Tue, 07 Oct 2025
 08:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901171852.2216823-1-vmojzis@redhat.com> <20251003164046.485103-1-vmojzis@redhat.com>
 <CAEjxPJ4ZFwO3Zay0XU8g=ZrzvV2HDiDs-OTU02J_zb0fWyQ+Pg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4ZFwO3Zay0XU8g=ZrzvV2HDiDs-OTU02J_zb0fWyQ+Pg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 11:41:27 -0400
X-Gm-Features: AS18NWBA01Yv442k5N3hShwPjSbBGHJvpUUdJx7hn4WVOG5H1xXxwcXZR-vydT0
Message-ID: <CAEjxPJ6tdE6DO38y4AtMFD7OivgN-kZ5Nk5xvK1bOyW0EK1Y2A@mail.gmail.com>
Subject: Re: [PATCH v2] semanage: Reset active value when deleting boolean customizations
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 2:35=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Oct 3, 2025 at 12:41=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> w=
rote:
> >
> > Currently, removal of boolean local customizations leaves their current
> > (active) value untouched.
> >
> > After the removal is complete, semanage_bool_query will return the
> > default value. But it needs to be called in a separate transaction.
> > This makes the fix a bit awkward, but I have not found a way to query
> > the default value before the first transation is committed.
> >
> > Fixes:
> >   # getsebool smbd_anon_write
> >   smbd_anon_write --> off
> >   # semanage boolean -m1 smbd_anon_write
> >   # semanage boolean -D
> >   # getsebool smbd_anon_write
> >   smbd_anon_write --> on
> >   # manage boolean -l isemanage boolean --list | grep smbd_anon_write
> >   smbd_anon_write                (on   ,  off)  Allow smbd to anon writ=
e
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
