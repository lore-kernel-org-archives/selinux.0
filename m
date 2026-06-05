Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C63D0914
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675042; cv=pass; b=bxHMxTA9+A2kHm9VAb/biwYgb2LdWtfhzqq9FCXAaZ7e9bd0FcVDKJ3QyekmBH7u4Q890Dbfoay4YhzOQC3AweFphr92HQ7e4uWd9kl2+nCW6lae5MjjT7dgB7lC9WmXFbHxZlRnFOh/y29AUfIWMf1C8cI/nkDjbaVfjycT9bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675042; c=relaxed/simple;
	bh=TBCx77+M6XzKENETcayx/D5LEauIQHANx2si3lOsDYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCB9PxAEhOBLIV3xltrJX51p/Rq7HTOhS28mZqBPBXIGsct8J98FnPgTq/qtBo21zGZL07srritTGf/rgmNvYtY9JE3jt68k65KvXNkENFLUVumQ4ybr04vU8oP6bJarMxO+WCOSdvmknpi7Ylex2YMmqKe5qzv+CfsJgWsp4IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUhq8eOm; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUhq8eOm"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36d8b644473so2096009a91.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 08:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780675041; cv=none;
        d=google.com; s=arc-20240605;
        b=Hvkf7xeOZcnlnultJIT+v+XrnnjLN1sypWfhpr8Vgf03BPs/nwMkf9ck4AafoiDqRy
         mHZ40GqUuHQ7+bHoJ6sfJFzQ+vi4l2s9ieTk9ThPOrxF+lDJFroSt1biCTpOAtXdGTXe
         U0e8HUgLbxYoBM1DVr4IK0FKlZ4jCgetg+aiI9Wzy3naDLxIGjqKEMJejaPVHh8UQUOZ
         oawWy+pX2/OUcp/rUmoG8l657Ii9vYrOpUdp/lh/fljBxjA6H92YJLh3w3pLDJQ5FZHW
         2MF1navrRRZb44NCYmBPsDAdYEXGUk1lFcjkCulMkCQ37mmKnUG5+6GpZ1bbLezAL92a
         gyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=654bqDNQRFUIIaXTWtrTKjWuyPmsZqtcOPLx+tPIL5Y=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=hfnCSIsawgzsj/Q5A+DnkoMGszRCyY697Jx9cKPDVzztlYz5RYU/pfwqRP2MTzrUdT
         xXmm81JS3BpYj9rwMYpSWDQIDRUzILGUZFtIj8LDw1Xyqri3+CXmccc0iU9QpOeV1y7T
         LAb9W8o3VovzSyKeXAXbMviFjNC2kABN710ri61EWHXkCHiUYxmqjt4iiTV/itizIIfT
         7Efc4ADMAUbT+53yXKpB4rVs+DnfQ7Ol4CBhVy3609+mNm1Kh0DM0d81m3RKkDQ9yEsD
         rc3KatoVjCPCLkDWJGCQ+mJEqDBlSqrmFXVRVtaLCg7PnJDpMdvD4FMelkmhHP/KtE8j
         etIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780675041; x=1781279841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=654bqDNQRFUIIaXTWtrTKjWuyPmsZqtcOPLx+tPIL5Y=;
        b=TUhq8eOm5d8k6IHOm2+ku6Lp+bQGk9l+28bfqyB0otS529pzwgXOV+Vrk+zjR6e7wZ
         w0LUDypH9bvNC5XN38zQJ45gM4Kv7hqLphDrNZ52cPEGr97/y3iXdxv+baMs+Mo+DDKV
         1w5th2nLLRHgL0IsHk2JyT3e5qKXkIWP4ifEewVt+JhfOjwF2DcK/4YKFtgm25nve73f
         KXRhklQLjSHZ1TpVj5UX7sOtopdhNJticXvaYh+0owinSVE0vrFpIIywZMjAgcbTtK60
         MskQY5yNjTlReft3b52no3rdBmtH8EA2evb5Iafkqmi8fymMvMqsQ0IWLDFkkzWKxqFX
         SDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780675041; x=1781279841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=654bqDNQRFUIIaXTWtrTKjWuyPmsZqtcOPLx+tPIL5Y=;
        b=YpVSaR9JXkBDo1yNDrqKEKUtQrW5y8fcqCfD4Sn6R5mtYxfwKPmThgnYPrNGlIU8cG
         iXyLb5JomxUBHSigX74L3ABN1eDCevVtyhb2pSd4yyph4DKWsKrLJ7sUuuxr7h7Wa4ns
         h1+AMf8f9cFSuIEeUvoPg6HfpxIGdv4kf0dRgHvKonJgIJ9u5FB/zVVfcsdT3aL76/8/
         u3zVuR5QsNxWSxr+cWVFEp56/Y6ri3bHf4eI16dGWmzeYMJaWNqPkgTqQcdXn338MOtd
         6QONh21KRhvhG6OnsG3/+f87iJYYpNLgJBbMYogQtKpqA2K42qS4L2wJy0Br3PbqhC9t
         HV8g==
X-Gm-Message-State: AOJu0YyJXbsynpQOnM3j5M+fC2QD30xUWBC0QYC0wR90Nu/F7lHWD3aW
	3GlsjvF2GZL8zMm0i47UCgOFQSHlT4oh3Ghl6AguSeL9IVa/r+oLHOtFrhafIo0GPOBRCOtOhzm
	QqZ//jCnYY3Z17OatA3C9Ty1w93+51Iw=
X-Gm-Gg: Acq92OGR/MtwEKLhRCbCHtKkek/r90msiB2KO1hLQm4vZdlCzdBoXWYnacLxMRZXyi5
	vy3z+arCNkvb3c+3RYswEDbaR/uR2jJdcF5SJzygxUz6fqAe9BS+5wE+E5/LTEOlgSsMImWM+f6
	okEXFlgzFagtXg1WLCfXwDf8Y9PI1h4dohg3qz4CHaeR7BbWl5bxblXMJbzckIfZyCge5waUSJg
	MgXFsDM9J+Ok0p0HsdjamHrGCwczLb1uLwGc4Wef0dSLXe4+Dd8gUkEZxVjSV3dQTFjhmFx1elL
	OUcvXAotYtcWMtglUw==
X-Received: by 2002:a17:90b:1d89:b0:368:ea0c:1b75 with SMTP id
 98e67ed59e1d1-370ee82fe25mr4549114a91.6.1780675040879; Fri, 05 Jun 2026
 08:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605133327.62535-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260605133327.62535-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 11:57:09 -0400
X-Gm-Features: AVHnY4ImDoqtm8QTd_jWlYrJEs7eF9QrDUn90iwj0LZanh50kG_Q9t3BHx3lBac
Message-ID: <CAEjxPJ6A4+MaU8hxp2WOtNPYxOG4pBkf89SRBHknOEK50kLxdQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: support custom clang-format binary
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 9:43=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Allow overriding the clang-format binary, e.g. for versioned LLVM
> installations:
>
>     CLANG_FORMAT=3Dclang-format-22 make format
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 972d5525..0e70f3d4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -4,6 +4,8 @@ SUBDIRS=3Dlibsepol libselinux libsemanage checkpolicy sec=
ilc policycoreutils $(OPT
>  PYSUBDIRS=3Dlibselinux libsemanage
>  DISTCLEANSUBDIRS=3Dlibselinux libsemanage
>
> +CLANG_FORMAT ?=3D clang-format
> +
>  ifeq ($(DEBUG),1)
>         export CFLAGS =3D -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -W=
shadow -Werror
>         export LDFLAGS =3D -g
> @@ -55,7 +57,7 @@ distclean:
>  FORMAT_SOURCE_FILES :=3D $(shell find $(SUBDIRS) -type f \( -name '*.c' =
-o -name '*.h' \))
>
>  format:
> -       clang-format -i $(FORMAT_SOURCE_FILES)
> +       $(CLANG_FORMAT) -i $(FORMAT_SOURCE_FILES)
>
>  check-format:
> -       clang-format --dry-run -Werror $(FORMAT_SOURCE_FILES)
> +       $(CLANG_FORMAT) --dry-run -Werror $(FORMAT_SOURCE_FILES)
> --
> 2.53.0
>
>
