Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5856354AFA
	for <selinux@vger.kernel.org>; Tue, 28 Oct 2025 23:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695938; cv=none; b=pwxtM8DL6ZhstaBZ3CgpWJUeAVJC8aSO8Lz71AfusV/rF8NLc9i4qlqy4RFffHcU5iTIHKThRhxQ2v7+IxpEGypcF1iyhA/jXbKgd9vKeNBYNCsDzKBJ/XXCrofVLQ6l4GUyCKrIDqEwSRGkvWHZAYgvCjiMULXIFruSeuuSJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695938; c=relaxed/simple;
	bh=kk8zkzm83REChxkZSsstjBUXBS7wFfE2QPwc7AaZrqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfXwVOml2IA+Tv2zgVTNgB6PAHzRQ9nyuEBtK2+50RO72CVR9aombUkfJCNFvZtBUlj7Oa6oNM4eAabmdgnWU4htf97E53qzikpjCI8l8O77vhrfLLyznWQ5ppA8HvC4o19fwD3sFNpzF/dpHXPgj2Q9va+F/oKVyDIj1aDB8DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b5mm2fmB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b5mm2fmB"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c11011e01so9709386a12.2
        for <selinux@vger.kernel.org>; Tue, 28 Oct 2025 16:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761695933; x=1762300733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WE4n4TCb18hPsMXmSS/+ET4xqQfmAur/mQUYq6ibGY=;
        b=b5mm2fmB9zTSMmFv4iKcb4cYmBOnPB/Zy4oRNHUHZ2iikAuKggazvFoh6D8vH5ZaA9
         DhmA+LKcnFO/ZrtWv+2TA34YvpTl7erhnFKoSbM2HAtVpRNrZuJyEJhtkWIlZY9GLHks
         +/MXfaI5oLqKh5dze2y6Rt0r5nN8ipVqo9HD3i/WJISxOx+NS6+V0zoCuTSi9yCJkwlh
         lqEpqob3fsMnFyMfsJoSfvvOBZDCMfGFjBNH6d4vTByQp0KRH60bi9LyW2aLznonIwV+
         XUn44AEioKOrWDBMX7EER2Pxhi4Hytd2/q/OVHWxKd1TUG2EPGrQA6fIBm6xvgqMNQor
         I30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761695933; x=1762300733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WE4n4TCb18hPsMXmSS/+ET4xqQfmAur/mQUYq6ibGY=;
        b=JydFoVFRHg6oBNS90faeCaeOGsqxP+cxwgV4hG4uMLVX3+L5m9M8K+spf77CHMJqzS
         o7VdmXL7qMkxx5VpvjyuShEPiUdAe5fDeL8fYj2zUIu9t04oAjPUQImHI3Gto5xS9qS6
         /n4S10B+4t7xjmJAwj6rQR0rFPonZ29k9sGdaSVTb6q0PrlZFniLwajNOTzr3+0pIIVB
         pcMyPNfClHr19mZyThfRjQxGvhEDZcLHgiaPHUM1SvcPq6T1Kf/Mt27lPu+unuGJRRiO
         hQuEHwv70h8sBkTbbn7AKuqItPT9529IOT4yk7JEX0G4ibFlV54PYP5PEsmr0mNX4C7c
         gofQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF/cIOvdIvmWjNKYfYjLHGxIU6kaspR+KyJkQf+0mFYDPFO9F6WhD3ygLMvABA7LzTO2ll6uMR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz78+lVh1YiWHo9p9WpR+akqUf1PuPJyJM7uYSgCiNmJ3xRiIrl
	Rv8aQ7u/hGDUSAHGiF2wJCXVZ/KApndbGBG7cTapgo4Ji8jcGLl7HGA82X1Vd9dbcQvt57u4Yo6
	LtHIDY2b4YBWr2q/rZrBVVfkXW0ylBbhF/yeON62E
X-Gm-Gg: ASbGncsbaa625tTgbKf86ktoOZDbp/KP70DQ5OmVSeA8uCARcUI6/Kr4VAekI84rac6
	CdgOhrvvfhiw1lcR8O+KvAqKffyd93GDNauUjFXN/n/IGR/rMSLQdnWDtiVIudPhMlcVagPXJLA
	CWgBUhF8jlvYqfBeR2UeQnS4NOG4Rnz/NL1OsBCIpIKVdyLY+ela9+JH8Dkz5Jik8bfbODOmY6f
	zoR05GZjejpZZ31dgbvHjVKdX0Ol9xnRs0HKaRRx9mZ7tmPlNaz+7eaH7wV
X-Google-Smtp-Source: AGHT+IHvIzFCAVsIe9KLnMzhe7HeHw161tWjaGF8dq9LK8mHTJ5LNBNsg03z1RN2kv4hUoIzYntUB79AzDiL37F2WAo=
X-Received: by 2002:a05:6402:50d0:b0:638:74dc:cf78 with SMTP id
 4fb4d7f45d1cf-64044380bd9mr816143a12.34.1761695932545; Tue, 28 Oct 2025
 16:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-11-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-11-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 19:58:33 -0400
X-Gm-Features: AWmQ_bnbOFuYYw7q6A3vKx1W9tiGVviHbdGsSFCW7Z6eJ8jFBd6mwoz2mbQdJG4
Message-ID: <CAHC9VhR4nO+TanWwz4R-RQijy9h5B2h6HuBDXxBNp0+kAE4Asw@mail.gmail.com>
Subject: Re: [PATCH v2 10/50] configfs, securityfs: kill_litter_super() not needed
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:46=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> These are guaranteed to be empty by the time they are shut down;
> both are single-instance and there is an internal mount maintained
> for as long as there is any contents.
>
> Both have that internal mount pinned by every object in root.
>
> In other words, kill_litter_super() boils down to kill_anon_super()
> for those.
>
> Reviewed-by: Joel Becker <jlbec@evilplan.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/configfs/mount.c | 2 +-
>  security/inode.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Paul Moore <paul@paul-moore> (LSM)

--=20
paul-moore.com
