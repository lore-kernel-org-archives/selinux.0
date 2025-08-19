Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82F3093B6;
	Tue, 19 Aug 2025 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625636; cv=none; b=rpOgLrGORnCw39nRycvaUx7QSEBFIhzRJodssH869ce/IhIIyZ+cyX/LRKRV4XJwhLBk7ld7j2uE/Y3okZhP8uZVKQt5aTo/Ih5HQPmW2VSIGbbTKjOYOxAl9b7gcV6A3z/2TYpsrMvIY1tXwEXjx4qpD73D10URlhfDdX2duyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625636; c=relaxed/simple;
	bh=McnbuHb5wi+EznYWp5yWShuuAUgvnEbHKGP6N0nLwms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nER0VqO+hz2s7qHygDwFL65v05khYbxJNKVq4q/wNzuwjlTCw0ycNRdU13WqJJBRflpxH5R0ez0qsmgrfcqItoW7oC2UCcJYoLUuz8lJCRu2jkPizhpxubf1TPX1pdQHY7T2ZImPhBV/8ZKsrZuYcNM6gAXH/POO53M8rLZsyXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgfQubJZ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgfQubJZ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-323266cb393so5157503a91.0;
        Tue, 19 Aug 2025 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755625633; x=1756230433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Mh2r9k7owueSt9os8fyVqdWxhHDOKyOa7EV2HX/FL8=;
        b=ZgfQubJZHwBrRxdmcNXp047K0nuO52PA11Jgf+ML5qrWT+Twb97PyJ6HFmioU2MUJB
         eDVJubO1I1RG/jRwXvstTiwl606m8dGhgKeh1PMdc+dSF9FfuPcsAwuT9pE/Qs0yyWVd
         hIW6LFOF6DgzSUYZrcc/dnmgm8ribRF7QRUzzzTG0xMlW5ytsVOEtSvHxs0IJ5r8jJJP
         ji+z0sMnFf8vcliheNADHF9LW890NayAJDWaOw08WuLDJN8GXEMKzC7RvQhN3Gz3YIb6
         arpysHA30kVphLrRlHVH6UDqFPYWZiXY29H5OdtkYqEGxazpYNrM4iNgvIHisRl6EHg5
         eOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755625633; x=1756230433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Mh2r9k7owueSt9os8fyVqdWxhHDOKyOa7EV2HX/FL8=;
        b=V1hhHAoGfJeswwW+D4LRBJ8mLorELa1LkoJvDnfy3YiX8X0Rhtk+DCzX+5DVp/rKJ4
         oGBP6dRobLgrJ+dHMMWxCP4y4vCVtrWl0+UFj1z1s0Ocb3lDJ2zgAeN87x1Hf24R9eGF
         8P4HS1juL4rpj7XbTdp3X/E+7nC0SZJBlWrlHk2HQFMFG3HG3xAs8WfbeJ9lF+u1wmWP
         bPjTeBtvXD0wH4l+l3coHVQJCvO+KS++chRxwt+Gxyyq6g+OFOQyMwrhJrwjroVp+RQt
         xgebeqFr6cj8cIJYl4pxqZagmQpi/cC1HAN26h4OuclPCfLQFS9ZNw7iR3V9dwGUt6+Y
         K29g==
X-Forwarded-Encrypted: i=1; AJvYcCW7MTbZi+yz0CMSr5Eaa+zADeg6U3YpnCkTRs2Ts6hXI2L8j53SpB+6BU2hrL2qUiptTNiTh9+H@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5OF9yfwQI+vB/wb38IFLaXBDsL4ZesfSLXkG8a5PfieiZ05ke
	OJLzXDluzr7nd8+p+JrG0oMzC2XPFhqrcIG7sIX4Hb5rDq2dq+wfw94MDAInEbMQTs1e6XUdy0f
	NHOzImEP/rVWclaU/h9vaAUmIl9zUgz/pkQBi
X-Gm-Gg: ASbGnctGmTIpoP24sitccUCM3u6rSAyBOYZMb3GPPw3u2KOj+DGu339A8Hh5uiuKjjq
	CHXD0DQK2p3+JXqkPiwHl5zLk2kKfvKIYZUumNr3b/TZS9pWHCBP1UAGUP2bIr/XHY6tqCDhjTr
	lxigiTwJnFUxdWh3Hb8Q4VM2iVrgo77PNZj+CPRrGbFPjlUIZZHjyxvY5UXatfdWfjNArVx7k7A
	4y9bNH257lFmGws+A==
X-Google-Smtp-Source: AGHT+IH/m9PUl/KnX+BkOiCNcUNsfmGEfqPqdUJ+6vwgw/L6gjaoHoj38lA9n2cee7mZI92QP7thR8g8u9CXwO9IicY=
X-Received: by 2002:a17:90b:58ce:b0:311:a4d6:30f8 with SMTP id
 98e67ed59e1d1-324e13592bamr116256a91.13.1755625633452; Tue, 19 Aug 2025
 10:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 19 Aug 2025 13:47:01 -0400
X-Gm-Features: Ac12FXwsYCvcY6xuEy1X6Z0OcZDUHvVfCsWZwt94T_vEPdZ1-VEF1oqVgEap10U
Message-ID: <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
Subject: Re: LSM namespacing API
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 10:56=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Hello all,
>
> As most of you are likely aware, Stephen Smalley has been working on
> adding namespace support to SELinux, and the work has now progressed
> to the point where a serious discussion on the API is warranted.  For
> those of you are unfamiliar with the details or Stephen's patchset, or
> simply need a refresher, he has some excellent documentation in his
> work-in-progress repo:
>
> * https://github.com/stephensmalley/selinuxns
>
> Stephen also gave a (pre-recorded) presentation at LSS-NA this year
> about SELinux namespacing, you can watch the presentation here:
>
> * https://www.youtube.com/watch?v=3DAwzGCOwxLoM
>
> In the past you've heard me state, rather firmly at times, that I
> believe namespacing at the LSM framework layer to be a mistake,
> although if there is something that can be done to help facilitate the
> namespacing of individual LSMs at the framework layer, I would be
> supportive of that.  I think that a single LSM namespace API, similar
> to our recently added LSM syscalls, may be such a thing, so I'd like
> us to have a discussion to see if we all agree on that, and if so,
> what such an API might look like.
>
> At LSS-NA this year, John Johansen and I had a brief discussion where
> he suggested a single LSM wide clone*(2) flag that individual LSM's
> could opt into via callbacks.  John is directly CC'd on this mail, so
> I'll let him expand on this idea.
>
> While I agree with John that a fs based API is problematic (see all of
> our discussions around the LSM syscalls), I'm concerned that a single
> clone*(2) flag will significantly limit our flexibility around how
> individual LSMs are namespaced, something I don't want to see happen.
> This makes me wonder about the potential for expanding
> lsm_set_self_attr(2) to support a new LSM attribute that would support
> a namespace "unshare" operation, e.g. LSM_ATTR_UNSHARE.  This would
> provide a single LSM framework API for an unshare operation while also
> providing a mechanism to pass LSM specific via the lsm_ctx struct if
> needed.  Just as we do with the other LSM_ATTR_* flags today,
> individual LSMs can opt-in to the API fairly easily by providing a
> setselfattr() LSM callback.
>
> Thoughts?

I think we want to be able to unshare a specific security module
namespace without unsharing the others, i.e. just SELinux or just
AppArmor.
Not sure if your suggestion above supports that already but wanted to note =
it.
Regardless, I have no objections to any system call or flag that can
be used to unshare the SELinux namespace and it should be trivial to
wire it up to the existing underlying function.
Serge pointed out that we also will need an API to attach to an
existing SELinux namespace, which I captured here:
https://github.com/stephensmalley/selinuxns/issues/19
This is handled for other Linux namespaces by opening a pseudo file
under /proc/pid/ns and invoking setns(2), so not sure how we want to
do it.
