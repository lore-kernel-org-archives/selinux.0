Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984C4FDA51
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699276; cv=pass; b=qaQPz6TqSmu7rI0VT8iwflXI2l3BovaKPfvRiTUkMp2zk1fWut9xebb+uX2yIY3WLUgtgTlGwUCqBeCpgTtAg4jJIIzN5UsIZ3EyuRRYArD0N8ANdgUvwbbK5G3AW3wIZLsfeVuwDo10mVIu9KNiR4qW3PWW1KH1L/ofMlkzF78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699276; c=relaxed/simple;
	bh=zxy1XJzY6/xzeWKSZAYgWeYKRCum/vM9iGQoQsLTtsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sU0v9+vhm+r4bAJGZp+NwaSqdK92yTCTNgYN/QBPR7/x82laSOFtx9bGX0aFWBf5A1sehAcOUq3n7g1OAhDlj+uO4gvRGTWA1CF2GYyI5ahxg032q974xS8ZmzXOnLTagNMALQElh2e3KE+OczJOfU911UoFB9hpqqJc5InPTQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+I6uUMH; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+I6uUMH"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-895fd505832so39005267b3.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790699274; cv=none;
        d=google.com; s=arc-20260327;
        b=bP2BU3aP0zwFcLvtxu2RTJ+wg8WaHGeQbTaj+eazj4psZAPf5zy2X5J8Q3lK/M2sso
         ISgv7c5ac7bJyez9JAD7CbloYUbMB4Oso1m1uN5XYhbVX4iWKqWxM8B3pb0l3PERFrbV
         uSL+aK0K+iYfWNIKY6vk0Ev7LQvp6oQnWMp0v2ofbuY4PSUwkWHUYtj/XKi3gi6snDqN
         CBazfaH4gxQIKTYeCJOH9yAw5t3Y9xNjEMUoaxaZYtn9j9VwAOKTqammt691xapayV3n
         ikooWbH+edzFeVAt84UCXkhnQXIP+lPgPIlYSoWTd30JGa+FARif2Fh5PyPamRu6eRqE
         iHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zxy1XJzY6/xzeWKSZAYgWeYKRCum/vM9iGQoQsLTtsI=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Zx89uef1tiurjJIkTiN0k6UimMQu1OR5Yc+F8RSbLZdnsuhWAhiGlqC3gnpyZ2rm8r
         z1I3ktb6fRS1JhLiEOrFf2hmkMdUohKt3npJp3VfjYa6UPGOYU2C2Gy38y7GEspKeQd/
         ORTKRUiLALgtNsLV0cV8bCKG87AZePKFP9pE9oS+eH1E6BCub48t6NyM6SvVnv+xRQo+
         YoQdIwlvLUg7ZN9KQMTXFcsy6TuIb1cbcW+owKbaGqWXea2tzisBr8mH3/LF6y2uk4km
         OaQvNy8NE7gZrUybEapuhz4pktGciQuxyTXM9tdjfxaErw/Z2RxqRhdu6ZPvg+Ynn0/T
         oXHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699274; x=1791304074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zxy1XJzY6/xzeWKSZAYgWeYKRCum/vM9iGQoQsLTtsI=;
        b=P+I6uUMHhfAGoOu3YMfnWAxIxuORceClDjCZIPI0yHxhNb5afYqKwTfuoAZeDV/IWu
         dhj8zhN5/uaCgDPIsa6l84070hSpZRIK1hq6HFkpIu5yLnhqngD6M7NjDJpFU/sQu9s3
         sxL4q/OXO/PL62lFtz26mOkV3iFz+JfKdNOlPb/kCEJwqawHccQC7BH4y88xthv3Bpis
         +Jve3UCU0cgTP89xju/7prqZKz+uO5Lc9GsouNJA2EnLf5yR4icVopv3AwUTLFAN2+8S
         /UidiQqyW4kivde82eLvEBzg/AASiPXWZ1cFk3wl6DRc9s5uZE3atNqfK62Gf/1JeFZB
         x7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699274; x=1791304074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zxy1XJzY6/xzeWKSZAYgWeYKRCum/vM9iGQoQsLTtsI=;
        b=XwJ12CBJyG9CtZ3t6XYbN4afMvK3dspFI64PAhMm8njQ+wbRC0g8RLl6iiB0MmrRXh
         C0co0XL4UPPDveVpYED3G6BKApqn7cg2CALg4voZavgL6E4vv5Hsw9vWK67e+Cxv3unG
         2AfRQqEXZYESHiXkZ6/hrsecKnUPiq93b6M9IOjZoGEhtSLJ3o+GTo4Yelx6GhbPhSba
         o6JCID2h3ub5NBuWtm6Z9LOKlHm/SZ0hU2T1r5bJ2SZ4zL5hgRQyNupVT3F5fip5t4+w
         3uFEEouu10YQDbnWeBHlNcq9ARgP3Oqff+NlFC+TH0dSPhCA9cFOyJYHuXi98gdRtY+e
         Bjcg==
X-Gm-Message-State: AFq9FYI8JHxJ7lgwsGKLtSWshLiLuS+UaS/LFcA5YtG1TwGZtPoT5w27
	bZ6SCUvK/OTAFRwQKzZO16uBhdPECq3DukupjsnT0Dp5I2x1SzNDp9FFNdZknZNcTty00QVXkff
	lUbw7hb4EwkkrAzVCynqg3z96s735Tm8=
X-Gm-Gg: AYBFou3avCx0+Kt2i4Gj0nr3GT8YmD40FeeYvPeId4K9cQSjZn6VR5MXLfX2kEC+4LA
	8jZ5fkubPajc7njpTG0wZ2nQXM09t/vgkzI2QBbdWvOifC1VbgaVWvemi8X1u30G5DuJA/AC+8d
	kLKHjsP/BOj4w9SfCE7QJXG8KcObCzNdmSf+r+b9+92aKDMv4O9OFZkBZKKIl9N9kEMK8NWoGjY
	J0xbsFniHZsPWv6MAfVsvel57nZpZkVcshYLb0UMrOjvvxEWeN83Pyg+VYGRi/SMVBJhSjr1anL
	j1Fo0U1jv441BiH3/PQwVAiegwhjhbmT6E9tdnDM0WCDt0jSR6BKIa8=
X-Received: by 2002:a05:690c:7283:b0:8ab:4834:5025 with SMTP id
 00721157ae682-8ab48345995mr7912307b3.32.1790699273689; Tue, 29 Sep 2026
 09:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-10-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-10-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:27:42 -0400
X-Gm-Features: AclHuK_k4pYnPiLvXFEX2oE0f6MXs6RiElTWthvdfMSBLI4_ljXvDv5XsjfG8x0
Message-ID: <CAEjxPJ79DP5OcJ8U4KLi_1LBgFUfEp7nBbgCj=R0M9i3Qbs2Ww@mail.gmail.com>
Subject: Re: [PATCH v2 11/21] tests: enable strictness for perl scripts
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:59=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
