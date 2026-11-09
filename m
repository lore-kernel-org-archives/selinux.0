Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794246806;
	b=WsSALE8dRBLD1tuFtt8sTCIMvsHGENjoHHCjwLJjwn2WqFuNw4FFyJi0J7+cC8OaHc33
	 T/dj2znegtHz/7wxzhyNNc0W+gFHBbZJVTLJCicXSlQOJsFXz7hnog7QE+oL7IOQUDO46
	 +3vJbr2oBRcmPvLjS5DSt0ckOSpnNPSshTRFuus7l50+tp/LOvu//Zv630AjUObuZtPcv
	 BYSUrXsP32U/+1wqxJYSi1jJG7ve6UOnxomTi7H3+ILq+sBv7HOKpbGY48pa18M/PFiUZ
	 dF1/dJuvDr1O7dTlIc3d0Trw1udLFZiPLE/PnA91OsjmB0nHk/IEyZLLke83JA7skeg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=gHrvOf8UdBPYz9FCbQg8xcR+wgCvHVFr6aRCIkQKsr8=;
	b=Sj1w9Njo+IeT8YhFmKMl/JGBC1WqEqZI4inyneZFTvTiuv8KMqkeXriXD8HNJ0U8HtbT
	 21ermMMwRl7WcC1uAmFL+4Kyx45DQBzliswKbyxflcY3NPduthTZpOY7juKPi8WFZfDSR
	 mMsPw0EWJrpB/Odm3rNmiO+R8jnAb1LMW1DEXKhxCh7OaRQ+HnB40kU8q5vWqnBerGK2U
	 0cA+tGuGUDGb4UtGOYGnOToPy5BM3X/VpAOHsUm0Thg5lapsXIF7dUERVGdAoOaqGACVi
	 T99kTSEOpFsM4anX6gJdFVj53WCSE/Sn3v4denQZFyRt3NYA5dp7THJjPI7kncReK2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mpcN8uUl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED95606A326
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 17:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EED95606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mpcN8uUl
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-675617e81f9so1012581d50.3
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 09:53:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794246805; cv=none;
        d=google.com; s=arc-20260327;
        b=V5wpsDBUKH736EHKGUFW0MXO/pZqcZR7RD0d2/9fhyHOtjudwaXU0HmLQ9hPIlStfX
         qHy0jmiGQJDAcg6Z8KtaAChu10ErvfIMFEOu8bbFBbp/Inn+Y51Ghdyw34hQ8Vr5rH19
         bTSIGNp8WKyc1hnHXpNAIg4qN8Fve1ipxAPg77eYwGohZ5yN+IAsbxpfxaUMOYw025CN
         BLkxA1zvzwCvIdRcXt0v0RMyT+c/90H2pWsHslOVGFTtQVMwVbz1dScvGrQLHG9DIw3t
         ++npukUioePJt1VB5+CmuG2SXcSMVGFKbSknfdLHskRMvAPtUrzHsVaUWM7wh6EoxItb
         /u3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gHrvOf8UdBPYz9FCbQg8xcR+wgCvHVFr6aRCIkQKsr8=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=U/DQNSIETK7PTh6f0oT379DTsQ/mWUlx03RRy6s6MX98xtYtm8pOh65MSIcLu7xZds
         x7oQ6gzj+qScTawtkPX7Ls+NM8xBbMiNzzPt3/BYqaatmBk461PqkmGonGzNDI7JvWRH
         LiXZ5bnQHa0NIj+P2tgVXV5pGNWaina+Q7ANwlkkoXu8pYG4+Ftn80vbD1OTlRlIXkFY
         7rs89zsDJY0pFw5bvkohCAmxPLsMWybqgZcchgp+DhZFeXO/KPr3atiFCKQ5q5W7NKGi
         ffTeb01DEJUZ/jPH9tCHi/rLeDyMFfan+6oq5/Rokti7Tk4R6wMCulEe5KxcfS+3W/l9
         muPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794246805; x=1794851605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gHrvOf8UdBPYz9FCbQg8xcR+wgCvHVFr6aRCIkQKsr8=;
        b=mpcN8uUlXAMjgw9zokKjLvaL63t9+L3V1GMiXQJ1nPURidhTnt9G2pnSvrxQT7pMcj
         a3Wj2KBZKcVkaOUzYWNzQAM95s4RTRQcwNXNd/QbMHX9HX8UVhj1kA7d/gwD7yVBEMFw
         C2cRO60EKLSU+YjxBI0ZsbHpk+QgZIYz3rIfqaHMvF0519FMiaiOzKEi+App+DVEyBYT
         tRJ4+IvKzxpuD2pVNAvrkXy64rz3vaouHNMPrYYzOQPtf+T2AcNYRrNjrNjLb0rzZizh
         5Ger4UTzVnnv+1QxtL7HmhtqUUiSqoyeNCGln+kwwTXykaOLi0NIo0v8cq+oGGYhjIb6
         aYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794246805; x=1794851605;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gHrvOf8UdBPYz9FCbQg8xcR+wgCvHVFr6aRCIkQKsr8=;
        b=S67LwLjJOA7oNDlVq2902hXJ2Qfv4NVvbxsCHFK2f+t/QWeId7hdjEjoOGQwl0MFOv
         HmHLNdBamDdCPRpAN+QxDGNE33LhjR4wFlPAwZwi6ReQkOY6XtkA52asHo/ZuyENmhuz
         6UDhDUeQHR4xhp5cIZLothoM+PlmAlRktRP8z1BHlrc1AXbzKw4eccESm6W+3YU4erm0
         qcjZOzp5ZS5lYI3bcI1mugO4B/mEvFWKAHqwZ+5NoXCPSOv6zA/5PQQTOyxDJZRi+/KD
         j7SbZrOu14NW1UF5jbD91DXBBg/4kBpC2470waLJoEo+lqilOgS+uVyflZNdlt38pJso
         jjqw==
X-Gm-Message-State: APuU4Z80YVELlczDtmuSLnA5smhoT2cu2F378oxV3Hz7mYi8vfyIRNK3
	Z0pzx1M0cgtd3RPOnPMqX7W9z9CF9mnYVIKa4Ia7g2jgz9etGM7oB+MRA0APGTtJLSKVdl8vL5O
	RDQtsOKwFOISuhifm+3BVc0YeKkqkIp8=
X-Gm-Gg: AYBFou35d209mcHPnSLojf8vkhtKR+fKAi7VuMcf98jaG7IKY2yGZE1YH4PIJZNDR7U
	9Y6YEoPmQKj2eInETjuM/a1x4kIfHzGCjq0iLCy0g5mhcrvDOpEGAowNb3uN4VABpxX7mqNl1Kq
	ViAfavM+mULG/IBaN/x5kDq2RBB3H5RvFMkvSMTPMFWxjkSCLp0vLZz0ZNhYEQrJs/yjBfIhT9z
	mjEsoENCaYUK1fRL7FIPJo64oH1WePO/Lm/Pq7SnhrYucSLNwzlxVaKxqjsagLwBBqK+nS0BK2A
	e0tliaAp9o9VY3owrz2VZ3WpgjNB4I36sf7EGGxX0CQPmrpIzuQhok925lJCUYoQ/8vRIRqoyqx
	jgSE3mdZCLnSJPvQtvSLrI0m7dyeOmpUfwuEfOdS19yEKXZ7pKNCoeprIS+weYpP49h836cV06u
	UwFlboZk1l68Xrw2TaeRK8mf9Ev5JVTqDyV4Bbt+yLGG7ZfaOx9UlHllKUwjcJo7b0PKdfXd2Lj
	xjfjQo=
X-Received: by 2002:a53:c5d1:0:b0:67c:27ad:5554 with SMTP id
 956f58d0204a3-67c56903790mr139743d50.100.1794246805111; Mon, 09 Nov 2026
 09:53:25 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109153802.76176-1-cgoettsche@seltendoof.de> <20261109153802.76176-5-cgoettsche@seltendoof.de>
In-Reply-To: <20261109153802.76176-5-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Nov 2026 12:53:14 -0500
X-Gm-Features: AclHuK_2gn6k2XOK0XpYoS8HjPRyUfK6u-zdd5M2h1LTXcj3VMKD4twPklX6yMw
Message-ID: <CAEjxPJ5mcMGCJq5tGESYiQL76hDv0KD36qrOmuocJBsuX8jhzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] selinux: zero-initialize permission name array in
 masked av dump
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:38=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> security_dump_masked_av() declares an on-stack array
>
>         char *permission_names[SEL_VEC_MAX];
>
> and only fills the entries that correspond to permissions actually
> defined for the target class (and its common) via hashtab_map() and
> dump_masked_av_helper().  It then walks the set bits of the masked
> access vector and logs, for each bit, permission_names[index] or the
> "????" fallback when the slot is NULL.
>
> The array is never initialized, so any set bit whose index has no
> defined permission for the class reads an uninitialized stack pointer,
> which is then passed to audit_log_format("%s").
>
> Zero-initialize the array so undefined slots are NULL and are reported
> as "????", exactly as the existing fallback intends.  Rejecting such AV
> rules at load time is deliberately not done here: it would break
> policies that older toolchains legitimately produced.
>
> Fixes: 44c2d9bdd702 ("Add audit messages on type boundary violations")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2: cc public mailing list
> ---

Just FTR, my Acked-by for this series remains valid.
