Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4B36308D
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481427; cv=pass; b=fci5GZz+tqytLGYG6hFPd669bjMP/ShCezwrblr0FREqbi/k9OgUWmN7WnlKVRmhY1Ip83vYqEj9EKr2yTuYbEBgIf69YLHeVjEDNMEAoqlYc5BqJWqEkXwau8jS9xjGngDRIP+8Wsv1/Vv0L4QdMPNDNM9cHIsJiJ8qmDRz0uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481427; c=relaxed/simple;
	bh=njNsomCt3jTWyGvcHXaEVlAdM+ORj7UOlzjxJlCHA6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEmPLoGMPVghlIOiijepoZSo3E7cEZIu+VUCAPzb+xMe1ie5luqYuSLGoMcLTGAqsOgp40HoYyLKUCqvBKoyzRBj7iMi6jZQ3Um9fD9M5sDHPmshWKgxLqmqtHhHGhj2kxoGvAgJhxwv0bJQvsYh4AU3V3w3E+zTtOLreWQXI98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAm7rFY4; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAm7rFY4"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc88a9baso258695fac.1
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 07:10:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789481425; cv=none;
        d=google.com; s=arc-20260327;
        b=QH43R8Y1Pc1m8mSymJ7rXZpj+joI6qEVETSX/HQDntkxW89sW3hVH1lpaSLOtyVtew
         Gyw8CVbaA5gQ+oDdZBkwyvsTUwI27iT6AFULc5XSzGi1RFHeSRHu7O6eHaJ2gighyoFQ
         6Sta8MmZ92Qmxyznu2ZLwYgwKmfYqTa1zO9FOBLsJpFOYJTlc2Sjzv5mDp2621A/LpKS
         I/5lQAYm7cpliGP8lCHpt/JGzBSE0Ni4FHo8NYDQRBnITxzXxtfoK+GSns8DQ241gd0F
         Gjlzfdu+5SBaHyD+8AjC6xChKQuEDP7MJ2KzYh5uwa6u5c5Oq3uUkW3ukgymkBLVifcD
         261g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oYKnJayXClFk/872V9nUCohueVb1da4bs2+ahGF9OxI=;
        fh=N+TNwIyB4OftVo6xWZyGDxf9PNoaOqAOuhaF+GgJBDs=;
        b=cLEGCNe7te+dVdsXWDm3GWy5vS88NzJZHyb66iorDt3suk0boIa7NSBckekVeihXUW
         eKOBQpjvBrIs/Mz99zow18gLr8yRowYUtVeAZaqa+SMQnW9MS9KLX61YcOxWqvoqpXqq
         zkrh9Va8WLuJFTTXDIYr/jhNqC0s6kwccB6pljglMXolZuYXZlJ+S5ko667hXO5CTQ59
         zaGgJrR58zT3hOXWVk11+wL2qii/GW3fvCul4g7MCrq9ZJFo09geIFec2ZsBIc2tS3gq
         eQPj+/Vlas14K7jVhOrQz95V9e/ahGq9dREP5uyGjCX7zPS0ehNC4BVfu4+Kybm0x9Mx
         +H+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789481425; x=1790086225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oYKnJayXClFk/872V9nUCohueVb1da4bs2+ahGF9OxI=;
        b=gAm7rFY4CWw+qyclzdTBvjRy2GT1nfZDEw/yg8GtcLjOx5Ete07mVUDrCFFFScxv9c
         Ne4+5Cp1kAfn/HnzDfYwQj7TqF/Ps+zT4UmJS44IMoSZXv6ptVJMBnKIJGfXsL7z5Gnl
         nd9MX0wiOuc3eHAlSfoKlRT4HubPB/kg0/usQSyuXTz59DB5X4YswaDxMCQqCmXssM8m
         fQsGAhLE5w2S8agNGIFB7ZHH/qi1jIDX7y93eoqtYER5slOgzhGzoJKodNIwe/AbJ65e
         0Gjy/xFs1KezpiSp8LOtidWxMNpKIsKAKDKBCl5UC2UPz1HObr+PVnxAKRMUnMgwDy9Q
         8nMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481425; x=1790086225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oYKnJayXClFk/872V9nUCohueVb1da4bs2+ahGF9OxI=;
        b=BV4Pox4eNtb5UYtcqJKtrLHzxLvAI/yj40KJvpvs2UejW2VMMsFXiwoFn17ogqicJS
         tB0S1IQZcJsP2gKlABHMw2729ZrN7Vim5L2V07iCcxFoqGEvLaQTT8/kp+5a782mXlji
         Iw4ctqhHwKZzvFFl71uUvMH/sd7hYREQD2EDM73V4BLs1YUA82JNvlvygd3n2DAVGWi+
         QiqV1gHCdKdgoHdR6HKek4delxFwwq+XQStP8iPfQTw0KovZSonbP4MPezUdXF5N8hXV
         D3k8Tv92dfOM2Bw5tceatMhue5i4UXUlJHbL4OaFjCCIH2BZmVjqtPYxc9eYmzd5zcs3
         sjzA==
X-Gm-Message-State: AFuF++n4uLd6nlbMSsK/EFkMyI/TaYd/Fe/lag2Njy+vc3wBizJw9r2q
	XogFTNr1mzoAPUNRWxpSG3wyo+e7B/cjyq/QRu5y0GIKwesk0/Ahh9mWBPqUDAswfkezXG6uJQs
	bqcpUhiVD2g4lJRmfm5NC8n5RkDx2lDSulQ==
X-Gm-Gg: AYBFou0BBUo+cw+c5D7QSa+q+F4Jxl77nDhpIjzPL8M/ll41G8ERtfPn5DCJ6ANRkwE
	hbxQwWhcPYlO71gNQb+ptwmFEjunghldLbdKGR/Yr9Yqi89x6rfaocMPJwIMU9bETf58g+jWbwm
	f5QcYcY4MIFlKhZLNy8NvJ1GtBT8LXC0EK/6qYLZ9aYqgCF2uIdBarOcfK47YZ/l8/s1g4Vxj41
	YPQSkc/2eIw/sDZcYHGF9QKzsZwaluyvgr34YWrob/t4rAWoHxzuF8Puo3u4PXW4Fh3fk8d1DId
	QQq0rT3cYYGbnFfH+u7F2zHmCeyLykmY1u355YcAtt92mumh0wa6nPU=
X-Received: by 2002:a05:6870:b3d4:b0:475:e235:906 with SMTP id
 586e51a60fabf-483d480da04mr840763fac.36.1789481424643; Tue, 15 Sep 2026
 07:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914155751.27077-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260914155751.27077-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 15 Sep 2026 10:10:12 -0400
X-Gm-Features: AcwNN1WYK3pTa3kzUPVeTazd9BRGnv7OX1YxuQnXWcQtA51AkU2IBme6F59ABJQ
Message-ID: <CAEjxPJ60Y98=LVbQY2BWFO9obtT5E9xxP4ytrTpOB6SRbh1k2A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: module_to_cil: warn and drop non-trivial -self neverallows
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:58=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> CIL has no target syntax for a neverallow whose target is an arbitrary
> type set with self subtracted. The (notself) syntax is the universe
> minus self and the (other) syntax is the source set minus
> self. module_to_cil emits (notself) for the trivial ~self case but
> fails any other notself rule with a target set.
>
> That construct is legal in the source language and checkmodule emits
> it into POLICY_BASE/MOD binaries; the assertion checker handles it,
> and semodule_link/expand accept and preserve it. So a validated module
> carrying
>
>     neverallow SRC { TGT -self } : CLASS PERM;
>
> reads and validates but fails hll/pp, and now also aborts the fuzz
> harness that treats a validated module failing module_to_cil() as an
> invariant break.
>
> There is no valid CIL translation and refusing the module in the
> validator would break the tools that do handle it. Downgrade to a
> warning and skip the rule instead of failing. The dropped rule is a
> neverallow assertion, not an enforcement rule, so the emitted CIL
> produces a policy that is no more permissive than the input; the
> assertion is simply not rechecked at CIL compile time.
>
> Hoist the check to the top of the loop so that the lmx/lme line
> markers stay paired for the rules that are emitted.
>
> Reported-by: oss-fuzz
> Fixes: https://issues.oss-fuzz.com/issues/561210454
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This patch has been merged.
