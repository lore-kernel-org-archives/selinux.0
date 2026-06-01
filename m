Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E856430C34A
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336728; cv=pass; b=XQjIu9tCBlzn2dyZo5kzT3K/DZ3poe2nahWeihOpOLPQ9wzEJQlIigzUSde20xwBBFQP1aFT1VFWDiGKUSNeRNIDhfXKjj2QMG7jxYbzcP7P4jyryNTN5FI5Q1XDni7JfX5pafSwKupNMtLTvdNusnaNqf+KMk52BQ2ETcKSlag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336728; c=relaxed/simple;
	bh=OjPt2Mr2IaSO1ZV3tG/RSPwfAKPQ7OY7N5llagrY5Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNytoxzSZ0qxGPsvEstMVTvbIQ/cRb0lDiXDx8DUeLvKzk1UbIvMU9Yv9/jXMIF74U+KW3+dx+CkiKUMYx96ryPZhkaYn7ScPAAwf8Kx/yHpjsuZJCx1eIgtkBODv3U90yQOlj6zK8teSwD/HnEQ8XsfS9DdLl9vEGVV5t8vESM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEkQX0NU; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEkQX0NU"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84234c83142so701727b3a.1
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2026 10:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780336726; cv=none;
        d=google.com; s=arc-20240605;
        b=PWfNOYPmyfiM0+rmXG76o3A86zvEQeIZiH2zgfan/Q0T3yKXpmeUzxQh4nnTDNhuDa
         IpLzBTMhdQwrRSBrnbqBu5MJxiG72PwD8PtjzZBQKKM/ixj5w6wlWfkEnEXI8zZez8xJ
         E/iyj99KjoLK3/g0Y5Mf3C+c58y0X2NATymVxyE0GwYvuNFfO2YhKxifbIcKx6fHW3C0
         BMkavDCYNN2w3EWxp2nsS/e4/8plXbXIBE/s1an9oOW701zz50h8zzO46WORPUl5My8J
         lv2443+dhCGoB/iODs1zJaiiBT/F4G8tSeJsspEOl+gNkHqL2N7eo8Mrc0BmNJa1HKOT
         ikcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OjPt2Mr2IaSO1ZV3tG/RSPwfAKPQ7OY7N5llagrY5Cw=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=j5nmyVGFFNX9GU9YuLAuJGfTOe9FI2nZoj3SPd3bR/RNhIkM9YRM0EoQQejelOOxlX
         NnyGBrY+cDOS60S95Fj5wQ0g+eds8MHgjalvN/4j8KaULsMuWIqMxmQpnyqs+KzzkGfl
         1Gw19rzj1SguYfT9oPUg4ubZugAQDjnEsv7C+nHZP0bNgoJD21qDnX4CJjhoOijePwL+
         DxRRPPX7kmMfIsWmp+5+8msz4szk/DUmSQ1ppesPUccKl8YU7/pf3GPrJGDLqEUSGrtf
         HyvTel4Fxl1XmtCmbbAtk6MpKDhZYabp54rPNxADdAuV/zlfo9SDaxoerLqFbfzXJeJR
         Ptdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780336726; x=1780941526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjPt2Mr2IaSO1ZV3tG/RSPwfAKPQ7OY7N5llagrY5Cw=;
        b=HEkQX0NU3O6KG/knhNlb+/4asvTp0/NSe7cmK6r6xZVg3isYMeBuGaUmOhxmRICj6L
         4jWWoq+rsTV1a31LFuX68BGbYYjGWlIqD9VXT/dbezjru1Soy1N754aUuJEDWydmCEFj
         qQ9/EfmMw6oJrweCZdkB7CE5H7J3jVjEt6GzdfLRci65jvkFoSKHehQGVJqwfJ8T5slm
         3rBnCkVyl2VlMCZd4YNVSNpOXWkHwbF7GhO4sBOKGrlohfo+799VopKEADNYPKIDs1kF
         R3ZBqaWOYZT2mMImQbjtqKkkRue8wE9m1XslrTpEjOoRYYGegeoaPf5ECg6+GOiXFYfc
         ictw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336726; x=1780941526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OjPt2Mr2IaSO1ZV3tG/RSPwfAKPQ7OY7N5llagrY5Cw=;
        b=UMBJjmlhGmTBvY4w3cEvXOCi4jBVUecSIdtBRBv3QpUtLfKqesgShvWN16VzliyTRv
         Ggcp5bMrdoYS5R2suSqwRVl+4S9kN/W8XogoPmyZxFvF01eKQe2RhiLtTJb/waRte+Or
         2fOacwbEZoGFWUvFP4zAvIo8sdpuL7VycIcY71rma80Ocll6ggWMFzKQ+ua6b3LVWgFj
         jXStRDu6J0ncqtBbvWJp2MvMI+We7FtGdFirqWS3prX8P0YpNu6W5bgJYQzNQt6Vf78G
         S2Yg46xRgAf+k5vHHSgsfxOc20HFE1UzuPYEhfNhwCMbjf4Jp20eibx3nhVLT7jbMxNA
         mloQ==
X-Gm-Message-State: AOJu0Yw3AeN2HZbDxPCL1fClAEIZlLZ4f2Zg7WyHxrrrkfk+7LSiuZif
	KtlHc1b6S3VW12GRCYlomDUgpe3xgg1n8sgGLl4xP+LEgNnCTwQPQmYckZ4VJUzLD5wtgppxvsO
	+KayrAhVK+mqW5r3CoZ1RDMBPitkxZgbYUA==
X-Gm-Gg: Acq92OGyKXoQsDTb1JHKpZRfoKrJk29adpohri/Gr+89+GWsaf7zOwekrEFc1MnvwZn
	BtZ2RstQzifGCpnTDK+l1xB2h/nVtpMW+MMFC8m8/mkyCqo+4it3V9fc9Oxdo52SB+p+uwhm+c3
	PeKMkh+igbtdJdRd05wbF/Tf9CQu2WPJZzB3CHLZi+qUYz6Ow1t7kq7Qm/8CrEmhgv+oCopBUc9
	7BJrbqE/HU9Rfb+WvmDPHhDQehpJ2MYzgb7B1Ueg+SDaOpQgcgo7OCFAV6qRpkRtxJX5W1PVauE
	ff6s8I9KJKt7J+2h+j5IIl5atyAv
X-Received: by 2002:a05:6a00:a20f:b0:842:6e9f:9c4 with SMTP id
 d2e1a72fcca58-8426e9f3394mr31744b3a.45.1780336726068; Mon, 01 Jun 2026
 10:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87qzmq5iia.fsf@redhat.com>
In-Reply-To: <87qzmq5iia.fsf@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 1 Jun 2026 13:58:34 -0400
X-Gm-Features: AVHnY4IX9RmDF69DEJDb08zu0Hu9oaTTJtJA0FfMy4uUQcnwdt9tvvh6r_HP8lg
Message-ID: <CAEjxPJ7fDTTwWKaDse8WrW=OGP_V5UpAYEe98GGx_YZ8dQHmSg@mail.gmail.com>
Subject: Re: HEADS UP: SELinux Userspace 3.11-rc1 release coming soon and code reformat
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 12:40=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Hi,
>
> it's time of the year when we usually release new version of SELinux
> Userspace and given the number of recent fixes, we'd like to release
> 3.11-rc1 during this week.
>
> Also it's planned that the last commit before the release will be code
> reformat using `make format` - this will effectivaly make all unmerged
> patches unapplicable.
>
> So if it's not urgent, please consider to stop sending new patches.

Not sure if any of the libselinux patches I posted today are urgent
but they are all bug fixes.
They are all easy to re-spin if necessary after reformatting.
