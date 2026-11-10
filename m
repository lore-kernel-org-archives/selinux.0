Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794329444;
	b=vwNue7PjqXxHXu/QMoCM6eBG7S20mVBE0X5j32We/GyZec0GLJY3ahVQ57WCC+ypL8aU
	 I5oeSvGLCXkQbTQDD6g6CC09i0B7gfyoe5PKv4nA6fIT0OuvZBYLX7ndfiVsDbffcWZ4S
	 stSVdzkK5cohsQbwPvSoyeNZuLVuq0GgVbMypV+DfMOqg8Tsm9/0o/Lue0FJwd3BBOEv7
	 7x1fjrNCrD2RF4hKCnjmLeh0ABPB8jskF68004YXh3/08e5aCDUiA8ZbuRm0Dxo6KmHEq
	 uMoab1s1wO3RJqNQ0RUCwtkvQzWiizqzBLFoWjee8cWgUChhWQQ9y9RcNbUpIrpH6kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=9oR8tJyOiORTZNZdl7JgbEiMduotOMSbAzHe9qfpYes=;
	b=kVj42bOq70gOICgHrGb8Tlp4d6njELe7OA0+lEEQuqb+L5+zM9VymsqhoN5NJSqflrzl
	 dg87fOjd0iq3oCea6SG23QrjP7hvHjQP1hqKx7aHowBMIoumbA1YHGX9w1eGeNvh5pU/f
	 Yv1iHvsiFsu/bxNpCj8HvtcDEVYbuQInY8rygv8sQkv4gvlrUA3NyHDirtCzZ2V53U9VU
	 q+4W1FFoX+7n3CN8R8vuiTryR4x67mOFjAJpKwh3wEtD+Y/pmRT6POBwAaj0uMlwxBURD
	 cIm6gs4KPHtEcRtsZP301jmw1QvpslDHflP2I4JcstqmEXnc2FTb+Gd95xV2MNPrupw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oAAnomOj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C0E606A325
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 16:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3C0E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oAAnomOj
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67921b515a7so2488817d50.2
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 08:50:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794329443; cv=none;
        d=google.com; s=arc-20260327;
        b=HHfNOgvJiQKKFIwB+oXeup4pJUnHCK0sLEL/O7OjxPv4uOmiZloSOhLU/1CZ7XMsF2
         ztmoiaR+ZbqntU+6BTfKZBdFEJ6ppNrNZ9g+fGrxqXAxtEdzOxoFiemVubqAzysClbXB
         FmLjmPI94oTfqXP9JzvdDKPUD6xLicy9mC30X7FO+OD1d2s+qknFPjUDmqN6px1uVC2x
         Nm04jDtIJW55gr5epp2hrXn8qii7R5S7r7ExIHWCS/FnSGrY9NHKi9TRiPC5M+AcI1Em
         uUik4fm/0pOkLwZhUH/sa6/eNb2Qnp/nWbPYD8/pXkbG23m5KCevKdSeqrw4eyQfbKJ4
         TwYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9oR8tJyOiORTZNZdl7JgbEiMduotOMSbAzHe9qfpYes=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=LKug9JTTfyCPDPKKWbyCVn3Me61gHONghZ2JExYxqM+K3vGmKxmAU0BJ9xu47WBJrb
         nGbFPX8GkaL6jTJrW3lDuQ0eKsxZjlCnVNt+n3W+UXdKD/x14cPk7eQzu0G9F0bj1x9Q
         HNOyy64rQZFeLRLSoGPy/PdAUkpE0KWV2uCYo5+ZXwDHxwhs1DLGYQoGwnXcNw2rF8X4
         6qdZPubWiEaml53L0W0WiXjNnwn0oUj06cPAvWZ9ut3Zs5wmU6/AWwhprjvvvyrrm4jK
         iXlXezqdreZKqQq8qJtYZLKvA0A3sqlLqwUNv1ug2hTH6vn1VNIdBAVrCb/4IDTZUwmz
         FlTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329443; x=1794934243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9oR8tJyOiORTZNZdl7JgbEiMduotOMSbAzHe9qfpYes=;
        b=oAAnomOj16c5XlbwzOhpcFpTY+eVw5ZKQdVQAK42yXQ4bf2zAap1DBdYzSuWvLAjo6
         1VelEPQYEcRXbu6GJb/aCj3g2XP0iCFtYdxue3Xe10dt7eMpWV6dfI0Ts4TTrL/Ulpyf
         uS0jHMYXgufIEMq3N9XdQhk4GRjjXKGDX7O9CcVqfSQ0nI8fPW4TiT/MUBwdKmv+cUH1
         NStA3RWqOIFz4GOKlO5ub0zIxVcq0BP8PLVRsL93ZQvTxXrqM6sEDJgJLrXoQwQjk4vw
         V9Rmxx7e090B3ckOzsMwdcbwiIslRCGzoUKLGtr1RS0yaEFj9+C5kTq8tj0JSK0PHe/4
         vkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329443; x=1794934243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9oR8tJyOiORTZNZdl7JgbEiMduotOMSbAzHe9qfpYes=;
        b=YnaFNUlA8Q4y1EM7P7O7P8RSN8VMn8skllasyqMbgYd4Kn18WSNpYjzKUR2c68P+TP
         cVwDUur99jwk98+odkthtCiT+ZpmrIF+qbPKRZ/w2cgRTpZyK2sFHGzy49u3KplElaWY
         5kd1Asz5jg3+n/49CwjC4uO7lfCrWsTR3oYhqEdHkzigUj8OxF/hjU/u18w4mH5eqQ8B
         eW21GxPwlLoReQQtgXsptN9gyC417t6rkwfgGgDWXFI74UknJJl0OyvaAtU+1Qm9l/BG
         DXNer7/1YjMWwL1imqtUASl68xo9NA80tcZa32eDTEuAyKgUbfj/iAfoptV6DCxyCcwu
         9kIQ==
X-Gm-Message-State: APuU4Z+xsugZESfMPFQMbKTm0OGAEdZq1Y7TYsmtqeh73CiyRPtKcZDU
	xUFCmbqosz9S4dPFMufYKLE7c++xYunFfGiuTiCQx6wHN6Y9UeQitpTF6BAxPjqi+o6fBIDuer0
	KPmhlm3GzUG5sCoYiqoTuk2E4wrlRVPM=
X-Gm-Gg: AYBFou3R7A9eH9tBjo2GuPyGPiUObBog4rIgq2uIC1tpUI2HSE6q5Wxmcey3FeHwOx/
	1euhKN8lBREHkC4hFPO3kJ5O97DzAHoM/a0x0JZpohuDpkneRgaD4Yru5ISRkQ8TQG1zz4sGhhU
	DoYV3Y8xu9rKxY9EZpLrvR/US3GLksxHISCmayyC9i2sBbTejlRe/wqTGYxvdAt96HvLdunCjjk
	dy6taHOtm8B6zLBOa8I+vZrC6yWOAycS1aJEtAA1rAjjVX0zdejpOqRRHh3Mpma2y+faYptQ3z+
	ZPXJ0z4z3gQV8TyI8vlAMQvdGrovFv6HHCCyIaEnEicOjbP0/BKMzDyXdOWOXW6OdMIKPPYqCCh
	W3aJFAz5ris4JcQZ0nVqh70ukGocGwmCljM0BdzHZxc1508kIUUGDjlkfEc2zGq/1Mw0LrTZLDy
	1G/uyjRHJyybZbogpr0fbmSC2qU2SUNyyFb0VS/tezQhyW2LT+jFHEVANITw==
X-Received: by 2002:a05:690e:144b:b0:679:992e:3ac2 with SMTP id
 956f58d0204a3-67c66e88627mr84290d50.40.1794329442824; Tue, 10 Nov 2026
 08:50:42 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110105906.58509-1-cgoettsche@seltendoof.de> <20261110105906.58509-2-cgoettsche@seltendoof.de>
In-Reply-To: <20261110105906.58509-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 10 Nov 2026 11:50:30 -0500
X-Gm-Features: AclHuK-1tuGLmBavhSJzg4PSyzxtL1Ud7kJ0lrsOz3MopfeSNk31SK3_zccGW5s
Message-ID: <CAEjxPJ7gHJGudaYteAX1gkL1ZMR0S_GhO5w=mFa1m=fuj0J+0w@mail.gmail.com>
Subject: Re: [PATCH 2/7] libselinux: set errno on getseuserbyname() failure
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 6:05=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The require_seusers no-match path returned -1 without touching errno,
> contradicting the documented contract. Set ENOENT there while letting
> the fopen() failure path keep its own errno.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/seusers.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
> index ea542392..659626fe 100644
> --- a/libselinux/src/seusers.c
> +++ b/libselinux/src/seusers.c
> @@ -269,6 +269,10 @@ int getseuserbyname(const char *name, char **r_seuse=
r, char **r_level)
>                 return 0;
>         }
>
> +       /* No matching entry found; the fopen() failure path jumps past t=
his
> +          to nomatch and keeps its own errno. */
> +       errno =3D ENOENT;

With require_seusers=3Dtrue, an unsuccessful getline() would be reported
as ENOENT even on a read error by this change. Distinguish clean EOF
from failure before closing the stream.

> +
>  nomatch:
>         if (require_seusers)
>                 return -1;
> --
> 2.55.0
>
>
