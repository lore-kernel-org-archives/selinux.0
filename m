Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF44B04B7
	for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565488; cv=pass; b=kO6IXItQQbTohZmmHlE29W7rurWwlNcwWMCDm/RckYLB+yjhesJTeNhcHgBrBOPmbqhzP55hsrTp35hyzj7MiBYO0y8C2Ro9Y/w8FgCv6SmDa7LRzN7YmaTotTOniegVEko5WStZ/lSmsJJTaJdBh+RvoxQ1CjfLdnp8b0hWnQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565488; c=relaxed/simple;
	bh=rXXNPWHWn5YGWNUhHLD6II/JWW4Alfdn/pn+rCSM3gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwGHELWY6mohGg4l+edE1Ep0UvnYzaHuV1SKn5ifzjBMPECEM42GNrd/BGN6rEEYgH1yAJrCxnmIOUPJgRRQ6MXROiZ+mhFx0lc3hN0u0UIUSjoMLTFd+mrcu2wwr1ceP1FqpENGxQbLzg/BDSnvDM41Z9G7EcDhq0w7L24ZVCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6/4tgOP; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6/4tgOP"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so791089a34.3
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 13:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786565486; cv=none;
        d=google.com; s=arc-20260327;
        b=RqD9cj0tQFDyoVnsNljPN2yo9tO1E4WAMTtFnyjwWY6NNWk64ohYjIkDvWsJ9ZL0GY
         IfE5DjXhaO+qGqQLS2l8KtGBKunddmN7i4JeCbjNiPtkqCmgenb9KNWVDmIi8ynnikGA
         Ho2fkfTb/mjFGCJTdtwiHliUKYFm0AclEak0jVCkpB/GRmzt3aJjOk2EYHRgYWVz+D+p
         Zf90mrzY2YCSzqbhkllcKO6jeYTgsgdsrDZzUuiq7yolL5eApv+NOaK+Vr1BbsLTW4Ls
         G4oGq1RKRyNs6hHN2r5BnwJTEcNNR2jfUF3l+mZQTTMH4KxNIgkOHP6t2kG9+Br3dEUR
         PiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rXXNPWHWn5YGWNUhHLD6II/JWW4Alfdn/pn+rCSM3gM=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=kz/aXlkZA6MO7bEMWGlidiEWLBZbPr/TT8bWEjaW8GuNg2LYbvm02svxU+gzMdidaw
         Ce2GIJZZeqOvJh8g1gmheZn5pAVacg8LTwEfSmNw0tUosAPtB++4o7z8PverMM6zUo3y
         gXCWWSIQRaoStSRssb7GmLir7kuqripcOz5E7TtKCKsEa7rl3ii2PEB0cu/pSAG30pLg
         j8RFVBXvzzpq9I+AWvOT3eIwzoTDeG0w1Um5vkEO+1IWMew2s1p8kUs3gy9kKhUnnTdu
         bVWh0ZPvR6xFvxDfsH9lhuwbqUOepcRPZUrMM4GHHIdPtRMkBuXZpnwTQtnuSoSa94zz
         Hi+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786565486; x=1787170286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rXXNPWHWn5YGWNUhHLD6II/JWW4Alfdn/pn+rCSM3gM=;
        b=D6/4tgOPepgvykRDGe4ud+P1GLISSAiDwqngkVqEBJHVBozXwwPTMjjOR4xTIcufmT
         o4urjzxtheCWyasvKZlvno94MIW4jnOQBpBA4dHkx5Nilx6zsy1AdiM+w2PcPpqG2emt
         rzC5gnJ/J32mL+W9g6ot6brWUN5hpcRQEXAKclSfSDhFZq6Hl96dd9/14Ci1sOUwmR+X
         NnMyau+VshgRWl7qnW+8GTYUafyl8Pq8blyY9MNQh+urCQBYHsFkms77wvmXJZpqFlnY
         oqhSZ/p2CH9YSkIEd3LeASkSxOUMKnFnpX1XFA7E1Zda38Ta7DFDBkZh8TKB477l2nI1
         Kztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786565486; x=1787170286;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rXXNPWHWn5YGWNUhHLD6II/JWW4Alfdn/pn+rCSM3gM=;
        b=hviwmATBiKvfr3kMsNxtu9IOItdzfatxbGV9skGRGBM88MFNOyAgBN8f2rA1xcM4KJ
         HzLmCBanrIbXiJz9Fvofx3r+YfqqsvdTaLyhioCq1jRZkQ3oAj7809Bauj7Hr11erUY7
         GvVCNpgL7f3udoBaDuSlhiR8J/9NW1IE3Iq8ZFZy0UR50OxIw0ie8M6xJpGoKNumlUWi
         UGLtWQCyDKXUTid9Z4XSjy6uQzyXza4zvI6sn8v/SEWuR3Gs5eS+a1Tg/RHa8MyU7lf7
         7fIvmXKS1vOkytf6+T8TUPRJ8TCFXlc6vNZWUegcOAIuVr2nO5w6tcvuujG1LT8OC2gL
         Y21Q==
X-Gm-Message-State: AOJu0Yw2KHY5gtxO8Iv6s54NPhMOfpZHdejGIaDWug6u8pRwceA6VBUX
	pSbKmsBAo39kARoM+kVvd9C1lbIq7rDYDTE0runziNt00z15ybrs6ZoFTm/6uhHWj1B8rWHlkTa
	8XcTpLnf6P8LpmyRrLnJvBV623IglKQg=
X-Gm-Gg: AR+sD12Q00jXABsvkqxj9v8Vdf6ZvVudNnjml94lbUOa8KZTrZP7KVm3ewIwYcpWp86
	YVwvGta2e4EkA1oWtL3jPu+UeYiExdu6m63qivVTUDok5gY0O0moXHll6Z3Dp68A+jSNSIh4yiq
	nM6wOhKJoHcdAKN9iZsuB1qfvEUfI64M6p8X3iQW6UEUP8P85gMPPHe5/G+GahFuVZD6yK74H64
	joFhBLwlnrzR4o7k8D9hEQhW5fRBQ0zFxV9JuUV649k0ws+ZOzrffxl9ffGbRPaB8gMPH3X/BA9
	tXEzx9ZnvIcstjHhirMoWkKlHeNRPL3fI8h/Io77BMQX
X-Received: by 2002:a05:6820:1889:b0:6b0:40f8:4c82 with SMTP id
 006d021491bc7-6b0c45e05e8mr919225eaf.29.1786565486000; Wed, 12 Aug 2026
 13:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812200301.15904-1-jwcart2@gmail.com>
In-Reply-To: <20260812200301.15904-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 12 Aug 2026 16:11:15 -0400
X-Gm-Features: AUfX_myDV17qO6xAN2822YIZZLTVCdiPkywSqKMeSQESEWKgOHNZCdIQ9PZPz1w
Message-ID: <CAEjxPJ4+LKDyDeoiWrsROaDSVQ3X3LXqe9m9z7eh5GJd7V+86g@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Check that a module does not have any commons
 when validating
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 4:03=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Since a common cannot be declared in a module and cannot be
> required, there should not be any commons in a policy module. But
> a maliciously crafted policy could add one which could cause
> problems when processing the module.
>
> Check that a module does not contain any commons when validating
> the module after reading it in and quit with an error if it does.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

and merged.
