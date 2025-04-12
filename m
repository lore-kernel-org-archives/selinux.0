Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED41F666B
	for <selinux@vger.kernel.org>; Sat, 12 Apr 2025 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744472568; cv=none; b=e0k3TDcu5b0w6uoVysge05W0s+Hi9j/l747T/FDdSqPJnymgGdruvHYElLoQiuzCESJoMUaNyUAI00C/ckq8yYcQXSOjMH8a29AmisYo2wHYai8MlDyrtnNveLpyAZR762EdYeKxCY4hbk98bpILmIUely9RJ3IN3VYgspbi/kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744472568; c=relaxed/simple;
	bh=9r1fCvprHI/Fwu+b6naHK+J3XuBrRL5vqfNT9fO7irU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzsKoF1DFFpYHaX9pLUNo+4zzQjBwiHWiPOJSDvRDiIE2bm40ieGMC4/lS+OlJGpTcoHIRTygnFRrlKJa0P0bnuHtf4OOpBlZ+ZcrdRz/TWZBWy3hn65k5NKlUW7CXqWFMbg8y4cZJ78DHXeya2XIZg4q4hfYrlHWeITDxoM8Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SeDa1Kwr; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SeDa1Kwr"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fed0620395so29646777b3.3
        for <selinux@vger.kernel.org>; Sat, 12 Apr 2025 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744472565; x=1745077365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N72gVGwL6LDwo9WXyFANW+3dFDibp9BPtFifdmz3IsU=;
        b=SeDa1KwrI6Goa8dCbQUznwVrpXp/Cc114YgxZY7RA5e0GFlreobHiHPe7VFM+6FNJ3
         4rmps6kccydYDp4fjOk5iJLpCKkO5e3Xff+752LHD0kjGgbz0aKwLF3QXfWV1MimasUq
         T5UlDDOUwzA00EWsXnNtxTHVcYt6MLE3gR/poghtnetoVR2919aETKyx2COYH+UIPMPB
         KaullQDIPmwDSZRIM5OV45d7us0GtsJ/7JE7uPhuiyr0jmr+4sqeVWTvjLqKoMAQD1Yf
         ZFzJs3rnBVY18VRCq87mvmabMyhUfuU85Ur0grkIIS/4U3rFaqBQOm3PzFBezL27WZDP
         aQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744472565; x=1745077365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N72gVGwL6LDwo9WXyFANW+3dFDibp9BPtFifdmz3IsU=;
        b=CT9mLJY6J21E+gft//R43OmwisvbMD7iXx8J6M9f057sx9asazDrL8Q4fEf7VC96N/
         MFQ9jp/04P8Urw3kiQS50VxcMxQYxcmvXFJ40fDY3BUntMq3kBWl5vj2FUALFAckfnPE
         Hb4kSdVAH4IMrm4ATTr3NidNe0pNkyZqH6qlwalpHMxWzH9ZtxfZ2wAjFjY509Y4ewjL
         r2cEBl0XHb72eS7nCs9/CgXDdSWOix2ArbQoh7dyZ/PWspvf9W4JQsaY+zJ0Ccjn66EJ
         qxqNaE1ergWtHf0YAa24MKaArW1BYasF+XIkxPPhTsf5Dqekv3a6govbFn5jfjrACrKK
         dy3g==
X-Forwarded-Encrypted: i=1; AJvYcCXmRojYcEd6RbRdo9gRtSL29xj4BpKCjIdTwT46VeGx1CiBYMx9SdzuYAdortJCFvLEw06oghdK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9aKkEK/EhY/VLPqO4qsqvznAe8v9z5vNO2yNHZvg3Dj/KXioc
	L+tupOQVInnyvmRJhnPrrmqKlIQ889Q6lmI8WFMhpJwT2nv9xWzYcjqZccs4RuVkkbd4H2ajq+9
	jhG6odIvAhXaChAORZD+u+icTenNOWpr4fliH
X-Gm-Gg: ASbGncto9Y9MVMDkg+Q1pyZEZOCQ+KULo/wObGHZ5r9uaFX3oxRLFjC5Dsan7Z/N3sE
	hnmRKIyVPxBX0rO6gcCH1xuezMH+wQ/WRvEVCp3KefaCIjyYtyIZLxVA5OouxJeG8w6B0qREmaF
	BxlZ+Q8wws+ZSFSuNNW41pO7IZbB2jofNZ
X-Google-Smtp-Source: AGHT+IEyX+uhMl0JZHDFv+c6SdZXSaFV9mqencBlf8FeI70qT4AIQ+9THKDkeM0kMLYyPNSUMNymDepiUiIBXaBasMo=
X-Received: by 2002:a05:690c:39a:b0:6f9:a062:2a06 with SMTP id
 00721157ae682-7055998e8a7mr97270327b3.8.1744472565465; Sat, 12 Apr 2025
 08:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202504122308.Ch8PzJdD-lkp@intel.com>
In-Reply-To: <202504122308.Ch8PzJdD-lkp@intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 12 Apr 2025 11:42:34 -0400
X-Gm-Features: ATxdqUFEhb3li6yFyUwRXthyrUsNY5fOY0806sl6qpbGcyvNOZ9-5k0-LPnNYVk
Message-ID: <CAHC9VhQG8OMFUo7onZ9nKzeHAMkFmnNHUm+Oy35sh5FzPjQciA@mail.gmail.com>
Subject: Re: [pcmoore-selinux:next 7/7] security/selinux/hooks.c:3173:
 warning: Function parameter or struct member 'avd' not described in 'task_avdcache_update'
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 11:21=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.g=
it next
> head:   5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f
> commit: 5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f [7/7] selinux: reduce pa=
th walk overhead
> config: i386-buildonly-randconfig-003-20250412 (https://download.01.org/0=
day-ci/archive/20250412/202504122308.Ch8PzJdD-lkp@intel.com/config)
> compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df=
0ef89dd64126512e4ee27b4ac3fd8ddf6247)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250412/202504122308.Ch8PzJdD-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202504122308.Ch8PzJdD-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> security/selinux/hooks.c:3173: warning: Function parameter or struct m=
ember 'avd' not described in 'task_avdcache_update'
> >> security/selinux/hooks.c:3173: warning: Excess function parameter 'avd=
c' description in 'task_avdcache_update'
>
>
> vim +3173 security/selinux/hooks.c
>
>   3158
>   3159  /**
>   3160   * task_avdcache_update - Update the task's AVD cache
>   3161   * @tsec: the task's security state
>   3162   * @isec: the inode associated with the cache entry
>   3163   * @avdc: the AVD info to cache
>   3164   * @audited: the permission audit bitmask to cache
>   3165   *
>   3166   * Update the AVD cache in @tsec with the @avdc and @audited info=
 associated
>   3167   * with @isec.
>   3168   */
>   3169  static inline void task_avdcache_update(struct task_security_stru=
ct *tsec,
>   3170                                          struct inode_security_str=
uct *isec,
>   3171                                          struct av_decision *avd,
>   3172                                          u32 audited)
> > 3173  {
>   3174          int spot;
>   3175
>   3176          /* focused on path walk optimization, only cache director=
ies */
>   3177          if (isec->sclass !=3D SECCLASS_DIR)
>   3178                  return;
>   3179
>   3180          /* update cache */
>   3181          spot =3D (tsec->avdcache.dir_spot + 1) & (TSEC_AVDC_DIR_S=
IZE - 1);
>   3182          tsec->avdcache.dir_spot =3D spot;
>   3183          tsec->avdcache.dir[spot].isid =3D isec->sid;
>   3184          tsec->avdcache.dir[spot].audited =3D audited;
>   3185          tsec->avdcache.dir[spot].allowed =3D avd->allowed;
>   3186          tsec->avdcache.dir[spot].permissive =3D avd->flags & AVD_=
FLAGS_PERMISSIVE;
>   3187  }
>   3188
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Fixed.

https://lore.kernel.org/selinux/20250412153736.27881-2-paul@paul-moore.com/

--=20
paul-moore.com
