Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC5B3D7D94
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696284; cv=pass; b=I8OgOsO7wOXfgHE2zhWldBkmX6VE8/L0ZHYSSrwyY0CtuG9JcG0/gXrgJcchgNsV6DGL9jUhBIZa8IB1Dvg3cYrtz6J1RTcUD2sbtT8IyHSOYcMtM4RtGZiljqILakKsD1zvswYBW8ybJdsg8UwHL/tolP8or6ccJ2hjmXGVMx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696284; c=relaxed/simple;
	bh=IhFEcgME49EtnnMHWjU/xiD0ow3rt9d4NLa5r5eB/hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=id8zT7WZw585bpTNk+oFoLO2FWnTgjs49NiUNn8JlPMGGHcKA3niqPHkk7ttXTa6oh/MeH6D/yVPtBY/s3SKL9efY8uaKz2Hjzle6M1AyzBYOC2xaM6reZkPaT8hx9TN9qO2ntQMOknJurlbowjLxWiiEYnggIMxyQYBkEfVujI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8Xxv4qN; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8Xxv4qN"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8961cca9193so62535837b3.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:38:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790696282; cv=none;
        d=google.com; s=arc-20260327;
        b=r8o9SEvT+H3557Sj6IKB2kQeoGcmxzxDzG7ZEZQz3Bh3XQMX22ctnB053ZEpaxq1bp
         EdQlUbuimxlJTyMmCkZl3XARG4Pvk0YG1yvhnjfb4vER6Y1dcIrmPBkG/6zHqdLVh012
         NSy7U8n38DS1EMX3+YtzixfpQPLKzRj+DOn7e4JL+KaXQroQOoQaNNIovn2+xfjicOso
         npMXhAgyrKVEW1feOPQtPBhgM95TOBl+KEBez8kO76Su9UcvqI2iPhPs3VY1n3AnPgb9
         2wpKkAqXP/VgSBti3Z9g4pP2lpU8WYXinE8EpXEvN0y2UYhPEXZqoFKM17EoDbUViNIK
         ZdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IhFEcgME49EtnnMHWjU/xiD0ow3rt9d4NLa5r5eB/hI=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=Ka/apYdl6eTFl5Izms6p5O+bTXlRQix2/o0ixhJK+Xth/d9D9Po95tG3iHFic1XIqG
         hNyhm6lEbqNI6nGft2CL/NVklRyp4A8m4aRbTxl78WXVEAk2NHG99L+XNTYNbUNZqI7w
         M2zYf8q87VetOYWUYk/W+1zdAH4D50p0YVGD2YiDyLAIxBEqzxlTtwA5UiS5qI1uvMpx
         1sGYPeu6pWG+jMigtp5FiNWz+Thhb4aVNPEx1up/qIQ4KbSUrFQ0fQSUf892H8xDk9xT
         AdDC+lIvwNkMg+tHi20ov3rM9Pyouu5M/V9Of19vHij3a6dytNGw36thrzZ7zsMCKa6g
         O7TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790696282; x=1791301082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IhFEcgME49EtnnMHWjU/xiD0ow3rt9d4NLa5r5eB/hI=;
        b=Q8Xxv4qNBUMo3BHaN30vemc9HAdqybv3TI3fXz8UoeQeWZif6kftYWTYcVhmPp5TAH
         t3iEorOrSxpXlblmEY3iK+BLdwPVl92F8kHKB2g+Jo0VCJmo843mLY3lgTwe6M0U9ycb
         U2domtP91yNbbPiWmVEzoDogDzpc5SQ6y5RXQxjGL0ddFm6MKfTr25AnsMpj74QzG8qW
         iLcwSlLyzP0cfCwZ+t89RRz5Y1d8eOJCh0+l8YkVXoCLaJeF3JpkashIfeSpgT1976/g
         WzokGXiScTVoXdTVN+QadWUWib28rrkc3ZIV/ByG+oEyv4Dxtfp4Vmsm6hijQY2dDJHy
         8Wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696282; x=1791301082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IhFEcgME49EtnnMHWjU/xiD0ow3rt9d4NLa5r5eB/hI=;
        b=jjAcw5uXTVkJJNo4Z4YAHTYQp23c/7ZdOX35LO0Wryy8SsPptPLDhGkY0FQ68KsE1A
         9dNTdK0QkaozgpP/zkDdynjWPyphVPAfo5Vy3fjtlHYbCyUEKpaek2uhdqrcAOQDhD2f
         n9bkKNJ+lK5rBX14SoUy3NjrSRNnrOJZl0zIPdfn8vwW2I0o9hOzdx+b4q3CTYT2ZwFX
         kA1+uZTu3Jmnh/yJeBqntYv8Qb6yYjSgPCUkETWwRG2Z1FJ9GfLtGzzhP9uX7Ys9inV5
         iW88jkCKMhOk85PtO1P7wUtF8XucG13xBb6Nfe6VZjOU3pabIrKiXnpX+y162+LQSvQT
         bUaQ==
X-Gm-Message-State: AFq9FYImTGNAL49onu/bqM2ZRQSBiod8RTEek2DehDl43ewkBf/N4TpZ
	Cht7rPPjeUeL47SDkCkCalVdAy/42KHbhFA0R6jKR1ISAPBTLUaAjTl3w6M/L3VYnAgrhrD8mj/
	o/GiADfYk+w4qpK4tLbahUcPbE3KNLiOqKJqd
X-Gm-Gg: AYBFou25sCoHgfEoM8Cl6WI/bmvlaBCSsf05GIHLkj+8zCtcHnN5T95U4RIKR5BmPXx
	k5hy4B89Hme0AuULe4naAwxB9O/ZP0OWKi94+J9NiE1fvxoMCxyP/ckMn8Ks2ND5o9hFgok9O/y
	LVEZnxHDt+92GCG31QzTcQ515bqCqlrlktrxpgFrrAsJgXZ0XnvU+O9deXUmNla3TwPBhOmX3Z6
	Ig+9MofzmI5yrRriBsAXWe9itFYzXmqUPaGMks8WW9vvOxT2CkfzwaZfWbXi4Q/a1wyepIeNX3G
	mkUOhsbEv+8QAe6rUy6a/2DOgz+qPU4kMS50lOT1MvVoYcy1pkcuT20eeuT4BDnDSg==
X-Received: by 2002:a05:690c:698b:b0:8a9:ab98:3cf6 with SMTP id
 00721157ae682-8a9ab983dddmr44973037b3.1.1790696281978; Tue, 29 Sep 2026
 08:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-10-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-10-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:37:51 -0400
X-Gm-Features: AclHuK8JIpTsUegEhv2zt7hiOHrd6FHwl0NGYH5LSgbX3PK-4vDaBqVSmTNOs8M
Message-ID: <CAEjxPJ4xEnwSyfnfjmC=3042FFC9AF7m67a1WnGRm_fT+rx_Rw@mail.gmail.com>
Subject: Re: [RFC PATCH 11/32] selinux: use file table names to mark selinuxfs
 inodes immutable
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
> Look up the status and policy files via their entries in the
> selinux_files table instead of duplicating the name literals.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Not sure this matters, but:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
