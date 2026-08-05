Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB383E0754
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912797; cv=pass; b=GjTDlgbLz+Mtn7ynWtuQ4ZmkDKfJJxsEnauyLNJEy3nu6oDCDoF/WfFrdu27vxzNuGGlPq93cxBsAKJRYWpgAvu/fjy7tXvSaZ6E9+GMW4CglCE83OqFxBsASWIYgE2Zl+4VT7KhqWa5wK3SmbG6grE6q+DBL51JF1SkXE7MrFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912797; c=relaxed/simple;
	bh=6er01vrRwkuX0+XeICrjDcghTg/CRnNxJstpHhA0JLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDg2lkVp8hHClf0vJKNthne0CnvK3Za1Ms3qfWKyQx/0KlXxbiE4/xAnpe2auTMf8glimYgzwIoQl8it6MLyk4gC2JcF1XzgFmd5PRvxL1NiZI6PtPnTgXEbHSRkoRE3ZG8NsbJcdF92fvMDiU04b0+0wljFKSXETZBdN0cmjnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFIPgoe2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQSkaSI5; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFIPgoe2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQSkaSI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785912786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xA6QCYq8hKaevbVi89k0Wm55hqDhXG/ZM69zxsx54w=;
	b=BFIPgoe2VLy4DXYbPFIRQKhk+p+TiJKVve+p+ZjNhmUTkHjNJelb0SusEHvgfSo2a48wVE
	ZG3dNl7rBfZJXllwJ4cf7ITMlYl5oodMvMu4mDBopzqCAmrdlX+PcOQ1nqauetC0Y5vPVl
	Eze9EJXXh5tL/odCnzHt+5fHzlIlEio=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Hs7gi8l7NZuFbUPmJFuEqw-1; Wed, 05 Aug 2026 02:52:54 -0400
X-MC-Unique: Hs7gi8l7NZuFbUPmJFuEqw-1
X-Mimecast-MFC-AGG-ID: Hs7gi8l7NZuFbUPmJFuEqw_1785912774
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccd1958e8fso12172625ad.2
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 23:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785912773; cv=none;
        d=google.com; s=arc-20260327;
        b=fHO/1NYvlfXwRsZ4YuqepEmVtPDrSMZoAL7ZeO5VgfRUsGHpKhUBHMYKJ88LFhaNuu
         yr5jEfM7SEPSWUHlKwvswh0MSM78wBs4Zzv7ikwuHK5ubm7LQumOZzOQXUm4AiXzOk83
         XnHXctzByVbKNVAL2YM7KLQzJZrEDzwxjrg1sRzSNV3Jjth+ZqNGQN7YqYiH3YluHDBi
         SB2poEs8xV7JpSXcyHmHKQpHYrt7DEaHPSSbPT7/ERCn+yVlXxLacSqap8UsWcpCsdgx
         AGZ2BPOGBzpqrLlmoDJAWtjx+kpxOvogfkl+zbJoyZgGa56oDutOyKUB00J/oEp0QN4W
         Tkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2xA6QCYq8hKaevbVi89k0Wm55hqDhXG/ZM69zxsx54w=;
        fh=kNXlBPu8BwQweijrLTw6/7CJlHRJ1+zBhAXh/3D3I9w=;
        b=ao0kfW5DFMPBqzESNLReE4+nVGGXc5SO9Z4UjA7bMuSyFIWmKLc7bYkaQTuvxpcI57
         W+QAlBykUfPwFfZ0Dm5lL11TS+UkeW711CrssgguqRXkAJk6RIXNb6ntoz97AkjTC3PB
         5kS6cMLAfvXaCEpeMNInsjRNtPsMPpcn/wwh/eoV/23DirVGxbX4MIa7dpraUoTY7Tll
         l4EoUBRVknJrA+2+8qoAoe4Q7rCh9Q/GzDPlovL4yVUVE5A3eOJLk9BQ9TKAuKN//HAg
         wx/8EkUGxapq5+/oKbsqvt/QPeoQw/+VsAJz11juH0UyFxzADrD4QXV3rdc0u/AeVowx
         DxxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785912773; x=1786517573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2xA6QCYq8hKaevbVi89k0Wm55hqDhXG/ZM69zxsx54w=;
        b=BQSkaSI5cAl/ta23zT8DZ5023Dctdu9N+Gu8q12DFODc+gu+h6/YcNL7NMO4hshwV+
         UFcl5HZh5jrN+w+RzO+5GldMB7s4MwGexZin1Da3obekPeDvIKbN8+M+ssXc/ONIZmun
         gy1+EMfeBp+v8jL8Pgt1RtYVug/f7ACDNYkQ36KUpviM9fBNXdIp2LeGBP9LRUjMMdCN
         gd+uoasmUJXobQUAsXqIBCqL4L2OAgiVFigvgLaLRljvJNNbnxwYOZOlj3qHPWo+wIJt
         uuNogsn9JA7pDvlEOQ5Qm0OPl+kOkavuBWqO7OnTWfSNbEo9m0KZU8ZGWv84xYxdJf67
         tkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785912773; x=1786517573;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2xA6QCYq8hKaevbVi89k0Wm55hqDhXG/ZM69zxsx54w=;
        b=bqmANX1oRzZJ4Q9dzVkCacsOv24we/bCOxpjnwyGU4jtDA9Lj+dCICGocSROItknNP
         ceujXzwr7zgpObFGlbuaJb4tH9BDgOlh7ZwGraEVlJ48MheltNMbacSenb+Z27UZldnE
         0knmKTx5xSD8MWzf/j70rEKBal7MRQGM1RVw/+Od+Ik8A0coGmggP1MSC6fW82mTXyi2
         9nVDYzIXX1oWz3bd6+diWKHLMGLy49YpaMQ7YLxNMmEdxD2lSqweGij3AxRzHWrgK9lq
         xEUgHA4Exr79uOL+yMpa9oVTz67tI8lpCUKfjHYGF7RVKUzXtiLS8gF/I6gEdM9S4J29
         jqWw==
X-Gm-Message-State: AOJu0YwUS214twwBQPckoOfBfDDlUhntPLm3FioDouNUGmA5lzkhUUJX
	gyTyQ0PHywCaXlzMBBObXjCTXvsB72QOAhOJvf1K94A3/zbgLSmvE4eXzI59HrmRNI+vJtmNHLI
	41JhdsVRXT1f3GFug6te2r0WOCW84TVgEv+/8vN8cQaIjnCsysEv8EcNnvcalOnLuNnBZBptUKq
	erlrpE3s/piQvPX0l7w27SSkZsL3X5tDEzUQ==
X-Gm-Gg: AR+sD13+p4A9Zr6ieMnqfCkCh0nrF47j7hKAM3l7DFmHsROUkj4WHJaSRz3DaG8MAvg
	Blc5y3Sn7Ue+5ykI0cnbsJxZpKCet+tWOcTEwhmXDK2wwjL7PC0wlcPJSuNC0RyCI0iKy7ZTTvd
	e5htoFCYpvGDdhkJXriZQxFMXQzoel5HM7U23/n5cZaTeG68G8CgNBvZEJSpOwtOKG+Tz+/8Kr+
	ohldMZ6abIhI2d5Pw==
X-Received: by 2002:a17:903:2f46:b0:2d0:cc92:f7a9 with SMTP id d9443c01a7336-2d0cc93025amr49198735ad.4.1785912773540;
        Tue, 04 Aug 2026 23:52:53 -0700 (PDT)
X-Received: by 2002:a17:903:2f46:b0:2d0:cc92:f7a9 with SMTP id
 d9443c01a7336-2d0cc93025amr49198345ad.4.1785912773041; Tue, 04 Aug 2026
 23:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804183911.23819-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260804183911.23819-1-stephen.smalley.work@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 5 Aug 2026 08:52:41 +0200
X-Gm-Features: AUfX_mxMaoPKw0Cn2dcwq03UZpjXfY7cVVdQsgISrgpTrAWzF6tEyB2QSGrP2EM
Message-ID: <CAFqZXNvGzqF2JYdYqkcC=8XRuS8iZ=XdPMYg0BAW295txtrNXg@mail.gmail.com>
Subject: Re: [PATCH] .github/workflows/tf_testsuite.yml: only run on SELinuxProject/selinux
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 8:39=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Only try to run the testfarm tests on SELinuxProject/selinux; anything
> else will fail due to lacking access to the API key.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  .github/workflows/tf_testsuite.yml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.github/workflows/tf_testsuite.yml b/.github/workflows/tf_te=
stsuite.yml
> index 7e3993d3..48484496 100644
> --- a/.github/workflows/tf_testsuite.yml
> +++ b/.github/workflows/tf_testsuite.yml
> @@ -5,6 +5,7 @@ on: [push, pull_request]
>  jobs:
>    tf_testsuite:
>      runs-on: ubuntu-latest
> +    if: github.repository =3D=3D 'SELinuxProject/selinux'
>      strategy:
>        fail-fast: false
>        matrix:
> --
> 2.55.0
>

IMHO this is overly restrictive - a contributor may have a TF token
set up in their fork and this would prevent the test from running when
they push a branch there (they would have to commit a revert of this
patch and leave it out when submitting upstream). I think it's better
to let it always try to run and suffer the failure when there's no
token. We could disable it at least for pull requests, though, where
sadly having a token set up in either repo doesn't help.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

