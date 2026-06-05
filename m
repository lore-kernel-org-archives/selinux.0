Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529593E3D92
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672206; cv=pass; b=OIA7l/YZdTWnTBW3StOg+HTQmivbtE47veZA1XiU0bVAGB+aslu3AEVUNPrKauFyvwuLj+1AJxJBqSJk9SMJtn1bOWAdfMC7ZU+hosmvlIk0+0HBRFShBZSNqiSM/7FSz/6TkHTO2g1NB0wAuCtPBWoCmcV3ONXV+jxwc0P4bgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672206; c=relaxed/simple;
	bh=u4GkjQx1Q5TB/HKRG98sQkmrFizD0Ll/AqxjrU97S8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qh4KGhlDjbWEx3wq/xNDp0Eg5TZ2r6kE+G2gMM4a/pe9kqbxdy5REfz2jBpM6pUNniAzKa5qFCCF0h1l+Ap4o/xpGDonxA3OSl5eapEnCjCxJp53cDCvneY5FBRz59zXe7vhvt1c9UUrwDS0RrlcMfHdC9cyXH5aacS49EmlXcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLbGemn0; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLbGemn0"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39677aed4d3so18421221fa.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 08:10:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780672203; cv=none;
        d=google.com; s=arc-20240605;
        b=WYkAyjI0rUeaqLeRykChKdeETK7YcRqrRJroZc6HK1l4Q9THD0bp6axGyFBIG14KH7
         Fa/Df74sRO9rinP77IREix+BHoTcajDMLVNCn1Fla38i3b4HictAlKxC8pbmNFeOIwCL
         zxdgmX9SGNBctE+HmRINBNWOa4rSyQgSqP0rZDR8DDlrNQJJpmgF6Nw3mvZYp0hh+u65
         7ADEyM9ONSsEF3+y1zpkQ5YiNXRamgm0gXwO4SisT9fni62CL7gJufCRakCqVZL5Zj2C
         XAaeBQCRVlvxuP2/OfJ4IE3ZqBHBcxoFfLO/ZDerO1YhIRzlmpzKSPt+DzmpzsAJCA2P
         lbtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SuyNOaJtj4UhRTOkIS3um0I8vLjABBAMHdw8avOg9Sk=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=LdWwKOlf3AR3zzLOVVfjeBwpL7JUUwiTLEICUobQ03slk4qcEVrXs0AcfE1nwg0Q3z
         t9HOVAJMxlUkuKVHXAAJo2fC0PfhwyWBhE6t/1ohD1FZGYees+mIP2jf8IcB6+J/A2x8
         wg9pPaLJSFpGfPQ5ouhpnNJPwhUxuSAxDDLXf5tVfQeHIZG6qPZxvwagZT4UNexrTFv2
         35HRy4/xd/ahOJwOORids3eWJesh3V2vRo7iTQ++ope3LlfhJVcFtpRIF6ZlLWJKxt/l
         E/cJ78EP4kDZTCisfyQATAmTnw4HnCOoQGbjmpJl2a66KU0fLEDhNLzMDSn8g1cd/63U
         WUrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780672203; x=1781277003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuyNOaJtj4UhRTOkIS3um0I8vLjABBAMHdw8avOg9Sk=;
        b=SLbGemn0y8yby5xeU3j0OS8eVynhbdBw451AZZEj9MlvcXfqce63ot0x9NUYw0yJws
         HpRCfw9wmVzxntqXkc51EYlP4SSspczGz4beXQweeAEXskAfDba87JdS4QXlm8Vh7wJV
         WCkCIRcq2byHoU5retzD1qEoS2c/8mmzDL/TyZBoS02alkFoHDXx1tZ8BD/rdjMQbPD6
         c7joXVoafUe/wZL2qBa4u7Dd/HFoPmEAN5iIAXxfnOBV8RUPXfDHvSW/RRRFOatDfnbq
         bDB/jWs54rk2FM96hpmvCSD9qI11PyD5JmrDtmr77jquAXIk80FKAjlM8yY4dM/z5mv0
         zyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780672203; x=1781277003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SuyNOaJtj4UhRTOkIS3um0I8vLjABBAMHdw8avOg9Sk=;
        b=mZca/h4/rpQxRkLb8bQGyI7c/v45k+0bMEX76rcNT976xgoVrSr8sEzHaQ5xzLnf4R
         9Pz/MFqa45GdPfCY4rZGj7ux0jz622AzqvBjb4r+ZVVikd9erdvN+dOaMmbY/ztxPU+M
         fntOTjzrZ5+CVRoasmipL6C6IbDzi7mwI2pUvLYLLLVvs1a7gOHMQd/qc0ZMIdl1/y+m
         28xpQd563pYOe9V0kFkMhJ0Odc4j23pIydD/4SnpdWdmknCcUdnRbkIPAMy+h5dIKeof
         tE1TR1ln1eAVdr6GyHP4SOL77pVBIHIL85XTVRLSVNdf0QeRyc42tXym5bxgfZcQidi1
         EHIA==
X-Gm-Message-State: AOJu0YxZOlfWTHFA5VZn097IleyFm4lCydsvRzcH2KK1clgA3fAKnJNe
	s1FIuVg3z32xQaDlQuOt+/ilVR1d5jju5rMvLxLyMy9hiBuogtTDpsGb/vqZt0K0W7+X0ynxy1N
	P+dMssqp+vcNVJHE0b4iAdkhpOVWIsiA=
X-Gm-Gg: Acq92OH7n6q5PNZbTl0GUMom69VKewnrwXb8KAPDuwcHT1NgN1OhKfKdZnielrTRFiK
	cV7+YVZLZ5EhoSE+OdtylO31pB0prZ18s/UlYWRdsCEApiyLuCjd+Ok9HOU66k2l+gNBuP4iXK4
	Yj6oBxmItyQmh+J9ZnV66We1Qo2oFGwYsEKS9BSbXKdIuu6diJ4wdmUWS5j5nDp7IHvUewJwREU
	6s5ABdg0AJeuOboP3wp+vtgGGXhaOg6t0wE4s8WCO3cnPrKKHQIPH6LXAciqVV+oCFeffC+hJ9I
	ocDbTkn+WBukREA=
X-Received: by 2002:a05:651c:2124:b0:396:7c9c:208b with SMTP id
 38308e7fff4ca-396d09257fbmr13151171fa.7.1780672203368; Fri, 05 Jun 2026
 08:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605130432.273624-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260605130432.273624-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 11:09:52 -0400
X-Gm-Features: AVHnY4L7Y32tiBhF81YPVVol_rpCrvotKOyS-wgD3tbcDNS8SxtmwFxZf6ifnQo
Message-ID: <CAP+JOzQyMFie9s-agWCUz_0uTbPx6dABQDKp2qKz2oEPcOpmZQ@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: genhomedircon: fix STR_COMPARATOR() passed
 to lfind()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 9:04=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> lfind() passes a pointer to the key and a pointer to the current array
> element to the compar() function. The array is group->gr_mem, which is
> char *[], so the second argument is a char**.  STR_COMPARATOR() was
> incorrectly casting it to char * and passing it to strcmp() such that
> the key was being compared to the pointer value and never
> matching. Fix STR_COMPARATOR() to instead dereference the second
> argument and compare the key with the actual username from the
> group->gr_mem array.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

make format doesn't like having a space after a "*", so it wants:
return strcmp((const char *)a, *(const char *const *)b);

Other than that:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/genhomedircon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedir=
con.c
> index 68382b95..d990c535 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -563,7 +563,7 @@ static int USER_CONTEXT_PRED(const char *string)
>
>  static int STR_COMPARATOR(const void *a, const void *b)
>  {
> -       return strcmp((const char *)a, (const char *)b);
> +       return strcmp((const char *)a, *(const char * const *)b);
>  }
>
>  /* make_template
> --
> 2.54.0
>
