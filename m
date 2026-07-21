Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EDC25B09C
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638541; cv=pass; b=P7wrYXURl9mNjH89gi5erpFN+t/wtUbg535Ybaj2hG1OkMUO2ERgKoP/BXgsRAm72Ep7Rn4wx2y6vz52uWCTdXMjqmjkbNp6Jd1VTOnbvLra5csxRwip0Os+gvgsJuSbxKhEMhvsfE0MY4wZKcRw/jG01BB7Y65G0RFWlwiujkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638541; c=relaxed/simple;
	bh=ixyUjIaDUUf12wr2HUkMMzaDeVELTi33Sbll7fRY3kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAYUbTxeRMENIGUhi0hSY9fZfAKPoPRVqvrSdO6qXXMeNTcdvchN8xnFFaCLxA7wpMO5A3/TCdb5qhT0tdaa+DmBAPLB1j/xJEuvsdAt4FlTXCa84tTus9PWCZ8SEYVV/9JFdGqnaF6Yo5NAPeGYefX0BxeOs226xk0n+7B0UFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/q6lJR9; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/q6lJR9"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ceaf8a1265so111620335ad.2
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638539; cv=none;
        d=google.com; s=arc-20260327;
        b=CmeOzH9e2RjJ8ZUriQCP0tRvg0alaOPoXhvzwafGvrRAFBOAEy3BR0YOI0A08XQRLk
         dXj5t5WPJ8PVHOuO6fdetfo/5gU8Iv/pgHt9wT64eDSfeOm+awiFKSd9+dkO19zQBYcl
         YU9JEti88vHFMzvAEubN10pRt+DYQGtxVA1b7y6Hf/b/xZLbSahgt1V+4SVvTDHqsm38
         kB+RQ+2dqy3U7Rhpn1l0V2ZJof+Ew8mOZ5H66+xOkw6zw4k0g+u1xccIkc2QwGyjxokm
         2lsgCKDLVw9CmW4pv7/tqYTNhmEkspJTN8PNAVgUWquBJPh+RfK1t+kOliGcysS3J1D/
         GpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vRUbdNCFxshQYQhoozZP4V8excDP3SxBjGNUOSkV7OY=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=Hkar1vHUD77Wxa9u/U4H95IhijRcypHTjLFaeFW3tuN7cVJwR26vbRAlCeajTDY6Ap
         fURfOrOGW2UhVgnyhOrUakKh3s3mcscpXiQc1IX9B3rFa6AlRYOq0EaYqVFkprJm3rhF
         RZDelIwbolqnFn79S2JALg92w6l/eZhBD8PiolsZqqzOXNt2rpjo99QBBPok3d7Tx7w5
         6iXULH87vwAhM+2Cat8XrRkrKyZlLPHP8KjVEKaOQbIuvltASwWvjN1rMM7BGZykcwSX
         8gh8LiNXnoGUhfw0c9GLy2t56Jo6VrvE/5HH6litIRlIbDvikmBCmtkj9ZzXdYGZyOk3
         4JQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638539; x=1785243339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vRUbdNCFxshQYQhoozZP4V8excDP3SxBjGNUOSkV7OY=;
        b=c/q6lJR9+ubKPW/Kg9136AcTgryG+TcyQd4APi7mBF8UoSYy83csP0gdAZhcllWIDC
         B+Gfa0q3VpGw9jd6a94D+fVTY413cR9xZDUsQo7UKiKyJDh3yfZuFrDeg1GvkUrWGqxO
         jPWA3H9CyxJr9muFcSoegdbonrBCJSMMRblsYTJt55BmeESspmQCgyS+EQIqICuF758X
         wkEK730iKY+PWsj98UC49AbkUN+kpDGfHKmMtq0MSm68tmEJofLcNwUrdRk/flFHUKIw
         EH/icYTufAyC3VIUCjP1g849pqWiLWsTk/F79+qUQWYH385WZSGpX5BvFPKgzzGF0+5r
         YrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638539; x=1785243339;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vRUbdNCFxshQYQhoozZP4V8excDP3SxBjGNUOSkV7OY=;
        b=K2l1gttYDFly7Mm3kxSvs9ZSyTjlQdes/zSE57xaDHn0b966Q6yQdo6iEOqkVJzVjY
         YvC56w8Kz26ljEt9KbHunzFg2BvleRTzmcjX+VOCy+Rd0VuScii6IRZQe9L6dy8M1pAS
         +/lW0GBpt/AEp8kBz+D5gw+EbTsCEhxSXF5sdLk3KQRTHLZ5hv73Bfh+WbDiHvhns6UE
         FTDnze7vc+XQWCR3GGLMMwzINfDX+3/DWHExSXEXOa6KDjh7KhoGhGuXO0X+oqr+eoQc
         W7RD/hDPLrYI8dvkIUhRJNcfL7WH6aeftpy1OOMRiRvYLYkqj6vzS+TBdvEACnRtiKiU
         r4QA==
X-Gm-Message-State: AOJu0YzAZl2Sx+bthaFy4EwR3bg8jtLpZWqKdyrj6lKUNRzx4W8HpX5n
	eDL29qZyTU3R1xaiSt8qoIq0FUU+2bLrHerSC3W5BntOk1Jj+asbP7dRqithTPQriHEp9Qt+TJ7
	ttlygikYgAScWkotCJEvPBLtvXqjk6ZxMAw==
X-Gm-Gg: AR+sD11aRWZnIJFAz24K+IZWjZnx+wpKX02+fin92Y5AjkEz8wGDXtnehe265J2nqeQ
	peGtNcgyoajT30c1CIEDt7rJ9PkrGDKOkLtFz37Wp7PY9hX/DsvBofqLOhyiBwyJN3qH2GPogZg
	xinN7GV/yjDk0SgcpP+cs/YDLIVdp9EWma+gA+9vWPU2WrYrpzq7cd979JUsoZmAGXeF8aWOPQt
	hCSqPlnxGIdysWZOmzEz0vmmuhAhOGLNyIOBIzbE5sFcGDLKQnDoCAP7c0ewA==
X-Received: by 2002:a17:902:f681:b0:2c9:a9c0:80b6 with SMTP id
 d9443c01a7336-2cf34a48e5dmr203781015ad.34.1784638539084; Tue, 21 Jul 2026
 05:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717172110.19156-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260717172110.19156-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:55:27 -0400
X-Gm-Features: AUfX_mw1vWRrABvJUbDyXIWQ-iSsCD0ZflARUT1bXAAX5iyE-3mFY3bUjz-8210
Message-ID: <CAEjxPJ5J_gzn3+1nSuswP_a4OEXDg-E4c1MP2ao3OzdUrUUL+w@mail.gmail.com>
Subject: Re: [PATCH] python/sepolicy: generate: drop or merge symbol table overwrites
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 1:21=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> self.symbols["openlog"] is assigned three times with only the last
> one (set_use_syslog) surviving. Drop the first two since they
> do not appear to be relevant to logging.
>
> self.symbols["pam_"] is assigned twice so combine the two definitions
> so that a PAM-linked binary sets both use_pam and use_audit.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  python/sepolicy/sepolicy/generate.py | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepol=
icy/generate.py
> index 0edda54a..f88d6852 100644
> --- a/python/sepolicy/sepolicy/generate.py
> +++ b/python/sepolicy/sepolicy/generate.py
> @@ -212,8 +212,6 @@ class policy:
>              print("Can not get port types", e)
>
>          self.symbols =3D {}
> -        self.symbols["openlog"] =3D "set_use_kerberos(True)"
> -        self.symbols["openlog"] =3D "set_use_kerb_rcache(True)"
>          self.symbols["openlog"] =3D "set_use_syslog(True)"
>          self.symbols["gethostby"] =3D "set_use_resolve(True)"
>          self.symbols["getaddrinfo"] =3D "set_use_resolve(True)"
> @@ -226,8 +224,7 @@ class policy:
>          self.symbols["getpwnam"] =3D "set_use_uid(True)"
>          self.symbols["getpwuid"] =3D "set_use_uid(True)"
>          self.symbols["dbus_"] =3D "set_use_dbus(True)"
> -        self.symbols["pam_"] =3D "set_use_pam(True)"
> -        self.symbols["pam_"] =3D "set_use_audit(True)"
> +        self.symbols["pam_"] =3D "set_use_pam(True);set_use_audit(True)"
>          self.symbols["fork"] =3D "add_process('fork')"
>          self.symbols["transition"] =3D "add_process('transition')"
>          self.symbols["sigchld"] =3D "add_process('sigchld')"
> --
> 2.55.0
>
