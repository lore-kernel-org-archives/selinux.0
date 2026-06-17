Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8F7401A02
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705712; cv=pass; b=sbcoIrLnSJpDv7M/QA1S/h8TCBBOEI/5UdOcXBqVjFYuhvSKREm94+g3sVsTR64hkSbRfTXkv68jCD8Vq8VitW8FotPUBFhQXuZGdg06ENoLwiMvVaxFRZms0T4TvoX99tT7HcPArp+JMC5NbF62lvNr83mbSUvgnHNopWbx/tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705712; c=relaxed/simple;
	bh=GKChtASBDpeGArIA0u2/+oYmwnmenZKD7zj7J5HU0Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUZcMUrJXxMDLBc5/xoQyOvtfEbwolQu46riQlb3zJOmeAXSwPSYaB+wIRiAtD1BetP+IebJOVIqku6o10qhL9mA41DuwctDZP30f149g5dxmIRRhS8GAPY2S9+x/OQkLmywoP6VpRyj6h71wkbLA4Tl49oHocNeJZSSyqADe6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITAXQOla; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITAXQOla"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c85b2139015so2069264a12.2
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 07:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781705710; cv=none;
        d=google.com; s=arc-20240605;
        b=IKUOPAkRdJ8xhotP7oiq0mLrmyxwQErtZMRoAw0GlaoxJboAyGe41Xm1NuAKXB3nhp
         ahphp31zmW/N304h8mrOb23ZmP7dbam7Bp6VQ1wfVsuvS0kwP5TYdt+Y6Y3OuJOvfmc+
         OG9emTJKkoTy3iNxqziQqdBCySEw0yZgGF9HojUvc+GPTQgEMr6oj2Gg0TS+8UOUEl/J
         jmWXnQIi6LqWj8CKPKAaNeByJ2EP/vBXWGb4QFdyMvtczcYFolHHubByNSFEWQNiPXTe
         FKZhbUPSDFLxDNIr6R24h59rTA8Tgwaa7pQx4CqaViMTZ3o73l4saOtxulPf2BXyourD
         DcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qljt1EeR7xv+hDpFHO1ursWa8b4u9hxnrZpcfi7Ao5g=;
        fh=wY8gy0iOksnwzvOC7hqRV0Sf7JK9ec7jJ+1ccj8gvlo=;
        b=GctraEorUj3EWF0xMh3jBNSH4d1lXa862JR2J+8c/AU+oLgJ3ofg7Q3YXXLBBglkgo
         /JgOOz5O5smhHFCR594CuLXCVETPS7QCmjgqieG+KndqOxeTRoj9HS9uJ2bdq/LmzLBP
         NhIF5DwBqCJevV27KfV9L5OPBQqa8vph1niTPDPilS5EcHk1WQhXlMlbxTEj31MS6Y9J
         DVOkSARfDN3vxnxQTpc0OQ5ROOe2wf3IbdhUSpb0vyIoQKijRs7g4M6iM2p1YTLJVAZq
         CdENvKM2WSPFD+pZnXQ+qzO70D+sigX6UaybMI+h0Zs+5RMLz5YkzRD2CD9vSDh1eMP6
         V6lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781705710; x=1782310510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qljt1EeR7xv+hDpFHO1ursWa8b4u9hxnrZpcfi7Ao5g=;
        b=ITAXQOlanQsZYkT05zFUxiz/cW0mj/KKgJAIJHbduLnklmM3CRsM0xLkW2NvenE6w3
         8UbR2sbERB8pliROQozxRvfCFtHMVwiYMY89mXtRzFJgo0e0X59utdD2OIQDTD46q3vp
         S/ZSTO5LLpJF654TN+MYOjMzN8KwUvkNbaE+W7oZvLsol5tKQVu8S2vSocK8cQNCklcZ
         6+RMtgxL1QEAh4mhR/htYfaYm1uTIbax3+amJT6tFaM5kKJbWiYB/vuYCqijFhGsIJtN
         ycLJP+eektdZWOYd6UaczT/OLO0ah+pSod/9gMIb2MroQq9tmUbtJyLVtrwYO5/NVPFH
         NZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781705710; x=1782310510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qljt1EeR7xv+hDpFHO1ursWa8b4u9hxnrZpcfi7Ao5g=;
        b=Dkn9sK8xACPmBN1X3IXUkOQvxw/HW2Id+Rd5NNI585yXxn1c4t05Ty43vAVrjqaDSn
         w+0OXDxKX+hJIbi/mQxwsbnFB9K1PpISDpqgOr0ElMv0PDYi+b0GLYgiXhwa7oVmh/C8
         O2C4DmnolyUM1W136aysbB6I0wNLD7SBoHP7xrXZlLgihyJZH7LfoFqjGcn9rO6pEX+b
         zvBvCNokrAFjos/E8HzsKqVGWnSrxVCdi/vHPCf49OGRJLwf51RhYl/kfVOmqUgLj8CM
         3Jo6ekb6n8/6MeoPXqroiZ1Uzhoe3fJWh4oRz1rv/zgWCORM7Njka0Y1C5KIOCUiVp5y
         Ldmg==
X-Gm-Message-State: AOJu0YxVo6KP2j8UyT2AJQPCy8VFFaYTXdQXUHJVQgzxrDtl83CMAAEm
	T+SykE45WXc3Dwrm6KeC77j2lp6vaD0KuZ0woGfHLNTA536qmdsKNmHHAmmFb+udpl5Eg7FwE9v
	LDj2u1WYGvq8RJ/mp42XsWVErhSPhb9d0Sg==
X-Gm-Gg: Acq92OEjFv9hEz4CiN9Xl/S5h85D8EZmZyW3fbYsu6vEHx5upSqDnxbH5TdSqr8dKT2
	0qo2uZeGUZHRgdt90lRPCkTjnQnZrzsTcQoJCwhSvoymymas0boTIkL02aCGwOE06W+mLOgVQcP
	70fh9/Nu1vhDDER2zCyJXK2g7E/Eg5eeAZe0mQmv4yYwi9rsIZgKFUYfSQ+dkL9fdpsHVIQW2CP
	DXoF4X8v1EHjJOHu/EGkEDkuCDkTkGzEZk+wnk3XxeAbDaO6nLdxfbjIi8xqplgFMBQQ+yR
X-Received: by 2002:a05:6a21:6e43:b0:398:6ea8:21d2 with SMTP id
 adf61e73a8af0-3b8b658298cmr4958455637.19.1781705710066; Wed, 17 Jun 2026
 07:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616143453.54781-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260616143453.54781-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 17 Jun 2026 10:14:58 -0400
X-Gm-Features: AVVi8CecWhRgA0wbfu6VyXC8TGH13i_FWlakCvM-yI5sQbID8CRQ28B3xa9lZiM
Message-ID: <CAEjxPJ5Xrnw0ckqp0gu_O-g+6T+Q-P+zXS=yUNK5vVpHe=TLHw@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: Add EXTRA_LD_FLAGS for musl+llvm builds
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	Pepper Gray <hello@peppergray.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 10:36=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Introduce an optionally defined EXTRA_LD_FLAGS variable for use
> by musl+llvm builds to pass --undefined-version. This enables such
> builds to link despite the intentionally omitted
> matchpathcon_filespec_add64 symbol.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/512
> Fixes: https://github.com/SELinuxProject/selinux/pull/513
> Link: https://lore.kernel.org/selinux/871pe7n3w3.fsf@redhat.com/
> Fixes: 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
> Reported-by: Pepper Gray <hello@peppergray.xyz>
> Suggested-by: Petr Lautrbach <plautrba@redhat.com>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
> v2 fixes the missing comma issue noted by Petr and shortens the new
> variable name to just EXTRA_LD_FLAGS, moving its use down to only
> the line where the linker is called.
>
>  README.md               | 4 ++++
>  libselinux/src/Makefile | 5 ++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/README.md b/README.md
> index 5e65a049..ea8c4e46 100644
> --- a/README.md
> +++ b/README.md
> @@ -151,6 +151,10 @@ set when overriding are:
>  - -fno-semantic-interposition for gcc or compilers that do not do this. =
clang does this by default. clang-10 and up
>     will support passing this flag, but ignore it. Previous clang version=
s fail.
>
> +## Setting EXTRA_LD_FLAGS
> +
> +Build with EXTRA_LD_FLAGS=3D--undefined-version to fix linking against
> +musl with llvm.
>
>  macOS
>  -----
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 9982faad..9ecdbd4d 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -7,6 +7,9 @@ RUBY ?=3D ruby
>  RUBYPREFIX ?=3D $(notdir $(RUBY))
>  PKG_CONFIG ?=3D pkg-config
>
> +# Set EXTRA_LD_FLAGS to --undefined-version to fix
> +# linking against musl with llvm.
> +
>  # Installation directories.
>  PREFIX ?=3D /usr
>  LIBDIR ?=3D $(PREFIX)/lib
> @@ -163,7 +166,7 @@ $(LIBA): $(OBJS)
>         $(RANLIB) $@
>
>  $(LIBSO): $(LOBJS)
> -       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -fPIC -shared -o $@ $^ $(P=
CRE_LDLIBS) $(FTS_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -fPIC -shared -o $@ $^ $(P=
CRE_LDLIBS) $(FTS_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)$(EXTRA_LD_FLAGS:%=3D,=
%)
>         ln -sf $@ $(TARGET)
>
>  $(LIBPC): $(LIBPC).in ../VERSION
> --
> 2.54.0
>
