Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF016EBF6
	for <selinux@vger.kernel.org>; Tue,  6 Aug 2024 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981366; cv=none; b=BB71fj+iJaVBLadSvIHLOqYxucOXp7Shkng2nXBlw7IX+tXMMgeYlb3BMd0ejBCpPY/4bXrXJ1xxhiFZG36rYvCrAWIBWAon/eiJqt++KpFVngSR517KaWaUMa/RwmIRMd8s/mbBaCIlOzXciWGgxg6/zwBs5GA9cSrH6UFwhFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981366; c=relaxed/simple;
	bh=Jvd6d/g8j8GNeIP/2vY+rysLx4jcS6wFfVxuDrV0hx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7qC/P+jGqPLVQtb89mqoVND6a2CcFKN2A9n9OjgLlDIIKo0BP4/3gf/v+mfLsjADuFss6ccEmNOaKmcQLo/zMJ/QUACaNwihgxGmPX662jomdipgfg0N8Y4TgIcRL2oE4z32vhUd9gOBEJcA1ZT+uUk8H2+xQXrfpklze9gVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OFKm6ezG; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OFKm6ezG"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e03caab48a2so278722276.1
        for <selinux@vger.kernel.org>; Tue, 06 Aug 2024 14:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722981363; x=1723586163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDAjrM4/RIRi3K/tRUnjq4ndMEWl1uNkteCqHbi87aU=;
        b=OFKm6ezGMCrq2e2n98ivl3PGtPJTt5SvKEFdxjf/Ti7ExV4gBvYc8fdu7bHO4S/09W
         j8XqNmghcx3dQ2IEYPxboyU7l8u2XhHeQw44dX6rOKPT89Hkm2fheeSL/Za6h/HF568j
         fwbgpP6AuRLVaN0WaiCHuw0qBr4BA7oDgaL3/uLed8aKE6wBafj0vbHj8danIV59rWck
         IZDD5jQP2dTfdxOp0/zYee6qq6tki0dfNKZtDA20BAnzDN2++6fgfuRs1iBnPiNoK4JM
         GGgpWwiKai/5/J1gZGMYi+iUEOi7MokMPcgtbBKB1Lr1vDjGokESAEKIrwx/J93m+8fo
         wUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722981363; x=1723586163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDAjrM4/RIRi3K/tRUnjq4ndMEWl1uNkteCqHbi87aU=;
        b=SQ4jsLj0BXkdnudeO9xMIVl19rq9LmZf89Kl+IhNJFwlhXnCXhHzKi2W/uzySPUzUM
         SzVpi61/dIhzqoFbUXg6EkcfS7/yFgpnw4a42tIkyK3F71yuswZA3Nl41ZwcIuHRQWpU
         fISDAkBBoGIoF5QxFi9rWbyUkAdyJ1hIBdfRSAyNyHM2NDbLE1m3rjmxBJq7RwByXIJZ
         1RUXCCRJskIqmK6lugL6lIq4o2DSZCt5abbVqY/UoWXcQZUXmVbJHjXErx4FRnN7FkCR
         +tbQv2wDdJfTb50TqcjkGFzD3P24w6qf/i4C1hCKENGNmVfdT/cUCSUra6Q7k9mCO33Q
         UR8g==
X-Forwarded-Encrypted: i=1; AJvYcCWjSA4z9f+ySWuMiZZXUU84x4pXJTW1w0VIFSxy+k9LOHu9YydyldmCPjTfg8LJ+cJJfi1/BD5hyAS5hLLunOMlNEvrBxzH0g==
X-Gm-Message-State: AOJu0YwhYZGKydGx02UwRPhIQZN5odfHLJVIWK9ah1aomXrZX+WaxAEu
	M3k1d3Q9YsmvENEOKg8OuSyjNiWv9apBQtSpJluETJymGbvGOtJq2q2cIF4/inSYWpzHMWd0kqA
	GKiky0xl0I7MifZUcypQHMUknT6Nw3GFlZLQm
X-Google-Smtp-Source: AGHT+IH3dkrRfOJW0prmnIwdEA2mFjIA4RWSsRtLuzMPO64WTfKIRWGNz9sO84SFriTXfQ/Css9cuJZbEfdI7+2HQNI=
X-Received: by 2002:a05:6902:2782:b0:e08:6373:dfc8 with SMTP id
 3f1490d57ef6-e0e877f5902mr158689276.23.1722981363600; Tue, 06 Aug 2024
 14:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806065113.1317-1-thunder.leizhen@huaweicloud.com> <CAEjxPJ59=rHFovk3scmkhLuiAdu2uinGiua60y0naJ0e95GLmg@mail.gmail.com>
In-Reply-To: <CAEjxPJ59=rHFovk3scmkhLuiAdu2uinGiua60y0naJ0e95GLmg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Aug 2024 17:55:52 -0400
Message-ID: <CAHC9VhTWye8Pm3EUr-Fy-mxq+6H1ThtAekqZd0nXX70f8xP5rw@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux: Fix potential counting error in avc_add_xperms_decision()
To: Zhen Lei <thunder.leizhen@huawei.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: thunder.leizhen@huaweicloud.com, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nick Kralevich <nnk@google.com>, Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 9:26=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Aug 6, 2024 at 2:51=E2=80=AFAM <thunder.leizhen@huaweicloud.com> =
wrote:
> > From: Zhen Lei <thunder.leizhen@huawei.com>
> >
> > The count increases only when a node is successfully added to
> > the linked list.
> >
> > Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>
> This looks correct to me ...

It looks good to me too, unless I hear any objections I'm going to
merge this into selinux/stable-6.11 and send it up to Linux during the
v6.11-rcX cycle.

> ... but I also notice that the caller is not
> checking or handling the return code for the -ENOMEM situation.

Good catch.  We should also fix this, ideally in the same PR where we
send the count/len fix.

Zhen Lei, would you mind working on a separate fix for checking the
error code in the caller?

--=20
paul-moore.com
