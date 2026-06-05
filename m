Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B4B2E764D
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668445; cv=pass; b=pAXxpEtzhdaAUJep2vloByTjU8vbrzIXioe5fBnSFcaIxm/KPI+jAHEuIgURCiExNNryyX/j7606uYrINNu3MV3tL2CP6G4nQahLLJmxJ314AEnhE8/s/81v9XjfGKv3kxI4qYo2ZIh3T00vZAmrFOlU+ngJg8uSJvIF44AiwmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668445; c=relaxed/simple;
	bh=4B3bNVS36DUTc59c7oQYnb6CAeDP1Q6aDRZpc3Th3nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+NncnH58PbilLWTCVnPvp4ZZpSAH/ySpZlCpV2CXt17lHxVyW19q+/8avLqaMlsKn9eNyvEzu5o2oomIYqUhy6XWLaCpyIz6iVccbYagp9o3zKy5fA9LIaROFLraD+LPf2xn5WTGzl5YIo0kreM06MQrD2WyVgeHsVO5/CPNMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0ZxWYUV; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0ZxWYUV"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-396775c26e0so18871571fa.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 07:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780668442; cv=none;
        d=google.com; s=arc-20240605;
        b=jnyFQQ/u1ldp45hLUuv6tnu6hl/zskGjYbe6LObBo6bHB/jEQKPUNdJ3nwNv1HGqnK
         YSYkWQo26hpgMSc6gv2A9RTJHKXQnV+OrwSEXJ2XPKPuQFUYMK39OXSXOKyaS3IUHDd1
         VDxX8sJhsC2eaeT1nWa+If8kr/r7BCBpE8XHNb1DBeQnrqTnbvm6z22QG/EC+mvETps7
         ZjFaC/H+A/xnoObj9cJbJNcxAwsxeO30pdrf5E+Eevt1d8qcf+EXfitBB0EUw9oBztJg
         3zd4t9e9ZdGdBWe8/PuZ878bpHJ4A/iWMfW3ORdNXsmdt2L/kiausC6I205ag8nLVRdc
         z+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s9A9uyUlGEBn6ssMjEZnsDYUQzIpZX6GH0o0EdWLv8s=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=KG6fl0KvDG0G3eAtPNuSU/INEHumrikuTfUUUW6fso0dkpmtD08WYVJ4ocIFBZ5/Al
         YX6rbEsfoOWzdj1a+FPbuUMYeS01IH9H2xP1y8UQg/CqlYRJZQqoQUk5dkWCvnIE6sBu
         gnt6HEOoh77UQ3WiSnZ2/4gx448AukKV27EmR/n6LPymp8YxPSsMVA2xYO6R3UqRkCfh
         3bgCujqup27k8Xklgt5TOdcV0eqXC7ujWUaUQtpZW9bvjgnq4AY/1o9tGJjY25j4krpD
         8MUPwAzualQLND9lp1iCSByzJbNpIFcs1drDtQuUr6LWAQlZaeahc1RMQtENMJ4yK4fx
         NsAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780668442; x=1781273242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9A9uyUlGEBn6ssMjEZnsDYUQzIpZX6GH0o0EdWLv8s=;
        b=I0ZxWYUVFquAKPRnldEiMT7MvPrSA4qEiLWylf2rDSUdbfAxSrBRPWgmCmx4Mx1gLe
         Rj4gdNjR5YOinJL4+w0/mcE/W0B8ogBCxShpc+q5rbYuRNVngXEaY2BciQ5Bsed7LZRi
         7wcJ8mylDOB+Bczbs4iAsv68Nz0GD0sRqLJsHN3SMOqJeMiEZx1P+Pk37YqoYz4LiOK6
         XrlkpEpm+vLTmc4V3KGukD2dwHIkzGHMeJt0dTWpwz5dOiS+q6oc8sqsHlCsfHxc0sfr
         T5sesj2RRDAnk34WcYgePyxU7+Q0B8ZAemJKcnf7uAanoac0ExP3dg3rkFRM0OSOSQ/M
         WN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780668442; x=1781273242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s9A9uyUlGEBn6ssMjEZnsDYUQzIpZX6GH0o0EdWLv8s=;
        b=sSxjnPZCPCmqC9X355G278lHr61RqWXwaRKVn3GcB6fNk+cJ7gg8wEyK7x9kAWTU6g
         rk4rCi0POh5epf+avNS5g5oCUF+P22WNBaLwAm4w8QeY54pls97tbZiS1VP/pu2ZD6VH
         HFQQstjXCKDFRUA6PO0FpYcJxDum+JPfqq0vDQ9B8x9ULtiu7gENuEev2SbL4OmVmk7k
         muPcnzBUAmoUiFcU0vOYQhFUwYRiswjXmFv8MxUEl/42vOo8SnS8/RBr3014mCm3+yps
         Fuu1uK9yOHxpBAI750wyXpWOphsZm6lZiHGfkLD5bg0NzckjApZ2mdQPNFOhtWmCv6BP
         DTPw==
X-Gm-Message-State: AOJu0YzEtk74nPOltUf1Ur1nOJdwIm/73o/YOBJ1K1V38PbD53d5asuc
	jlC+5FERoqVBU4LZlWv2SxxE3QF+RVQnsX2XQ2umQFbwLDGdsIfHDD5bO6H7/oZC0SnI4wP3OeE
	u6g/k4ECRl/zGFRI2VU1O2Ltmqw8J9cw=
X-Gm-Gg: Acq92OG1HaGZGmwsGQXTocT9Ga4iNljFpQMiuKeGMd3DGbLifQCBrQJ23CZjAMfKGKE
	DoOLDA+2sTv6+snQ3uzYznVH1xSxoJyceFx6PcbqBbZdfyvfkS+QBdiICzvmkJh9Wf4STsh//bA
	z8BWQzQ7mK/Rf8+mSnxqTp6wpmN0b/nnf85nLmnbCYzrNbdHlMHj45FxvZRLSZM3G45SYkq5eU1
	Qm3p6ivgwig+WkfC9WGBJBE7H5jnU1nwYmQgSKveeMousfMGMlcwVObRpkjD7sAFBdVQoF6dcg8
	T5Es96DP06dHzik=
X-Received: by 2002:a2e:a98b:0:b0:396:8ac1:53a7 with SMTP id
 38308e7fff4ca-396d0831aebmr11508881fa.8.1780668442212; Fri, 05 Jun 2026
 07:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604125854.255679-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604125854.255679-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 10:07:11 -0400
X-Gm-Features: AVVi8Ce7DlNrMVi-RIchOi6pG1b2zHcOidg0E2iKZd-QuCqz6tKEv5DD_oWnP4E
Message-ID: <CAP+JOzR8k=u4mcsUudgJEp3=AT3urYuFT3boyEPNO2fWt2psZg@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: fix OOB cleanup in semanage_direct_list()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 8:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On the error path semanage_direct_list() indexes modinfo rather than
> (*modinfo), thereby reading and writing the wrong pointers.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/direct_api.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 6426ab14..9572dbf0 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -2006,12 +2006,11 @@ static int semanage_direct_list(semanage_handle_t=
 *sh,
>
>  cleanup:
>         if (retval < 0) {
> -               for (i =3D 0; i < *num_modules; i++) {
> -                       semanage_module_info_destroy(sh, &(*modinfo[i]));
> -                       modinfo[i] =3D NULL;
> -               }
> +               for (i =3D 0; i < *num_modules; i++)
> +                       semanage_module_info_destroy(sh, &(*modinfo)[i]);
>                 free(*modinfo);
>                 *modinfo =3D NULL;
> +               *num_modules =3D 0;
>         }
>
>         if (!sh->is_in_transaction) {
> --
> 2.54.0
>
