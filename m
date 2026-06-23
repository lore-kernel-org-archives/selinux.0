Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51718313545
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232875; cv=pass; b=PFAKfTDsDckPJIDRUWtXdvkfKLvX1TkBDl/L8RT1l0F3HS9tQoN2rNSxr/uef+L2up6qQq1APANVrJj9zL+68HlzMWHJZPZE9w730SFTcmqqlrz7w9mYg05Q6cydnbRel+ig7NyruLFBeDxM/ibps+36ww+CjTwUXdRqw8mDrh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232875; c=relaxed/simple;
	bh=U7aj7W2eXQSLQmJP83r3CALNDuBRujUwAoBN6eftLvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+eXiSGBYURMpS1rHSVqfslXnBsh3zB/qqQKMY+ryRMMdauaeNILuzuNTIBfWvdak1INTYcTYJjGSUcle5HWmgGJLYgiSByctXyl/lkTaasiL61uXZUtPZQ4wsOquP+/uRcHWJdla7yEFMoKazG7amlLqFLQLz0f4wwlYPbnt7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/XCG9zH; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/XCG9zH"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c88b8fe9059so380a12.3
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 09:41:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782232873; cv=none;
        d=google.com; s=arc-20240605;
        b=aQddHZcPinu5ljuOSL9NONQa28xGl45bWldO2OJvwnjrl0uvpSxGxJgEhrXw3EFEa7
         8S+QhqzlKZvKRzBfOFDmOlt69OL19dhFFnKK4Uxim0Hs5ZyPgG4oXd23iw05/XjAbG4i
         /Hv82RtaK/f3em0gQPnoJYt/oc3gWNAhnNLXJVzW6MYAtWoZGAAHNsLqgr9mwT99Gmbn
         9aUBM5xFdy8Su8hCuJ3nTmXQ1ByMQopc32tNLvPDQ/Owlr7Cbq2KbGiMwk7PM/Nacoj/
         Ag3MXZQLXn5ISBQ8Zrw0QAvelu6NWZ4ImggbJzrEoRTNuvkz3puCirwv6ClWT0MoGku6
         fAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eusQla9aWczqaRW6w7848yuB99DnTcKj6DnhWyLYths=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=g/YXDngGxDg+20BD72OX3Ibkj+InPGrpDNyVprnsbi1Kw1YTO0nUcwzKr5C/TV6S22
         cx2mR7XiENZdx24x30WraiAkzYRrwrpmHNOgRWvrma1Gi6GsSXBxe8s/vsGzNzJq6t0j
         zXt/ilsbCQfuYiYBy/DW9mR4eUMXV/NtTC/b9orzjxqYKd7EWbRo4YaTYN5LORT0rLmn
         tR3HekZzAzeylbvBAkbejo/B9q34QuB7uxEne5ro4lRrQw89hR6L1pC7teQpiF4AFnPy
         m0u11XX5k5YpcVNE4foRJIvyjJ0dmgGhdDs3xIodjWZwitjDrQm8yR09GxJv44CbI4wK
         zc8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782232873; x=1782837673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eusQla9aWczqaRW6w7848yuB99DnTcKj6DnhWyLYths=;
        b=S/XCG9zH9WAUAQ1BElXW9pi4FQkdMd1P1c+u6tf5VX1ksK5su8dCpI79gJcdFxkqMq
         EJtm4gQ3Jic2UIWUPAcuVHARFDT7ZLCav9Nf5JxnoZFwYKJt9oyNl1DWLSJBJ3Jh91we
         4NNOfQ0Oa9PTVMkLiQRwOLu3sjb3j68n3rL4jIOCU+YinbvskO5HHHffI//Rye0wud7H
         LVVTDnMC7r4VqXiENAOUPSg3B4Cvw41J1TdW2Hgt0OIZZW33ES0UxTc89HvFH3f2/smf
         h9d8L9MjTZ2j9NhLw42+8mQG2Ol5SHEfg1fc1tBuW1MGtH5ZE3QFUuLY8ugF0bOrzJyf
         0D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782232873; x=1782837673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eusQla9aWczqaRW6w7848yuB99DnTcKj6DnhWyLYths=;
        b=juJcBu3E+qt9ZA9zYvWkjUTji8BRCDTnud3IKB+AAg+NlXMaVWlyvOuxRTz8RDmyV2
         wdjcVAqVhhtOZ6EziipInpjXotKxoOyVHLQ3H8dhL2GvhNK18e2QHxRiGo4FQuo/+vCk
         iHjq+FAk3/rEyjg8nNDz2Q7B6q95/0oM6FBKJJmlEjo1C7YEr+15uK0AMVIMBV7k34yc
         BwyhwlPgyOyE9F8C7qM9q9TpVwpdcZy9HjxgmeXHzVTdr528WkM3/OTTAorCTtIzR9VC
         trzKK1D2wb02uGKMnJgjkisj6V7X7VUl87FPWlau5zNQGvFSkWnBbO1JjNhfJB5N2Akn
         oW8g==
X-Gm-Message-State: AOJu0YwVJPBFVWQ/1GV1G62yulH7RKAxbffqb2dfks9gOJiND+FmTwfR
	spR0gjSrNIiVuIgF6kjQualmP8JI7X+RqKXX/Q2xHXAibE+ykFdWax2i/cI43SDtzqK8N9Men9e
	+Mw4RccNLW9O33l8nrD7B7vGtH0EvQenp3jK+
X-Gm-Gg: AfdE7cmx5fdrR/k3mqjfSqco8qs3jPJ0Ldi7df2DT+gPPKCfEHXa3f1FxhWikAZ3hSU
	ATV0izpdKV7ROXsvv5NEInGBAR5F9tApNzWMKLsgYnQNOjpsdcxQXGaM9qCIVFDs8P1P+eMeGsV
	W9NHNBjmotAXsSsVRvH+xp9at3XmFz1ylOpOQPEX/hmFM2KtydznPanuGAucrpaqr/BZG/ZGiYU
	Bz1L9HqltCWUUhgALgCgc4scoIW2aAvayh6uk2GA/N8VyCZqBskmAJX5byUL2ShhjVrX5Nw
X-Received: by 2002:a05:6a21:998c:b0:3a2:d68d:9e78 with SMTP id
 adf61e73a8af0-3bd14ef6ff2mr4607043637.4.1782232873332; Tue, 23 Jun 2026
 09:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623141023.114173-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260623141023.114173-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 12:41:01 -0400
X-Gm-Features: AVVi8CfAVjGcUDEnKjREsLxlPWkg_8-JBIIFfXN0w9L3gv0Wa5EhkS0babUCY2A
Message-ID: <CAEjxPJ6P1VERZ6f5As2-Ndsnf2+MzGJFBy9D9KR3HBD0wBy1iQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] newrole: compare shadow hashes in constant time
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 10:11=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Replace strcmp() with hash_equal(), which ORs byte differences across
> the full stored-hash length so the comparison time is independent of
> where the first mismatch occurs.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/newrole/newrole.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/=
newrole.c
> index 960c8875..ef194efb 100644
> --- a/policycoreutils/newrole/newrole.c
> +++ b/policycoreutils/newrole/newrole.c
> @@ -343,6 +343,22 @@ static void memzero(void *ptr, size_t size)
>         }
>  }
>
> +/* Compare two crypt() strings without an early exit on the first mismat=
ching
> + * byte, so the number of matching leading bytes is not leaked via timin=
g. */
> +static int hash_equal(const char *computed, const char *stored)
> +{
> +       size_t clen =3D strlen(computed);
> +       size_t slen =3D strlen(stored);
> +       volatile unsigned char diff =3D (clen !=3D slen);
> +       size_t i;
> +
> +       for (i =3D 0; i < slen; i++)
> +               diff |=3D (unsigned char)computed[clen ? i % clen : 0] ^
> +                       (unsigned char)stored[i];
> +
> +       return diff =3D=3D 0;
> +}
> +
>  /* authenticate_via_shadow_passwd()
>   *
>   * in:     uname - the calling user's user name
> @@ -388,7 +404,7 @@ static int authenticate_via_shadow_passwd(const char =
*uname)
>                 return 0;
>         }
>
> -       ret =3D !strcmp(encrypted_password_s, p_shadow_line->sp_pwdp);
> +       ret =3D hash_equal(encrypted_password_s, p_shadow_line->sp_pwdp);
>         memzero(encrypted_password_s, strlen(encrypted_password_s));
>         return ret;
>  }
> --
> 2.53.0
>
>
