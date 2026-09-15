Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C45363C63
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481382; cv=pass; b=K8z9+CBoPb5sJnls2REiq7W0xDyfhAdggwmZdg3b6cAsqR3gKrTH8aRmjwBTf+5Jy4uCUWeYBbRZ0+DRdEKVXzAQiGF2xeairgTJZSwqorwPMm4/+dp92Qs5Nkj1y6rc2481wxSaL9XYb1OBI9hDCgLEuPCPm6ylYyGdPlNlbbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481382; c=relaxed/simple;
	bh=H2HjJw984dleXMExl7nFobFLh4B5odmkPXC0iKA6vCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5DGdKCq2fuCvy9SukucqD1cFZWZSp+lEym5SzGjaWNsoEV9DBWsQzjAn9SpfmtArNTFWrH4SL56IEflXi/KqmKFWzP34nZh5zif+8M72Vykou1ZG5OXlFs5JcclGxXx9Q8uZglvjk7QaL1Nc00/L+lG4+n593ASTahR56Nnaa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I670SeVx; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I670SeVx"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-4788fe5736eso302985fac.2
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 07:09:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789481379; cv=none;
        d=google.com; s=arc-20260327;
        b=gss0r+Thdk32eYlSbXj4QUiSEeYgFoO054EMcZ9z+AB9oT0r2j3JD9AIMP9eALf3HP
         phHhYmWUHpBwi6hWBTqFjjPpnkG5zJBHY9Fhav5QKlj2iHa1m0r3Y6/FfSOJGKWkKp6R
         Swv6SRIqQRYErnaorBV//A7YzDP9ga291keg7SO7CN1e7lPP0Kc+oP+zTCe1mEPgds4a
         ru1sTTiI/ZusFjMGWrDklHwHWfztconK7Ovlkf4NyYsh7c13epH/0WeD7LaC3d7ym2Yw
         BnJODRdTvAJLSaBSJt4cH5wlWhZpXc8nfVJdEXHijkGqTaTIhzmN/WEqVtgKD4/o3o0q
         hKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T341kkHvymDWq3UfC3WpKeDRzkxTOVtWO+50P5CEv2o=;
        fh=N+TNwIyB4OftVo6xWZyGDxf9PNoaOqAOuhaF+GgJBDs=;
        b=CxCcfVV06QTQhHQPQ2GYa0eZffqkN7fwytcIGl6zoppxGQwI4dlrh7JhUQwyvuj9P7
         GG7dbVxJPM2gvgD7mKYtVBQeqlb/O7h3yXKOTx0HUuQVnM0kccrUfzc5mb8oDhjqKk/r
         pKxui+P64McXxB0j+mfRgXQnz6/N3SrlCyY4LRiqqUvkQCEezFMce6fIkNKAnqCsHjva
         D3sO4Mjkq7zNuHt9pxViNpd+bCTV0B9ZWmfcRF/U2j38UU35cEpn+QTdPONyeonLo8y/
         9HH1WIu1kSvXlKVrcAMsDPEmXjCY820AdVH/LznwtZxcU+cvaA2VrdjvTyZadNoqzcHS
         xlwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789481379; x=1790086179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T341kkHvymDWq3UfC3WpKeDRzkxTOVtWO+50P5CEv2o=;
        b=I670SeVxMNQDhI0vs6cKH96OyeMs4g/XxWw8r5/i+18b+4lc3nWOwFDT+dXuuySBmL
         jyRX2ZO38O/HPaGYEnbAoUa7m5Kh2uLoQcQgRodc8NWo6KEIMlCo9fcTro1hoaRW5OKk
         W7MIpLg2D/8p0I34QaSsG1qrpnB6xQN5qAeynliwByWd2w/zFNiZEdpiVqVpCOSZnSSx
         Z3jzoGPrEHwbnDW/Sy/NA3lnEl4PoZAAPVZD4eEWBWyMNVxDZZDOFg6TUMmidcUUFmM8
         SGTNDnDFKDcJXNayematcFs3datnKkc9U81d2S4ew8NpMladMGgc6BerFVNGQh8T0Byr
         CcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481379; x=1790086179;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T341kkHvymDWq3UfC3WpKeDRzkxTOVtWO+50P5CEv2o=;
        b=KKDPGGitd/uQRXzSbwiSa9Y9W1luFie1AXc7+6Vc117PZ2umfURCtz+H22OV8pdKLK
         TKtYdB/Q8yoZqIToqQqi1LfaF/kkA7IwL4XtdFC3gAV9/7dakXDWX+7MitFIqAy5e+Qb
         4CXdoGoVzGsQmNJ7gYDpEP6q3FiDPjv28OWsxk6a4Uq80q7/N9RnkiXMSVAgBjL1F2wC
         vn8t8q262q/XMGzRu6RgblSIlxxIi8T016DFWOBnrhRcjLTpK9qOuH+YcS8DOKVajnwB
         3xkkJ5R/5hlwtHrbqpGduLSk2URYLQeqaBMoQDSjxDwiO2AGyBegcMs+Iv0JJHxM2C9G
         UzeQ==
X-Gm-Message-State: AFuF++kNZ6t6r4h6/LGIxajX08NWSeZYD+VlVpxTK9uuoTMAp6LJ8NNu
	+zhe+8D2mzoqyy8/8DQVUdbUB5jeREjmmRV7uzAT8+wevmLqNLV/wsqsxCQbiq6vBVQjS/gSwY0
	r521h7qLhh3Cp8h94IHbEc7Z0D6bV+eiuLA==
X-Gm-Gg: AYBFou3ToCWIRZG4IiSqOtOP1UlWroy7NE2FksDSsMQN3L54S8HkhC/YAeE0mvAs/qM
	zCnEmeTW40SDUPtkGhBexpPodooylxeSOZHXKQEj/Bp2PKFHdfAnIK+22NncKVcG3VGjCkjWtO0
	99FzYuk3gbZVQ453QdX/TQy91zhFYRQb7D0RVDpYU/5W+TxGdgnXVlufK4R348hcqGLEmoppCUs
	wRTQhMK+F/hJ/Vzb9TndRYXmiN2bAXYHfvi3GZeOSi+wbuTWmGD0/pkMdWogmKrLhpu7BNyGGv/
	oRho4oyqTcK6KEUp8zeAv41ZN7mQd3oZmYAv6vlZXE1uzh/MKSa4S+Y=
X-Received: by 2002:a05:6870:3e08:b0:475:e066:7717 with SMTP id
 586e51a60fabf-483d38aca5emr880718fac.30.1789481378899; Tue, 15 Sep 2026
 07:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914153822.26027-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260914153822.26027-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 15 Sep 2026 10:09:27 -0400
X-Gm-Features: AcwNN1XAygtfAcusQx67LP8472SBwSgrBiSzQLJNcvE2jpr40eif3vQ50Ujrb-o
Message-ID: <CAEjxPJ7xjbUpHcTMLr=1fP4g1rpjqKJg=5MrWwKRkBc65S9knQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: use the correct value in validate_type_datum()
 for TYPE_ALIAS
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:38=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The alias-chain walk in validate_type_datum() picks the aliased type
> value with
>
>     v =3D (t->primary) ? t->primary : t->s.value;
>
> which falls back to s.value whenever primary is zero. For a compat
> alias (flavor=3D=3DTYPE_TYPE, primary=3D=3D0) that is correct: the alias
> shares the value of its primary type and s.value is that value. For a
> TYPE_ALIAS (which owns its own s.value) it is not: primary is the only
> field that names the aliased type, and every consumer reads it
> unconditionally in {link.c,expand.c}:alias_copy_callback(), and
> module_to_cil.c:typealiases_to_cil().
>
> A crafted module with {flavor=3DTYPE_ALIAS,primary=3D0} whose s.value
> resolves to a real primary type therefore validates, and then any of
> those consumers indexes p_type_val_to_name[-1]. No compiler emits such
> a datum: checkmodule (policy_define.c) and link.c both set primary=3D
> target->s.value >=3D 1 whenever they set flavor=3DTYPE_ALIAS.
>
> Match the walk to the consumers: for TYPE_ALIAS follow primary (which
> validate_value() then rejects when zero); for a compat alias follow
> s.value.
>
> Reported-by: oss-fuzz
> Fixes: 7ddf99ae ("libsepol: validate alias chains resolve to a primary ty=
pe")
> Fixes: https://issues.oss-fuzz.com/issues/560970829
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This patch has been merged.
