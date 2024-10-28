Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC91DD0ED
	for <selinux@vger.kernel.org>; Mon, 28 Oct 2024 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135719; cv=none; b=XUQYLWK8Z6l8XSPdZ7nLSyyV6p/wWTGnNPFoHFfZth9e1dHFnJouP/xvnA1CzFJNoKN71bQtB0cTSYUqjFIxsfvLLMHxuBwXEnNngjZHcv7DEzBh2g0rxQ8jbxkJCm905FYz6FKeKbFbEwfiOnu0514krw4mf//sDXP/N8UloVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135719; c=relaxed/simple;
	bh=/xeY7IoS8bSaE3G9KAXUFaw9taZhlR0DUPLOLrmS2F0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnOQq3ruJkCvNVNAOHXMow8Lkku9RtBtxrNjZIgBR/o7lGGWGyGE2uHBAyuPCJbSIvGB/1fhSlUbdyh3fzhsqbQ4YeCjd3S6j0MzzCQtyLs308O5X9O3zEVBN0f/TOryBIkGo5hCYsukm7/HBbbtpa4+56pI/dLO23Q85q1qlz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUXf1qiv; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUXf1qiv"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-50fc0345155so2436691e0c.1
        for <selinux@vger.kernel.org>; Mon, 28 Oct 2024 10:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730135716; x=1730740516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/i7umC2yh0aZRufZiF32ggKkL7eLkf3xrDYj9/DQpk=;
        b=IUXf1qivfi1WfkiZKqWmi9AaZORzopmT2XKB6H/5qGDmEouHpd63QLWXzfr2x8zzSy
         ChCI4OnStLFV3NKOp1c3+40+VLOhGvuONKC7ktCs2It393iZwCB+25oaWZQP7U2cvljd
         Jl1XTWZpevvNKKm2L+RdaziqKM/TDJaQD7c8r3XTbsM9Iomh4P/KR/E/WT7bCczlJTZh
         AxZ9ZFm0w2jT2hkV7yn5w91KgiJ1ACYC6Q4d7y4wNBdkf1KcZYinuSTE8s+ug7W3qLlS
         GHbuBUSRneWgu7kGObvmYeMVtxdeTOS+RhCgtX1BLuweJHXq0cbUG6qWz9cZNWJo4d0N
         zUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135716; x=1730740516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/i7umC2yh0aZRufZiF32ggKkL7eLkf3xrDYj9/DQpk=;
        b=wYqTLAXAZd4QjbQG9qcX4dRokkl5ZcpoctgtWtWFCXS5DH7gvWJFQhMnGqjfUC92YO
         Pe+ABX3tHH8s9dGCehkcPiI9pZkao548p12XlfqsmnpPx59/UNqH/67BlpI/4W1Pzf9s
         3/pyiPCPjljaz/y6zkPIFDmM32Mi7FMI4tumlJePjb5veNfEaFm37vcv6UYXnoBBgxic
         w98DdxRj89kascz66nmbzOFq4AXLFLvQkKvvmGYQ0r/+rpjvpTab4naj5fEo44UdCamz
         iQzWXrOFtmtbp84j3ybGWvREbu7MIRBmIzuxSIhmzr6yKpTEE91VqXjKTOE+//GLQgod
         YgNg==
X-Gm-Message-State: AOJu0YxE+IzbFJNhf32ItioYB94YxBOEu0qEY06c0Od84rzbIBLvFUkp
	bSegrmkrgo3qrVZBpCdHEmxbV/kj8cpDN6fsY4zg259kggIfnrCAOcB97mKKjiQkVomsvRtlFD7
	A+b8L+euU0ObVmr+dkVpIOjcLXpU=
X-Google-Smtp-Source: AGHT+IFPn76KmAhOnRIOf9EcRM6Z4Di5i79A72JuFlrdTavl8GGs6rFUPOcN83kOdqFnyQOMFm0ip91t9SrNW3Llddc=
X-Received: by 2002:a05:6122:18a2:b0:50d:530b:6c0d with SMTP id
 71dfb90a1353d-5104be06afcmr429246e0c.1.1730135716372; Mon, 28 Oct 2024
 10:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025183207.1827274-1-vmojzis@redhat.com>
In-Reply-To: <20241025183207.1827274-1-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 28 Oct 2024 13:15:05 -0400
Message-ID: <CAP+JOzS8PC_gzy73a-d5ZhvY7-weToXBTotm0HcmoBsEaKd0qA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage/direct_api: INTEGER_OVERFLOW read_len = read()
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 2:32=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> The following statement is always true if read_len is unsigned:
> (read_len =3D read(fd, data_read + data_read_len, max_len - data_read_len=
)) > 0
>
> Fixes:
>  Error: INTEGER_OVERFLOW (CWE-190): [#def19] [important]
>  libsemanage-3.7/src/direct_api.c:598:2: tainted_data_return: Called func=
tion "read(fd, data_read + data_read_len, max_len - data_read_len)", and a =
possible return value may be less than zero.
>  libsemanage-3.7/src/direct_api.c:598:2: cast_underflow: An assign of a p=
ossibly negative number to an unsigned type, which might trigger an underfl=
ow.
>  libsemanage-3.7/src/direct_api.c:599:3: overflow: The expression "data_r=
ead_len +=3D read_len" is deemed underflowed because at least one of its ar=
guments has underflowed.
>  libsemanage-3.7/src/direct_api.c:598:2: overflow: The expression "max_le=
n - data_read_len" is deemed underflowed because at least one of its argume=
nts has underflowed.
>  libsemanage-3.7/src/direct_api.c:598:2: overflow_sink: "max_len - data_r=
ead_len", which might have underflowed, is passed to "read(fd, data_read + =
data_read_len, max_len - data_read_len)". [Note: The source code implementa=
tion of the function has been overridden by a builtin model.]
>  \#  596|       }
>  \#  597|
>  \#  598|->     while ((read_len =3D read(fd, data_read + data_read_len, =
max_len - data_read_len)) > 0) {
>  \#  599|               data_read_len +=3D read_len;
>  \#  600|               if (data_read_len =3D=3D max_len) {
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/direct_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index d740070d..7631c7bf 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -582,7 +582,7 @@ cleanup:
>  static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_=
len, int fd, char **out_data_read, size_t *out_read_len)
>  {
>         size_t max_len =3D initial_len;
> -       size_t read_len =3D 0;
> +       ssize_t read_len =3D 0;
>         size_t data_read_len =3D 0;
>         char *data_read =3D NULL;
>
> --
> 2.47.0
>
>
