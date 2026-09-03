Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BEC4AF9E4
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443116; cv=pass; b=fnJcmeMKO8EJsDzsc2YnO18CFV26KCZldNFAlqciRTSntO4oEp9S8Fuo6OGO9yErP79an2mJZCt1YQX6Xnv/3hrqkuEg/TxrfVXMuUELRPz20u8Fqm2tdpsMUQJDvdDSjRbdz/Z4BTJHW1rV7lcT+SB4jF5W7GMv7UpDqO7xv1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443116; c=relaxed/simple;
	bh=XeRSi13vY3eZFIzuRhimPBuM52ZilWxTeRVwIs+KOy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WT+dirUnY3NN8E6ecCXBZu5Tdki6vIG1BXfxn2oW6V0clC0mxUOJsYJlE9Kt6wr+ojQudcMoB2/rOJ1asYLXOvLmPsPuQvgyWAMT8oIm1J3EEqOxcZ1tLEk7w1ySfvrKQRqbrfzCKNVJMBXvrPM9QbfKrERKA8CRun0Wodgbxdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbq3Q03e; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbq3Q03e"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-46adfc80ff6so1256521fac.2
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 06:45:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788443106; cv=none;
        d=google.com; s=arc-20260327;
        b=rBKM/KX9OyZAMCkR6Lk1VWczU5P58s5cv6mn6FkeR3S7VMvQvlCKptY4P54sm6xbMS
         h+ZfgBdjIgeNn3lqy/wdUWz/6aG36i04KwhQRg/uKym2tPZw+rhX9m9z8uTcKXqxQU2p
         wrJmSE10qoyIZiSDO8qAP/9LgE1MhtcoZQtHkj8duz6zC0i7yoefSnlqjobDko4qdZRu
         xtRqvlPhz5sIaeeGjKoQ2UhXEXVXOQRbdO1o/ybohubNdB8dh7r8GBYbKP5udwgjudm/
         qg74y05B5rXNSfDLJ9QrHzxDinGtXEZauTcQNF1ssUUFUd+9N1dyYByCO6HnwQdfpWF/
         wyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XeRSi13vY3eZFIzuRhimPBuM52ZilWxTeRVwIs+KOy8=;
        fh=aUbqRQkq61ZAI0AgKTda9vTeDxp/LdA3hosIEHHauP8=;
        b=Ynzcetzxp9lNeuMClKVCqfLqqIncinCUUY/Pe0VqrrPyDDlLHiYZFvRD6LRieVnLjK
         2p1ufRp47WRBaHeMo4t9VRsyWgeibWk23FyyftPc8reYzjz8NUB2oF4G+BRq1xbG+3DP
         OJK5kU59TYNBZOr8GAyPLj1DX4jBO5VFaCXazwRGJKz3Avbxjhlb2ukWd/+UhjvO/x8J
         bhzmNLVLlhd756PswgIvF/8DyTsHH2a+da75L7XmI7YiXqkvGBsCwde4nPKFiWiMftxU
         d7Gafb+Z+WaCzJgddfvQVkJsNELX1Ezwwhl4y7fGrlpTxj5r/YbYyHzPLHEh90cHo5ts
         aybw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788443106; x=1789047906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XeRSi13vY3eZFIzuRhimPBuM52ZilWxTeRVwIs+KOy8=;
        b=rbq3Q03e0NwRzaN7++Pm+AohkksxcixS/aO0XwXB+p45QgoIkngiucHlNMoIQNagkZ
         kqoiXTKEogy21F+h5y1vxXhRt4REYgc6b379iKxQ6SQHjHNbm7oZPLo5/yLT5xpsgiNn
         5etCmv555ePmCeblK9Zq4/lFrQ4mEcpCxOcUH29vyAapXntxWel9Ibzcxoc22dHrptUX
         bp7blb7KiDs4HlI0fD3Hs96ntGhCeSBninZRHn8jgj7y2F+qzkoCaZDgTO7dD3NsEukK
         09mUXHIG8y+7pDrUqjM/cG0zP8tsP8sWG3Pd8Vg1yPEE3R0AwjNAih7kP+tUHjMAdwre
         njEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788443106; x=1789047906;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XeRSi13vY3eZFIzuRhimPBuM52ZilWxTeRVwIs+KOy8=;
        b=W6M1AXSdetH3cAZ+8kFKkBGq9K3mDfsu8bNFIBA1k2VckDC6UaH4O3IGtEuJY5SklW
         AFR/L3pTaDNUQyASW0R1k5Ug/cg+R8TjiRqndWIemSgblrQ8/5FUJyhZxoAbvc75U8sg
         e64dnpPpB9hMAq0gnDjVM9viM3loC2u38k/Y3hFYCcP18EReCc6ieGzqO4YXevQm4pf3
         fKnqOKhJxU1QoETVf41j98yTxdGWJvKlAVY4pYi9/6Gdf/jUxrKLKmofWOLyyEEC0bKW
         NmXfR8b+kSrUIxdxvpXxZhxJt1ET9qClwumMSJKeTuZOoizqzdqtSlvnSFXgF4ehL2V8
         /4Gw==
X-Gm-Message-State: AFuF++lhCIR/cPDSY9pQWZrQg8EuIGvoPG95foAz55RETplKZaqPHsHE
	hMVX9CxI2aFiytKyaK2bY+U5sApLc9FyDhHPl34EXQrQtkgCc4H6nLIcRDEIUIXoJ34VnCrWT+O
	NuBmS+S1jR6a0J9tyJR/KsG+Eo4yx+Lg=
X-Gm-Gg: AYBFou0jJi+IdWnmITve/v08Ds8v3ylkk+dv7BmchwGbe0lnzxYQ+iyL4fGphs5PTU9
	GI3pak9rgWO03AnBQXCLvryjh3uTDOvOHa8Ak8gZ2JnMXZZsivJtLWzH/6fIyc0UUey4t6X21gk
	kehf4dzVhtwVjdyPjtCkDvZ0X+Msin+RAZ+tsY/wCfD3rji9Il/vM9MS1cTGKZdULnNcVFofu/s
	nqezoVFi9jD9OifIBXwd9NNjyKzYq2bshqFs/k1OjCwpTJwaD8BKhjcnktfUeJLj5dj4dEEFCqU
	imh4ovZg+Ys2qZJUYUqORD73YONa6H4qbqoPnm6l6tLpR/YRTXxtl98=
X-Received: by 2002:a05:6870:2183:b0:45e:e061:162b with SMTP id
 586e51a60fabf-46f8b0c6447mr10516584fac.18.1788443106284; Thu, 03 Sep 2026
 06:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903113538.72942-1-cgoettsche@seltendoof.de> <20260903113538.72942-5-cgoettsche@seltendoof.de>
In-Reply-To: <20260903113538.72942-5-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 3 Sep 2026 09:44:52 -0400
X-Gm-Features: AcwNN1XnndlJf3tDIdS486e9Dx2ogzOYcJdVKAWBBwrpQkdeHI5xJ9pA0NPakdI
Message-ID: <CAEjxPJ7=vA0pXhQVXyXrUj-orQfVqVZLT=qMbMjKznY7ykMV+A@mail.gmail.com>
Subject: Re: [PATCH 1/5] selinux: reject duplicate symbol values during policy load
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:36=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The symbol index functions assign unconditionally, so two symbols that
> share a value silently overwrite each other and leave another value with
> no entry.
> Reject a value whose slot is already populated, for commons, classes,
> roles, types, users, sensitivities and categories;
> booleans already have their own "declared but not defined" check.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
