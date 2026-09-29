Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30883D3008
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696339; cv=pass; b=QLh0rOvcyAuBPfGcQM/NQF8AYlNsIxTE6qDN5C8jmMeazOQyHs7psbNLrakk2FgKk/rNT0Azysk2Slagn8rtvD1+0BNSHrqzzargZu9GIiwWtXZ7s5bZ+p65l5CPz8SKHiq/P0MvYrZjmLm0BwmjCIbGbO160RVn7a7/8GHBp0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696339; c=relaxed/simple;
	bh=ssO3Jks+u1W0YroEGpdvd3U6Gy7xI4c6iKcqmD9KcYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAie9IfoAYS++rL00W0kDf7MkfCwGTiJaFE3QB45Vep4KpFuYoBbqf0Xt1DOziFBDroxNrZN4sdOEIuxFMoL7CEot5Z7ch5yhUS+suaSQsqEZ9MsYhG5/HgXrrpdSf0h3QknA9ifzybHWpC3jmgMPUy8lgwakUS7O7VnJV0ZVAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjvOi7oo; arc=pass smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjvOi7oo"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ab3fa8a788so10959057b3.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790696336; cv=none;
        d=google.com; s=arc-20260327;
        b=rG/vllb6VjBXHGnlsmdkcxMOsdKbwOSH0fOIKChMvm1HelO9aTAt2ZcCM1Gj8tvQ5U
         ZV9wIruB5WzcEc7Kxelgnv2mg20lczAKBNYzugIZonSEoOtjEIyctmqxGbXurYwYmTfJ
         wlSVAwrnoUYYWPBdbEBp5gM23FTRF0NFosnDeDYDLKD0aOPKWGuUZ4TkmYLG0ju6JPQc
         bFupMzZoof7jJZnf/2g5Du8uIsMW5YyIjjYXg839DYyBJm5b4SrygqwjAqtJIsgvD0ls
         4zwY46dXxnZBJ6llAefpEGGZ5IcIA8YZEzCQBJ5bxsLH+N3kKwA0ecC0wYvbri/Ps2P6
         UGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsMxTjVSTbYpp1y4OQIozIigL5nrKUJeLDACE+qhPsA=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=Y1mO4i7LUcqQz9qs+PyAq0jY7viR9bYwRzk9sOx0im/nh4tnVhqR+D7snZ1d7OCS8P
         X0xJgUPd8zKwPDLnZTjg1Y3JvcjSjYeEpA1q5F73mv3RrYk/dzA2Uor80sTb2yUYsNkQ
         gIe4V4HZjALYYSasRyS2QJMm67dvgMbJ8HPAXbie+s5aEcWRrmqpZSFlK2i8/jR+hInn
         pmlaqZWIZeF+8DxiSgiYyvIPns0HaJaGOqwqJq3m23L/Pq8DxAWESMCPXY8BzeK9yGC5
         5Bmz6pTnu8/mY19huQJ/B6MEunfvyi8RtpKxqSngRa7brVkd1MgMMPZsLXkvcoBi/rGS
         UPCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790696336; x=1791301136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TsMxTjVSTbYpp1y4OQIozIigL5nrKUJeLDACE+qhPsA=;
        b=DjvOi7oo6l3Afi6LTLG0cHBJUPVUp4UoQoCOfddU1tMB2avqjGyOUaEHk/QfmNLy+r
         RvamD+IRZZX00Bo5AYuCoDoVcH6Ev+yvZAoiEFj6dl+Bcjn/iShJMLsiZgxp7Amyt2yN
         TMflbQz6cu9cZrW0xx5Z2TFnPovCBQQL7RWw3rEKIzRtQLfQoOKqW4QAvvYed7DO0+Mo
         J5nrHL03BdsxF7+NNytNcbzeqYjKXsyiL71SY2OQ8+GxOYRu+lJnJP9IVOpNvjAxAzfd
         M5sJNq9iOVCdxlYOFu6ato5R3DuhwQPIclEBLlRb5+iUB6afTqxDxQnuNLM0GEA/0kvt
         t/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696336; x=1791301136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsMxTjVSTbYpp1y4OQIozIigL5nrKUJeLDACE+qhPsA=;
        b=2AjLjBGkyL64yUt0XPtRJ7dXEk0fVfDcjC8TwnUhQ/svVTt57qIE5USCaymeqE5q6J
         A6cvZBdeT4WrJRXo1GPqWVPZ+ToPzanpDTyO9jdOM6nhZmb2EMPXyGg+iMezBDd0lZDM
         v3P4duZJfeL+ZikIMktxOk3PR8yLam597vuTSZ1++Z7QEwU3u1YefDNsSmYlYoD1FtX6
         DYTNJ0IeefUoaNxTokryhDBI2uC3M5pcZ8kvAwvX1WtLPYjM6AbwUy/nQ+TddxCcfb90
         jAmPfmrczD9gtkEG3izba6DHuyszow7FKEzdbUTyvMnaLbF6w6IHjxIG0FyY5W5VB9jS
         o6Wg==
X-Gm-Message-State: AFq9FYIovwtO/exPpAfQ6XlDMhH7Y8W1TIIbRgKpwoaKN1EuUcF+7ajE
	q/swcBORo1pNohjBVszycGn0BkyyAX+8iGIKmZBsFkSyrYcZcYVz2n6J9aL6dwlC6WvQe1PnWkf
	F7GhpjPo9DTRCCVKm+jlEF8UBB7UFocU=
X-Gm-Gg: AYBFou1+DXa2lVGoDyDB5R7KkCo1PHCEanDfbHhZyiPn5lJ27E3zgeH/uqbLcWlzyJm
	KweSVYGQEbJNhxZ37I5hKGLY53WnjpnYndqhAgBSN9ZfybMMjEV32W7xjws0ZRE0YWMzJB09P0I
	L1Awq8sxGc2E9m5eo0mSKlJOotG7drIAnOjWb7b3OfHYuqobv5Yk5ruQn6P2WZlfplhDI42WZX9
	3HdPOjEi59reXA5WnMXgbhV+yJlghSC9oSc2yGlR9O7E2zTh0sE8L5954J0B+/a7k5Ep9DSE41K
	6B/pH6bAs9Vz3c2m9ktZEBGI2oKxdqyzxHtyAeh/nMMNOGTAuRyzE88=
X-Received: by 2002:a05:690c:a196:b0:8ab:36df:344e with SMTP id
 00721157ae682-8ab36df34e1mr14448137b3.91.1790696336483; Tue, 29 Sep 2026
 08:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-11-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-11-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:38:45 -0400
X-Gm-Features: AclHuK9IGL9NG-RejcJ91FVp28ISs4hPRFRcxt5-HlMoNpWp_df1AYyDK-lINpU
Message-ID: <CAEjxPJ4ffZeCStA8vGj5fRVOoNZN0yyFHXVFTBr3gT58FRGBnw@mail.gmail.com>
Subject: Re: [RFC PATCH 12/32] selinux: avoid context string allocation on
 getxattr size query
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For a size-only query of the security.selinux xattr the context string
> is computed, copied and immediately freed.  Pass a NULL buffer to
> security_sid_to_context*() instead, which only computes the length.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
