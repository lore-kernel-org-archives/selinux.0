Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B3182D0
	for <selinux@vger.kernel.org>; Wed, 29 Oct 2025 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696298; cv=none; b=BdRf8Y6xWn4BtDQnxWhjHt7lN4Ph2vPi/TiBjpAKi9IWAm9Dmfu20LRpYOo3gMybddNH4ODcLCsZltsdNLuwYdILDmX/8Ez+L36yAbIeOLy8yYMj4ggMOJepmn0vrm4Bg5qxRCZyEYGxCo3HmAzti77IhgjNT50yCajAfcWE/hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696298; c=relaxed/simple;
	bh=qF3NtATOlOxjmKjh31CoJ8+W1noziSRiCQPVNghpJQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjyCkBZyWqbTZ6ksGgZOqze9gNlrKLAUtV2ppr5oGfLqmh2N/UBEXZjSoCskEzZJwAUvVXM8UvEZPrM2BQgeRZsVFu5Ry2VxK+ViJEhS6t3cVObiPu+YUJVooieRpEt1laGh3bva8ylo1tVZMQICDu2nR4OOpN+UsnOTJWrzp+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YbZoaS4q; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YbZoaS4q"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33067909400so4949415a91.2
        for <selinux@vger.kernel.org>; Tue, 28 Oct 2025 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761696296; x=1762301096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BerLOcBoWrV1cLwn2WvSsreg5PxA+PLtgWK6veAyVuE=;
        b=YbZoaS4qDsxU9JuqQ4+3At4yH/xb+t49dYMx4ISzdT10Oyh4a4LL8Xoth4UBNpPzur
         itM56A7SQV0GUZ5w8xvciREEGwmWVcktk+WNgGo5xRpvGisMiQFBUmzHNigbgsdLltuz
         +febz2p4RQxz1twT/85RYbInr8Qcj/hdKgsarSl4+IMbNiaHEfL/ickls/wMnIg+xzsa
         4IPwCpYWb2isD1NXOYAbyvihlOi0GryBRt5RCIxfsk2RtMvDS6iHlBhho9ytJKF38Y/X
         R2VWfvi+gGlciUOT1SsgwNss364GzmiITVWZ5HYuAohyrQ6dwaDR9zKMuNdpsLjDsniV
         i9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761696296; x=1762301096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BerLOcBoWrV1cLwn2WvSsreg5PxA+PLtgWK6veAyVuE=;
        b=l2LuSOISsZJBFQUqHgBEyOluI9eungBQi8crAl2DhocQuKtJ954/L2QfZxtn8+l3Oi
         Z50UNKmffLmH1WbRz7JXNFz8QXqWEQ4h77Ul7G99S49ZJOo27XJlgOR8ATkKnUfQCmIx
         IjCIOvSegV1qklTOqrBsTlYurwao1+4h91fwTxgM6DtiWPQNv+KCiDHo5QkopHqXtM7j
         fh1qnYcXvYPdud5XsQmG37Q+qvq3On0ndAMm+69I+ng4a2tvU5R/TO3LQcGdCjJUos5Q
         gNbX+lnluBZtrGcLUwHPVipIfc/jXvkWRI6wqtCcjraJSMSwnEFuaIIWiADF0ynuRTLm
         /i4A==
X-Forwarded-Encrypted: i=1; AJvYcCWCD1yHgqEBnJpWFIM+YSTM5yUxgCTl5qh49sqvaULq4j5yb76c0lia2M37GsT1tY7QnVEE8nLW@vger.kernel.org
X-Gm-Message-State: AOJu0YxkxJXy4+IHPyCvtURgTneUVTJ4Gdg55Zv2NisGFErUDGB/xmH/
	ZzCNu2gZJ4YOyC6uootl1hHnhO9F93SnCp/3z8qH5nSnV+qGaSu2/+QuWRPKYUwBzLk4uDt1wIx
	zhRWKPN6VAX05TnpD3C2BBj0xxhtn2GfPMxPV+Tiu
X-Gm-Gg: ASbGncvMRBu0SUk/cv6dVPzOX0Zrkx4A2YmPzED+wnR2x5c56Tf7O8KaeljzWhVkg3i
	dDgZeVCFLXWDDQj4DUU+Bl9179VBJlRhbFvI3gFIQXtmPl7G1BK5zNtD14mlIfEPvQdLFfH+8z5
	ZaoctTQ4QHxzHEiLyksFGpbqVQjOvD+UNtQng+hUD9yQ3z/3NSqH5dQxfrPc42vkG34SEO/ZwEX
	pNQWWvtm9S8S2OJ+AN5Tmi36L0A1JgjBztdpt83Z0sOV2lCr/G7QjD554R1ZAAfIB+FAhQ=
X-Google-Smtp-Source: AGHT+IF9Sg8XTJhY1XF+gNJzXx33YCPJNPvD397jHY3K37ysFCuyvsRKOtkLfk2UKLtdow89RUSTsoGqlzXNXJIH+YE=
X-Received: by 2002:a17:90b:3147:b0:33e:1ae2:a4a7 with SMTP id
 98e67ed59e1d1-3403a2604b4mr1039988a91.12.1761696296385; Tue, 28 Oct 2025
 17:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-50-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-50-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 20:04:44 -0400
X-Gm-Features: AWmQ_blrbvCvNMESns84vcg9Bs91_mExO5kolf7cbCdCoz5ngCaqmvIG7Oeo_oM
Message-ID: <CAHC9VhQH--uP=fWo0MsH5=BojV2qG=qy7A9tHTVOnLYOxKbV5Q@mail.gmail.com>
Subject: Re: [PATCH v2 49/50] kill securityfs_recursive_remove()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:46=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> it's an unused alias for securityfs_remove()
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  include/linux/security.h | 2 --
>  1 file changed, 2 deletions(-)

That's annoying.  Another case of
let-me-know-if-this-patchset-dies-so-I-can-take-this-patch-regardless.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
