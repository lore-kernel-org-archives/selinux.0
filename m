Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A045C4C9553
	for <selinux@vger.kernel.org>; Tue,  9 Jun 2026 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031603; cv=pass; b=U4mCf1pAuurXBFhOYE/zDzIeTOb96C3eDvCDWRU3VUJbFhqvenWnHE6bRuF3nawJbegHhTQM5+qlla6+Kfkbi9/oH5mZG7JA5j4xtiBaQcDrkQeX8EXeFSpq3MronTh3pj4A/jk5IyShL8hZ+opnIbBwyIfVHaliy+A8b9Y2qBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031603; c=relaxed/simple;
	bh=G8EiG1fO7cDghOOmLdXusGE2Rw7RXLDcps1jMjPJ4dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4Hj7RLc81ZYhgZy+9yzISP1AWEgRV2QjqM+x1UZgW2ydKpEjHZcxOyQKwveVa2mfv8IhhPSCOMPy0SJn3yUkYn4WwLdN9/TZHop3PFYDSCsxe9ciZ7J2sf/Lpu6w13ajHDKeo1VhLKNm7FddSE1VQXsM6f5OvVZ/jBJjiXjqc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0MjPLuV; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0MjPLuV"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0bd02d97eso66778505ad.2
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2026 12:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781031602; cv=none;
        d=google.com; s=arc-20240605;
        b=fGCeGsQQ/t5HdX0Ui9h34usostedkkJBTqbx4IdfjjFC0UMSsfxt/X+BSgHmNbnuWW
         oSSjdGnHmHj912iAoWDFiAIKFTQ70j5mhyR2cVaWFQPEQL/FE0t3jDC6XBbJwfQqtdez
         rCWSuhTBaHmSZGY5fVS9FmrQvM3Wy+6MEShHJ3S9WC+Fv6xR5hnxbrGNutDyzsefqtIy
         BJ5vvgBkmB4Cmi9BUspHTdg0xW9VglrdTEmzZ64/zWA4NGlJLQp/JH45yVM8nO8J2X4h
         ASAOEtsFgs8KkXVBb0WzVLmtc6ytYIoueBjWOTp9IN/BgjaqWWN32/ZARFg7p43Yxh+p
         PQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8cD8nWsGF4fl2INrTCTP1TR8uQ1MJcxONrZy+IUyF9c=;
        fh=teCuqbtyRM4Tgu/qjn48lO8vG8x3Xo0e287DZw7JaQM=;
        b=BVNROCB8gqVuinl0U97EStxv1XI5h1N6l8MW/wes8jUzW+xrk1sh8lC9rr/3JLazib
         eLLBbolEGb0qVRkyV9+NVeS8pKFETLUpJuI9jcFvUV02+f+JL72TSCttB7edDgzaiz6T
         9Lb3tVB5wTyUbPwhbWZ9AXu8c04qwkXRFmL61RdWRIGtSfaMnPZVwKBEt2aO61LBfIeS
         7C+BumMR3s8PBKFdFAA1Ok2XBC0/aPPVUCDNkvsXnWuZhO7KqrCm7In3IJ5+HaqaTpVN
         ekvxrjfBcrpakD10o+Xi8sRZxCVgVXJUZjrDuznCLPnKQroPai5tYs54Z58RjW1vOLGv
         T93Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781031602; x=1781636402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cD8nWsGF4fl2INrTCTP1TR8uQ1MJcxONrZy+IUyF9c=;
        b=T0MjPLuVaV1gifsUA1WyC4e76PhyvD/sYxPjFBOHlNENO3xvS48+e2fRh1k9WZtsQd
         FRq85bvD8UnhBW+1QlL54kkLLKCxvRRjRtIetoVlSsVLdEQxaqIUpr0sqAHrD6NROYXD
         CrR0KLeUM7WA73X520Qyw5HVO0nJWVC02VgyFi8DD4lPkiK6CUebNOellvHyJwgR4fLc
         6girRKS1Oq9vxAlDY/5MAaNfrd/TQYDBeLjVg46Pb0Ws8P3PDbSNLsxdHZsftG+iKS/j
         lE8h+PdHGFyKA7c3YapId/y1BF9V7Z5qf0CyKtWwTTL2PWGWVlWfdBRsvuc+KaoeU1Om
         z3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781031602; x=1781636402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8cD8nWsGF4fl2INrTCTP1TR8uQ1MJcxONrZy+IUyF9c=;
        b=Sm2PDYnIj2y3q+AcFdf60jiLgKZ+wIfSlKZPjUBSSLrvE6yiYlFBBBZWeQMAAXkJ7b
         zIBQ0mwl4G93f5+XRMV+dq8OFF4hYh7Ki2RRGBptEH2Hrkzw6crbS+z57QXAgfRmkoXZ
         GYcx13eeVmoHK4D7Ooz00/mdrETChCEMXry6RnAOZzRMKqbIgEvbpGmQjKaPROcImDu6
         LuapcdEsFfNJuikJMCEAZRVFIX34AFhcth7H+gPaGN5VihawOZlCCvnEjEtuN8JlLX8Q
         Yvhr5FzjP8uHQ3bCkAATgiYW9URfjXxA1GByOJJ2US9rKI02FnXY9OBDOlAW9MRJqHdA
         wmaQ==
X-Gm-Message-State: AOJu0Yw1wz84cNFUdTh1ccVRfakzZw1Cl2uKVwBRjEAiKxUDefybv9Hw
	Dd6AUrbqQAhnUgawX4rCliOnI0N6CPuq4aC2yP0yxLDSc2p011W5U2E3JkPtFKEKBX4tT34dLFR
	wtqXDaUJl+HPNASuVvQ/iD9y1g1RUsjfP0A==
X-Gm-Gg: Acq92OGXKpGhZiuhEJnuHWHWHuNi3u56UtfgtNYlR84t8+jwc5HNJVWui8w/UeXTrMd
	Z5YGRZHStZTadT23EoQ7L/+DnjQuYmqq00CD/Q9dHBXo6MGM40zRJW/mi11DS0UrsmNRfgAIYKT
	8RS+7vEYEWXyMIysvlqYPNi4RlszdW7Ym1r6bTHGLEt7DkFa/5FPfxw5VHhLs3xlqMsq6ed2H2G
	bSEr7qnXoUWdAcxnzOlDfIU57ZVgRhWBloJBYK+2FZ0bMoyXcgoZpCkC2YbCyG9uh6YTjJn9qXV
	GOtXa6zywhUxibCB+A==
X-Received: by 2002:a17:903:b0b:b0:2c2:1e6c:450f with SMTP id
 d9443c01a7336-2c21e6c46c8mr181859165ad.10.1781031601793; Tue, 09 Jun 2026
 12:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605191355.281484-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260605191355.281484-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 9 Jun 2026 14:59:50 -0400
X-Gm-Features: AVVi8Ccdxq7C4WS3MMHPowUtGOcXQJIZMhCL13mjPC9y2--OlXU9tKe71thrUKs
Message-ID: <CAEjxPJ4k-3a3QfruDYnE8dO9srD9qVf_OM0X_RyojyzMaWadSQ@mail.gmail.com>
Subject: Re: [PATCH] add test for fts_* availability
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org, Pepper Gray <hello@peppergray.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 3:14=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Pepper Gray <hello@peppergray.xyz>
>
> check if fts libs are-builtin (glibc) or add -flts
> to use standalone fts (musl)
>
> fix: #514
> Fixes: https://github.com/SELinuxProject/selinux/pull/515
> Signed-off-by: Pepper Gray <hello@peppergray.xyz>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  Makefile                | 6 ++++++
>  libselinux/src/Makefile | 3 ---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 0e70f3d4..0e465f94 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -27,6 +27,12 @@ else
>                 -fno-common
>  endif
>
> +# check for fts_* availability
> +H :=3D \#
> +ifneq (yes,$(shell printf '${H}include <fts.h>\nint main(void){return ft=
s_close(0);}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -Werror=3Dimplicit-f=
unction-declaration -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> +export FTS_LDLIBS :=3D -lfts
> +endif
> +
>  ifneq ($(DESTDIR),)
>         LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
>         LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index c0e18321..9982faad 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -99,9 +99,6 @@ override LDFLAGS +=3D -L/opt/local/lib -undefined dynam=
ic_lookup
>  LD_SONAME_FLAGS=3D-install_name,$(LIBSO)
>  endif
>
> -# override with -lfts when building on Musl libc to use fts-standalone
> -FTS_LDLIBS ?=3D
> -
>  override CFLAGS +=3D -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_=
CFLAGS)
>
>  # check for strlcpy(3) availability
> --
> 2.54.0
>
