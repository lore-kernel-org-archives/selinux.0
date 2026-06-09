Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFFA36EAAC
	for <selinux@vger.kernel.org>; Tue,  9 Jun 2026 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020686; cv=pass; b=t1ptgCFrR4q4Nk6vpXmps/8UbijMZeFyqEFhw7BUeN/6F+MZU3xvROUwyB+5/FIrzlL0S8nxswxAM71OUQjLmJSQVa6RTWN1LTn50HOO6Oq28K5jZBHhLBZjW/U6yJ6fuZ4IDPZZ2hhI7G27dUEK89PiUx2otemerEqz35uGMMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020686; c=relaxed/simple;
	bh=vp3zsQF1tOvS3AWGN6sPu3TSNArDoWoPE6D4zrJ1njg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIczQ6DA8/8EuRoo8pOgYzN5wYKpzam6XgLLAYuO6nO69mRQjlApGVZd545/PDYIDxgeDATv8Rka1JtLNvSmyzLf5RyWbYmVPLkynStWRolYzAqTamWf3vy5EOs6QhsBZg632Yk6o/lfZ8n7DRxlvbTLE4BcrbnLqUGTCapKjps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JTeimykS; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JTeimykS"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c2c7e0c5so39139885ad.1
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2026 08:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781020684; cv=none;
        d=google.com; s=arc-20240605;
        b=Gc6Ixq97t8+ElrAJDztRIm6dacp0+bUkXbdcwDb+FsXGlnwGx8rlryVbRsKzrEhfu7
         PhOOvaf1EwORSoyOogPrlvFfCIIK5fIG0s/MM4GBBBIEbDr0eQGqMtqdpNXI7HM71T+q
         2IDLnMWzNgTYQQy9kj5DsZMAVYzRBhXNpLR+ylV5RLNL2lAKZZPGNNTH3MGsNcJ1rNoe
         mRqFgLE5JVhgaxe+Al/l8FufXwvdWVsf97UzzWFGPGmG8QaBmM7bJOAwMfWmjNcW1gVv
         WkuF8PGTlO1I3laOoNBEiNZFUBczuQ8IEgmcK4TWNhTOdpjum8QNdW10kLXU4Xkir4+c
         W/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vp3zsQF1tOvS3AWGN6sPu3TSNArDoWoPE6D4zrJ1njg=;
        fh=szNbHvrZ9tgD7IbBK4eiQiwR6NVxN0is2sKK6qohdqk=;
        b=LgAmSxv2/pRmmqluwVmM1whcGrPHnnINmb2+KcinAmfKzp0GRWGGlU/4yKTfipEjuP
         zv3kHr/foZ0i12CPeERypExzhVHPNz012YmaY7BhducjiPaJr6lMA2zPavRkZ/HYaXGw
         PW58PI0vN70kvWQAC1pWIo+rhu47aD2IvJ9HhTJbRmBvU4s/n23VF5c/iDWCniUQAsnX
         rmF6YOnwOuDOPKhTXD/rHXnlT6mq28c96bboljhkLu6/KB0X5zJntDLhkJJwQ4go5pEo
         H9F+yla5z7hJ8t9bFENHzf16NtuuvSmBlKBT5f8d5mROw8MWwnMEDHf6udda3xo1A9+O
         2Qtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781020684; x=1781625484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp3zsQF1tOvS3AWGN6sPu3TSNArDoWoPE6D4zrJ1njg=;
        b=JTeimykSb5AQiuHgaE2eJyhO3LEveNkKWJPDbBLsGTl8kcnKX/PiVok26IY38H4kZe
         pc5L1SROBpJgAkrnKR8bjBFgTyrxDvSoc90j0AxrlrQVgjNlriLg/ZEkjLs/3H7B/z7y
         atIjUU3ij5ZJ45wUcgqqwgdZT2WnbnRZHt5wwhmKWSeGGc/kRP8iKbod0xSp1iORxyH0
         e0rlS1Qt4VYdaXsvTz3o7e5bomnqZbXqndIYn6kBdrzWv44uGa92rINvJ1lirRpocqLO
         h3lT9+lDOd4WY34DKrOMX3kg3ANxUA71X5gwZx5046SZs6VkTy7dZNzld3y5JyfL4KUP
         jmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020684; x=1781625484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vp3zsQF1tOvS3AWGN6sPu3TSNArDoWoPE6D4zrJ1njg=;
        b=OoH93IdMaNbGsoHNEXVLMUPbhn2ZGueG2i2X53Q7bt6L76s9IxGPxRPKShhRyKWjBV
         KvsXyLw5guD5/vMSCfPiWkRBckHETKhddE3wXEaDf9OpHs+0G6r5NBXLLXRYo3hd7Iaj
         iEX62EcUNSdvIduZJfbdpp6+G9X7peR+/tix2NmaYpMjtZdTGw6jkFBSslYfGYaA1HUn
         IVIw6tP8k1HF3i3aYFiE7GU7LWAJFBn+/mSz9mQT5S108WcyZLUXRXbbvB0alke/xA7p
         ZDC4BhYeVvoutD1rvAxGFx+shxmRSiO63Zzy9RRM83/GTmyf2aPG8swmGZfrEg2//uV1
         QLPQ==
X-Gm-Message-State: AOJu0YwYQDlZKB/JjQ42Ay/TkJ7Stdupe3pFn3KW8nYrVCgd0hbcqaJM
	VvG9Xt4pKBiCsDX/YpZCPNHl+mOPWi82OJR7LCSM04z3+8POYczRqHMyMwbCoN/zNnzHWfk1fWB
	kY3EbshS1unljGl5uE5l8izZQldQLoHREGI818RoNwtrNCoWFeHX1mA==
X-Gm-Gg: Acq92OG4S4Ead0aNKnVRXR2gZwg0bP7McS7lB4UcJ5X3psX7g/qMcQnm6A/tnBvZ2DW
	P41SxGzhnMnEmfwz9u3H5sVjXCdkaimysaJlzyDPAI6/MCaRv4HEJ+dmbCjy81Fu+/9VNPqxj6v
	mYLSY2Wb8OoPQsFFsZVwQ5pdViN4Xb6jcd5wUq044LjGxPp2utYo/bZYqYNOqVbBRYMsK1sWGWW
	o60tiyuRTis7lm6IWXFkNbq86+H9INoqm0dfJ2FLyarpD2BZ005Fo0vDfGXsE53NykHcZxv/lYr
	ljD5svMe3Lqm21eWyg==
X-Received: by 2002:a17:902:f645:b0:2c1:6259:cda8 with SMTP id
 d9443c01a7336-2c2a1c873a1mr43603215ad.25.1781020684190; Tue, 09 Jun 2026
 08:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhcyzmaCLaRmK2anDfThnhy3M_EFRgpk7Aajd+uctvYr27WZg@mail.gmail.com>
 <CAHC9VhSf-ph9D63=J-AemOZfvb9HXLFguCRFWkU4y1DvDsKr9w@mail.gmail.com> <CAAhcyzmUS0QkOL9_HReHD76fNTknPpJUui67-mLW-Dx_BPFzZQ@mail.gmail.com>
In-Reply-To: <CAAhcyzmUS0QkOL9_HReHD76fNTknPpJUui67-mLW-Dx_BPFzZQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Jun 2026 11:57:52 -0400
X-Gm-Features: AVVi8CcVGGky99jQ2t7oF-tUgk9aZtKOVs6RxdBN6-N0VP5ng-oppqLF-eha_FM
Message-ID: <CAHC9VhQbfSV6gt5QncQKmgjbyNCWb5TP1WsheER+JLaV3oqoMw@mail.gmail.com>
Subject: Re: [REGRESSION] LSM/VFS: startup latency spike during rapid library
 lookups (ENOENT) on x86_64 between 6.6 and 6.18
To: muneendra kumar <muneendra737@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 2:03=E2=80=AFAM muneendra kumar <muneendra737@gmail.=
com> wrote:
> >>Are you running a distribution kernel or are you building your own?
> >>If you are building your own, would it be possible for you to narrow
> >>down the kernel release which first introduced the regression?
>
> In our earlier release we used the Linux 6.6.78 version and then we
> upgraded our kernel to Linux 6.18.33
> We are using the kernel from the below distro.
>
> https://github.com/intel/linux-intel-lts/tree/6.18/linux
>
> And we are seeing the performance impact in Linux 6.18.33.

There have been many changes between Linux v6.6 and v6.18, not to
mention any patches Intel may have included in their LTS trees.
Unfortunately it doesn't appear that Intel releases an LTS tree for
each upstream Linux kernel. However, if you can identify which
upstream Linux kernel release introduces the regression, e.g. moving
from vN to vN+1, that would be helpful.

--=20
paul-moore.com
