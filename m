Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E303C872C
	for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465489; cv=pass; b=NqDL/bOAlyI5ERD0Ov2vqOl3r1QM82IXIu12DPzL4u8G4seaJj/gDjF0/PuKp6TNjr91P1kJb+QejiPkkxbeL8mu34BGtSiAg3AcBCMdEeLGMpfMa1NWYFc6n19Y+8bxxk4yEqBSFfdi/hJMmaRXd6dv//4y6Ls3RoB1TtQbZ6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465489; c=relaxed/simple;
	bh=qEjlCpo74JqO4ysVk68rr9x+hC276f7RK051SmINb64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s09C5hU8uWzNZoa7qnDPWlByTVDg7DUu+edWT2DTiqwXEu7F8njrIrTGi0U985E8vSfB6FWNkTIx1WdMeFuHv2D7q9dNYSaqLBLQnUSJpS61W5eqavtT4UurHZ32ObpvR392nb0UGnfd45HThKvRyv/H1lNQcpP2BOrcib7E+OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI97RwYU; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI97RwYU"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6ae3faeb9c3so37349eaf.1
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 09:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786465487; cv=none;
        d=google.com; s=arc-20260327;
        b=GP3MfI+vyrvByTB3mWvQKTWZu4EBa8EEF3yaK+gsp8sQxZBkxP20OB83qZo/GEXLn6
         nijea63ulFny6htaN0Ns+oC9Xno3otarRuVYsL+qy+ZxVOxZR8W2MQtoTZGH/LjorlmG
         rctG2yfy0UIwsrevYJHNrvZ4XRvLt+LaKds6FcjyD295/XvdSttNX/nIehF+nE7WkPtd
         ogAVFV7HNPo6Mk2lr5pAq0RMA+HlmuSgrs7JJNXXSWYvonF9zQPSCq4bdm7ul2GTqrQk
         yFmqNMnBDGnm+lqtkSZur9hWzEu4HJBhHe6cZq2aZiT5pIvYd5v6lZzDFzh8tnabdWtx
         VWog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LKB+V/FBOQPm2rdqLgY9pVzMtTRZnCt/cP8XD0Xtsvc=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=lnTtWWsTXVS1axyg2cMLyA6pOWd1QTCipYLQ3u4paITrjKYBxncbEj4AtacdWyJvGk
         GiKDmjcyEpLrlt6SmYQe6N8e5qMPoQ6eh/0iuc3Uf1QbR6G56IRN9REYUm1fQxuBlxhV
         R0QwrILesT+mgN0IJtlH5Wc3eJ+H7Dzd52EG1xXAfdDwl3ovqWewPdi2egtzzNBVDIu9
         j4Vzhfz7rrxAxkvyH0c0iBYJTq0wjCu7xzdV8dVela75rKEiQVCvcTILqRoWqUXOoinr
         WUjGrGJRFs53soyBsR2mdGUT4/Aybd8hbqyajkPUrrZqu0C2+3kvwwzvlti/dhGOvG23
         AuaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786465487; x=1787070287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LKB+V/FBOQPm2rdqLgY9pVzMtTRZnCt/cP8XD0Xtsvc=;
        b=lI97RwYUfRt6hv5Uq+2c/OmKoFaGQJcpocFfUiw89q9EJVZFgHyCpi+kg407cvvTgp
         DbDjPYWR2LW89ds9QNJljbS/9MpsvExo4I4RbfH0DTnhwAWc7B0TiOzS2krUCfOO30+f
         FT4iHwxVn3DqtxZdd6OfDC4SL5tUEYSgZWSsjA4S5I9VLaOhY6PwcdryaWV11DrdpOOI
         ly8YVTm+5LLd8dEE9ElsjLHv3AXvEiHycrSrQA/iv/RfImy9UWEInwLLHmwl8MnozM8z
         OQQ893QwqZIA85t5wTTkd9OolgauqAgSmMej+y8xIvlpGlvLH5UHGRAhQtJyow05gfcY
         Gztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465487; x=1787070287;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LKB+V/FBOQPm2rdqLgY9pVzMtTRZnCt/cP8XD0Xtsvc=;
        b=HZEviYUMijkrHf/nUMJpzyM2MK1LPsNeX9mEd/le/HE1dGnk9K0YzPC968NHfElKLk
         dHMKuypXWl/gau263qZTuFAb/5Itve1fuwZtIxVyc6HaL4+Jnk6KUvMw1NWk4O7mpN3K
         NqmOcHwEGB1hqcukeN7wnvVp161Q8PH9W13q56jOESCIOR1AOWfxfJ0a4ijxbNmm7F84
         ys1ioEiTu4yMewKbHIFpHV/NcOemhR8cSSx54IA8MpSIhM0x/DDloRrsSnSvk7EttuIC
         IH9e8KMl0QVOWQp1/Yd6L6TgpU7uEzT6HNZ9nDu8wL51U061wlnrxYE9//2Pt9hRP6vW
         vfbg==
X-Gm-Message-State: AOJu0Yzg0V1gVzWyUBU0ziCdJtZD4NZ4132cE3IuDbpz2nvIs3VoQt4s
	scH1W8MTeu3yentoW1qU0e26PA38NZ/xA/tGEZR+TcA4+BbQ2NpV5s6LcEqC+MKGrLpdoURIs8m
	E7Tu4hFqkHbh2HjKIYMv7s/p3hmsWzW9WXQ8u
X-Gm-Gg: AR+sD12KG2CuokpaKu8NMVj8DvogdWV0a037vv5eYoKLd67dhFd9RQVBpUxl6Q7ed8r
	4+DSK1MjvXKrK4yRTg5pPg36DXsN5F+P0bJSBVe1FsahiQOoU0XfctylXVz46JCYi+IZkTGJAcF
	NPktXemP5Td/kAAht8HB3uTDYr8iZqWCr6zNoQ1kbHuh5wwxV1ofu6CLELhuOdasZnDlJq8HDg1
	52nxTdyrkjH9sk+ykMOZlwXEvR7dqmietyiphhZ5Jv6dSOHQzDXwLcvA5TbN//lpj60L47rr9aE
	9BRI5Imqze5lYY6aZbvQyxXhJRiYuGQmn/Im0C+WQ5qd
X-Received: by 2002:a05:6820:81d0:b0:6ae:8fc0:dbaf with SMTP id
 006d021491bc7-6b0a2ff20aemr2820719eaf.1.1786465486656; Tue, 11 Aug 2026
 09:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811151705.109129-1-jwcart2@gmail.com> <20260811151705.109129-2-jwcart2@gmail.com>
In-Reply-To: <20260811151705.109129-2-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 11 Aug 2026 12:24:35 -0400
X-Gm-Features: AUfX_mxjvLiBSpMZGx8HtIluH7wF_KDOaxyYys8cc8Ayc0tv5Gtcn8jBplLj03k
Message-ID: <CAEjxPJ6vr92tSn86iai+1CYUjG0wJwL-EJ-cj2BCJk24K_rN5A@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: Improve the validation of type aliases
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 11:17=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> A maliciously crafted binary policy could have a type alias that
> refers to an attribute or that ultimately refers back to itself
> in a loop.
>
> Validate that type aliases ultimately refer to a primary type
> and not to an attribute or themselves.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/src/policydb_validate.c | 72 +++++++++++++++++++++-----------
>  1 file changed, 47 insertions(+), 25 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 5687c82b..5178a2b4 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -13,6 +13,8 @@
>  #define bool_xor(a, b) (!(a) !=3D !(b))
>  #define bool_xnor(a, b) (!bool_xor(a, b))
>
> +#define MAX_ALIAS_REPEATS 32
> +

Ideally this would be lifted to a header file like private.h shared by
both files.

Otherwise,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
