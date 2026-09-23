Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917E2531AE3
	for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169709; cv=pass; b=Q9i4aEPY3VMaZUACakdd8lqitaErbz98KmzWSZck7l0TUpWKh7RqEKyKpR0k2pL6oDycYdXvsptK231ls5B6BgqdkjpbU3pq7Nxf1rswuTDJ4tYbR7CWb/6AK9RR3KO1029JMPyooeg3zGD1gCBYDwXEizm0dJs6MxVThb+ePxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169709; c=relaxed/simple;
	bh=GIyIZcvcAthbZqnwhXyd8R3veUb1j+Z7Km1ncbDrQ8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ja0xRJws7pGHjrbnZWGmAfvQWAWH14MfJUfN/ki3Wf2R8B6MiOuxESOc7uppWHL2DhLOzc4rgLEBQz0O2jykj95ZPQpIY9H8iBI5oI/JG67ypMB99u0Bb4FNhhc1lUtOE1JXjww+I8QZpSkE4kB1vq+CeLdBW4jKpA7o4IHy8Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTctTbu8; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTctTbu8"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43ac8d1eso10321287b3.2
        for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 06:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790169701; cv=none;
        d=google.com; s=arc-20260327;
        b=kfoDsN7Xf7ioD6Ha6tCN18H4G66qEHZek6gZCw0SdciSN+d1+0OnA1BnxRL6vDcKkO
         VT2hGkp2XBufgrAADSE/8PXFFbXUQ8x/tuSbq+uxaXgJ+mrtJ8y17Y6X/K/A1CX1Rimu
         xPhZeDrGw0OI9giaUUNN61iL0LEOLW8WEuIl/kfKMjmLUlJlOVg6+cUgJSEtjbL7TbtZ
         gB20YVOgPsFG4pSAN+BrFe574HpjmiipnvmeK6UPpYkWj2WQdcPZFAThdBCx+AxoTwSi
         vWerlM44S4oH6uM2j6kQbZh+hfNPz3vQ6KWehtSJyXCSS47WBZLIuFIG98lik2fbjoWJ
         z7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GIyIZcvcAthbZqnwhXyd8R3veUb1j+Z7Km1ncbDrQ8Y=;
        fh=SjvsRls8EMYSjjl9Qh7dZOJWARuq2ZTRyx7Rvgz7sRw=;
        b=bVG8P3RthgCAAp9gBPXSSFy0fMsRzzZXmNawahDtkQ2U8vu9OJB8l8gb8QjCKwFMh3
         RdJqeUK3GHDeBs/j3fL8gMt73o1AKJKWtqQRgbkaw/5MJlucJiR3X0Ce6XkwUnJreEgS
         wxdvjAszy386PZPDfnVy0asKhexMMGW0hBchAMdd+HCq6QSAFR8RyrUMeksjRBi+Fut6
         tkEXq6Kpl5HoSgKcpAhgpgApAgW8a9UsPyGYr1CBhUTbfTkP3t5qXCnfTKQBTqvQ+0/1
         i7HYQb2wQ7YQG7au12+7KxWj46hPJlTNLsfis9z969ZYpmGUM63yb5VVhTyAEJUgmK4D
         DNGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169701; x=1790774501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GIyIZcvcAthbZqnwhXyd8R3veUb1j+Z7Km1ncbDrQ8Y=;
        b=aTctTbu8O8Fbo9xA27uC8PZ/P2b9L3PMAmaoTcqJ4UilJnYG68GDq3FgDTXuJMns7e
         Xk1PIukpYWBkbxZ/0JWqxjnF4MzxvctroiatDIg6k8M24I/Z3ZyXhuWcSZt1IEOp9gSh
         OEN4e6nO1yTE3JVBwYv68EEVCyFTIZ0uIedvXu/lABy7CUkglTQ3uGMDotKCGMn79JlY
         Cyk8c/xV/RvCIlkW8ia6IhOloTUPfn5Uc6Ygr7yJfDJ6I/EBkDBAxCnsNKxi1ZefDNcJ
         PJWP1tBozWgD1GXnNiLPiR3hPSlZ2TeifYMx2E3VYPH5WXkDNlvBStD+CO4maRX+Xt+7
         BhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169701; x=1790774501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GIyIZcvcAthbZqnwhXyd8R3veUb1j+Z7Km1ncbDrQ8Y=;
        b=1kKzmtaTX2YIXuUBx3pCBL2nffNtamhPjFRuXkEDTXOf6AoFLhX5yZRZObeAHAz1d7
         LpAYKyp7hkaZruuTFRVj01SbqNZ0KcASL677jF0RhmSubZAiZUgIyyKtGQd16ycZTvWk
         846AcwaYr6VdMdVetO2YZteoivJVpC5c85O0Vtf9YeuyH6PjlWuSs7WNmFPKqi+2QXLs
         0rKRPuo2R4t0tl8a+690di7WYk1ehmi4MwXMvUlmRAH1/YLK1xOsfGD7mPX3x3GRA1ud
         NvV9sVU3GGajqnGnKJIVoI1m50UU3427IS/Adu4orp0dAyZLm1+oohg9YnQ//TRFHnOf
         olfw==
X-Gm-Message-State: AFuF++liGX3IC1GaPLJ2dZ0dkJFQshSg4Pg01QIVOk+TCdD6Ue+K3va9
	cpJWhbFnmYS1xG6YDwrOnBZryW7Xvas5e6QZ7SwRji/4YmNdAuR3j9RJAJk34ZjelbeynS8wlgb
	GCVLzXzOy08lk9z62Z1SnMYWO+4gOxG0=
X-Gm-Gg: AYBFou05XTO7bqRhJ9BAB36pH4OokAGjbH22Oi7am24mcVeh+UD7sB1p81n8RTJgHw+
	0lAxq+uaD4BlHWeMz8F9a+CtdUSWFxJj80uNp5277b0puMIwbbCgq/sDkUtQ/8Rzlpn3Qgjpw1q
	GOqfcG4EjCgBwkJb4IfXmkPwDEBrAY4U7Om9mlDjBGOeJy9ICS7dIhzbOkyJLlFIlZ2X03joKH7
	jRI9j/x8MnAi0CE8W1kKdi9UvUHAHzw0B1ibVTBUejxVameHZmYY3vuMpG+4fk7Kb1iS56Emjia
	/RdlnBjZp0gLQ6WEKZy6tRGnkD3Ix1YjiHNpjjjanXpjl1nE+eV7c8Y=
X-Received: by 2002:a05:690c:95:b0:883:768:7432 with SMTP id
 00721157ae682-8a45b97c569mr17802797b3.49.1790169700282; Wed, 23 Sep 2026
 06:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923101323.2996793-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260923101323.2996793-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 23 Sep 2026 09:21:29 -0400
X-Gm-Features: AcwNN1Ur2C0Pdc5Kn1b0Fx4NZUf31Ftd0VBFnf74Op5lgoSiY9jngGootg7F5Go
Message-ID: <CAEjxPJ6DQ+W6OvRhO50D3G4oq_VoMoZ=-tK8FAHe-6tJwCJ4qA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix data race on AVC latest_notif
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>, syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 6:13=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> avc_policy_seqno() reads latest_notif without holding notif_lock, while
> avc_latest_notif_update() can update it under that lock. KCSAN reports
> these concurrent accesses during policy boolean updates and permission
> checks.
>
> Use READ_ONCE() for the lockless read and WRITE_ONCE() for the update.
> The spinlock continues to serialize the comparison and update against
> other writers. Reads made while holding notif_lock cannot race with a
> writer and can remain plain accesses.
>
> This marks both sides of the intentional concurrent access and constrains
> compiler transformations, without suppressing checking with data_race().
>
> Fixes: 788e7dd4c22e ("SELinux: Improve read/write performance")
> Reported-by: syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da7f7cb0737bd91aa698c
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
