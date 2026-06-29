Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8673B42D1;
	Mon, 29 Jun 2026 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716491; cv=none; b=Zbv56YUaY7UBjDRClzhCsOkt2rrXcY2ykWU395OMI2CXzdyNnCxh10623+oe3uumq0tClulSIJrpCGw4AInYGvACcqAO3NrM+zp97YTE2CbjgsGAFlffLljsB/pam1bme1QGPDHscierO6srffrW/7ADmNArWEEKOR2AJJ2Vz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716491; c=relaxed/simple;
	bh=lzLSYvZbviL4rs52ym+OFLsTQEUztIMyXP068DRiYxY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l4T4HpnT+e6glFs0cg3s1jD0/YzdE0xK4EaDxDA6wBPsjMxA/sMNQQ1VhiXZfo3SaTmTqiOXYCo/xqD4/UUbv7w9eBfKV6dnJm4HbKyqTALlj6/+Q29GYftY6GJA/Y1TYYGo35j6lGjyCpJDn3wAqNfRfM0OUroF+UytiwsPweo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXbgl2nz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXbgl2nz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5AF1F000E9;
	Mon, 29 Jun 2026 07:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782716490;
	bh=/ojqVuQ8qNG+9pku7O3Xen50FGMQw7w4aioRIokPfmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KXbgl2nzWVDwqxs8wW7kmCZnII3KA+tTMBeQ+y3RfqknR0cMBzXawDRrALx9kDv6P
	 +KEd6kxLuldM8pComdZI46Li6hY6+fd3DhLptYvepaWVU/trCCroDigjRgxuDd7m/h
	 v7hwXIeYKo8zc7WmjWdebmG+6VN1fRvHJ2g/VdE9yU8qbGXf54xj+wJ2n88OheP1r4
	 8QOSTwgKvEldQxU930q55ezS6DOyIZVjS07f4YfLbKbFSnNL54f6bAhhXgZsWHMsv6
	 OnOlcDQG4fbdciKjzpRjCB0RZHAbqFD6N+bBuna6lOkIby0JZCVOEneLa8LRA1sZzb
	 iSaFbNwG+NC8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 stable/linux-6.12.y 1/3] fs: constify file ptr in
 backing_file accessor helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260629070338.578858-2-caixinchen1@huawei.com>
References: <20260629070338.578858-1-caixinchen1@huawei.com>
 <20260629070338.578858-2-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 07:01:29 +0000
Message-Id: <20260629070130.0A5AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The helper backing_file_user_path() accepts a const struct file * b=
ut returns a mutable struct path *, breaking full const correctness guarant=
ees.
--

commit aa7c0a70405fd2c0d95c3745c9871a3e87c26cc3
Author: Amir Goldstein <amir73il@gmail.com>

fs: constify file ptr in backing_file accessor helpers

This commit introduces backing_file_set_user_path() to handle modifications
to backing_file fields and constifies the file pointer in the backing_file
accessor helpers.

Link: https://lore.kernel.org/20250607115304.2521155-2-amir73il@gmail.com

> diff --git a/fs/file_table.c b/fs/file_table.c
> index 2a08bc93b0b9c..75a1908d51a9f 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c

[ ... ]

> -struct path *backing_file_user_path(struct file *f)
> +struct path *backing_file_user_path(const struct file *f)
>  {
>  	return &backing_file(f)->user_path;
>  }

[Severity: Low]
Does this inadvertently strip the constness of the input parameter by
returning a mutable pointer to the internal state?

Since the stated goal of the patch is to constify the file pointer in these
accessor helpers, should the return type also be updated to
const struct path * to enforce full const correctness? Returning a mutable
pointer from a const object could enable unintended modifications.

>  EXPORT_SYMBOL_GPL(backing_file_user_path);

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 87720e1b54192..70bbc00a2bd25 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h

[ ... ]

> @@ -2738,7 +2738,7 @@ struct file *dentry_open(const struct path *path, i=
nt flags,
>  			 const struct cred *creds);
>  struct file *dentry_create(const struct path *path, int flags, umode_t m=
ode,
>  			   const struct cred *cred);
> -struct path *backing_file_user_path(struct file *f);
> +struct path *backing_file_user_path(const struct file *f);

[Severity: Low]
If backing_file_user_path is updated to return a const struct path *, this
prototype will also need to be adjusted to match.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629070338.5788=
58-1-caixinchen1@huawei.com?part=3D1
