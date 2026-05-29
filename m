Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8332192F4
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071085; cv=pass; b=UggibkqyuStaw8XqB44+EclKXVEhBaZf4abRgqTrJp1roknE6snVpl69ftgnJPOKM7eg26mbEVEOgzkHrCNZDqMdDG7Qozdw20MJ8bEY/yukiNhIS+XXEsp2bd6E/+K7f4nrY79TyNR9tVXXtn3h26BIfX5nCZO71zb8JpF4Xno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071085; c=relaxed/simple;
	bh=LOEaPD7Rz0zsPbSOZbfxpmu2DbPZ8teKVvGhPB/4or8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcX6P2T7TyKpvJlH71eJQlAy0CziEQRWn7wW4HeCHjHZM1mX3FCJw3UCHA1PgI8U6aDM6flCrjP4fTeJlx5FAauv3iCyp+aDMoSEywbzRShq5SUIpKg3edtQ70WSL7qdFf8Aa7N8LsIAODiiegBl+U3csi8Km0YfnxsNOGDHPAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgWIRKCP; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgWIRKCP"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c70c112cb61so10753627a12.0
        for <selinux@vger.kernel.org>; Fri, 29 May 2026 09:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780071084; cv=none;
        d=google.com; s=arc-20240605;
        b=Q6JpvOXcul1jH0ilHxT3J/eFkZIQjHUauDnDL4tFY/C5Y9Sewu/Q6n7FfffpK5DQah
         9ypwXxrdVpH6bwtlB5kdenV/x9j3lsyoiByhxZIdewdCk6zJZsE4SeMnpmI986Qmi7Wn
         +1veGw1fBX1nbzH8RgvtBgiESha5mEGGwLVjsNIpWyu0IDhizgU66QM6PdJEmbSKpC70
         GB3/0ViEqR+oXLpiyqCTVWrt8IPucf/HlDDawzDJmu+jLecyoAwcqqIC8lqh+2MrN7Id
         5zV9looUoHxWkhhit+En6HCmaGcRRZimOsWtIcrBMpRigGSpl/4ipLjiWqHongBkdXhJ
         rrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LOEaPD7Rz0zsPbSOZbfxpmu2DbPZ8teKVvGhPB/4or8=;
        fh=hdhbLxUDy1e2/6QluAmQxiLFPIcUmbNAnjlGW/Dv0Hg=;
        b=e87TaK19g1Q2LAnVStF3W5CyhkoHDB1VIxRYaCaBa03l/WXPCb0QwHTq/IZCM6LmL9
         TDw7vrx5NM+ta3sVjy1JvqAZpBJMKPtMuR9rHz0HugLSBU2hapmVer9IMrGQz/7eXg+3
         AvW5LoJ+akYdX68Ki+SddQ4jz/yHagpHGs9lt9Kr8HWdCHhW5iB5cICB99atys72Ug3N
         I1XmjM1/ElcYHpLYUCe8oUoYloMpRESrv9fKZrPs56BObSYn1aUIQnv1CBqilhNeBgQG
         eISxM3i7jGSuiYwHpv0jHn3Zbku8fe0sHXOi20vww/d3JbQiCHhExfRNMccAxOXWM2Px
         U4qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780071084; x=1780675884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOEaPD7Rz0zsPbSOZbfxpmu2DbPZ8teKVvGhPB/4or8=;
        b=AgWIRKCPHSu1MLqwMiYstxYsLmf/eia7r8RofOiwW+YMQpyGX69Ts5fLNYcBByfV8d
         VYNnmx6qY2H3SPDI0wAV6EIb9SZsMDNA8UdVz4+jjFaCO4nGUBUKdVIiCbOjTogR4fWb
         4l5hmCHerwII30+MH1iLuQCwUVcDRJqp6FJlmxiTRpMyCQrI7686dyewmytTSwTY5DJl
         p6ZsK/4ULRIysPSnkwIXjVDNvv/SKz8wGcqsxcCg8J+jS6pTodOgqJj7oNI/IpmyRWLi
         t69Xrv9I8KSKZAv+U8OgJDElY5aS4BiDyeevg7VE9f/RVNwEz3td6/SVdAc3l1ub0BZU
         Q67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780071084; x=1780675884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LOEaPD7Rz0zsPbSOZbfxpmu2DbPZ8teKVvGhPB/4or8=;
        b=dUeU63XP5KWChlOc2B2CJHSk6HRDXfj4M1QGQe700coldt9elcb+f+dYK5rQwtUhRo
         QAuOxE5yLMxuH1QM4SLJrMADBKXHPihJbhY/fPLT8umkOie7Bx6chTC2YPdNkfWUBmp6
         diDJ5qSNH2NVYX0X4KABnAA/MBd1z/T0uNhX0q5SrgV9kywOJbBvBD3IRFZekSIuBupK
         WVC/+GN0vGaf7PkLqqNc7Vc/HTEAhR6g6dyilL7Q37N4UX4Ms3qGRaoZa+556UPVlDbW
         nGo0eEjyadI4L+SiUM+86Ae1w2AnZv978pqw66m+NUaodUdWNFXkJvuUUiCgW4GZK+aR
         ZSaA==
X-Forwarded-Encrypted: i=1; AFNElJ/Gv5aEbHpW+1v1pWJRC4qpVC3ZZgfZzgJomMyF81p5ZiXZdpDXy6oB1JFYT2qyw946GlfOtJXB@vger.kernel.org
X-Gm-Message-State: AOJu0YztiauIuo+Gxn/yqurMSqhcPG/Lkh7EP129I36WZkVvcyQkNpNS
	uhfKXNHo1isjt9DIQlbtmkcvQSLynLctXnLBbmKqkVsh+Zb1UJ0btMSL9TcqKSSO1zqjdJIledi
	iMQZsx0s/iewJpW/c6EAVDYtHBA8GiU4=
X-Gm-Gg: Acq92OFjFwatL7jYsX5oAT1y70hPVO7s00W0lwi4HSq9iYsitTBSEzcRPwcGnq07daX
	3EUp+VnrpuIhAGWX3YkxNBqASRqhTiAd8jRYC6ycbP7RDVelt3ykqk3TjoNbGUKOBVPHRPzg4Yn
	tZzZpqecD5XGilkSGI1ctImhYfo4y4C0RmydMzhh218zWHd3T6BbWGItG+I1jsSfsKbBvDlfqF+
	xa84uLg4attaxzVQjUFRmbEqdr+RY3lHqwe81HyUP+CEBNKDE2aobI930kBgx1OFXLRTCw0Lft/
	PfsttdIVIIYdu0qC8w==
X-Received: by 2002:a05:6a20:e306:b0:398:9d5f:e093 with SMTP id
 adf61e73a8af0-3b411cd03aamr4325288637.19.1780071083461; Fri, 29 May 2026
 09:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com>
 <8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com> <CAEjxPJ7Y+9AqEVTJswUsan4OOP+DVkFG3vXukQVtcJZbVaoZnA@mail.gmail.com>
 <CAEjxPJ6DqhHKdjwC3ddZfUK4HVPwOTzb1Kkuabi5WmwmF8Lu_A@mail.gmail.com> <CAHC9VhSEjSmdVgNxg=PvwS6RXnJzFybJtFhCJbOsKiRhXi5PJQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSEjSmdVgNxg=PvwS6RXnJzFybJtFhCJbOsKiRhXi5PJQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 29 May 2026 12:11:11 -0400
X-Gm-Features: AVHnY4L4gN19PG3AQEBx0PURc8Ls8mq8w1hJmRjX8Fp47k7jg82ZQUCRn7L1ESw
Message-ID: <CAEjxPJ5wS+sXvCjO3q2sfrckuMo71_Y3uSdgu+Vte7xLkW0Huw@mail.gmail.com>
Subject: Re: PowerPC: Random memory corruption causing kernel oops on Power11
To: Paul Moore <paul@paul-moore.com>
Cc: rppt@kernel.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	selinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Ritesh Harjani <riteshh@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 11:39=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Fri, May 29, 2026 at 11:19=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > Alternatively, I suppose we could just update the dentry_path_raw()
> > call to also pass PATH_MAX, but
> > I don't see why we want to use __getname/__putname() instead of just
> > direct kmalloc/kfree here so
> > the size of the buffer is immediately evident to the reader.
>
> It's reverted, see the posting below:
>
> https://lore.kernel.org/selinux/20260529153608.30853-2-paul@paul-moore.co=
m
>
> I think there is still value in using __getname()/__putname() here as
> opposed to a simple kmalloc()/kfree() pairing, but either way we need
> to adjust the buffer length in selinux_genfs_get_sid() accordingly to
> use PATH_MAX instead of PAGE_SIZE.

IIUC, __getname()/__putname() were originally internal helpers for
getname()/putname() and allocated from names_cachep for struct
filename. commit c3a3577cdb35 ("struct filename: use names_cachep only
for getname() and friends") switched __getname()/__putname() over to
just generic kmalloc/kfree so that other users of those helpers would
stop allocating from names_cachep and noted that those lingering users
could be converted to explicit kmalloc() over time. So I don't think
vfs folks want new users of __getname()/__putname() but I could be
wrong.
