Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B24C3B42F4
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782137582; cv=pass; b=d6ZxMp5/l/egeVJpBeUjAc8OKjFhmml3NOX1eOvPHgyya7/7rxLtsq9TsJQ2ycs540Se8xFkwYYVX6qeKuKY/Mm00T6Fx9ZTf9MqAUTcSwmuUjrxNbfh1VencoZLktbrgpfQpn2wQY6HRrKBXcPBJ59oRZ4K3tG/x891zVgiWEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782137582; c=relaxed/simple;
	bh=h3DXxfjnoRBKb9Q5qIM0GACEbU2bDotjEwDf6nGdF/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnSNBEt1//mEmZklSOw6h+UE1A0wT6oZvOqtW0+f/rtI1PXQUgItW2XOWoHTBx4G0tX0OvLp6LYf26k7JIxrA//9Jk/h74aBMmMi7SjYO3f2RcYuO0+vNUK0dV9wTi/KdOjEUkxOwtmQuIbZcZruSwxE5VCjyo2F7/tFal8USY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5/7help; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5/7help"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c892935bcdeso1735868a12.3
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 07:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782137579; cv=none;
        d=google.com; s=arc-20240605;
        b=E3glq8g+cByPjapWty0ehrteFFkI1uUfNdMYRaC/nIsuo6Eyk4si66gILiB52eLFhf
         hn3K2Yd9WIcF+WSQ+JgG70hK+v+9+YCo+64nocb8Bev5H8q+pmyz6fxF3vTLiXj1lLfb
         T4e+emiWLacOl9kYm+jeT19xYFHJXw9tq32XaiTiA3HBxZo8eFQM2PzShBCmVsFXkXF+
         8lIDFXJj8hQXhBG9NgA+c06m/IS+GM93V6AhmZp5QTWxeqhlnQdM32LON+E2L/3JdHz2
         z/PbRJtcWZauRy6iBso38pwLbMxklL/mCNszbgvahMe54uNOiZlxDqnZ6nhflPcIClOy
         JD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M2WqLWQyMsQEzVUJqDlsxo34QmoBE3Oqy9iS0ZLJYAM=;
        fh=CAhq4Q04LSX5d7eovZaWn31qKAPZpID0Bo5gNWbXX3E=;
        b=YEwIjkjHQK7eA49W8thEasyN24bPQ5bko50ataQpgr8KRsW9F1jSPw5gJe/Qyp5uTf
         m2MFarD+XGz+Fbb0N3HKHBson7iTmYIwosGFWvDCIeT07v+UYY4PF6vx6VpWFkqgI2DG
         qjYdAtTyf9TYyhVEomr5C1YkTJIiJbo6VWBnZtePcfcd1YZovFqgSm4/jqATnxMvTWWj
         RAhl2iQB9MSJ+Wwu9g85MnLvJeudKlWZyTfFLPASk6t5BP2TUV9i0GrW40b4rqmvfaIX
         lxqSsLRB9Ui0GyWmpsPiqiIgQZui2i07V1F4a2H+HElbJcgz1ktEoOxcS5B5JQ3BuPuB
         qm+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782137579; x=1782742379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2WqLWQyMsQEzVUJqDlsxo34QmoBE3Oqy9iS0ZLJYAM=;
        b=h5/7helpBcsWdizArN7vpk9kNZpuUfwmxvYDnFl1rPUYnFiaXdoieDzZc3yckXQUs1
         2GczrL0bZyiF8bTeZKG0eaSh/IqgCBg8YPwevxvh+5q9KPME201/rg065CYZ5rPuTMcb
         rKR1xBgdFcD9lgqqdYOuiQl/1LbDd6+2MoowURG1U9bAcHkQb15mH1t+seqcEkPvJq8W
         m/yxzLzptFaUzEEsxwWo7szJSDAnksYNH/DoSxP0qerXe1CXJmVH+MOPTH+culT0F0dh
         p1EhckCXVh7XmALkxMHWu0MThfgOvFSyKlD6j3MSAYC6l4bh3nuoSK63KaJJZTT4TMLJ
         NFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782137579; x=1782742379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M2WqLWQyMsQEzVUJqDlsxo34QmoBE3Oqy9iS0ZLJYAM=;
        b=T7oKSqFO572cwqpLGSZAM1cFIQ9tYxXEiBApDSsAzDO3eR6YfR48Tt+BYc4k6Zo7B3
         l4yIgyYv8y5OGGtBUC6X8sh2VIIPCTJWp/aAafGNkPvKB1aQhaCRkg5IQUIQi0LNlBGg
         R84mVYnkjcFltoF3axpj9/B9wMklKFfSVgldMQYTirIs9PIb7MkYp9gQvwL30glHR7L7
         tHEiTCtVjwYTikO41XC8TYfq+nH0rOKUj9F57g0twa0oqxC7quvGGuDm7MKjzyEIhCkN
         /nPu22lpsW/ZSzuZKySegzMzhfyx0MedyrC2yDkbWKq/epyLxCbedLUcCyiqEe4RwghM
         onpQ==
X-Forwarded-Encrypted: i=1; AFNElJ9XS3Ga/IoPGUP0TR+DW7ln8D9KrrU0LF8+naYm1OuvsHzYFwSjErUFplFAIxoLGc9FU1HBKyy3@vger.kernel.org
X-Gm-Message-State: AOJu0YyQsrJ81Jlkbv+dX/wlQnJlpkdKNrlIAFtHYQzABw4aihDfSbaU
	/4gUKA2YX7hxXbBzWnmrP0PNVP2rVFcwVHrBcLIzEcglxc5g0oeKHSENslPkP91dY5lmaSQPgnT
	16KPW1A8hedBZtx3X3ssXV+PpmaMELZ0=
X-Gm-Gg: AfdE7clfx36VAZKbTL/KhCMtolTdHkYjOFModc20ToAia2ixfq40iSS97smnvy+tY/t
	0YpBv7YW/xrzqKIAIeSYmHyIJJhruD9ZINCK1YDWe/6uWrn1m+3+w+u+TSoA8YenL3p5YYFi7OA
	K6dCCVMjFesLzuALnd/vZLo6nJHY2dVsfyhFEyzg+EkLDTYAoE/xzX24k8fYzMziSiSGBuH6V8W
	AkTyIul0s2UOh3VidStpDLb0vCWtRIV1jGRGel2+7o8zckG4FErGSHLY+qfmNvgsEeLuiHD
X-Received: by 2002:a05:6a20:c99a:b0:3b4:65ac:e2e6 with SMTP id
 adf61e73a8af0-3bb35b6e77amr16196992637.36.1782137579386; Mon, 22 Jun 2026
 07:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618232149.1780219-1-tristmd@gmail.com>
In-Reply-To: <20260618232149.1780219-1-tristmd@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 10:12:46 -0400
X-Gm-Features: AVVi8CemQ0t_rTSck1wS9CobbvsEmXex-9Y2SukK4wkFUT5aXCPPWsw3QZQQIHA
Message-ID: <CAEjxPJ40fKJbDFobsxoos0CvWqi0FfL6Sd5xkpRY=g5Ukyfnag@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix NULL pointer dereference in selinux_sctp_bind_connect()
To: Tristan Madani <tristmd@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 7:21=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> selinux_sctp_bind_connect() reads sk->sk_socket and passes it to
> selinux_socket_bind() or selinux_socket_connect_helper() without
> checking for NULL.  When an SCTP ASCONF chunk is processed in softirq
> context on a socket that has been concurrently closed, sock_orphan()
> will have already set sk->sk_socket to NULL.  The subsequent
> dereference of sock->sk at offset 0x18 triggers a kernel panic.
>
> Add a NULL check on sk->sk_socket before use.

Is this sufficient, or can the sk_socket be freed under us after the assign=
ment?
Do different callers of this hook provide different guarantees
regarding sk_socket or are they all the same?

>
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  security/selinux/hooks.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0f704380a8c8..e45588563caa 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5717,6 +5717,9 @@ static int selinux_sctp_bind_connect(struct sock *s=
k, int optname,
>
>         /* Process one or more addresses that may be IPv4 or IPv6 */
>         sock =3D sk->sk_socket;
> +       if (!sock)
> +               return -ECONNRESET;
> +
>         addr_buf =3D address;
>
>         while (walk_size < addrlen) {
> --
> 2.47.3
>
