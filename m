Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7473876A9
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073145; cv=pass; b=t6Fsz9D2Ez1z8kFF5nEPDIXG3q2MSStDEpRATk9vWSmqpEKIhRSMB+FnoM9AN6gK9dhfqvWrwcqtNlS9+iltUrV6qupPYAdXZNY2RMM9uOenCK6aDu/9/6Ki/hKlz3ngNC4PNd8BnYDMZ1RfMUtq12yNsxeeCEJ7bVqmxYJb8vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073145; c=relaxed/simple;
	bh=ImFQPFwV3lGIcko16rv/96HN28D3qygOuzUAjJEAilI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkP0wkvgauxFf2lVMGYivT2yToJsL/20javIdhNLdXnDUPCmecIH9FK0l//6y5cKypGFkejx4tpGfnWVaslY0J1a1cRMci6N7qDclyDmYDuO3SozJjz8NH2XL4GXbuJXR62vVN2nCNLKyhFEasW2PAp0vo02K6vJiezXLHBvoPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S686sx+1; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S686sx+1"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e61ac64ec3so45955955ad.2
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 07:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792073143; cv=none;
        d=google.com; s=arc-20260327;
        b=pWRJ+TKmhvIp+mzL0ZfNGjy9Is5HKTPLoW7dR1gpbo/4dqH9b46zL72fPXg/fxRirz
         19qsi6TESkyyox+DBYS0FByHmROqsKQKPGZaCIizfxRZfxkFsKfbNUbvRhkKx3ewbKp8
         sDP+Xpi8bGEL62pwFd+f1BRyao3uvv804Z16Vjq0tFXpSZDVTm2inKex2awTR16ZjZEQ
         TORNTuridinr1zP+k6S0zu5rCDYXFWrF8HTfWeoSaYD8FmWu/hjiFPMDsXKr+EgGui0A
         mSu/qeSp2UVDK5enWMAZKbEgxRvYrfacfON2Eko2Q51MWTxFpoj2CBPJ3AOVVHNx1U7z
         d1NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ImFQPFwV3lGIcko16rv/96HN28D3qygOuzUAjJEAilI=;
        fh=FY7zAVERTaP7qBYEHfF+UdYnFiPx92TK51PoMRAzG+o=;
        b=P9BnpRjar8Fujw/O+8oQfjJa4c1tdh93ZnXAlpq7EojimV1JJhAglnYt9fipPSXGDl
         xgSbLXPGtL7HtyUzADiiGQ2BYB8qD6LZWo7vniK4wjaHcvdS6v5HdN6rulgj0qP94isY
         RtJhfPnCJBJWiSMwd/4/7Cq/hDeZY0BqpOFTPPA/l+CYsgniR+8utzIdht/gsQRJkAG2
         LgdBM5+Z4WvBtGQC2HbCqwh0/QWxAqA8nIiElh2mYkrVLmceKIDKkkwdQ6u456sd/eQU
         izVLMNTkpknyz+aXd8n//XM9sc4J91HqUHaVBgLRE9BPe8YcM8+dtDD2XLUO/ej7NAtt
         JVsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792073143; x=1792677943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ImFQPFwV3lGIcko16rv/96HN28D3qygOuzUAjJEAilI=;
        b=S686sx+11bTbY5GbVwhlJsHfWY5sjoIxWw97zHJ32ADkIpGQ+E/kI/0CbCy02LQqSu
         a2w+o+pIA+Sjk2qEkzSN8+GArMEI17Tt/UxvBc7VqNGePKrybrHo9443G+zYqLrcoTdt
         VWRMDBNiJ1uzj6IRIIzfBKQlzBClzph3xDhb/w+VKAdBE1eAInXua+Dl6eQ10cdWIO1l
         cNxRGga9qCGxSDpOwj3ZB2ulKqvVOrPW5pakK0tbEeZK9ci0xp0NiOFmXwpSrU2gHY8Y
         ylAbSY6uNmiVyNfutK5PigPxOzfmwQGHQ0FpnAenkq8RQhp/JCxMUrUWJ/o6K+o0s3bD
         NAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792073143; x=1792677943;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ImFQPFwV3lGIcko16rv/96HN28D3qygOuzUAjJEAilI=;
        b=YxQDvz5/vbvOVuHJji9n4cLW53F5PKHUNVN3iZErpJAdglC06JDkqI/g5N1QJOGTDp
         afpDObFoJLHmPI2XCkjobWKkMnfEK7yUJ5gkpOOowVK9WP2Sq+j9XFPPJqp9A+BhAFH0
         Wha8JfbrFp7JZs3eQwQKPJ5cdznE7Z6FnUBwx2kb5yL75eeSXBiepsO6f4g6yM6/BAD9
         tjvOil1ywV9Aq5BhzPt9AgZmwi76InRW0dsD4PhSMCNeH97y3Qz9T5f8h1RTr7cS8AJJ
         8JDLF4ubfWrw1wUn13jGPULXGpCMZUjS1+toB/zLh7K/EtQ4mLRvd+yyu/PN/leKoNJG
         45qg==
X-Forwarded-Encrypted: i=1; AKwUvBzcpxkAfMeJcQaQU0FMRXs8/aADPAOUewQ/+VokP/asRsfB9Qh8pBsLJduPfNyG3GWRsgNGNMOh@vger.kernel.org
X-Gm-Message-State: AFq9FYLpuFY9kby0zSEgYaHgw6DsOsPlLOItdNDMyeTOecq6GbEoO5Pb
	ZDRQuX3BjLT4AGZ5RrS+kNaKFAqv0WNzSMc5JZd+tOqOLYgY1cl1RClrOD/3SJaxbqs5hSO4IK6
	BqobXksBPiharrGue91psDuZSoJR2qOPPBKnxyZoEMdAoV5d5TZEF5Lt4
X-Gm-Gg: AYBFou1toZtZzPbv7gvbJvYR57Un37lFdKi60GqQELpSb7gfSEswm0WCrsq47sAUH7G
	wQmgo5oOM27IWN5iRSMh8/VB2mPWHVVfkW+3/G/ssppYrGcfqhct45h2hsF8sOXYr/Iyp0aZtVJ
	tOmTsWNKEppb5MA8vvEhqw+0gpTivUfM8Ox2P8jjsYs05QM0c8AIE1/74bn3ULqT0cdAgxNkdoj
	j2uImRhsHYSJTXYAliq0mSLlhN1QzCobH6JMBiffZcFGsjYqZfBxPUev0pS3w4MPsyWPS0Ybtbx
	WjexJMh+5Owf7mloxXtcmkbGwKZNYUZqhA+6IR8axZ7yJ8haqL8J8uNRaQ9ZIdT2e1sPSmxrAQC
	bf1YgJvmO9R8=
X-Received: by 2002:a17:903:2a8b:b0:2e9:4f7b:affd with SMTP id
 d9443c01a7336-2e94f7bb5bdmr36582545ad.6.1792073143026; Thu, 15 Oct 2026
 07:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014160741.222219-3-blum@kernel.org> <CAEjxPJ5tbPLOj17dwEDvzVNEJnEgMy7hGgFzEe8MYwzVxU1smA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5tbPLOj17dwEDvzVNEJnEgMy7hGgFzEe8MYwzVxU1smA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Oct 2026 10:05:30 -0400
X-Gm-Features: AclHuK_2Ieu2G96FqstOihSeQiRTaHucFgcmqqdmYaHDfkKf15sXBreZo4_0rJ4
Message-ID: <CAHC9VhRk3n1fq3914rufiieTLMEVkqJ14wXUgFR7-MZ0=pVgiA@mail.gmail.com>
Subject: Re: [PATCH] selinux: use isdigit() in selinux_genfs_get_sid()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Thorsten Blum <blum@kernel.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 10:01=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Oct 14, 2026 at 12:10=E2=80=AFPM Thorsten Blum <blum@kernel.org> =
wrote:
> >
> > Use isdigit() to replace the open-coded implementation.
> >
> > Signed-off-by: Thorsten Blum <blum@kernel.org>
>
> I seem to recall seeing this same patch possibly from someone else but
> regardless:
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

https://lore.kernel.org/selinux/20260928174643.2458710-9-cgoettsche@seltend=
oof.de/

--=20
paul-moore.com
