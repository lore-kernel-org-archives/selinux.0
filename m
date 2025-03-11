Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89525E82D;
	Tue, 11 Mar 2025 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706402; cv=none; b=TpqpIWCWcJAUpy+ajt7fUzB849MMhEHUqnnFFTA4OFah8qVDXC7Mvb4pRyW8402tA/l+T7W8qJqu2CGqHhIuUII32vK0FO+ldZJtZzKDntWEZtASTGsJtNviON3glk3eKzVqKiX1Hh8pXL3m7bRcxLPxv6bHdm5tTB8HbmQym2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706402; c=relaxed/simple;
	bh=5/wG8nHMCM++cumW9en06xtU++e43LqeIRFj3/uNFAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnOAG/xS/dPzYad2klEiH/Z4E7jGM/tBVbjqymZKIC2zR1pKTetUC0GhGQjNR+Jzt7epd3446qHXlh6m88tq4TJSUo8HgjAZACynbiyesADPB5yyfLEhWZT5CqRPN4w4wrYekFFAjIcv5i1zXhMAA/rAoOj2PW5SVJEWhEbRkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNJTdbeM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNJTdbeM"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fea8d8c322so11014176a91.2;
        Tue, 11 Mar 2025 08:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741706400; x=1742311200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLpGIQEzIXWjI4LL93GRRnhD9+U7WFwz7zuQh2rFuIk=;
        b=FNJTdbeMZjgadnCutl7AFm7C+X6zerfxNTkDj0waENxVQomcyM3RNEXQIvaQsVmWIY
         ngHe6ofroISGZmtjgkCk+gxP0cVF/ZbQIF+LnBFfT4tar90JwgLCXeXEPOP7MuNW+w1S
         PjsudrQ46VNqnyFEXbFL2MhYWU7dyT4/cH5Gg361Mc6Uj24Ko3JgnCxXC8JqWtO7ONlW
         7NEOY5yyxwNH3TdGLoUnv0xwr26472OoYJ6BgZnQS1mGUQb7GCTEq5YUNj4qt64+3Qs7
         RvkJz3V8Tu8rP8jataQRBRzhDxw0Efpmz3fMRjm0r9im4O7WfsMZ/F1xrhIxBTF/KC/e
         BbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741706400; x=1742311200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLpGIQEzIXWjI4LL93GRRnhD9+U7WFwz7zuQh2rFuIk=;
        b=WXPM2FTv/md72dT0p0cef3tO3HBUdz2rC5Ug76m0seq+V1i0HJXtI3Xm9QRwIV8rDO
         KCl3HWx/2nnc8pfSUjxP7bSiZlCF1XKrdvKZZJafQVCdpgC62NLkOacxnJ4ZyASXXwwb
         SOI0sKBnux66pV3kkMxRyCLtMZ7urpDTuv4RFJVQi5N60XPsrTVJjQ31nW13qORMK56F
         a27Dz/NQuXVPhVesoNNKSzIGyVL0uLjYpHeoUieGZZm6x7F915s8mFEV4GNUu/q+JskE
         AS6ve8xcxQpR30HoAL8wPx57qhq/C1mB/EhclXvbtKnVjR70VAQnMgeh6mHnkODUr6I/
         FA7w==
X-Forwarded-Encrypted: i=1; AJvYcCU+53i2+D8Us1JBXOoKIkh2v07dnLGvj9JmMlMWyhe+gcrIlK5rulzupVTWw5Tgr6TpVQWo7g8MnEjbRLc=@vger.kernel.org, AJvYcCWHa159QVma5KAD1a/WiLUPmpn8zz6pL4JCXO3dkpgBCEyeRl6XTMMNNrhpt9Vpi9XlaKlpFodhtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHFXhCLw2lRJH4Z7l2m8TAWXV7SL0hAhaswVpWt5hT9KH07Tsn
	SvQyvTDnJeI8zvL2ogXNVfI9lkDvAOXjYwDVji1YSGJF+XGz4FxOQM0y+s0YFv45ZRGuo1GxFrn
	aeHJZM4+vmC48U/g7jz1miw+qczo=
X-Gm-Gg: ASbGncugwkVY6rHqDuv5LA0NhkyGHHL89sgsYh9yP0VzVT2oxb4xppkxBbRJJ9tLhKk
	DL1XRBVz2u0/NT5JXz9kgIiFkbMAPpXZsZVzg56PeXVsAuZEDqbqjHt7Yr9Dkqr1cOVr6kWu64+
	T4oBFOHxHnkWJNq+fhWKHyIVDtmQ==
X-Google-Smtp-Source: AGHT+IFqh82SJYICKBnZ/1jGzEelREd8UX+AZQr+rvlBe76AuD5mjSivb03i5H86uGigOCGjRQRXJJdbgc7ZBFQpLmc=
X-Received: by 2002:a17:90b:1b05:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-2ff7cef76acmr26271552a91.28.1741706400429; Tue, 11 Mar 2025
 08:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhT-VA74h90ScjwO11g7b0pmCjzhVYWKHmkKqD2LLio98g@mail.gmail.com>
 <tencent_5E4FD70DE825E68D96927A5DE95D90991807@qq.com>
In-Reply-To: <tencent_5E4FD70DE825E68D96927A5DE95D90991807@qq.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 11 Mar 2025 11:19:49 -0400
X-Gm-Features: AQ5f1Jpf1kQ-vndEfPtWu17udbcq2j5tuE4lhsjr-AFC8MKt65DdeypnTcHMBS8
Message-ID: <CAEjxPJ7eFbsn7h7o90tOE6ymp4+g-bwYL_Rwy6t0EcxpaBAxAA@mail.gmail.com>
Subject: Re: [PATCH V2] selinux: access sid under READ/WRITE_ONCE
To: Edward Adam Davis <eadavis@qq.com>
Cc: paul@paul-moore.com, linux-kernel@vger.kernel.org, omosnace@redhat.com, 
	selinux@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 8:03=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> =
wrote:
>
> syzbot reported a data-race in selinux_socket_post_create /
> selinux_socket_sock_rcv_skb. [1]
>
> When creating the socket path and receiving the network data packet path,
> effective data access protection is not performed when reading and writin=
g
> the sid, resulting in a race condition.
>
> Use READ_ONCE/WRITE_ONCE to synchronize the two.
>
> [1]
> BUG: KCSAN: data-race in selinux_socket_post_create / selinux_socket_sock=
_rcv_skb
>
> write to 0xffff88811b989e30 of 4 bytes by task 3803 on cpu 0:
>  selinux_socket_post_create+0x1b5/0x2a0 security/selinux/hooks.c:4681
>  security_socket_post_create+0x5b/0xa0 security/security.c:4577
>  __sock_create+0x35b/0x5a0 net/socket.c:1571
>  sock_create net/socket.c:1606 [inline]
>  __sys_socket_create net/socket.c:1643 [inline]
>  __sys_socket+0xae/0x240 net/socket.c:1690
>  __do_sys_socket net/socket.c:1704 [inline]
>  __se_sys_socket net/socket.c:1702 [inline]
>  __x64_sys_socket+0x3f/0x50 net/socket.c:1702
>  x64_sys_call+0x2cf2/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:=
42
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff88811b989e30 of 4 bytes by task 3805 on cpu 1:
>  selinux_socket_sock_rcv_skb+0x72/0x6a0 security/selinux/hooks.c:5129
>  security_sock_rcv_skb+0x3d/0x80 security/security.c:4781
>  sk_filter_trim_cap+0xca/0x3c0 net/core/filter.c:151
>  sk_filter include/linux/filter.h:1062 [inline]
>  sock_queue_rcv_skb_reason+0x28/0xc0 net/core/sock.c:527
>  sock_queue_rcv_skb include/net/sock.h:2403 [inline]
>  packet_rcv_spkt+0x2f7/0x3b0 net/packet/af_packet.c:1967
>  deliver_skb net/core/dev.c:2449 [inline]
>  __netif_receive_skb_core+0x48f/0x2350 net/core/dev.c:5737
>  __netif_receive_skb_list_core+0x115/0x520 net/core/dev.c:5968
>  __netif_receive_skb_list net/core/dev.c:6035 [inline]
>  netif_receive_skb_list_internal+0x4e4/0x660 net/core/dev.c:6126
>  netif_receive_skb_list+0x31/0x230 net/core/dev.c:6178
>  xdp_recv_frames net/bpf/test_run.c:280 [inline]
>  xdp_test_run_batch net/bpf/test_run.c:361 [inline]
>  bpf_test_run_xdp_live+0xe10/0x1040 net/bpf/test_run.c:390
>  bpf_prog_test_run_xdp+0x51d/0x8b0 net/bpf/test_run.c:1316
>  bpf_prog_test_run+0x20f/0x3a0 kernel/bpf/syscall.c:4407
>  __sys_bpf+0x400/0x7a0 kernel/bpf/syscall.c:5813
>  __do_sys_bpf kernel/bpf/syscall.c:5902 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5900 [inline]
>  __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5900
>  x64_sys_call+0x2914/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:=
322
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x00000003 -> 0x00000087
>
> Reported-by: syzbot+00c633585760c05507c3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D00c633585760c05507c3
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> V1 -> V2: replace with READ_ONCE/WRITE_ONCE

Thanks for the patch. Did you audit all other users of sksec->sid to
see if they too should be wrapped with READ_ONCE()/WRITE_ONCE() or are
already safe?

>
>  security/selinux/hooks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7b867dfec88b..77d2953eaa4d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4678,7 +4678,7 @@ static int selinux_socket_post_create(struct socket=
 *sock, int family,
>         if (sock->sk) {
>                 sksec =3D selinux_sock(sock->sk);
>                 sksec->sclass =3D sclass;
> -               sksec->sid =3D sid;
> +               WRITE_ONCE(sksec->sid, sid);
>                 /* Allows detection of the first association on this sock=
et */
>                 if (sksec->sclass =3D=3D SECCLASS_SCTP_SOCKET)
>                         sksec->sctp_assoc_state =3D SCTP_ASSOC_UNSET;
> @@ -5126,7 +5126,7 @@ static int selinux_socket_sock_rcv_skb(struct sock =
*sk, struct sk_buff *skb)
>         int err, peerlbl_active, secmark_active;
>         struct sk_security_struct *sksec =3D selinux_sock(sk);
>         u16 family =3D sk->sk_family;
> -       u32 sk_sid =3D sksec->sid;
> +       u32 sk_sid =3D READ_ONCE(sksec->sid);
>         struct common_audit_data ad;
>         struct lsm_network_audit net;
>         char *addrp;
> --
> 2.43.0
>
