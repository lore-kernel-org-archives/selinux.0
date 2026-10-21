Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792611540;
	b=Ngi9coL0+2DjAg2qjev3cTpZpeqWldRQzUHGo9jeHKDApLdsad9wakANJO9EHjqtId4T
	 NswB3/Nx3mEbaquUn/STQyyYdCR1TFfQROgEOzNRutw+v5+vTwKVH45ordKrVWe0noqWZ
	 CNx+mamwBScG47G9SonvfaJCFYtNjt7iO4YJ4ntFPmUTqAHcTQf26+xbVhiX8tZw7rY/G
	 6SpyiSP1tXpKtw7McxbnPwFpu5425DywVHrUGw4xkwg9I6IwNhJmHaT4y1m0XNRwbtHtr
	 d+3/DJ+aZz0Drac3owOsxiJCnDsi3KaEV/L1QtDJ7njnfX8SLRxKvOtT6/R2/1j0UuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792611540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding;
	bh=VqAuxGjYkiAGQzctLUidO+3df9NdElbZApqNJPqGCbw=;
	b=TdDURp+Oh/psVwUKj64T0S5LgXUhNIDT7vUyWLO5cgTo7R0kauOQjVlZ47F7YpoG2Wiz
	 tDhPLfMDgk99nZcsi2Y3Xgh+MH8Pjv8oQMWD1cXaOfNBQUu+ZsgxUHjjP2SxW+fKQez7+
	 v3QpJhzDEcOmqK1jzbxTV96RErihXfqkAzl1PNLrXyWdUJEJcd9JUiA2O7wqEyYXJOSI7
	 yPqBSMo9c4lvdhef6TsgRMqhtHm8ooYE8P1Q7oUCBTnR8pTqqlZz9/xZPTWXPx5/4qNm5
	 nTFDxIcXv5cpk23JFwig/khG2e7b3B0s+meYgCSl8PVxnjDjWCJwvwtSBTZfa01t+lQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K7UiaQl1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B63606A319
	for <selinux@vger.kernel.org>; Wed, 21 Oct 2026 19:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74B63606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K7UiaQl1
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67989a98f8bso765058d50.2
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2026 12:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792611539; cv=none;
        d=google.com; s=arc-20260327;
        b=VsAHVApOd1krxqMwgfSXJuWYxN2Gwor21StvxZZGLtIi2ZWn47ZgTT1NZSiCh8xL55
         EigddXd/q5Zz6FyZnoJ/rQSIErSHFP29nWwAeDjePbsPtnvCDcR4fabRskcGFeDCQKsk
         4OlaLPFdhr2K+ekYLnXW0J9txZ+jYvHM+S+NbYSW9D9fgMT9ClJcoeaGwkLZAv5yaOqE
         Jo2sYCPT2CeMkTB0pOkPgNpFGCctg95//XHF96pH7qSallqUJK7mpYKo1L7B15bHQf6g
         xzL5JGjlI+B9GVGA0ANWMza7WSJn4iF8AorYtx2He300RRdhMDTVTJ4KU2dmHu6pFe6u
         zYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VqAuxGjYkiAGQzctLUidO+3df9NdElbZApqNJPqGCbw=;
        fh=oUd6iX6eGfmfzSvqOqHtUAkZ8nq97+hvXuiTZgFFhEY=;
        b=iojYFImYCuPpC87gLuCPRngC2+c7H9plSbhgf+SRchf6wAIvqhYfeDvGv3/gkTyG/J
         i+8Eyf5uI2pQzc9NwAO5Bvb1kUPV3pATVbXno1N3TkDLsGyYnRvuHHqumaTobz1tGEdL
         esRqnXCriXHOFFWtyl23ISAif2IRM7CgR48Sn0aVuuUMXMZpBLsw/N+eldYUNuBpfS8+
         vQllzCYswdftTCLVP3v/AJjl1TXADy0iIYKNqUWUw5xOiusIAqDnkPIWJTA+oT9g6ElJ
         6W/IDBErPNI0YxVktXnWvJJBdnPDAZfEQHQVIOv8VqQH949LtKVJn0D7Hb5hqfFpVN7d
         1d6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792611539; x=1793216339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VqAuxGjYkiAGQzctLUidO+3df9NdElbZApqNJPqGCbw=;
        b=K7UiaQl1sEHCNi9/QX+Y1uuIB4DzsTF6t3Ay8lvMM+yDZx1Pr3uVgOO5oHMNwyTP1A
         OGWYuxDoaW73iFtRIVfyKM0knHIyt7SlwMLKhJexKeDkE7Lw4CAZGqN4+0X7Vh+Z/pF7
         c4kKWS4heFiHxmhxzmXZ9eetTAbyt0208v7Poa020npQKjUnUiyXyHWxrx2ALeLeyET1
         vxw5t/VyaSsncXwscwCm6F/SDS4ra9KbTV+Kwf/gS5t3FLimK/4M18Djk0UHhPW/FnFm
         zBYvfK1trjE5h9plu7upSbM8MDUmpwjbAr8aivG2YW/T4I9QsTAmEGysBh9y1ySB14Cc
         THxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792611539; x=1793216339;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VqAuxGjYkiAGQzctLUidO+3df9NdElbZApqNJPqGCbw=;
        b=fH0aYjrbuTru6Kmjk35rK52hDMqt7kR0zF+a/lbkRC4uvdOHa3UeAbhszsMaeAYx29
         eYihx8gEq4KSD89o1UIcU8HCExGeWnmeqcZsXLiM3RRYn5uEaabjbJNMrCT/9lU4sIh+
         YC6UtLdWP0KM1ERECW7myRv8HM09eKLHfIyOGSS4EUsMy+hAZn9XTZcqTi8Dl6Ij3GkM
         6eFPR5rmvLSmxK3o0dMODzB+3MViVq3BGcgOOLkVi5ChsTP+7YfCi3a0SpFigGeoD+3G
         3PVfUWlUZweEGnzJP4IFP3IkFQl3rYdaqlk3bJzLcQskhtQ9T6kD512oBUC+ZVeZjBEB
         uJ9A==
X-Gm-Message-State: AFq9FYKRX0rU/UY3sLZNVxfC8QOxu5Ll/rbftBJUJJh06t5vl2dFfs25
	a9zHPx4ciEyu1y/BGIGOjCcs+9jApIXXC3fc0z6RRpHGNaIUDEglR1ctHS5/HswgYTaxZnyAhBk
	Sk0vRw/6yGAVE7yytxoOlEgEDUA1DmLNLizM8
X-Gm-Gg: AYBFou1OCcsOnE2CP0rR5IiRXdXCUhWbj9TLopO5NuSWMofiHRUlWQxolRvVfA2NegV
	bYi5eNpDuXSWnXPR5emMrnLeZwYE9CtKnTdQGW2BDQ9M6gJTz63dfVMmCxUCu7k+CIrWKJY79zk
	TcIUW1yxeB7E8SRAtVEYz18Jd8IpQq/5c/Uzg2axyqIuQCynYm2EfV2WgkbgtR3Li6GTnFMKWd0
	85FZlkoAPxuby1qRmamjXJ0YxPRQsSeqwxQjmdS9zWrt9TER/SReeOHJvQcOnDWp8IcMxgxv+Gm
	qPnxfahfzvW8GVtZzOi3qw7l+itAIvOINzGzAR4bvpFiWWDgc6f4LcMPYUzVWGwLJhrynYAmZ8B
	PYNccEYOoupZ8aRjnjqkTlVTyVTafy8DEkqT0+DR1PXWwj8fyPtMfYD1WCswQ0H7IDvp7J6Cffj
	63vgKINU9G5A+tVGeYiXD68w==
X-Received: by 2002:a53:a08c:0:b0:679:abf5:147e with SMTP id
 956f58d0204a3-67a0e585fbamr1107489d50.89.1792611539298; Wed, 21 Oct 2026
 12:38:59 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAEjxPJ4nHQEt1ApaA9Qbt9Y1WQpN1y5PM=Z8mECKhdJL5dYYJQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4nHQEt1ApaA9Qbt9Y1WQpN1y5PM=Z8mECKhdJL5dYYJQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 21 Oct 2026 15:38:48 -0400
X-Gm-Features: AclHuK-Ql1s7dLEDvmaVlgoDqD7YzQnEVaBJweybwAnv9X650MCFbOY_x7xetD4
Message-ID: <CAEjxPJ5XOeMhf_mztdvbVMt9MoV3KmoFDm7-zygko_GULP2Qog@mail.gmail.com>
Subject: Re: Updated SELinux / SE for Android tutorial available
To: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 8:54=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> An updated SELinux / SE for Android tutorial is available and linked
> from https://selinuxproject.github.io/ in Google Slides, OpenDocument,
> PDF, and PowerPoint formats. Note that several slides have notes in
> the Notes section that provide important context for interpreting the
> slide.
>
> The content except for the agency logos is public domain and can be
> freely reused with or without attribution.
>
> Corrections and suggestions for improvement are welcome.

The observant reader will notice that I have a few slides about
writing policy for Android in the Android-specific section, mostly
inherited from an earlier talk I did at Android Builder Summit, that
don't have equivalent slides in the general SELinux section. That's
mostly because my slides on writing policy for refpolicy (beyond mere
audit2allow -R) are even more out of date. Would welcome suggestions
and/or content for that, or if not, eventually I may get around to
reviving those very old slides and updating them too (from my 2010
Introduction to SELinux slides that are also available from the
SELinux userspace wiki under the Historical Talks section).
