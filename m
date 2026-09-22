Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B31B5519AF
	for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090432; cv=pass; b=uKCEBCo2yDt6gOT61gfOJ1D7YGeULKaaCFspZdMqVqbGLub+ca8SXza0dR/5P1wWAoF5836Z8cvv17aE2q+H7Y4nyqBhHpHAye51Ze0A32BN+3fXnng1z+TlErtmhWRc2+Zxq0OV69IiK2OqZ4lszEwBliGcsNMPTB13GhSKdec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090432; c=relaxed/simple;
	bh=wOG+RJiwOBzrs3wQ+TiuUiYTMJOFzbnMFoSfpb2M7vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SE4/GYUZl6LGa3T3IGjDIStY/QzG7vwZEoZsUQhu39wluyEZD+BG+zasE87xTMvTQA4L785eOF+suOD6p2wUB5Q1a0TxpzWP0fuvacqRh2GbLbsH4frEv/+IIuR1t4W7pMQgVxSd8yzXygdP7b6C5jbLFWC1asHVbrB4CP9yj8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXg5yp/p; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXg5yp/p"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43ac6072so1691127b3.0
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 08:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790090430; cv=none;
        d=google.com; s=arc-20260327;
        b=D+4LbFUOTSQlPeYiLX5I+a8vzx2it2E8gqTlF0RbxN2hZ2iiG2UqyGU3U9SwJEwq62
         EbJdcWT1Fxezcvw29uCAiQ2PJSB6rL0qNVvN87a41iUzzEQvvuv+lKo4jfmJZmxttfSr
         zGy1vLZ5r3K0k4RcNZlLz5QwTCBs8WDoBG9cXRIGD4Usf2FTqGW0NXNpm/0aTsOFanh5
         6U7Pa/fmpF4nxAxePLc0STuRWocblyTjHcz9tSM/bFUHSMeL1WXwcNtnQvI8Wq5k56D9
         5/C58dG6w1qUUNtVP12+yEloHX9kXv0rg27Qc2WiSwrjbtOjqifUsM1UfYTz9f66vwMK
         bTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wOG+RJiwOBzrs3wQ+TiuUiYTMJOFzbnMFoSfpb2M7vI=;
        fh=KcNbqYfh5/rp+3O/oy/Rn1Jlbpp64wJ640nU1xb/jaw=;
        b=K8zUJcfZ2y5nLhkBBjwNGLuTWKSTSHaKRRmXSKguvd5MYB+YF8ETdmmABQ8Dd578ID
         4VxcZyCZc0UVLT8mBtCOIku3Kg7Zr0qW2dKIRKoGE1P5v8xHSE1jZPhNpvgylL7HE33s
         HIx9J46ucl1Q8WGtqyhBQmb4CSw7c27JRmXakBciwdxW8eESNIkB4G33/zSf8igVbLte
         vy0oNAWjJCke0TXM0HfNSTu+Njq1m7LC9AOPOUjamKp5Z/IwyqM7BcBlm7tPHMrt5Yqe
         9qyBrFjS3NKZLmRvb9o6UxW2QviA9PY2y8Mn27gztKM9ZwEiuS1PbFK1monub/UBmE52
         EsiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790090430; x=1790695230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wOG+RJiwOBzrs3wQ+TiuUiYTMJOFzbnMFoSfpb2M7vI=;
        b=QXg5yp/pQajxCO8V/cFjGjMPGdWIrFrK97mtTm0Q/cUAUiKZ4PZmpnsM/5EvpZ/Fo5
         6JJuPXnQHESyPKf367JCT/uCEouxVE1ShUkuCkHgrCG74GHkG1JKfwKNH1tsmMOiR5Rz
         7K/suGYhillgn9jDVd2Wad18/fGDKuupw2YoKYzWEanw2nV7f/SahwHTXySFhXeyDaWL
         481W2vydeHtHAYZEs8VrEQN0naV2pIXEZq8uJWjrYBAggf5MyYDX3SO0NXUDpZTP1LrH
         XDOUUIzVSN2E5CxCWvW3uVVmc0RSWhAQ10PwZed988SNZQpaib6ouG8ulQVYWcodHItA
         IZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790090430; x=1790695230;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOG+RJiwOBzrs3wQ+TiuUiYTMJOFzbnMFoSfpb2M7vI=;
        b=xosxwClT3TSanop53lCKT+voArf/2PHn1JyqmNZlc9jsLrjkF0EHdT2OH17bJ+IihE
         fzf3QQhEQKaBDhBaWjADLc4uFnmG2nBElrCNzmKqQa6QWawsgqEV+Ul7LxF8MM/nOA5j
         nuAeQoXfaGRRzDG/hglh+bjl+VGuoYJ9zEZBHXKlS6lVDqNV6zAuB9AKov01ZwPuKUMh
         XD+gXK6cs6GsK4XbN1fL43nlUUNC3M2VgeL5WeB1mHHJIu6hLhWLWSxzAbCHRdex9Lc8
         VEHQkEMpco+bWreTiuM2xV0tUERn3zCbAB8XVmjLK6eI5Vyp/AM3r72KMdUJ9DDgWrC2
         STuQ==
X-Gm-Message-State: AFuF++ndBpAsYltB1iRnsdrvIBUmMZ7SYwIJ1x3ag8QeycOMqwiaY+uY
	hnPX9LPRXrloG/E67qv5ZdDDgQp1gzIjcYGxm7GDvbAVWJlaJD3XiecPoRlpe0O6sQa7gFfUGOu
	aiqU3pWqrd+/2btaApyUTYx1azz3HDxUzDg==
X-Gm-Gg: AYBFou0Ysa7jWmnzoLgGwMBx9j1vf3UPJtrNup8k12C8G+lM11IJ6IjazHj6U8Vq2Mr
	YbQJulHmuQmod7f7XeetHrtBrawUgg7K+0J7ecBzFaN02sNwJv5h8VrHoXh7SjYST9B4Jkp5BGC
	6ul+KGORXfmx81gnl8McjECKe99wa9JJiK62+d+ug9dm5rBAcFD33dyHvX0OzxYVm8b23wMpklZ
	v6uGoOA9/uwI/Q3TRKh6EewaNUyoSCuD/uclLZuFTP/AaSPqNkj9WCzMKfn5t986lBE5AjXFzl/
	dWMVkl5KYiBYc2UKYCrjBVLj7CuzbTzv5DhxkiRRonn9rASXHurPy6Q=
X-Received: by 2002:a05:690c:e20f:10b0:873:5c7b:c0fe with SMTP id
 00721157ae682-89736366fa6mr40629807b3.54.1790090429457; Tue, 22 Sep 2026
 08:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921195341.25227-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260921195341.25227-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 22 Sep 2026 11:20:18 -0400
X-Gm-Features: AcwNN1VaZGVjscni9FBpIT05tk1p9wsgjEAKZCgstYn84Q4dojWeI2b2IoMWEB8
Message-ID: <CAEjxPJ7Y1Ms3b8FLubwGVtf1_dVmsRmcvNGDERHmQAww4_dUJw@mail.gmail.com>
Subject: Re: [PATCH 1/5] libsepol: consolidate IPPROTO_DCCP/SCTP fallbacks
 into kernel_to_common.h
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 3:53=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Five files that already include kernel_to_common.h each open-code the
> same IPPROTO_DCCP/IPPROTO_SCTP fallback pair. Move the fallback into
> the shared header (with the netinet/in.h include so the header is
> self-contained) and drop the copies. ports.c, cil/src/cil_binary.c,
> and checkpolicy keep their own copies since they do not include this
> header.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.
