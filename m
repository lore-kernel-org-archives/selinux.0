Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FD5101F7
	for <selinux@vger.kernel.org>; Fri, 26 Jul 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014694; cv=none; b=AJJCn/mFX4hJ4z/p22oMia1s6sXYZ9H8IEJ43tlbHJmc6mFZHN8aD00Xz2/s5/NuQT8yoEaBM4X2TbBflHZGIrOGynrtR+Q/Db9kCAPlzZPj+Ld/K36Ia5wU9hQkTuGp2jXEmLxK2FLK8YT2Bnv2aRmD757CbJO2F/NJmDD1zO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014694; c=relaxed/simple;
	bh=boE+JkUdvZiF1BNYFyHPbBjT2hwJkbAnDGzC4jUmd4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0BRi6dNOzWWAaZw8gg12feMUzcIsu9dYmsAQyHaH/5tCrgn+l/BWEqHQ0Ly5un8UrLNvDSpkELcHS962290mpXdL5KFPXQB1NjQpHqv9LvyzQSBdRVWez59PAeWDdOa2StT9KM6bzjBzZCfHO7rymjR/CmWq8tfp3mn6BQD1GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmnHIhAo; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmnHIhAo"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso820860a91.3
        for <selinux@vger.kernel.org>; Fri, 26 Jul 2024 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722014692; x=1722619492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afWwaKu2idbPlvn7CW6d2jorcrYSJC9sCbb5lTJXzTY=;
        b=nmnHIhAoQl5HtyFZhVSKHhTNMlj3sM3N8RXQVW5QUVCxn4yVOHLXrPSnsav+3cl1eO
         KA0HdQrUP6a/9BETxiL/azUuLodZqF65tqXFoJP7TnNT5tfm+cuhyYJZqrF9pG6Esfgj
         jj3TvDLYtV/4O2+Dkp3Ppv0+vmx/1YHxCnpCwFk9cKau2+dlhnJ8LvvuSq3f1jQyOBJp
         Ow/Vy59A2WwkK9xqu452yIaoLJQj/3TuCidDSjbsxbms/GMa7DVNYEO5R0ckphmm9VCx
         U9TQTfBKGsvXC8p24eYDbQ3md8j/iDy2oJngHZOEfULVjZjxEB+oHu/l1dUtlG661Y5l
         pJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722014692; x=1722619492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afWwaKu2idbPlvn7CW6d2jorcrYSJC9sCbb5lTJXzTY=;
        b=roLG0qBVGMmPxkMhV560Jgm3BOiCWuV3myfglvXul6NiKaOJQwLlM5+7ZofGcX9puE
         QBoGH4C9qVNiCPDy2Taf9VwyFHpGwmW4Cg7+z2WNYlqkV5aC39CYfwBUH5vXvGFctAiK
         e1+fnJKENs7OabtGdXdBsRLsZ9rXx/Ggv8V5V4ONJFE05f74FyLLEaSGBSzr63iO7Zyj
         KVEtHJJpU+kaz8ibh+U88zG5Nwr1eNi4hiWBffPbB41DwJYO5O+ZsUF6qc2ZIGK7HLL2
         EgAtGSXAFyuuIF6/DMz5rXWKRF49twl4Xfn6nEWxWRq/D65jUY+Ja7SRaMVnfTt9/AaC
         SIpA==
X-Gm-Message-State: AOJu0YzqQIQM3yDrbYrdPf4bGUrmf/ApSnDNrHfkx0LP3DFL6gtCcTsx
	q0iFmW/R8QI6Dsr6GUB+9/vcBERZra8twIRNgs6A9YLV0WIIbmdwXVtE00MVvqBM2dAmA1TJO5j
	bs54MUF9OL3utKIC3RqInPFd36Sqcrw==
X-Google-Smtp-Source: AGHT+IFtd8RtjwV2uTwTFhyKmla2xt4lfi3k3xFoviy8poRYPYCgNrc89tQAoK3w1Nu8XjGQTsRYFJRWx/6ZTGTBBnk=
X-Received: by 2002:a17:90a:c713:b0:2cd:4100:ef17 with SMTP id
 98e67ed59e1d1-2cf7e5d335cmr190262a91.31.1722014692201; Fri, 26 Jul 2024
 10:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4hUc67Ra7vE7z1znGfx=8UqCSFY_OouJ0_mOQW4-qx1Q@mail.gmail.com>
 <20240726160725.1598159-1-vmojzis@redhat.com>
In-Reply-To: <20240726160725.1598159-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 26 Jul 2024 13:24:41 -0400
Message-ID: <CAEjxPJ5BJ7q1xqgcqfUU_50V5N0eXRFCk6cnD=+4tB6GDd45hg@mail.gmail.com>
Subject: Re: [PATCH] libselinux/restorecon: Include <selinux/label.h>
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 12:10=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wr=
ote:
>
> restorecon.h uses types defined in label.h, so it needs to include
> label.h (or code using restorecon.h also needs to include label.h,
> which is not practical).
>
> Fixes:
>   $ make DESTDIR=3D~/obj install > make.out
> In file included from semanage_store.c:39:
> /home/sdsmall/obj/usr/include/selinux/restorecon.h:137:52: error:
> =E2=80=98struct selabel_handle=E2=80=99 declared inside parameter list wi=
ll not be
> visible outside of this definition or declaration [-Werror]
>   137 | extern void selinux_restorecon_set_sehandle(struct
> selabel_handle *hndl);
>       |                                                    ^~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[2]: *** [Makefile:111: semanage_store.o] Error 1
> make[1]: *** [Makefile:15: install] Error 2
> make: *** [Makefile:40: install] Error 1
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> Sorry, did not notice the error since for some reason fedora-rawhide
> build with the patch was successful:
> https://copr.fedorainfracloud.org/coprs/vmojzis/userspace_test/build/7789=
598/
> But I managed to reporoduce it on a fresh system with the command you
> provided.
> I assume you meant label.h instead of handle.h.

Correct, thanks. Probably not a fatal error in the default build.

>  libselinux/include/selinux/restorecon.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include=
/selinux/restorecon.h
> index b10fe684..5be6542c 100644
> --- a/libselinux/include/selinux/restorecon.h
> +++ b/libselinux/include/selinux/restorecon.h
> @@ -1,6 +1,8 @@
>  #ifndef _RESTORECON_H_
>  #define _RESTORECON_H_
>
> +#include <selinux/label.h>
> +
>  #include <sys/types.h>
>  #include <stddef.h>
>  #include <stdarg.h>
> --
> 2.43.0
>
>
