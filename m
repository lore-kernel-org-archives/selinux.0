Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB91F8AC5
	for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745602002; cv=none; b=RTvOUwss+ibOB5FznsKY3Yc2prN6YQemL3UKsWra/XUwizpwgjEFoS9/gWdU+0OxF8f/bzKiSDVo2TXVOab/nX7wT4jDqiM7M/1f0jxuI9Ltdt6Xi54OKecjlNg62dWOQ/wM9pR3WKOaSj8PaiRiLatc7qsOQ6prbqhQ0OCSD7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745602002; c=relaxed/simple;
	bh=+fBuGQky9lIeVO3DqUSTHKQe1t26CJYoA4F2eh1PErs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bArZdq5GBvVd0F9XBn7OBPlrTb0U5T2riHoYOkAvAQv5nOtdvFCmwEsQsV54JaHC3Y88GysOU1XImTagLQdTghV3rAQ5ESQ+tZVcSPX4M5ct7EIiMX/DTmzc/g6Q5J+s8XE1Bvt8SOFKAqUgoqOh1/7KtowqTqpKS0AR6oZH/jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1EwCzJK; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1EwCzJK"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86dddba7e0eso1055390241.1
        for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745602000; x=1746206800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0Rw5frwkX//kv+jm005rqz15sGE+DFnK2/9QTDlTAI=;
        b=b1EwCzJKDC2maYnByXEDwvGO0YEHIbuHG27RRdJYJYA1ESP4a3o8aGjNwIQcB6PhTQ
         Bws3KMT8qn1uXlQn1sLOOZEpJbq/O7DbLiE5ook2VZiMVfW/5nEsaGt4hjDRmmqW2Gc0
         hXkk8FARU3MPJOrOqkQwU2I87YaAgXJY0EMhN19pbhxnqIHvreHEmDNUVR533F9eA8nG
         5rBsHkFuF+YLZ3QZYgjGLYH6Ldt5vTs41XdAKP7ytFE97sVmjcJlnw3ywPYQtAkznk2R
         RUQBhOGhVXnF1E0D2WXOR5fX93O/LfI2XLxHzZvZNQHmmjegO6SI0NUk4G+bgP5vVZwn
         TpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745602000; x=1746206800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0Rw5frwkX//kv+jm005rqz15sGE+DFnK2/9QTDlTAI=;
        b=qpUFGY7QTm7fAZoYMku7qwuWWbF8XLvxacztgotm8ayupdATrS4fkoZp2kfdA1CUR4
         /N8Qzx65EvL+m2SZ8NXiHhwU9VHqeTBtvKndxfX+zJZcv8+wdoi4qjdHCAzZnvgfSd0x
         xWbxULKBrsWQM0k1ECofdzQsxWTLmYB1ozWR77Ww079Ul0OYAgw/HC/nxKRadPhr9/Yy
         lkQLgxA0eKZLU+UGKzfNwJb2XmLkdtBNX3NxoYjeEpyM8bVOrX6nJ5e/MTBG1nV56172
         9ks76WAvblfYRTolP+EWPpvbfEsKw8tX4Ww6X7ewJlNvM/N682cOFz8jnSMd7lAJq6d+
         UmXQ==
X-Gm-Message-State: AOJu0YyEj3hiOMyrz2i6vnJ6/DqnBxu4cO6vllneUILtcXmIqTUiUajr
	K9nDH5sjy5GwK/XVBWGfvavS8FXpc+4a3ivErr1UkOQfE/pe9zneep8gA3mbNx/pYNMPGossm1O
	XPtWcSStVROJZebEHQNWzB081DHlgRw==
X-Gm-Gg: ASbGnctagBscmh6Un4CRzsmKKp4sMCpQ8BwG+lyqXWU8NbU6dy1D3HGrfsi3LuvgXly
	EbpZYaxbNuQ0ZSnoegf9s41ZRqPSc6NTHTW+nqf7gLoM2lEVddB56VklWE9WnOKA12dK3ofpArY
	SdTTkBnK5H9XSNujJZtEE=
X-Google-Smtp-Source: AGHT+IFkyFQT8MPfxCYpxZ1MIwchcuKerXL56BOI6+pSL0EO3ykLfSn5yJeWBnRyQUVFCvr0+l7DnALwJaYg8arTnVc=
X-Received: by 2002:a05:6102:80a1:b0:4bd:22d5:fbd7 with SMTP id
 ada2fe7eead31-4d543eb9348mr2436404137.11.1745601999922; Fri, 25 Apr 2025
 10:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407023757.2183935-1-inseob@google.com> <CAP+JOzS4fo+GNVz7qE=6wbCkLANrkpn9-Vj=wU0s9kSdOZJc1A@mail.gmail.com>
In-Reply-To: <CAP+JOzS4fo+GNVz7qE=6wbCkLANrkpn9-Vj=wU0s9kSdOZJc1A@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 25 Apr 2025 13:26:29 -0400
X-Gm-Features: ATxdqUFt29QmGQUkOOX_ysObNiQlJ3xZOvrVIqMXjV9C8Lq3sXpP4BRwZdLdXHY
Message-ID: <CAP+JOzTFipTE_C7wLbrZHmv7-bNcQ6z41i9Ez7JKTdJ4P1dK0A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix markers for info nodes w/o children
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, tweek@google.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 2:29=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Sun, Apr 6, 2025 at 10:38=E2=80=AFPM Inseob Kim <inseob@google.com> wr=
ote:
> >
> > cil_write_src_info_node has been called with
> > __write_cil_ast_node_helper, but that may break the result CIL file in
> > case there are no children for the info node, because the "lme" marker
> > is printed with __write_cil_ast_last_child_helper.
> >
> > This change manually prints the "lme" marker in
> > __write_cil_ast_node_helper in case there are no children, so opening
> > markers and closing markers always match regardless of children.
> >
> > Signed-off-by: Inseob Kim <inseob@google.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil_write_ast.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_wr=
ite_ast.c
> > index 15d8bbaf..f9edadba 100644
> > --- a/libsepol/cil/src/cil_write_ast.c
> > +++ b/libsepol/cil/src/cil_write_ast.c
> > @@ -1624,6 +1624,10 @@ static int __write_cil_ast_node_helper(struct ci=
l_tree_node *node, uint32_t *fin
> >
> >         if (node->flavor =3D=3D CIL_SRC_INFO) {
> >                 cil_write_src_info_node(args->out, node);
> > +
> > +               if (node->cl_head =3D=3D NULL) {
> > +                       fprintf(args->out, ";;* lme\n");
> > +               }
> >                 return SEPOL_OK;
> >         }
> >
> > --
> > 2.49.0.504.g3bcea36a83-goog
> >
> >
