Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB731B3925
	for <selinux@vger.kernel.org>; Tue, 13 Jan 2026 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323431; cv=none; b=d1vVgvnBmJpZI51v1Rkil+53SUY9wR8AWTCE+xp/Efbv53QQQcXitux173Yg1YwFckR8kkOzY6WcwxU3sVIO2JluXXl62D/9iusa3EnXvhwKGQXEl2jKuDWhBlxS0I+X+raYtuPDam8Dlh4jFi9zHo2eLwO4Jcb+y0KFutWmnNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323431; c=relaxed/simple;
	bh=POn/xvYsV52oDVAWMO98WPb8zT0z9ad0V4KDRdF9KSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=q3QGZgJeb/QCdSH7Mku5vVu7ernSq4mW+aSPexaJo9OwZ/kIrrSnYhANWo1wXlUPcul6zyA1qUdUUtF+FD5tFpqJHOTufPdw/sV6hAw+RGgXEQPwj2+PoBufEoxk+U6J0Z6gWxdYMrnNFZO7ojpkj5Hb891afQA5pS23vlzBHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dkVWOA6g; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dkVWOA6g"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso2895729a12.2
        for <selinux@vger.kernel.org>; Tue, 13 Jan 2026 08:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768323428; x=1768928228; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDq6IojhqiDne18lmeVfmVtdRPmxKSzqUNMOJuvwU5c=;
        b=dkVWOA6g2b9bDx1JLgY3PGVX2loNFSRYAXhBWxVgEf8n7ZOGRhNPL4aMFbLiDj3BdU
         NMhtSkXlX6v+KQ/di/hWoe9+Wu2/OvuM1Eob0IAod+JHc/RSBM/YfHNE65XwnPwn/0se
         xxc/mJhvePxL3fBIU71iNEQInVbSVt6vvNzMWRsa6jo/h9OpdospDH06xUzwtfMAe9av
         ClPTwf5COZuoTKGR3FEQrc7/t9Ov0DmbBM68diva+FVChZxgsxDTQaDi2ohJm2fJsOnX
         XXs0JE9ximLnmYD9Y4UwaXVa1hk5B1hir/jrXDzoIVvn61rrNYm23U8jAeoQZrG824cO
         UlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768323428; x=1768928228;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LDq6IojhqiDne18lmeVfmVtdRPmxKSzqUNMOJuvwU5c=;
        b=ONphCfZqOGr0VHVvsYNIe5mThKVirvSjC01ZfRrI7g4vFNrLyoIo7tYIQkmIPPS4ow
         Pb8E4df8dnsC4hj+qC4fQfxR3lpOYCsfMxT0H9u4BXgnENXhcpP2MVGn49EjLCwOpuic
         2NTUd2+7PzoTyToL8KKVhhJDEZdqpu82YUx/Dmpi1ZmBPCDMMLLI/bEJ+eRL1Ec9Quo7
         kQatLjt0DMa2ABjmiVN9DyKtM9OksrscU/ygta815Uu6GCfjdHkxb3UdvoCeYkm0OAZN
         UslWDBj7ZV4KeGvihqouLFRRT4kEsIUSZj3dCWwV/U8YWCinLmiHf/OgFJ8e71xU3qFk
         SAUw==
X-Gm-Message-State: AOJu0YyXwi/0ZfATE5pIKQ4CkRJIOWDoEqG9+8lbmxjuqoaMAFG8aC4E
	6bTAtzk+/d31RnX/9Eqrkm2s8RD/TrNul5pjU1sxedR3Srh7+VsSCyThBhPEaORjEmu57MewrtV
	/2wln3XnQt6CgjGVa8zX3HZpMtxPCfYAo4MaUWT5dWlA6CpL9/P0=
X-Gm-Gg: AY/fxX6oBfDaVAn3l4aO7suOI+22633DofxKq2+ujsE3BW2um52tpCPJjW9KhYydd78
	fk+XTWl46+6psEADMViNBrozflnv6nrp8Cm/OVd2UMxIG4yrdHJtpqZjzVhDVHHL2YKWJrEmE2b
	jMSc846NND66ndeQZj9jVfo7LR56RY0eiosfpSEu3Mv774v8geCG9O4HJVguH7CRlb5+IgRdgwl
	TSrXkcODvkBZAzprK5jrkFuw2oh8SS4xmDNswPPf3bceqh/8gCPgVk63UGFRfXVlV4Wb5Y=
X-Google-Smtp-Source: AGHT+IEIIJEHUFf2SFNGNqyX6+jpJBq3GyflNHmNr4trGPXp4jwLcEktGFEiVX8tj4Du4B2oIt7e8uPcg9uGWyuJiY8=
X-Received: by 2002:a17:90b:4ecd:b0:336:b60f:3936 with SMTP id
 98e67ed59e1d1-34f68c4ff5bmr24635090a91.12.1768323428501; Tue, 13 Jan 2026
 08:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109223931.393478-2-paul@paul-moore.com>
In-Reply-To: <20260109223931.393478-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Jan 2026 11:56:56 -0500
X-Gm-Features: AZwV_QhDa-AndjxK2ExI2ogUwZhE42xr83mJXseFL_D6wWMptByTREbM3mBP4b0
Message-ID: <CAHC9VhTeV7LPujEZQ5-f15bjti8kCK8p-fKUAkjrE510y-RHfg@mail.gmail.com>
Subject: Re: [PATCH] selinux: move the selinux_blob_sizes struct
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 5:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Move the selinux_blob_sizes struct so it adjacent to the rest of the
> SELinux initialization code and not in the middle of the LSM hook
> callbacks.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 42 ++++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)

Merged into selinux/dev.

--=20
paul-moore.com
