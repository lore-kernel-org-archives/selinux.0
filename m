Received: from mail-yx2-f29.google.com (mail-yx2-f29.google.com [74.125.224.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD92542EF9
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695512; cv=pass; b=QE1fRjPii65+ersEdrQtKt6trAaWXbxkFL/9U/h6lhnPx3izwfOCvsWegCwK4fOSLbCjO2JpxohPqBCTteh2W3Q4fZ7RHAhYGb2IdVETG2Fbg0BDMdX3fy6yEVaegIyhfkoVF7JpBlF5aFodVifHOX9k/U23rHLEYDzRfi8JkY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695512; c=relaxed/simple;
	bh=QzLqWpGxY6QytVaRyW6z3EAT4SRAEDSWUPYPe62N+/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6ml+jLJXBzNUDrI0ualGslufexQhrh/zVnxoLCIFipFuLhpC97b6RQP5ZvMBU4bsiOHL7x86lFH7+7utkKc5nKbaHLk4glVjY5jPlZr1W9TjLbFaRi8yb50F4A5SRM7jpJndFB69LSfCAbnn1fkNNcCp5bxSxQ7K1v9fG0s4I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c55pGMXe; arc=pass smtp.client-ip=74.125.224.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c55pGMXe"
Received: by mail-yx2-f29.google.com with SMTP id 00721157ae682-8ab3fa8a788so10692907b3.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790695499; cv=none;
        d=google.com; s=arc-20260327;
        b=V8w4ECqpOqmBYlYxsQKrhf6EsHhub41Pb8/KwmDftbn2kgLWu+OY1+IyBoGR/a10Xw
         Xt/TzvcZd1Yp3IcHTigygfinKVhPGxxeOLd2vK2sWRlosnJg2tIsPHrLCJlmac/f4ZD1
         U2u/vWcjqlIrDQ66i/ayJyN32mUSsZm6x1HoN13GcFt22hn+3/6j1c/jWZ35cbJ4Kxpl
         pzVZ0mEOIpd7hyyQmoQYkWVgxHjsF0p1sdJWcOXJnywEWnxgdlzUXgNV3S4CWUOqQDJz
         HaxvofM6BoAFobC+tmGAZhnFVH3n1cu8+qy9Pr91HW1HoIcGZFofEMpshG30uhey9xoN
         qq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zuext2TDf8o/ANwyNV9F8eMg2rqfnJhU9KY4jvsszW8=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=QH5FV3igReR47PZa79VDO7Zd8Pq5iNlbyqGurTEIO+/4RLIufk2Wuz0GPVghHuEDAZ
         lUszTjaWvHnXXat72xeut60rX2uAR1wfPAlRwfSsvNBKWtmDS+j4dgosKtOoT1FFmY+k
         +9kmhUNcJAehIArpBmA51D4oUM1KNgaiUZuFnEOQLVwprNfl5gLP3ZHpNWwsRoDsX3ur
         PNbGN9kn7CTPlkaMz0lT/12Kg63LVXxPY/7IGOP294EpR985oFwXt3uhZDmu2AV+1Uc1
         /np9T/gXiLE12TIv5rw12ac9Kg6VS0NvQZY6Fpu5zX6KbwZIyR8PLzfRYzQbq9VyzI+7
         i9ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695499; x=1791300299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zuext2TDf8o/ANwyNV9F8eMg2rqfnJhU9KY4jvsszW8=;
        b=c55pGMXemKEGiGUV549KiGAdwsbnC7FM3IpD9IX6yea1iRy6MuEIGKWT+zw3lOL3tf
         G9XIULMU0wGDjj5eDFcZRiBJ3+i9S2qQ1Z1rUILcyqOfaRGpw2rCg3LylhCYKzrIhz6e
         xVmk7dY5J3F89+Me8t3kpPe+TPO2rMTGzkrqTjhBOId7U2rWyq/POIlfeU/zdfvGClpz
         Z2cTagTrUPqDalrKlIy/orr+Y0MR2eNIhhhxd6V6stffyBzni6zdBZiS8KkMB3rx/lgU
         1Rsi+g02LOU/SlW0YEZDQivRrpGrS2JTwCwDG3ku9Z/qr36LRWSOX3dkFiLbOOvzv7vU
         fttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695499; x=1791300299;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zuext2TDf8o/ANwyNV9F8eMg2rqfnJhU9KY4jvsszW8=;
        b=MSvMyr11qzGifemSTgRvlbk6EtUo0XJnx1oOjCLyNeEXVNi+/Vjg6REHwbFBR5EHQ5
         1wl2f+GMYSgg8eMeKUrIoB/SPy/xpkt4g0Ka0sFNZBqVpLeVK2uuAqiC8mZONKmAMsyn
         PBTMQgxXr6qx21xuxz1A9YXb0gZe7bQROhIYQV7m8BnIvAWMjOwn3e47Mwc/kwXrtghc
         xLnesyZ2ikNqESLWKEg8QJyGJjtwHaooBqh2OVXHlsaRGGbSVJJhQ3+WtN9VukaSq7vy
         L/+2OlSpo7ToK37x3pF77UP4N9+cb0xT/6zf9/f4aiya34KuYNitKGomI+2uA4QG1JwV
         q+zQ==
X-Gm-Message-State: AFq9FYK5Yr7yNvD26PjYbHtOAg5uYn9oB8oLTB6YjbZq5rR4CSvzG6JW
	BropObMizjzDpN+auP3oFpBladIztNsFaNNCg3pYwNC/yHDVnXEp9zc0djYJGjNUbJo3TfIz+Td
	3ExslP3HBhZHpfXPR4Q2IO4yNZrxqlWo=
X-Gm-Gg: AYBFou3J77E1ok094jTlAN2+JcyMqBYHYxpv2ugOpE2X1TE+gKoz7OaaHNwDITQ6tg7
	xmHfhkWbVBkIxJOqbghtJkaaVQB5IbKzSf28Nhl/qheK0N6CXqUSvYHu6SiTqPUmREVJYjZj2AE
	S5m04LkCUgTeBPu7LPDvX+Zcd6ZaQVvsbCUaQOWWzT/xbpNqSiuHV9y6DBebNWEmaFt4pM2NqLZ
	SlUdoEazhNuSZv3iUapDxQYfby6N5Ke9DMcT64btRebNc0BmJdkKL5peAnK+Sozj7j9iEsJvo9s
	wp5/RuhIWyDImlf2eZ4e5rePanw4zIjmlcY5/Ys4vekMTyOVLM9wUEY=
X-Received: by 2002:a05:690c:698b:b0:8ab:336e:5a41 with SMTP id
 00721157ae682-8ab336e605bmr19344107b3.79.1790695499655; Tue, 29 Sep 2026
 08:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:24:48 -0400
X-Gm-Features: AclHuK80CyG659hm2SIK5LwUhCYO9Q9a--CcdwlJL7sAz6-vh3zxo_RGErGlozo
Message-ID: <CAEjxPJ6JzDsN2AN3Ri6-YLWkOsMZ96i9HuJ25CkQfdiXtWw1-g@mail.gmail.com>
Subject: Re: [RFC PATCH 02/32] selinux: drop event filtering from AVC callbacks
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> All AVC callbacks are registered for AVC_CALLBACK_RESET only, and it is
> the only event ever dispatched.  Drop the events mask, the event
> argument and the redundant event checks in the callbacks.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
