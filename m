Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A26168B9
	for <selinux@vger.kernel.org>; Fri,  2 Feb 2024 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899673; cv=none; b=LdNoPUY70Zbo2GLLgtDAmRT2UlJBhYWzpIZUtQmMnoh2+aks3UOmXaOblZzpKNEiFDWe5XELZtAjsxnjApYYCtEYLKLTA5qPd15tnC9QvQM/H3+JXID7jNbna0cK96LpIqSGTx/sLuYnEM3WSVp43mz5GZ2ocv2wS2nhmFIl/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899673; c=relaxed/simple;
	bh=Wuxl5vk5hzFM5Z4K8zEVOY0JnCMPD6vtlJM2iLYMc3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uOH5nz0aZi4Mu50AvCWwoj6UyDQgJkbs1E/c+kpHhKLjvYYvRYS2Go/8qmjtEsac8g1LVqNNsmMDua3T7d2MTxyFg70b5MDQZcHRXAoMVx4o79vIp6VyQ0Zd5MDwTgQhwM16jYLkZa0BBxhkWKHqapC9b3cjQywYavDhsijG/6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RrdSwEEE; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RrdSwEEE"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-603c5d7997aso22481997b3.1
        for <selinux@vger.kernel.org>; Fri, 02 Feb 2024 10:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706899670; x=1707504470; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/HMThlaMAGd0lkG8y7zuiWSMtPppy8fZvYOmI4jhkA=;
        b=RrdSwEEEhnDi7Bt7QKTznAm8mp7vAbhP5z9/KyJR0DTcScox41PD2gRjh08CtjYarS
         +HmRoZ0orvrZwIt0xOrAEvINiFwxSmY8N7NeaXBwsWupTvk6A44TttgCjLy0VGk8O/Oy
         f6VMuN+n0L1OSbv1Ob7WpDUrfYlU9X1PECCprMHEG9cgJPB26gCDKJTig7AxaZhJsyDk
         95UKQwMKfhmutIIwixKm9kgHDTt4ukxn81eASzVtBHDmiXpP7eA8rbCeGGXFQNLwi2bp
         y0p1dHq/GnHwHNOjQGOXbVyyHCDPWaICR/YyqrEQDpTAWo3TRx0TWud865VrSK/D3ZN4
         9Bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706899670; x=1707504470;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/HMThlaMAGd0lkG8y7zuiWSMtPppy8fZvYOmI4jhkA=;
        b=TlDIpm4Lf1qUDASEsj20qw4YPXbyZ7dLa+e+UnlfaT3ZI1T1k4dEoys8+Oe/WAsK2G
         uRX9ImZh+14tEn2bJftamlhpwhZQtuzbvkqYNIByKGkB7lqdX4aJ/frD5DE6kYEMtqez
         NzL4c3MtOuFCpmyAP4aWKZ99rOprGXE4ypMvsjRw5A1W0anldmKsN60fW3ba9NixcY6c
         1kK0pqftyxBTrhFbc1UzxlQkKEHtrcF9i6uElhQ5a9Wdq/HxU7bX6RnzyzQ0TmP1THW0
         D6sOcIkpCgWYBRnisR+/3T2As7SEvh4Vgf5TbbTWyexquJK0I+Ff6dUHnCtUxhsbiF5u
         dAdA==
X-Gm-Message-State: AOJu0YychOMABBBheqo3H3MLh0AokbLRK/6OyddVJvthu2YUOqNh2tip
	bthi40sk7ECFfU9PLe0SSfLAOrrJxOqUTibfwUKBS4n9ALMBxecipZQRsYUMlvwvybPVtK8GoCA
	xfFjk3MQoiSBF4RWgpvb0EtkiyRG1Np2iUmFms3swYmP+OEw=
X-Google-Smtp-Source: AGHT+IEvXdu2qGmxWqy4jJ8OGETbx8qPGnCbKhQPnwYJTUA/C17wHmaLH3OpY2ttxd0+L2EZrRfW7tvcvFmIWtS/Rig=
X-Received: by 2002:a25:ad90:0:b0:dc2:50ca:7d03 with SMTP id
 z16-20020a25ad90000000b00dc250ca7d03mr3330975ybi.1.1706899669776; Fri, 02 Feb
 2024 10:47:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130232342.378342-2-paul@paul-moore.com>
In-Reply-To: <20240130232342.378342-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 Feb 2024 13:47:39 -0500
Message-ID: <CAHC9VhRw4MoJhspYOmrY4JdXTTd=BibE4Cd5kHxhVgmJL+tLJg@mail.gmail.com>
Subject: Re: [PATCH] selinux: correct return values in selinux_socket_getpeersec_dgram()
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 6:23=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Instead of returning -EINVAL if any type of error occurs, limit
> -EINVAL to only those errors caused by passing a bad/invalid socket
> or packet/skb.  In other cases where everything is correct but there
> isn't a valid peer label we return -ENOPROTOOPT.
>
> This helps make selinux_socket_getpeersec_dgram() more consistent
> with selinux_socket_getpeersec_stream().
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Merged into selinux/dev.

--=20
paul-moore.com
