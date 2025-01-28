Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A119F111
	for <selinux@vger.kernel.org>; Tue, 28 Jan 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738071434; cv=none; b=VpWw5iLJ4J5gC9Y3xxely6bCXpPasMp/esgvVwLsi7O5qHRe3ph6mivN+BtLA+8eGWEkaYwLQJssNbstVeBoc5SbfImTj9rl0yQAZZaIVTcTK//LGAJVG/RfSrxc3DO/GT663suNJdccKUgrELGpzrftqHy2ZTkdxCCv/C6AOTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738071434; c=relaxed/simple;
	bh=za4jWSIXiWnx1/PtIdrlQUWfgRWi88/FEbsBClDq++Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbOl1s3n/i92pAuw1mNcs3q1Kzb2d9khNgR3Wt9SZDySsg8VmeH6GxVTRKfprIRcRPSpviCQRUKgzJat0Ya3lnvrHH141feKbL1ocvibLopGeb71g5zAocHejP1HSzR7MzlZA033eRDGMbUkz11gE462I1fN25gDEzAapx+phAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BM/I/aVo; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BM/I/aVo"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46c8474d8daso44604901cf.3
        for <selinux@vger.kernel.org>; Tue, 28 Jan 2025 05:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1738071432; x=1738676232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cEBqaIaDwYzpAfJb0Xza7F8apQH4HtqaJ+JjUwM8mEQ=;
        b=BM/I/aVopvQmXAAU9Lx1lLYfIsFez4u45iXCOilKTl7APoK/QCR33ZVougxbmZ2gci
         TW171voLB67P7eFXO54deYTFS2jCJ+VRUj7eNV1ZJS2fV++Ldaw73t7+w1eywC/EUeKm
         eH/YKXNOz+nYR/rWsYV+53sm75gtKTIAmL3PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738071432; x=1738676232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEBqaIaDwYzpAfJb0Xza7F8apQH4HtqaJ+JjUwM8mEQ=;
        b=mrs2Hrj04oKjbh2sfQzVMWyEdak2CbI7EUtAhSFW7j8x2r2VOFgH0xyaX24prIFi7V
         DubuN2c58XRMzYA7yYyKFcfJ6jD34IOm7ciR9dZD5aqWl7wEKBCBlMWuRXaXS/ZrahSY
         ouNVgEwXnM9rkp/ldQtNyOxAECuzVbEdMxCzA6aRvipP5qc5cwQ8QiAd0LF8nX97FlA4
         vmnJiz/shRysDfyuu6tYe8LXvR7hI9MrPvRA7VQSAGlArzcBOc/M1kQ6aJgvup0NY8y3
         /qncObbBdTv1GkLDX3jG54eOafi9dF0TL5/SumMVB0hgskmrCqrkeoRp6/s+IKrnTxv3
         C/QA==
X-Forwarded-Encrypted: i=1; AJvYcCVuX0mS70HxAZw2486hgplis8we39gstsxt7KOZtTvsf/xqZ+iIBwfnBpr7V9BbP1bUBw5nZG+u@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1J7hlu0UOso+AmZ9yf1RTZkenhqezxFbMOMUSqp3ISQNXdqpE
	cxWcIOMr/rliZLcujt7siG7qqgWptD5ReObj3YrOlpizotkjDwLLcyj/bfAIeJ0hfCOSPcvUgsu
	L9dsKYeE06IWiOqdlkyup/FgJf+H1dBP+mseaXA==
X-Gm-Gg: ASbGncuMAlX6yaQg3VJcojuXjFoQG59ftXxr+t7S0C3bLvGGYp3XDXzuvyqcifIvNsz
	wM9trNbEEOk5Q+I8evgz9EcL94ybAvR2NRXFC/WjfDDZul4aM5lGiP0ThU6rhBJBhMZYts7c=
X-Google-Smtp-Source: AGHT+IFWTIAnK+5eL7HyrGG7lpTg04Tgrx5YKQ2A5MNEXhLez1EsL/JNf1CxyLCjHr2w2Q9lyVqeWMCdUDReSZN1y/4=
X-Received: by 2002:a05:622a:1311:b0:467:5eb6:5153 with SMTP id
 d75a77b69052e-46e12a3f746mr729277911cf.19.1738071431912; Tue, 28 Jan 2025
 05:37:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123194108.1025273-1-mszeredi@redhat.com> <20250123194108.1025273-3-mszeredi@redhat.com>
 <CAHC9VhRzRqhXxcrv3ROChToFf4xX2Tdo--q-eMAc=KcUb=xb_w@mail.gmail.com>
 <2041942.usQuhbGJ8B@xev> <CAJfpegsKWitBYVRSjWO6O_uO-qmnG88Wko2-O+zogvAjZ9CCxA@mail.gmail.com>
In-Reply-To: <CAJfpegsKWitBYVRSjWO6O_uO-qmnG88Wko2-O+zogvAjZ9CCxA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 Jan 2025 14:37:00 +0100
X-Gm-Features: AWEUYZmizeJU0a7RXrBJlqhjTqK1mNWtSBDQH9Nt1-ZaM-h_jUVyMC5_wxbnhOg
Message-ID: <CAJfpegs7n5eO6yOms+_TqeXGrN=OaJbjRB9qVm4VsW7JpWG5Xg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] fanotify: notify on mount attach and detach
To: russell@coker.com.au
Cc: Miklos Szeredi <mszeredi@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jan 2025 at 13:42, Miklos Szeredi <miklos@szeredi.hu> wrote:

> fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_MOUNT,  FAN_OPEN,
> AT_FDCWD, "/proc/self/ns/mnt");

Sorry, this should have been:

1)
fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_MNTNS, FAN_MNT_ATTACH |
FAN_MNT_DETACH, AT_FDCWD, "/proc/self/ns/mnt");

This notifies on mount and unmount events in the current mount namespace.
