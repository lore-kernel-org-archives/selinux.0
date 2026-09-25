Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A25C4C7532
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364126; cv=pass; b=HgPpXNULqkIDuCqYaFxACYWavTm3kwUSLA+HPkf6vOm6+r8nelxvrb0CSPY8NsbdXfFYSDg8W1ujNmpMCrkLw1sH/aTyCJ5ptyzWUCBhs1oAyfs2J+lKClcgJyOyzCxWP2fiWaQNcKN69Qm3kKqkYTPE0zDY0nSLu8Xecw/vDXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364126; c=relaxed/simple;
	bh=EYE4/gN5WNkTJVdrY+f5lysLp5g9gCcwGBQNwcx1OhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbVu1n95T2B3c/d0qB/NtlbL+0TdczMqnSzBQ3PCdObi3iLiVGnYrCzNTBAPr67rNz2nLNXfQiRra5idx8hl4N6xnj3IgrsB6CskjVhJ5vLnwBTb9/JzESLDRmU6RigPnGZXM+rQ22hM7MncG2FvJSK0G6KYRQBJVOgyTp6PtCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIP481Ab; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIP481Ab"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8961cca9193so16779037b3.3
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790364124; cv=none;
        d=google.com; s=arc-20260327;
        b=eOGKPCa/18hs6VpOIzHcP4HknQ48BWPNFxymapkcCusSEbNQt9Qtyf7r+x2njC+FHy
         lp3tJ78JfdOd2IHokdptJtbMChzktK37OjIic3N+M1iZwHrU9+xhD6TaZfgzAwrHgE8c
         Hr5EcbRyVtwpGsBKWKjDncYOlC0tqAr2CAXyJ5EKPjPj+elxo+NwsFS2KLNg5RpbTvv1
         X996aMqjW4s03+oxvldZUbDWsk23XeGL4ECW+/zxOpO0Ly4NMF76I6L/LS5sChoZkJHM
         OZnDXm0nAwFV2LV98p2YOGsJDbmct+uloYHeEtJMLnEXxaxUL0FaRaY9FmdecsbhZ03j
         s/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EYE4/gN5WNkTJVdrY+f5lysLp5g9gCcwGBQNwcx1OhA=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=YEGR5znuzziv9HyeaXCJEmjsFr2+NYraXoemEYMzRRCcKWdWF+4jFra+Tr/iQwSEry
         AHE9i62G42ak6vLQ8FKWAJDuBh1ZudizoFAXkfF3ohOaN2X5EzpKp8NAMaPbj+M1a12I
         qy4Oy73tKWWJMMrnmLJeDmi/PPbw/1aMVYoPOYO+ruJpfUDKJTmElhJ8om1tI1Z6eXIj
         ILANOMumsjYpEHrVo6ng91/1uF6/Di1/MCwGAMLZ5eDI54DqJeFGTEANanxtA9aW1sVl
         K++0OCQXkYZVDOEYgzKb1aQ7VwlD8vhnNeJz9kTeKvNVNIWJVQF2yuAHX7adq4+Rbvkg
         2WQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790364124; x=1790968924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EYE4/gN5WNkTJVdrY+f5lysLp5g9gCcwGBQNwcx1OhA=;
        b=OIP481AbIPjEpxe/GKw8kI59ZxtwUGdqi5Wd0ksjjOpllBlDvr4Cs6TzoH/muzeAdE
         jGARUa09vKoc505zOQTXE8YNIPRVRUsNJEmU8c1X/BQhEyXneMbcB2xr8qwsaH9rOy1Y
         D4+lF71sYE0a0q5dyaQstVl4I8z8/EbaVqLw6UD1wTicTdd4CSTb1cxjJ3O7iATXeyKn
         g+HKilqKqYi39W5zBjYWdYxZ79bqYUny8jP3n4iu404EJbvD/0FoQ1XLWfe/u+qNfQIq
         mnOfAA9jTeMJx47SUFo/lRUt7EwzMS3/O7CFJn2whFNT9ykwwib8K+ppCOx0J/y8Zc1h
         hDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790364124; x=1790968924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EYE4/gN5WNkTJVdrY+f5lysLp5g9gCcwGBQNwcx1OhA=;
        b=o/7JDt313Md3X2oqQMDUGSWJNaTK00vqWQFbjaLTOf0NK4G/KDvNRvUk+Sfzz+Faed
         LMl0oAn5oVpDLVtYH1pS1RVa74YLYrHxphuV+EP88U3TxZQWqSxy8HOm4XkCxckQQPqC
         YR7ipcqGV9Dc/bdjPrsLmybUnUoSp2PuMGv8FSq8qPQipEvEXiu8GQLv6HB2WFaWWqbn
         F+tNcutRjxxbH+6EwzkFYOIC/VUNbh8f8hjf5OZ4XjJ9NdK5O4oxdhvULFK3jGI9s2k+
         XXE/wB+Sdle5wVTttcUApXF3cfAh0AhrJUPJTunY5m5ZSqJHwfwtEtTnOv5GVDvpFK4D
         lt8A==
X-Gm-Message-State: AFuF++lSGxdgxUkMR8mmt1KaDUvqSIpRbEFeugUDqNN7U3F50v9aHC4p
	a+5sAn71g3Tm1yor/It7My6P9lEi8Uoj/zAx0l2ibiLEPq+qJymQAcXg3b3CGP79BF3GfEoLbF3
	nXbFIvnXvxjgRLV1n/6+SudL800o5Q0sO+PFi
X-Gm-Gg: AYBFou3YunBZPz8F3DaSC6QE7a8V+SCV/5UtPArZAcWJR+xCb6sYiGqSkib37wnQR4x
	f4hlnJYDltpJ0Rw5bh74KaExaTMHtY5AJsJRFtRwjlcbKDQ5BTzyc18sp+2bGGcadHkO8X2XT4h
	qZOsLOovSIpzg6CYZjtr94rd+Tc+O4J0BArDC0NxsG+/VCJxMwPXQkHpzxlauYqNn3HOSLTPhl9
	CULpoqD5Nui0Penv1W3WEtxfwx3H0F9r5OvmqrRdI2IYeBEYjE/pW/7W0tq2Q0DwMAMyEvFkykP
	BA1tClhXco69SWNMx+3i4yoMb0yMgBS9M3NSZooOFXGHmmqFOXkWkBk=
X-Received: by 2002:a05:690e:b8a:b0:674:7847:f84a with SMTP id
 956f58d0204a3-6747847fc6fmr50849d50.22.1790364124310; Fri, 25 Sep 2026
 12:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-17-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-17-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 15:21:52 -0400
X-Gm-Features: AclHuK9KRwEHb-2l8tSbeatO_vLWtArc0K5iqmZ9ceAWOf4UMM5LDhGs912WRLc
Message-ID: <CAEjxPJ5x7rG3rVMA-6GftVMQCS0wD_5CgFOgMOe+eBVt5V_JFQ@mail.gmail.com>
Subject: Re: [PATCH 18/21] tests/filesystem: improve fsnotify check and
 preload loop module
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:22=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> fsnotify support might be missing from the running kernel.

You mean fanotify?

>
> Pre-load the loop module to ensure creating a loop device succeeds.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
