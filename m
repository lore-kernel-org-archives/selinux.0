Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACE11862A
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226794; cv=pass; b=RDIfnfU7drRrUMKQ4g5Q3iDcKPC/fvJWzBF4vK4GVVHBZpz8ZbadM5cBzRva31nOTE7kdFvTdD1Ri9wBTyfgNoN3/k0E+xWckb2xY6ail/U+GCI15f2RXCR7vmHDZe9/VNjAwsS9pOo2L3cBOzp/VIX6ZxwapLRMogUrQu8ocUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226794; c=relaxed/simple;
	bh=OPExBJA5NMRgLlY39nKv+widpaSKywYcTgs7SQJSUlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoyB+0rQQCZqeu8rwOYYTYEMMzQRicsiwtWSJol7urGDNzF0rZ7eiCOCMnc9ex5pWiQaCvuP61hP0A/Duuc8CBRvG6To5Pau5br86rPjgTvI0J7vrkalbD7aHOtANFz33JjNqpnNFSFcZ0wRVnqnmIfh2yQ5RuI7pJwXH6oKEXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBcj/SB0; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBcj/SB0"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37c867bd3e0so31718a91.0
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 07:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782226793; cv=none;
        d=google.com; s=arc-20240605;
        b=AYG/k1IgtTCd2WhE+jKPH5IGsSJfSgEmucRTA1D4yWQSiLoWEfnL/s8fYh5gQMQLQf
         D5BS8KiRMbSeVs2Iu7+a82tlQYQ21KqS5gzVDdj7JkvV440f4g9F+jWykkc3YajrkDTd
         js46Qv1nwLVk8kKLX3MEcVPd16fvglKt22I+vJt76mSYQu/6FV45fqX87TT6BvYYzbEP
         VpDVsZJFFuCsQoLaQJ0zWRdRRm4njT7H4kcEAnYJCiwqILSHLjT9YSGLE37qmoIt2X4B
         04n+txyDzgo8fEPacKDEfTkBwmTJLSzUHHh2TdD8P3LXrVr7JkNYCtlsMslUkJZLnWg7
         5WIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r/4PJVc90pv3r+luvXihPewXPFjVdFjp4yXR7ocSqfA=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=FmX5JBmvBXmr1kXvG1H/Av0qqjNZZo/XFnmjyryHxPH+79y/C6LztsLVq8M2tRJxJm
         X01KBX1f7Eng86EZykHc952IHrnv+quRkmNTOEr3fpu+irJX61D2DwZh29jzTw4cnjzg
         EF8+ua68DBmb/fC8+IKXmlsVCOHt+puKYRF/3f/loejhdCLOgAx+snthUfLkj2h0wu/g
         YJrNVFU+nzt4vhQDTW6D9UoBhvoC+MBQUldWVVfV3SstBUp7SLKWG1WukoFh6YvW/kan
         cfeLHadE5MFcR0I07IxsEVYPX5SlDULlkeN5UUSL6L/71afa94Lakp9jNavmhIp9ROsG
         xRKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782226793; x=1782831593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/4PJVc90pv3r+luvXihPewXPFjVdFjp4yXR7ocSqfA=;
        b=MBcj/SB0xJLgRXcprSe5wdnmhn1AHTXaNHnip4SumO8G/wwSRZpvv83xNQWHYjb08I
         thEABUr3Ye7+M492HmiMz6QsmMf7NMK4y4OSZqMgsDukuXCgsW4okREP5oiWGfkOslIH
         1prKqEwqO0C/4nJ9k326s/0weanx7EXS+YAJ+9JV8TzIZBYE/PYvbm+LAxK3B5I7LU15
         XBjjZMTN4zeTbbVLhpyR9wm05fqnRfZ8Boh6StBzFT1I7z9yrj4bXR60zwTxf36RqGFq
         0SCagX7uzPl1TtqG0BU0yrnKwyMoGoTJhNkTNMk5U+s03fYZepo589kPDXkAIPiT059c
         uB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226793; x=1782831593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r/4PJVc90pv3r+luvXihPewXPFjVdFjp4yXR7ocSqfA=;
        b=HCWNm65inHY88MsTFe6rKA8o5tIAiet0xVDxfndbk/IcWPX0o4U1lOUeDqqGeRSC3L
         uTHON04t9BcwXBUE9aKGSEiWHXKpePRYnjtvYVF+9OO+5JEm2oLcTjDPFJ3cWJcNz9Nd
         ZXLdTkutjSCJgn5vGnQTnxE8qbHb2LhnJJkCivEkaKATZZqnPDV7+oAJ++1BDWPoRJsV
         4DqmGjz3EUZOxLSfx0IcSEN+KvgsPXwNfhm0Z8BwbHdAK6tF6pczbzMc0PvqZVxpD3l2
         3shJbF9bVKkK/f2dQxgwpViMTe5bhuRRlzBiwPXRHRRnaTL/RgtQnvuwXOCemxyQkSop
         c9DQ==
X-Gm-Message-State: AOJu0YxhjLFY1jxP7sIMCRzM6p9idnTutvOxApMIgru1tJYh3lDgJOla
	m4yNP3UC2i4aOg2Gnt0wpud/DsIgSnjT9qaNN8ChCI3EFr5Al5+G2rdGMbhi30H7jvDALNNuq0h
	9cGfXb5PJwnpMMVWb8g4gXj5R/WoXGpBi9QiU
X-Gm-Gg: AfdE7cn692eMUM/g+ZkHssssfMq71KPElOJJVu7U38caSWemXcSs0HBjSIlwKHZ9Nv/
	x+YDM6piZnzqTrrnB9irG8Zhq1Gs53cpMA69faAtR0QJ6MlKEjldgBQhA5ZZSMugJZxl4Wba+JZ
	d0hmnkWVZX8cZQS0jatf9iCR5BnY/Z3uGmfoDHh5YkCFUr8A3MXwve9gtR+iZyI2nIybChYcSah
	Cl1sdiRJYOgtmPn6bj+E7yNH3bJgremZTwQrG2YWGVvqap9/JxOhPOnp/R5PbNGKuk4qMSe
X-Received: by 2002:a17:90a:d887:b0:367:bc89:546e with SMTP id
 98e67ed59e1d1-37dd173bc9dmr3089901a91.12.1782226792654; Tue, 23 Jun 2026
 07:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-4-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 10:59:40 -0400
X-Gm-Features: AVVi8CclBzSerxBFQxU9pW1rJ6zaR9meG3y3hW3oWSTTOqWCjP87enM2ReGfMaY
Message-ID: <CAEjxPJ5WBJJ9JawjD6JS0UjzmcvxkkA43pwONfoCD-6=pw70nw@mail.gmail.com>
Subject: Re: [PATCH 05/24] libselinux: guard possibly-NULL role/level in
 getdefaultcon -v output
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:43=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> role is NULL unless -r is given, and level can be NULL too; passing
> either to printf("%s") is undefined behavior. Print a "-" placeholder
> when unset so the field stays aligned and no double space is emitted.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/utils/getdefaultcon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/utils/getdefaultcon.c b/libselinux/utils/getdefau=
ltcon.c
> index 38057ad9..a6c780be 100644
> --- a/libselinux/utils/getdefaultcon.c
> +++ b/libselinux/utils/getdefaultcon.c
> @@ -114,7 +114,8 @@ int main(int argc, char **argv)
>
>         if (verbose) {
>                 printf("%s: %s from %s %s %s %s -> %s\n", argv[0], user,
> -                      cur_context, seuser, role, level, usercon);
> +                      cur_context, seuser, role ? role : "-",
> +                      level ? level : "-", usercon);
>         } else {
>                 printf("%s\n", usercon);
>         }
> --
> 2.53.0
>
>
