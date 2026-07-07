Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB6D3314DE
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450108; cv=pass; b=OCWecwKXlGgmkai/jz+RrfD22JMaxc5Gr0klZE/1mu6LipeyxBjMQU316Em9+Fu+jGfFbzu0u8GWRgvi2VA8u1Vli4DM0+QkDxZY3SX9fW2DFCIBni/yZLlYjaKCo9Ll8yAkWwpwtmoG8PmFWQsXOPkMM6rXe2TXryPRRs2dUz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450108; c=relaxed/simple;
	bh=rtUYFok+ac4p2ylgzUh1Lf6iBK/D4Y6w6h4iMqSOFVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ls8uCzeIk7dutnhRx4hhFt8L1/SKn7TK5Q+0hvXdVjteckvGXft0ayfrTm2hwMyg+YY0YKYdwOJLs3GlWLHxFH5vp7qcKtx85RIYXuY10v1780+oRZQRw7Zobc7z1X3kT7IEG6yEh8IrYmtFQW4DUBqBkXSj33PfEE43TUZ31GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SbMX+V34; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SbMX+V34"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8423f236418so3098939b3a.1
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 11:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783450106; cv=none;
        d=google.com; s=arc-20260327;
        b=m0MWiKl2QakLm7BAvPcEzO5dFu9oe/LEXVwY1JxkXWiRkL1gzLhmHEDCdp/aJs3Gee
         +tjuAZivn77BEljFzlTyybJ1zPpm7MfH1QK9AAjExQPgMpUOZ0v2ay0X84nonrBMtKO5
         hwoSuN974LEfkD4YM9VTdMmY4hdM0RL9yk+2qKFN2jvNNQZK45jbuMtyGGjgHMBBhCag
         qP5YoW3B2vw6hBQLjqyFZXZKYXfYjJPKNJdQYFw1KJtHHr4B/P9+MgSzdfC/cdpgKEX1
         xCUUtIx8IlVMqzx6PdvTlskUWk8mYcSEXLnm+vYfi4+EwsqQvk0sKAyGQkQRRaN20GZo
         YEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8I9REEDFjv8luH00AFfyJaYS+M1fVOulSubRZfE4umw=;
        fh=xiAmk5YdyoDtA6973YwssDt3qhd8thxcwCLV9Rn22wA=;
        b=ram3JmLobesnJrj7tX8oGMqMA5lyqqmwh/qiI6/GThdQzKpnAXYpEW4D8fasjEFtqJ
         uA9AuRh7Wwss0gW+mZsJlQZCAMXN8bx/AkPLodEf1vmq8+FiOw6ufk+cvvAmTT83Nl7Y
         meqcPSTBQRi8tpx+S7odde0d0SpDljGnjxbt3b9KNugz18O3ZRQFuKQcQHlWmR8QYKcJ
         p0h4008/xd3MQCbP/08HG4Yt2w3XOKIj3BUnuYLQYoArxPBxjz5FKRItfPPcr+wrVqM3
         ZpVGKtyreY8PjJdXHMOyS6LFH5fmxSZ/bDutJKBgEmT0b6w2PqfEbDzBAA7EO/1uMD2S
         qWXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783450106; x=1784054906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8I9REEDFjv8luH00AFfyJaYS+M1fVOulSubRZfE4umw=;
        b=SbMX+V34pw/hGfQ0jnLozavu15GqajgcD97kN5tE//24eM2oDng7uW+jrveBE2sbxK
         tZTPV92Y4ojWtDbDyvUZ9WkdvI83qrY77fq75dG38w28Hsydr5dE4pFB/K/eGOrrXGOZ
         cCxyQO797x+cLoZVx6j94OupGttLEmYFoGVAmmWGmlUIlPGeNCCOg5u6TA4/jNZNkp5j
         QYQteDNGQxsejvwn9uedvY9deXsOqzkB5halz9dN0YYkB//9iBbSoiJGQYsTMCHoZqh/
         rynsuxKD+dwhrX6qImgPC57EIo52r5OPYDMAcAPlNY2TI9KYlL5h1d0JAsSHe+3+xbyv
         xk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783450106; x=1784054906;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8I9REEDFjv8luH00AFfyJaYS+M1fVOulSubRZfE4umw=;
        b=Kc0VDt7OlF9isbrcQpl84NtXE6rJCnARBBIBQ6lARlNPb3Jafn3lbdmeF91cd5jd1c
         VuR4iJMjnbIhNSWPGbISOutCLKe4NAEy20YxynlpR6KzyD0QmQJAaUczfXHADdAju/Rh
         EQatbbDzFAZDiMOzuR6QtZbQ5BFbsJGWZ8+2ZgLXxHIwQQxtQ4wrp7hfw+dEB30uTuVi
         L9ofTO0prEr0o0reUMy4kvKXr7EezWhPuL/S4yAW2leGsyJr+rqRYsVxhLYms2pUGN3t
         29ouaK1wDn+MXzadfwrUTEAz2sCmqkoOQWGwwq5RLzvzGPrdg4DXCSrSvcYSdV0qqpsR
         qC5A==
X-Forwarded-Encrypted: i=1; AHgh+Ron+75vxcxBXjxNW2nNqIj2V0Y2itS/d1hnly1G3E5t4XPuW5YcKHH5/WwfjMUOToQljYVxPsbF@vger.kernel.org
X-Gm-Message-State: AOJu0YzkqlThdNNXYI7mYAAW64OOJ1u+cdZJa17LOMALrIWChxAZ6G15
	XGS9rVKrvjZMaDkQgBFVBf6BE34upJJ/gqiVzBq79z7/Jpv78ubOzuIVKbQrJP9JU7YzpUGOc6s
	b+tZL9S5TxJHT+iyV45nwB5R8bRkslZO6TR3uxdMA
X-Gm-Gg: AfdE7cnsnwPcUw6kmmWPXECFYCV8pm3fy3eoy6AkErLQopFsiZQMqqIM5fI2bdwTL+3
	y845ZP8u8GhJ8DaXzNVtvQ1jEHrgBgkcp20HV1Mu/XPyyJTuyu3dZOgI+gjqgSNSZqL0F3ekc1n
	O7j1uLPNr4WU3HptevAXAFc8/nQEAe8gMg1i9TA5NLAmTA8/cW0aJTedq9ELrxZo/fR9c13S7YK
	4GD2ImJzfCtF24Nsk7NmBIpLiDSOSywfzoziZTYCJW9SfMGp2VRLB5T0R53tTU4twXWqfuq
X-Received: by 2002:a05:6a00:2e08:b0:845:e04b:565f with SMTP id
 d2e1a72fcca58-84826cc57damr5655333b3a.14.1783450106203; Tue, 07 Jul 2026
 11:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102759.9626-1-achillesgaikwad@gmail.com> <20260707152305.15324-1-achillesgaikwad@gmail.com>
In-Reply-To: <20260707152305.15324-1-achillesgaikwad@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Jul 2026 14:48:12 -0400
X-Gm-Features: AVVi8CeBLkSCcvz0jk-hyXd4ntJNDWvRa9ubZXqmixAE9m7kjk45u_XN0jbOBFs
Message-ID: <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: Achilles Gaikwad <achillesgaikwad@gmail.com>
Cc: trondmy@kernel.org, anna@kernel.org, stephen.smalley.work@gmail.com, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
<achillesgaikwad@gmail.com> wrote:
>
> A call to listxattr() with a buffer size of 0 returns the actual
> size of the buffer needed for a subsequent call. On an NFSv4.2
> mount this triggers the following oops:
>
>   [  399.768687] BUG: kernel NULL pointer dereference, address: 000000000=
0000000
>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
>   [  399.768722] Call Trace:
>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
>   [  399.768731]  nfs4_listxattr+0x21f/0x250
>   [  399.768733]  vfs_listxattr+0x55/0xa0
>   [  399.768736]  listxattr+0x23/0x160
>   [  399.768737]  path_listxattrat+0xba/0x1e0
>   [  399.768739]  do_syscall_64+0xe2/0x680
>
> security_inode_listsecurity() (via the xattr_list_one() helper) now
> decrements the remaining size even when the buffer pointer is NULL, so
> in the size-query case, 'left' underflows to a huge size_t value. As a
> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a real one,
> leading to a NULL pointer dereference in _copy_from_pages().
>
> security_inode_listsecurity() does not return the number of bytes
> it added to the list, so the code derived it as
> 'size - error - left'. That is also wrong in the size-query case:
> the generic_listxattr() contribution is only subtracted from 'left'
> when a buffer is present. Thus, the query result comes up short by
> exactly that contribution (e.g., "system.nfs4_acl" on a mount with
> ACL support), and a caller that allocates the returned size gets
> -ERANGE on the subsequent call.
>
> Declare 'left' as ssize_t, use a scratch copy to measure security
> hook consumption, and only decrement 'left' if a buffer is present.
>
> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode_listsecu=
rity() interface")
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> ---
> Changes in v2:
>  - Use a scratch variable to track security label size directly,
>    replacing the old formula that undercounted the size-query case.
>  - Drop the now-unneeded NULL-buffer special case for
>    nfs4_listxattr_nfs4_user().
>  - Retitled from "fix nfs4_listxattr NULL pointer dereference"
>    (the same accounting bug caused both the oops and the undercount).
> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-achillesgaikw=
ad@gmail.com/
>  fs/nfs/nfs4proc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

[CC'd the LSM and SELinux lists for visibility]

Unfortunately my testing was unsuccessful due to an NFS problem that
started with the v7.2 merge window that I haven't had the time to
bisect yet.  Assuming the NFS folks are okay with this change, I
figure they will want to send it up to Linus via their tree, if not
let me know and I can send this up via the LSM tree.

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 1360409d8de9..a3415082d610 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -10585,7 +10585,8 @@ const struct nfs4_minor_version_ops *nfs_v4_minor=
_ops[] =3D {
>  static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t =
size)
>  {
>         ssize_t error, error2, error3;
> -       size_t left =3D size;
> +       ssize_t left =3D size;
> +       ssize_t left2;
>
>         error =3D generic_listxattr(dentry, list, left);
>         if (error < 0)
> @@ -10595,10 +10596,13 @@ static ssize_t nfs4_listxattr(struct dentry *de=
ntry, char *list, size_t size)
>                 left -=3D error;
>         }
>
> -       error2 =3D security_inode_listsecurity(d_inode(dentry), &list, &l=
eft);
> +       left2 =3D left;
> +       error2 =3D security_inode_listsecurity(d_inode(dentry), &list, &l=
eft2);
>         if (error2 < 0)
>                 return error2;
> -       error2 =3D size - error - left;
> +       error2 =3D left - left2;
> +       if (list)
> +               left -=3D error2;
>
>         error3 =3D nfs4_listxattr_nfs4_user(d_inode(dentry), list, left);
>         if (error3 < 0)
>
> base-commit: 6eb8711ece2ce27e52e327a5b7a628ed39b97f45
> --
> 2.55.0

--=20
paul-moore.com
