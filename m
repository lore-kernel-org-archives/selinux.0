Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0861E376C
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134230; cv=pass; b=iyeIGrhivZ35cWWPOumr+MH/+BGUTrthtytWWRLXOS+9GbCY4v5a6UtXxHYBaNvWGgk12Y0PemkKFW86oWBnD7N6BYuxmWnWI2oFHvosJrgMx28WlhWJ8dwVeXYgWj3eAHMBGUIhUe3D9xhPO/H4JZSgmJXXdsXlcNqVPJqOBXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134230; c=relaxed/simple;
	bh=PPNle68nXec+MIL+0OukmSGJCsqpS1s/eRfLWrhXELk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hau8pcIUBUeuiM0Oa4o87LV26j7WtAERInqt5Q/KRUPC65SnLkeS8Bw0jM1GHJHQEdz2Az34YUNwtZTqNho4MFlzKEAwP2Qrudi03lGAG03MK6hPf9WRhD2KYQZTPWjOnKCyYAsccGxw88lpemtjm1R5QBkc2WnlQSWxmifZZEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CphToU+N; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CphToU+N"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b458ca2296so19562285ad.0
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 12:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779134229; cv=none;
        d=google.com; s=arc-20240605;
        b=STP/tKFoVQ9Ou5RXodXNjZqS2LB+K205j6peojqmwv3GuoVXLupL21HG0ld0WKMO/H
         jF4SjkI1L9ORc/UZkHh86OJXMsgIqDszZRbAGW3SjxPm/l6dz1CZP3jzJiB4wB33fq2G
         T6v3IIN47nsKiRShzpZOATFpWmnP9/aHAdWNcRKAb93PFIcYTPYvpQ3h6sfJJqpi+R01
         P6s2/xBul/Op9pvZqh35jSKKFg6QYOrc+E+Yv2OkqZbsnUmzzbCJ+KO6YhOakJXLQi3P
         7dubvW09BqRNUU9S1mTXY/P7zDGeenxpxRPLnTB0vh8GgpM+yN9w526Dx6X08apT9ASN
         bs3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y3aHJS3fI7Gnlbp2BJpIQ/rSzQFoFGCnX0Rbo3qeJR4=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=W4HqG0d3JRYt5BaB76CIKkp26/psyo1ar8IMJAzvdv8HZ2EiDuqm7Ju+ax/rpToG21
         cSpIdo8zSp9prKFV44ZHTLCE7Zu7CgVJb9ZbOlwAyxchAkCvET6juIgXzcc3xW54UTY8
         B/7Sj/5E3BTzbNK9zdy+0t+NR+gN8JNFBB2+KMYpuWXw4Z3bvclVAJnw1bijhTnVu1ZB
         0BHAelFuyb1ykFJzfjdAjewD46ZA2ofn4vx+vzLQs+wmtLS6TH1uTgbG9lT8+OhEnozY
         QVLj9qF2ea7m04hhbLAD4HbCjFu8FlAylmSLRYlJ6Nz1570tG48ZxZYYMQb0K8rgcb5t
         Rhmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779134229; x=1779739029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3aHJS3fI7Gnlbp2BJpIQ/rSzQFoFGCnX0Rbo3qeJR4=;
        b=CphToU+Ne2oNdYXdJ1pwtWRhF1wvf1FSUrTFKQvBg8jnnAeQPOJX7pufKyD6p1rMZD
         C7PrAbHDTUN64TiYfNDlQE6da3/QitjRIZZkgyKoBZkuGy96g75tt/cIsLTcNW3N7lgb
         ksIH8K3wjEbpJPKS6GbBallMgmGJSWI/i/iak/rKkvieJ8oHqZ/phP+dL+FaH6C031iz
         GI0SGNQtE8+Zu7CKhBO4V1LQ6iZiMsD/R9R1eMa2EG/7XEl+ngHkh80toxgNBeKUoGYr
         yOkrGvZB379NkkVM7Zsb/cxH4D6gO8B4qLbgNo4b6LzRvL77fDgrvUki2KmtCuV6FIWC
         X1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134229; x=1779739029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y3aHJS3fI7Gnlbp2BJpIQ/rSzQFoFGCnX0Rbo3qeJR4=;
        b=nQ9HdbhS9/uzTAq8GeVNqsLnskOcRgWjwATjWaTIceQQuHOgX7XR561pUF6SdjyTeF
         I+Cb86ut3Jpd/IBVHd2FFWfmlQbeDfxgRL8vNbkuuJGMWUEmrXSd5cW3JfR3sFXsATNU
         8ZSVUEEubOfT29Qz2JA2Fu+xbKUr5S12XMWChX7PJD+wrJlsJwcDgd9T9lE+oNuC+dZj
         qzJsJZy6fcGGM3s4wm4w4Zk5JRKJlNvIfPQvYN4dEBN1ZaKZZEpHGjDXHAdMrV8xv5xL
         YAxy6LE4vjulQFIeMRF/c7jetI1+hEq09EGiPiAFO1yCOnrJf8eGjXJ9Slnq31cKSWg4
         SkCQ==
X-Gm-Message-State: AOJu0Yz1PQhRufON1P65BUZbF7COlCp7HxNuCcP8Y/dlzYwYhi+uejCr
	ElQScuPfCiPwWqABrDzIomlSU5ePs/et2bRzjQ5mCeL+a4g1aruZtjmUG/x0QcBnl6OvrTGM+du
	xWZ4FhLXsnTY1Klnbv0aiQvTRAFHWBoaWZw==
X-Gm-Gg: Acq92OGI/yHr/3GXCqrPQjeNbaQR2GUoOFjUxl18ML6DEnbxpc0WzuXfWs0MdP0wWOb
	G+/oYoKzeLYvmJJ7/p1HHCSgXl+CXkk2DTw6qlo1BS672eforza1y+h8gdNwzDuZwTujEUYRmhs
	BLGuMyxjeo/s13khKGQkvD4DbTKPgQlMY/7GkUJ29CZLcYAdOFUenmchbTTXWc47cpiWg3mhWkh
	8dYZdqHqQkRC3OuJi/f+oO7UTGcXZ6vn6z5Oqw30cdajchwCJHJ8s3Mgf6SNa3RQW6p5q1lqvEp
	/cFNlw0=
X-Received: by 2002:a17:903:b4b:b0:2ba:25ca:b49f with SMTP id
 d9443c01a7336-2bd7e856af1mr172495205ad.17.1779134228670; Mon, 18 May 2026
 12:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512161337.733958-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260512161337.733958-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 May 2026 15:56:57 -0400
X-Gm-Features: AVHnY4K4RBZLSdgGa8TSJ1Ow8LgPU7aIqA1Tmi2eaq4Ow7-5fgBCL69Xf0KbcAg
Message-ID: <CAEjxPJ5PWyG=E8mOaK9eR-nRfVqyv3jr-F3YypkWBtwjwET0dg@mail.gmail.com>
Subject: Re: [PATCH] restorecond: NUL-terminate ut_user before use
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 12:13=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> utmp.ut_user is not guaranteed to be NUL-terminated, so
> copy it to a NUL-terminated buffer before using it.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  restorecond/utmpwatcher.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Merged.
