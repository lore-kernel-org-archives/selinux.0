Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792430002;
	b=QHoYbgXJ7pBE7YWWiQqz78mk1CZ5HXLThoS2KztHIOg0FdRDEYPRwf/DePik1Mb7qXbJ
	 0L8jVv/kQGVEFH+v4OWg3qr+iSicLQRxCbD21BHidvpuNN9t9aPutnrWHdmweGRBgiEi2
	 +rBH6+wA9imcrJ0vqTGUNsPXzqzAlCd3XEhBFeYczx2nuuNU0OH8fa5Dg/G/XTYbnLpVx
	 coxpdySHqA29jZN3caYp8RxsmTV6BoCAjur7bwqUiZ7RqJ+qzDQVam/Usj+qSyPA0+JhR
	 jydwzHvDph7zQ7GUL0DnmyQ05j6/znkHumAQu5u2HTfFvsRFBWVNN23TfxwcJ5D/3OA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=YKqv0eWmbrC7f3GvGaBacxQY+gCOoBx5sOZ0gF2egWY=;
	b=q2UIx3HAMxYhSvRiMDYnDoAgLLkHlIF8VwiinYx9KH0J27WfVFox9zC9bg1TrV1eBmkl
	 pcx6QXphfI3V6p8Hq/kMPiAC9C3HmkLHqq0xZqD6sGtmxsF1WfXwo4V4XXOLM7jgvxtV4
	 niyrK9wddz4MtY9YgVmZBzCIRPsTfmlw4nbOH5I2iH2Aun5ImBhXrB421FJ+0746bPBzN
	 9k1tcV2fi+xMtRKzGrG3LL8NGYaMUSKDwR/xOEtgSciUibUVvem3G7911Us35oyjuVWjZ
	 DW2YKjU5IiJBfBjp+s8i0oxD2ooxfPHVeJaVcEF0yMgqAnqQ4rIxnDBjl1tzPByDcRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="dBID9X2/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9A3606A31C
	for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 17:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB9A3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dBID9X2/
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6798eb0d13fso1731931d50.0
        for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 10:13:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792430001; cv=none;
        d=google.com; s=arc-20260327;
        b=scKOdHdWNifVQG8Yb9uER2N+mbrwIISIG3T13xLusX0ydil7oGSUWEqiVZstiQkWJ/
         Mon+JpcmEY4hOA6VWs+wxDZnM0ocub+Q1ra6Ls0/2+Hpe+3gEIY+MsfDlkmqr82apDby
         6LGmDhGcepmvcfLzvxW7dtYpg7gS1igft+vTco2kqq25RntMPq9W0jchZSvPTEJ0NV2t
         BU/OBHHLHhiU5HJYamtOa69dsLkJ5au69xhhgX9Lbe4V51PglDKq5sB7xQgaimIf1TyG
         nv4dZCYMDd+TSsjhNPbClGyrZzHQWzQJohU8/qUANnDsViHuy2gYojhZs8J8kAE5F1w3
         F8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YKqv0eWmbrC7f3GvGaBacxQY+gCOoBx5sOZ0gF2egWY=;
        fh=TmcX6VEReUQt9WZtoJjaSyS0EG8H3Pp6isyrMyvcgDQ=;
        b=jINH3ca3GIEAPjHJLZq59VNv6au4DGP1SvCMCtNV9mtfwV9JEJriUX6izHaRbmUP0r
         KnedIRahsgAW/iimC4dKFQXbBgmnlcWw2t2MDCQnAZka4Pcd5e58yGFtXEw0ocBM1Scl
         p1bbsWL27SFBjv7qmMH2CVGGPRQTqRQRaFGrH6vItFgAxFlV69HAI2udRmcwBnK25Ye+
         42ioqBqMFmN+ADkQjLbG1FFZyGvJq9Ne4jpLuHOwN35t7FZkkmZjNS2wy9oHCPHMqgUv
         C+lDtTs8FP+mmBqRPYe10Mqbj91+12ZeHNPg9+0ZMQfgElVulnw90YAPmaQzjuyYI9sT
         6ydQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792430001; x=1793034801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YKqv0eWmbrC7f3GvGaBacxQY+gCOoBx5sOZ0gF2egWY=;
        b=dBID9X2/bLoOi3i6J/Jt1BeFQn2ohqIAOB6boKcmeJNzkbQi+eZDNzc3b5U6MAw6Ll
         /zmUmBRqS6ZGO5YlaLSoYzz1hrgqnsaiwI5Y1vB502XYY8+Tzf/y6kWgU03l7o7cg9wF
         zETbq/RLzhald4H0dhK1hrW9mJbEjIBtU8MAOraMo/0PCsZNcPvspxe1GI2l3X4SPVtQ
         ER6AQ5HaB/eobZo9qqm2A0KsVNzWyKibNYSxce7s7QJeTc/xd+WayMou0glA7W2KXTmN
         k0436nRSowEphG+tm9J9PE8+fjil9l+iwUN88DLrc15tvS3ZBbTvyAZgUlFyo+aYOlZa
         gq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792430001; x=1793034801;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKqv0eWmbrC7f3GvGaBacxQY+gCOoBx5sOZ0gF2egWY=;
        b=SnLDx6VItsQKPe0vwQIZpHUCB2ZzVAGios79A24lfsiat6FwRXWjUTY94XEW416AmM
         oGRkzzWOYjczzTY5xgIJnrWrRDZiNdSY33CFufLHmOcrJz/0O4BzahKVBEJNKMf/wAo7
         OzBCAnNbVtVCHTZgtxP3yEfZBTSF557cjjhNRXTDcEK4M/OSAeyy0UiQp/4yqzqr+j4w
         AYDOEKS9E9VhIO7sk7pK5wnajtpet00LwcmR09pErxSCEowxvk2J2la0Tf+I/uI97KDa
         /v9eV/bxITXpE1Lt8K7F91IqBVm4tHHMtMnbHH352wPT+OIn487Rv4mfmtSFm/1Ayk0D
         dQmQ==
X-Gm-Message-State: AFq9FYIWayfzcL9Cn3Uu6NqFEWrvQ6Qg1ly9Odk7ixZaCNXqsNtPkHWk
	9TO7WouTCpv8NE1uQxeDLbxmxdK1w0dGjxuu8AdtsjyRWzfaGbM+ifdKEW2/qFiqSPD9L8LMcN0
	SJJa8AyNOh0+Gt78D4aYuiy21vBQKNFA=
X-Gm-Gg: AYBFou3Ce7lnnVfIc6JTfT4pbiZy5nAc67oJtBHbX1owY1rtLwrg2TMOhsCz5Bi8swQ
	LKv6afaYPcAaDfcQrPbOGvwLy0fQwfPBlQZU19q3dDt6HIRYCzy263n3YOonQU85ptThlTkX2Oe
	se84wdf9X9VuY80UPvrWfVhskoRC7Inz7/YwM+iyKNyufXXi8+rzfKpJ7qfGxMBwVllJ0sBgGBj
	w/3u1a2L2xlgnCuuD1PMCKDfedepIUCwP+7S+Iv4nblntF4xNRKrdJRfWFSck//zJ7t4EuHvB4L
	EWhYdVEKh/MDn8qQtUPiGYp6fKS2xfEv2K1+2HBUFfX8JJ59vpyP8wI=
X-Received: by 2002:a05:690e:140f:b0:679:a353:7a83 with SMTP id
 956f58d0204a3-679ca7ef9abmr2893861d50.41.1792430000874; Mon, 19 Oct 2026
 10:13:20 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018012909.1795176-1-phugen@redhat.com>
In-Reply-To: <20261018012909.1795176-1-phugen@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 19 Oct 2026 13:13:09 -0400
X-Gm-Features: AclHuK__TWGnKiBYODhsdnRzSNwzaJfMk4osvHFbGmUgLq6kXr51D3TqyWKLK2A
Message-ID: <CAEjxPJ4t=_CDnXYqSf2atEG7WODadR1zKMJVvwXWG5g+zBb0bA@mail.gmail.com>
Subject: Re: [PATCH] tests: fix format string mismatches on s390x/ppc64le
To: Pablo Alessandro Santos Hugen <phugen@redhat.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 9:29=E2=80=AFPM Pablo Alessandro Santos Hugen
<phugen@redhat.com> wrote:
>
> Cast printf arguments to match format specifiers across
> filesystem/statfs_test.c, binder/{binder_common,client,manager,
> service_provider}.c, and perf_event/perf_event.c. Types like
> __fsword_t, binder_uintptr_t, binder_size_t and __s64 differ
> in width across architectures, triggering -Wformat under -Werror.
>
> Fixes: cb49040 ("tests: fail on compiler warnings and enable Wextra")
> Signed-off-by: Pablo Alessandro Santos Hugen <phugen@redhat.com>

This looks like it was prepared against a tree before Ondrej's series lande=
d.
As far as I can tell, all of these fixes are already addressed on the
main branch except for one residual cast that isn't actually needed.
