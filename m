Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793995803;
	b=4nqNiPgGA81jR4MSK/kvMLpSOWgkxdAlr70nW+aJL2dGeThcBDCQ/wRgDzr+3WRvf6h3
	 lC+vax6KvBbxunh2FoHmTtESfPx1yVxAxd6LQxlHfRts1KoT6d5bvL1LEXXz9mq0z+mYf
	 Ix9KesKjNh1ck/5MfERHgKVclnq4abUzC+edmQxEoC4kRF2IfxStR6MpfcxwIrAEMsFqH
	 +lrMPe3DXzXW8xoMXHnHY/Veq8PUFoP3CJIWZ5M5uFINKr+QalxDyTy6d+fRWCYXVwgW5
	 Rl47RvivVEuLLxcgpx+mUQ2VNQdEqTZw4aG9BOxHaOau5fYv6HDzeLY+saFlzEj7qSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=0N2j2ukA0lmsAq4ygbljjup/jJpvK6Da58q1HbVskQs=;
	b=fKF5m9fh9KoANXKvW61Ime/lTD/T5qExiLYJmuciHkbSsy4ns3knieRxcrONsxI9r7jj
	 Lxtb+TTbRsJBuIL6j+ctyCcTknioogpJmZyPCOKCSq2MY9ckWi5DCeGn0xMdSkbXmPvKu
	 YzoUBEfmQy8OwdK1CWGUF3jJh1u7ndGJziDNDpGIBQIiWQfAsUVtlm7DBJTsSHlos1m0c
	 SqstCU264oe4LlhzCroA9nwFLh679CwzoIjC/KMJPS8YDVfUCMYWFtqYsazMyKyaOY3xf
	 5SN+2DlhqraT5mHJ8EUwrMhIo6b5OsBsIkgwxdopLWWlp7Q2PoeBWWTmCL7K68dEuCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w1cTsq3J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AF9606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 20:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1AF9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w1cTsq3J
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67c02c106e6so1113617d50.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 12:10:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793995801; cv=none;
        d=google.com; s=arc-20260327;
        b=PsB6Z/rL3QGv1j5opwVYU9JbCBy+iXsim6cb3arRO4Vbp4o95fKSL8pbrzrAqvW8Os
         cEjZzmFvGya6h+YzukkVTzKujk6AzkZ0XmcB3Mwn5rR341aJZgPW7jt7GSINNrNYykzM
         YBDJBNFpF45sebbgv4J9afGoitqEwUnTF00UKHCsHOD7OC0m+7LhWu9qQmA+V+eLXSFN
         k/kd+FybNgQe6tpSNHyhsEsfxwncvzvTxCebiOQhy2bG2d7Yemj6Xx9YBxwI1R3pwJAk
         nPvLebm6/WG+dnDQl4w7a0yrKZE/grlU/cP706AEkA7NRLknvpSSu3wW8CgH/80tSpQZ
         RGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0N2j2ukA0lmsAq4ygbljjup/jJpvK6Da58q1HbVskQs=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=NQbe1zPj6xG+KfO7TSYzDKaVlk2r/pBVxVVZbVibr3rGeiYOBFSmB7V901lM5cO6vu
         /O8Oa1NqsWnnPAJpame1KAabu+U2IBVIqYbb0LX22AttnLgTtwaZHmQdSqIxFIo8hwli
         g+ZtcS+xqUpuzKaDzerIqhqXeCgCz/oTg8WVv3jyqXDVDgrWmnk53IMqXmmZAkEfsKSu
         M72TKKoEScWtw2rRWVh8KACcClGlhDY+BH0mv0vju2j3rrOgRSCXTi/7SDicVZa/qDmV
         HVv7c3psusdy5R7JFF/DmRzqfzm2ZfgYbACW3FTnzh9QjNL1xm1qw1McjOhxXaZ9YMym
         qITw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793995801; x=1794600601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0N2j2ukA0lmsAq4ygbljjup/jJpvK6Da58q1HbVskQs=;
        b=w1cTsq3JYIqpDABWmoxPKwcn47nBQEnmizY/4o8HisPSdYqk0EAOxioip5I6Mrc3cC
         c32v2uYKVE1Bg45uu1l3MpQfK8h+GzH0K37mjOTbGnR24/b1yUT5ZBWG6ieBm2lrwTii
         ud2Uj7ffkQI2Upt7W1cOvAsNhQ3aAj1En/uCEfnzV79yhy7Qvmf4RCnvUwc2U8D2nMuH
         pWLggj4oAUorOqY4nIKKMnIA8OHHiz86TyrG9rybKNtQU1D9RIW92WXVACbrs6p1/LuH
         xLGsnTmQxK6kukKmPjHf+NTlmZBlaARKh0OK0DOOH6Zg0PH77Mn9BIhbE5A3TAFtjoYx
         oIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793995801; x=1794600601;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0N2j2ukA0lmsAq4ygbljjup/jJpvK6Da58q1HbVskQs=;
        b=b5VhXpk9eODdtrInqi9Z+rPjaVUhrRPMbxkGZsZy3LkxnFYOsctpJm7BWS4ryt8OTU
         IrCOn0shmkR4Z6YNUDTEtpyxmGU2XfRbGAvsRWVbJfMUl97KS5shfvgRJKNe1fxCEtdk
         G7iWFzqzuBi0ZJO/ld9DiWjSXFzCAgFLhvxdVzLCI5oherpWb62v0WnY9MzRrK6q6fnm
         jHok75TcBYQ7NLIowDB4bhG0MGJuH1c1wlduuCajuJ7PsINLjK+74ykrnmeaEVg9M0et
         igb8HMNCmWvoK5xnkSZwWzfRRFKi44bsr8PCEDMgMyTwuG8nSTcG6m41c+6zHBV1m0Pf
         BOZA==
X-Gm-Message-State: APuU4Z92HlGseyK6GY8Qt05t3umKT1bYxxp4KZVidKety8MvgzeFdLjR
	C6T+9ENJNrqJ5nFXy5Clc+iQKfE8Kn0XxLnZSPxCmZXNvmeQ+vBLFuGBvTR+CbF6Uxt9/GuQdHr
	+wpYOXQmujXO+jyhD1GcCfi/xmzav0mpR1sKG
X-Gm-Gg: AYBFou2wxUgLH1rSl34BSKVZAEAcIpp4snCi1pqcOZjTmDD/uXEbFnY/EWJx2ptFGCU
	kmUWtH74xwIQHSQGorXgw9aDS7XH54H0qmfe/DywZnJkU5E8//3IXIcXPNG0Ty7NbLKyJiW1CMi
	Vhsnv0uWOeRb3/DfEnVEkOWu3Avze6307RzRYIGdYLZqqZEhpJ0UeWilB9LFdOpH4IsGiLgsX8/
	asPv3TFvN3bqLY/OQyx9hD1Y/q3076VYt2LXOGgArBStRJuca7g7FOaOb0+Qdlw1MY7QO0GaJWT
	GUM8s1c2eXTGphwoi2p3Jz0pgCB605/jqjYriXnssIH0GYus9g0x/eM9lbnaJtrO6RTVotEfWog
	2dQ/vFOEVXs+JqEyGxF4srM8jhS77kpaxv24w8IDBtnxOqamEQzJoauPZeel8lg2067hkt52P6Z
	OVC377WQO90Beg3lvXsZDlcnmXz/XScQ3Xc5bVVOqySv4lMJ14subwi1FKPUGuuFwze2JAPnGdS
	sJVrgU=
X-Received: by 2002:a05:690e:4011:b0:679:b87d:6f7b with SMTP id
 956f58d0204a3-67c1440da06mr2421990d50.42.1793995801451; Fri, 06 Nov 2026
 12:10:01 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106131652.267648-1-cgoettsche@seltendoof.de> <20261106131652.267648-2-cgoettsche@seltendoof.de>
In-Reply-To: <20261106131652.267648-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 15:09:49 -0500
X-Gm-Features: AclHuK9Tpez4D1nceTN4a2d3-sOqt4Kmccn9lqet3IJv-GqCisZNO9DyQxu15Wc
Message-ID: <CAEjxPJ4ZFQODYcHX2yauU1AKjWd8qqomOt7-Bat1OC7e3wO4aw@mail.gmail.com>
Subject: Re: [PATCH 1/2] python/semanage: fix permissive add with bytes module bindings
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 8:17=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Commit 82c7c876 ("libsemanage: treat module data as bytes in the Python
> bindings") changed the Python signature of semanage_module_install() to
> take the module data as a single bytes-like object, but
> permissiveRecords.add() still passes a str plus an explicit length.
> Every `semanage permissive -a TYPE` therefore fails with:
>
>     TypeError: semanage_module_install() takes 4 arguments but 5 were giv=
en
>
> Pass the CIL text encoded as UTF-8 and drop the length argument.
>
> Add a test that drives permissiveRecords.add()/delete() against a
> private, throw-away policy store, so the call is checked against the
> real bindings without needing root or an SELinux enabled system.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
