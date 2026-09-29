Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D77E2F7EE4
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696780; cv=pass; b=PRLkgShyj5ymdDybmYX+1dK6ZiH1FW3K3GxkEYgNjtlvADAaIT4gAi02nV0xgbW6WJTxKZkJ8RzuTDttHKq0OGbMRFMWuTD9BttCEGlALXlnnPoGrSI5evNGLQcUUsmnsHKMFr1Y/bO5iyg/ILGqhQRn6mlTdCs3qVd7bqwltvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696780; c=relaxed/simple;
	bh=X6fx0fo9uEOQFBt6LtEpZAZWSOIBTnDBLrtV5H+HADo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5FvQdPEgsVAISVR3wOO2SBY3limUNWhwEtwiRuLUeVHFat/9Nn9bLE4sYTQUW6bDh/wvtECDzmqwewYDOMYGC2/uMeBk8P2gqrGSk/29T5JNNuxoqVBVKkVkHJKE0h/hUNK3BoOpWJgJ3Hw9v+OOE7PSTSL3OqiEl9HJ7q0fmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daxhucvU; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daxhucvU"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a7af43a358so40435307b3.1
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790696778; cv=none;
        d=google.com; s=arc-20260327;
        b=M8cxwwtMkLo3QLzR9uIzC0GKSNX0fl3qG1/ixL58fOK8tFmiY2dWwkEoBtGFlswKzZ
         ZxTD52WcFANHkNDKF9uFlaGfQaivYfDQzNoNsfF9vRLxIFSBJ+UVW1TyYam/U6mfPMcg
         5xIjayYJVTlpH8DoWApyLIlG7hdYHc6qmlvRnE4pUIfws/RkSes7qTK1PNKwUM6iHm7i
         epffwsyhRKlxmu59dWy+ptwmE09z0cyVuDMUZrFeRDipzkh8wFtklD/DK/aXsU6iq6nT
         ZMcf346aeua0QTTPOPYOCpoYDL3AyHMGI8g7Z5o/3XdHKddAi616OA/JBw3JZNpf33C3
         cWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X6fx0fo9uEOQFBt6LtEpZAZWSOIBTnDBLrtV5H+HADo=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=U2xEhjNA53jwYKw74Et5L1rciw0PC70tdh152DPPeMIPHcXI0ikDjUXAdrU0LEQfFT
         FFtv2lxfTYD3V4OThvgfny7YMjZ57fofmXX/AGAHYZpNmzXo6y5BjAmdTTWVO7uMNJj9
         Q1Zcgu11QOrUIg1exI7qGODXTumo5+igMrYX932sR7VS7rwOEDsrN1g8swW0rYxpX9Vb
         uGX4YGH1b9D1xWhgbvEj6Ag38t9nPwA48o2g3PDKNAWe2YzqVE3gZxC2ql02vJzE1ZlI
         xxksaKUKKEPlLK47kUE5rk/abOINyKbY9VYkd58MRa7DrHPoS27xeQ0gVc6iQras/aOv
         bsSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790696778; x=1791301578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X6fx0fo9uEOQFBt6LtEpZAZWSOIBTnDBLrtV5H+HADo=;
        b=daxhucvUiXuOk0tmX+KQgDzXhgv34PEHjibAkZMo+PWAtyh0DnhbP7a81vh0jUglZB
         aYRewCpJ73rXZtPbGM0wRMmDILBVLUUFuH5RanhvIIlQ1KZj9bS6WaJe9N7eBJkb2C29
         hww3TzKLL9EPqieONZBMYyIqDvsSt2k/EIYglboTEFpNFDTxQQT+d1cFd+vjpswPoVkr
         cvXIibaa9viqpYHA6SAsWL1NSyaJCNTQ9U7q6NBR2liLL2XePtCglVRkhpdDfQPt96/q
         tFY8WG4ILqwNP0Uc02NgeFGFkoHY43qLMb5yFA3YuxaIQuxfY3aC2anUOSMr07xsmi5w
         XI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696778; x=1791301578;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X6fx0fo9uEOQFBt6LtEpZAZWSOIBTnDBLrtV5H+HADo=;
        b=2WXCL10pPd6LngM/ZVkgnBkp1lL1GWCU2v2Qq9vRrAmkm0bF7MUaR0aBwqQDrlxCNG
         1fdlp8WE/r2oer8bJz/2fUpcWH0lZsqrJEyQQSxwrKkQdStNOLQCKbgtp6bom4hdSrqo
         OKXiLBuPPk1fCdlETtt3jkOfN/Sv23MmHGONFIjf5phEEfzzgLS7Dy6vhu0fz6kJD4rj
         owpgEPoYX/eI3xG0NZ2KQ6vxlyCpTokSmH/U9t+6ousTpDXryBzXbRoWyhqoMg9v8YQy
         4XHHnNeQIw6YsinSW7n1F5yYyzt2uMyO42Z5PnrYrV80ezv2w28iessLYJfcQpgjhbjs
         /v9g==
X-Gm-Message-State: AFq9FYKmAj8+LK5XkZnz5YIl4TSunMivaBnirHE8lo1kYyrXE2lN99mj
	5pSaSDyU3MJKkpsKAzPOoSosML/hlbCCFrk/YuHToAE4GKRcyafO8yFp/9dD9CB4jDHPP4dT+mD
	CIzIBeWvksiJQU+mOXgC3FWfI73oN8po=
X-Gm-Gg: AYBFou3m55L/xwXV0kKY8mB/0skevdOdMmbI3zh+Kc2iTGqUohDEpAR+TWikHv472FN
	1xnqFKJABqkoZPHTlUR7BVCVvxrStu9g8OyR2kN3rZ9mJg9VF+9BfQdUH7hWA62dI/XbtlfPQzy
	SXVr13nZpUoFAVbuztycgYX2gNJSy2irJhek3DwotKvezIoqzD8XTnt0CC6nRYDZG5p8GG3Mw/v
	aEH9ZM8L/tvvXdbu3Mt/AOR1gNf8/RVk41KOsKiZRHhZDrLATG99cS41rgy9XhElpyjctNKfRvl
	8aZkn/OwU66ZuJCglrhia3fF28Clg2meJUV/pJcsgCiev3LhGMGiBuQ=
X-Received: by 2002:a05:690c:7483:b0:8a7:d419:e27c with SMTP id
 00721157ae682-8a7d419eb3fmr86439967b3.17.1790696778043; Tue, 29 Sep 2026
 08:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-15-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-15-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:46:06 -0400
X-Gm-Features: AclHuK-t66_d8EmHWSrDXqwuwtD4AFJ3Sum9z7DaAgtCe4itB54Uv286ZZLq4HM
Message-ID: <CAEjxPJ6Fz8uK4hK17OG_WcY8j5NAZ1us=_9Sp73bUsVE=m53EA@mail.gmail.com>
Subject: Re: [RFC PATCH 16/32] selinux: drop unused policydb parameter of perm_read()
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
> perm_read() never uses its policydb argument.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
