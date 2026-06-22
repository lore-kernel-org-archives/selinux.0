Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D133DEF2
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155389; cv=pass; b=Xgu+SnztdIwmpC17hKU52FhzGdFA5FmZkGKdyBQYKnSHT0FZd+JftrAccmUW2msyZsk3y6BuNpg5SiV9jVuNkE2qzd6usskUOytopn4gjmYJJhQrpZQT0RBPKzbPpmdd/AyE3ilHelpqV+TlIB5KlrytLow/JVINAgxBguPHawA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155389; c=relaxed/simple;
	bh=4I41dd2MmE2BZv7njHd9Fe9IIO64wm3CezpWOMXxz04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a29m+6SG71Si/2zlxDOl2gndIOIOcb11U3yEyuOrfmKTs0uBdZflR86qsczSMLdekF01T85d+jtN61IXES+CBjFVsa7CZoZADMdk7yquswQNFkLVWIStl0z6xvblz8NUj36rT1L1Hhrne6o27BJUXW1tgMfPGGaV2l7iY8021pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oldas7xX; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oldas7xX"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso2469323a91.1
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 12:09:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782155388; cv=none;
        d=google.com; s=arc-20240605;
        b=CD1iwE0ZzWebK8cnvBcNz5+EdR1G0JnKpcE/ybrSmKcT6SFA8lUg0wmAg0gB6Uubnb
         +nIvbuLQPOtLESCiCp5ZriFmcKULxesXC2sUwElQDRWycBEUXJSWChSsltcO6sOb6ixw
         bVcXpPfSTCRQMgmT3CYEjFZ4MGe9ezm99B4WlN0NfUE1wM87Q0GRf+ur6bJ4qoIt2tCk
         AWFT07zpRCLgCYbmhB6QZHT8dpL0nHJT+AHQuM/HyrIfIr1oavnzD7m6UqNS/zSRgl6t
         2pdu/fyPOSLKdEEchGDIeSuh2tfeEtJaZCGnZ/hfJg3fYZK0Tb7ZTe+OuMx+up3ZYDrn
         cmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kAqIYUOu/0zCai2UZ60u7IH5HNkWIaWZVX7L1X8TDvM=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=HOwoaFDwMEYPp4IAsi2JAU81xmaMsT3z+inSMoWszp+DLqNvtfqHJcBbqu9qdTKLwS
         B0TS9VTkCVLtRTjAwU/y7rhx4IEGwRVCMSdTLRhVxocCzBtYa4MSp8Q/CL50LJseRnJF
         /U6f3pYtBpuEqRg4IDRdTRTMcBsYGlXKXlQ3fX2gQNnUkW+P8Zw7uUKN7ImG70MFiNwA
         yHUmvYPnLmI215V4EG8P2Q7HDO2MgKltNrd7bEajvq1FS7+ckAMLNfjvTsN/N3c+ppHX
         43oLRVK0xhqeepoJudtJDVeSs5xYfko+nUdwpUJ8RK51V/yQSIKrQOZQWdSIdJxlWi3E
         gZMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782155388; x=1782760188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAqIYUOu/0zCai2UZ60u7IH5HNkWIaWZVX7L1X8TDvM=;
        b=Oldas7xXhSGU1L1tc06RTELyqI3WddL1LTcGzK0FD7iKBr8uRvmEd4KB/1dMC2c1wm
         /Gh3HAOAVwMzieAhNs3SrbEVWJiOgbZ6FI+Tw/SOe16pH0EauNyvfu80rVaNNfbVYhJ+
         6Is22lEvfwUofFtHUGqxHoQ4qy87RWh/8JgHXUA2FnJ769A5twUSjKFhlZhEuFzrNr65
         l0BRBcnhQw2xq1xMAxaiyBaKBfTtdaWmwJRlxSaRLQSZ7xmgWpPh8idRdrV6HSsCeJt5
         IKyvk833hnTYMMEQDchR8xJCDcb62sMu61lfuXZn925mHWLhUfrXP9AjNFRzpFeYrkte
         tRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782155388; x=1782760188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kAqIYUOu/0zCai2UZ60u7IH5HNkWIaWZVX7L1X8TDvM=;
        b=riDF2sD9XQBXpvfvb7WH0ypm8EWzcsi9DpiLFcVOcIiApBQiVe2IOdRk/Yd2ll88lV
         ayGkuNzpTbLKgfMV6HVbwE/WsHUbjJkKVELU7/VUqzpVAMjnw0vpnDrK5c3rbDZabkjP
         9Rhma2H+m4EMtMdWphtd8aShL8zm4qk7JRT2Fh+1AWct8/uZroPpoj4BvXK5UtaCptEw
         IN1HVnpMOeyIl1+IOXx+ui2jIjCfSL3bTQ/qWrk1e7bCMuZBPzG92eXZ72v2mn4KdnFn
         K1FykOG1XDnYNiMhY8HLWE0/PZt7izG2o/E1CZiJjTUio5WOM2HRi6bSM1oK2pI1Yq92
         63aQ==
X-Gm-Message-State: AOJu0YyxlKZTP6oG240YMJgHgdIfhkJ8JKrmsgZQMqzNgr0HR2PYUJBn
	6Q/0X5ZkYpQFQ7tnx0MRD4fvhJgZdWL1d8K2GN5OoL8rxnXb8KTY5FrunKEYwVbVXpn/AUp18JL
	5eJO8LQg7MbyCcoKnzzgDCtxGnQrAlnw=
X-Gm-Gg: AfdE7ckNkiIpzmmlzPiL1csEhiawnsxmo+W9bNGJcXzP2g4vk7TEORHfsr4ilvnEWWe
	Nht6dZs69yE7E5NBMVC9chqxoZKlMEeXtRcAt3Qye+lppZgB7J1vkFimq7D3xGnevTFShnBPyOr
	II3yDIYU17c9tZaY4kEKUBU+r8As6hjqo9czzMSk9/Ve5MYmhIXJBiE3O9R0+oF8k/hDWKJXodQ
	EcMme8+kePt+/xzUcP4DhbkOJ5GtH5eAEaHSd/aKXfvU9OWd+jlBdlkVXEiWVciggSzzvFVSHLv
	J4VUsRE=
X-Received: by 2002:a17:90b:3a43:b0:368:ac5f:d31b with SMTP id
 98e67ed59e1d1-37d1629deaemr14409523a91.24.1782155387655; Mon, 22 Jun 2026
 12:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622173541.174998-1-jwcart2@gmail.com> <20260622173541.174998-4-jwcart2@gmail.com>
In-Reply-To: <20260622173541.174998-4-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 15:09:36 -0400
X-Gm-Features: AVVi8Ce64mMWfE-xfzY0GpVjB7jLpiqpsJBqiFo5J9E2neeaQPixqubER6Mhtn0
Message-ID: <CAEjxPJ5BBE4drznHE-kC33BRkurpBrWrQRsSf+PZp3tzr2ZeCg@mail.gmail.com>
Subject: Re: [PATCH 4/6 v3] libsepol/cil: Add overflow checks and cil_reallocarray
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 1:36=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The CIL stack implementation uses "stack->size *=3D 2" to grow the
> size of the stack without checking for overflow and calls
> cil_realloc() using a multiplcation that could overflow.
>
> Use __builtin_smul_overflow() to grow the stack size and exit
> with an error if there is an overflow. Add the function
> cil_reallocarray() that checks for overflow of the multiplication
> of the array member size with the number of members and exits with
> an error if there is an overflow.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
> v3: Previously in patch 0003
>     Use the __builtin_mul_overflow() family of functions
>     Add a cil_reallocarray() function
>
>  libsepol/cil/src/cil_mem.c   | 12 ++++++++++++
>  libsepol/cil/src/cil_mem.h   |  1 +
>  libsepol/cil/src/cil_stack.c |  9 ++++++---
>  3 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_mem.c b/libsepol/cil/src/cil_mem.c
> index aeffdae2..4f75122a 100644
> --- a/libsepol/cil/src/cil_mem.c
> +++ b/libsepol/cil/src/cil_mem.c
> @@ -74,6 +74,18 @@ void *cil_realloc(void *ptr, size_t size)
>         return mem;
>  }
>
> +void *cil_reallocarray(void *ptr, size_t nmemb, size_t size)
> +{
> +       size_t array_size;
> +
> +       if (__builtin_mul_overflow(nmemb, size, &array_size)) {
> +               cil_log(CIL_ERR, "Overflow\n");
> +               exit(1);
> +       }
> +
> +       return cil_realloc(ptr, array_size);
> +}
> +
>  char *cil_strdup(const char *str)
>  {
>         char *mem =3D NULL;
> diff --git a/libsepol/cil/src/cil_mem.h b/libsepol/cil/src/cil_mem.h
> index 7ec316af..f3f40c46 100644
> --- a/libsepol/cil/src/cil_mem.h
> +++ b/libsepol/cil/src/cil_mem.h
> @@ -34,6 +34,7 @@
>  void *cil_malloc(size_t size);
>  void *cil_calloc(size_t num_elements, size_t element_size);
>  void *cil_realloc(void *ptr, size_t size);
> +void *cil_reallocarray(void *ptr, size_t nmemb, size_t size);
>  char *cil_strdup(const char *str);
>  int cil_asprintf(char **strp, const char *fmt, ...);
>
> diff --git a/libsepol/cil/src/cil_stack.c b/libsepol/cil/src/cil_stack.c
> index d9c7b0c0..6fd051f8 100644
> --- a/libsepol/cil/src/cil_stack.c
> +++ b/libsepol/cil/src/cil_stack.c
> @@ -77,9 +77,12 @@ void cil_stack_push(struct cil_stack *stack, enum cil_=
flavor flavor, void *data)
>         stack->pos++;
>
>         if (stack->pos =3D=3D stack->size) {
> -               stack->size *=3D 2;
> -               stack->stack =3D cil_realloc(stack->stack,
> -                                          sizeof(*stack->stack) * stack-=
>size);
> +               if (__builtin_smul_overflow(stack->size, 2, &stack->size)=
) {
> +                       cil_log(CIL_ERR, "Overflow\n");
> +                       exit(1);
> +               }
> +               stack->stack =3D cil_reallocarray(
> +                       stack->stack, sizeof(*stack->stack), stack->size)=
;

No real effect but you switched the sizeof(*stack->stack), stack->size
order relative to the cil_reallocarray() interface.

>         }
>
>         stack->stack[stack->pos].flavor =3D flavor;
> --
> 2.54.0
>
