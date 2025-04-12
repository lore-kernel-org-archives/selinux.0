Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E2C1E5B90
	for <selinux@vger.kernel.org>; Sat, 12 Apr 2025 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744472566; cv=none; b=EfGIaHJWAKcpL/wlmW86MR7dG7J8gE9kCOWGFLNdLUwqK3jBnuHBbRlWyyr1aLCQsvXj3caDZHRwiLHqtz3NsiRe0yuUY+i5ev0YDuKa9SKdZaCV+ecF53UY7zcpJOfqy9CqQFKG2W3Udz/183Beq+f2n6xucgxX9RXc8g0yMLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744472566; c=relaxed/simple;
	bh=ikR8zpKuK6iSSiCTim3scw7wAQGZTAj9MOga5PJ12tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rU1BNT4bTPrcZyi9ItzgfPn+oZCVp5ISqriIlcuwo5nQHzy7JLUz5cDLuecYQiiXSXf0G7JAOwdzJstDvyYa1CnGYdZSqmuViLjXgOMkpZxfGo1F9gQaYfGnR3imPbrG3z5HSAuotDtK/1xGZt8yng3FrkcjyxacTpVogiov4A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a+tOZaNX; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a+tOZaNX"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70576d2faa1so549857b3.3
        for <selinux@vger.kernel.org>; Sat, 12 Apr 2025 08:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744472563; x=1745077363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ConPm8IJT23r+6UcU3AxVgkNM3TyFNN+jLy1yNFH5Ck=;
        b=a+tOZaNXrvRIkZZ+auKDkBXSewIQtv+hYo1PNTKnkuQIu0ATCEWgrsQcb4DPAXKavZ
         NybJ36ydMTzqevtbALe/JbzcPSVoh77OZYbgkEeJjBJI+49ER3Ol1t40Nc90sSoYhoBe
         RvIA7VZOhypQ75MCySbq7r3ivcKgwI2MfzHd+T4j/ipXycBZV+c8vMid71HL/EeS19yw
         I1d+qGGMH2OThwPlXRUBsxH9FSk0hOoDauGZa6swXkfr+AXFqIKXm1wgCOYVp1jYR6Ds
         CaJV1Oaupus9Xf5mCuC8Xee0mEJL7rL+uOuBToIMNy0hCjw3Yn1mcUu06+G7lPmSqhbr
         96bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744472563; x=1745077363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ConPm8IJT23r+6UcU3AxVgkNM3TyFNN+jLy1yNFH5Ck=;
        b=fCpa6RhEuGxXmTf0u7Z5yQeoXyKFw0Fcou4aBJ3Vf7MRal1zIZsgLqAIKTdMzJCOcX
         KoOe6mO4PkCLSexNT4bklkbvhEA64KJtF6LEhN6yAr/e5vUs6fWkKIKj4H+fYCN9e2sA
         3BZ+n9DCWsspuBqRnZVpq30lOiYRHKrI1PMauMoiBckB//Su0eEp8soPU9kIX6TKuBud
         oHcUqrnVqNVHjIwzf3mPBPTyEcCBtYU/HjMUaAOEvUoO8ZRBm5tEGDMGD3qcSvMwI4ir
         Zcqa1KwXFixn36jy8WO4n5oLqPS5GveJkosv/V5pvH0NmNjtCC/UBUVPfh9WuOSiTLlw
         pzaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkOgo05L2P2dB7VU4CTTpfx7EqhF9OmhSI8FRbscgBo2vDNbbLyH8/Tr6srjqluXlVZtnXWak7@vger.kernel.org
X-Gm-Message-State: AOJu0YzJuKeNrUDXvWBTg1NwgB3SRmFA3seHPxhZvNsam6j8gyuzWwol
	S9rfSu9+K0G7sbfLQT1UHdHsXOQbxv25ci6Tokez2XF4dQPU+b4dz2G+euF3MjwrcxewsEcwpyN
	XHomwChQxrQDZ23bdfMLPaEM7JtvUIABycVQO
X-Gm-Gg: ASbGncvxsbAcvafbvpmFmscVLiW/9+aOtutW6X2jU7fIiux5z5DOHfOFf7S/gVYYcIJ
	p9Zg3si48KCX+W/pAebj6mAWD3chX2kobm5tzOQNTayrehPK6M/W9xqH7D1i4jklCBMiNumnqrT
	g7JJ79t+EUnEPU2M5Y3t5zQA==
X-Google-Smtp-Source: AGHT+IFHTR/J1ToqOsLLfRswA8bylDousXZSQOr7tW7I+V+agP1IN8sa62DzJO9DPRSzTRFooIitfK1pXLo0cIjLiZE=
X-Received: by 2002:a05:690c:4b89:b0:6f9:b12b:8953 with SMTP id
 00721157ae682-705599f52b5mr119148267b3.20.1744472563546; Sat, 12 Apr 2025
 08:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202504121945.Q0GDD0sG-lkp@intel.com>
In-Reply-To: <202504121945.Q0GDD0sG-lkp@intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 12 Apr 2025 11:42:32 -0400
X-Gm-Features: ATxdqUHZa2n28asX8D_hZjzcFjvbX_5AUbAtNrYRWqf67A6BvveAHXl2YzT_Sm0
Message-ID: <CAHC9VhRst8Z8LH5JcGhi62ZPc3MzXeA9c_eFk6tBZVRVfJMUFg@mail.gmail.com>
Subject: Re: [pcmoore-selinux:next 6/7] security/selinux/ss/services.c:
 linux/parser.h is included more than once.
To: kernel test robot <lkp@intel.com>
Cc: Takaya Saeki <takayas@chromium.org>, oe-kbuild-all@lists.linux.dev, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 7:34=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.g=
it next
> head:   5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f
> commit: 8716451a4e57cc82f3656d7a71b67d3b5831ef3f [6/7] selinux: support w=
ildcard match in genfscon
> compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df=
0ef89dd64126512e4ee27b4ac3fd8ddf6247)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202504121945.Q0GDD0sG-lkp=
@intel.com/
>
> includecheck warnings: (new ones prefixed by >>)
> >> security/selinux/ss/services.c: linux/parser.h is included more than o=
nce.
>
> vim +49 security/selinux/ss/services.c
>
>   > 49  #include <linux/parser.h>
>     50  #include <linux/vmalloc.h>
>     51  #include <linux/lsm_hooks.h>
>   > 52  #include <linux/parser.h>
>     53  #include <net/netlabel.h>
>     54
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Fixed.

https://lore.kernel.org/selinux/20250412153234.23169-2-paul@paul-moore.com/

--=20
paul-moore.com
