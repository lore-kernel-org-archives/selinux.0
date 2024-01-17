Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4E91E87E
	for <selinux@vger.kernel.org>; Wed, 17 Jan 2024 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531596; cv=none; b=Ut/IQRPf7LmpK1eCc1Q7EkbkuF6cbl/3iwrGShbReMZNQjMYk1IaXt7dJOiH+zdzcWllchkmtL0ATBsozB9yXBZK+HjOZebDZtbtlqSCEhLhPIE/U6Y4lSdOqts9INIXtjHJTPlDfcD6FTV89cwsk+ivWyNqIj5i07jZMFmz5qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531596; c=relaxed/simple;
	bh=iUlscJeTm4pbcg+uiIT41dxgdS0KpwW/iR3/zKnUo08=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=hVpAiWTgEQyI7jOOuEFHKCLQZBJHfeLel5vCNO6TIEdi2mp2s9Q5On1VNOvfsiZ+Es/YYe2y2BfyoJ1zf/I+XPfv0R7lA328/KZpJtWv9Zkp9woppBD4jpEetnuqKQAsq7+MfdjNeSmyEdqTYDWEEj2EUirNebBLt00Nc3ZJAC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lgcUy59G; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgcUy59G"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5ff484f2ae7so32084757b3.2
        for <selinux@vger.kernel.org>; Wed, 17 Jan 2024 14:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705531593; x=1706136393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEtfKHM4jQzQLGyBhBaXBaAlBL+U+MX7o4RckoJKRd4=;
        b=lgcUy59GfI7bWRPKu3lW8abUo3M6xXsWdT/t+UVqA0OsOM+ooeizGyQf6KVBM/wJxH
         x9tObR0CybXihTbypLnrMphrQVgUo/d/BPMTRIAeLfl4RUYmSuQnBzvcwBurSgH2qRVx
         rq5h2oao5h4FkWrCecVQYbMWilz0vb8pV5FxjBHzH2cZkaCtf+L2qrE6fERccn33tHlz
         5yq9CyrZuruj6xzNbI5I2IJYZjLMdTCIHO4DdZEC4oOyM9iV7eSVQ1oSlztyc3zKBEfI
         ERPnZP4DYK7fPeKxKAxW5Ex+HYGQVojbP0VH0nafFqEXqqY48dPdt8WrhTDUzNlrzC41
         Nq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705531593; x=1706136393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEtfKHM4jQzQLGyBhBaXBaAlBL+U+MX7o4RckoJKRd4=;
        b=DsQzeVVCiIKnSdiCu5z5JdvjsunsteLFyFXAXO60tGt3CedJwEasAKtIRz5XYT7FE4
         4wgFDZXsf1Ij11F/bG2V9YkqzeDz5LbAJz8n+Hh/ahBa/ctR4P4htbrx5ufKKGYvDDCa
         SN2C3zDUTMu6pay2rDvM5sAdvT8Xh4wXZcz6poxEwIrSGS7wUp0cP0pOW5zjLNykqOc5
         oBPgtffB2iX8R4G5ey8qd7ljTiLicNdQSzaboewME2hNay0jKFScThTOijhLN86BD2+K
         SdS+P0hOpuGn7qe1PdTMEEHqpuynv9H+ANwTcygIr1xFu5tsadctPiSw1JPUu8T8tDt9
         YxIw==
X-Gm-Message-State: AOJu0YzE59EnBV6uO5xmbFQXD64VdmlHLT+EOjWxhKmfnIa4RHLGrIfm
	TXYw5NXKOvSbp8RA+OUyDJvPqWa7C7CU3i5sjQWCTxxbMPKo
X-Google-Smtp-Source: AGHT+IFcNPtuzXeyNaWzcBsBS0yPnJacNDAP6RyfSMO6gLFv7R5OR5rMNmfvyQmUVgCL03Ny0eXHwuHfVLL4PqulmvY=
X-Received: by 2002:a81:ed02:0:b0:5f3:dd8d:4646 with SMTP id
 k2-20020a81ed02000000b005f3dd8d4646mr7819257ywm.81.1705531593500; Wed, 17 Jan
 2024 14:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117223922.1445327-1-lokeshgidra@google.com>
In-Reply-To: <20240117223922.1445327-1-lokeshgidra@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jan 2024 14:46:22 -0800
Message-ID: <CAJuCfpHFNBSteck_bWxHwXDzeqC7QLn6hks5PoMC4ytWbJO4tQ@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: fix return error if mmap_changing is
 non-zero in MOVE ioctl
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 2:39=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.co=
m> wrote:
>
> To be consistent with other uffd ioctl's returning EAGAIN when
> mmap_changing is detected, we should change UFFDIO_MOVE to do the same.
>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>

Looks correct. Thanks for catching it!

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  fs/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 959551ff9a95..05c8e8a05427 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -2047,7 +2047,7 @@ static int userfaultfd_move(struct userfaultfd_ctx =
*ctx,
>                         ret =3D move_pages(ctx, mm, uffdio_move.dst, uffd=
io_move.src,
>                                          uffdio_move.len, uffdio_move.mod=
e);
>                 else
> -                       ret =3D -EINVAL;
> +                       ret =3D -EAGAIN;
>
>                 mmap_read_unlock(mm);
>                 mmput(mm);
> --
> 2.43.0.429.g432eaa2c6b-goog
>
