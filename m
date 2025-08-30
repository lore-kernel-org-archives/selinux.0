Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4616274B57
	for <selinux@vger.kernel.org>; Sat, 30 Aug 2025 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756554512; cv=none; b=oFy2uLvfL7t5UVO8dRRZEXIxarwapBbNdOlMNqX/rBX9A0Oq52kEX/bSXvfGNFZu745BaQs+5/yqSX8cHWXHTUtiy8uTtmfcyNvIvqEDvpuzzMWveDwSLhWGMjHc3g2POAbeEuPBM7mqhl2D2OAFwjZnHHKWvEAkdz+VTwsAUDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756554512; c=relaxed/simple;
	bh=zaeQ9+KQzLSByS2I5JXk0VDH5I1R+0tcwVDmQJqKIVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfSjG1S/nvhIOwLZeaklO8oVhn+gTQN4QL/XZSGo7qjjPWVshilipp8pHhdiDVMbl+ODNhcH99sXwyJj0uGhz5EYIYg/PMT5SJXBtkqzziRuYolyhJGlM5jHIXmr61hO9Llkw2sWTOQHsZujmN6Qb0UZgp/YYb7Itosl2RC0amc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dv4L/+Q2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dv4L/+Q2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756554509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KaKjGFLwy+V7ecd9sJXmkoNWgd3Dh2vSUHl3RDc679g=;
	b=dv4L/+Q2Hl//duaCXOolyMoLMsCc3kbQZWSTmlGmgrf/PMIw5tMdZ9OUqHeiqtohdmKFvI
	W5WS3qpoB2OmEgI0MlIi+MHX4JB48cYxOf9Y0R+YJnYN0iS+tkT0flhQb0ArdxOz5Rtczr
	bQTvxT/JahnNCxDbfyzANYlH0aOHSn4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-KrR4lZkRNzKhm_tmzTExdA-1; Sat, 30 Aug 2025 07:48:25 -0400
X-MC-Unique: KrR4lZkRNzKhm_tmzTExdA-1
X-Mimecast-MFC-AGG-ID: KrR4lZkRNzKhm_tmzTExdA_1756554504
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b467f5173so23815305e9.3
        for <selinux@vger.kernel.org>; Sat, 30 Aug 2025 04:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756554504; x=1757159304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaKjGFLwy+V7ecd9sJXmkoNWgd3Dh2vSUHl3RDc679g=;
        b=bczr5Xs+uDPkGlohaJlC7AhmhklFXzQXLVg3Y7x+nJKrLEkCA77cgSLDAj2n7Di+Om
         PKLNx+e0e6N1eC4Iq2leQv+MGYiUYm1f+Ck8zfzNO95nkkX4ocsPOqkXtMhNEUNTyXvq
         onWuWU7zTS4eDi8VQtA78WkSUfes4nlVEMTlGxRZL5KxOHi29HmhHX49yslknCCfImX4
         ekc5kFOjGD9jx9GIWYkJ5SNbqSlmM0cueuFh04zRBT05/EVH7ulpwF79uDgQEJl4BB00
         XMVen0KZ93hvqfnOdfJGo+9JeUmP2I6CNzt+EuPfEQ4+OPgWuhHDVhiSXVBYUvxc1QZ9
         E/uw==
X-Forwarded-Encrypted: i=1; AJvYcCUvAPuenC0SviTTlYD8hTJMTe9QkhKd5GDN3ngQzjTdPb4lLU0xABgUj+YG3LaK88Bijdfnqznw@vger.kernel.org
X-Gm-Message-State: AOJu0YxLV/YT9HKJ2ows6qOTGAF+A0LVRK+l9hjDs4XpK+vpjorbQjaL
	N1Y7EXXvedHfSiE0oG4bRrDw/LsVV8q6rQ4dit/VNKmccqJ/mTgo4BTumbJ3e+kflFRey4grI7Q
	p+VW07h2HHWJ/nqz6nUHssqhCixcuFq1RxutfjIVFBNZnjhlqROXZloI50Lk=
X-Gm-Gg: ASbGncsESXnAQV+JAud5MZRSxptChi58trX/zgtb1Cm5NHm4uCCAHft2wJJo7CP3sFJ
	goOOJK+m9gSddTONLrF8RGqvhrPeCbEu38WsswQrUpAZ7OuXMp78DU232pBMx/sRMkkc53N3HiN
	kD/3bOViTUpi6EIpb+2prjhIxV79EwlQFuDL0Rf4r8Mf80UA3qzUGARaR7mRRfej8aYQPwRypxT
	4cvTIAC8xlRvQtlyGcakg2ElGXn/eBVCDT6RoxTS7r1KptXabgoApW5xB/X6utdStor8czZLd0o
	4esUYgFu9BuSirxsjPWR75tUYV8KnhkRk4w=
X-Received: by 2002:a05:600c:1c98:b0:459:dd16:ddde with SMTP id 5b1f17b1804b1-45b8559b660mr12175365e9.23.1756554504262;
        Sat, 30 Aug 2025 04:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6Nv86gUIdggy1hEBUnLjrjO0ADmTfym8Sdz/L9HHFlU6ED/awS0qFW6I6CEH8xnA1upuKWw==
X-Received: by 2002:a05:600c:1c98:b0:459:dd16:ddde with SMTP id 5b1f17b1804b1-45b8559b660mr12175215e9.23.1756554503856;
        Sat, 30 Aug 2025 04:48:23 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fc496sm7074059f8f.1.2025.08.30.04.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:48:23 -0700 (PDT)
Date: Sat, 30 Aug 2025 07:48:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH v2 7/7] virtio_balloon: Stop calling page_address() in
 free_pages()
Message-ID: <20250830074747-mutt-send-email-mst@kernel.org>
References: <20250826205617.1032945-1-vishal.moola@gmail.com>
 <20250826205617.1032945-8-vishal.moola@gmail.com>
 <5ee2b684-94d9-40be-b01c-b0538ced33bc@redhat.com>
 <aK9Ogjn71JoOM3w3@fedora>
 <aLBthEcK1rDPQLrE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLBthEcK1rDPQLrE@casper.infradead.org>

On Thu, Aug 28, 2025 at 03:53:56PM +0100, Matthew Wilcox wrote:
> On Wed, Aug 27, 2025 at 11:29:22AM -0700, Vishal Moola (Oracle) wrote:
> > I imagine theres more of these lingering in the kernel, but theres so
> > many callers and I only looked for the ones that were calling
> > page_address() inline :(.
> 
> There's only 841 callers of free_page() and free_pages()!
> 
> It's a bit of a disease we have, to be honest,  Almost all of
> them should be using kmalloc() instead.  To pick on one at random,
> sel_read_bool() in security/selinux/selinuxfs.c is the implementation
> of read() for some file in selinux.  All it's trying to do is output two
> numbers, so it allocates an entire page of memory, prints two numbers
> to it (while being VERY CAREFUL not to overflow the buffer!) and copies
> the buffer to userspace.
> 
> It should just use kmalloc.

Why even kmalloc? Why not have a small array on stack?

>  Oh, and it should avoid leaking the buffer
> if security_get_bool_value() returns an error.

