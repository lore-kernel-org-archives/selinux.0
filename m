Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C53A8FE9
	for <selinux@vger.kernel.org>; Tue,  7 Apr 2026 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564090; cv=pass; b=JfjyCoFIy6Rsed/cgjeZroIT4TF7KhWu8Bq50dQ8+3ss/wqFz4RRktSfjgB8uEkcYl/venOOQ2dWXKVTGEYU188JC36TQXdf7iiW5r7vUWd2LeXdT0K3Kmp3hZNBIugiEkhwQ2bYvrwl/xb2ldr3Jl9uoRUvjtQt5eMveUZOYGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564090; c=relaxed/simple;
	bh=DYtH3ovqeZiNqkreX7Nz4nkPWobgUXsJ5dwCB2BpWgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lh/9rPVw3IDOM6n6Lku37lQXGzyjsM5Tzl6anSZ4KMVE5EnfV53tWkhhMTUUKthwoL4YQlS5N8KoXdMD4hRos902GN9L0n7sSLtfFusvIeRNijrA22oI1hyrH/4MLiUT4qLT2RvUy6sSTCyPJtlPVesT4CeCBNiTczQeCo1CRz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVZPYGFy; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVZPYGFy"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-358ed696623so2112244a91.0
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2026 05:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775564088; cv=none;
        d=google.com; s=arc-20240605;
        b=Rafd/GT99RQzmd2ASgxlei9z4KMjXSj6skEYOc+mQVS6QCsdi+leKE5Zhv45J0ERBd
         KSAspnn8tcfOR4/mGBuSA3cNIbd65KyWKVHF1SkTHoTstGIfv7aB+C/xa1yIC4wBqmyu
         lccn1Mbjk7bLwjaPKWs3SwIVifWjWgteI7v4LzMMom0UfurDM2++xOwBM9SenT5FlPJa
         6+q8G7qqcs4DeKHek3+VWKCObuRZPsiRzdRk+bzUiT6UKtRbuBn4U3LE5olq7+5+8DfI
         wWYDQEKRw2wa2YzSJWzvjAJkEjcdswQyu2qe7kQ7t8tLHDco7NqvlkCsF0LRTXHuSHWr
         7gyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zTDkABRGJ7UHzKZMFM6DSH1URUE3mRRr3uWbQhi8EKg=;
        fh=v/RO0NxkSjYRN7Z/gFyfJkX8O1hXr/WuNS4jvZ1QCFM=;
        b=dlKxT4BxDGdTk2kcEZ6KZbNwX/OxcZlombqEjK1awqZIf3ZME31ffSF34A1FF/9Dot
         giGLW8qWmYcvWRMyR5aHp+GIHbUXm8GET4x2ZrPCEL0oW5CdGKNn7d59UbmzxdfyMnmJ
         G4coKKVMIB5xjlXs1K5/6OBhz3u+T0SS0kP5lqtOU5ZuGrPb4C710s97k1i4how0YG7t
         dj/rSnH6IseDQs7RhzcyleCna6A3iGbZykmYetyR+3rO0HGHmNzpTg7uxJ1GQ0QVidPF
         t49pWT+CGVDIxECEupN9IXs37uVqfX0yAimqbivwUi/eucruz9L9XjFbQANqssw/yHtB
         jejA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775564088; x=1776168888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTDkABRGJ7UHzKZMFM6DSH1URUE3mRRr3uWbQhi8EKg=;
        b=mVZPYGFyBgGtpWk4sX37nuVl392e96R4bjfs0ORNcxHmm4repjBBJl6wER9s05QPRx
         u9yMmyrIxhKtFPIgahhJkUem9XXnOt0Y4udHqUe5ZV5JLiunPgHbLwuF5YVLX9xOMwfS
         SHajj6jRYt56S5BkSVItPD2zTTs+S886TqgSWf6wGsfmVf48l/adO1vgGfcBxFHMUdKk
         98zAae8oxZWozMTxhB3oIy7PG5AaxmT0a1YdtlKIlVFcGbOdculw91xtDE6pfiAGsJ+L
         dEx4POQKFfhhxVSIboL7SSA5JB8IVPNytMGFiSoathMYqf1+sLX8Za9GGxj7OoZpqzGF
         gAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775564088; x=1776168888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zTDkABRGJ7UHzKZMFM6DSH1URUE3mRRr3uWbQhi8EKg=;
        b=RMYs+SdeeqVAQZcNSwTCMFFyRRAm+jPgoeM5u9FxBS7Hg34YHHm/szLd960LRhxDvl
         txRdSpvMObLDdTBsyBjUcNr33rnLnrj7f7WQGX0fNr5de+m71TqT1KttGoh7V5JUQEvZ
         WvAAQDtdw2uQPrzdcX7lB8X1izm4AaWlSxcbdjVfBMKK4SXWfGMpehIc60EFBWFbC+Nz
         aDBJ0Q+wmyVFIsQaro0EbfvU6g92nQR72rhVmm8EZkxOi4rp2PXeU8cDXot0eNGuj0ja
         T3GxsAJTppkGIgEJG3ET4WjWpiusXsELdYzbxM3OYtTcJ2pdSD+LQbYknbNYZ24ZgRbj
         kgMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd7DdZUmhJgqxPXRjJpmlfz0Kc0JEzLXGRAk6fe2rMWvu1bNlR4cmUlNpSQw+WZbrob2railBd@vger.kernel.org
X-Gm-Message-State: AOJu0YyaCEM1pWCMHETQ2Rj7MVdtu0BjZMMsxhICsG0iq/9LZc2yZQje
	xQDZMOncsGMUgyFYpjIM23GXD2MxLYPoRVqwdvm4iA7/y/wIbPHH2OkxCVU+TV3PvAVX7ihVrW4
	hyGZRm/aVGedPC/Xra/8GpTTLIp47rhY=
X-Gm-Gg: AeBDieup4Ld8IyyLWHz5eUbzCJPsEzZuYYILlOJGMx7q58HEaAUmlqGxgvzAXHlSYJ8
	LGFa1Mdf3W+HAbqL+hHp6ZN9tFMLk1lqIy1u34YZZujfVhnUEs0C5YMGOFxZfki5S1Lod78v2rT
	XIpDOKjbz5ywmYn8MAr6/QK8gf2SFRUxS4/P7sZFRzE84TUIpzA/ahr2Jejzx3MKBTX+wNUNHk0
	xwYVTLZJrxeGt09Vra/mh82IxWwONQBQ/UakHqiMJfV7bdAMqRERVg095m5/+0TqkEztGOOfZtG
	Ye/fjys=
X-Received: by 2002:a17:90b:3d4d:b0:35c:d37:6024 with SMTP id
 98e67ed59e1d1-35de67ea9d5mr15645164a91.11.1775564088070; Tue, 07 Apr 2026
 05:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
In-Reply-To: <20260403030848.731867-8-paul@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Apr 2026 08:14:36 -0400
X-Gm-Features: AQROBzAHeiE5r-KOh8TmARe6SlYgAd0n8yvhwUwHmTAae_PdDX5ZmAScFcPTcfU
Message-ID: <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Amir Goldstein <amir73il@gmail.com>, 
	Gao Xiang <xiang@kernel.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The existing SELinux security model for overlayfs is to allow access if
> the current task is able to access the top level file (the "user" file)
> and the mounter's credentials are sufficient to access the lower
> level file (the "backing" file).  Unfortunately, the current code does
> not properly enforce these access controls for both mmap() and mprotect()
> operations on overlayfs filesystems.
>
> This patch makes use of the newly created security_mmap_backing_file()
> LSM hook to provide the missing backing file enforcement for mmap()
> operations, and leverages the backing file API and new LSM blob to
> provide the necessary information to properly enforce the mprotect()
> access controls.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Do you have tests for these changes showing the before and after (i.e.
failing without your patches, passing with them)? I tried running an
earlier set from Ondrej but they failed.
