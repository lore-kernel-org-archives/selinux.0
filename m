Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF585277C9E
	for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188075; cv=pass; b=cohRanBtIrEBkmStoRwWe6aXOGdnKrPHqQYSE9NKm17tRfoQp55qpwgg7m/p06o+Xwn07t+R+KaPU0bujkrVkFyrLVpxhFKPC5N0Npj8sfoGbg//FO2qWPV3kkCWqstj7zu61FmstpyHKDldPqm/WnZZi4tJb/lIdxyR39QmxhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188075; c=relaxed/simple;
	bh=Sj5PBnItpyWJck7jl3aF4y+xMYqFBsXQHKxouwFkgAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OX7K/VrYGTA+GTcPABVG8WlDhkn3eWfMUfhLMKmU5zd/DShWSl1dlaeNVR2R8Ne72cOEfRa170v4Pyn+LYfGmK5pLMrDRhmDmihh2UOm+Kcqih8j9rStYl91S1m3wHzBFIoULcY4stA7d9zElrjpuuOMdUBepK7Vylxg4gOcJSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuRnaDF3; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuRnaDF3"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38e9653b580so4921391fa.2
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 10:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776188072; cv=none;
        d=google.com; s=arc-20240605;
        b=dJFmVpWoR4TLIOznbTLmWNuHRxmpAjcV6MVdVx8KbquoltOOMXnE80+ASeg9o9M3iH
         23PERANok5S8FokSJzhvyPv9GC4061Th/+bg1Vfd9xkdXUXg6fH4GTDMApLmnQ6JPr0Q
         NoP53o0KDc0DfdPENaBUXGk9ShSDeMsZEHBSlAWoio9EzSjWjBCZawX9QsKT1YYjluhl
         tflJmQ19b3Nwwv5BaLkXPDqyzb44JJrbHo2XPSHvNq9OU8PFIPJIifo4ifsUquhIA0sK
         kXyupXCGgGLznp1wy+U4ig9eJP21L6ASxBRfMpZE/z+SgC97/bQcK0OvAP5s4RKkZ6aN
         MOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tsGj9t3Kjautfb8WHoowBgN8Cp+Wmp0XgxaMTKG9oaE=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=UOMEt3j+pJj43hqPP4SJ0qRjLMr5jE9vF4GDsCwJkifsM8uSI9IbdJl6mJdepvfI5u
         z5e8QYpxIYMgvD0ZTxJdjShyum/HBIt/J6tjYGND+A6jId40rCCoNwCfO7aPb2eQTx32
         SsOzyo+FxUw2mdpABSq6JSRGvp3PRvQRTmNAu2bgQcUrFrQvBi22KOMjNU7xFWY5ufr8
         by5B1e3NWgyd3tJoUXphqCHRSY2qs6J9xbd9SkURkxikCjKmDA8/lUIhr8pVIuDrag03
         wuRuEmlcflzeZD5NzfGXswOfq3tqehsnHr2iGIFywh18dddyp/Xe0CxZkEP92IdX0kw8
         Rqbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776188072; x=1776792872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsGj9t3Kjautfb8WHoowBgN8Cp+Wmp0XgxaMTKG9oaE=;
        b=AuRnaDF35IBPbgpykh+OxXeFlHHs5MdvsZvIOTg8xybEeAAm8q/20x96A5h2VZsdsM
         OvRAM+y8We6fsfSkxmd4sKzRChjVVed15UOVUmRF7HZMIZeWMTgqjBgDjcvt2h2u0cjh
         Kbapo47RtqIKNcwDHRSwa+OaBrabK6uKuKJvGF6N7jilHFaXu1qFl6+hkXNdMB73Z9ac
         blY/FkQBgKLtf/a6BcyzOXvZH3+zamSETZ0OEHAb3TKZkOjHDVnoXxyGqBXwQuN3HDg8
         EOcCAv+z+NxEbDaTCLVsO/mla81sQLC/zYnLVqH8xSdEhH44KFxonTtZhIPGTXEUH3bq
         HmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188072; x=1776792872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tsGj9t3Kjautfb8WHoowBgN8Cp+Wmp0XgxaMTKG9oaE=;
        b=TpLl1xFET0dYsp+ES+pgbM7+Xcglx82irNjGpIMGeW/xUa546LiOCsX1hdA1T4HvK8
         8ZqA1uSTPJvx+dH+PBmZBoBfZs7uHx9CCW0gCslqG1RUuXS/p+kBOYBJNO4IXfO3kzMJ
         oYUxdY4IWvr5pOailQa8OrU1VXDCxv6JlBNKyAVKh6NJfbiQ9K1/m5l8xh8DrM8FzEH9
         GyGAiDsdOd/P9lXxdXfiRoFoheUx6CdfNsqgQCC0KlXQ/AT0kCjwlG1viXfOSgZ0aB7r
         zoGby7IK4gjvZk7E/wYm3etrglnROQPE5G7LBnZbuHiAKrNNf94we1Y0iKuaXt6AkfGO
         fvmQ==
X-Gm-Message-State: AOJu0YzLJIeNz0HDRpcbjo6dFiZ7NeU+QDN+F0l+n9v4rmynPV7sju09
	6MnrxoG8NdTFOPs0LKGJGWj0WS6Y1Oqw69jSihES/0FKge2Mz/Cuq/OOO/ffUBMonjXxHLLPdts
	3ew6H3cLJHDfLytbZj4wojacjh5CYgbfiTw==
X-Gm-Gg: AeBDieuAX5ba7d4DjTA6rrHTahgR6rmLl2+ZVx6GhqhEzZDXPSdFAoOuh1fPimcqnpY
	oJTCg6p8SFFMZhSx3g0xUYRYw3jWaO+sHAxyznn8Vh+fwQiDxK/yK5AxIWXVULp1h0Kr7LZOMse
	uK5hE28MP1cIV/bSIMGg222oZ1tQZgkONVN5zGi10xW1+8cbgnRt9wU3Nvg0qbN+OBqk8Y6r+0N
	jIUoa46ZLOvK62cY7dCChPrV6Nf8kc51r1xF2p1d/qxXBv4khsumNVPjHcucnU1btdV/avXoofI
	HNPM
X-Received: by 2002:a2e:be8b:0:b0:38a:4e7a:c236 with SMTP id
 38308e7fff4ca-38e4be65235mr55962821fa.12.1776188071655; Tue, 14 Apr 2026
 10:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202142404.92347-1-cgoettsche@seltendoof.de>
 <20260202142404.92347-8-cgoettsche@seltendoof.de> <CAP+JOzQJybDw21=q1_NODitUp3v4-MV+3Qzv4ONpqXKE=RaH+w@mail.gmail.com>
In-Reply-To: <CAP+JOzQJybDw21=q1_NODitUp3v4-MV+3Qzv4ONpqXKE=RaH+w@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 14 Apr 2026 13:34:20 -0400
X-Gm-Features: AQROBzDxrBLBZZ9j3wPUewq6--ciHx7r546GTeGZ3tKmllr1NImm7nIeCnjxLdQ
Message-ID: <CAP+JOzRcnjW=8S7rd1_0SgGfyMR=9V2SfYAKmUNhQr=vX-Xa8A@mail.gmail.com>
Subject: Re: [PATCH 1/8] libselinux: drop duplicate include header
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 10:15=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Mon, Feb 2, 2026 at 4:14=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these eight patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These eight patches have been merged.
Thanks,
Jim

> > ---
> >  libselinux/utils/selinux_check_securetty_context.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/libselinux/utils/selinux_check_securetty_context.c b/libse=
linux/utils/selinux_check_securetty_context.c
> > index 5581dde1..0abbdfb9 100644
> > --- a/libselinux/utils/selinux_check_securetty_context.c
> > +++ b/libselinux/utils/selinux_check_securetty_context.c
> > @@ -3,7 +3,6 @@
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <getopt.h>
> > -#include <errno.h>
> >  #include <string.h>
> >  #include <sys/types.h>
> >  #include <sys/stat.h>
> > --
> > 2.51.0
> >
> >
