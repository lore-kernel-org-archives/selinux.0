Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011ED31B80E
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698916; cv=pass; b=p6gzn2SUpLwtMTF+ti2YYeqMYiT39EWJQxrTay+aPK8LzMoS2jfypa21ObUeAl4OJXbLQjPqXRQOFbLMd8vigjw+bm3zX3odPrejLMnOfcHWGMnnRZkoBP5t9DhPmcA5DN0gnp23SQQ3USB0ppwa0s/BgNkpZEwBpksTJ/dKc3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698916; c=relaxed/simple;
	bh=LGYCvCCx9jkSS5QBfGo7lOpZUt49rk00aE0usyjYIE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljPj1A3yLz4ubUo6c4Pz5fQRv1IcSscuG5/AUFnTBJu4FWBa+kHepxWR5nqpM2z5cvORjKQhxDXKpjSuzUKXxsrPPBaB+SzWl1VIcetxFZsOtz34cBEToxJMgqaylUCrtx8B5U6WcwAwAdzmiAkJp+c4qSW3D0ZwU1mn+o8Y6JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9pKQA7r; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9pKQA7r"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8a45b788a71so36795177b3.0
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:21:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790698914; cv=none;
        d=google.com; s=arc-20260327;
        b=rRyTlbUxKKWYZoafmhfUfU0Xd8g9w8kNBfHIuwtRo9/jrwaHMdJbk+V9SDV/oGBgQC
         I0/O2opyig3lFpdzAg97wKN7MBw14dNXDCk5FCUJALzniPqw/09hDGuh9LMb+yJ2oWDw
         R6CDZV8BOWzVco6oWQcRicGqZMSV/O1CScyWlzZVf/VuJZezuBbrfnNq4NY0ftS6nirw
         Jf70BUDTlesB2CH5Dl4Okcr8qZsjXg8C1dHLcrIkDCnILEGxrXoHkafy39d1Xb1JzHLP
         O5KnCc9fy+/oCVu0uY9kphwzDIqXt2xVTR8XL/cZtsqrPFZVfGkQ13hkDSM7zD8RSJrT
         pK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fjr5nJcNBgq2HWpgJ6n2rBAx9O96kqJmVmHXl1ynnog=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=BlIhBCvUaMJaRoClLT7Y/ZliSB0HGDFNbRziZzy7gBbUstDglRbgrY+Q6Wp/wqJpZ0
         8m2DN+te7qcnDcfWWCNxw6xLlqvwt8E1BdUQpn4fPZyqkd759IuybzhbP86wQMeUsZiC
         FXkStTUKL/89c4uq9daygxviQd697EXVMNbnmwOgC0Kp4wanPgU43cFFow4czpGibEiB
         Yl+LaeEyjVNCsSyrGxihaJsusiUadXLcP0caqaKKeJeyS5a7jzO07GYmVtTUc/1WKFXb
         9z/75M4t60urpfSBoRiU0XZ+S/TYmpL/f7fSX6V5KeAoR2rAVp8qHYZBDuajPD32u2aG
         1gQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790698914; x=1791303714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fjr5nJcNBgq2HWpgJ6n2rBAx9O96kqJmVmHXl1ynnog=;
        b=W9pKQA7rlLoezd+7pRKAtP/ALy3L3mb/Wjmt+6LOPP/XYXwrFWGAQA4bOy8kGcXrMA
         vkY8wOBc3QR4vF6LLDrz9QPQeGQgPu3RAFVUeFayc92ni5GtLQz/ibD1r1CKnXyYP399
         lnnDGbCQ8xpiDQdISaSfV1uMaJZNkIAdU7i8E7juNLhd/iCdce/ProuKMWp9CdQlVRLm
         Pm7lRoltDLw8Pb5tb+KUMZznbaBQcuWopYnfbW7RfMBFkTbTTmjTc5rLHIfXQbWYIsy0
         4UxJ2TEXjdmf8l6bVm83H8Huc22F7JZf24lqhJD3+L/Olk9g3NgyiidrJInMi97iCoA8
         o3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790698914; x=1791303714;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fjr5nJcNBgq2HWpgJ6n2rBAx9O96kqJmVmHXl1ynnog=;
        b=KhzoHvvTwYnU6LvYenhbJqIru/hWWeQT0glH94s5dxBkZITVuyWyxYAS69Bm3F6+tL
         oEn2VBe6hMZGZ3JOOV7pyAmBEXKhqkTeDN7kyByA/LgKptIqL1PQYMdPprSYYuWhlmza
         IpGfejDPCtqIkI97FiHru0AHw7OPXNJDlFec+CXlYmv/gkUBYg9q0UhTA7w1+jHubl4v
         HeJd7I0Jqw46ev8XeGPGEeJ81zHVYrPiAlID+iUnvOtBP8agbvwou2bJM+X68i/TUrC0
         UHBMnoHwUhCUC0RyQY60QoPRI0++QaWn2DQczPiq8sndc85xahXeqhF/jUyiYtsI/A2u
         sopg==
X-Gm-Message-State: AFq9FYJyGeT5oCV1W+JJ018i+EFG1zkoDJW/BQ+KVvGi6v6vYqsdBySc
	vW0Uv7CJDEBROSYq9hMcJwHUE08W6poikCORD/UOYsr7OCqgO55znKBzz6PnREygKdFbviEphLO
	RlVrsotIbkyXJDqGtIUxjCD+MsCuybS0=
X-Gm-Gg: AYBFou0tvb8KJnaDpFfS64lKcKqhHw9OGdLpQwarhQTxyWZ66kY9SiGamm78EoAmLZo
	P2Csqo3PX8I7tyiBTUFoqVSmJwkVp1SykDT52OeUuj//cLckuQAf5JzsCfYpxcBN2QeJSavBv4O
	MAM5Gdv20du8LAAYlj37QXLALlpo5NdVP2HDDXQdeE/DgiDonX5vF+KgwLCZ6TyFTBz+kGi9Guz
	mZaZ9AV3yTd+5FSfFTGY0Y7idVeT83OquyumrINxyoUo5lGzP1koCbpFzHV51TCs22Lg8BjKo3x
	ueMh8HM2zs/TKwWDIfd1jLuXxZ+ce6Z5KJHIHrQyH0l0IjLn4QOdMts=
X-Received: by 2002:a05:690c:d8a:b0:8a8:889d:2f1 with SMTP id
 00721157ae682-8a8889d0887mr53646257b3.34.1790698913884; Tue, 29 Sep 2026
 09:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-3-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:21:43 -0400
X-Gm-Features: AclHuK-MFOxeSlLBRkcpFC2rMeAArJpF9bjBugOFsvU8EsdfK-zdbJUEsCUO_sI
Message-ID: <CAEjxPJ4z4HzEE8AADJrZUoZeivY+B0jwJEB7RYfOjsLu1-J5ew@mail.gmail.com>
Subject: Re: [PATCH v2 04/21] tests: skip module_load tests without a kernel
 build directory
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:58=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The module_load tests build kernel modules against
> /lib/modules/$(uname -r)/build.  If the headers for the running kernel
> are not installed, e.g. when testing a custom kernel, the build fails
> and aborts the whole testsuite.
>
> Skip the tests with a warning in that case, like other tests are skipped
> if their requirements are not met.  Check for the Makefile within the
> build directory, since distributions may ship the build symlink with the
> kernel image and only install its target with the kernel headers.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
