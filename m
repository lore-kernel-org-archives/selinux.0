Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C81C5F23
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865353; cv=none; b=ZTk9WfuWm18iWW5uTe26sLTbipvul/ObIqfoen2yKHXz3C6hjC9/MsjY/ZOqrFGWgVgXYKUFPrKmwA4aUC8ghkgITGmx+ZKQtiYG0Lh9X1i+f/SXdGWCYBnK4ZnjV/ABFfFwAY6RaWg3bjf1+EZYUR6iLL+auQxozXMIQQQYdJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865353; c=relaxed/simple;
	bh=Yq4A3aAneGBJMf7Pq2q+VbBOeQmX2sByHaj59EwJ6cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8TEjT0UtVAES19xQrTIkWcn8Vf3ZK+U72ukka0BKnlGLCpnbJvwHa+IKD+ndoh+N5WQgdX760vkn+HkTCvyn4CtxE6Df4Lp2FRB2vVNaeHSNNNkP6WG2OY948ovRYphk9XFvJ1biYUEddi5PMTtdAk1qcraLUnun+Em02fJKcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TWaw5m2w; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TWaw5m2w"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3306eb96da1so5531964a91.1
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 12:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1759865350; x=1760470150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCPT61E+gdkaCNPxS9tVsNBNendxI8W7I0SJKezwxXg=;
        b=TWaw5m2wzEp0LgbS8Kq7TrCUDEVfJu8k4MhfGhGiETsW/zmLU7CWjK05A951tn9mP9
         HXg8wgqbw4olbCg+BJuoV1Yb9Z6QxBtMW13m4TIXDFnaFetMer8C0CXDEgQzfR+LSYAH
         ym+GsrJ/p+HzaDZFndV0wn7skJEKQoAckSz43J68HsiU3TgNQ6yQrXLyo3ipbBemgzgn
         aVruTGs/XIgwADI98J3aPr03gCX5zZFSNhcI30TF+E0YhHOP7LlKD0j/KsOMv1IJTsKp
         fnMBsqdaIuqrRMT2yvt1IosA8Fa6fafo8qPoRrTiN9o2GrVmp2Z1k3IoYytxzolf14MN
         KLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759865350; x=1760470150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCPT61E+gdkaCNPxS9tVsNBNendxI8W7I0SJKezwxXg=;
        b=OoKB+H17cxNAqWOu5OYdYjkKfRbVkO7VNJEiPQTLwZ1UpfWKoLXjDQxANTa1qzI3pI
         bXx4vCjIddlidENAXWZtosOt+5GDL66+q498VnY7uLpD3VsMWFivCzJMkEKSmlHiWalZ
         IYfFC1CYqTYXVjwrZ7eDeL3I31RNvUXt4CabU6onsdPWOSNWtCcMjXiUEAdEHjX816sX
         vS3+gVNbptu5awR16+FGntPppMzqtdUXS+qDygNIiEaMbZxHIY3HBsJnZT5IMm+I8Pql
         ADBipijcTCZCHY1mOrpXTy1I55yqu7pUFesEWnwtY1/CkBUlxKXdzJFDsgwgyKNaTnJq
         fNXg==
X-Gm-Message-State: AOJu0YzcR3fR4DoGFvkQ0uvDn0OdN4mT9CV0r5m8iiH6iholuv0M+6WD
	FxwhpuP/x1TEgED6R53yR5DL7VWaTu7DOFjgGUn/ye3gfxDcJzHTPcPRW+tkDqP1beNEkqtm4I0
	ys5rTpItfZMWdSLQGlG2CxIsH9FZT1H3uz1kaM/s+
X-Gm-Gg: ASbGnctC1DcpJ/6s+AGSOj2YBuucGIKrGZafS8aNfcaP/yXVqsJddVju/ymkpJQ5DnP
	HYlT2SloRwcYxFIpaIBiX+76XbpiauORPXo/Kpv8FBzXBe+3zXdP+ovKmt5eEnGwxFr23SXwnTR
	0yoWulmsebVcSMTxZ8CY9eU2MEdGYiyJNCd6ntuztSAMunol706LN3RGV2v9uL57evE57ZQuaI0
	poaLBXYHCzfnT2YM99dWPiywiDEpAE=
X-Google-Smtp-Source: AGHT+IFEjhoKLhEJmiqVHFw/fLI8pi83+pXDmcDWU6REA5on34u3pwCMUgxOKhiMjjcxOW8lBRLqqBRzq/k5scg+WEA=
X-Received: by 2002:a17:90b:3b43:b0:330:7a32:3290 with SMTP id
 98e67ed59e1d1-33b513b4de7mr800030a91.37.1759865350172; Tue, 07 Oct 2025
 12:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007183552.74330-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20251007183552.74330-2-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Oct 2025 15:28:58 -0400
X-Gm-Features: AS18NWDf2s-J4iOys1ZymJjdlywU_GPir8Y_LVjQzucr0sBSqQ7Z-Upqr4zY5Ow
Message-ID: <CAHC9VhS8e_WBQZu76LUqy0ydqChwxzZZVZviz_UG-GDiOfwEyQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux-testsuite: Add btrfs support for filesystem tests
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, 
	Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 2:37=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Richard Haines <richard_c_haines@btinternet.com>
>
> This allows btrfs filesystems to be created to support the
> filesystem mount(2) type calls and the fs_filesystem fsmount(2)
> type calls.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  README.md                      | 2 ++
>  defconfig                      | 5 +++++
>  tests/Makefile                 | 2 +-
>  tests/filesystem/Filesystem.pm | 3 +++
>  tests/filesystem/btrfs         | 1 +
>  tests/filesystem/test          | 6 ++++++
>  tests/fs_filesystem/btrfs      | 1 +
>  tests/fs_filesystem/test       | 6 ++++++
>  8 files changed, 25 insertions(+), 1 deletion(-)
>  create mode 120000 tests/filesystem/btrfs
>  create mode 120000 tests/fs_filesystem/btrfs

...

> diff --git a/tests/filesystem/btrfs b/tests/filesystem/btrfs
> new file mode 120000
> index 0000000..945c9b4
> --- /dev/null
> +++ b/tests/filesystem/btrfs
> @@ -0,0 +1 @@
> +.
> \ No newline at end of file

This, and the similar file below, look odd to me.  I only looked very
quickly, but I don't see any references to these files in the rest of
this patchset, is their inclusion in this patch a mistake, or am I
missing something?

> diff --git a/tests/fs_filesystem/btrfs b/tests/fs_filesystem/btrfs
> new file mode 120000
> index 0000000..945c9b4
> --- /dev/null
> +++ b/tests/fs_filesystem/btrfs
> @@ -0,0 +1 @@
> +.
> \ No newline at end of file

--=20
paul-moore.com
