Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69C53B9935
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805294; cv=pass; b=ktdhGMdynpto9gXS0i12ivMMQ0hdTJz1bhZ502AqI0/LUSPftVm8y39dnJlc8xcEF5rj/taLVzCLc9kMQuNZY3OEmDEZmm9GPIQ1Gvw6ia+hE9Z/uQSaTgQtb3AQ1xI7C1lz2r2FCLyMXewVzTrKvt0LEV9ZGnV/kGibbk8nDZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805294; c=relaxed/simple;
	bh=6qhAm//fNkUcypCnObmczJqRUfL1duMSv+PsKMd+Y7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzFAY3m1/UFcJJU121QJRcuz6DAvAxwHgR3Q6229va0PJfjY9Yky6T0oSVsqAvEFSsCJblxdQEMQWWMFMcZ32IWYZ1oUf2DA6igtB029DvnT7zx10yZ3iRyuW1P1G1LMoRWT3M5WIDC5O2pVGwYAb/z2ixsN62xdSPucTh23cL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oSXUUc37; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSXUUc37"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba856db1c0so78110905ad.3
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 07:21:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805292; cv=none;
        d=google.com; s=arc-20240605;
        b=XTCl81KbCG9lfMEJwU7VFwctR1IAYZ0mX3t8SDCFR4hP59567JEez+kPQHXPF2Afo0
         +Maie9lV/DWs6gApxqE4cG/eew6fcL8ewbu0jr8sp0Nykot9dy1SMVSDnWLU60iq+xE5
         TN+Yltas2eOLyrGBiMHclCcloV1l4fhL9rwAuzvVHfhtQlSb2pcCVElYm4KYC0K7YEe1
         lsk8tqfReUHPctko+ww26+jYnbB7dM44poC8DjLCSjMccQr/p/6XF7a+kDofu9Jz199N
         LerjIxSiVgSQJrd2UZEJmSRK3LofEmgf5No560I/A3jSJsB958xeIC7dC5SxB6vPwrvQ
         FoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WQFL4FwlHonQ0btnlwFJ2IVTt9F5NE1qkugBHpcMSyE=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=cjwLAcWZ+ArJrfBmQqgVBERfiLntVHRGd5hPYtRzlrRZTib48tFKKwSP28nxfnF4bx
         Gi0gD9Hv4/e8iThkIh0lGVhVSBJFh60kfS9zi0Bj6/As6/t+nCBmvUVlJGUuBxbDOTPE
         GrbM2TVFgla7LNE7oQkynpb2DHpDlg5oRmEy7Pud4Ls4ijpvCaQcRCMdl1ndSMgeLRWt
         FjpwHhVd4V4Bwtky1Sjfv4u/v3V3zOeknsZUTZQgJ9KvnrqJBeciV3g/PFIG5Kqmunwo
         hSZzBpWLU0EG+NGTmvqdplM+X6aCz3SGRrcek4cXneXvCaCz20C8QrQXfGGyMQ48Sti/
         +rpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779805292; x=1780410092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQFL4FwlHonQ0btnlwFJ2IVTt9F5NE1qkugBHpcMSyE=;
        b=oSXUUc37BfrKG5pVkE6NBNp0JZ5S+VWQWGiFzqd8/rG8jo9vj4xwSohY5X3vahygac
         9rRb2OWolRSMgNFipKnqWeJ4ts4l+ZIRHhy6vDVxc2hS4zTbEF2kyxD7z7y+SGsBSsX9
         EoIVmYVcxiFFrQwXzbeewsuIxNhf6TJEZMeJklfiXsDtaCEHiPOKcTLrOiCHMvXFf30R
         UXN0/wVdIcy8IO2r7FCFQ5f2wcuZf1gV+DTeYPHFlmiK3tiEg8rwoAcXCvIuuuEWD5MM
         1QLKkdzLuiDu1Ml5qRyvpbmOA5KH15o2MPV+Szd8k5+WpjwvehPjbMm0W5Qu6MapUCwJ
         s25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805292; x=1780410092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WQFL4FwlHonQ0btnlwFJ2IVTt9F5NE1qkugBHpcMSyE=;
        b=S61/+kPLk4CCQu8nyLNPGwmiv57prxrLdCflT1HXw6121Dfh7cqjsHol726H1nqVk7
         weY3LZXd6K2QC8+C17I7AVcz5A8a21ClO3uM69HJuDACNSZ9jmbMQy0z2FSNrxldFwCD
         76LbpFFxTw19HGcq5WKn3V1abFL80eGvBYJsJKDhMIAd2nOhkY/9gT7+TOZ1Z5ud0VEf
         QovH8RAiSFJ3zFLfc0/0EQTJLXou3wRmbxJYsLbJJgtlu+y45FzLlGsIJ21vnHkhz6Je
         /Ri+UKmQvElyTRDv0DDE5Rulhw/bLI4zOZ5TKb6DyZ6o2xQmQqISMfCQuFgO1N2OweBY
         H5qQ==
X-Gm-Message-State: AOJu0Yz8EvIHYTNAi7GEu7nUrGxqttuZwz905/gjJj1eoB0kX94PU9pm
	XqgTlICyakrczTRaut6oJcN6RjuaBjydw4LOqCdBP3lLl3m1TvAYKqs5EqT1vsJBdTKxyLdsQR0
	YM7vVo3NhP4Qe3XImrjxtYgTTMKo27xlRiw==
X-Gm-Gg: Acq92OGPgKXIyk8JexINmnvn6z5Kh/BVaerFa6vYgHXEjlP+B5SyNzax1rhPUxHLZV0
	GN4pHnSIwUQWFZABbPQqXoue4FFFf1QPMu7O4oRg1mQjFjSwfS2DS+H80hHLgQo+Kx3X53Nhs2g
	iE+1DpQraWQ3TtPAq5uOSVzLLvCY3/YE8oRps8AsYJbSojGHAXM52APgF0KpNcTdvNU4XZG35Xl
	+woKGdKKq/k0p5j/ECQz2czNJXZu5RyGvOQQY1YWv3HrYhOpJozlX5PkVvmEHXoSi+OtnGq2GS1
	4A/o5n4=
X-Received: by 2002:a17:903:11cf:b0:2b2:4d36:7aa with SMTP id
 d9443c01a7336-2beb076ae28mr207737515ad.35.1779805292334; Tue, 26 May 2026
 07:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521154526.12791-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260521154526.12791-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 26 May 2026 10:21:20 -0400
X-Gm-Features: AVHnY4KOl-03z4JSXsnuhRUAOr9sgiLJh9k-jp4_l7xH4YkjMOW7EYXoiKyEinE
Message-ID: <CAEjxPJ42RZAbU2eZvBQaQZ27iPEO2ukP5rMvxhV+JrN-OA7Ouw@mail.gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: fix undefined behavior for child
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 11:45=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The global child variable is written in main() and read
> by the SIGINT handler. To avoid undefined behavior,
> declare child to be volatile sig_atomic_t so that it
> is async-signal-safe.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged

> ---
>  sandbox/seunshare.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 7a4233fb..1e4c1271 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -63,7 +63,7 @@
>         } while(0)
>
>  static int verbose =3D 0;
> -static int child =3D 0;
> +static volatile sig_atomic_t child =3D 0;
>
>  static capng_select_t cap_set =3D CAPNG_SELECT_CAPS;
>
> @@ -98,7 +98,7 @@ static int drop_privs(uid_t uid)
>   * If the user sends a siginto to seunshare, kill the child's session
>   */
>  static void handler(int sig) {
> -       if (child > 0) kill(-child,sig);
> +       if (child > 0) kill(-(pid_t)child,sig);
>  }
>
>  /**
> --
> 2.54.0
>
