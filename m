Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4013BAD82
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412586; cv=pass; b=hdzQCfuggryGU0Nx5RGCkGxaZncapsv0aCNJvOZ7ijN7KiKOyIHgiM9y8JolwQ3nGdtwFXtYRLNkc8hjh5Ll7pSALna3HTTr5JQIHM9IQxmh62f1pQQqgFSdjIuCgg1SdYQxTBXxln1vQApz1K1A7mSSIBIebr0zsUWJ8K4VdMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412586; c=relaxed/simple;
	bh=gyKyNofzJ1T2ETMMDW3yyyckClVmKLYc6ZS7bDhXQEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjI5hfkGKRDpZdqqYFdLyUNs2oDsWuszTD9gw0FI3tsXino1/SqdKpbT4/S0l06crrfrL7gmvXSRcFIqzzinIVihYdGi6J72ZdZHHOYQxTY6pmnYzgeXDsyAEwceqq3WJ3sVhSAf75KciXbAFltSVyF6YgDkTdo0TVHGJ7qwYVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLWQwJ1b; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLWQwJ1b"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423efd76c8so1645116b3a.0
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 08:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780412582; cv=none;
        d=google.com; s=arc-20240605;
        b=KS/VQ2/6TOV10TZ3GZHIpHdqn969bGFSu+s/IZHsYqCB+QOJhV6ZfxFLgdnc3qaCIr
         BQgg+/+9kteBiPsd3YfLE5/wDgAYjcKGC2ZeDcVNbgl3AQc6dMN8ouGHtdzISCEGq9DG
         FzYKg5VyWf3OKrf52Z72QvIkUsFFQOyPtssxqfuCJlvOZLDZSzo1wZFd3mRxQQ8wIq0E
         B4D+Q8cVUQ4feA8QZXabxh9cd8fz5ZuuXMhq2NOPuWwKlEoC/6NbzKHJ+HDjMXho/Cu0
         /234M5bp93PKL/hZmcsfw6rkgmCDvjNMOuzixqxD7p29gHt9wAkDFMUMjGqXY0sbyOWe
         MV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ERA6QmcHg90fD+faSazy3V5u4yaSQReiOWj20cNATFI=;
        fh=ZRedc575flThWjp0FOeY4xu8TVTKDyGyGDcFPwDIv+A=;
        b=OjTHjrIg4LFVAWld9H3MX/S5K3OEv7zgE40pKLJdGtb5qt8f/dvzOISVE+FI/3Z6Ah
         Gb3C2WkaxjyLtZaJFpKhovZzHTXxpgsY9INbZmq4Bz6ylCOgauHWMX/E5L4lErhuR4Jo
         CyFpreWt/YVWvGu9KcsgavoDtKSFqUg2iA/I7LfdSYaRKeDVRzg88HtNnJDUkXR8nmVI
         KkyXvxGf+DSvjv/HM73mLjbFIJRJHumCRXsgCtbHAPxVUwRemqdhY8JFOutWHbUq1ETZ
         +9ZPs3tZP2UqXU/kpZZF0veJNpcp9FPWv2KFNaZZnHRaQhTRxzu8gxmB1GyXngX5fRDs
         q+jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780412582; x=1781017382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERA6QmcHg90fD+faSazy3V5u4yaSQReiOWj20cNATFI=;
        b=XLWQwJ1bmdYnvrPeVyV/2CSiTrO4JsGI5yH6Jt0EstHYuv7prPwCNOtFJBptkT8SN7
         +wMxdSoeTJV9CkLpEwMJW8WYLa9ggD7Knd+uSGClOTSCL4wT3JOhc9ivIq7H8te7RAlT
         SC1nZz4hGtJA1xJMItSys/6W4TlyuyPZ8pQqCUKwRf3mnHJNRqy8xs99RU+V/zO3B6AR
         NhgNNaY7f07Sny6kQJa3/jIzkWn2G1Mwo5no3vfVtcVGGTKv+KOAmaUKccpOrDyKTk2n
         jcXUKjZFRUwIHqTEmDamk9rLllderzGpj9mkHcVuEpHe+PRQByFykbIpVqi0HkmPbZRt
         umLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780412582; x=1781017382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ERA6QmcHg90fD+faSazy3V5u4yaSQReiOWj20cNATFI=;
        b=oGIumWJqCOh+SdESkJqrnJQeFP46N9LIgKX1yuhCq715VeS6Z+Eo6DjXeVxxDwirNR
         FG9Oi244Bqhx2Lt87f63f43Sj1sNeJHNLxIF/ixafuUu8D1g8j1oy/Tx5VcY3YeoCzFL
         cyVH8amWiW4voOyJjczBgXNSBYsPNGtq7PDB3XhEerlnnkA319CXjYB4k1LkGT5T9Dqg
         H1ERBRfSHLBGPFLT9ef2QBLGNXbtgw0JbqyYzx/tsZgyEHonw0OBDPOsherQQfjSwDks
         z6zDimXQytpSLeL+4JXpfN6kNAWV/aCv/xY9DmWI2so/TCwnJWJYSN/5Dvz6sVxsqwEe
         4h6w==
X-Gm-Message-State: AOJu0YzKIHBvcfwOQsnq92mLVSL8bdmLvDiywS4JkDIyb0+mC7HpeCyr
	xYQq9wA3jn6spBW8Dpng0vfpL00PEN3ZJ2HsOdCLB5JfHcQ3CQAiEks8XF6kShtAU6tf0BRM4zY
	PAgVVsKMmNhAnCZ5syRkTVeex1FHUk5E=
X-Gm-Gg: Acq92OFOucE+1ubuNBqmMbUB9o9RA2FBviK6ti+5jUuNjPAvvXV2igIV8i3lAJ6IPMq
	0MVlOTtdHlHMyDx20i7VHgl1eeX3sMCKSb4s01XgTP4VoNXc2PCmBo0W1XqUFlFp3Hb8fNtB7m8
	vF/Bf7bLVHKUms/37kCZaz2451/ywhN4l+rIDLc+M9T/Zr0E+xhaFgFhA6GMguX8lkRTsX4eTGu
	KJhHGbpw2r0rT6pah1jbDCZ7wBegMz0ZLM8uRpQNpD9JnVvJuzSfN2E0iAnsMCQoo8B0p5h1Tvz
	9tQRQac2ygOmwyLm3anwm4pIUl++
X-Received: by 2002:a05:6300:14c:b0:398:89b6:1b41 with SMTP id
 adf61e73a8af0-3b4281d7496mr17146611637.32.1780412581386; Tue, 02 Jun 2026
 08:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602144820.147382-1-jwcart2@gmail.com> <20260602144820.147382-2-jwcart2@gmail.com>
In-Reply-To: <20260602144820.147382-2-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Jun 2026 11:02:48 -0400
X-Gm-Features: AVHnY4I3iK_DH_lcNrdLEIRi8Lda4nYZwoKM6YF-Cni1Tsbv0QFyGFcM1I8LMGQ
Message-ID: <CAEjxPJ64drwbLT9BO7qifmVYzwS_z41uD7qVA=01siSsuwCjEQ@mail.gmail.com>
Subject: Re: [PATCH 2/3 v3] libsepol: Add a function to output CIL
 declarations from a binary policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Doubt you meant to delete the python .i files here.
On Tue, Jun 2, 2026 at 10:48=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Add the function sepol_kernel_policydb_decls_to_cil() that takes a
> binary policy as input and outputs the declarations in CIL format.
>
> Also move the checks for a supported policy to a new common function
> and use that function in kernel_to_conf and kernel_to_cil.
>
> In the near-term this will be used get the declarations from a
> policydb so they can be used along with neverallows written in CIL
> to check for neverallow and neverallowx violations in the binary policy.
>
> Suggested-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
> v3: Split out less common functionality to keep the same order for the ru=
les
>     to prevent breaking existing tests (even though CIL is not dependent =
on
>     order.)
> v2: Added more explanation to the commit msg
>     Split out common functionality
>
>  libselinux/src/selinuxswig_python_exception.i | 1224 ----------
>  .../src/semanageswig_python_exception.i       | 2128 -----------------
>  libsepol/include/sepol/kernel_to_cil.h        |    3 +-
>  libsepol/src/kernel_to_cil.c                  |   97 +-
>  libsepol/src/kernel_to_common.c               |   26 +
>  libsepol/src/kernel_to_common.h               |    2 +
>  libsepol/src/kernel_to_conf.c                 |   29 +-
>  libsepol/src/libsepol.map.in                  |    1 +
>  8 files changed, 109 insertions(+), 3401 deletions(-)
>  delete mode 100644 libselinux/src/selinuxswig_python_exception.i
>  delete mode 100644 libsemanage/src/semanageswig_python_exception.i
>
> diff --git a/libselinux/src/selinuxswig_python_exception.i b/libselinux/s=
rc/selinuxswig_python_exception.i
> deleted file mode 100644
> index e5e55a79..00000000
> --- a/libselinux/src/selinuxswig_python_exception.i
> +++ /dev/null
> @@ -1,1224 +0,0 @@
> -
> -%exception is_selinux_enabled {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception is_selinux_mls_enabled {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getcon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getcon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception setcon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception setcon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getpidcon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getpidcon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getprevcon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getprevcon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getpidprevcon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getpidprevcon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getexeccon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getexeccon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception setexeccon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception setexeccon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getfscreatecon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getfscreatecon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception setfscreatecon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception setfscreatecon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getkeycreatecon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getkeycreatecon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception setkeycreatecon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception setkeycreatecon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getsockcreatecon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getsockcreatecon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception setsockcreatecon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception setsockcreatecon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getfilecon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getfilecon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception lgetfilecon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception lgetfilecon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception fgetfilecon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception fgetfilecon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception setfilecon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception setfilecon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception lsetfilecon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception lsetfilecon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception fsetfilecon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception fsetfilecon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getpeercon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getpeercon_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_compute_av {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_compute_av_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_compute_av_flags {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_compute_av_flags_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_compute_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_compute_create_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_compute_create_name {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_compute_create_name_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_compute_relabel {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_compute_relabel_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_compute_member {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_compute_member_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_compute_user {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_compute_user_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_validatetrans {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_validatetrans_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_load_policy {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_get_initial_context {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_get_initial_context_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_mkload_policy {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_init_load_policy {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_set_boolean_list {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_load_booleans {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_check_context {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_check_context_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_canonicalize_context {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_canonicalize_context_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_getenforce {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_setenforce {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_reject_unknown {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_deny_unknown {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_get_checkreqprot {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_disable {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_policyvers {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_get_boolean_names {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_get_boolean_pending {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_get_boolean_active {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_set_boolean {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_commit_booleans {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_set_mapping {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception security_av_string {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception matchpathcon_init {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception matchpathcon_init_prefix {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception realpath_not_final {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception matchpathcon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception matchpathcon_index {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception matchpathcon_filespec_add {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception matchmediacon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_getenforcemode {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_getpolicytype {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_set_policy_root {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_check_access {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_check_passwd_access {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception checkPasswdAccess {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_check_securetty_context {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinuxfs_exists {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception setexecfilecon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception rpm_execcon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception is_context_customizable {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_trans_to_raw_context {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_raw_to_trans_context {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_raw_context_to_color {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getseuserbyname {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception getseuser {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_file_context_verify {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_lsetfilecon_default {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception avc_sid_to_context {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception avc_sid_to_context_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception avc_context_to_sid {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception avc_context_to_sid_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception sidget {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception sidput {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception avc_get_initial_sid {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception avc_init {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception avc_open {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception avc_reset {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception avc_has_perm_noaudit {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception avc_has_perm {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception avc_compute_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception avc_compute_member {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception avc_add_callback {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception avc_netlink_open {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception avc_netlink_acquire_fd {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception avc_netlink_check_nb {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_status_open {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_status_updated {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_status_getenforce {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_status_policyload {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_status_deny_unknown {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception context_type_set {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception context_range_set {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception context_role_set {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception context_user_set {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception get_ordered_context_list {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception get_ordered_context_list_with_level {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception get_default_context {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception get_default_context_with_level {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception get_default_context_with_role {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception get_default_context_with_rolelevel {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception query_user_context {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception manual_user_enter_context {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception get_default_type {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selabel_lookup {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selabel_lookup_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selabel_lookup_best_match {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selabel_lookup_best_match_raw {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selabel_digest {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_restorecon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_restorecon_parallel {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_restorecon_set_alt_rootpath {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception selinux_restorecon_xattr {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> diff --git a/libsemanage/src/semanageswig_python_exception.i b/libsemanag=
e/src/semanageswig_python_exception.i
> deleted file mode 100644
> index 0df8bbc3..00000000
> --- a/libsemanage/src/semanageswig_python_exception.i
> +++ /dev/null
> @@ -1,2128 +0,0 @@
> -
> -%exception semanage_reload_policy {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_get_hll_compiler_path {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_get_disable_dontaudit {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_set_default_priority {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_is_managed {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_connect {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_disconnect {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_begin_transaction {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_commit {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_access_check {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_is_connected {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_mls_enabled {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_set_root {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_get_preserve_tunables {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_get_ignore_module_cache {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception select {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception pselect {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_install {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_install_file {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_remove {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_extract {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_list {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_info_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_info_destroy {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_info_get_priority {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_info_get_name {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_info_get_lang_ext {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_info_get_enabled {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_info_set_priority {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_info_set_name {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_info_set_lang_ext {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_info_set_enabled {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_key_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_key_destroy {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_key_get_name {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_key_get_priority {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_key_set_name {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_key_set_priority {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_set_enabled {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_get_module_info {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_list_all {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_install_info {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_remove_key {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_get_enabled {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_module_compute_checksum {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_msg_get_level {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_key_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_key_extract {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_compare {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_compare2 {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_set_name {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_get_value {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_clone {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_key_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_key_extract {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_compare {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_compare2 {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_set_name {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_set_prefix {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_set_mlslevel {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_set_mlsrange {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_get_num_roles {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_add_role {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_has_role {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_get_roles {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_set_roles {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_clone {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_key_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_key_extract {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_compare {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_compare2 {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_set_name {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_set_sename {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_set_mlsrange {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_clone {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_context_set_user {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_context_set_role {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_context_set_type {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_context_set_mls {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_context_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_context_clone {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_context_from_string {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_context_to_string {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_compare {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_compare2 {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_key_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_key_extract {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_set_name {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_set_ifcon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_set_msgcon {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_clone {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_compare {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_compare2 {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_key_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_key_extract {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_get_proto {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_get_low {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_get_high {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_set_con {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_clone {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_compare {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_compare2 {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_key_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_key_extract {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_get_subnet_prefix {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_set_subnet_prefix {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_get_low {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_get_high {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_set_con {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_clone {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_compare {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_compare2 {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_key_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_key_extract {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_get_ibdev_name {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_set_ibdev_name {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_get_port {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_set_con {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_clone {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_compare {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_compare2 {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_key_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_key_extract {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_get_addr {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_get_addr_bytes {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_set_addr {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_set_addr_bytes {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_get_mask {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_get_mask_bytes {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_set_mask {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_set_mask_bytes {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_get_proto {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_set_con {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_clone {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_modify_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_del_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_query_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_exists_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_count_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_iterate_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_list_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_query {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_exists {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_count {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_iterate {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_list {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_set_active {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_query_active {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_exists_active {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_count_active {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_iterate_active {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_bool_list_active {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_modify_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_del_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_query_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_exists_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_count_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_iterate_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_list_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_query {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_exists {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_count {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_iterate {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_user_list {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_compare {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_compare2 {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_key_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_key_extract {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_set_expr {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_get_type {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_set_con {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_create {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_clone {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_modify_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_del_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_query_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_exists_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_count_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_iterate_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_list_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_query {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_exists {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_count {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_iterate {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_list {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_fcontext_list_homedirs {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_modify_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_del_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_query_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_exists_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_count_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_iterate_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_list_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_query {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_exists {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_count {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_iterate {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_seuser_list {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_modify_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_del_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_query_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_exists_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_count_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_iterate_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_list_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_query {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_exists {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_count {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_iterate {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_port_list {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_modify_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_del_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_query_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_exists_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_count_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_iterate_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_list_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_modify_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_del_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_query_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_exists_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_count_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_iterate_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_list_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_query {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_exists {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_count {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_iterate {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibendport_list {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_query {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_exists {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_count {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_iterate {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_ibpkey_list {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_modify_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_del_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_query_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_exists_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_count_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_iterate_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_list_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_query {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_exists {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_count {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_iterate {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_iface_list {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_modify_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_del_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_query_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_exists_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_count_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_iterate_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_list_local {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_query {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_exists {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_count {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_iterate {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> -
> -%exception semanage_node_list {
> -  $action
> -  if (result < 0) {
> -     PyErr_SetFromErrno(PyExc_OSError);
> -     SWIG_fail;
> -  }
> -}
> diff --git a/libsepol/include/sepol/kernel_to_cil.h b/libsepol/include/se=
pol/kernel_to_cil.h
> index 60346ad1..1db0383a 100644
> --- a/libsepol/include/sepol/kernel_to_cil.h
> +++ b/libsepol/include/sepol/kernel_to_cil.h
> @@ -2,4 +2,5 @@
>
>  #include <sepol/policydb/policydb.h>
>
> -int sepol_kernel_policydb_to_cil(FILE *fp, struct policydb *pdb);
> +int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb);
> +int sepol_kernel_policydb_decls_to_cil(FILE *out, struct policydb *pdb);
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 49040ae4..db63ac3f 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -3262,6 +3262,11 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct=
 policydb *pdb)
>         struct strs *non_mls_validatetrans =3D NULL;
>         int rc =3D 0;
>
> +       rc =3D check_for_supported_policy(pdb);
> +       if (rc !=3D 0) {
> +               return rc;
> +       }
> +
>         rc =3D strs_init(&mls_constraints, 32);
>         if (rc !=3D 0) {
>                 goto exit;
> @@ -3282,30 +3287,6 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct=
 policydb *pdb)
>                 goto exit;
>         }
>
> -       if (pdb =3D=3D NULL) {
> -               ERR(NULL, "No policy");
> -               rc =3D -1;
> -               goto exit;
> -       }
> -
> -       if (pdb->policy_type !=3D SEPOL_POLICY_KERN) {
> -               ERR(NULL, "Policy is not a kernel policy");
> -               rc =3D -1;
> -               goto exit;
> -       }
> -
> -       if (pdb->policyvers >=3D POLICYDB_VERSION_AVTAB && pdb->policyver=
s <=3D POLICYDB_VERSION_PERMISSIVE) {
> -               /*
> -                * For policy versions between 20 and 23, attributes exis=
t in the policy,
> -                * but only in the type_attr_map. This means that there a=
re gaps in both
> -                * the type_val_to_struct and p_type_val_to_name arrays a=
nd policy rules
> -                * can refer to those gaps.
> -                */
> -               ERR(NULL, "Writing policy versions between 20 and 23 as C=
IL is not supported");
> -               rc =3D -1;
> -               goto exit;
> -       }
> -
>         rc =3D constraint_rules_to_strs(pdb, mls_constraints, non_mls_con=
straints);
>         if (rc !=3D 0) {
>                 goto exit;
> @@ -3533,3 +3514,71 @@ exit:
>
>         return rc;
>  }
> +
> +int sepol_kernel_policydb_decls_to_cil(FILE *out, struct policydb *pdb)
> +{
> +       int rc =3D 0;
> +
> +       rc =3D check_for_supported_policy(pdb);
> +       if (rc !=3D 0) {
> +               return rc;
> +       }
> +
> +       rc =3D write_sid_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_class_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_mls_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_boolean_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_type_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_type_alias_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_type_attributes_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_type_attribute_sets_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_role_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_role_attributes_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_user_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +exit:
> +       return rc;
> +}
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index 99e46865..b267b5d7 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -751,3 +751,29 @@ exit:
>
>         return rc;
>  }
> +
> +int check_for_supported_policy(struct policydb *pdb)
> +{
> +       if (pdb =3D=3D NULL) {
> +               ERR(NULL, "No policy");
> +               return -1;
> +       }
> +
> +       if (pdb->policy_type !=3D SEPOL_POLICY_KERN) {
> +               ERR(NULL, "Policy is not a kernel policy");
> +               return -1;
> +       }
> +
> +       if (pdb->policyvers >=3D POLICYDB_VERSION_AVTAB && pdb->policyver=
s <=3D POLICYDB_VERSION_PERMISSIVE) {
> +               /*
> +                * For policy versions between 20 and 23, attributes exis=
t in the policy,
> +                * but only in the type_attr_map. This means that there a=
re gaps in both
> +                * the type_val_to_struct and p_type_val_to_name arrays a=
nd policy rules
> +                * can refer to those gaps.
> +                */
> +               ERR(NULL, "Writing out CIL or policy.conf from policy ver=
sions between 20 and 23 is not supported");
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_com=
mon.h
> index d3283658..53f398b7 100644
> --- a/libsepol/src/kernel_to_common.h
> +++ b/libsepol/src/kernel_to_common.h
> @@ -117,3 +117,5 @@ int strs_stack_empty(const struct strs *stack);
>
>  struct strs *isids_to_strs(const char *const *sid_to_str, unsigned num_s=
ids, struct ocontext *isids);
>  int sort_ocontexts(struct policydb *pdb);
> +
> +int check_for_supported_policy(struct policydb *pdb);
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index a8126d58..628a792e 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -3116,6 +3116,11 @@ int sepol_kernel_policydb_to_conf(FILE *out, struc=
t policydb *pdb)
>         struct strs *non_mls_validatetrans =3D NULL;
>         int rc =3D 0;
>
> +       rc =3D check_for_supported_policy(pdb);
> +       if (rc !=3D 0) {
> +               return rc;
> +       }
> +
>         rc =3D strs_init(&mls_constraints, 32);
>         if (rc !=3D 0) {
>                 goto exit;
> @@ -3136,30 +3141,6 @@ int sepol_kernel_policydb_to_conf(FILE *out, struc=
t policydb *pdb)
>                 goto exit;
>         }
>
> -       if (pdb =3D=3D NULL) {
> -               ERR(NULL, "No policy");
> -               rc =3D -1;
> -               goto exit;
> -       }
> -
> -       if (pdb->policy_type !=3D SEPOL_POLICY_KERN) {
> -               ERR(NULL, "Policy is not a kernel policy");
> -               rc =3D -1;
> -               goto exit;
> -       }
> -
> -       if (pdb->policyvers >=3D POLICYDB_VERSION_AVTAB && pdb->policyver=
s <=3D POLICYDB_VERSION_PERMISSIVE) {
> -               /*
> -                * For policy versions between 20 and 23, attributes exis=
t in the policy,
> -                * but only in the type_attr_map. This means that there a=
re gaps in both
> -                * the type_val_to_struct and p_type_val_to_name arrays a=
nd policy rules
> -                * can refer to those gaps.
> -                */
> -               ERR(NULL, "Writing policy versions between 20 and 23 as a=
 policy.conf is not supported");
> -               rc =3D -1;
> -               goto exit;
> -       }
> -
>         rc =3D constraint_rules_to_strs(pdb, mls_constraints, non_mls_con=
straints);
>         if (rc !=3D 0) {
>                 goto exit;
> diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
> index 2b103993..8785cff1 100644
> --- a/libsepol/src/libsepol.map.in
> +++ b/libsepol/src/libsepol.map.in
> @@ -297,5 +297,6 @@ LIBSEPOL_3.6 {
>
>  LIBSEPOL_3.11 {
>    global:
> +       sepol_kernel_policydb_decls_to_cil;
>         cil_check_neverallows_against_pdb;
>  } LIBSEPOL_3.6;
> --
> 2.54.0
>
