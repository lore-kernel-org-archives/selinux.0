Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7A1C28E
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134697; cv=pass; b=cYsSYBsMCD2gdFJxR9t4b8mLsJ6A+XL/96kXREB52iZQmb44MXj32nNOBXpZudZ8pHxiAdlsjaJsoaAJjOaPYB9pQNnG73TMfbDckZeFSGVKUWa++rjfXZGq8w7b60rsslJO327YSbsPFdCVcyKCc7pfAhMWC75IOZAJdCU5I1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134697; c=relaxed/simple;
	bh=/4ojZ6cR6nSdGL820emfDyeNJFhV0DV2LQG4wGJJxzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdEEF8UPK95JE2ZAqfcCcYFchaWtAdkNI2c8EiGINobZaFE02sJW9aUDBZzBmwaCS01txDbNrqNmLteGLz6/mJwrFQUh/dH1OwADJu3Roo15f4gRrOAdffQGHJGpD1PqAyiVDx9CVb/NBA7jM5/sNMKm/MMzco958s6ghaYlIbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtYNsyNi; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtYNsyNi"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bd2051167eso11472955ad.1
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 13:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779134695; cv=none;
        d=google.com; s=arc-20240605;
        b=DgjqotqiWVo4bEBPAL9Nk5f+8VvBbnF79IFGaHIyJ4zdkJGpR29Zh93qlXvAzW/pqI
         lzxV8/YgQne+Ipswqk7Rx1s5dN/1i6drlY5tYicl1vHv2i0mS3fwcSKOUNPiig8MqNxJ
         f7jdmL0p7gr8TqIKUgZbXztdvYSWDVsTVfMkd6m5RA7alNZBWzLeUMD0+43Ju/8NeOCu
         ZukIxthS6DnIlSEoVJ5sSerd9GwOWgF1Xv9TNjySkvT5OTEiWLYWxf1ENHi7rukYq75/
         KzVbONNFtjRMJGCGr5TE3MfTFEZfVuwHN4n7aUAXyjcOTuJndslTclmvqCSut5maMahh
         5Q3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VTFUMyX8BrtdT22ElFkPzfNIpVagW83ThiWTZLqQcNU=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=dzU+pB4pV6H8pEEfBK6HiBM6Z+87bdU1dqARJRbCiOjDNjGSgFw6ZKg1ZYBcfs6k1Z
         cV7MADgfvYHGSojF5WypU2fMVxOcwe2mxgjvuSxxjtWbBSz06fu7kQpsYTdV//2/ZV8J
         mLEV3ykLWfrCyOJYIqcTCHjvkiNlkWD1K4z30uRlg5nRrgxhPjYH80R4MreLXtoK5MLl
         qPw4MZpW6qNko1ZdInhuZdnd7FVJ1kgga8PXp6SSPMhGAIrA9wDNaFIGpAzarK0/tkJg
         ZCkovC0vSs5zbTbmkVfa9aJEB/T3/d8PSModznhc3y9frmqTlj+8XYE/jGD4cMWYXs85
         xlYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779134695; x=1779739495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTFUMyX8BrtdT22ElFkPzfNIpVagW83ThiWTZLqQcNU=;
        b=QtYNsyNi1UK/6ZrEmpM/CGmIWyUrx8LXlfX5H7f+BKOgN9eiOaAX0EA2qfKaioAPfV
         EJu8Umi1bOegd9u/lAcEHjBRvPfycuHOT2k+wwD74AoRssHFz0bgcwfJQagFXB8rI96X
         J+ExzjNCYHmI5Qzjs5nfTDNui4caY5wAaj+0O6A7nUsGJHktYls2fUHR+wCtis5Gkb3H
         z2Tl0BylyHe4Z/YadX7SUXyZXzZ6Cs0NW6Xu8T0b+4JJjZlFVkyaxfm5oz/MbrnSi0w/
         ONBRy+mmPXezobcSSoQXgDfeIp6txC+OiCxIqJjxl5uIJMKphOoLN4qCE9xOtItDz+pL
         3fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134695; x=1779739495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VTFUMyX8BrtdT22ElFkPzfNIpVagW83ThiWTZLqQcNU=;
        b=H6LUTw9MgSqqN6d4nM2Ug03UXc8dSL2FQsbflDhP0bGAo36J239g3HaCKbo0QX50og
         cHzxu76m4BDTssv14NmsnNhtZb7cbmElWMFYHY1QanA8Cf29glYpWBhDzrEo2v5Hjjbv
         +RtWdsk9QPUCJNGXq28I1UtDRCkiIXDYTgMJUs0zCTfYHwRt04RDgKIPWxjf/FdVws6o
         R1/N/hVi0PVGNXhLIU056Knpz8k/OWdv+/XTFRp+aIekBfDzhlXOm8BwvO5cnxhsJhAV
         4rYt9KO5UA7M8SAlW2Zk8YJ5eoKnWg3Q75fXcwf1ZuOheInR5hBZJaqdJcFnqLFlA14y
         ZQJg==
X-Gm-Message-State: AOJu0YwFa8Yiq4nMK9b+Qrh1cNT34CtkkiGawQpdVszDJgQ+HM5etMWM
	JS6BTzIRd+RKbbr2d051aBzEfsB6U7P4VGWDHy5uYB/AkDArqvnHNiFtL9y3jBG95i3JIWyrm4u
	OSKIB+GyUUYUHYySCtR0YDqwn2B5lIq0TVg==
X-Gm-Gg: Acq92OE1JIjePyBXvPBra5MQZ4n+8vLVtv+/5bjNN5yIXSnsFtAsZpelh7noifG78Ew
	DZOrRb/hlDy/nNP6VOhvJac0R1gGl7rwV+eTaYy9eP/ffOQ9cS+iY+3x7ZtdLxpwzrN2z3PQBMc
	AvnER/APnvL2U06eqV3sf/7bKuClMZyGva4tme9o006JZJVbDkJ3SKJejMw5rxlmKfmqFFMBdTH
	HmtJqRefwvjlZNNwZYCt8vgS28dpK1cl3IJeY5u0BFZA6ZmNo3saavFqTgh8vSd2zZ2UdUX1tzx
	0IPU9K9peqPg9ZfASg==
X-Received: by 2002:a17:903:388d:b0:2ba:3e50:e3f5 with SMTP id
 d9443c01a7336-2bd7e9769e2mr169101165ad.30.1779134695526; Mon, 18 May 2026
 13:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514150542.55256-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260514150542.55256-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 May 2026 16:04:43 -0400
X-Gm-Features: AVHnY4KXSt-RIIzlEkqdAl9J8lEodQ7vhFWF2i3DW9zu2Egi3a029Mv6g5kwlNQ
Message-ID: <CAEjxPJ4NiLqwvXOvGL5MZQthGj3D8eHtmpyA4d5ubhT1eqCyUw@mail.gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: fully check setfsuid() calls
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 11:05=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> setfsuid() returns the old fsuid value and doesn't always
> set errno. The existing code was checking that it did
> successfully return the old fsuid value but not explicitly
> checking that the new one was set, which can be done by
> a second call to setfsuid() with -1 and checking its
> return value. Add a wrapper for setfsuid() and use it
> throughout to ensure complete checking.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  sandbox/seunshare.c | 60 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 48 insertions(+), 12 deletions(-)

Merged.
