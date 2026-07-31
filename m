Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA3364EB1
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527212; cv=pass; b=hCkK2c3OqkqeIp1urjExOWPsUUN+8uLRHHBMwUPebAASKvz9o0cpS/hUjvYGp5rLxzNzE8pAXAlEu6WiBffsyM3/ei03gKJ7o7qge1zO2qaozWk8swonzl15eQ4BMbWHaZmqLncDaZANIH9jhwo6jGbpcwI6GkuEUFR6htuc1lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527212; c=relaxed/simple;
	bh=2ybnDkNJyBeqFIu+2AfrW4TzTFyuM2mikAZ6OuZtsmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1YCLtWr3zp2Ogey8s9a5RLBcT2HWXBNOnLjCFvs6n1jO4pfM2d/LS4nyLSdwpLHOwPSzQwr7mhBnlGquMqu8/nxStjQC/QzzWKeIttOQPUZNMZfivMqXY79kk3dwwrU8AGRfwZmqEFNEpXqlcrdQyxR0pEatfFeGZJcZnX+gbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaDYruTe; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaDYruTe"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6aae3e18607so495270eaf.3
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 12:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785527210; cv=none;
        d=google.com; s=arc-20260327;
        b=ahkPTL5lHpqX6HU82TPR/oHohB/OdjSP2zauwQp2tuBgkhnzwWenlkrDi6jWPxj7AS
         9Saef4PXpp3PuWYq/+XenFAIC/3HdmYV8bdEJS7/rF+ABhWVADfIN+u/YyzF8q2IQrJl
         0ruSaXjqDo1wollCdk/ipcWa8/a73l+AUIuH9g+PIxfAVvcaWNw9yoT9bpamsC2bQFHJ
         RAErcWE/DPfghCReNAgKR29VyXI07Q/aq/WhmY2offbJIuAQfAlYQlwnNQLfLoZPHZ1D
         rgZXc8ASl39gQzopoMCt1swE8/+SZr0qH/9Lj//VDLqjA/s5FwduUbhjcxmnRxNQPIoQ
         DT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2ybnDkNJyBeqFIu+2AfrW4TzTFyuM2mikAZ6OuZtsmk=;
        fh=YqmE1l351hGBvnL2vcZMvvL3rhu2MKOuENs6tSG84UY=;
        b=oPhsO8oQaZtwVVaBvO1gbhXlFmz8joofAQHQgPVTw2PE2F5okwIXdP8bRIWqIodVT0
         KniVqFOJVBPsuqhB8DbjnkblLnkAUhqSb7x4qs3v7nOrvvTcldPYG0NGmh1k+GZgy7Oz
         CWsGX7D0wCzDS8IczV7eWdcv9t/TdOViIEpVCd9mpSrMoo6vJEqdUPQ8wTmw1mXi9uhO
         j1+hxvjd9wazg5zfaYOq3kAYPEPLjlYg4sr6YDvBarZVNiPmnAnxKPCUaZ406Ccb5M92
         XkM87J2gRQbObc2iQy7jKJg0KE2vVvzCVnxPGiZ9PJrbLVZuL3XrAOnIUoiM4Repbn8h
         Z5pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785527210; x=1786132010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2ybnDkNJyBeqFIu+2AfrW4TzTFyuM2mikAZ6OuZtsmk=;
        b=kaDYruTeM/noy579BWzJ6pBE9l8S6d8ycypWSbG7YORRGd5P58/kwHAAK78FYWpXp9
         B61WRsFYdOuaV/etitPd4yJi3hFeWnqHQD5LPWy+Ejm4yAGaLVQlWvVVb6EfFvVqs/Cs
         xqWZMUDvKYVcFlx9ecIHJjuC3OOzVmUHK0KCqpFmyjeOIeAjlKApktYX7TKnF1kay17S
         3+TkvwEpTtSXoorZQh1KjtzM2dVYIZNeIOR28eISGlVVV96gR/i5j1ENvAylGFGkP9R3
         3pMUTfOOHYsfZQyGDh52y0/6BPpkzO9H4VDIK4K6sW3gI8kNbqWO2YIbiD1IC6otYTBv
         UYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527210; x=1786132010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ybnDkNJyBeqFIu+2AfrW4TzTFyuM2mikAZ6OuZtsmk=;
        b=YtOjUpy06W4nbMTwFuMVk6EWbz1UYrRlI7GQD6wMwVFB0EmdmOgCPLwZrvFngziwpd
         r7/LQ6pkHooe+uYPQEKu6eRmbBK5EuPelmyb+R+Mo6TIZPQTZipQEoALv/OmVS/EnpAv
         2JQOAULE/IGcAda7xWiWm8CS7M3HeXc6FNVqKsix8f9OR6qWanhfBT9zAqW0jIA2rSDo
         5283JBvqpO0rh9SNnsJgYcTeFd8d306ffKtEzYnIxBf/rCIJjY/1nek0C1t4XsvXoWMu
         1ej7pk5BMUJB9CO4q/lj0cGs5TfIvY1M4/yXrF/8GAptPQKAZPfXDk8rUwL0piV5NQ/E
         NWcQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJ0KcTm7XFUPmRDJbS5i1SoK4EAefOXOj3YYUa2RjSvsmWVl1wdNAVUtZ2I+WaM1rbMiCryGAH@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/NiOj2q8oVxC6rO6Pmsnuq5xl1pzatdUpi2TAouU6G3uVurf
	O7t4vxt11GqSoAX9xdB1Vx+Kz+p7H2BhKaun8tvvayTlFkr/AGYAgIoT3UQnidVl0qabrQwFBIE
	sqJEzfJfxgRPBCbETCBuYZnw7Bs4ELjM=
X-Gm-Gg: AR+sD11HIfGDM9Pt+jfrArFyxJnvNJNdpa9Qx8oRW22wX8s2q51R0a6aDe0/N9He471
	Vkmmc2xyTV6cBR5ZF/fXOPHo3eemHkKnklxlL8+rcZRurVk2fORcL1JgtwWKrAQOcQZfU3xjT+z
	V/NtI6j4lB5zK2pr9jQU5s8X5rm/GDJSChQUThJhrr4eb1mnhssLsN/+ZzHZc/jJskYqL7ql7uM
	yzxTDw51j3Bou+95XyDJoMZ/cVCX8cyKMHXkek3pR7dp3KQkbt5XVYeowBBgdbO/vr4BdwZu511
	izuqvMnEnB3nBY2/0RYdx9skOYyBpcxT8mNUJyPxY93p
X-Received: by 2002:a05:6820:16a9:b0:6a3:92f8:96ab with SMTP id
 006d021491bc7-6ae431a40acmr2424810eaf.1.1785527209829; Fri, 31 Jul 2026
 12:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-b4-disp-d32e997b-v1-0-0341d038ee47@proton.me> <20260731-b4-disp-d32e997b-v1-3-0341d038ee47@proton.me>
In-Reply-To: <20260731-b4-disp-d32e997b-v1-3-0341d038ee47@proton.me>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 31 Jul 2026 15:46:38 -0400
X-Gm-Features: AUfX_mx-tGIrovpBGeQIpoKyhKJ0uqnS7h3eNAho4qUnMJrq5nUcl-FajW9bs0k
Message-ID: <CAEjxPJ42Yfcje5g-6Yv50zL_-tu1fYVo3mRz_VZ7JCRAXntQ1A@mail.gmail.com>
Subject: Re: [PATCH 3/4] selinux: reject an unclaimed class value in security_get_classes()
To: hexlabsecurity@proton.me
Cc: Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <kees@kernel.org>, selinux@vger.kernel.org, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 1:44=E2=80=AFPM Bryam Vargas via B4 Relay
<devnull+hexlabsecurity.proton.me@kernel.org> wrote:
>
> From: Bryam Vargas <hexlabsecurity@proton.me>
>
> security_get_classes() sizes an array by p_classes.nprim and fills it at
> value - 1, so a class value the policy never defines leaves a NULL.
> sel_make_classes() passes every entry to sel_make_dir(), reaching the sam=
e
> d_alloc_name() dereference as the permission array. The class symbol tabl=
e
> is allowed to be sparse (policydb_class_isvalid() exists to absorb that),
> but this getter builds its own array straight from the hash table and has
> no such predicate.
>
> Fail the lookup when a value went unclaimed instead of handing out the
> NULL. Conforming policies define every class they declare and are
> unaffected.
>
> Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes an=
d permissions from the running policy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
