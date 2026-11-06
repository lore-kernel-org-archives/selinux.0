Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993180;
	b=M0jwkKlPlSvPXN65l3gT26oJXFCSAtMe6lXai4o5U1cR2GsWErQE/5dSRMXm6FPYEPYI
	 qA416QeKtW9nHme2CqKuytU/Walc8epq/7/Leyv0m6KxGszk1Xcoe+caDAq3/J27PbJ95
	 wOCTWOCnPIL0LIEr8VjBTbRTli8pPHgWSTZaXLWdkjLOE4ff9n2EM9oQmTX8pTw4t51Qn
	 FyFLYxcXkiES7B5d0K8pcgL/IIxHWqz2VdDpJO3GrMcLN0XxlXBfgdVOK9eofixUgc4+O
	 TmhaaW/UjVt4938Qw1VcsxYlnC8JFGzoXqbJt7gLcz1PCHn5+ImNsuFwdKTBImFBqiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=fsYhdA3001WKUkA1S6GPwnGVCBzsrPcZv2HtNTyJW1Y=;
	b=UlEHZWwQs/SEA6lrC8pWrxbaae5hFs4KKq6ZZ42YQR/YFPXKiy8pbx00evvQqnsxOD9x
	 gw7b7la6ZfN1pGO+gXF+aYrU7J9e0cY/bwDVc0W2BGMOPKdufUlXOorND4/YJSfuyndK/
	 MdsxVcVx42l6sivR8M1wDeOB0/b0x9H6s+JaQycIYHAUTdpBJ9Bhh/coTA5ykKWt8ozzY
	 uRuglsusqSEOL8XSU47dhlpZLgjIhYkPkHRRgse81g5PS4x/irp6cUb2rKh2fxeAkgaCd
	 GtXrA9JvrVRWihoDEQJKb+PuKUE4h9zZXS9+DLFCGpOwS7Pr6D67Yrx9EpePzYxl0Qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bye31auz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B8606A32D
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 772B8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bye31auz
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-675617e81f9so905766d50.3
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:26:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793993179; cv=none;
        d=google.com; s=arc-20260327;
        b=BzRkw9UYhwdo6SVoaQCeXPHHZIYblkb8TzOYz3qi6u1/c2LJttXkA703SLPmPkqtMx
         reCpKCj1qfbSNPccejTDSFJTWN5UN87YaqYIwWC6ePciwshlZD3kod9DsjwjrPabSwuO
         ig3zmZaARP6Nn16njp6UqxAYSrmP8y7OCotW9Ql/fBLWU2HYqIQM/W7BN59x2jzeQ8Do
         QhBSyxF6yvDL43tWDGNTKOmfyNOjx41ZmBpy+Toz+5yr/7fmEOOOtEZJpS4Udvv/XhlQ
         mvzlEn8mfjkSO/3F/Pkg8/GEB61k6TlaDgHuSMB8h3a41HqNF+AxiM85whZurYjPCGbS
         kJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fsYhdA3001WKUkA1S6GPwnGVCBzsrPcZv2HtNTyJW1Y=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=LGwBp0Gr5rTBRFPxLCgtZWv+CdDE8oA+XAVeE4Y5m7/kegewcPEcWNzNYi9zcDSdGa
         hMZlpV1h7c0QDqWB6SY/Z4VvHAw3PWBc5i9iT4ijOtW2zxB/bOU6jkxy8OTUbn3tKxPe
         q9PTJ2LnLv0K3AdbPTV8idgdYQ7Y9tDCKLn2U8foM5WGNV0FomNmvdIUseOlUG7y6u6C
         DebPtRfum/NOw992MpsU/SwCzNbItQ/ONyEkXSEFXRorAqZPTduAHui0uV5acoxdamrP
         QRZ8v+QCUALOA3qx/Ukm39rtguyhkWIeShOCTgXX+FC2H1Is6VEnK9OTl6SjM1yO9IAD
         jF0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793993179; x=1794597979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fsYhdA3001WKUkA1S6GPwnGVCBzsrPcZv2HtNTyJW1Y=;
        b=bye31auz9LFfJ89uWlIsnVqMg7WouIHbvY7Nuhu2vB9llb4pN0lz7+FApM//kvcjWi
         5DtRkHyGw+fCakswsr2jnZZCVvYl9xQe5L12UPHnkWwwxrxWKadrVgPbVyqDvIqZO/In
         QohgPCObO/rNxVXYNO79mIEAxLAz8nSiY11+V+Zh3TQ7D2ZQO1jWwCnIeOXOq8Qz12BF
         JO6EBkJiOjNZj20Mcw3kxRtVRMI4b3ZJUaWzCToljcSr7SknAqnpBZ/dhSRaN1PS8NsO
         VFW0+MbdP8pW6VrZvjXoju4e5a4Lo2NZ73HE4Bn5XCFaBD4BWsj8dx6cB5KrDi0wtdtw
         VBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993179; x=1794597979;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsYhdA3001WKUkA1S6GPwnGVCBzsrPcZv2HtNTyJW1Y=;
        b=chIJDGZkRPGjcsJhjKoSzgJt+/vypG9QPEuipkzNDmxCAPQUVfUMSW20g+JMLBtXir
         F6PTrd6olXdUfwqGoy36fLjNJrE1Kxp6Mwr2Y1bbcr1jNjtB6fVNqN8oWgbwaNC/FTw8
         1mPpPEIFMZ4ZbZ3hO33dmZW00C+xiZs0PCNydxRciohOVVPWaBRfoblr6YD7jm2FaEfG
         gNAKoF8Lfvst9+9hk4BSoWzh147S7Iz3i7qYkTw2jdXwNQUXYeOscKyPjAVTwQCB0RKE
         9BWpIzN8sQC5honS4EV/CYVIDxtnVX7OFOiKcbiFnEk+gVnbTuxFEDXz7MiaCmu/tibY
         R+EQ==
X-Gm-Message-State: APuU4Z+Vc5HIxr6FXvUnO2MGSraKUnY3tKYzzDM1Miw7/X84oQDdyGxI
	mt++eNDK0uleSkGHHBezGq/FQf5NbMdbJ5awV+RryoGRPhZGvEOK6cwgb/NVx6ncnWMqYPeS/wx
	DIlm1pztPkyyvH2sR7xLKh/2o+ZQg0Nk=
X-Gm-Gg: AYBFou1nNoxArpNWplh/dcTxwpUN7EeZrFNJgcal/JmbxYNSB6FL1IfwOutDrz+iFo4
	KQaqNwNly6asryr8Tc/bBV2LE2cDoYlnmIMJi4p1jO8geqJHUUgr09gPYEQ+nlfzYd3ZbFkcZuj
	HcS4UIpR1BGxMSPkZ4+e+DmI7TT0lLg7UASXO49Wu+rdIgcIvMjfX39SmCMHytHOhvCBI7kOPW3
	EeRxTuxY6PqGVe8MfXS1QbBvHkL/CQpLU1v3PqESgblU5Erl7YkcHo3w+GAqcvQyRduXD0d5S1S
	ImaqwaHzzL3tTEnBDidouppFlTm6Dg6bO3Mq19ckgR8TaK5npdnFODltJA7b4gNS/djhV/bwC8Q
	ZRgZHVFXTK7XTkn2egjYa7OhLT05d3H2yJtICsy1EoJsZGfSa76yQkLKDssf4I6TWB082XwZC+9
	oRGQiuMbvbE1gUUkKSCdWSbajpKKNYMZ0iwiEW571wJyR2jfLK3JuPgjjYng==
X-Received: by 2002:a05:690e:168a:b0:67c:1dca:808 with SMTP id
 956f58d0204a3-67c1dca1974mr992618d50.40.1793993179320; Fri, 06 Nov 2026
 11:26:19 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106121725.48778-1-cgoettsche@seltendoof.de> <20261106121725.48778-4-cgoettsche@seltendoof.de>
In-Reply-To: <20261106121725.48778-4-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:26:07 -0500
X-Gm-Features: AclHuK-aCgg7MLeJWWCmfvK6bgw-LzPpKWlRs6PO7-DgNoFW6Zb74GdqsZh-JWs
Message-ID: <CAEjxPJ69d_6t77YH_ScJe2optuHkw=MtqxsCG==Eik9_0Lk6KQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] libselinux/audit2why: free reason_buf on a TE
 denial in audit2why analyze()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:23=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> sepol_compute_av_reason_buffer() allocates reason_buf for a constraint
> reason, but only the CONSTRAINT branch freed it. A mixed TE|CONS reason
> returns through the type-enforcement branch first and leaked the buffer.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
