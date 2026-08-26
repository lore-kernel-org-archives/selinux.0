Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D3D41D122
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747137; cv=pass; b=NlKEmp4WfuRroVl2UDCqWzWlXJFqS5C8CmQN9fpA/rOSQIJ5uwvgjxVYeZl1a7jFhqvEyqPIibf3++m3cq+6uwJkeHsmzNdhspTX0q0L9LMC5M0pfUef7Wyp4LyAd1dzz/tts9kozC5OtowP5zSlMNeAqmkcX3MbBgRYLJn+izs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747137; c=relaxed/simple;
	bh=9RcQ0wGg2ZwNkbMNqS40wKNGWfMVMlBwQ2qCXh7qhKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/9gIStw61L+ukMPy4jAMDjhTs7l6bQsDrdwiU6a5oSVDg3AXkqJpK6pnjfjbBhpeGJDUIUD7PQtwxM8pdP0b4q+UfZ3xsOAGuPcFWZXuvRy/wiiJeDpRkvbozQHfY4fyjHlYMmHsrPhOKW0IZFAmDyC+bbXGoh258ffmHey4+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bm487Mip; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm487Mip"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-45eb688c891so450023fac.2
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 05:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787747135; cv=none;
        d=google.com; s=arc-20260327;
        b=QtHxfmcS4vhVV7M3bBNu369fIj8l9R4X4Ns7mDSD0yPCk2unQJ+j0Rt0voRKsLKCHu
         xOeYTS+W0M5m/LpM978wrMDznbH7xGf3d+af0co9L4bhZmmudJD+S4e6qAG4OnZnpzjO
         PodFJCgKbd0wuaADrPDz6X5QU3sZ8UtjRpDE1u4odHnruCpKKt9iWm6/c5T7kf9gH6WK
         Pciy+fQeq5J/NrY+ZpJG7y4m/fCKIgD3oIG2usG5i7mTThhVwGPjHbdndW/os1MuYLWq
         wc086FWKd3Ujj9RTIfiveie/LXaRxjKzHUenQNytxp7cUrxCcpu0Uug0cKJN/ZOrHBcK
         tEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9RcQ0wGg2ZwNkbMNqS40wKNGWfMVMlBwQ2qCXh7qhKs=;
        fh=7+QOJrX0reqoTSCiDyCe+ResJzkpTNgCkbawPxCyrOc=;
        b=lHHTbEXTD2t5woqCeBvB6BZQApM8+saYJRKfWcSzEoBW4d7ranTFbr+i/GRfVfX73a
         C3G6Z1NXRGdkfoa2gfSXpKbKJd0JdI9nTqRUm8jZkMM6WXMzTTsLB7RyMA+/fgVSGpmO
         Kj7xV9EIM3/NRcUrel9X1mP9OpczvLxPjNh+ufJxbyTHBuqyKja84SK/0PwwK9gxAuVz
         quzTcb7LsenG4PDCnEioCK+J+zZl501xRCRZ2WY9lqX0UTs9oVLTgCtNA8sET9aQ9jLV
         2wBrZ0GuW4AHwF07DbeoZohqRXBrLJQkbsOeS26qWisANonF4P/0fYkNe31oZ4JlJIFt
         hD8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787747135; x=1788351935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9RcQ0wGg2ZwNkbMNqS40wKNGWfMVMlBwQ2qCXh7qhKs=;
        b=bm487MipZg9PglnUVfnfTbGnq5ItbeFT+k/e7BpF6jGkbCHFZwAFVyvZNS/A3aKiRt
         TVZPOl6luOFltrUczPaV41L88qpFTxmtcPcqoAuvXzJC/M8GdJOcTRgNozr2OSYoiaSp
         ss8y1y3a+7qc9g1n2ff0rmGcTf2jh6927EMOmlequtwRrV7oPs3ibs6cfqK2eXki4sfr
         wwCNIj+/72n9Kw+AliZmtdFyCRCpJIsM8BvByOCUzVkJ1PEPTAz2g5ajiRXWIlbBzDib
         FSjDsrjZtvPdPiSSg74o4EoZmbEqOvG1Nc+q0vZFgsxxNsAhblbel+wg0yegT9ImCvUx
         7wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787747135; x=1788351935;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9RcQ0wGg2ZwNkbMNqS40wKNGWfMVMlBwQ2qCXh7qhKs=;
        b=FRmJ8Zbo55Q8DfRUI1Vcd8chzT7W+s2C7P338syKVUOFw581j0qnEPPsB1oaVutAII
         fVe1N6yDxeb0Yjl1kvmYVDk9DAuCgk81ih8Nxm5YGntML7DdWWFOkJu6p7JEavv8u37l
         unG0gFpZmgjkLpOVDgKd87dG/DQeuDh1YbgUi0FQXtxxKkrEy28/LvjAog2B/j2H2a1b
         ARMDox4HyG1jUf1EBm4mIWZVFgx1TvSej2+jSP6qwQmy13RLrKyubc0DCkCtAYi552hf
         7MHt3Q3IM6d2s95B1PbVNYv+pzQe+WP0Cdfo/aDsy0rOI6/hd1GQjSk29Va2XLiaXJW8
         nYZQ==
X-Gm-Message-State: AFuF++m/rJEvKiHxF/NLChb6B9YoXR/hOt2KZLCnZa1U8jl57qbwnL/s
	2TUl5T0u6Hdykpp34JoAnD3XH9uXwWC5tzxb4/dYCa9NKTnx/9Gou1AT3ugZsplJM7jNDan8AuJ
	/hdCrMKQYUhUFmZMIU5pmLRmZUYee95I=
X-Gm-Gg: AR+sD10TDLKRtIUB7Fvk1lDrWRtItnhqTStr8tmY1Nbfq1u9Pd+97DlCYBNgi6w2pbR
	pH9gqvWA7zDXTpocvh/7vImMSd3y4iJmerAzLlwNJB8yYdlbNw6/XrvuHSTbSaGCLaNxl0EEPLb
	JsldGEq5kl3DXETMDFz8xOA24iwT9S9Knj+046YBHRz3q60OFPzCcP5goXcrrTMHjDQVyJ//M+V
	MaBnRiN5l+ELjTmOVDiYA0ra2++702K+uFmbYdpcCgfSp1Vml+eMPJoDfg4kRt21qYtAk3gSRd8
	0qkxK5ERdBkcxN6IahlvPbRHzcgLUAQAzrjTnYRy3gmMHII75dFaINg=
X-Received: by 2002:a05:6870:6b97:b0:463:3935:9c30 with SMTP id
 586e51a60fabf-4659b7c918amr6888374fac.18.1787747134793; Wed, 26 Aug 2026
 05:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825180358.89854-1-stephen.smalley.work@gmail.com> <CAP+JOzT86cPNuLw2gygoMAMYWbgE6OYdPz_ur7tWBvaZ3Em2+w@mail.gmail.com>
In-Reply-To: <CAP+JOzT86cPNuLw2gygoMAMYWbgE6OYdPz_ur7tWBvaZ3Em2+w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 26 Aug 2026 08:25:24 -0400
X-Gm-Features: AcwNN1U4LMGfE27r_Pesedqh64wTgjJgo_M3H1Vg2NDTPYLnmAAdSj3WY83-4hw
Message-ID: <CAEjxPJ4=UjCbdv=AGTt-0qqxvTf0BN5_v3EF3ceo==Gp6YBV4A@mail.gmail.com>
Subject: Re: [PATCH] libselinux: sefcontext_compile: include limits.h
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:52=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Tue, Aug 25, 2026 at 2:04=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > limits.h is needed for PATH_MAX; the absence of this #include
> > breaks the USE_PCRE2=3Dn build.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.
