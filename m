Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31A1917D6
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736332296; cv=none; b=hBhcJ8vXtb+rOJ3t70YCDVcGNKVyxUG+hhCo7Hk2uCyLI7WQatXEdqJc1Ywv3pQo7Oi4OxoSCh44s5zFby5Yg1s7rPjrY3/3y8SJpsgZE/QyJze23ZP62H/AOc4iqfIhh9CeG7eFnqUpMFIEUNaBoQIBFphT4LNyIU0IqJOLeIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736332296; c=relaxed/simple;
	bh=5ZiJ/yXvR710hvjdHaqIaLmPQLOtbWT6YR7hhFaax5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tv1KdjsGhXxCtm1mGQyC3JMDgLWXz9rXmSVM/CGMueEQgMZr/asIEbz4uXLVPl4+b+41a1xGC/MQPpFphhNjFrlKDJGAFJn9i94ueLYJyRjwa9wWicMi651BtTN5HaaKwdFYOHyn29wgvFoSyw6Z8qUikcFo28WiRzWyEB95BhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=brF+6eRb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="brF+6eRb"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53e3a2264e1so5668e87.0
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2025 02:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736332292; x=1736937092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2rvFRPj6V1qMzxmX3AirjgzZROYS5fbmEOwRcXur5I=;
        b=brF+6eRb+7SfLrneV/ihT/hq5RJPbEoZN87fJikFu5iqv4O1ZAXKkjSfSxz32ozG6l
         /S7yT94ADQs0FUbIOXpJmgoCBkAwdXMTfj2N5BDpcT7PA9y17b9gIt2tdaqk8AwdoqcN
         kjqdlIiizsaNqsnjuLEiSqQllOU74y1g/zhcFClvxMErTSvZ4ROKrqnQ79oCXZmW5PyN
         WMircIgqabRvlZHljW9FKizvim6M/7aJvqq+i0QGf41kAhAvJmLUANi6eXGd0vdY/RT9
         +exGXoukLmJqNVpJuPcufeV/bjpoX80ZyfcbRRIGWGLYAAu8AvRucHKNfJHDz0o36eLs
         3kKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736332292; x=1736937092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2rvFRPj6V1qMzxmX3AirjgzZROYS5fbmEOwRcXur5I=;
        b=FnSUpeGZTp9gQY293ea8v9ntX1/+nhpUaCDYjWFjZY41nHfNHeCXWf4qn08TV1Pia8
         03Kd5LuKPWlvOQass5CgEu3lhWO8Evz7dcwLGfLot5kVcNRENkR2x+P54U1wj4vXBzM4
         J+nfqPhfyoBJWNEme02jAHz3l6gVfAmSBAIuj/Y/+hmAqTc56oK1BdsbkrgoTPCMcn5N
         FznSOyvcqRVMpdXEL8KLP7+hF7f/CxO89UrNnWd8hnIGqEmc6qvJAM4WzJA3gnHmlDCx
         /SaSzVM9svsNSvo3GCyQdB9eJjJxV35NukcacCuk0bz3RL793q2rpnUwnc43waoVnBfM
         KMrA==
X-Gm-Message-State: AOJu0Yy646kX8t5rpDo2bztyTMb9rmZBdF9boYCnCi4BBk3yMLrwYcyt
	3OykYEoLCjTchGLbY75TM2CJ+B5uaT2EHCqkBw1Q7J0PQJ/umAHY66e2nmlmuQ07XbSTdzLxCfq
	PoMY61h6ka00Lbka9NI+k0Aqk0u7A7f2CNH1b
X-Gm-Gg: ASbGnctTymfs4W6kkBVJ1IIGWZVI5PYplFM4l9cOPDGzl530RTFFD7RDVXKMQepDGtn
	8GkJNAsjgjLKdDEEUVvywp0wLj+31pwDxi2Crzw==
X-Google-Smtp-Source: AGHT+IGvjc0C++tXHqbb78t/kt0okSN7UuEB1hP9AoQ53ge2dnNYH3+9kAhpcIfV+MdLRfeEIoim3pbouSFcK6TiGXQ=
X-Received: by 2002:a05:6512:3e0e:b0:53b:4c7c:a792 with SMTP id
 2adb3069b0e04-5428433ce63mr160409e87.6.1736332292259; Wed, 08 Jan 2025
 02:31:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108082855.PkG-_BaT@linutronix.de>
In-Reply-To: <20250108082855.PkG-_BaT@linutronix.de>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Wed, 8 Jan 2025 21:31:15 +1100
X-Gm-Features: AbW1kvbICav5cFLlQTzMug6itbzsbcsGccYK3Fr8LxOhWlVvbHg4g-S0xAyigKQ
Message-ID: <CA+zpnLc1PhF7zfWVCj3qezfvYYHbaOc-FyscWS9y74bXZw3rxQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IHNlbGludXg6IGVycm9yOiDigJhORVRMSU5LX1JPVVRFX1NPQ0tFVF9fTkxNU0c=?=
	=?UTF-8?B?4oCZIHVuZGVjbGFyZWQ=?=
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 7:28=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Hi,
>
> since commit d1d991efaf346 ("selinux: Add netlink xperm support") I can't
> compile a defconfig:
>
> | $ make defconfig
> | $ make security/selinux/nlmsgtab.o
> =E2=80=A6
> |   CC      security/selinux/nlmsgtab.o
> | security/selinux/nlmsgtab.c: In function =E2=80=98selinux_nlmsg_lookup=
=E2=80=99:
> | security/selinux/nlmsgtab.c:188:33: error: =E2=80=98NETLINK_ROUTE_SOCKE=
T__NLMSG=E2=80=99 undeclared (first use in this function); did you mean =E2=
=80=98NETLINK_ROUTE_SOCKET__LOCK=E2=80=99?
> |   188 |                         *perm =3D NETLINK_ROUTE_SOCKET__NLMSG;
> |       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> |       |                                 NETLINK_ROUTE_SOCKET__LOCK
> | security/selinux/nlmsgtab.c:188:33: note: each undeclared identifier is=
 reported only once for each function it appears in
> | security/selinux/nlmsgtab.c:196:33: error: =E2=80=98NETLINK_TCPDIAG_SOC=
KET__NLMSG=E2=80=99 undeclared (first use in this function); did you mean =
=E2=80=98NETLINK_TCPDIAG_SOCKET__MAP=E2=80=99?
> |   196 |                         *perm =3D NETLINK_TCPDIAG_SOCKET__NLMSG=
;
> |       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> |       |                                 NETLINK_TCPDIAG_SOCKET__MAP
> | security/selinux/nlmsgtab.c:210:33: error: =E2=80=98NETLINK_XFRM_SOCKET=
__NLMSG=E2=80=99 undeclared (first use in this function); did you mean =E2=
=80=98NETLINK_XFRM_SOCKET__MAP=E2=80=99?
> |   210 |                         *perm =3D NETLINK_XFRM_SOCKET__NLMSG;
> |       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
> |       |                                 NETLINK_XFRM_SOCKET__MAP
> | security/selinux/nlmsgtab.c:218:33: error: =E2=80=98NETLINK_AUDIT_SOCKE=
T__NLMSG=E2=80=99 undeclared (first use in this function); did you mean =E2=
=80=98NETLINK_AUDIT_SOCKET__LOCK=E2=80=99?
> |   218 |                         *perm =3D NETLINK_AUDIT_SOCKET__NLMSG;
> |       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> |       |                                 NETLINK_AUDIT_SOCKET__LOCK
> | make[5]: *** [scripts/Makefile.build:194: security/selinux/nlmsgtab.o] =
Error 1
> =E2=80=A6
>
> The commit introducing this is part of v6.13-rc1 and we have v6.13-rc6
> and I wonder why am I the only one seeing this? The bots must have
> noticed it way earlier and yet I can't find any report of it.
> Is this a typo that everyone keeps ignoring or do I lack something that
> auto generates this define somewhere?

Thanks for the report. This is a known issue where the generated
header is not cleaned properly:
https://lore.kernel.org/selinux/20241127-selinux-clean-v2-1-a6e528c1ff93@li=
nutronix.de/

Could you try to remove security/selinux/av_permissions.h manually
from your build directory and build again?
