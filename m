Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BD713E41A
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729628628; cv=none; b=I9MqSE05E4f0NiYJIJneB++iLW5LiRRrvQMBt0B3cDbra+cJUcKyEIuzNgXaCoYUgutiCN7YUdHsDgHgWwGPsU/DEqURrGSjZWaDzjVniOk3k5dYbHJBS9Oso4Gq/ayrNAj9iiMoea6r5nzIFJt5ceCgqJfKnNEEeM4Z5miyCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729628628; c=relaxed/simple;
	bh=91Mx37TZIxwXTtB8+MBSKkuJTxqdi+tNm6m8dD90NSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlMh38VCODYAMZiKjSNFAoOf1MjDAE868XOPW8FymtuX1o/9yKnPUpE0mCWsh0BBirTT5EhGHmFaR2Uku4jfNo4aMxnr7C940rCYrFXCgp1G8IJ6LRE3rfTVTAkNYy+xcGof/aZjahR2xhz9ERBxalgo5dlhzfFjTjkoqEwKDXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmJ0T4n0; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmJ0T4n0"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a48839bc89so1650174137.1
        for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 13:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729628626; x=1730233426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VGbYt4uWkDnhlECIzkfbjWKZZP6BIAd2zZ245uTsHI=;
        b=KmJ0T4n0IaBoWbvEm3hFWagMqaPP0mE639C93rZrso/vjaFlIE2o7iWGgEdIpqmpV9
         0PvrVMh4otwlexTw9WaSs4TiYlsrJMgA2+ZolTfdHJlM8vQAMgULRrQU06qnGPTcMy6K
         JbqcnsSXQCExKlVzADmFyAnOHYteLuNb4BB7g38Wy1lielbU/XJd1or2R8y0LzwMhHY8
         UlbWh57jEdGZsoebtARTgNOohfy3sq3i7VEzlN2xUel6eUv8Cw+nmEqF1t725e2KxBeQ
         WSYDMXALOyG4mLM40b6VKoSlhB8lhVmcRXKgo94qAR/BoE2E9unhfykR+BPk5A1Qp8oU
         utsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729628626; x=1730233426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VGbYt4uWkDnhlECIzkfbjWKZZP6BIAd2zZ245uTsHI=;
        b=flU5UXNZVA44d0OpkStq3/XLtIOCgUlatpKHOJJ08GujoJEWngHAGSojFiIOTHEBnT
         0SmdGHNp0r2ZDw4KznggSPoNJiPSDkVZ1zI3B9/VAF3R9BV086pWAcQR/UFR7zJOBYI9
         HJKVCcOnHFhsBE55X2Rd2AA+1bknI4Br2e7Iq/EaanNma4awbX5JmibCkjDIZ+WNcNA5
         FMxZOJ6c39t3WX3a7H1jCjxA3dKemaWQvFn10xHt0q5q0cxSirsKbLNCsLe2J58WR8sB
         DQgG4PlvdPNR1s2MXqnN9zKMKebo+cp4HgWceltO+RSaBNYNDe+EeKg0fEbfdIK+qpXd
         rL+g==
X-Gm-Message-State: AOJu0YwKhbKO30ROiI6nWbQRsGn0nIzhjutAO+K05NHOhKmFKgwZ4Ifd
	yXagebB/opU39BlUf8xSL6nYJzagazhWobZnu8mJICVmwgSjz/e/LkPZb+EFm5bjJM6gPK/Hb4z
	Axd/VJk8xLiz6NAqcet2mNkQAPp4=
X-Google-Smtp-Source: AGHT+IE2stoO3a7+xN2AoleaQEpF5cEt6hqpH0KxISpxZ2m6yeFOB8DaBGqBAWoG80Iu9aFzfSyJoErf6JWsJo8gqTA=
X-Received: by 2002:a05:6102:3a0d:b0:498:d12b:4774 with SMTP id
 ada2fe7eead31-4a751bbe7d8mr367154137.7.1729628626012; Tue, 22 Oct 2024
 13:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022090314.173002-1-vmojzis@redhat.com> <20241022090314.173002-2-vmojzis@redhat.com>
In-Reply-To: <20241022090314.173002-2-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 22 Oct 2024 16:23:35 -0400
Message-ID: <CAP+JOzS=pjbG=_3HnkRMZFPd74XM_j-pd_1yJh5RaF_nfrxWMw@mail.gmail.com>
Subject: Re: [PATCH 2/4] libsepol/mls: Do not destroy context on memory error
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 5:14=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> In case of malloc error, ctx1, or ctx2 may be pointing to uninitialized
> space and context_destroy should not be used on it.
>
> Fixes:
> Error: UNINIT (CWE-457):
> libsepol-3.7/src/mls.c:673:2: alloc_fn: Calling "malloc" which returns un=
initialized memory.
> libsepol-3.7/src/mls.c:673:2: assign: Assigning: "ctx1" =3D "malloc(64UL)=
", which points to uninitialized data.
> libsepol-3.7/src/mls.c:699:2: uninit_use_in_call: Using uninitialized val=
ue "ctx1->range.level[0].cat.node" when calling "context_destroy".
>  \#  697|       ERR(handle, "could not check if mls context %s contains %=
s",
>  \#  698|           mls1, mls2);
>  \#  699|->     context_destroy(ctx1);
>  \#  700|       context_destroy(ctx2);
>  \#  701|       free(ctx1);
>
> Error: UNINIT (CWE-457):
> libsepol-3.7/src/mls.c:674:2: alloc_fn: Calling "malloc" which returns un=
initialized memory.
> libsepol-3.7/src/mls.c:674:2: assign: Assigning: "ctx2" =3D "malloc(64UL)=
", which points to uninitialized data.
> libsepol-3.7/src/mls.c:700:2: uninit_use_in_call: Using uninitialized val=
ue "ctx2->range.level[0].cat.node" when calling "context_destroy".
>  \#  698|           mls1, mls2);
>  \#  699|       context_destroy(ctx1);
>  \#  700|->     context_destroy(ctx2);
>  \#  701|       free(ctx1);
>  \#  702|       free(ctx2);
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/mls.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
> index 45db8920..a37405d1 100644
> --- a/libsepol/src/mls.c
> +++ b/libsepol/src/mls.c
> @@ -672,8 +672,10 @@ int sepol_mls_contains(sepol_handle_t * handle,
>         context_struct_t *ctx1 =3D NULL, *ctx2 =3D NULL;
>         ctx1 =3D malloc(sizeof(context_struct_t));
>         ctx2 =3D malloc(sizeof(context_struct_t));
> -       if (ctx1 =3D=3D NULL || ctx2 =3D=3D NULL)
> +       if (ctx1 =3D=3D NULL || ctx2 =3D=3D NULL){
> +               ERR(handle, "out of memory");
>                 goto omem;
> +       }
>         context_init(ctx1);
>         context_init(ctx2);
>
> @@ -690,16 +692,14 @@ int sepol_mls_contains(sepol_handle_t * handle,
>         free(ctx2);
>         return STATUS_SUCCESS;
>
> -      omem:
> -       ERR(handle, "out of memory");
> -
>        err:
> -       ERR(handle, "could not check if mls context %s contains %s",
> -           mls1, mls2);
>         context_destroy(ctx1);
>         context_destroy(ctx2);
> +      omem:
>         free(ctx1);
>         free(ctx2);
> +       ERR(handle, "could not check if mls context %s contains %s",
> +           mls1, mls2);
>         return STATUS_ERR;
>  }
>
> --
> 2.47.0
>
>
