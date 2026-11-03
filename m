Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711151;
	b=OqVSjWkXXWFSAKbmvNYrQBIgs8xi3NUbPYx2Sp/LcrXNgD9L59nFKBoylIrAwkpUZUmD
	 kLdBJJTzSpTRC01WZMbI5rnw+ecqBn1SpVkOwIa31cKLIRyIHmoLijv5dwkmLTtrGnxbS
	 Fav0RbNUFlEKoRg8PA30PSR9ihXXyAllCm9a6gflM8D4EJ5ZdQPPRaNk9q6mZI5hUEpNS
	 f7i7I2QtQPxnsqm0q/7O98UI/W40nJMvuLlROUP9fDFCi2c4ZKLSHu4WQp9HVwLHH7igX
	 fOkRTILiUzvgwUur8aZBhzNuAeKQIoJl/32EYABU3VH3ZMt8FsCGOTv6GWzOBRepPPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711151;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VyK7okHp454HnCCRM4VH15ZwJfO0mDJ/VCj4vZivXcU=;
	b=GpJ6YMp0rhhxMXGUgrFGphZKWNvPrzpG8Qd5whINqM7i8ZT9wU83y5hT9PNB5TPlBYs5
	 QhpyP3mRznssiwIlzzReWhWGSlxlE9/XyrB3qbdowueMTgqx9xGsBMyVOSgwkHepcbWJz
	 FJMbVOyZBLtGY2VUfQmnYs94Quw2mtt86C8Tzyu1SPQkEMvIujsD5FldaZhrp/sW3jEcM
	 OR6KDWSAkUgpyk2WOVz5EsZYz5tkpdveAjHSL44I49GuUHLYGN5nwyxQOFTFuvkD/TBtR
	 k6dfIuzu4s8u5kh8dQkcVkElpZD0cOII1Biv5eArVTUQSDVGIRjEGd4gH0MuyEbwYXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQWQAUMi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDA1606A326;
	Tue,  3 Nov 2026 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQWQAUMi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916BE1F000C1;
	Tue,  3 Nov 2026 13:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711150;
	bh=VyK7okHp454HnCCRM4VH15ZwJfO0mDJ/VCj4vZivXcU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=kQWQAUMiKjAS/sDRyUArpihnMhKtLQdwkmo9kW7V7hgtU2+JRROqiSW3gRblUEeng
	 Gn7zENlIYAPm+wWMabkxM09qJuuE9c4r3xmtNIPGOVd/2x8Si5paWq6XdoBLDIAUCH
	 gWX4/sT379sUL9v8sikiGArqoTrlNyF5wCFnZz+f6RXYNOeNLjAzt7iwSvILnasrZT
	 s4fEiEJJbu+o52ENlvOskRwJ+XARNmh+zdGThDOlEkZTR+pXC7u+W4BmenUuPJKzQn
	 CmN5CrxC8EjXAc1kvHU8a6K/iGk6yJnF+7mo37Li4lwjhT+nqMGKooOwqBUH+DUKwS
	 F18IqeVO0gUIw==
Message-ID: <sashiko-outbox-195303@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] af_unix: introduce MSG_CMSG_SEALED
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261102130540.252894-1-omosnacek@gmail.com>
References: <20261102130540.252894-1-omosnacek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 13:05:50 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] net: scm: missing get_file() and fput() when unwrapping in scm=
_fp_copy()
- [High] net: scm: missing fput() on error paths in scm_fp_copy()
- [High] net: scm: file reference leak in scm_recv_one_fd() when FD_PREPARE=
() fails
- [Medium] net: sk_getsockopt() copies zeroed int for SO_RIGHTS_SEALED_SUPP=
ORTED
--

commit bff932de78fdb71452bc8ca043d1f0a85ab5a42a
Author: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>

af_unix: introduce MSG_CMSG_SEALED

This commit introduces the MSG_CMSG_SEALED flag for AF_UNIX SCM_RIGHTS to
allow processes to receive file descriptors wrapped in an opaque anonymous
inode without triggering the security_file_receive() LSM hook, and to
unwrap them when forwarding via sendmsg(). It also adds the read-only
SO_RIGHTS_SEALED_SUPPORTED socket option to query support for this feature.

> diff --git a/net/core/scm.c b/net/core/scm.c
> index ae38f3c1165c8..08822b2a1f222 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c

[ ... ]

> @@ -114,10 +127,29 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct=
 scm_fp_list **fplp)
> =20
>  		if (fd < 0 || !(file =3D fget_raw(fd)))
>  			return -EBADF;
> -		/* don't allow io_uring files */
> -		if (io_is_uring_fops(file)) {
> -			fput(file);
> -			return -EINVAL;
> +
> +		if (sealed) {
> +			/* Only allow sealed files */
> +			if (file->f_op !=3D &envelope_ops)
> +				return -EINVAL;
> +
> +			file =3D (struct file *)file->private_data;

[Severity: Critical]
When unwrapping the envelope file in scm_fp_copy(), doesn't overwriting file
with file->private_data need to take a new reference on the inner struct fi=
le
with get_file() and drop the reference on the outer envelope file from
fget_raw() with fput()?

Without calling fput() on the outer envelope file, the reference acquired by
fget_raw(fd) is leaked on every sealed sendmsg(), preventing
envelope_release() from running when the envelope descriptor is closed.

At the same time, storing the inner struct file into fpl->fp[] without
calling get_file() means fpl->fp[] does not own a reference to it, even
though __scm_destroy() will later call fput() on every entry in fpl->fp[]:

net/core/scm.c:__scm_destroy() {
	...
	for (i=3Dfpl->count-1; i>=3D0; i--)
		fput(fpl->fp[i]);
	...
}

If a caller sends the same envelope descriptor more than once with
MSG_CMSG_SEALED, __scm_destroy() will decrement the inner file's reference
count multiple times without matching increments, leading to a reference
count underflow and use-after-free on the inner struct file.

> +
> +			/*
> +			 * No need to check for io_uring files here as the
> +			 * underlying file had already successfully passed the
> +			 * check when it was first sent.
> +			 */
> +		} else {
> +			/* Don't allow sealed files */
> +			if (file->f_op =3D=3D &envelope_ops)
> +				return -EINVAL;
> +
> +			/* don't allow io_uring files */
> +			if (io_is_uring_fops(file)) {
> +				fput(file);
> +				return -EINVAL;
> +			}
>  		}

[Severity: High]
Do the two envelope_ops checks in scm_fp_copy() leak the struct file
reference acquired by fget_raw(fd)?

When sealed is true and file->f_op !=3D &envelope_ops, or when sealed is fa=
lse
and file->f_op =3D=3D &envelope_ops, file has not yet been added to fpl->fp=
[], so
__scm_destroy() in __scm_send()'s error path will not release it. Unlike the
io_is_uring_fops(file) check right below, returning -EINVAL directly without
calling fput(file) leaves the reference from fget_raw(fd) leaked.

[ ... ]

> @@ -365,18 +398,37 @@ static int scm_max_fds(struct msghdr *msg)
>  }
> =20
>  int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
> -		    bool notrunc)
> +		    bool notrunc, bool sealed)
>  {
> +	struct file *f_received;
>  	int error;
> =20
>  	if (!ufd)
>  		return -EFAULT;
> =20
> -	error =3D security_file_receive(f);
> -	if (error)
> -		return notrunc ? put_user(error, ufd) : error;
> +	if (sealed) {
> +		/*
> +		 * Receive fd sealed in an "envelope" anonymous fd.
> +		 * This will install a special file that can be unsealed
> +		 * upon sending to another process, otherwise the underlying
> +		 * file will not be accessible to this process, avoiding the
> +		 * need to pass the LSM check below.
> +		 */
> +		f_received =3D anon_inode_getfile("[envelope]", &envelope_ops, f,
> +						O_RDONLY);
> +		if (IS_ERR(f_received))
> +			return PTR_ERR(f_received);
> +
> +		get_file(f);
> +	} else {
> +		error =3D security_file_receive(f);
> +		if (error)
> +			return notrunc ? put_user(error, ufd) : error;
> =20
> -	FD_PREPARE(fdf, flags, get_file(f));
> +		f_received =3D get_file(f);
> +	}
> +
> +	FD_PREPARE(fdf, flags, f_received);
>  	if (fdf->fd < 0)
>  		return fdf->fd;

[Severity: High]
If get_unused_fd_flags() fails inside FD_PREPARE(), what releases f_receive=
d?

Looking at __FD_PREPARE() in include/linux/file.h:

#define __FD_PREPARE(_guard, _fdf, _fd_flags, _file_owned)		\
	struct fd_prepare _guard __cleanup(__fd_prepare_cleanup) =3D ({	\
		int __fd =3D get_unused_fd_flags(_fd_flags);		\
		__fd_prepare(__fd, __fd < 0 ? NULL : (_file_owned));	\
	});								\
	const struct fd_prepare *const _fdf =3D &_guard

Previously, get_file(f) was passed directly as the _file_owned argument to
FD_PREPARE(), so it was only evaluated when __fd >=3D 0. Because f_received=
 is
now allocated or incremented before FD_PREPARE(), when get_unused_fd_flags()
returns a negative error (such as -EMFILE), _guard.file is initialized to
NULL and __fd_prepare_cleanup() does not call fput() on f_received, leaking
f_received (and the inner file reference in the sealed case).

> diff --git a/net/core/sock.c b/net/core/sock.c
> index e7405be8941f9..68a447d8bf52b 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1959,6 +1959,15 @@ int sk_getsockopt(struct sock *sk, int level, int =
optname,
>  		v.val =3D sk->sk_scm_rights;
>  		break;
> =20
> +	case SO_RIGHTS_SEALED_SUPPORTED:
> +		if (!sk_is_unix(sk))
> +			return -EOPNOTSUPP;
> +
> +		/* Just succeed without returning anything, signaling
> +		 * support.
> +		 */
> +		break;

[Severity: Medium]
Should the SO_RIGHTS_SEALED_SUPPORTED case in sk_getsockopt() set lv =3D 0 =
(or
return 0 directly) instead of breaking out of the switch with lv still set =
to
sizeof(int)?

At the start of sk_getsockopt(), lv is initialized to sizeof(int) and v is
zeroed. Breaking out of the switch runs the shared copy-out epilogue:

	if (len > lv)
		len =3D lv;
	if (copy_to_sockptr(optval, &v, len))
		return -EFAULT;
lenout:
	if (copy_to_sockptr(optlen, &len, sizeof(int)))
		return -EFAULT;
	return 0;

If a caller passes a non-zero optlen, sk_getsockopt() will either return
-EFAULT when optval is NULL or write 0 into optval and update *optlen to
up to sizeof(int), rather than succeeding without returning a value as
described in the comment.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102130540.2528=
94-1-omosnacek@gmail.com?part=3D1
