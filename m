Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D8422D4FE
	for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686146; cv=none; b=aCWXoA5GAOcBo+nsu08ms5QxmfiMZJQTnHFEn/yppJETdpEFS7hEp2zxgMsTE6pabjWlMcfmzwDMzA4qCpWr8M0EkXoZAL8exf0fprPqau/xRXW4yc85wuscwTFtU5+HiseKA9Oab5ZC92GRxthoaqxqdbLVJ2LdP3GdUo1qNOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686146; c=relaxed/simple;
	bh=YUrFd/a0U24o4B1pjkQIsPhrjXGWo7FH1O1yP9TGM4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3bFC82zcjPPCPhCoArPmn6zDFA/LlMYdrCXSXqWN0JrILyhKAL2uG9BAtGCXAJk/N60ec7dIPZ378sw404sfvlKIRwFXfZ5DokLaOjz0oELA+7NVp1Er1NSgse0QpHvV9qQF1G78p1VfemJepMMSxWdY+DxgGBIAU8Ji44Fgfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ea52B0Dv; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ea52B0Dv"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54993c68ba0so4072787e87.2
        for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 02:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741686142; x=1742290942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uhivK1A5/8xYDXp8Ib56ZkFS7qJ8onBG0QJ+l4PZnn8=;
        b=ea52B0DvZWvL4RuQ43e7wMKwSNmMgiqcfqNpwufNQGqdc5TOSlKpC6wLmfZU2Ek683
         EKr1en/WOf752qOF6OAxcExS/FU12dkOnmTxOj9M2u/iMa5q9nDQfsQRxamS+aqlZIF4
         SXLpSrs1+kj/Ss+Uij72wk29ezB2i5rQP5Sbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741686142; x=1742290942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhivK1A5/8xYDXp8Ib56ZkFS7qJ8onBG0QJ+l4PZnn8=;
        b=rRxDtdFi34U/0iQEcaFl2oMz0K1yYEu/qtxBkzPe1jnAj2cZ+uG9eGkb03pdyqZlHH
         9j5qSzQFSjZ+1/vUD0iFanZuyvbVZc7M6wz+9b7732PtgcZIVw5JumgAihTng8SZ8e/g
         MFxroczEgqMxrM/DyKJQaoAXDnkuv04vNEj6IK+L397CEU4qOz5vlcYpimySg9x0lDuy
         3B6Lh3sNBqCA6D9MG39Tp3PqEUeY0y5/EHpHUxO4GoMjMjzlAI6LLgdpiFlCH5BTuYJA
         usauONYd/Sp0pVNFmrSFCkinyidhZ/JEMZIUA6v0UgybgPIRikM829ivC4DNqmgJ6uPx
         s4gg==
X-Forwarded-Encrypted: i=1; AJvYcCXsMtlCA8IHYl7v1z9P9q0OLvZlYcX7KJEuVclkIKLfWPysMdpMZNTcb2erDtC8vm/pyJmsn95d@vger.kernel.org
X-Gm-Message-State: AOJu0YzCkPCoQ4DoTXD7UyeRgwnaIlusmAqBICb2VA1ZJWwZa41d7HX6
	+86qpeYIQNhST7dgGSvyOgALOxNdG/15dQiXgJSMoGHKQvsh9e97q2Nolga6ayRXBGxpctDdxQQ
	OJguAAnNOMPrXn0/Ctpj3aF5QHSs9BuziW2I=
X-Gm-Gg: ASbGncsD5s6SSe0C5ImgB3kYJBKTnKJv8Dk8LX4rDO6Us+3tJXKebzcL+feu+T7hwcs
	fFt2PFqDaOmy5OejFxuIhKNodFq/8nC6XIJNBA7kJc2vKDEEkYcDPR7AVp3dGJrBmGVtKDyGepu
	N4b4URVwzgVqcWj9T00elJ6+UtssCplk7yXq1n/PLZLWbsWGqHQZWGlw==
X-Google-Smtp-Source: AGHT+IG9bFq6vmR+YIGaTUNLkIuXm8H8fh/JHR4/xt8/PJTevv76QQrwy5GOFjvmZvy/OGsYveU2X7zbq7bSbWi6GVo=
X-Received: by 2002:a05:6512:12c5:b0:545:1049:eb44 with SMTP id
 2adb3069b0e04-549abae97ebmr927683e87.36.1741686142277; Tue, 11 Mar 2025
 02:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311092920.1114210-1-takayas@chromium.org>
In-Reply-To: <20250311092920.1114210-1-takayas@chromium.org>
From: Takaya Saeki <takayas@chromium.org>
Date: Tue, 11 Mar 2025 18:42:10 +0900
X-Gm-Features: AQ5f1JrDPDFPgmd6U3IJMfmmFg1ww5OAngAnR3K4E5_azsWE3WZgITCkOddnV8c
Message-ID: <CAH9xa6dtem=xKPZhF6s+ttiOsQRyz63Je=Qv1m8edxCV1hE7Lg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: support wildcard match in genfscon
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, now this patch no longer appends "*" in the kernel space.
I tested this patch on Debian by creating a modified SELinux policy
where all genfs rules were followed by a trailing '*" and the new
genfs_seclabel_wildcard cap were enabled. Both the new policy with the
capability enabled and Debian's default policy without that policy
capability made correct labels.

>  +       bool wildcard = 0;
I overlooked that this should be `= true`. I can fix it.
