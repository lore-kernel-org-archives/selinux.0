Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F7337F73E
	for <selinux@vger.kernel.org>; Tue, 17 Mar 2026 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773747; cv=pass; b=qFk94EHi3Mc0sqtW4EF8kmUxIQ7rbpgZWJy0tC+WCH8vFTt+J2bV7Ge5RYFBVZeS9xB/wescdrxozzUDA7ZTtM9uZ5ztwGX+rxBbggx7d8ZjScfqa5FS5tPSYrRu5IlssENt5Ty1k5dzg3WQRd7l4qzDyEqYEiLsQ17XfsPGn6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773747; c=relaxed/simple;
	bh=etSz9j8qVjzmI1unubyh8NUg+Q8k204aq0jG22wPMjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acZt17JpbGeP/IqNT195xUJY6HqtCKK8oUx3V0wiWICTb/8uex49P+O7nCU6LQK1s93YrAueYCHSOApTZGwi96kJf9DSikcF0oCeWB0ITliHcHvaRM34JsOnaJmV4UjScgUX1fcsm7+j3E/0WfaK0jx3LSmTxnrVPHftNs2RqVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/VEzvrp; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/VEzvrp"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35bb7afdc38so317477a91.1
        for <selinux@vger.kernel.org>; Tue, 17 Mar 2026 11:55:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773773745; cv=none;
        d=google.com; s=arc-20240605;
        b=lZxCMy3n8ODO4hFxjNd/93WpXBB4gySmxfyhlhAOsISsrVB10xloadlQUAYVrkLJvR
         gQDTf4K5QVbdHoC/694mCQDs+IatCNLAjy4BcyedATDdzjFP5y4Y5EUD2uJu5B5nVWRL
         oBz4dp6axhas9rQjUsAUn80vYfc8gtU7c0rGu4tu351FsQJBa6S9VOpEZHSTLFfen08N
         YqBoMn6rReWmRqI1sPjTBuSHeCCDp3So/XJ52O6vT7uLuOKOi5PJG4D1oo8Kyub9K/h8
         UeCQtyD/S9Q54L5JkQxXOxFS+hO8IcFC9hWhuwYSWTXdXkT0pWZx/ZPeEpx4ll2VuLuI
         +Qxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m4wc4mQlSZeWIY8AotHFKek4AUzZbGuiSunnPmRXmWw=;
        fh=9JV8FEExFAbKechmDTd1Jz5Dmbu9LnenH6n7Cwl4roE=;
        b=dn+6of2vhyrH4v7NKpffXp9yEdrS8Qk+RKr5SSym/Cfxi1eiqoM5QK/jd/NCOEKBFx
         GULDAoe8D06J0Dx8+ZDVe3bh9lJyeo/vLt6De5pK2zT2SM06infckaKunSPh4xHfGyxH
         40PWaVaz/UgIhtdB51tqxyxfgG7Eo4iz+PfjEW+XS0xyavjhho2PH6g84V3TH24ih33J
         qBjYA6K68+cVM7KfHsFqJvIzafr/MuE/dnhQ0kRElbx+mpmVbwI6uTNGjGzmrgRLNLTr
         +fEr5mml6ibzVr2ein/VL8SRHOR9JJIKAaSWBX9SpxDwbx8AMou9qa4BqZoKkJ4kJrdV
         p2+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773773745; x=1774378545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4wc4mQlSZeWIY8AotHFKek4AUzZbGuiSunnPmRXmWw=;
        b=b/VEzvrpv4+daeV6eQU2I6sBMEPyMZcDjPLqPltebFcniaoGaBIHsfmDK5GjaMIAUP
         6aRt/ybC92VztiLdvKnAUmhvKybX/JJorTQiNK4vj54AfOEZu3NQ+UFV9USkH3A/ljRJ
         kD8Te4F+AXGCfjjd5Iv1tZrNDKA0jOzUbN4GO7glc6AJmPZTYnJjzg3Za7rXwdUBVNuo
         HlZNOR63r3ZAgVlLLJD6Fj0XZOL1GVFnan5s1GzcKLSv8EJW8d6udGRvLSAfLViGOuzG
         E0FD+Dxb7BHYZmsHQrjAPnFRhCiGh5f8l+xPVUp4namOSEWAfeEGChCaWipWYNKdU3Ga
         h0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773773745; x=1774378545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m4wc4mQlSZeWIY8AotHFKek4AUzZbGuiSunnPmRXmWw=;
        b=lqfCrDbwkOvp9omBaKrR323OXzge6f02na7okgepu9+jsjG9Dawro1LpYdEAAI7bmF
         8s/9wWFWn9Kr7JEr/Yn8OdW7GIyX3xGppnihSZDbENldg2XrCLj6sFzmcPTzpNGAdqOg
         P5cYT1OKekXsOn/bk49/lGN+0K4SHx1tqO934POPJUGQU/gLjlhOlDFliq+W0Jt1Cqkt
         BJhn65HHA0sBknsLZlkXYAe1f0dEQM1lBHrrmUFM7HXquMTr1ZV8RqDIDyVvU7o03s4I
         61LcYElPMYCjrsuUJpSIjb/Dgfqo1NP+qPUrImUFrfw9/8Eh15HZBuJBma4i/eNsVpKn
         rveA==
X-Gm-Message-State: AOJu0Yw6YQ+5h3izEv0db4fO9oUyqY6fdB+Q3iEmHjZ5Eegb6PYyE9P7
	XsQkrk9PtgqYfiI2LFSvxRLe5YBO8KX7bKHTrTbXo0P5MdvGOz+mJ/Y4CftfZuzsaKTgbZHMKpo
	NiNTRhmj0uh/jODXjCwfHPzsVdlivyA0Kug==
X-Gm-Gg: ATEYQzxzmeSwpOrPxqYmZnXWqNFvye82AqhyYBW1jJXGM3EeInS81dKinO2880QWpUW
	i7QNf/XQCNmO7cbmBrECtm6qfe8mOnQwQwI1kndmSQgMAL5koNoi373K18CU32qTQ7RtORF3q5X
	AKx6Y/nWkq8HCWKDx2roweVgm+R8+iqBy//SoiRnOBwLsnuNMKU/Gi74+SlT+x6Jdnk0Sei0zAf
	vJCYppp4a7/ExCLbYSY4qmmw7WHpPy2lIp8cTyVebL0QTSlS5MYu+gt+R5ibcKvhHk93DsdAuii
	K6zH3ok=
X-Received: by 2002:a17:90b:4ccb:b0:359:fd50:e733 with SMTP id
 98e67ed59e1d1-35bb9f4075fmr440240a91.31.1773773745464; Tue, 17 Mar 2026
 11:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216160734.126597-1-cathy.hu@suse.com>
In-Reply-To: <20260216160734.126597-1-cathy.hu@suse.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 17 Mar 2026 14:55:33 -0400
X-Gm-Features: AaiRm52cM6nu5B_8eT3kGsZS1BMwfYmhCXiEwfVjhQUmYZLMjq6HMRmxZkucSRo
Message-ID: <CAEjxPJ5Q0=bK-Q+Nig6Rhtu1oJaow3yfsZ06K0_CY8OVEx166g@mail.gmail.com>
Subject: Re: [PATCH] Disable build isolation for sepolicy python module
To: Cathy Hu <cathy.hu@suse.com>
Cc: selinux@vger.kernel.org, Cathy Hu <cahu@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 11:08=E2=80=AFAM Cathy Hu <cathy.hu@suse.com> wrote=
:
>
> From: Cathy Hu <cahu@suse.de>
>
> same justification as:
> https://github.com/SELinuxProject/selinux/commit/17a9372391ad2c9bf0e44039=
1d6fd13cb8cfdaf3
>
> Used patch by Daniel Garcia <daniel.garcia@suse.com>:
> https://build.opensuse.org/requests/1333291
>
> Signed-off-by: Cathy Hu <cahu@suse.de>

NB I would prefer the justification be included inline in the commit
message rather than requiring following a link, but otherwise:

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  python/sepolicy/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> index 1a26cfdc..ccb22fe7 100644
> --- a/python/sepolicy/Makefile
> +++ b/python/sepolicy/Makefile
> @@ -27,7 +27,7 @@ test:
>         @$(PYTHON) test_sepolicy.py -v
>
>  install:
> -       $(PYTHON) -m pip install --prefix=3D$(PREFIX) `test -n "$(DESTDIR=
)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_A=
RGS) .
> +       $(PYTHON) -m pip install --no-build-isolation --prefix=3D$(PREFIX=
) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-d=
eps` $(PYTHON_SETUP_ARGS) .
>         [ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
>         install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
>         (cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
> --
> 2.52.0
>
>
