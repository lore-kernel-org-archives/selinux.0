Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC3F3655CF
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681812; cv=pass; b=Ter5qVNhqUB2p7VdOm8De13qeUl0CF/HtkU7EiKDH3MmXGNHTN8af4o0pjeQRDbEoam0Bpp8QqHVNLYFW7v+6WIRDvG+K97jcnmDIQETSYTACu6gSPkHcDgxvN/BeN2uyRI1lyrUjlFYlj0kg/EzKij8dimHA/LJzQLNmiRoASw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681812; c=relaxed/simple;
	bh=f1Q/yl1/LOmPN8H/cN7qP4xoWW7eA7EoH4Hc4Et/5Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBKQtLHGtpLLsLLKyjS5xXONQ9cLmKaLYGUtF8nVr6kt0H4O5+ATXAbPmXmJfD/lAPOXlOoHq6KaFyuEdNtOgY0Wv5RBTyGbMO28BckuzZlZ9S0TccU/4+oa/BcBW6h5ITkNmjvgabUtN3eOZ4N3v+i47f0uKvzM/j+qRXHGh7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB5ojsij; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB5ojsij"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso16428405ad.0
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 10:50:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780681808; cv=none;
        d=google.com; s=arc-20240605;
        b=eRlp6ayrUGXr8PyPXQGOyAIOBMgxR68MzbNnY2jBBNiRNEN8AzVm8owmoGwDM8ENhx
         kxOLFsGkM4ZfvQyQmaa69Pee8bAAn7tuxwZADbSVlbdv5FqxdsTYk6QHQ8HxC5+xhNoq
         5Q0aUPAwgafZ1NGe6265DVG3If1t1A+VuIJM2rWIMmAvzDJNR/cTbnRczyAhQcPfbivQ
         9AsUYlBii1nYN148JpIfZ3frt5A9OyZnrw7ZAx2Em/dR9QrylzcldGtwoWyMWj+9ROE3
         SiM/Eef4e8h6dfGytVrWFdfAO4hMultiTBcWBjeVRR5bgQpR7muoPbabgl9/Ou2TB6xn
         I+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vVuNvMF5LIbALVd06HwUBJL2b63vgfKaZ7hM2uE2ioA=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=aiVQrCvoXFGeNdfBOHTNy9HfJ6f9NJ8aWHdxx06voXib+j7Z4RkgoHQHA1NP6qZt2G
         yyw//XScKbUeyNhkmOkfrD/QVTF1L4YePxnhk+A1r4kpWUlwZQdar6c85qRbWH3np+oB
         gNlZr6Si8vqlg3OmOmXjBVt2zzSKiTWWF1LRWoQtbzOABUvMhn0D6BzK/f8tdun0lxyR
         5iOYy1Esaw4CRGF47mdXgaYl6ovve1t7zUZ9SG3NogNhMhkOqERRQ8bxgyfWhDABK4Z5
         N2KCqYOiM4UMJLrAaONAb8DqtXZqVmG2gdDECCDQL8T80Tl/bvYJvIqlHJhYHyCjQmhP
         RcIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780681808; x=1781286608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVuNvMF5LIbALVd06HwUBJL2b63vgfKaZ7hM2uE2ioA=;
        b=TB5ojsijqNvPc5VEpNRZcu0ocebvFYnzM7SBxlzdSijlNKlx6pVe/N+eCRbJ+vYXnX
         /RmtDoeqlhfvAkvm+O4yhkxuMnxNMDldCo/g9H6eOY46t0RN+PBVt/OxE4icmJi2LjsH
         icQv02zGvBvln8A73G46hfRiC0gndWxgfiSJxtPVwCXJfBq46sj/pYnwtL4qO0kDrx6m
         UwTgraEViV8xEjncseKEfySsi9BpBRB6EVBz5LYpRNtowWdkB1rWPB0PGxf2+GCT/6KD
         vxzbvIIJtqce/IXwLFkPoRLdQoe5lBuP0i+MunizPwkuK+B/8etme+hus70CsQwXdY0B
         RC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681808; x=1781286608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vVuNvMF5LIbALVd06HwUBJL2b63vgfKaZ7hM2uE2ioA=;
        b=SAwfbVgcELJQyd+T7/X5PxQmhAm1Vl0j5MouIwtribHNp+nzJGXY8mMBUCR5mzzLo8
         AmHnjYFipg0shNpoKnp5HYUflt/1ZhJMO794EELYoI+yKx0/sSXBpt/ooDp0YCXNnqFQ
         G7T1sXb2+qpkflW03ta9qEMlTBVOfMS0XaPS2MDnnZ86u/NmDIbz3XTx8NcKRDoWApfU
         uYJXd72VEDe+yMC7CI9EILRgM6QTJTNxnGAY0Ln3mKuggWUbnM/YOaLAvuwXQhdgwZDz
         qdJhD46huIavT47fkJaS/Z8CY6ZDxssvu25/rl+Yw1S433Uzei7mjCATCCIJngjuCS4f
         8p3Q==
X-Gm-Message-State: AOJu0Ywal5ceZPzN6i5J7B6/QrLBIs5FG39rPvRIxzT57BS2PFz8FXjO
	eqIfQTHF94dTS/1ndR7+EEZKUUQoQOeFgsrV8vuMRfojThpKg/9Qg07eCORC7FN5ckCs7C90tJG
	lYZFehi6i9912X9WYznA/E6Z6WaNi5YGA1Q==
X-Gm-Gg: Acq92OHMeQGTxx4ps5d0QL68W/Jeyq1ry6Y0BIRf7hxUXsLc5QXECnFURpNPCGAfEZA
	fmLk3y2Bd5BjlDEXobGyga3DEMGNmH7PUuEb6N/3iLwM4BFskaI3MiUlKz02vhPA2aM1Bn/jDz9
	LHiS6VzijLsTWtCEYyLo3NzELVI5j7BUpYbcpAkqqc90YlsKsozMqZeKxyAbPpu9xdVfWv3rfjP
	8A2fG3pk31IjqaW9GdRBK/NYXf1eFU3RcLmDduskwb3JO7qJggk/gC51jrxeRQFgj0W2seaYKdP
	jkr1N6ngPdybRw47gQ==
X-Received: by 2002:a17:903:4b46:b0:2b2:5314:e96a with SMTP id
 d9443c01a7336-2c1e80fc534mr47938305ad.34.1780681807883; Fri, 05 Jun 2026
 10:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605172207.222382-1-cgoettsche@seltendoof.de> <20260605172207.222382-11-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-11-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 13:49:56 -0400
X-Gm-Features: AVHnY4LCCUm6D_jBLbzV5_wUzPDXl30XjA66MO6d8BKJ1BbcbVZYNHL4biG4iBc
Message-ID: <CAEjxPJ4AfpaRTcDBtLOxdYBsWdooKeT7_8oqq9WY4SwRdn5RdA@mail.gmail.com>
Subject: Re: [PATCH 01/11] libselinux: use size_t for index
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 1:34=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The variable is used as array index and the only caller passes already
> size_t.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/booleans.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> index 4e752424..9ec46ed1 100644
> --- a/libselinux/src/booleans.c
> +++ b/libselinux/src/booleans.c
> @@ -329,9 +329,9 @@ int security_commit_booleans(void)
>                 return -1;
>  }
>
> -static void rollback(SELboolean *boollist, int end)
> +static void rollback(SELboolean *boollist, size_t end)
>  {
> -       int i;
> +       size_t i;
>
>         for (i =3D 0; i < end; i++)
>                 security_set_boolean(
> --
> 2.53.0
>
>
