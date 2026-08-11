Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1CB3C2790
	for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465451; cv=pass; b=Pj2Zn4bbKJY2PvKA9BDZ4c3zICfMcXifGSheo1iuCu1RrhWrU94p6qetFpLBvNnvYLZnj3gR4NHY0mWKWciBYCkO2RONuKhkM0MiJCn3Ww/srQdfeKbhqnV0yq2bP5GEA6iPsvaExRLO859gOKCQlU9tFmGuux1iUYgnLkJ67l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465451; c=relaxed/simple;
	bh=6L60WEECu/1kByE2/lD9bazAleTj/iasviW8aMawhes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pf/I620RB9P3rLP1PE19aN3VJ0OwdywUhP14+nXy0F16//fz9JSbithgZwzkN3B/rrucdZbI6SXHptjEaAWrZJnmosXudWz/+LF5kkIDOsdBHDeRKMFebJBKH6toUYycOsfHULpPjTqpC5MLdRlalrRcF1k4k4yQdK7JsZ1LqWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=so7+MC2o; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="so7+MC2o"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-44cd237446cso1985580fac.1
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 09:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786465449; cv=none;
        d=google.com; s=arc-20260327;
        b=Us1NCwaI59uVN9MvrPD9JwzgV+FVfAMBpg5LxAxyKQUg1WS4Uu6I7tlWl/bNpyogj+
         NTS3OOlZHCOvGj93Xi/qzqjI2HidSgRRf+jmpW39i7axaZlEJvbwktf22Z0adPHokSIC
         eWH5ZyY3pJpaQXTCbR5T95MIg45Xk4Y0GOxYUzEfmkdObMqFQkkEhmQQMBoSROay9W0D
         6Xe+5iyjFaNCMzl2yEfREezIkt06mVtQ3+ZoqpuszjVwcvaPNnlox5Sw9DfYlD94xRfG
         eJ6OSN1hVswJVPr/Y0bld2fhlr4rqP5w7T2ypQSihjb06ZtvACLQUSGX8bRRealkWoZ/
         cwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PLAgoNNkxBYuauxI2zk38O2OZIInY8TcJrBFo6G9HlI=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=ELPiAkWa8UMgwLOcXstfrQRiKa8upVdVTQDG+C60U4R3o96o67fRsS2qhJ8Za4a+jq
         XPhdi/LADpqCkc86R8/CibVDsXK3H1weRrFisJanGzdRS4ZPkByDMC5ez0wTBeZDgjHO
         V6JNSjh9w237DuTOJ0vnqzPvZF3k8R2LUIwAgLaJJCZd0t99lkndcPnOt5rbJFzJqOYu
         LJfTYQHEVZgvqNFY8ZaSNyiscoWpG1BgoWGaLzxjRikAqTLP+IXkJgDBSzEwxU/8RVvW
         eqRyQEV+XbnYnYT7iZ5/prZIuAO9PrZVrcu5anRrgzS7FlMulpQlPY/DR2moN2b85yf/
         YUYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786465449; x=1787070249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PLAgoNNkxBYuauxI2zk38O2OZIInY8TcJrBFo6G9HlI=;
        b=so7+MC2oMlYt7frR91XPiqcOohC5cdoKDFwLuMwUO17Xt4c86+dJgMqgOYxUFhDrg9
         eokOsl8Tnp+QyBPsTH+k+hstvhVa5kTjxrOPZcGLq42TGJ6Zk6CseqXs6Y1Qu4Jht4bs
         ry9xxhs2E18VoRNOp14nfIz6KFtDmg6XT/OSkOd1gOHYPBTmXHN4o/4ecJ9js7KLYduq
         0S8oIC2xaOCKtjUXNHumG9hRhzYaC6KXTeDm0qHqC/e2Sp+HyNAFyybrBYuC/l28eFhp
         5yptCQHp9cbhzlq31CFtwrYiLq/38Hy91dqBUM0DkMY0j7du0+Td1PK0Kjlyrf3ERDL3
         yeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465449; x=1787070249;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PLAgoNNkxBYuauxI2zk38O2OZIInY8TcJrBFo6G9HlI=;
        b=SmINY4KLZBP41KUey42Gbq5+o01fiWp4Esddf0jCN+OQZZiURwmnBlaC33TXELBglr
         QyWfU9dth50+zRzkT7YDYpuzfC/LGIcRTZVemHwe0igSn5MgKqtNgmCXyC1Alh1aDXic
         lF4O+DkamOExSyytAVx1wjvZHhKPHfYMGipVrNuYXPSIzpnT/4bYkXSFo08FA9sWAtpd
         TcFl7hhdO1RAhGJ0vZBHV4LcLO3BKpox7WwjhCPxaemVbp3BAuIMIlGOZ9afhSYhvg++
         V70uykKmCu+cWasFqyPEGGt7NLbSV7zQ18iSWCoNuZy8S51pKT0OcbQiRrcK77rBq5pL
         1CNw==
X-Gm-Message-State: AOJu0Yy3bW33yAcM/TNN2UrrdgsrTDpiQ7Rb7by2QoZ4pcs5viBynWKL
	IqwvPgv5r/UrpI9F8apbEjYSy9HWXGPJAUss56H3ytvu789wzdO1g2oVdZZKkd3oiEpDldtdqMw
	Z6HeCMDaMvLg0XfuS7dMlu/eZCt8LpxHY4g==
X-Gm-Gg: AR+sD12O5BEWoz2AzQtXzhGY06LeoWuTKFBQ+8Spmf6wsy6oGimEJXLVplyhLdzjt0k
	uVA1z/fybraokW715i/D1xLK23t/GxpQ3eX/XnnaFSkWS0j7WRL42EItQqN/TtmY3BeXk4LR6U9
	eZq3bTnI9FvOTFPXM5TomRcUNetOYvjghhc8orRG1FQJkxTxlm48L/vNspHUsooKlUTTt9N3hc8
	lnV1kU/UxUILC41RV/5fUBndLUMyhDtWF7akF4tUiiKMRA22OOnEsiHdMXm/w7zJ9Kp0GLodFmu
	9b+WQlRATezdtW7speSopLu0zy4RTiZX6R0DDo7Bm1hlx3YOSVVbm+s=
X-Received: by 2002:a05:6870:16ed:b0:447:559a:29a0 with SMTP id
 586e51a60fabf-45e20bc8d2cmr2976871fac.0.1786465449113; Tue, 11 Aug 2026
 09:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811151705.109129-1-jwcart2@gmail.com>
In-Reply-To: <20260811151705.109129-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 11 Aug 2026 12:23:58 -0400
X-Gm-Features: AUfX_myMhxyVBqHajW_y0Tsae6Jt-2d70xwk5twVwkHvA0OvFYWfA__xFxi6HJs
Message-ID: <CAEjxPJ6WoOoAFUg03yK2N7FngfhLFU=sDUfitSx5BhGOd=Ls2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: Copy a chain of type alias references
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 11:17=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> For a policy with multiple modules it is possible for there to be
> a chain of type alias references where an alias in one module refers
> to an alias in another module which refers an alias in a third
> module and so on. When expanding a policy with this sort of chain,
> a situation can arise where an alias being copied references an
> alias that has yet to be copied. Since the value of an alias is set
> to the typemap of its primary and the typemap of its primary has not
> been set yet, this alias will end up with an invalid value of 0 and
> return an error.
>
> When copying aliases, skip over aliases that refer to an alias that
> has yet to be copied and keep repeating the copying of aliases until
> none have been skipped or the maximum number of repeats has been
> exceeded.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/src/expand.c | 47 ++++++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 16 deletions(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 466d5bc1..96d7b332 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -39,6 +39,8 @@
>  #include "debug.h"
>  #include "private.h"
>
> +#define MAX_ALIAS_REPEATS 32
> +

Ideally this would be lifted to a header file like private.h shared by
both files.

Otherwise,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
