Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685B1DE892
	for <selinux@vger.kernel.org>; Fri, 25 Jul 2025 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753480997; cv=none; b=rro5drCflmKfGbdocWVWdjYWe9Qj381WU8l4oCaCK4H59k/hzuR+qwez7K6oEVNKqKxPCH1fbefgmHzmRAoJ5BVVkfew1JrOf6iyA2DIotciYyIDHlVLYwLoPxZeDUnTwV6skTGRAaUYIUKbzbDKumidX1iZkTHsTalYwgV4Sfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753480997; c=relaxed/simple;
	bh=DJeChMIO6t8OzNGtb0172ttFuHILsugB4HzIz/Wa8B4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 In-Reply-To; b=XvufnTwUJ5lFj9WOOeS/e1q5P605Bz0EXIuxuTCp410/0glwGPAtlPGFZqBC7u4vGRmRjhVqy0nptLQabrjcyD9sakEVPnGbdC6SQtR3dghqnuJ3rBgTqt+4OikTpzddrMHJI58tQWG52mxMMbTxZ23jUAnyJxu2Ald3iAoWwko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrBBunwp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrBBunwp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45617887276so17450145e9.2
        for <selinux@vger.kernel.org>; Fri, 25 Jul 2025 15:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753480993; x=1754085793; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJeChMIO6t8OzNGtb0172ttFuHILsugB4HzIz/Wa8B4=;
        b=SrBBunwp7E8Q+4hJPFHRx+SzR2YQZev/FVUl/kCXLGRPxfVOIh2rtboq6/W0EvBoCU
         TNzVgxoFRI9nU4yKkx7vHiY+zGSHWy4x1ypGP/ZBb+dy3+Imla9tSmM6CYG0blFECnDy
         9uuBZR3uglvslQl9Fel0/20CMpptTPwJZtwlFCsWX3a6ZG/HYM9of2tfsCq32PLYkV1I
         nSyQElQApzC6NOBUggjXZLRgIMvsp0HIDDDWm8VGZR33v1Coc/kXabKhXRWY5RHvUyBx
         Myt+Y+bmMO6V8vZWzQ+uDXrkqD9yHRSpu2Y/blNALsh+14VnKqQI3bVCOVYIpNgsQDzq
         YE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753480993; x=1754085793;
        h=in-reply-to:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DJeChMIO6t8OzNGtb0172ttFuHILsugB4HzIz/Wa8B4=;
        b=gJdekMzCzt18zDu+h8TrpFZgbmIk7mWYg0TPX08jZwf4h2WC/3XYc4QGkcmDP6rJ3j
         xi58TtwUyILbM/5NU0I/mWWSLjmFnFy5bYhXBlY+RqMCu8iLi8Z0lR96FgvpbVL4xSVR
         lzwVvQSECyHG+dJghFrn0keDbTPZZCjitRBN6rTuQ+zWE6lYAJO29oGbPO1N6kAcMxXA
         /2GT1SCJu1uB7YNrPjN3vCq+AumhRIHi2dtsumX+PeBieqlHQrW410oDQanYJ66K7pl6
         vvixNs+SObGg/YbUcPijbT5lwXYsBjAvXGPXzOe2IgtzQqIw87aE4pZDMLAH6PvjjA6H
         Qr8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW89Rgpdn4wh/eePfe57KpPtrk1SBNvBoJNyphrt6GFEsJQBHYQOTf9CKbpgd9Ezs3jFpWr0Ax8@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf7PRiOsAZRMquv1hD/1dv/E8dlvl+k+uGfu442rPXe/JgK7nX
	8SYi3oBvzIjcwN+VYxUBauUYHvGAYSANpGeMVX/EGHWtmbb/0VSRKqCM
X-Gm-Gg: ASbGncsRNBSOTEWWxXt4iVPcJMl1TFWLEIi1ui8R4tpV9xQZ2FZFq0+jZDkHcuWWNsE
	lJdLZJR98TzSQ10VgOsU1a8RbSG5fbYO+smWpK9I8Bb+oVZwfhb1CyakySVzVO/YQlV//NsLl8D
	IBw7Wv2/Jm9a7bOyvi03Dee7GXZaW7yJI/3mhEErfTgAUNwQ07xUBrW9/0x3FWSHqD8UXZtAVpX
	fLw5BfZJ+yGOxbRxMJb0E/snUzArYWj4teXMfTJ029kgR5EGegBx3OYuWCnpKefldOEDYzuoj04
	M3vWqYjIDxJ7E1aP+84OSdaM8igau+TTFg9tPZYYXqER517L0Q9gr1MVuMe2G176lAhlTiZAgLq
	ZjE5T6AkYmi/NrdQc
X-Google-Smtp-Source: AGHT+IErAiv+gncFMvFr1TeZ6ERRA17QxBNpp8wMjv9BHcQRa9ItjjsIqCOuoOh2J6xXmwsPrVcByA==
X-Received: by 2002:a05:600c:529a:b0:456:c48:491f with SMTP id 5b1f17b1804b1-458763117f3mr37082235e9.10.1753480993296;
        Fri, 25 Jul 2025 15:03:13 -0700 (PDT)
Received: from localhost ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054ef47sm65803275e9.8.2025.07.25.15.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 15:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Jul 2025 23:03:09 +0100
Message-Id: <DBLH4U3X4LOW.1MQVO4THRG7CS@gmail.com>
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <stephen.smalley.work@gmail.com>
Cc: <jwcart2@gmail.com>, <nvraxn@gmail.com>, <omosnace@redhat.com>,
 <paul@paul-moore.com>, <plautrba@redhat.com>, <selinux@vger.kernel.org>
Subject: Re: [PATCH v4] libselinux: fix parsing of the enforcing kernel
 cmdline parameter
X-Mailer: aerc 0.20.1
In-Reply-To: <CAEjxPJ6nRZ50-L5wDtnppC641OjuEzO8QRUhGjJXcT5iKTNfbQ@mail.gmail.com>

> Apologies for not asking this earlier, but is there a reason you only
> increment tmp by 1 versus by sizeof("enforcing=3D")-1?

No specific reason, I guess that's also more efficient so v5 incoming.
