Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC47349CD8
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157127; cv=pass; b=bORTwSxG6l3h316l+wj8+ITiF10zs72O4UEgSNVBKLfl2Uk7Qnr1qFrTdFy8GdY4DuGFoKsFLZw11sZXyp41X+VucQCk6qO6yZWYb34f09cxjDwnnPFc9Pt0nMZnN3mc3CC33Jihs0imHemQwmKWehNdK19jM7hNa5LfDlIPjSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157127; c=relaxed/simple;
	bh=mmm23bE6Q07svgFflgT9fYMJRhrLxVXo1n6n80A5h1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EF8UhJKnWeQMoO+aO/tnzwZR8TDoMYhki/vsK2B/ZcGPk2hdcKXClsk2NS8pbej/qEOrI6e6ekPZUvivcIXghkqd7/BsY3QuhyUQJzjXMrsPm2+NWKaGI+3ZPRZ7KBPo5V/WrinX667UUTqaoPB5HG368dnnBhxVzPY4kkQnH9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Afm6BC6I; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Afm6BC6I"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37c6cd1ac98so4218429a91.0
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 12:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782157125; cv=none;
        d=google.com; s=arc-20240605;
        b=ZjIiH/tbitnxSDE4M2rVRRP3iVlhsqXWGZ6z6haSp8hRYx+5o/7TyXCy8LduNuW5e4
         fGN4QavFqxWIC6KxRelKCq5yRLno2FZikTAVliowhvk6lTFO6+dXvAyuTRg17x4XV6fs
         ep4kj28HvjXwwNfo6YZ4sGRg3iORtvqWlgAhxeGpw7ifeQJKruNwkpUJT1M3xYApMgHK
         OqzSbdXZuwT3UzbMWMMCotGWQSrokioW99P9EVNjb3SA/Lmv1PIIbJ/deOb1MgYC6C5J
         gU4Q4s+JN+i1xWjbFb/CST9j0beys+z8XYCRLahy4/bfjQldLgX/sEY1pTNflAO3LT2s
         v+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mmm23bE6Q07svgFflgT9fYMJRhrLxVXo1n6n80A5h1Q=;
        fh=bUJmBO74qv4TfVpdYRs59kX+OuX0TAT4jBzXhbTmIE8=;
        b=A6M2RpKuHpxf8laTY9HjA9S14YCu8j/LX0zdbMkjd0ORGI6p9d8gVefdc/bxdxR2UO
         UymCd0UWp4TfkG9SksHcN3Y8EzESeWiIZko+IVlWCvXbFxpsaYCU67VB9L7I1CpZOdYV
         jT7qG1hLIrAYv3rDk/Bbh7xg1IdURzG0b35GG83jDQYXCV0EWpipQATivzCpRporkwV8
         mgCmd9hewcInyoV/Ye9rG/y33r5bMknmmzrv10vJp73TT5xHsZOlSnnxs7TBFVfaUaVV
         F0S7BOKY7Q8+J9upiqH9zXqAUgRpYkCidhPVl/52u4Lq/Rqzo0F8S+AtK49JYaDO0OFS
         Q/GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782157125; x=1782761925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmm23bE6Q07svgFflgT9fYMJRhrLxVXo1n6n80A5h1Q=;
        b=Afm6BC6I54u72V/ypsC8yEr7BqJH+yg295tGExqvZvk0n/52wc3UH6+ZZNz7SOgCtU
         qsfwPGB0KDY2pJ9JMWKY/4BNRJl5JKhlYE5qLFgKKWberrjEGmDVchfiJ2I91hEe1Onv
         3vPLTBYN697U3lGfTxUI8ysFRj71FIAdv7KD0Qq0ku3rSXUqGkd/dVusinNqViPIEFtN
         x5MEyJy+9bT2GkMBgaYImfG9sELMinpX80xN5XkxZKXzGRKzcn3O5rnZAteeIYQ5oMts
         xi7+t0vx0r1gZx8rNSuFL0Ty6LXJi/cIfUGUW3CEjlukFpMQxQ9Is7nUfp0KUGM9xj2T
         vQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782157125; x=1782761925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mmm23bE6Q07svgFflgT9fYMJRhrLxVXo1n6n80A5h1Q=;
        b=PcL16gpXZjVZ4ms8HaM1uI3jTKQWPFxdJ0T0qH4dbEhpPcPZD92NPrJyk4ZmKirHEW
         hBtgQOb0P52WlI5IGVIFxy47XhrBpkLAyFrVW0AtdgM1RepnfYCEOVTxQim0v2gFQoK1
         Z7H3ZpVsXDIBMUlyJZq15jcYPXypAvNnDvPPnV3YXLjtCd4j/Gxmi+Tt2FYCDIN08dh1
         HvC1J3D8xCbh1wDR1IGGAfX0kCvdvwfD91kxqza5s+oPNDspqOYXrofcYXs89cGCvWEu
         9JPRtIz8iyea+Z+g5nWFJMOpV0jlci7pD+jjI682LLfauXsis4v0+hi2q4NBCuV8YwzF
         SpDA==
X-Forwarded-Encrypted: i=1; AHgh+Rp51F4uJDUeQkHipEPkUsmsAri8LfIviM8wMIG1+sETX/DaPi6yNqtU/3w+4b/mXHJ4nQOfKJ+r@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwpA3Z+PlCWzBOfOROHw3J7i+bq7OPPjm9nF66UcGJhlpAGw6
	ePJrCNsZkZYKkmGFBxeI4NNcTQndxFK2UMmkF/3yZa03T9NofDN+zjTPxQqXUs45Yzi+mN4ezF4
	VF4CbI1ut+G2fdzvAGv3rSnkpNHN0xNk=
X-Gm-Gg: AfdE7cnGi0Z3IKrofvDATE+No8PmdgMkWk9teH++3fyfB98izZN7d+wTwRIIg041Gjr
	sOn5r3OjC+AeMuOJhjD0xpGQkdwULmqPcRF2ueAIU4twzuPF8slgjsAAnEZC4PT4H7GGfQcnj0D
	3g2U8edaT/wP6bRyAjG5Nr/qBeyNsrbOxikUslcfwXY/+AvsdEZ9fv0adKYY6m++iMfmAsp6OF+
	y+SoizWWcYsU2ZLJtcUr+qBvak2dEuiz3B20DhRhcOH60/bPzZoEuWd/rk59n0m3+isSXuh
X-Received: by 2002:a17:90b:4a12:b0:36b:3ecd:88d2 with SMTP id
 98e67ed59e1d1-37d1e82fe09mr13648393a91.3.1782157125269; Mon, 22 Jun 2026
 12:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618232149.1780219-1-tristmd@gmail.com> <CAEjxPJ40fKJbDFobsxoos0CvWqi0FfL6Sd5xkpRY=g5Ukyfnag@mail.gmail.com>
 <178215477740.1641401.9370300196381074566@gmail.com> <CAEjxPJ6zrqBR1jXWgCJs0e+7qPnonhWHXUMomDT8gbz4Rm8yXg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6zrqBR1jXWgCJs0e+7qPnonhWHXUMomDT8gbz4Rm8yXg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 15:38:34 -0400
X-Gm-Features: AVVi8Cd3qwaRPEhC0wEk6RyBv4Cj-VHTDocK-wt3iBfoRpbqTiKGawQuzctoIdw
Message-ID: <CAEjxPJ5zGiFHRXTLvPFDuB+H3MmE2zCPOCJJhcxJDXnS2gtPew@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix NULL pointer dereference in selinux_sctp_bind_connect()
To: Tristan Madani <tristmd@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:15=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jun 22, 2026 at 2:59=E2=80=AFPM Tristan Madani <tristmd@gmail.com=
> wrote:
> >
> > On 2026/06/22 10:12, Stephen Smalley wrote:
> > > Is this sufficient, or can the sk_socket be freed under us after the
> > > assignment?
> >
> > The assignment is safe. sock_orphan() only NULLs sk->sk_socket -- the
> > struct socket is freed later in __sock_release(), after inet_release()
> > returns. That path goes through sctp_close() -> lock_sock(), which
> > serializes with the ASCONF softirq path (bh_lock_sock). So once we
> > read a non-NULL pointer into the local variable, the socket is
> > guaranteed to remain alive for the duration of the function.
> >
> > > Do different callers of this hook provide different guarantees
> > > regarding sk_socket or are they all the same?
> >
> > They differ. The setsockopt callers (bindx, connectx, set_primary,
> > sendmsg connect) run in process context with a file reference, so
> > sk_socket is guaranteed non-NULL. The ASCONF softirq path
> > (sctp_process_asconf) has no file reference and can race with socket
> > close -- that is the only caller that can hit the NULL.
>
> Thank you for clarifying. It might be good to add some or all of the
> above to the patch description and/or
> a comment in the code to make it clear going forward.

Actually, given that selinux_sctp_bind_connect() just passes the
socket to selinux_socket_bind() or selinux_socket_connect_helper() and
the first thing those functions do is to grab the sock from it, it
seems like we could just refactor helpers that directly take the
struct sock * and never have to deal with this issue at all.

Otherwise, we likely want a READ_ONCE() here as well.
