Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D433BFAD0
	for <selinux@vger.kernel.org>; Wed,  9 Sep 2026 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983050; cv=pass; b=iJ/eXjXprcexMdMg7XoOuDKGEyQZL4ZNAe+S0sZ+9M6sckqDmYPzjGFDBW+iPPn7dOtwYj7PtGrrwx19I2T/JTYM/s+d6GKcpurNwd8GEDZuV5pOBkGPe/Z59qHi0yIdRToAg/kk25f7ndD23mPiw8jq6nVQq0Dn0hLiQkb2nEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983050; c=relaxed/simple;
	bh=67Rh5qWd6Yp0GDLqqLZwMMLrgxSvN4aVvVsdIHCnYH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=De4XgvYjf3S5Af794IT0nhL1HyNlWN6tA3foW4XmwsqkO4KLtLUthHYNMlojnQLDByniYg8KPYwKZl36fuVtKYDwGV7/mdmHQwoSjQ74qaDdud73WrYLJjQZKakAdtf0mPSoGdYAsJ5TvBf4pU2J2df7ZJUIbOtEJj9SxSXUPys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOzTTaEY; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOzTTaEY"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6b7b4b08d78so3944676eaf.0
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2026 12:44:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788983048; cv=none;
        d=google.com; s=arc-20260327;
        b=dE1KLBDkyZ6rde9eh3nI3X5AjgLILaKPYYK1Ez6QjO1l71lSOhxwvbPxv5pf28hW4u
         4Irwc9nzq/yx5IUQ1kisf1V2kRCFsZJA/jT9j4gHgSNwpUZXP1a0Fd53PjtJaVBeLjv2
         DLhUfOJAvKVMxV1nmlPMZRBI/ESW9siIgk/Zt28r0mQaSqhuaIoG13y83QxjELQ08fa3
         NiTAvdu0YsNeU5zmsNIVkgVv/b7oMkYt8r8a4ilGrs/+UK7nIS4stDS+AelFrF07/YQU
         X6k1o+2dWsLcsp8NEW3Ge/Jjj3dbQr4nT/wcecl4lu/bhwBHTsjx8JahNXPa79zvaGxO
         UeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RVSgShsz0FrwDMVk4wTuFNIYbdzNfl3wM6vDbZc9w34=;
        fh=N+TNwIyB4OftVo6xWZyGDxf9PNoaOqAOuhaF+GgJBDs=;
        b=G07J3OBQD5qhZzuXm0XQi2GrM9AgNFPiSPzvomRdQujlvnA5nBOucrsjSGV4k+f42S
         4Zaeqf5y1CSrGKrvyolmeP1OyBMohKcFSc6n2RR8FZuduVSqgdxu5yTRRaurJKCOwaEJ
         srfL/ah693EtSkknvq55vTYJ3ynqDDop8ArtkSwImAqNAgZo0WqGCTMyVeJTCnqDGGbB
         /x9a+bstj0L5tSTncp1PQFhJs3CuxV0XVtCg3IvhFkl75LckIYysvhcqTU05La9AVT91
         pKZl/aARRaoNDGW4nFVzTTQQj186x9vuFdtyX9PmFRz8xbX5fx0Rx50mJrtgUMcsvORS
         xGKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788983048; x=1789587848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RVSgShsz0FrwDMVk4wTuFNIYbdzNfl3wM6vDbZc9w34=;
        b=JOzTTaEYfdk35IcQrVh5aKS6oVwoJ+3oHTyHX/ksdd4LXh6mAsSC6LhBUUSo5yMmxH
         i/7HslcVfZvpEFChZ4HsdP5zwP1xyM0q+KmGdak8ZdNAYbvRkYCUSnLL1+m3APMuUznq
         PLXq7jSCkMLnQVLjELm5X8cjSIdrSjp94i+HhYHeXeMHrLUyj9Fduaesr2A6/xF6HAK0
         6lQYsx4o2YkmcawOQix97fu1a7CEPfje6PmyHiNpaiJaMhBxUZNchtWJZO0H1NZM/0PO
         6uQ6Rpq3dQZDeJMg6Xz5TTE/LuUf5eAWdXTmGlbMGmPX+UjMM7Nc+47Q87vYth09SW6g
         jSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788983048; x=1789587848;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RVSgShsz0FrwDMVk4wTuFNIYbdzNfl3wM6vDbZc9w34=;
        b=ELh9OgCqy+BCN59U+Z8625qoYzIScssIqe5thHqIpMqmu4FygdlZ7IiljnBIPK1Mgj
         A18KZ6oU21Z3VDrTEkCD718mhMxHtYSl+xSV1WI26pzhyCrM2VKGuvu5TjyYgjdsKK9R
         rTXsaa3QaLGNvWpQTcZSS5JvDdU9t9/9uFsKLJ/851TaS7J+HpexM1Y+7QA73glcEytk
         F/D1P6XfEPCK46np1+F/nNn28luXkiYVrtsiiX+OL8hKWN5erCYQtyz2EmUSktjJ+pGi
         LjWUKjoChU2cWa+Td7OqMK1EX4IrhdTXmK+ha4J67fxjooLkuXgVZJjX5CHjt7OwYiDG
         8aMg==
X-Gm-Message-State: AFuF++k03FyNVwmLh3H0uIhfnOwym7ZvpGjG08/QFzNlsQcgZK60I/ir
	/KX1TGbiNYjOkLlo7goUpKkPt8l1oXi8FViLl78aGVXxlAMKzyTtoFxaUSlcczopc88nl0e57/V
	hTAWX4XlXGIrLeglWj3/d1eKLFYzrcBJ+4w==
X-Gm-Gg: AYBFou3d4rbnpvEb6GkFolDbRg+vCJSPGJEYxsz24pzMKeVh3H4DE9Hqs1J+c1Somf+
	1d/HIO+nUxD6TAzGapKDG7JgcURqNFXeJe+I3iFjaz5SBOXXAghgwbM+85lkfIePhV9W9q2YQE1
	xzjIezr1RdzKH1nEkhICbGtOrML73oUYLedLARnbVAxt5n1GGZ9Y3x12B+mpO9YyeJ4SlcTnHpw
	KTaTzEReIeU0keQ/LbFosS/pg2WF1wsiB7r3L5xtIJMV+r+Hpq8XqReSxFJIwiEMlJrtUILsH9E
	rcI8Bz4aHTslTe38eNhEMuDuigTwDwF/KkFFxbyCTK5qOmPBWHKiHno=
X-Received: by 2002:a05:6820:f035:b0:6b7:83c5:fde4 with SMTP id
 006d021491bc7-6b783c60303mr17200120eaf.37.1788983047940; Wed, 09 Sep 2026
 12:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908200332.23630-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260908200332.23630-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 9 Sep 2026 15:43:56 -0400
X-Gm-Features: AcwNN1XlxLXbeDPwjiwA6aO4sZQZG7uf_haSmEEUEl10JBEcRIUJ-2OOYtgZeDU
Message-ID: <CAEjxPJ7599ogTPsGkVVL8y+UyqWuBkrr_=24jjG2MG2YLbn2uw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol,checkpolicy,secilc: split min/max policydb
 versions between SELinux and Xen
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 4:03=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> checkpolicy and secilc default the output policy version to
> POLICYDB_VERSION_MAX (currently 35) regardless of the target platform,
> and check any manually specified policy version against the
> POLICYDB_VERSION_MIN/MAX again regardless of the target platform.  As
> a consequence, checkpolicy or secilc with -t xen and no -c 30 option
> produces a version 35 policy for the Xen target that cannot be used by
> Xen.
>
> Add POLICYDB_XEN_VERSION_{MIN,MAX} to policydb.h and, in both front
> ends, resolve the default policyvers and any -c checks against the
> range for the selected target after option parsing (so option order
> does not matter).
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/537
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.
