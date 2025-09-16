Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D515D2D7391
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022155; cv=none; b=K2BsFhMdt69Al/pdbGgr1mRRRoszv24ZeDbqrjI/5oz7wEQdygLCJ6aPuW2aOJClgu5etbIrccijh1lGoAMvM65MK3+isRv2g6TNcfFA7jszbGRdAHUAd682KN0PBA8UPum6vfu6gYUoFjJ9G9GqsXl62ExwsfAoK4L4qErv4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022155; c=relaxed/simple;
	bh=CD8tyGv6KSIJKGex3Wezi1kN7d3g2iCsTY1KMHe7TeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSJoUBC6oQbAsU8dvlE+FABwJSJqmC88yDrdFGpdSMJNp32fScL8JeJxHBuTJUjUvqS3bQdxnoOi6hxyj+cVGsL838U1eCH2z1szY9zkoV6/PL9Z2rkGKrL+kGhxrNmQqIwbA3wyUTi/n05Stvot8MJEX+xDVa6wB6o/9NCl1iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBeZBCH4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBeZBCH4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758022152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CD8tyGv6KSIJKGex3Wezi1kN7d3g2iCsTY1KMHe7TeY=;
	b=PBeZBCH4yMLj3xth7ATvk3znExh6Tf4e6mlC8KfW4b3wWIp1qQ5KQukCCo4O1tSqTic8sY
	dHM+uccEWFT2MZfJwuWckOzYQlrt5MtoTtCQoC3sHweREngg8GfmHWKxDj03RcYfI4u4fy
	GJE6OX7CSCbF6BOmCOJ7IF0AdDfDcsk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-x7p1O6JDPBWdcYkyCE7CZQ-1; Tue, 16 Sep 2025 07:29:11 -0400
X-MC-Unique: x7p1O6JDPBWdcYkyCE7CZQ-1
X-Mimecast-MFC-AGG-ID: x7p1O6JDPBWdcYkyCE7CZQ_1758022150
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ec2211659so157844a91.0
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 04:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758022150; x=1758626950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CD8tyGv6KSIJKGex3Wezi1kN7d3g2iCsTY1KMHe7TeY=;
        b=dxc3EeJxrJNYTD+yJAogPmuy/vY6bZwyI1VAeanzzhynlLJT+vTjhtYeg25a78MjCQ
         6CmmpjamhcaytAKPvLmFfM77gY5Y0JaB1MmdeNgKv3KcUEQ7VvTTB0qwoqoSYBABPD95
         uRxecbb3/75p7XVPjkoZra80W4O7OarBZuBbqlqxRxAgQraJ+xtFXy76EJvwz09eNQ4A
         z2pu5Gqvsn5VuuziPjBKGymKq6XDmPVhjkko45+fi6j8roX6yKQo3FygZzT5cZTVbKRK
         ANoBvvBHZTQ1gL55QZ/FFML6RU/YF0XtrKUhH+1u+2ydmH4EyqdTuaIfpZgGH5LLZ3t1
         rW9Q==
X-Gm-Message-State: AOJu0Yx2zT90y/WM/ins4MUgT4bdugyL+VduMYYiv4LBApcy5gPthkb9
	dudLzqUHXfZbPni9Q6HSQbxXRYXijGznStok6HKoe0zIdi2vFEIvyGY+j+b2mxW4MDAmB3UIcL1
	nTZ/EpZLqGecuCStai2gCMEbisyadTSbCFrgIaz5D2s//cM71SVz9TU1/PaOXLOpM3jCY8fTQoe
	5krmfBery4UnWghpdVk8Zu7qGIxILuezi0ig==
X-Gm-Gg: ASbGncudJfLENaSjVD40LzTyyF0Q5CEUO9gEraHsL+ujhP80226X+1jFDriTb4iPO8E
	YeXt1cVvTufQ3H4Ho9j//wWN96oVKG+y97WMzVHuioDJ9IDdFJq/bqeYu//i1LDbR7Zz3w3HEr1
	P8JArL+asNVKuKgR/y1GU=
X-Received: by 2002:a17:90a:da88:b0:32b:9d3c:13b3 with SMTP id 98e67ed59e1d1-32de4f87cd3mr17007765a91.18.1758022150350;
        Tue, 16 Sep 2025 04:29:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0jKXnNwF5avLPxDTUSYpDFP2iUJAWLnyxqzHaZZXWOEZHqeVIQkYtpN6VWWByvqdZIW3n+Hr9VRM38m60Mqs=
X-Received: by 2002:a17:90a:da88:b0:32b:9d3c:13b3 with SMTP id
 98e67ed59e1d1-32de4f87cd3mr17007750a91.18.1758022149943; Tue, 16 Sep 2025
 04:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ6D-3kVh1sZgHGVxS7jRbKxn29Qmf55AF0co302jWZLyA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6D-3kVh1sZgHGVxS7jRbKxn29Qmf55AF0co302jWZLyA@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 16 Sep 2025 13:28:58 +0200
X-Gm-Features: AS18NWBNgpgOjIaPxzWIF2HPu-4SxvLmCO3QS1zG_mxDoutJT86f5S-KaKTVw-U
Message-ID: <CAFqZXNt+sFKYsM4ds2dA9JROU7+ZmUqqLwKMWSw6q0tX2bdXjw@mail.gmail.com>
Subject: Re: selinux-testsuite patches not always going via list?
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 9:41=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Noticed some tmt patches being merged without being posted to the list
> (or at least I didn't see them). Working as intended or bug?
>

It was intentional - I sometimes apply simple CI-only patches (usually
whatever tweak is needed to make the CI pass again after some external
changes) directly, since those don't affect the testsuite functionally
and I tend to be the only one who could really review them (though
admittedly this wasn't really the case as the modifications were
basically only in a shell script).

I could revert to sending all patches to the list if you prefer.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

