Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0E933E35B
	for <selinux@vger.kernel.org>; Wed, 18 Mar 2026 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773877625; cv=pass; b=sj/gtksrcJ0jUdodOtDxKjcxhxRXIlOWtPt8yL2LNaYlTVg7naM4dQ3gqenL1jfSecmmHoHfAW7GZqzZebqJ3M34Rs3VZdLw6UWQlmKkeW1BbJyi1iAAj7F7rvpMipWEpLSAzXoO4ilj17fWddTpeXc1dPguL/Si0iY6VymE4OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773877625; c=relaxed/simple;
	bh=goPdRYRb1QYfjLs/QmPDwV3Kh5LoPgcZM/xi+f3fGd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdOb8dL9g9hWuXMEaGMEZoLvIw6oYNspkdPmgAuDpTcBE2utkmjMYB5lWgUHd1aGWGetldvh1LhsEo+vAjQ/hRqFdaDdx6VQcJ3TL8BHZ9TYP0BDuFWydKBhvSxjdzOmpF2xw6ItNKVQ4GhANiR2r6LvarX8bPAd1viHKnr2ilQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AKLsHbzP; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AKLsHbzP"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ad9f316d68so1667645ad.2
        for <selinux@vger.kernel.org>; Wed, 18 Mar 2026 16:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773877622; cv=none;
        d=google.com; s=arc-20240605;
        b=SYGHHokxD/bDQ/cRi9BwOLnoENlvuhpVwHZUoX5Bf0//CVcC9qaJNGvUxR7ZvlwBY+
         Q7xXY3/YCM5CC2c1ahZOWk2UTsVjwYoZ/btD3dyc6VmNLldRq5x61AsALmH9XbtUTVlQ
         /MLXqJzPijuEjVeR9fxxGTS9mSOsriigsScKixdJQB64PNH9GRSqvANDI4etu1SZBSkQ
         GBHM9cNOcGRwLvNq9R36r0EtAKDTmKsrv1g4fz5S/JFWEQzKvIZPp0rgr3vZy6L7MgAR
         o5/gNbP1RHIPdhLwTPL/Hh9ib1QrsVX3iNRy4+BqaPJEzbDnlyYU27uV72A1Tc0jczl+
         KweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKdeu+6dCkvAUwBQTZO2KRv3z1lv0eoszoXVMxx1Rl8=;
        fh=YbbCUspLrJXnUaG8uuj8zvTtO1TZLBFPlp9H+oNxDiA=;
        b=Aw3dOuKJRkF51bDanrehs1zi4ZOUCk15r2wEfwd9eFQ+SdngfYZ03oq3JVxRPgjwun
         zzONa8SXhLuT00WGaKz54B5usTo+rdGBqqLueUAkGQgkEYz3EivZPGQuuVwmeALrfzP8
         C6L7SFft/NUPEA+SOkaSHGz+RvWwSitgqmcazya38Nur4ZCbIhMfV5armPPtrbWJfGIQ
         vyvnK+X++h46H9anjzbh6iLYzl4qtkpzkJfUGRrWctn4wY3moUgA49KbHdgBWXnbGN56
         YhbN1JsdKqfa6CjCBvKZjIZB67RXDyaEX4vjr+6LI39NBOR4mJP/oFgK648sMbZdG+6t
         r5PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773877622; x=1774482422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKdeu+6dCkvAUwBQTZO2KRv3z1lv0eoszoXVMxx1Rl8=;
        b=AKLsHbzPe/UFGdaly4ZmKWfwEwmrHjd1DkZL4IVkQuzIErZyEfHo63QiPdDZocQ1er
         TDQuBHxvJGfj7ByZiLM4PkfV8rNk5V/3NumordXmOjXxnaeC+X32rN8w4u++FYqMJ922
         qiHl419cOnkMprBN228Xaq+2531KkoPltl6Xoo3Vp6WW2pPtOlttG1dg8+rgq8J+7Dml
         4EjE2vHGePmPhTt2w4gTd6ctMcC6LeWCMahkdppjXGiyBMeMN+uX9UjHwZhkMaO5oXpt
         utlaZH6uQCma0rd7bqSMOrjCIguHzeb4LLkVoaJxpS4oP3XYJDepNYXITJJxfvyktN/S
         yLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773877622; x=1774482422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKdeu+6dCkvAUwBQTZO2KRv3z1lv0eoszoXVMxx1Rl8=;
        b=YaNZoHudLsNMH/qBITPRibDrwI+HpEyb4MWUVUFvhpCzjepCcHqtdnAPPHudVn8mLh
         6I6CNr6+U+HoCdbSjbwB/bPxlTa3/+ZdPjplotGlWemqZvGS4VZ/wStxDQEpxD8TdzRK
         MnV4SJa+tFR9BEm094qfMdniU7gvC3lyElghQfTd2oRidM11B49qpI3cafH3c1EWQUNw
         Jm4nPsQ2p62haY/MAp9JKIldCP4FPsOdPXG9ovX7HGo8yVtZsecZfWzXoohi2Lk+QSHA
         xXSMjLX9RHA5wQiko0X5scXFMVFjRn/fgrOExOeqnCqQJeUYhWZXGoUyCj5Scn2flk+R
         UFsA==
X-Forwarded-Encrypted: i=1; AJvYcCUt9tsDKubAMdMrS2lFKmjSWLEe8fGdiJmeeLi4RRHqhnouGxuOIGtW1lX1WpSz1l5C/zZcHjqU@vger.kernel.org
X-Gm-Message-State: AOJu0YzSjQQrKXpwt/HOLL/B5JVoY3NzAZhwaTqrazsThFvAQrTcyw+c
	JU9/uDOzR8j3ByxNSAkyvuRJtQleHnSS9Ok8KQYvqb03VTmlva7e42tM9MTpn++zTZ4wU2iZ0Vo
	u9zSeUtNn8lvtNnfYEZ2eVehbfrmTHUJiZNxgmRBw
X-Gm-Gg: ATEYQzxYCtKxdZtTOt1gtPRRnRDu9487HHdnpWea4r2fBskERuymI/cUBE3tAx11cWQ
	bGGoMapmCLIZ6SqFdwKkXolMrLXmDcpWO6dBNjw6hZyGI/eOb5xj7rWvQcW0nQCKBRcZhoyriI5
	4xgyiHl8122cThjC5o6yG/K0Skak0OTvoQRMcVLD7uCR5dc4LO4eboA99t3FCocf0SpzLc3vb8K
	JF4Q3yPFMtXwv7oPbBmIW0VUIkuDArchsHhftIyRevlDEKXIwGh9J0b8QQ/zCRlzgnOKw7cUXyz
	IscAtIE=
X-Received: by 2002:a17:902:f547:b0:2b0:7177:d5e5 with SMTP id
 d9443c01a7336-2b07177dc04mr35425715ad.43.1773877622532; Wed, 18 Mar 2026
 16:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318131258.1457101-1-amir73il@gmail.com>
In-Reply-To: <20260318131258.1457101-1-amir73il@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Mar 2026 19:46:51 -0400
X-Gm-Features: AaiRm50UCF1CurPQjVXbzqdFj4rL7YmqoTti-AfxH9o9diMwAaN1iIjAFrpAzkY
Message-ID: <CAHC9VhTKvOzMS2ZyawE=qBN-EpyucfxvwcHZYjXF5zugRhE2rw@mail.gmail.com>
Subject: Re: [PATCH v6] backing_file: store user_path_file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 9:13=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Instead of storing the user_path, store an O_PATH file for the
> user_path with the original user file creds and a security context.
>
> The user_path_file is only exported as a const pointer and its refcnt
> is initialized to FILE_REF_DEAD, because it is not a refcounted object.
>
> The file_ref_init() helper was changed to accept the FILE_REF_ constant
> instead of the fake +1 integer count.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Christian,
>
> My v5 patch was sent by Paul along with his LSM/selinux pataches [1].
> Here are the changes you requested.
>
> I removed the ACKs and Tested-by because of the changes.
>
> Thanks,
> Amir.
>
> Changes since v5:
> - Restore file_ref_init() helper without refcnt -1 offset
> - Future proofing errors from backing_file_open_user_path()
>
> [1] https://lore.kernel.org/r/20260316213606.374109-6-paul@paul-moore.com=
/
>
>  fs/backing-file.c            | 26 ++++++++++--------
>  fs/erofs/ishare.c            | 13 +++++++--
>  fs/file_table.c              | 53 ++++++++++++++++++++++++++++--------
>  fs/fuse/passthrough.c        |  3 +-
>  fs/internal.h                |  5 ++--
>  fs/overlayfs/dir.c           |  3 +-
>  fs/overlayfs/file.c          |  1 +
>  include/linux/backing-file.h | 29 ++++++++++++++++++--
>  include/linux/file_ref.h     |  4 +--
>  9 files changed, 103 insertions(+), 34 deletions(-)

Still works for me.  I'm going to update lsm/stable-7.0 with this
patch so we can get some more linux-next testing.

Tested-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
