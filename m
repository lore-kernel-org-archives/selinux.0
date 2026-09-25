Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2824C3E9F8E
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363174; cv=pass; b=gcMevtxePSSkUR2WFtMeAcgFuyGuLQZinCxpPyiEJWhoWh0GHywVm7+xEFgkuHtRAicmKfkx8pb5McAr/5xOGEEPN7ngYRRiZ6897gvQxTlXjwdOxyBiq2NnKb3uWFI98SiudX8ih6VM+FmjZCDyLFRJSseQhGT1Wl1XFW6ppIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363174; c=relaxed/simple;
	bh=n437FY6O3RXknifzt2b9GVYh+K7XCFXJfAE1r82eRmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpjJSqTWOzD8y7i1qroCFY42m+E8JQD4YsFQ9sELvIf/k3viYzsNuXL0O3TbnSDZ+qnalODzXXHC5HZ3Gec9A6wq7xRu8Cn72c3GN4GWEJSPor0vAa7JAGI8LBdKL5o+e4i+cDQtJqr9nhGKXJDfckwxeeUKKkGUFbu3q/HgUjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=orLbOtNc; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orLbOtNc"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-895fd505832so11492727b3.3
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790363172; cv=none;
        d=google.com; s=arc-20260327;
        b=VeW+6h+ZtbQrd45uxOdEx1GyrE+LaubGYKYXdkmfG/PSFZZcrI/kVdtEKfwwiXkR6w
         b28g5bsssaCT1S9CvihPp4Qk8h2OXk6Yhs2J0xqFrpzClfWiHuxe9ZI/eb5XMh4qLq9G
         l4+xODuwR86lRoFp9CM5YrXRzBJjVJ0APfFE0KzqTe1sND2ggioWJ9MrOnog6mQrTMjr
         TdBz4FPXLndiY0J4+jTwHLytS+MFHDDHihU/Yy9TcZIZ/sp7FursA3v22n0OY4V9JwF2
         cJULac7WeyQbZXWDBqTn+WIKio8dHnqCyu5l1sNylUDJyRbKxlwujrMgI4NP33TB8JBk
         bEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n437FY6O3RXknifzt2b9GVYh+K7XCFXJfAE1r82eRmQ=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=mxlQ4RYt9hVfyKhCBi06rEtojZh5Qhlo775h2kmEeJD+wNoJyCshLOgMRKuI51tKhT
         lw+E2tPWC1P1EU2QavD/VggOl9JfudRhMrl15HSAIxFyCKxIhf0/+Y2cl06gbdPeMhRI
         xB0Zto8Kg8LhkRwJVs8sr0OxtdX1bKC6eOeP32V/iW/0r0ayy7Ltakd9nk+eQlckJCYp
         cejLZmr8iePZV+Obgp1vj0luLoC+3IlPQrtC6Z5NDjVYLJnF4r72kjLWRWmNRBIy7wnM
         lFW2Lz9K3FeCa/lGLsY8bM99TwdygmT6K3rl0cbGj3MwtJwAAHRgiiFDNEJR0kv3kkfl
         K4Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790363172; x=1790967972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n437FY6O3RXknifzt2b9GVYh+K7XCFXJfAE1r82eRmQ=;
        b=orLbOtNcDZ27ie8YLX2qSb33BUEwHXwboovQIyA5YHHWA3b55VtAxZOv+q+hOLx7DW
         zuG9EE2Y4Oy8OEOMYnjUHcBo6LL5r1WlnWSVJDH39FKpFO2x+jvA89OdcFRr5KtrXcBn
         Zy8F3mOdWMfMeQ4oJkLUz0HxIZbP8MXYUyLfJulKx7OXgAcOu2MrZ0Z99XWxO1+P/yDM
         TdhqTTDnHBru2Zo/m19glxbaAarQLHYfkN14hdKfL8MgNct/W0/u5aWa3ZcwGwNt49qW
         nstdC5O8tm9jlpgmSFJSUWXuGWkUpUElSGFvY6rqAoIqbl5Iu4Z5M3dDjkm6ijsTqBQn
         YYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790363172; x=1790967972;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n437FY6O3RXknifzt2b9GVYh+K7XCFXJfAE1r82eRmQ=;
        b=AGCPeac4RWD1Ewo6Xc0vCuQVfZ5DS8XJbYEMrit0ZWkWI5LDj08nUjb86KFvkh2Oh0
         7jIPfBJLP1LVXs3DdwJDTXc9vTowHUan9Ah2JQxV+E1vLTehjVdADnVLfAnRrxwiJ41D
         OiywpvmUByHl9Jew72mF7rgHuBJ2T0/VhLUqeiG1U3zSCyoQpvV2P7HeTjdWz/4u8i+e
         mHSsUvFVevJV8156H1LIcbLmIdCSpZu6a5EKH6WAvrJke3s3JYHYi9Ol67ECVHbeB98d
         Z40wsREUvmgSBDqU9fRjBitfEc1oDSW1ceE/eFn3es5x6bX3Jge2SifCTZsduuQClU+U
         68nQ==
X-Gm-Message-State: AFuF++m5RAMjoqRj3gzibDRPUJYtE261cRCyj6X6LSCC7pFvRFlMRNht
	9lBrFSHw0G766kVX2gEVTgbuZoP9g/HEJMBQuhpPWF/xTSleoMN/9n4GdjuFQmWpLmBMZylT0L8
	NCeszVDwySvMsV+V2eq/5sMo15USbQ+Q=
X-Gm-Gg: AYBFou0ik551tb2AFZsA3eaWgBmhchQymplbu3cOTa8QjfrjNGEFvFmlWQ+L6NHPawL
	kntp+UtwH2Gu66x3Gm1lyKoMLq0U9MPgDG4dlraEHoMdH7nJ7OMF42QFddFCWPsKpgM73nffOqq
	LiaCbqumNtBJAgBFHk6ezJexFe2JSRdltSBooTccGLlBWNof8KvEOxAk2g5ZK1cclWShL+SgRYW
	URhTifssrQaAXWDKXL43TkllxdNW+qhAVH8R70DSqunqEGm3U4ES2u5qaPCdOEa/KvM/zMdc4cq
	sroDu7Zx7Y+v1D+R0YITJJTbT8o2U8pQxn2xXOEQqlcYTTnDhqPb38e20OG6ySNmJ4Q=
X-Received: by 2002:a05:690c:6e86:b0:8a8:1fa7:fac3 with SMTP id
 00721157ae682-8a81fa7fb9bmr23965567b3.69.1790363172002; Fri, 25 Sep 2026
 12:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-8-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-8-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 15:06:01 -0400
X-Gm-Features: AclHuK8p75oSPh-ni6q32okqssjqyjNvQ3750c_0bwzFfTh251-IC8eaBWUM8JU
Message-ID: <CAEjxPJ4OvDoQB6gRJw9kJfpCfaT6AzbOz6OYCvdJGKQa7eyqJA@mail.gmail.com>
Subject: Re: [PATCH 09/21] tools: quote command to prevent word splitting
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Reported by shellcheck(1).
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
