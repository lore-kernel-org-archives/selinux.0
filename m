Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27257EC5;
	Mon, 10 Mar 2025 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636404; cv=none; b=P14Qstw+uTX1U0nWNFkmJEC2oR+JzJ6HKOpIhf+XDSMRfx/OE8rVa987sb5BIU7v9quqOvj56E3+cPOzSeVxcbOPavzdOl+mvExus4PJJ1iD3J9vlQSSK5BDSiowJuOKIK1eH7DlI4b0lFCs/LG1Lc9Yd7p2chAypzmszSCK7fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636404; c=relaxed/simple;
	bh=FLsyrkIuBT6/EdxoumpdN8c9fBiG2fgHltOHrjLrWMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEnI7pw+h3olENLKsRW+ZJcws5ejlrXMU9hfRZynEWbduAak6s9Le+s77blop2Is+K6k3vnjLiG7/5q7TkqtLrAYiOa3LrBHYjdyHVU9bXIx/1htG6kdV1EKc0ZHs0YWhd1LEUwxYdFut3vhGLOS1pgpyBh/32O3J7FFgcmomIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Adjygv4S; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Adjygv4S"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-224191d92e4so80850345ad.3;
        Mon, 10 Mar 2025 12:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741636402; x=1742241202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rIOKavYtELkPPeF1/D83NWsCXMYHw86UZysRlTYFnA=;
        b=Adjygv4SfGS7DSY05wGEw5JthQB65K7Hg6PcRS0waXVtbjBz+aGAKqTO5kjR2xk2RC
         KSBYlpChLl0gVknwY4cAIbvTgtDBu3p7xGi3N5cR4MJ2CmmQCAYzbXmZP0cXgrwEOSou
         HSOWhEpSPL1V2p4vg9ksBDC5qKPfFX4zPwmQLhvgzlCY4v659sLJBIdfkfWJNWmPDVy9
         IBVSua6ABzbVdWJREs6YpUYsVJVqX33n4jfSj20ITnT5gONbxprqJa+5E30N8b4zIM2d
         iyjGhz0e9QOyTMnDgtwUHrNMIKChLWPPiZNuBOIK1NNJmp4yJ7zd2v9sOMoUiLK2XicG
         cMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636402; x=1742241202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rIOKavYtELkPPeF1/D83NWsCXMYHw86UZysRlTYFnA=;
        b=qgL6q2soNxRDHQpsPGe8zz/bf7IFAoAPId8XihZf1ER27pPCVs4+VAixuZRy8u2a6V
         eEGgjQ5yA3C3ItWolsspvBtzIw5M5QSnnSnknjNukcyviIEQHT7dFQYK/rokQBNtd1bY
         5ZwTJ52DJTKC6EeNkiB+POsVhBIlUVGFhl18KhfSpkQF6+3dTAVsoVb+VHew51Iv4/rU
         xoQ+klflHQom53/7LLxWgi2g6MfkcvE15OF7ggow2emBnyVQZRZwYzivT87MqpVSlqsR
         RXbW6mdO/SWUc25vzoTJ3cIA9oqo1Iocagpt1yEz0/4O2SxDdTWHD77Xi1ISRfrmVGmI
         /sug==
X-Forwarded-Encrypted: i=1; AJvYcCVtAxlfS4I5jTKG4eRR+5dpmAfYKGQOVR3cOBH2he4hoI/4Weve9IPsTllWsnoIGMicEy8l8WTL094yIyQ=@vger.kernel.org, AJvYcCVxrlISnKGs5qKnQE66Val7ESD98ELoV++ijqPqkphai9jmJ+h/E6yTJgd6+vHQJcacyqGMo/YwHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzegQ2Wa8KcEprf1FkQPwIxE+9ZQpAHDZk3+rjdxU1kOuQ8vj14
	oZzcjl/omGr8y9ha7qHcaaSHd6rc++SIfzeuK27otXa/mbcs1OIczKj7Rw9wG6EWSJVmyP63OH+
	QplzpRc/YnDzb2iY9IZsbXysaHMs=
X-Gm-Gg: ASbGncvrNW39WmmSIHZ334+J5846Yv3saYlTl8pFlgsP3vDzo7lDF52MsS/4RLHOeIM
	C2Q/ArIIHuC/bU+l5Sr5VmbxZZBeuvf7r1ulbTs4GN+i8hJ5IqA1iaArDeSfQnKo7fSrca4q6vD
	9/Eb0KKyD/s2QKq5DY8ruV/38gbg==
X-Google-Smtp-Source: AGHT+IEEZQKKuwk8mqfI7y0yx3ZKhbzf37TMyg4IIJyDAlkEbYbN3Dh5/7pe2cdZBy4l3CNJleXCtwmvvccrqG6VbBU=
X-Received: by 2002:a05:6a00:8d0:b0:736:2d84:74da with SMTP id
 d2e1a72fcca58-736aa9e7465mr20026068b3a.10.1741636402494; Mon, 10 Mar 2025
 12:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67cb894d.050a0220.d8275.0232.GAE@google.com> <tencent_0BEE86CD3878D26D402DDD6F949484E96E0A@qq.com>
In-Reply-To: <tencent_0BEE86CD3878D26D402DDD6F949484E96E0A@qq.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 10 Mar 2025 15:53:11 -0400
X-Gm-Features: AQ5f1JrKFetPF0Qn6Ec_B_Njx7Clt4Z8JPHdYWWOLyCKrr_hnqSxVoRWMYOnmHk
Message-ID: <CAEjxPJ6qFSSBUmK_F-rDhvhh0xw3y1QMP6bVr0iQ+V0FZ3niDQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: read and write sid under lock
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+00c633585760c05507c3@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, omosnace@redhat.com, paul@paul-moore.com, 
	selinux@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 11:55=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> =
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
> Add a lock to synchronize the two.
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
>  security/selinux/hooks.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7b867dfec88b..ea5d0273f9d5 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4677,8 +4677,10 @@ static int selinux_socket_post_create(struct socke=
t *sock, int family,
>
>         if (sock->sk) {
>                 sksec =3D selinux_sock(sock->sk);
> +               spin_lock(&sksec->lock);

You didn't include the diff that adds this lock field to
sk_security_struct, but aside from that, I would suggest something
lighter-weight like READ_ONCE/WRITE_ONCE if possible.

>                 sksec->sclass =3D sclass;
>                 sksec->sid =3D sid;
> +               spin_unlock(&sksec->lock);
>                 /* Allows detection of the first association on this sock=
et */
>                 if (sksec->sclass =3D=3D SECCLASS_SCTP_SOCKET)
>                         sksec->sctp_assoc_state =3D SCTP_ASSOC_UNSET;
> @@ -5126,7 +5128,7 @@ static int selinux_socket_sock_rcv_skb(struct sock =
*sk, struct sk_buff *skb)
>         int err, peerlbl_active, secmark_active;
>         struct sk_security_struct *sksec =3D selinux_sock(sk);
>         u16 family =3D sk->sk_family;
> -       u32 sk_sid =3D sksec->sid;
> +       u32 sk_sid;
>         struct common_audit_data ad;
>         struct lsm_network_audit net;
>         char *addrp;
> @@ -5155,6 +5157,9 @@ static int selinux_socket_sock_rcv_skb(struct sock =
*sk, struct sk_buff *skb)
>         if (err)
>                 return err;
>
> +       spin_lock(&sksec->lock);

If you retain this as a spinlock, then I think you need the irq-safe
version lock/unlock calls in this hook due to some callers.

> +       sk_sid =3D sksec->sid;
> +       spin_unlock(&sksec->lock);
>         if (peerlbl_active) {
>                 u32 peer_sid;
>
> --
> 2.43.0
>
