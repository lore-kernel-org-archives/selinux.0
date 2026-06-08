Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24363F164A
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929804; cv=pass; b=qPtJbuPMiPWQcFqtLMusK3MuFsvKCNE1o4dtyFX2UWP3DTKj+yZPLK34mx4swd4yY6ZBQf/foV1zj+VQfERaYa7JK9LYEZUVLL4GU6wV4PE+qXCHHutLEW7iyVt7eFhTPmpkXD3Q8MgAb08Wif5QiKK9TdBeDdIg2YM5AOmYo1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929804; c=relaxed/simple;
	bh=PgDWGBSss4DA7hVwqgTZi8igVkgquI6tHTar3zdANNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8eiyPJRFHFCAvLxyuSq6J0MyNe+eAf8M86NTtPdhON/5dIIGWWnCWh5AAG3NgDKUkvfWEvmPoRf47y+V0534nloVgWtp/9pSWLFM2wFwJls/ImaSS8izOLaKhhqJrL4NpZGE1NkE7X9zQdAP0l9L3GRkps+jvuXGakS0rfIeHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sOr4UoB8; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOr4UoB8"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3966c0d5ac9so42837401fa.2
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 07:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780929798; cv=none;
        d=google.com; s=arc-20240605;
        b=STtwQn439kEGP+qMjIvZfmxvbj381v6Trbd8hBWA3pn32bYSTFi8GclLRvl7ThX52O
         FfuzNNxfCbO3UJII7G/dfbxYX5Ks2eX/vbPzlwq6W/aFFa8KNCerEHk4mB6rkfswcPwI
         SUC1Q8f+tUWcAcCuPY0WORYSML35qL6VgabGY82v+EHYIPndynr0WmpGAg8UIFivhReF
         DLkiwxvQObI6W2uQfomFAUu0jOtqF9SXjntXN1yrLsShRBYFdUPue39oPGYpmZPJJarl
         FNUgmTUopX/TRyAzQk/VeMIo5qLzxYKDsTd2pLRgC8QNPERIutHQYFgdZo5BubXVc0WT
         j58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fPZgcLhux4uZ0BHk/IySiQfhfq0FUym+/CSLNDG6xA8=;
        fh=awiB000zUfMcVGmxycbUbg/UQyVXYNPhajlqBz9gu0k=;
        b=IbFpKPQG0jqwQIMEB5Vp+hAYRmtC0h7HwKoj7qhIVukFi60pLQmameMg31Mlh9bkQ1
         sRJLpOGkUpvrLFCzYPRntXbB8+dCr4lzZ4+qeIZVFt8ITc/h3ZaGjZ1ZggBSWiOiNjo2
         ET0j1uEPD7vbj0KHB0FhYlotZYH+gqO7LsmbptFtld2s9UGlOEp4kalQz6ILmWCCIvIi
         BsbchhFUWkQZdIL7icO+SzGkGO3cYRd4VVfhdfLWKIkZ19xiom8PJMHhKjj3zXPZUi55
         MgZowTe45TaQ99+A1p8UD6NsfA32oU+DvdeGvxs0wmFWKELoP0mqAPK7B+FODpKf6jE5
         UgbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780929798; x=1781534598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPZgcLhux4uZ0BHk/IySiQfhfq0FUym+/CSLNDG6xA8=;
        b=sOr4UoB8VajfnWHmFaYG3gsnMlkPZjHekJpRUnpsHaVz7Px4/fofWtwzfw5jHDEwOO
         yL943y6F1IEToepCFJlZNZcQR1spK3YVv2aoR+wBWM1xcfa+VAimau/6sJ0vZPlrffso
         vq0CKZKicp+bDLqb4KADlfA1gRYHVaHRxib+br39jCeywJ3iSE8P8sU5Y/flO/c+9Y1E
         0VnImqSEEDE3aGZENAsqAIozN8PheR6l9TMqTTVCFhCmJhr9weYZKoTZ5W3NdzumblhO
         sMgGHv8fdacwUBNXQ5/Z4ZgTHgdioOmaBqxKuyO8yo/BGdJJ3zPjd9MLRpNdhOdyuKsM
         3evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780929798; x=1781534598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fPZgcLhux4uZ0BHk/IySiQfhfq0FUym+/CSLNDG6xA8=;
        b=JCIF25kmdFjl08MKeNXuLXPhwYwJE1qvcmGkesQr169KlhmcquZER/9QAzDUAZ9rLc
         ZknaXFPLV1k61Z4emusJ3Q995l/jUoFTM/kPjBZcXKLNOzlO/3xcrPW64YSU9crZtWWz
         1iATUOvKEClyqiMbbCBryuPvEB+zFgeTZnGwuK2RE8VFWoqIAW7DAJOKW4HJgQUreeae
         hOc53n42pgOO8ghlZqMrAnoBSgcDyies1hc0ALv+/U7KOAh4dyA/Pt5klZBkCMIw0wui
         DwRhSDwbnJCtoAPw5+VcPsmilW+/bysnlp/yFel5BLCqrXY4ZfJfjTLSUFX763rUnqhY
         nDag==
X-Gm-Message-State: AOJu0YzyddPkIeMX3x2yJBq8GJF82/aFozCfSAzkK7WJNbASqUtFzI2k
	rZT0FbYNaelRnbvKKXG+5P/KqlCeDnfrhzhazKgqbeoaJKHoogosl5swZvefa//P0bQJjT4a0XE
	3ZuHmYmybZrF6yVFismPn6gAZo/xBYJs=
X-Gm-Gg: Acq92OH9CyeRtw3hSmWBDdw10OCaCogAg7NRyT8EnTg4Ax1DeAWfHqzH6v+R6IOn24o
	bp3d7R1ltrpz9Ro+wCNQBxWozUn9THlMYGHQVvspH765csgrpgji2YSVQ4BmMQJqRY/P/uxPqk9
	3JF1mR3AAGcwc4YWBOKEB20iXMXNHsb7Jntxm7x6HoqT2Hnoz/aNZkvKavr9TD5epUndQ917N/u
	0brtliLUL6DYBQQI4sLHTDhWf9hraM9dpBKQ4qBjZraVTv69Xb9Vv8EHFyLz0EBGNVdD4bkptjS
	QtsSgCUIG25NBWQ=
X-Received: by 2002:a2e:bf01:0:b0:394:635:70b1 with SMTP id
 38308e7fff4ca-396d074cd83mr31747971fa.3.1780929796446; Mon, 08 Jun 2026
 07:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608134720.309839-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260608134720.309839-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 8 Jun 2026 10:43:04 -0400
X-Gm-Features: AVVi8Ce7cysqWlaBo-xFv1oCj7Tr-2bDqpHRSU55h4xBOb88AYoStpK_lKaeN1s
Message-ID: <CAP+JOzTQ-Eyp=-xJz7FKpn_0omJiOWs1tLkzodV+-Yp4AVVcGA@mail.gmail.com>
Subject: Re: [PATCH] libselinux/src/se_linux_internal.c: include stdint.h
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org, 
	Fabrice Fontaine <fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 9:47=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
>
> Include stdint.h to avoid the following uclibc build failure raised
> since version 3.6 and
> https://github.com/SELinuxProject/selinux/commit/cb8289c2b237e5f66e4a7608=
ecc6c68abeaeaf55:
>
> selinux_internal.c: In function 'reallocarray':
> selinux_internal.c:25:29: error: 'SIZE_MAX' undeclared (first use in this=
 function)
>    25 |         if (size && nmemb > SIZE_MAX / size) {
>       |                             ^~~~~~~~
> selinux_internal.c:6:1: note: 'SIZE_MAX' is defined in header '<stdint.h>=
'; did you forget to '#include <stdint.h>'?
>     5 | #include <string.h>
>   +++ |+#include <stdint.h>
>     6 |
> selinux_internal.c:25:29: note: each undeclared identifier is reported on=
ly once for each function it appears in
>    25 |         if (size && nmemb > SIZE_MAX / size) {
>       |                             ^~~~~~~~
>
> Fixes:
>  - http://autobuild.buildroot.org/results/7e627744beaa4f7fdfd488dfacbaafc=
074a999f7
>
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/selinux_internal.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libselinux/src/selinux_internal.c b/libselinux/src/selinux_i=
nternal.c
> index f83ad16a..f82be475 100644
> --- a/libselinux/src/selinux_internal.c
> +++ b/libselinux/src/selinux_internal.c
> @@ -1,6 +1,7 @@
>  #include "selinux_internal.h"
>
>  #include <errno.h>
> +#include <stdint.h>
>  #include <stdlib.h>
>  #include <string.h>
>
> --
> 2.54.0
>
