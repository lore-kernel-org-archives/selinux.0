Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A15157A61
	for <selinux@vger.kernel.org>; Mon,  9 Sep 2024 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893858; cv=none; b=IxwzImhIplqeYp/YBr0fRMCcwogFHHGmF2BPq4boXQ92Wdl14D3Pnoj9EL8x7O/qesrut+a51Uiy3Zih3lvI5hAGzx6zaVd2lWL5l3BHqUr3apzT4Ces+h+oIc1jlmUUdKLwQRQ7V4SuvDqojDGUnq47h5tA9oe6C5Lx/KzB02A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893858; c=relaxed/simple;
	bh=C3eFWjEINqYvmJ+hHlWXOonq+P5fCgcDyD4jfpHk7ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhdfharIjH0r39MekhYD4UW0txD5HTJY4uXoeg10mI5fp0tDlK/L2zQ8w8BkJti309QsOq3agLXb25/kf1HXVOiLRxM45UHyea/TqYRHjG5RZzqSv+EZTD7JjOKXwLo//Z88nEGIAYCvxm2LCu2gJ3O0ZLAs4isfve9CZpBYp4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLpvpswG; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLpvpswG"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2da4ea59658so3160805a91.0
        for <selinux@vger.kernel.org>; Mon, 09 Sep 2024 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725893856; x=1726498656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9St8A9rEgKQl69j9hxStNJuuvE3DFy9k3jn1cjLFI3w=;
        b=LLpvpswGPmt9hy97wjqOAhBPIo9RIezhGYMHhzUXbLJn7CnywOUotxCTvMuYRDHyK2
         XWJKYrYgrUXW/3dhTNi99NVhf6uT7gL7bofizyRu+Dlj42N5j2O3VS4Ycx+XF3ph04MH
         Q0LahopjopA2yJYomXRsStUrebNQ+n0mz/xA1v981Blvu2NI41nQLMW66pPBoe3yCViZ
         x/aOydF7ZiQ2bIyBqJJ9FHn2Mg8L7mwNTlG05FLIqIjHj1USIUEzMUsVpB9yv9ftYRQB
         tWJpZad4JekXsJNoXjirjTCwmZSu3xNweDLaeXuPM/ALryV6TLdDENoIUYrChhU+M9DL
         vH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725893856; x=1726498656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9St8A9rEgKQl69j9hxStNJuuvE3DFy9k3jn1cjLFI3w=;
        b=nno3otj9XPDArS3USG8dH7o5vwBCkLaldL+/lM0a2YW2gCvOoaCfbzNRTV/Jdk522Z
         yN/K6oc1jrUUzTIuo5BpJZxl1Mbl+teNCmhePq3pxbRNiy+A5ZBjbRzv3WHWo1rTmNxd
         9vO4wQVbJD8dEp485IwIxZD2tdLNleiL3t6gAE/+kRMU6UgORiNTnyiCnabkrU6XjALv
         8GDZsMPtTXQH9qUa4508LebVP0nGAd4ntduLq7nj6mz/msYyWp5N12RmBE6o8oPClw5S
         wHVxhsKHznLXuQrv50m/NVEviX3BzGYYRk+tOAM8VUy1Wa+26uUB/0KauJnp7rMNbPgT
         DDMg==
X-Gm-Message-State: AOJu0Yx93t5pUzJF6AHfOfup9KfvZT6yMGvizDJdtbv+EaWIcUdd9U7D
	0JIjZcy5u22PMNTPV8hWbISIrbcMwV97Ty2H5YbIZTgWH+dThOB23RgGaGQtVDrBmg53dN4ZfUS
	05+1DJTObOMe8HvegdELV4KG/18H9KQ==
X-Google-Smtp-Source: AGHT+IGthFZVmYgeKIB/i0umYcRUtvvQhqMGd5KwSPDgLGjdC3bVEtIHSkDt5aSqHKOnydFKfkyvQWR4tiIXC85aWto=
X-Received: by 2002:a17:90a:b008:b0:2c7:700e:e2b7 with SMTP id
 98e67ed59e1d1-2dad511264bmr11061673a91.39.1725893855962; Mon, 09 Sep 2024
 07:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909090236.194250-1-omosnace@redhat.com>
In-Reply-To: <20240909090236.194250-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Sep 2024 10:57:25 -0400
Message-ID: <CAEjxPJ7nto7+VxWm-BUwD1UNBZ03P0oB6U1rj1O=k-HAh1R7Fw@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy/test_filesystem.te: fix policy for NFS
 over a symlinked directory
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 5:02=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> When the curret directory is a symlink to the actual selinux-testsuite

s/curret/current/

> directory, running ./tools/nfs.sh would fail at nfs_filesystem/test due
> to missing policy rules. Add the necessary rules so that it can pass
> also in this scenario.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Otherwise,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policy/test_filesystem.te | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
> index efe1f4d..f60b0c8 100644
> --- a/policy/test_filesystem.te
> +++ b/policy/test_filesystem.te
> @@ -31,6 +31,7 @@ allow test_filesystem_t test_file_t:dir { add_name moun=
ton read write remove_nam
>  # Create test file
>  allow test_filesystem_t test_filesystem_file_t:dir { read add_name write=
 search mounton };
>  allow test_filesystem_t test_filesystem_file_t:file { open getattr creat=
e read write relabelfrom relabelto };
> +allow test_filesystem_t test_filesystem_file_t:lnk_file { read };
>
>  fs_mount_all_fs(test_filesystem_t)
>  fs_remount_all_fs(test_filesystem_t)
> @@ -44,6 +45,7 @@ fs_getattr_xattr_fs(test_filesystem_t)
>
>  # Required when running the tests on a labeled NFS mount.
>  fs_getattr_nfs(test_filesystem_t)
> +fs_read_nfs_symlinks(test_filesystem_t)
>
>  # Update quotas
>  fs_set_all_quotas(test_filesystem_t)
> --
> 2.46.0
>
