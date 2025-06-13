Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA701E51F6
	for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828171; cv=none; b=VEdyE+W1joa22oE8COXcJ16wogHZgslWWuWN9GE+yWLW6mZucMZq3Wcm1ag14sCd6BkKczE7ToJliEX5dsms9PM7nG1BZnJae03AZbGHiRZ+iCarSwy2jNALz0ShtYFs+Xp7Ps5JtDS61cgTbeGXw2d7EAOUkdlA3Q979uMV4FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828171; c=relaxed/simple;
	bh=DxWOhHNOUn+QAruIrYVUGgMzF4+IGh0zdQPzdb72yz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dl6SUG5KdgDKiq9oY9dbtR6a9Ift5pIXThlMn8vC2kiOZlDnZno4b1ElJGJQ/iJZvfkvb8g3cyVpLtH9ZjmWKxsRrp/6ZH/dByaQDBJ9EyFG1ZKeVgKGSxoUpw9Gwu4AHL+c6TjyhvmABBpqk8AWLRb7iCkxS0NRuegd3kWRYtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp4eSsMt; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp4eSsMt"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso1864228a12.3
        for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749828169; x=1750432969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxWOhHNOUn+QAruIrYVUGgMzF4+IGh0zdQPzdb72yz0=;
        b=Vp4eSsMtSOJZGhDEGWBbbhclsSJaZsTnIswM5NTr/pXpVMYhZ0S/aT37yGgN+zMRrL
         j6pH2mt5Rq6cig8jHHTGSQU4BBTiPmsds0b8Aofe51fuA33Vy0Ed6UtWHw+hP/1VPgIt
         HhjscUwaJcdUblE2kT2aH3ed3N4COuPza26FsK48yFpUu9MVPCS1ipjqf95/6L5vNf7r
         wkDoNP0rz+WEhTnbnj7erSy56+GqSeM6Qun9sKCgXv+8zLypX9xJxgy1d7MLYeapgwzz
         9ZRyA6w6llrQV0LY1nxKPXEiZCwz0QVhhs/u2S5jXVS3bBr52tZe3OcNulOhYFTn/7iX
         5MuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749828169; x=1750432969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxWOhHNOUn+QAruIrYVUGgMzF4+IGh0zdQPzdb72yz0=;
        b=kDx89ubrTJW6jCqxeQ7mUsPbizoe8f7uT2OcwwA/PjgXmmJS/X/n1P7P9MqVWxxviV
         SxQZfxGN2VTQ5HoWBgM4716Ad9hiQjDY6aBwXnBZZ9UUinnsQxDeb0OLTYCElYRzhNrg
         cvNa2MhQ4/K4b6jRJqBOD3RS63ICAXnH8oDhncU3bVRn1hhP6PMCi4cKMoWFC6zAKtMU
         Yk12LcSkgfh6lQ0Ae84MwuwHe/Mt1iMuozg6xanLWxdGuRoqCKv1pHLQTA8HLd5YRveu
         dDX1Omlyxy/IDbL6MtFRpZZgHk/UkLbvnrESilkG/B1HzGVjNYXdZRF0zb4ojK1iDyvr
         FT0A==
X-Forwarded-Encrypted: i=1; AJvYcCXnhdQ9ves4erXaflRxhBGCqiiFtVbmZRO7sKBCnAwS5Yb3935PSaYUbAHu39nvEXB4V3db0w2S@vger.kernel.org
X-Gm-Message-State: AOJu0YxgXxW7WEuWv+dk9GlWdA3cwVkMhL3EZaFjOayV4FGDO/YGn/hR
	JUyX94mkRobGK/C9MfctKLqVqm/OR2wUKWXqk4eVQdAdm2T+c+/HyOb88p5Vvpzu7GjZhmK8wj9
	DsTHx85V5Q66d/lhIiUABzIEuJDWTeZk=
X-Gm-Gg: ASbGncvRIdM3U1bbUKGS+qsgGvqtW5tF0N2mfyqgdQV5HpijbXh+sUkdZnlp+JYxO7Y
	PNtiAVMTPvSLasZ1NdpouldduWpQ5Nk4dhNYpbuAQVJu1p6JBB3RMHZtDmwXTwInlwluUPHH0v6
	UZrWo0LI/kJqMbMCuoBRDoDSRcQJKYQwXeJ4yJHUnz81k=
X-Google-Smtp-Source: AGHT+IEocoqUU5MsJ+J+nIjomiU2B0juuxF5Rga4if4CXpsYDNxxwmKi1ehPg2c5qP/raoPa/U8tAe30xaSOZka7Jlc=
X-Received: by 2002:a05:6a20:7fa4:b0:1f5:6b36:f574 with SMTP id
 adf61e73a8af0-21fad0d39ebmr4735654637.38.1749828169457; Fri, 13 Jun 2025
 08:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611183234.10255-2-stephen.smalley.work@gmail.com>
 <CAHC9VhR5CZSHKo41C4PdXbeJ3OuZUQ3ue1cbk9kjkHA6thjH6A@mail.gmail.com>
 <CAEjxPJ7JAJ2aypxVyjw4KKAvGBvUVK6eCzbXF3Wd8huTSPiSFw@mail.gmail.com>
 <CAEjxPJ7YixhZOmHVq92EBVoXO5ZO9__YXhhyD7iAWMkQNV-xsA@mail.gmail.com>
 <CAHC9VhTunOdxp2v=27sAxTjQc558nwnQCT=86WR5TNP3ihSdfQ@mail.gmail.com>
 <CAEjxPJ4MS4S+O3vj+mMuKkCVx53hnt91=2ZNPiP4eY9fKDyO8Q@mail.gmail.com>
 <CAFqZXNtrNCHcybw4mEJZ6AZHGzTjtrf4LnBM6wZNVdpjqec-pw@mail.gmail.com> <CAEjxPJ4ErTOs5wRPA455cUAha22pCpvAD8joS5fZTtYaGitDZA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4ErTOs5wRPA455cUAha22pCpvAD8joS5fZTtYaGitDZA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 13 Jun 2025 11:22:38 -0400
X-Gm-Features: AX0GCFt4IOPR8U6Qqa0KyMj_f0_a9MOPDpqrZ3joD8xOVZE_2ZREw2PtfDamia8
Message-ID: <CAEjxPJ5O9diTHkewEJeB_9mA6TskGU9BSRyhbMA0YEUyq_8zMg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: invoke ip{6}tables-legacy
 when appropriate
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 9:03=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jun 13, 2025 at 7:29=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> > On my end, the testsuite passes with both iptables-legacy and
> > iptables-nft on Rawhide (with stock Fedora kernel). Also the
> > alternatives symlinks are created automatically on package
> > installation. It looks like you had some weird issue with the symlinks
> > and perhaps some missing config options in the kernel.
>
> Ok, so I was able to pass the tests after uninstalling iptables-legacy
> (reverting alternatives to iptables-nft) and using the provided kernel
> config. Will need to see if I can figure out what if any relevant
> differences there are in the config since I was using the testsuite
> defconfig, which is intended to enable all _required_ options for the
> tests.

I am seemingly unable to reproduce the problem now that I only have
iptables-nft installed, so I guess it is fine now that my symlink
issues are sorted (possibly a problem due to upgrading from F41->F42).
Should we update the README.md to stipulate iptables-nft instead of
just iptables?
