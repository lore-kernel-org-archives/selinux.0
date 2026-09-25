Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3D3AFAEA
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363056; cv=pass; b=eKsmRU/dz1AFxc7SWJaYPa35NhDIL5TagXJJq4b4SSM70hNO8HOBxx/gdwQNp2Ob9PK3CtbCWwryHU7s3scPZ+D+GQZokMLL4TQY5BQ6mO3ACVAEyBbpVfe/6HU9wk1eHmNWfiLZj0YoCUEUcvacJTw/T6NjOLADD21jwc82hRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363056; c=relaxed/simple;
	bh=R9dHvePV31bozm99GtN7DPnb0xpTLdI0S9Wn5x2Ny8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOOHtdxpagKqlWpNk3gzdWfRqV7dUdJNBXseTIotL3+bs8m5oVlEudp9HIldbvRImKzRJ7QxwFj2ZomK1hnPIy8gGDgOJBbgn8709HKN4K+PPjBJNll8fZk0FRCcE0oAivGQscQGGa+h9OcRdNAAEl3yODcu5LPAQJLoiGacESc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ktbb0/Ki; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ktbb0/Ki"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a87be3ca16so7858777b3.2
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:04:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790363052; cv=none;
        d=google.com; s=arc-20260327;
        b=T7subs32/a/K8rGAo4IgJMNWvtUwSN2BySrFJOjGVm5w7aETPHxzgT2ONYGzv7RbA2
         qOxeuCT88Kx5RRZ/Wl6my8G3rVm0YTzYTGRNZC3gfSHXN3scOM+1g1R9YW31Y9IkPkDC
         pDilbMqaqvEby6RXfvvQiDZZ+1XLn/BayQBYSLUeK2i26QF5yQeTK4jbOvPUSlARKCyI
         wd/A+D6fhEm2ZHvZkqaeRqhVjLYYzLIGsjuHl6ov3DLPj2Urux0Zi2BDT0uZY11qVn8e
         RH1RdhKyB/vBxCg6mrXHYF54+72MIhEwHI/ls/ys7CwoPbXRkbffOZp0k1aHQUx5TLOp
         YQfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h2weLQhvDbZTbZQK4hU++nbkcdLKDolgELBnFTO/k14=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Wu+9hn/Bh2LJJmGhMzMQGflBytr6bBmfmYmRkoqiPApJNRJNjc1TAo2ziaM74qITk0
         b6T9Se7+xFg+YhHW86OF5t48IrKX3Gu8BNHyvb/e3bgOEbiVa/U4/jo9qc8e9M+E18Vy
         QEEgIorGTgI+Jr9oTG4gELDUIYS8H0lPHMOlFHIMZRWqBBM6Y76NUoFNxap+TpOND5Lj
         pQOZwHzRe2EfD6IUpYvl8MXrKYc0wfC2w9+MkSOBS90FGhr8yahRVVdTE6SLl2FK00Do
         +NrNkAOp+1s/dbA3eN5DrRPj8+LKQhFNDhjjue5YQmwiyo8VAlXfKb5Zwx4YZihxZTxr
         DrNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790363052; x=1790967852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h2weLQhvDbZTbZQK4hU++nbkcdLKDolgELBnFTO/k14=;
        b=Ktbb0/KizNBmL1byPLu0Oa/14OmmmST82zPQBtFrNauz0LDP8vDMkhm+d0GZgcGuAK
         kSToprCSdFgBHZwzy5/ls1zjfP/GXp394mUIcE6wOBUaBIs2QLmE41uVl++rozAzs3qp
         Phv06g0ull+afl89QFAAF9ZlHfMWoEh7Y4oc9sk6WhF0IiJ35D79/w4ilmtSsV9h5VDk
         i6JGhsT4I+Zznme4DhAkXEmFy/HgrG+tbs/tqS3EySaLBSEdr7o1WH0nxxYvyZf3Qqft
         X3j6Gvf8Uj07LIoJ7wJHLuFAL7U8JO6gyDY6jMRP+pRLAzwA/Et1+UqU+xCwKNteKRoP
         dWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790363052; x=1790967852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2weLQhvDbZTbZQK4hU++nbkcdLKDolgELBnFTO/k14=;
        b=ioxvW39I8oIoYZWff9s7qJHY8Zaa4tIcgw+F9Tus5xPEPMfwexh1Xg/ZBRCYoB6ilz
         XggZQ5bHpfVWmQr3gfIVItdBYyuNSH9vpyWM2L0v/5CM9dmxAU3pgfiIEe2CpbUuz+Tg
         e9/JBiPbuIx0jmA7vAbnK/P5MQvSph45lYo25P6mZrF/m8oLSRRD9Sq0f7Kn3Fu+cY+l
         LTOI1Ms0/B+wghjAqMEwWdpdqD0aIU+OrsUAa63/QwhyXR23z2dDYXBjHo4zVHOTyd/7
         xmWwv97DR1s7eQhxcFBmTPovf+WCE20/nbXLUxbRY6NAtXzYD/KbJ0NK+jtVXKkS4FFI
         FGrA==
X-Gm-Message-State: AFuF++mYynAPaIP+Tmk5fPr7x1HogH/7rY1AKoZyyi0zS+gAIduMMcTj
	wMxgcSWXqsbPTUmI10rgAr1DZUHaBOd1sBEOUA7PEinnePGjLGrdNe/Xr5YcVBnbOVrxhjrdRhk
	eI/mVXOkr0Ft6LteikZJAnaagACi+pIM=
X-Gm-Gg: AYBFou0/IPFzhzbh4iZzTZexBaNQmHN/GLqc5Q/66nDQdIJU3hbhypSGJqObWYxgA9G
	v6syHRYWpP7sfVcM4PfsCmoPEFV+NZ+IvnXTRumipZIdmlNnKk1BZnkQSNNsbnqcjEb8wytRwdb
	GHCybYOMLBxtchfe5JWKqoXsQF+ron1l/tctz9EEtIqadViJEP44VIpqOBN7MTnGEhVpj3VmmpI
	yb+E7rg8TIskJ/0LOrLW3HOSZi6eMBMseUKZ9NJ3kb6UwH793V1P9IeKBIaw1XR7pn39+hmikq3
	OQoYv9cYMPBYQkTwJiLLDlat3aJQN/G4psDqhZUaAPFhC57hfzYgTQiXXcjFT0mwdQ==
X-Received: by 2002:a05:690c:e:b0:853:a9c4:c3eb with SMTP id
 00721157ae682-8a6463b030emr33134567b3.28.1790363051778; Fri, 25 Sep 2026
 12:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-5-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-5-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 15:03:58 -0400
X-Gm-Features: AclHuK8lCSps8gHbQ9sd3ZcGgaHL7k4FUvBnR_OtNb-fcwhmQ70RQk9VEwhBpIM
Message-ID: <CAEjxPJ5iGQYPSBQ7oh_F6rNufmFniiOydmy6y33PsrWFUMjL1w@mail.gmail.com>
Subject: Re: [PATCH 06/21] README.md: update the Debian dependencies
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:20=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> libselinux1-dev has been renamed to libselinux-dev after Debian 13
> (trixie).  Also add packages providing tools used by the tests that are
> not pulled in by the listed ones: make, lksctp-tools (checksctp),
> keyutils (keyctl) and f2fs-tools (mkfs.f2fs, as in the Fedora list).
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
