Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A594F1946DA
	for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806277; cv=none; b=pbCtvNgDq/5By42Bw+H3u6ZW3Jsl8N1yIxLX1Zru0gOpa3SVXKige4BM9lHTtEhtG6wakqTHFLufloJTcMeZZUH5KGrxguM6yWe/17Z0VMoiA3tXP5mPbCS0AhTSUqQ1N0yWG1jkN+PSnPQMyKuJUhBzXVyr8bgvp3LiNvNCXHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806277; c=relaxed/simple;
	bh=ZJ4DMFkyVvE7aVUN5OK9ErlngkkGtwrs8pixxLS5A9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpBgyqrvmTFZcqzEpZHK3CKNHVdyHVliQLoZjKqOfIYZHr2+ocwsrN+zpvLRYFRrXAI/n5shuA0wcWfwk0DbBhCdHZT+64aiPqdWbHcC7lDPVLjcFbUVmjTSy7W2lOwU6n/w1oIE1d4RwdvQHWQAsNY5ySWhNPaSJfPKtK1JM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eGenadm/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eGenadm/"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so1558688a12.1
        for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758806274; x=1759411074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WtopI8TH2twCLYti2fdQ/udRigxL3LsgOlw73SwsXw=;
        b=eGenadm/DHlSFwzdg/gl3uP+dHn8fw96eNNQoxlemVWnTsz/FbGAcquAzg6j83BhCc
         e+SCWq5iTNnemNsrf2cYIOYIu7yulPv1PDGCUTgVm2JgoN8u4MnpAbZ6FGNebvhBHrQi
         d0XxAy0+FNDnWfu5UK4udglaZ2rN/2yTWi+9/Kyx2CTyUndAOC37Tga8aDIp5+XByWlG
         rvfnQ3ablDIdLEscrCE817BszBehLXFiP/mAlRAm+f1JkeKRiL+fWwYiOLtremxmjFsW
         qz3Gbcu2bE+QHNiwtrD4xpZeh+6ve9llZdMuCJmKOE7hLiKwZ+O4Ow8hjTzG6y6a0jd8
         o1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806274; x=1759411074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WtopI8TH2twCLYti2fdQ/udRigxL3LsgOlw73SwsXw=;
        b=VF2rvikPB8ipEwSDOXmzuAQ3GBaFVjtp6k6HdyR/5fQVaA8cCuFDJmkBW9kv7mN2DH
         CJIc+8ULv9s5RpUMh9WnaYELhxgT7NTL7t6YBRPitfUrsmvL1ZGJQBExg7T8+wN5jeoj
         9Si/RD+uphiiebezngSzMu62OtpmbC2re0nGg8frTDO2PRsbBJ/3TnK5N9dkUWubB2n5
         q/eTJuV8HntbGQm87987tAKELrvkcMtBWi9jfRK94opdEfxikhlgBoLiH8iboeMeN9bp
         ILV4kWBTOK2Theyzjjajh+f4V7n3gTnbsJSd0ANJazqq7xoIf25YrqkU5YXtrcGvrrCn
         36nA==
X-Forwarded-Encrypted: i=1; AJvYcCUWC3cCO1zgh6IPYRRr6GFTi2LZeBrTfSVW8BJAZVRF5yCIJ0Myg/QTeLvSDletR3ObSQ1MTfjj@vger.kernel.org
X-Gm-Message-State: AOJu0YyqW08SpC+hf3JoIzihLb6BGnIladggI1kYXFN9AN0CszE12ZNV
	cpeyw3uAIYarLX/efpSlEM+w0pyVXcNK6VB7s0PsvTo3AnKaRUs0M5oAAQmgR4loHDxF206d3GF
	XVestjHaTbGw9zWtc2XVxL6fzIf3Wtu0T1GfjqDgA
X-Gm-Gg: ASbGnct/YbHLmUVUGOCgug28c9PsPRBMq6EPdzko9BEotuHqWYZPypKmuMwPYG5RMSw
	VBM2XMl6YLjc5T62CkQXTBSfcVUIeucXRAPkMVeCeH1DMP5h3yjuACc4Kzgvg0PzMFaw1jnKJ0T
	E70+58OdPYxIWrtNHzPbGroLj9+Fet8jm+qWIOPELO7T9SoH8/0j2hLF0WQI976jA/y+225IQ9p
	/1cug4=
X-Google-Smtp-Source: AGHT+IEutpBsfshhNUJpauSSeHahyxqkZXNCfoDjRi+/NaSQoq8uNgNrJA7X/ZAfGmasEigKhk6wFxyyFb6f3C84tuo=
X-Received: by 2002:a05:6402:3593:b0:634:a23e:df34 with SMTP id
 4fb4d7f45d1cf-634a23ee390mr2412727a12.12.1758806273814; Thu, 25 Sep 2025
 06:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402153526.ua7jdw7xtgda6qo2@jmarcin-t14s-01> <DD1MUDR1JIP1.VWEIIPWFBN8C@gmail.com>
In-Reply-To: <DD1MUDR1JIP1.VWEIIPWFBN8C@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Sep 2025 09:17:39 -0400
X-Gm-Features: AS18NWDs4_MtuhOeWJVfAeht2ya9zGLB3W3EENQjV1dSB4MGqu-4Jx3DHDmHp2o
Message-ID: <CAHC9VhSWuDop7rXYEhaad75__ZWY03f0=6zU+Y1RJ+fOkf2X3A@mail.gmail.com>
Subject: Re: [PATCH v5] selinux: add prefix/suffix matching to filename type transitions
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: juraj@jurajmarcin.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 1:30=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Hi Juraj,
>
> Are you still working on this patch? If not, would anyone have any
> reservations if I pick up work on it?

Since it has been over a year with no response from Juraj, if you
don't get a response by the end of next week I think it would be okay
to take over the work on the patch.  If you do work on the patch,
please make sure you give Juraj credit in the patch description.

Regardless, thanks for your interest in this patch and willingness to
help, that is always appreciated!

--=20
paul-moore.com
