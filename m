Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993789;
	b=Af9ijVfnj100pvuc8CDaGJfxO97wdihvOJdcSAKGRCNgNvAr1/je6qggArsWyDbO9hsY
	 beffH9BnEaDunSYHSLEmcjrLPRE2SP4c4vlwLZL+fFFIiYLz4GOPowSXjoGtW3CPdugF4
	 l3WWn6GCr9tDLbVnolGMnnVTGFtkWCLugnTFEQLEN0ryNR/AAf3NcfUR9cc98Ns5LHVdr
	 rWZJR2yWFcmXnQENTiG7JTI76x9lNKTZJ/vNRuV6eckIy4xzmMiiPnF3NazhJZk2eOjyr
	 +7vEw8KVidQU2/fRF4t7wTcW2x9OfMVmm+PFxXhyde67Ks7EdigTI1fqPj+9pTSiEhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=bGj/tzEpUNDWyFCzMBKWCbyGBoC5tmQucXG8sGFLgDA=;
	b=Xr+vKxb7yZ9dkmLBdmYcegC3obd3SaSwvuYRGLVsRxYebKuiJrBDaNHlGGAdcpNLgFU+
	 ikUBGx2/8nZOcbM6A2k3Xs8bGEvQXLGkU4JCURsvtuvWQZqyY4Ko9x37OtUHxgdPaGb6h
	 VeTyvjKy7UYuG9TByEuvWY7T1Mo6E440MkLbLGhOS2llTf5TzWnAx05dEjAPrpqorG17w
	 rFwpjFOTiXBSEDihcItk7Jtm68VsQ0OEJ7+NBmVmmaL9/FahQRvx0RbiFc19VHszJ3oG/
	 FsvBkxHihVugppzazECgiJC8fFwr4z55NiX4lkQFW08kUFIUvkfh2jv/K3SQc4cbMKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="QS/nKdoA";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09FE606A33B
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E09FE606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QS/nKdoA
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67c00f291e1so789178d50.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:36:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793993788; cv=none;
        d=google.com; s=arc-20260327;
        b=fpN7lekpze/N41VgP72OcA/G1O99V4mO5R4I4Qb53Ck17fOKRFNyj2gAJmx8vn8Zjp
         CXvZYOemT0kOCxRYREuETN4JaHE6JtyrkTWBYVgzmSUfZBw+JJcOEKcqX4KxEo5E7WaO
         Xr9bZ04Drsx8uRIp89/3cGD1OHrPFv69aKOJdJQYxp5VA7trdknC2slYj5WTOUr+fsii
         te1jDwxM95pibeULFdEr7viOrzZ2eaKF6rjiLd1m50casspXWyEw3lCLgRgRDPjPfbyk
         l+aGSa4tY1/4G9hymh4tpdkhnM8cy08394FGH0c/bQ79c+VZbnITUOAdODVySr7NJcHh
         VBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bGj/tzEpUNDWyFCzMBKWCbyGBoC5tmQucXG8sGFLgDA=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=JZoXdJbvm4bXwW6ErEimi8iV63WKlmlew3ZUyv8xMtTKTtqSn54ZdvTfvaKh9PhXSz
         asYDQBYcMqFhGNsStyor8QuC8LvOhl1jbNAoEeT5y1lCVm8Hc/VVGitVxbzn3/qCc/aM
         SwMkjmN+jtTR244qTbyL9rFy4qFXtKMVcVPj2I31Aj46mcZ3/07cYRXwT51SuC85AREM
         A86GyK3acZVtz4zKE/KP2apbyFCJA79tgeQhJGsgs/ADBJuE7XbOed+M1JVg8CvHYXS2
         JqpsL3SAHOGbB1v3MOSX0zZOa47kV/ItWFPVOGsqNhddWNKmYEcX4Gh1MC81udGKWEsd
         mf/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793993788; x=1794598588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bGj/tzEpUNDWyFCzMBKWCbyGBoC5tmQucXG8sGFLgDA=;
        b=QS/nKdoA+PJBqq8C3pU8qDamILiikPnEf3Bt98ZbMUBfNofXSdYJCf+et8ll0/rsVD
         bh9inBL59FaM+QcEeO0etEWgPV1n9jhmiLHkp2JbYfpWFbBEntp8JrZg8kyLSAHwcSW9
         KtjxrkmHy/taw2jkJ+tq61hFzhIYCJjvTT8jYw9hQQ+Gp6M4FACaAt4c4vEPAHs6VuDr
         9NJorvBOJgB0V65qHsBicq9OZiMS50vL+aAqGm7k5wFHjbdYyE0zlUhEAQdnw8E8PIep
         s3RGAWumZcMIX6M+AK33xAZv9nIGU5ukFaGLd5KKOkjTiq2GKTZH7Xmyeqp8FGSYY8L4
         IVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993788; x=1794598588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bGj/tzEpUNDWyFCzMBKWCbyGBoC5tmQucXG8sGFLgDA=;
        b=B7/aqFw8nH1G1zID6bRcXY0/T2WNc8pJ9bqD/E5IElONiVJluWMqFnxHmQATRZq7hs
         88S/QxXKxNaFJp1X030ShveC70GSmQg0O/wUvtOaeK6fOcVx9x3HC1SeZfjqOQd4e0ks
         J5aslZtBDSicVvzIYC/mfLvki/hcjEy4ry9746OTbWlTXM5g4D5qf/cptx0HU0gjEV60
         vhkDapnMhaDGy/N80OqALCvJZ4xat5YJv4UVcHJ3J8ng92A4ysMT4vNfw1GrBCfGR4Ry
         5b1DrQyC0R+OsJ57BhQNp6zIxVV0O76WEnxVDsOQlPxpXC9rT/BqUUtWd863u1/AeZ62
         15UA==
X-Gm-Message-State: APuU4Z+nIj9ep1ldvpxBRXiRti0n3nMtDI1wUgx3U7JzjNgRnd2Xzzay
	8/LVRhHuGi/SuTV2Plixrs34iyPRxjHQpwTLVieEVWXidgAc1mvxd1aYSMXu4LxcTxg3zicjYub
	ggop69NZ1H2FJN2nwGLPFWYt7FH+jHGA=
X-Gm-Gg: AYBFou2gtA1W7d7ZOE16G+c0XJYP1Ls3/CUCHGRTv0usH4oJSmZXc0DXd8r1lcGvaS6
	10UqQC8Ichgl8NzrEf4vQ6GFb8rQVU8LagmIw22TMfD4FEvu5U2J9p43yqKfkR3CSecMUCFx9JY
	3/+1T3oODmzWvKMv1UfLNPAc0RkqFQnQKyI5PoJE63YZpsw7b/OqHsI0/6Rp1zvRCoCSzJE+B/9
	sPJxWiRDpR4Fwwk4SqQRkhJrWAomzeRc7ImtSRDLH5PbkTAEQAs9gNQuHrVt3SqvxVYHDJelMkA
	+63qZClMLvZSc8HlrmSwoeb2rjn695fD9KANqcnweUOSGOsd2L7rVsNQJ22ycanhGXtV2AhDJRh
	Tjd/qczvawJybRr+ZgsfJYuufU5DjRx2p+NR6HrQEt0lX7UAIBwydL65kR0lVfh3gunZsTL7J9p
	GXNtewvCVGPbeagFA5KP/OVwllj5sQCcn7ovk1SFZWNz2H+0WYmQmUofYROA==
X-Received: by 2002:a53:b64b:0:b0:679:95cd:1aed with SMTP id
 956f58d0204a3-67c143e21b3mr944931d50.60.1793993787639; Fri, 06 Nov 2026
 11:36:27 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de> <20261106123510.76727-2-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:36:16 -0500
X-Gm-Features: AclHuK-fGEZaHjsdWhfPza4F5uDtlqaBhiXJPEnuzp6Iadvx1uM2j07XmDKxgU8
Message-ID: <CAEjxPJ77pUa1Y8+UgpjKCcKdjjsQ7KrATmu9AyEZCOCr-CSbGw@mail.gmail.com>
Subject: Re: [PATCH 03/16] checkpolicy: reject self as a type alias name
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:40=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> create_type() rejects "self" as a type or attribute name because it is
> the reserved target keyword of type rules, but aliases declared through
> "typealias t alias self;" or "type t alias self;" bypass that check in
> add_aliases_to_type(). The alias is accepted, yet a later
> "allow t self:..." still resolves self to the keyword instead of the
> alias, so the alias can never be referenced.
>
> Apply the same reserved-name check to alias identifiers and add negative
> tests for both alias spellings.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
