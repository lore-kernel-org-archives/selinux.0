Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC342222D0
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779392005; cv=pass; b=hmeJ0WhmdH9ulCREhiQ1sKMBG2m9mM/tIdOpeiKEsGdekBG8mO++V56GQuiA2g4nKUGNIK4OHr1ujGERHOd1LGhxXTZxEu3SejLLjte3jTPnqUJGrp43H4xyeEIFB+SQAuLzIP5pnyBux4Dgwfrh/LNarHRYws5vTrgGiMg/SJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779392005; c=relaxed/simple;
	bh=ei9l+P3Js1Iebrgn/V/MSEeB7kik+sXH+l3c5dagduY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BE+Z7/EE4JVSfvt7887Pn5Vke7Gk80WMqQD+vNUYd0NQUiXnyPcDdqnJoIERFS6YzJCYp8pRcO2D/OS6cXF1ArPU5N6kLDuctYM8INDKSWSe8ZXNTrxGcWMYqSnpgRUjAUZ0/luAZQw3kII5tkiwWJNT6ys1z8Xc3j2gwWuuq+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=py5wnhhT; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="py5wnhhT"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-83537a80ab6so4381824b3a.1
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 12:33:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779392004; cv=none;
        d=google.com; s=arc-20240605;
        b=BrcGlj56KWtEyZCeuXFP77fCj3qZ6f/Xj/2j0OdkGLcLroO8s/UKaPD+vZ5+6s7zlX
         Lfu0THmZW88XSggCvZzJI7AsIDfCbeObTGlU4VJF8xG7DGqK8oKnccOLRKQxQfIgB6An
         giBNzTz0wHqt4R/zId/U8miVhVyT3RXbNcoQ0cPbBIBE06vOktXn4SvfBMJNZPNuG+qF
         78P+On94OoshrOw+MZ7L6qu7r5AK+kZBWbtdvcXDW/RYYmcAcFDs+12OClH5cn/WWjPm
         +w4LDDsWZxabwE56E6uI2Tw9+92+4i3/32v0JlrdMFOWea1GfTE3ZbYmi6q4JxkFxUrl
         xyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ei9l+P3Js1Iebrgn/V/MSEeB7kik+sXH+l3c5dagduY=;
        fh=1QwKmOBKCzaAoY8BhHeaS5N85aCEEO0c683iIQ2jtso=;
        b=FbNLNVOsLaeDmg5kOZR2JKYvkl5vHiQfvzSkDx9Zu0YIwxSO2DDCAi001lXmXHuA1Q
         /z4W1GA4lBb72QEAmo4OM8BLff3LXB2ldqLnBUAyHSNuMrlEuD1XjxHKOVE6PqxQsnlN
         smSFNVjWxtzGT//mWvRg1cgkzkim8PymWsT9zkYysT4GUjO832yvrJq8A2B8i7pGlSnp
         hBVG7zX/MynKbTIFD8/4m7tpAl9aPkh4SHjyI92eJ7H3edx+2b7DJVZT/z6vAuslXh6S
         k9PsWZANHB5YlFXnjEGOF3OAojDCkOWKV/sku9eSReDVaXsmZnk8zZCc30q8nmXHMvkW
         hkKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779392004; x=1779996804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ei9l+P3Js1Iebrgn/V/MSEeB7kik+sXH+l3c5dagduY=;
        b=py5wnhhTlrkbEkjQvIw8/4L7nULh10T67yURlLX8HlJCJYHflSdH+CPVCaIzjGDzW8
         pDLonhGkULd7hSPspmv4psGmJlDVbWpsc1jvcypwev+5lxor61EGbERzZsrFlXnLIjmM
         tnntVKPM2ttt/7GmyPgLSXA4EIguAwENjzhT/D99eETOFKWyLUnehDwMKHgzJswLoxlU
         erGep/dYUjKKwWBr7vk8OCQRywAM5cPPDxS/gpr4X/rSsReG9iPbEY/A8CHn3Tvt5QK/
         m+p7vQ7xadGC3NkH6Hhle/Foqr0rdsIHiI1kLjgCZBuK9fSkb2BTzQeg7n6xcILnU38X
         rYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779392004; x=1779996804;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ei9l+P3Js1Iebrgn/V/MSEeB7kik+sXH+l3c5dagduY=;
        b=NHTq89ZMZs7lhmoH60XeePAoI0YXgqUOMjwKfcTeRuqg4zuxbpVwmXhvoldbSqWH7B
         1ClKF1jUkJDKWyM35EiWOjCJKFTjTI32nUpRc+yiH4RZ51g7M66bkq279PkG4aPKTcPE
         ACjuXMJ/vYrsFibxBFBud63ux82RcC1MYTCHV5PLziRAiGFzZJYBJYSZFi1Tg8Q2jMI1
         rr1THaXCHvCd4h2h0UKFq+e2YEXS8P8W08XWAC1UAtvx07YEizoSS0jur5fPv/ezmVRb
         QGyvS3JrI1NwRac2sCZFw4XlUZaESf3thNR7G2bzwL+9hbyxTueA7SPcbwylPNjvXr/6
         XT/Q==
X-Gm-Message-State: AOJu0YwrCcuz209VCKVq27Vm0ImZAu28iVZaUfreDgw7tOq2xHrrvA6y
	iXEqNKEC1sRJI1BVpm6GxgmzK3+qFjq3PL8JP8YE+PQD2q9lvOTCHW/5wVCnog8DXJAYiJnSRvC
	Y+p2d52QAiOzkxeczKcRTfrCOQ117aJ5I+A==
X-Gm-Gg: Acq92OFpdXzEilAFRK9jU+rGN4J1tIpWSaqizer5oyEy5jq+feLlIy+coH7NNUkIezn
	gV5fm8kQpMIGVx7BtUhorFjyEUu5J2r0R+jxVUeVyOMEXtI55AToHpAfW9i1ynlzjNFiXheVLx9
	tStjYvNn3EPP0il9IBHds7JKxChJTJxD4OmA6vwaE07t9vrwhB/Ea9VcRlyWlsBG+tL9Fz7xqE5
	PVbWaKmJy9awRxNRMGDZJKpxCR84xKKRJBwlKCHnmk2gE2vx02FhDL08CdcaaB3JSJDcG0Cq+ml
	JBstOH36aGGecZRLqg==
X-Received: by 2002:a05:6a00:3004:b0:82f:721f:10ea with SMTP id
 d2e1a72fcca58-8415f17de74mr624048b3a.18.1779392003701; Thu, 21 May 2026
 12:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 21 May 2026 15:33:12 -0400
X-Gm-Features: AVHnY4KoXswASDpi4WQYcCAOOoloqEDc-iDSytfImLDZvakeCuCXiM-dsp-1BXI
Message-ID: <CAEjxPJ4bb+sBUPPVYbwkay7w6k1NJx_6adiLVbHnYa5vjb5SUA@mail.gmail.com>
Subject: Minimum kernel version for SELinux userspace
To: SElinux list <selinux@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Petr Lautrbach <plautrba@redhat.com>, James Carter <jwcart2@gmail.com>, 
	Jason Zaman <perfinion@gentoo.org>, Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"

There are newer kernel APIs we could leverage to further improve the
SELinux userspace, but doing so would require setting a minimum kernel
version for new SELinux userspace releases. Not sure we've done that
previously.

In particular, I'd like to be able to use some or all of the following:
open_tree() + move_mount(): v5.2
openat2(RESOLVE_*): v5.6
mount_setattr(): v5.12

The question is what if any of these can we assume to be the minimum
kernel version going forward?
- kernel.org LTS kernels span 5.10 through 6.18 currently.
- Android common kernels track LTS kernels.
- RHEL 9 kernel was 5.14-based.
- Ubuntu 22.04 kernel was 5.15-based.
- Debian 12 kernel was 6.1-based.

I would guess we could set the minimum kernel version to v5.12 and use
all of these interfaces, at least in code not used by Android.
Thoughts?
