Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7461FFC59
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851458; cv=none; b=PJYFU/YWZc7e/G85w7R98eFu39cQgV8VuzFphOa7OkyPC996ca5RXMqmFbsVr7L3AIUJ+NL936gEluEG2uhga0KIheEpha0oGAczASwvR95Ix75Smc2t4OnHjOD3eK9iHZfQ4hHuW8HBwG1DUnsHrf9x2L+uzgR65SV3joK+vsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851458; c=relaxed/simple;
	bh=Y5TbdYomtVHceJUSTAv/mvY239W6f83G5T4xsQ+KqnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpBjWU7jeVLU8++QBmWMltpRaKCGN1Yj+trd46gR4Iip+HQI+k2DSNDuiCKUaBfgwRdvdggawPSJQoaRvQSJ+EiLzMnI4LPqSG7yf5irTzDacYLjNLunGgSGsSMdgpvp5xGPbPnYy5IaiYblgmSjxhgvZeOfGl4EHXr2NRq5uv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kj2Cwpps; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kj2Cwpps"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33255011eafso6596796a91.1
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 08:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759851456; x=1760456256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5TbdYomtVHceJUSTAv/mvY239W6f83G5T4xsQ+KqnQ=;
        b=kj2Cwppsv94tL6aDohmI/WfFuRXYLERxyPv12SGAF56TIR85HT09FgR27TfWApEq98
         8fxLQMhoblhntNEvzqH81HJ7lOoD2okZ9/cY+lHQhjUuD3CIhdKP2g6J7ndIuTD84Nmm
         ruwiZhs4d+INwxAbdvUeJqz+omhgEfRBnGtSkavptIUIDweSDHK9Wf3iCudM0vQ986T9
         whbQZnY9uHMiQdE2Bipm2ZDGYrCCqg9dVWRJLn6+9f4vN9TA3stsK7m1yE81QIyjbR1s
         UiljGUWQRFKE6mFU+2q+brCSmynM/W8nfGstOWyLpClRNXKnFYNqqKj7uA1Yr9XaXUlV
         nnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759851456; x=1760456256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5TbdYomtVHceJUSTAv/mvY239W6f83G5T4xsQ+KqnQ=;
        b=H32G54Wif8wHaDAoPEitXkMU98T0tOX/hsXhBSGCgpUiIu0SJMZqiSmEDWfhP7sCGa
         JCricoaec8DgE9KNLFiu08Ftg0CmnOjE9zcRmrclEO9AQ8G6TWlFRoe+eGZJFu7vDo33
         WV7i3ASyxh0qLeQZxzH1kgwskJ75vSVQkWJWV0X4pjpkTppPKmerAyByuDbj4qT84IUT
         YPcN2L0xYkTASgdxXgy7apFxw8iO4Ih/8rzZBnfxnLRHo/iGIxItheIEY1A7UUEaK1JA
         ovjdyccmgpOVdjSUXDG0BpNnQgplWSDICVPogN+AXahumAIVBRfOlXs5TFdKYMT/Nq1k
         fAMA==
X-Gm-Message-State: AOJu0YzclomK8aKpF3dca+Jr5SBgBdPLAZfytsUGCeroEBDBRxqPdewM
	FRHDmEMBgygBuj5DPn7BVZTb0/4lR5zLnIOU5ZFK3fzn+ZTm2TWr/AaCjH68jsaGuw+Y0aY6u72
	H67d9TkSm7ijLmV3Q5ZSowAnEPW4QFdkETw==
X-Gm-Gg: ASbGncsrkqIYShI5daJwxuhCNLO6g/iYYxoUGxdXgiTtAGeR0u+8QuwBLtbkGETGlEW
	Ljjq9EPlubV93GUEnouhLj0ZvZQ6SjzOpQwoQAJy1zJjJYyDG/i947+OFFeFvaz90cO0XrVYQ9u
	JKJUQi28h6cWZtZCHhCGvqVZ9yiNfDYaydfc9/GYEsUsDAhdXBTGJlPxLlyhqbm91LZvzRjuf/c
	OjjJq20ngYeOFCMpaTEosEAZHaKBQA=
X-Google-Smtp-Source: AGHT+IEWj73A5Ei+6Hk85XeUA3o6GiOz4gOPnRWY2mMtUDEopf5IvJ0Wn4PmwqYp6/A9jxXiLfgnzDlhz32CW+6DXZw=
X-Received: by 2002:a17:90b:3b90:b0:32e:6fae:ba52 with SMTP id
 98e67ed59e1d1-339c2706786mr20517057a91.6.1759851456033; Tue, 07 Oct 2025
 08:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ60msaQXmD3kWOPoLb-=Fx1WK2TdGObpg+Vq40-yJEfTw@mail.gmail.com>
 <20250801174527.1203687-1-nvraxn@gmail.com> <CAEjxPJ46APV=OOBEqBLORJ3eHEC10P=eH1=SS3fK6BCGwpxu7g@mail.gmail.com>
In-Reply-To: <CAEjxPJ46APV=OOBEqBLORJ3eHEC10P=eH1=SS3fK6BCGwpxu7g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 11:37:25 -0400
X-Gm-Features: AS18NWCijo0Z9ETxc92mKorp9kmB0SyjVxMSH6jr_4DcpiUxaTMslVOQ199Tf4c
Message-ID: <CAEjxPJ4KGn8u1XiCbsRNMuFPOaSiD+Kq=LSYxcbHLkYy5eG9pQ@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: refactor selinux_check_securetty_context
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 11:45=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Aug 1, 2025 at 1:45=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
> >
> > Invert the checks for fp and con.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
