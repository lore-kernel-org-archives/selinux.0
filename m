Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793625222;
	b=KDRhwY61FLQqJhnNIz7vZcKY+PlB0wBLEFOHoUP6xiIs9G9nMOJugFzRIFgyvNsIig3o
	 iNlKF4Ig/nZCjIPrX4mI6BMfphrbmTqO7gn0xDWIeVV3jWIPomzEXz1Uud2Tv1wQSrdMX
	 BuhMmdFMj+ekypBukNLscO2AB9NY8xiJ9AUXwIzeOLchElRUlLm44Pd6ekMLFdCnCraav
	 lI+USl9vO08Y1LMy0wlwTa7S49vq1BEhpK5NKuix83qvUQE+xmwWjy6l6QP6XYULZs3Zj
	 xSqw5vq6Uvi7zigOY1Pws0KJWLraVf0ObEUdaQ7VJMAz3QhV/liX/s2ITxfU8EBFamQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rC8xVMt0ftVC1MA0/AxMx0dm+YERO32RQqLOxWhbSdM=;
	b=b0QjPHmKteMDjIp2b0outcc+sRUNvRtW3KLpcrFFhNPbD1HXthGeurBGN1drlaa0D9fh
	 R1v/0lL8+LSZe5PftTpM6daNMDy1+gBRBlcqIfpiVDmaDWn2AHG2pwVDo9lIQT0H4dh/K
	 ZlG6pRoTBXYvPFT2c8NmBicEs5S2cGP+wh2jgZkyJpziZBcY7sVFXeNVABy2QTkZUhvSk
	 ek1k8P0i93QrApAQYap3xTDmL683YZXgEKdmt9ZNrPTIm8DCSPcMGiMa/0mjlZpHfUy6a
	 47qG+S+1grXWO/upamAFFHp9b71r7+72HaGTX/rkm6rlSJqT/KIL/32pGbGT7G8zPZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9Bv0lrt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DAA606A337
	for <selinux@vger.kernel.org>; Mon,  2 Nov 2026 13:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45DAA606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9Bv0lrt
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15ea896ddc8so5071085c88.0
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2026 05:13:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793625220; cv=none;
        d=google.com; s=arc-20260327;
        b=dQyRucOaLS+X1zXBcmBRIrJGk3N9aoF5XmBuMJag4Eo2tQJh5l77l+K83rZ4QoRXYu
         Ngziw8rxnJGourY5KsJpqbwrz8ugHJp+q8dxgl6N0PcsncPJV28+kqgK3He34XMs41bn
         5aDS2+TbLTvYqY1a0PvnPCrUhnBWWOCBCQ7aJ0uOWRlJ4xACLK5rl/90K1bLHMgHJMX4
         Hm9Cd3ujR0fkrb2uU28h5VJlA+qE8baKebLdGs+COZhDUfg/O7g+iNiD/kFWR95CBROg
         qDtqYXSjJ60SmPUTRJabuVjJRC74Ew11BXFDAO6SMAq8fLOzUyB080Eoe6DfbyMj8qGU
         Ag6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rC8xVMt0ftVC1MA0/AxMx0dm+YERO32RQqLOxWhbSdM=;
        fh=mNpPn3N/SnkxhAiul23jOZq0JYM1l/UcG5KW1FcRT2Q=;
        b=rbo9ui7FFgEE9G18tUrVBgYKLNdzQNNoi+Ml61lc1QQk6dG2jFxxw8Eino+0JrpPB5
         j5oU8rVH/VpgGE0qgvKAvqw4i5/qfmpDFwLY04o0pRBf2dJ6QEeIVce7DBuOBihCUqb6
         g3chPGeaNbzVJcnMPpS06hC+1EjsZfaMPLzPQpawEgfMInzr7RwE54+NNHaLNkJSbLFT
         q4O7/IlfiC6hbZ/z4/75ZOrpSu1KCkc2RExHjHs+2SxsLIX2L0NEVfyLIYMkylPtvMWj
         ltbhODfOGKmmodx7Xclxdc93mXqu01F+nTkTFfoqbxwA7phfxI2VIlGHaQ2dw33ButTV
         0Jng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793625220; x=1794230020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rC8xVMt0ftVC1MA0/AxMx0dm+YERO32RQqLOxWhbSdM=;
        b=o9Bv0lrtHh2cwTJJVMUH4k06fPh+ZUF1Xl51YCyt5LSal/HMFyjV6eP5ndcJg+7iVj
         WTAY3phbzSA8x/6rfLnLvb4bDnZ8Y4PG1EA0o2RPOfRyLwq6jcyjm/QiNRIf9j5AQQsJ
         l2LCkDlG//3sWy/odK1wwz5yKvgETNvSW47fduZrW/zlPZQm2Hr6OF9occ90dnwda9pH
         15peHnhylM0gwl1DeCkmpBva8CbqeJR2lmvPc9gUGtCRkIGAVwQC32c4UK+T3jOODMWv
         8UTKrgc631symoPetFblG9qRPrnzh0NbDQA57q01cYj3VhCGGF8OfpP+shjngzwAm22m
         UCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793625220; x=1794230020;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rC8xVMt0ftVC1MA0/AxMx0dm+YERO32RQqLOxWhbSdM=;
        b=B1p3us/i83Q+RXhdqU6H5wp8fDhj9YKR7FtKgM5xvJRM7KLhO+Zaqf7eBHI8BQfQIm
         ig3KSi6FpuG4i2fdyDlMYeaOaGQ5SmMesbYOPrNu2fFgyBtCFiQb0aatCRL01d/Fcc6N
         UJ8JhlWwcOIMLY8BAGXPD3s8/Cae7q0+uX+8DDr9edI/sgWACl3biA8zcfB58AFtaBWr
         iktRe0MJp0Nh73VEZA93Xqul9EJLKTAya6937nL8Sem3+V5nBZemzbVcj4eo1JlVUBHh
         0mLcP++FDX9ufpCYtrC2Ll4hFy8q2VZbL0rGl+P2CmfrJYJHVQDul4lj40ia8JnzTvVA
         XzBg==
X-Forwarded-Encrypted: i=1; AKwUvByKqmtx4s10NaKLY/SNMaoIHMN95iqnrwu181eGzdGK5H0unTHBqOcye3CNdz9jpsn3QN78ZD7/@vger.kernel.org
X-Gm-Message-State: AFq9FYIlifcqxtzplUD8H3qxdcZqhNzgjeE10lAc+zPMwsT2S4A6TjUU
	GrcG4jDO5+U1g9+2RKRgHDhxz04RRT3Po8D0Y3ZpzVSmbvu6eSdN7XLXMOyswxfqftmBh8r+ndV
	1OI6koR/iBSDJMeD9SYaxvMyqs0ZHpmW+Kkrn0R0=
X-Gm-Gg: AYBFou2ZQc85C03E4gPEB1dUQxK2aV+SG83vhiWyBtDq5ZeBCjf5PztEF26BtAjek14
	+d09PlaxvwLQxh/nbZIla+P5DI42cGyC0J07gDmQJN1CN8l0nJDVdLrpDhFV05PehAKFTuFEwSn
	0uBXivmmQfAcVPojQ/lk5RYOUc8THBYQ0hsOfjrpzWjuM0MlmA8oQjYig5YVYxHgsmdBFk9WjyM
	r8UUaxh7FuF84UsIT+xlgU7pwa2pLbWK7irZx1onUUkAB8yMDIkJxERn+l5ALU7Bg7MU5T/dw5W
	NV+eWzLcLdST0O8D/VVmZG3+5dkOyq5wtvGTeCAYretngg676k6hJ+D7lsVRlko4yWDF90EQRVb
	8yJdwotfy4rppfccp6YO5ka6IN9aLM3z7z/wE1LfvFdMC0UnqOn7ZMKqzP7VH/0zizkvv
X-Received: by 2002:a05:701b:230e:b0:14a:8cff:fbb8 with SMTP id
 a92af1059eb24-1ac5bbb5053mr14722111c88.28.1793625220279; Mon, 02 Nov 2026
 05:13:40 -0800 (PST)
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
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Mon, 2 Nov 2026 14:13:28 +0100
X-Gm-Features: AclHuK9Lk_3jmZnqSr1tjOillycrUr-WcgCLTZN6r2TRwhWtp1BoaHKbHJvYD28
Message-ID: <CAAUqJDvsDi5ceO3ri5cJP4WJbZeUdpJe9F4cv8OU4=wBzVeBAw@mail.gmail.com>
Subject: Re: [RFC PATCH] af_unix: introduce MSG_CMSG_SEALED
To: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Nov 2026 at 14:05, Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com=
> wrote:
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
>  arch/alpha/include/uapi/asm/socket.h    |  2 +
>  arch/mips/include/uapi/asm/socket.h     |  2 +
>  arch/parisc/include/uapi/asm/socket.h   |  2 +
>  arch/sparc/include/uapi/asm/socket.h    |  2 +
>  include/linux/socket.h                  |  4 +-
>  include/net/scm.h                       |  2 +-
>  include/uapi/asm-generic/socket.h       |  2 +
>  io_uring/net.c                          |  2 +-
>  net/compat.c                            |  3 +-
>  net/core/scm.c                          | 81 +++++++++++++++++++++----
>  net/core/sock.c                         |  9 +++
>  net/socket.c                            |  2 +-
>  tools/include/uapi/asm-generic/socket.h |  2 +
>  13 files changed, 97 insertions(+), 18 deletions(-)

See also this RFC patch for selinux-testsuite
(https://github.com/SELinuxProject/selinux-testsuite) that I used to
test this patch:
https://lore.kernel.org/selinux/20261102130834.253605-1-omosnacek@gmail.com=
/
