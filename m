Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3177355F41
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681837; cv=pass; b=ctQktKBmD7Xb4OWOmUY+zxnznVTsemLNqOFnfUWtpQWUN+CktTk9w7wVeiEmHhefmqFaglrURF3FASa0b61OrYZ5en5PRVZS9t2onye+CkQfO/F7+TYGKV4Aac6r6gpWuWFoR4ahQApzBOgIuG4bz+OAfwNm/9EyMvj6kMzxPYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681837; c=relaxed/simple;
	bh=7xlV1n5SMZJCWRb9IqBnSEMo6DJJtPzi5pUvpwd6UtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILYk3zc8fy8rB5c49wRgabV0jB2o/85hD1xsBICq0S5I5l91TWpf4DlML6OrRQ23/VXC0iMvkFiO/wJy8nyoM8mTxAp6EIH3EpCTxaZ16nmyrqjBAIxVExOf8eF8ghrRGHG1cCsxV8+MgWtASgPGH5ZnWyXa2FBQbj8oI/ZvoAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkI0RhXP; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkI0RhXP"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36baec934b6so1965893a91.0
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 10:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780681834; cv=none;
        d=google.com; s=arc-20240605;
        b=b3zjDAMRN0wcfnsJh63jovRtcWVYOHDyJd092jIQL4Aw955IyPF8P3xvrCVABZZnrN
         vYUBUKqlG/RrPBf4dKxbf21JJyL1EZPS7D84fWZSsRvQFfCyx+qGohgt75CPFndqEYb9
         z6nk/z1W1RgBnx35OaBNBx+qNJPKBTdCRIdaYIDq8yVwX80gEQX2Fhq/na3GewqEIGEo
         AkxqQeYrHFty8Lf0E0fKJhj9m0kzP+IikGRTto/7LJVYUS2D5KYsFvJDXmw003hOfVXV
         YNCokO4aFlWx9o5i6bfd6J7py1NRztKVxbcdcq0H3CoeQdmmgpGdnH9EsFCVw2qNE5gh
         egyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jbmzo2fMxGLkWAKoGuQOIKACdr9+4D8dIPdVjgVgEdA=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=dRAe+Hns5RuKufL+imCfP2QJOzvB7Qg7McgBI2qowkbpKdvPnxtce8VPxNCqmyILlI
         wKPk02qz2oDWq7VYaOPnwvlpgTI1VkqSS05sM2vv6ZRz9DKLd+908zTQCrjo9ZTqwis5
         Tk931JmRIAD4iSyArcPTDzz7j5hEHSJv3gGiOEjx43uSPzfquEcV3z01hkgfNe/jvV7U
         7AmcTgVReXRLkqiTaijHbWvWU9uXQ4JRrY7ZGx6R6jKBwGiPMFmmeDLnkfGbUXauuUFc
         pshOXDDipx4wvrLZHJR4K64vWm3B3WegJ3OiL5bbuN1fEHa+NEZ6a5mz7PLdQBtGig1G
         3P7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780681834; x=1781286634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbmzo2fMxGLkWAKoGuQOIKACdr9+4D8dIPdVjgVgEdA=;
        b=hkI0RhXPTaaRB8lZXy+dNeLvdjLb5bB5SgWt+Z3hf5wMZHDWSAvb+LBiA2fn4rVn0m
         rkLUtqopSMZwSKz2CDSNei6Wg0ZKCvZGws2v+n/sJLvlEJPKk2CTkkDpIKekjBj4NR1/
         2AFgWN/CfXW5Eg2UUrVLuRgI9h3YkKmv8GwT8eFfGLfjgAOwPMeSuChMa4gYpSu923y8
         ddyHGN+Q+vncJU7YmDCacBDNLlgcxjJAvYw22jHetp1fAuKVPsVWGwLCUxMQEMbMF37n
         nsruB7viCpMNeCETuVbIbBkOArO4/pP5fYyUdgANz2RwTGYIcUYAj8iLFfQY/QU9j26o
         xAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681834; x=1781286634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jbmzo2fMxGLkWAKoGuQOIKACdr9+4D8dIPdVjgVgEdA=;
        b=dutAHGsgiGVvz9pl7EyznJrCtU6qZbCdk6y9BXwD8cghTTXE4jSLtQ1lVlSsuFeZ/X
         xbVdLfPlPY4cBTA4w+dYdyykvHZAcJDnBQPDNbW6taDGGKB9ydsr8+h5ZuIyHucK4W7H
         RpsrLAnCH0E1nmqs4vSz0AJctLul+IvvnOycddiXAuzz1p5bhHnjIHDdt4Q/Q7Ifb0nm
         wUkCJGZsj3oarD8c0nUm2xphTsYKhp7AzS0DsW4opz6WkUyrzAFHTeig/Db78JQW3/Gg
         XfrOgmRKjAIKHN09H9sOjPSfNlDLkusIqUKMMw1S9sjCK9etSgq2k7JTRyfZcEkY1vye
         C8Gw==
X-Gm-Message-State: AOJu0YzYewtjxBBeyDmmPNPHEK4z9s9N0LfWZTVA9GkPOhDc9gtOe+Sc
	2v4q1mCaTigpOtghvtqN/sCTt5m+vP3owXMPpW00c2clU8ku1Dw0bXLXEVbdjIUHsm2RYoUC0eC
	pibFbx4+/FcACmSZBvsbeEn2y8I8kn3quaJvX
X-Gm-Gg: Acq92OGDEd1myfOc3DhEY9RhdvSI3QHOd/vATMa8ZwFNMvqMDyuZ+K+4xAdG6X8AThL
	D9DWqhi4vxFBv+SV3tGVOsEp+ZIjC9hIYkBTqqw0wZOKJiszB7iPlTRkx5gWkDkdvm+j5m/DKDR
	bN9HvSXitfAY5hSPpfSHo6q1cZ4mliALnPOiV+ovxND/LGDk+/DT2iJZmHR/VlkafvvF7EbZ2mq
	f+MmPr4Wqlk9l3yp+fawWp/m04ydS+S7LVlxXDz2J1O2nMR8Ka9VXPgCxdFNHzRcOb943at/MHu
	QdJKkfkKtq9M3YNY0A==
X-Received: by 2002:a17:90b:5285:b0:370:aa94:1662 with SMTP id
 98e67ed59e1d1-371325b7e6cmr3146604a91.9.1780681833752; Fri, 05 Jun 2026
 10:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605172207.222382-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 13:50:22 -0400
X-Gm-Features: AVHnY4IkJf3o8wOErif0z0x2IQdSI1HaGY3u2Iu0VxJ3_wUaH0C48IbCWri96WM
Message-ID: <CAEjxPJ66vcWoi2ZWKtO5CjLR3vZ+-njnR-z2S0YnxR_dFB4FKQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] libselinux: drop trailing returns
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 1:29=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Drop return statements at end of functions returning void.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>


> ---
>  libselinux/src/init.c  | 1 -
>  libselinux/src/regex.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/libselinux/src/init.c b/libselinux/src/init.c
> index 68585d42..499e4e44 100644
> --- a/libselinux/src/init.c
> +++ b/libselinux/src/init.c
> @@ -129,7 +129,6 @@ out:
>         free(buf);
>         if (fp)
>                 fclose(fp);
> -       return;
>  }
>
>  void fini_selinuxmnt(void)
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index 0289a45a..bd7f2188 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -653,5 +653,4 @@ truncated:
>         default:
>                 break;
>         }
> -       return;
>  }
> --
> 2.53.0
>
>
