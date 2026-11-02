Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793632469;
	b=ZTsInXY3HUiAetBw3kh8tOrT2AYNDEj6fPn9oBKuEc9isOZhA3snKbMJYGo6KstHy26K
	 s/Qm7rUpJ05zgblyh/QLJkOBxGjUVT+mdOOQiYKsYHu8V2LI0foaKgUdyHMmW81OLZEUN
	 Kgc+z7ag9CW7a8u8/9RV01dxMfNzZCIv0J4LqCXMtTAQtaUsufR4Ceq2ambLmaSfnXZ6T
	 fAwp7LKkDwj9MEqlDGYPIv5TrvACCUVzeyzLipuVBMxnNScb9FJkqN1xnwQt8OoTFvz8o
	 anjJMvSU80WqyCtRokWwP0WbatxN/ypbBjr/SAGWIvwzfLLVhTNOA2pZLD+x/sf49yQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aOdCxZO55hUw/6I077tI6EL/o28ur2wlUbUGRR4UyJU=;
	b=y5fh5VinOYdaZraHuQQEvz96les0xFyQCfCtO7GgPV1Y6ldfE9T6s2Q8am8aoimeeFlW
	 CMjMgqisQP0Xa5dqMcyR7CiohuOxmLO1ShjmQrtsMimX+xy08gOD/CkdowvOtZb4vr0kL
	 I43hUmY6awP2HWFCdtvb9qtjOE1QDnjEo4mp3ylGhrYvzvSh2x+M7fTaxnl0AuYHPRqDv
	 MgIhlco2A0H9jNvX+6HGN44qT2D3bvCypYJiirJtw6k3L5V7y/gdcVqZvEgTXHe+Fa6m5
	 Ip/kR2sf7Tv5xqaZ/drTiG2t3yUW2/plseL8AGD7erSGqF6+l7M9l86l+7l/6dBapUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UK/Ov2Zm";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710626093F49
	for <selinux@vger.kernel.org>; Mon,  2 Nov 2026 15:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 710626093F49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UK/Ov2Zm
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0a28a720aso29360857b3.2
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2026 07:14:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793632468; cv=none;
        d=google.com; s=arc-20260327;
        b=acC/INrJMaNC/894nJjm9CSneYEWj1XArBlAjgvdKEhg0oGHRN7xPwCfZQQ7Lto6FO
         gNhEDn/zh9SSoObYsn8QCN4LJzmWOMwg/C0/GeDLCkp9sL0vVRJbA3UVgl9TqkDvsVXr
         CFZehPuB6QAkFyMeVL4wDhl1uC9Hiz/pZ27la7KkVx6zhow3uwL+PQrBCT58erEEqSo6
         Emw1lYmt153RNC3Ss5Wc8T9y+6QpyQGTtYGmUIOpqmVcNE1qYqmaVdhCLewJwEKT2Wqe
         2VH0ZwB1kTBQN0SyWg/TDVcv0SZ041AVie3IOucrTgHAp6WZbgQE7eubbgIe6AShsNGB
         c5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aOdCxZO55hUw/6I077tI6EL/o28ur2wlUbUGRR4UyJU=;
        fh=raW+NAHYc2RmYeuUHBNeE7k9xQLk5h1KHelX9tLJiJI=;
        b=I/9x8iuCTNqKcH/48pK4NP64m4NadzHn3IIO4ITpfAynXti+UNRwGdFygdoGKpRiHF
         4PPJ8m6DWIxSShE8PpHl42qNO0v5CRs6TVdyve8OP67c2msVkayQ55f0pv3mRsQLUFoV
         0PFkaKgiTHLDg9/QVsvwzZ+V6Pva3iJAj+CBXu6eOXM/31hhvPmIPkGrA6ltLQpUuAxD
         nirJhYKSCg8U2ztcccVa9FridXWcPHPtf2IqBAPEPwRsA99OtgtnAxxbkWwJyRD5oOUd
         /b0hUPi2X5AU0Xkqr3IsZhzfJXvALTSeNX7bEDGWMIKvifX/j9S4tVSIDRlTSDodMwyz
         1xlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632468; x=1794237268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aOdCxZO55hUw/6I077tI6EL/o28ur2wlUbUGRR4UyJU=;
        b=UK/Ov2ZmZrdzn6wtpyN4IuP0s2NI94uQI7yYBJibP6aHf1CPcffmPVYaLkzYSc7pZm
         Q+awmbVw7SIAx9igzH2GxMbpkJkUZWNm5FYtB1KlYDTmR1d4BJDrwn+eZuXuDN3hfkKi
         wic6ZSVgM3Y1UqylgTszFO6RuIHOCzlfX7DyBHr6w+fBZfeaHkL3L5lbBc4iRYJCXspt
         9pzWytIy2fjqQ7RVqjA8Iyg0vs6YCR+ISjcat8IZewOZC+HDkTF+GC7SBwr94lTftIlb
         iXOhyfTyOpSiHWGkM8CQhvl9wo0AmvYC/zHu1qJMn7diEAHe+U1q3JmLq16spCqaJO9l
         ToNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632468; x=1794237268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aOdCxZO55hUw/6I077tI6EL/o28ur2wlUbUGRR4UyJU=;
        b=qHm07rzcZ57PX66xtfaFdFy36BaHms9ABSaXDhtUnbAUnJEb1xCGX4pGTCpG2QWeYQ
         YBjkHAXaWf8r+ybQyQRzd0bVz3gNEZZK+NIWuEKKZQn0HEULdMSudLSQ/kK6phh3weK/
         3m22oP2K8coBNCXaVPxjI+6UtN6Od/gymCUBF9O9qTh6+qRjrLK8OcIBEKpFTHCEr6th
         a12It25dI6zrvwuRf2hyrHjoVP9FR1RwOZsEQ/4mZkzdGPjl9Ny4B/EMtq1uDTCSuwfK
         Z1Xv2IO0Z58UIonBwkPhWjLIS2/uD/H3IgobbH5dOxH930ipICUwT1Nfh2qDWPeTymuj
         ELTA==
X-Forwarded-Encrypted: i=1; AKwUvBwc2ZNWJN5wr3O+pdkG7knEYu42oCkIaISlUQQKQxZvw7VAvEQEp1zEEDcOt4wO1SactvSW4LVe@vger.kernel.org
X-Gm-Message-State: APuU4Z/b5qU4xN+iyl7hKmaj+QLiM5cQYap03H7wmZ6IAmSpZOOi5cjs
	4ARL5FURI1u13YmONYnToRUv0iaGbmty9MhpFQzybzoJ5XC2tSF2Rh37YIob1KPCCkRM2t2L5hE
	gkBkHlT6JwkCLGDDicbcltTTHwZITDS8=
X-Gm-Gg: AYBFou0etSZhmi6VW8MUmxjeNTFHWeAROWAVhpeAB8RFexhEMkngMIeyrnVOJ515WE9
	7WulZwCelufjkIZuQqngFqlfjNgbq3kxQOzcbXzB975fhfsBOKLURMCRW/pojK64bLlz4RbWCY0
	i8nICbnue5ABezfVXjiX+EqYqpDHdBIMdlRH2yIe6obLaFy2lE9yPEtLvMBbnzSkZAnRnnWJcIP
	00BtuyQB3AAe7RLMOgKy0xVwhJnBtkL8Ezmsy8HH0q+ogkl7jKZlItQ2So/0iZwUJhFV3pomynG
	R4cx9h/zqV1v+/EhkTU1UwTg4rYKhgsn+nHDvY1McQ2Sbs5uB8J0a0FEyWqwyU8JwY0w2c4D570
	IWyXKHGUj85ope6jmPpyWTXkfdxgFPJNqwr75plXVt4FebO0wvzGiVUeFVAuoWvOdFsrL0aPC4j
	sIZArc/JvFF90SZx+TVBW7cp8NnSvsQ3YNAGBFWSXqMmkxwLEhkFo1YsKOqw==
X-Received: by 2002:a05:690e:1201:b0:679:28ad:d8d8 with SMTP id
 956f58d0204a3-67ba5118897mr8055833d50.104.1793632468374; Mon, 02 Nov 2026
 07:14:28 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102130540.252894-1-omosnacek@gmail.com>
In-Reply-To: <20261102130540.252894-1-omosnacek@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 2 Nov 2026 10:14:17 -0500
X-Gm-Features: AclHuK_S3LwuvSZEIcs1e2WEC4WgX3S0M8bKoabDzHzf2mxELuht56K17Z9rPEg
Message-ID: <CAEjxPJ4hxdvV-r8chmF3RAi9RJX=-4AqntG01=fWUhh4-xP+ew@mail.gmail.com>
Subject: Re: [RFC PATCH] af_unix: introduce MSG_CMSG_SEALED
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	netdev@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 8:05=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnacek=
@gmail.com> wrote:
>
> Currently, when a process receives a file through AF_UNIX's SCM_RIGHTS
> mechanism, the security_file_receive() LSM hook is calledto allow LSMs
> like SELinux to validate the receiver's access to the received file
> (similarly to a process inheriting file descriptors through execve(2)).
>
> However, there are cases (such as dbus daemon/dbus-broker) where the
> receiver doesn't intend to access the received file and merely wants to
> forward it to a third process. In this case the forwarding process would
> need to have the appropriate r/w access to the file in order to receive
> it, even though it will never actually acess it. That leads to the
> security policy having to grant the forwarder access to a potentially
> wide range of files (in case of dbus-broker basically all files), which
> is not ideal.
>
> This patch adds a new CMSG flag MSG_CMSG_SEALED that, when passed to
> recvmsg(2), wraps any received files into an opaque anonymous inode with
> the name "[envelope]", skipping the security_file_receive() LSM check.
> The returned "[envelope]" file descriptor can't be used in any
> meaningful way other than being passed forward via sendmsg(2) with the
> MSG_CMSG_SEALED flag. In that case the original file is unwrapped and
> sent via SCM_RIGHTS to the receiver. The receiver can then either
> receive the file as normal (subject to the LSM check) or again "sealed"
> in the "[envelope]" anon inode for further forwarding.
>
> Note that sending the "[envelope]" file is only allowed with the
> MSG_CMSG_SEALED flag set, to make the unsealing explicit and avoid
> unexpected behavior. Attempting to send it without this flag will fail
> with an error. This also avoids recursive nesting of "[envelope]" files,
> which would only make this feature harder to audit for possible issues.
>
> This patch also adds a simple read-only sockopt for UNIX sockets that
> allows userspace to determine if this feature is present (passing
> unknown CMSG flags unfortunately doesn't lead to an error currently).
> The minimal code to do so can look like this:
>
>     #ifndef SO_RIGHTS_SEALED_SUPPORTED
>     #define SO_RIGHTS_SEALED_SUPPORTED 88
>     #endif
>
>     #include <sys/socket.h>
>     #include <unistd.h>
>     #include <stdbool.h>
>
>     bool MSG_CMSG_SEALED_supported(void)
>     {
>         int sock, ret;
>         socklen_t optlen =3D 0;
>
>         sock =3D socket(AF_UNIX, SOCK_STREAM, 0);
>         if (sock < 0) {
>             /* handle error */
>             /* ... */
>         }
>
>         ret =3D getsockopt(sock, SOL_SOCKET, SO_RIGHTS_SEALED_SUPPORTED,
>                          NULL, &optlen);
>         close(sock);
>
>         return ret =3D=3D 0;
>     }
>
> Related: https://github.com/fedora-selinux/selinux-policy/issues/3286
> Related: https://github.com/fedora-selinux/selinux-policy/issues/3287
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> ---

> diff --git a/net/core/scm.c b/net/core/scm.c
> index ae38f3c1165c..08822b2a1f22 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -114,10 +127,29 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct=
 scm_fp_list **fplp)
>
>                 if (fd < 0 || !(file =3D fget_raw(fd)))
>                         return -EBADF;
> -               /* don't allow io_uring files */
> -               if (io_is_uring_fops(file)) {
> -                       fput(file);
> -                       return -EINVAL;
> +
> +               if (sealed) {
> +                       /* Only allow sealed files */
> +                       if (file->f_op !=3D &envelope_ops)
> +                               return -EINVAL;

This leaks a file reference.

> +
> +                       file =3D (struct file *)file->private_data;

This fails to take a reference to the underlying file but will later get fp=
ut().

> +
> +                       /*
> +                        * No need to check for io_uring files here as th=
e
> +                        * underlying file had already successfully passe=
d the
> +                        * check when it was first sent.
> +                        */
> +               } else {
> +                       /* Don't allow sealed files */
> +                       if (file->f_op =3D=3D &envelope_ops)
> +                               return -EINVAL;

This also leaks a file reference.

> @@ -365,18 +398,37 @@ static int scm_max_fds(struct msghdr *msg)
>  }
>
>  int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
> -                   bool notrunc)
> +                   bool notrunc, bool sealed)
>  {
> +       struct file *f_received;
>         int error;
>
>         if (!ufd)
>                 return -EFAULT;
>
> -       error =3D security_file_receive(f);
> -       if (error)
> -               return notrunc ? put_user(error, ufd) : error;

Design point: I would suggest adding and using a new LSM hook that
allows security modules (like SELinux) to still be able to check a
(new) permission that governs whether a process can pass along these
sealed fds so that we do not entirely lose control over their use.
