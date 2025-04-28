Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C5820CCDF
	for <selinux@vger.kernel.org>; Mon, 28 Apr 2025 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848705; cv=none; b=T+HvbOGNRRruN62IYTVEvo46LyrrNZiX0dnSvD4gxGWZ1NxoQdrBUX56cj/wCnst5Y5XB1dYzp1jeaIHt/LTvvKPBdKuMx/IMLvWX3VXma91XtAgp7jrL5ntQZmRFpPzFyszToCOiIqq8QHHxy6qhuNpFO7B4ssWGJhk59pjqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848705; c=relaxed/simple;
	bh=++y1JmbaK06vauS9ch7LY0aaBVnR85kJMhuht+1rdps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLJ6G4OUmiABKjkNaXjTBJ+DJH7sFCQCOX9sD8E9MnZw4S6CxLBMIVH6X4hsw+qN0JUnZeUHjjZTm1lRqzi9SGrCj+4DrXVJEXlPZ6dm0ZMTB566GzjPSkNnTh0nlVgjiNNp3lNFVmLrFyySjaMjO2qgh1SWh6CJZ+QK3fInUJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h++XyU0j; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h++XyU0j"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-301e05b90caso5391512a91.2
        for <selinux@vger.kernel.org>; Mon, 28 Apr 2025 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745848703; x=1746453503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++y1JmbaK06vauS9ch7LY0aaBVnR85kJMhuht+1rdps=;
        b=h++XyU0jwtpqborSdyLgDMTn7jTftapn7qZWR+uQBUkchDWEuIf+1QjIwhBGADk1l5
         X62ScpC2nwSrZUkCfngr4UmuV/8o+A3Kv0/mIb4mBfrLI26LPjezKhY8e9UJaOIlL6w8
         Eifnc2gxqhfLeETaEbCSfx1oVwaRVmvf8mLP3cc98cTTYrVCgSdr78FTxoCCLCmfc0Wu
         ue+EdsgPHu0Q2XlI02CZB3umfof6vV0W/Tn1Ij9OOSOQ7FHDlUBQBL8e3VsT5XO5Q6sn
         64g7opAUbYIwQlyRJhoQgDIUrgNmmxcfAZlegbWj4NYFe7VdwzRN+gJTWojCNSu+hP7U
         DDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745848703; x=1746453503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++y1JmbaK06vauS9ch7LY0aaBVnR85kJMhuht+1rdps=;
        b=rZSmXttdpoeu9G47BbQRleV4C30wpiNFv1DcuC2H6Tt0ovZH7Pnlb6RXi2EdAJ0jUx
         x540qGn86l/UlG5QObiDn+ARxsnOihm9QhObQsBkSEL/FFDRaCzt+nfICE4iIye221fX
         eE01WmAkJgBWr/s2uI1FU66Q8kuU7/kAHjV4QFHv9RNy5mT/HfYgaWG7NlySNAkWgfLt
         NWTUCi/W/9vyTyhX9+KV3+b4KGyfPt9nA/rTkboI4NOLemUfUnMySRtNFCYLwNGtabvM
         2v/jvi7vP965uNO9vu/ofY0woPKyMpWKMHqk3cBnhhn8GzyjZWQgxx5v10cK9kPD1g2m
         2J/A==
X-Gm-Message-State: AOJu0YxzyAvV64uyOzVz/jLCcoOBZj7KGqD/FRG5MfiPoTrZx1N9lI8Y
	Kq1Huy0qjkrTy7FB2Xd7qInF+JW7qeJcALyq5K3Yp2pWQKOuInQo+rum5AfcHT1+UjWoDsktaF3
	aKwLXxkGu/a0QdieU0vpePvnu1DQDF+y4osY=
X-Gm-Gg: ASbGncv+4yPPtHlPMbghaUIJYSSA4Vduy2y93Bj0ytYndpj4s/WaXPFRkxRLigHGkPs
	4ET4LKGM2vGoZLVn7FZYi9jWauNI9FwS07vUsbhDyJ8GBKUQsYb7PRKn+v5dpr2j8QSWxL3U9/g
	28wK0efvg+eKUXJNjb+Iyk6Q==
X-Google-Smtp-Source: AGHT+IG0lF6OuvICO/jX56J0Vjca6/GVtSxY1ao2qSABf2x9gDYtrF3E2ygqJbHT1fTpy/LA5y0TP4AmaR6YsEwJLGA=
X-Received: by 2002:a17:90b:2647:b0:2fa:1851:a023 with SMTP id
 98e67ed59e1d1-30a013d808bmr13155175a91.35.1745848702935; Mon, 28 Apr 2025
 06:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425194005.19148-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250425194005.19148-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Apr 2025 09:58:11 -0400
X-Gm-Features: ATxdqUG2vTFcpx79m5OofmjjJlg1S_REeDLCENC-e16I6CXND-mN35zjUjLw1NE
Message-ID: <CAEjxPJ6AQvApqGVWZRsH86NTLOj7Czc7=-rt-spD-X9zpJyskw@mail.gmail.com>
Subject: Re: [RFC PATCH] libsepol,checkpolicy: introduce neveraudit types
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com, jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 3:40=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Introduce neveraudit types i.e. types that should never trigger
> audit messages. This allows the AVC to skip all audit-related
> processing for such types. Note that neveraudit differs from
> dontaudit not only wrt being applied for all checks with a given
> source type but also in that it disables all auditing, not just
> permission denials.
>
> When a type is both a permissive type and a neveraudit type,
> the security server can short-circuit the security_compute_av()
> logic, rendering the type equivalent to an unconfined type.
>
> Test and doc updates still TBD.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---

See https://github.com/SELinuxProject/selinux/pull/473 for further updates.
