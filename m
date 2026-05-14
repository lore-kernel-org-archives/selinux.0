Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8432C1788
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785213; cv=pass; b=oqJO0lkWrJKRQXY2ufSz9fhSzXCf8f/WenQ3MbG3E8GEwjTUC+LCubh1l5ZXBLE6urwcBhG1Za+4jFpqaf5v1clE43TQnE+9sfa7c3ku7R04EkuZpk0c2ch02LcCGV200yZXYCUxZe7cnt2jNWTPjZpNCPV9Fh9CjlBT620ICb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785213; c=relaxed/simple;
	bh=V9WCIXH/X0EbqeneYvddiw5pcu9pJfGiXq2YDp2LiCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeEl81mXDegnWyqeCnJZzcVn0JkPeQDbIECItwbG5SkNK2Wyi8l5dJOKGTaeTyvirvRc4vModZgSegqHiiy4xAiqsZ/t0gYyWxirLIyssv4cnKj7kXgUwIP7cIWBfe2+/QDVOu0VDo+Ilp+Wv7nuh6+ZDtukh+sVZZVpwXVaH0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dvcuZcJc; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dvcuZcJc"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3660daea6a5so4651458a91.1
        for <selinux@vger.kernel.org>; Thu, 14 May 2026 12:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778785211; cv=none;
        d=google.com; s=arc-20240605;
        b=Ag2WmUVD9/2kgxoJ1TQKbxkuMNXYkvSNjNnFcHqwbrkkbN9QMH3ibMEbDvhPRzZTHs
         +R/VaqpxVgnHEa3pkeyUAgDPLE/yDVySV8N4G/66/T0lXZirn2hTEM5ooqliO8R7kVrh
         2RlIQS46I7Gw5ES5MegQhv2qjY1B1914DBXUHGKcnCEsis78gWMMSolE7ZyMJZ5Azyce
         D8wHk2ADO1Ee/Y5R3HEZgvnhrFBmD1w1Rq7DDnidvgiVK1hh1VsGEfNZd/ll+fAIjgNK
         a2Jf4OVtuUDVL+kZcaQJrIvhkZaFzZL5SsLKR0gVhqXLC+O3lC0HwilmrnNy6WXWMo9j
         8ANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V9WCIXH/X0EbqeneYvddiw5pcu9pJfGiXq2YDp2LiCA=;
        fh=45GNU4U1Znj9EUw6gAzAd8w2nDGnnJhKxsXerzUGvHA=;
        b=bhqE7cM3eZG22xSaZY+EInIS6LqiZMTHXbtMyZUkE3TTws8E41iRMQFSuvkTqIgmKT
         IuA2LZ2j9NvoaSOWpOmia8SGRpez5QL/375JP4Wps05UumVBf6twkffHgsxCKGs43xbd
         2iX+7c8E75YNrhgHdfiK3iwUo5BXrmnch+/xWDR6pB00036y0x2VEwkv0E+mIuCFwPy4
         gpl9ikMJW6o1OCh+0zr5ziM5avZZ7ESmFsiavnMOic5t+F2XvU0AMFlhsxjnxceRQuL4
         DNcfhW4ivNvMWF2gF8VWbdhbJ6g0vF6OhmkXdDq+3U7PVeAu1H/pJ3PdrBKCEjSQKf6Z
         oigA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778785211; x=1779390011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9WCIXH/X0EbqeneYvddiw5pcu9pJfGiXq2YDp2LiCA=;
        b=dvcuZcJcQWFZmsmlQgbg7OylxMYx2a0CbEHQqOvW8xFeq6Fiv8oIF63qMyOwO/7T+u
         a4DfvygKlRIoM47IIkxm5fhw1vjRDMStBWvvbWAoq0wCvjWKGnc8WS8/EohTghumWUOy
         7OEcusEMRNDAvSFyiqBHzNFlu1EJ6kh1mOhVRcqyH4V7uEzoDdbYfAMON/bdRJSyVCK4
         ZE/9M5X+8rjFno0ogr5z9p8llJU6lqjIvJY385GotBuUO+Zm7Pj2RyKh3e3FkyDjs1Bf
         kVdhh1gqMBmMpvBpZloKifg4W8aywWCdMnBT62sySmX/TtAObPJ4gBLvx9iqk3ZiBxRN
         9rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778785211; x=1779390011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V9WCIXH/X0EbqeneYvddiw5pcu9pJfGiXq2YDp2LiCA=;
        b=Ep4wXm4TF7sII9wW2Av/xNfMkkB5iAZ1Ywn8RxondwGDuPH8rgR4EETSSDsxlWsXlM
         uKQyJLSs7otDgwQ1aBafa/BHhIkhi8Y7BJ2uwhgHZXFgOlHbNxXCKw4ZahrowrB5Ej0P
         qZTdSl3OrUAgBs4mfpwBhMbsaoLM5btB91WJVoStTVE0Xko4HS4RyQoDAP1QjJ0devyX
         P1VBPf+QKl7MPlnNw7bR7hc3jW3WcVEihQmaORdCf+KYPOXe6OFxOs/gufwjzYrI2vRp
         I9Q7lcrWpUZywXAtrZqbuvu01pG8NzfwhwwNXASGsihQuXl657miq8ZOFxNHZywurvxb
         6Kfg==
X-Gm-Message-State: AOJu0Yxgbg78fgAsOTmQZcWGwuIu2vpYxGrD0CdPcyE5ES+kJtM+geyO
	zwrEK+6Cxse8yaYWqRApDo8pBzdbwPAMTGOlQpdQna2dOGg2ioUhYclzb3qgXS7jkzU/JTmmohN
	BTOqGl0pk85F4WNadOPebY+MK+TsE8X/nHNmEkZoB
X-Gm-Gg: Acq92OGTgChwdoX1O9JvVyX4lGsis8/EcDQvh6WoJRrfeMza++uw5/e0ky5+5oIJsl0
	8sqtUuGpuj1qHUZyk5LMCXrWiy7EIJgy7S4U73N6kJZFhsNTkY1ITCar2bldp5xLSbco+7AZvsF
	FNty4NaSv8h2Tqg++QdVzeYCBzMEvHdzSG2j9lgFHFu2R7YDiz7iKDA5uYMTSgs8NW6+79b6ibX
	jNjYw2xoe99F1xBd1FcbopAf7BBuVVnd2LDmp+aPP4Ru0/9PdT9V44+Z+8XmAZsq+RqsDEKoBh9
	pwN8tnJqU+rVmOn6+Q==
X-Received: by 2002:a17:90b:2752:b0:369:a78:6009 with SMTP id
 98e67ed59e1d1-36951a6724cmr646353a91.13.1778785210964; Thu, 14 May 2026
 12:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOssrKcz2w1A465OUGr9jnWDAd+AN-Mt_AL_xxuWQOqAz8PRAA@mail.gmail.com>
In-Reply-To: <CAOssrKcz2w1A465OUGr9jnWDAd+AN-Mt_AL_xxuWQOqAz8PRAA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 May 2026 14:59:58 -0400
X-Gm-Features: AVHnY4KyxjtG9uAFPYoFvXN0JwwIo0AIucrsr-9QWmRl2_mQaPkspDR8OAwu0yE
Message-ID: <CAHC9VhTzDERE4phHRXTOFmaRJp_xuX3HgGwwRU0sxJJierPUDg@mail.gmail.com>
Subject: Re: selinux_inode_init_security() weirdness
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 9:47=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> This calls lsm_get_xattr_slot() at the very top of the function, which
> increments *xattr_count, but can later return -EOPNOTSUPP, signalling
> "ignore this LSM".
>
> At this point, there's an empty slot at the front and any xattr added
> by other LSMs will be ignored by the filesystem.

Take a look at commit 1e5a8eed7821 (" selinux: don't reserve xattr
slot when we won't fill it") in Linus' tree.

--=20
paul-moore.com
