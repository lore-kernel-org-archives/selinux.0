Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9219CCFA
	for <selinux@vger.kernel.org>; Fri, 17 Jan 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737131455; cv=none; b=oPju3PB71maoKw3p5X9pmrU+2kGNIpdydRZA0Qu6KiNjS/Fz+xUFGcpURg8/Hnq1XdhbgH2qKyoV9V4KN/XIjF015DDSEXIYJwojN/mw1ZjKgTsL5LKl8hs21rxA2UwBvH4bQrP7klZR7PqwTLclp1OmjAbkSmfxGYeVeHIQjwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737131455; c=relaxed/simple;
	bh=pbg8o5dz8njHgKg1NDQXRfGlM7MhqH+igmKnw4ydDHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOfWp6SiW5HV7BNuTP6HnC35vYt6UcNIv5M1MKFFY1Om/17nLWduavmwOSW1xkWlxOsUPQksnBbipKHCaME2Q/TZZla2ijwvhNpH880YHJFPXbt4rOmzAcKwncVb6/rNyCu59F+JRTzYZlbCFXR2zzyqOtx16rRbsS2V2+D2aqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dZH88KyI; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dZH88KyI"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e479e529ebcso3338388276.3
        for <selinux@vger.kernel.org>; Fri, 17 Jan 2025 08:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1737131452; x=1737736252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+X5++CJ0KNwoc8gGmPhsCoxz0UPerYMZjw+oDnzx48=;
        b=dZH88KyITmHWNjCuoOpI+++KNulowPOBbxriNYS8yQa0VmfvmxpI6Bk1MaegXGJyCq
         9WChzqObNmME8LFX9oea+V5ZnKuzoQnOBc2zMkmAcwURSZLB9yi+oDZUiOsnT07kfE95
         2tXV49gIO4cE7OVFvsIhjcSLUlR+AR2CNXRLLCPN4nFzvgNN4K0g7TAkmGJq8bVh/f4r
         vik+EImQkB8/Mg5UVcQKgwJ7Y/G6MbySzAFaxPZyBmlPdKLSfv9E88KKx+F16Ffqlq3Q
         fS6RUoyNHX7XnkCGoI47uzVmO8fhalXHAz4/ASaAKhLISNzc0Pr2YdHrB/v5hbjcOXnc
         G79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737131452; x=1737736252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+X5++CJ0KNwoc8gGmPhsCoxz0UPerYMZjw+oDnzx48=;
        b=XfagNlmO5gwTdQFhW8/3ldD1o4wHmMxKvnllWx+ze43hqtHfivFtlD0HKpDHZJlKhA
         IwQKxZ0qaWfnPIi4sV5jv/cUEePpOlVtylYEceduAkXLcB3chIOSddpKtosy1ds0ajW3
         eurp9iM6UHTSUVmECtcpFaMahpiP0w/GObx3d7cXSvafhjo3JV3/dFaXfyC7BkwcnHi8
         GlyrQCbmziN7jY0p9fDlJk1R5ItbW3GmkVbnbGurBLTvrn37ro7H/w5OQvUGwn3ynblN
         xo1n2ZiELeplq/yo9tOP8S/VEP6Pwf2x5sFivnyGfSknvaTyBrbWwxkUWg40uUdY6Nfg
         mYmg==
X-Forwarded-Encrypted: i=1; AJvYcCXR4p4TJeuG0zkj2sTfFg/dWcMvxA2WumkI4uUFB2S0Yx7FJ8ZlU7ybo/NlqSvgrrifX9PplWZ+@vger.kernel.org
X-Gm-Message-State: AOJu0YyJa/yR7Pr+/wUf6X4/yN2f9/fe5bMvXGaMzwbDJLl4oH+vyExD
	oy8zlQiHYaZHT42wbB7bmhnHGFd6tmwP4HkYSoq/V2q92uzbleZYaMvkyWyyKGZpi2ihy0hjgTd
	Dc5r0X60q6ZjR3/v2RjS7XxIVJjd/ZYjdzV7zlFAvow2c5G4=
X-Gm-Gg: ASbGncvsxZyJcu198Bqp4YKUTfuA2mK979SWnwkLOkQs6ikgsC1AIM/SPyU4ehxfAae
	zC49Ap1Cl6+mjJ7bMTFDZMUIiNlnm+bkhnRbw
X-Google-Smtp-Source: AGHT+IFkcIbSanU0awGz+g8PDvOcCR4f5DfDkcwb62fkJKTCQoTz3ErGkqkSlHrseL0Jsri6uzmQLKq+74Cm3j6IR/k=
X-Received: by 2002:a05:6902:1a4a:b0:e4a:3170:1e90 with SMTP id
 3f1490d57ef6-e57b1060abdmr2613329276.12.1737131452445; Fri, 17 Jan 2025
 08:30:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108082855.PkG-_BaT@linutronix.de> <CA+zpnLc1PhF7zfWVCj3qezfvYYHbaOc-FyscWS9y74bXZw3rxQ@mail.gmail.com>
 <20250108104525.PJL0eRAG@linutronix.de> <d218ca3e-20af-47f5-b3b3-3a372c15a1aa@quicinc.com>
In-Reply-To: <d218ca3e-20af-47f5-b3b3-3a372c15a1aa@quicinc.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 17 Jan 2025 11:30:41 -0500
X-Gm-Features: AbW1kvYbcT7vva24VEusxajdJl_cPqcMxOHG9yj-PvcL5CPee3yPO304an5Hi30
Message-ID: <CAHC9VhRkVLeJVgU7kPhUnHp0r7rWRRYhs9NuLnsPs3cANrqHJg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IHNlbGludXg6IGVycm9yOiDigJhORVRMSU5LX1JPVVRFX1NPQ0tFVF9fTkxNU0c=?=
	=?UTF-8?B?4oCZIHVuZGVjbGFyZWQ=?=
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@vger.kernel.org, =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 11:01=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicin=
c.com> wrote:
>
> Is someone going to followup on the comments in selinux/Makefile
> about replacing the dependency rules?

As stated in the Makefile comments that you referenced, the suggested
fixes for the selinux Makefile require make v4.3 or greater and
unfortunately the kernel still supports make versions going back to
make v4.0.  Once that changes we can look at implementing the
suggestions in the selinux Makefile.

In the meantime, if someone wants to propose changes to the Makefile,
patches are welcome on the selinux mailing list.

--=20
paul-moore.com
