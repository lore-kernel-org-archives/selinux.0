Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347F37B40A
	for <selinux@vger.kernel.org>; Fri,  7 Aug 2026 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128046; cv=pass; b=J5xZ6ZvTWgp1yTP2DWcM41zyiB6DIgKkJU64cllD6S2XNyQY8zYloTTt1Fft0foB+wJNzBiYNUsXLairJ+tIkzPCN6vxCs9V3kXOdnZQNiEcVIzTPPjA6ZgzvBYsM9IghLmWFYCGSJFuoxTe8EIIiod7T7TH5UCqefnyGNSk5S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128046; c=relaxed/simple;
	bh=tThuM5gk0AJQRoejYJ5NRI38frcwfp7xt8MNInzCL2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8Z4KcyjRoe8xEzHG6J8A47Sv3Nf4Dj0zGYKOjf050m7fRkK0h9VH0qrK717MZVcyzEVtw+3FO5R+2n74+qKTw9OzqGWpmhf96xiEZDV7DX0LXhw299jEirV431mYdQpI3p9MflKgXH1MTMq4tzyScCn1ESQemgSXgnVpmpmmbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4F+W0zU; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4F+W0zU"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so2237230a34.3
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2026 11:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786128042; cv=none;
        d=google.com; s=arc-20260327;
        b=XwWwWanC/k77K9oz2B4GtoQtbHo/xvSxOV5q6c54Wv4fn7joZfdJrCDzgKDk660inV
         GRq1Su/76gbTykp3OMvvNxXpUyraDR+yUIRLdZelBK1dxfAS0/z/CXqAFmp7pXxw/qrE
         HPSPisJXV6LLbrkC1zbBR1ZMIFbKeE53kOpT/YqNL1Epo9Rx7SiD99velVKZQFUeN6hI
         4hnnVX+aGejZc49kU8fZn3wz6OQ7wHVT58XV1elIG24v+qkRmvQVTA18aWapJWQzvUTj
         ASjSQ2bZx1p0b+WEGn4x2inUV3zogYqVI2eCbycwRtd5YKsbWq5AEHFT1oyJxf6tIUSc
         fOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tThuM5gk0AJQRoejYJ5NRI38frcwfp7xt8MNInzCL2s=;
        fh=XCM8fo7IfM89sTn06SjGxcUqBXOhXzH4qY9c7awlrP0=;
        b=YBQnQaSFLsUD982twxW/zZZz37An1lKnQYABNc7+kx0FNGO33AeiD2gFWlYk6Ka1Go
         w/Q0/omKNor55GQiRnwVmNGM5haS7x9D/SmsbAFLPt4rv6fxAazAMUxtxIajuBYvKHUz
         XBnEWb0THiuYgNABIXypZOiLeiolgMlm84UZU97/7YFqyfyY3wQyXNp4uYsOxq1FdM2J
         RR8BhKUSht8FTAAjpzfIYELTR9eWLsCCWwuXLXkKv+gFtMILr6VYB8eVhBnsB9kyZ78s
         86xxUS3tdVuX4xBF28DEvGbw12v3OjziVe8owRNEr2dRvuaDyMYuENJA0JI276WoMrmr
         C7Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786128042; x=1786732842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tThuM5gk0AJQRoejYJ5NRI38frcwfp7xt8MNInzCL2s=;
        b=b4F+W0zUiWf1I81mMEwoOR/tWe/4PA1A+g0C2rHc8KRXmdCi7yZJZ3v+o1/mKH+pIo
         nm+fl7Z+nwcwHa+6CXoOXJx/zWs2jtU0r4gi7NWpRk0aGMnlpmgOXBmGJ+DuTJMr+jUK
         P32wzm7vJUQEsyjShpl0raP14UVBi2WvkdPMCUUJGOW3yTGIQhHegy5vJ9PWs97i0CHW
         xPFV99ATqZOt8aJn62Tm/MYzYdfa3OSzKN9KB2boBXaxSk4duQcLHqpMCmdYvYOyMnWO
         BAmCk1+ZNDpclQ93Jx7ByfxoR6GLBYisyK6dGMCq+XP5fqatcSXxwA98asriO/n2LEy0
         uADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786128042; x=1786732842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tThuM5gk0AJQRoejYJ5NRI38frcwfp7xt8MNInzCL2s=;
        b=ntSjWsnDAUssSNT65VzMUxkEigCPxqRbyd2ABj0xcOCZaMnCer7wAGFUfq8/r3FRQt
         yxhcZU7Fsu4+txmz22iKZhNwcqph1drEpKOpXmNhI2Le6UBzN4E59MzHtiHVEUPGbBgd
         TG+qqIoKnSSVdDSaJIYd74mCmBDFvD0+TvRaL86Ax6h62A/uxoaxlikDHLIJHhfym6ri
         K88rzvqSej0C5XJYcD3I7j3NLUmSsma/9QdmYctJQ/bBS8Pg2SYaNl8Fm52294Q/0KWp
         klwTyTelKN+djcBbetJL5lpFkKf2qo+pDDT06EerngwUQclqEMPdCF6fVj8Ta/32Z2vh
         YOPQ==
X-Gm-Message-State: AOJu0YynwoFZpzTmOm0Hk9b3FDq59OVzbrFs0qzALLCKPu3iJ9PllPCA
	Ak5Rf6/wHOR1RmjT1qs0P6LP/5f/8QlYMiLt+L1FbG/PyWc/jy7ECKz5FsalGuMuJpBjJjUzVSm
	KYmM5Uop1t85CvKHmtykqqqDb0skQTKdcvA==
X-Gm-Gg: AR+sD10dnaH2rAPvbsBO0oa1mPekmDnbjvA/QnYwvYVhA3jIDWkJmZb/ANf4UI7NevC
	0kNyplTq8Y0zcJmsrkmv2vPBKjceUH8RLLlnNAqd8h56NXIDs8aKBo11loy6iXs7t7rCcJYqM7F
	5M4Fw9eCC14If/tHq1YdeMcQ1Cwy6cCxKs7YARyv9/H5cIvju0Wznf+B5ybVzAkoXe6dmm22HMU
	tXlcv3bU42RHh2Sye5XlECMq+7H2/3/U6ElBvCjqJ5SOVrrUODzzbGVi/FNoydeqQxB1og4rB+Y
	bEeCwSY3J+zEXoELaCSiOyMWHWg+173JaVbuQYYb+V/j
X-Received: by 2002:a05:6820:2d85:10b0:6b0:4170:59be with SMTP id
 006d021491bc7-6b041706e10mr1141590eaf.8.1786128042157; Fri, 07 Aug 2026
 11:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806204320.381649-1-vmojzis@redhat.com> <CAEjxPJ42-mJMUCvW7r8xS9y0J-9mYQoDU83T5EkAstaLjNXVgw@mail.gmail.com>
In-Reply-To: <CAEjxPJ42-mJMUCvW7r8xS9y0J-9mYQoDU83T5EkAstaLjNXVgw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 7 Aug 2026 14:40:30 -0400
X-Gm-Features: AUfX_myO5PyhF_-QBq9rvNXPH2CXKJ76I053SXB6l3ni7nicoteHfpSFOqpG7_s
Message-ID: <CAEjxPJ7Hmu4XVyVL-TFDHVjjfBuSgyJ4k7b-T717A9C9BsKwQQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: fix size truncation in cil_add_file()
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 8:44=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 6, 2026 at 4:46=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wr=
ote:
> >
> > cil_add_file() receives size as size_t but passes size + 2 to
> > cil_parser() which takes uint32_t. The existing overflow guard
> > (size > SIZE_MAX - 2) only prevents size_t wraparound but does
> > not catch truncation to 32 bits. Use UINT32_MAX - 2 as the limit
> > to match the downstream parameter type.
> >
> > Fixes:
> > 2. libsepol-3.11/cil/src/cil.c:561:2: cast_overflow: Truncation due to =
cast operation on "size + 2UL" from 64 to 32 bits.
> > 3. libsepol-3.11/cil/src/cil.c:561:2: overflow_sink: "size + 2UL", whic=
h might have overflowed, is passed to "cil_parser(name, buffer, size + 2UL,=
 &db->parse)".
> > 4. libsepol-3.11/cil/src/cil_parser.c:247:2: taint_sink_lv_call: Passin=
g tainted expression "size" to taint sink "cil_lexer_setup".
> > 5. libsepol-3.11/cil/src/cil_lexer.l:71:2: var_assign_parm: Assigning: =
"size" =3D "size".
> > 6. libsepol-3.11/cil/src/cil_lexer.l:72:2: taint_sink_lv_call: Passing =
tainted expression "size" to taint sink "cil_yy_scan_buffer".
> > 8. libsepol-3.11/cil/src/cil_lexer.c:1770:2: lower_bounds: Checking low=
er bounds of unsigned scalar "size" by taking the false branch of "size < 2=
UL".
> > 9. libsepol-3.11/cil/src/cil_lexer.c:1770:2: data_index: Using tainted =
expression "size - 2UL" as an index to pointer "base".
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
