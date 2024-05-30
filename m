Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41F917D364
	for <selinux@vger.kernel.org>; Thu, 30 May 2024 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070263; cv=none; b=Eol9qUc3lvzp7sS8bVpaJSIyjAoOehDxGdp+I23tSVvFDVh8X/zohvNTvflIUDqz2uK7/gMOVZ8HWWjIeyWKikyeoJWL0sDGQ49QG2TfVBWFncbnhMYB/QINpeUJOhSziXxL58tXpOVbCNITTG3FT56k+V5RxRIQJ26nDna4mxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070263; c=relaxed/simple;
	bh=JhhN5gCVPvGPrPq2PN43b5TdaPUoaPxEIzEDA/d2iiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5CazytdeBZoOhJ06kVunCSv42LXfKeqKCpOaVy89AI4D8SNgTGKvy+on+gOeTyfomKdG+9lzrB3gAJv9iYxsWsRVIctm+Ngu7l/noahccGXCUcaiKaBcHj1BfppBPnIPZijjgtZdbOm4zY2ySGEJToPxh9hZtCW8Ku+b5oYVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7juLKue; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7juLKue"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2bf9753a00fso582815a91.3
        for <selinux@vger.kernel.org>; Thu, 30 May 2024 04:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717070261; x=1717675061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhVib18Ab9yqx0g2AAhNYLKyyZhYGgQu8G+AuwymFIM=;
        b=B7juLKue5mKFxQUDk9R9QdNJl+llGQUlknk0A00seCxQ41OVV/Dt5iz5eGc04RT3Jb
         X24D2TEvPk5ts6Oo+ngskr2iFsaKmlV7uacMzBiXCIHarUGiIPpoEsL6OHGBFr1rNw3R
         vC0a/PHbeXzBq0cs0UUR+nlyV9+USHjzoLMohD0FEesAIoamiEb/nUrVTNfXj2hGEDbA
         jgXjR+VHgamAOC/jFaDmgBYlcia+q7iZ+RWGaN5mOrSbjt0iKcRTi4KCF8fsjdiQwRQH
         XqLrVRY3WqUjLwK9BP/0dglxm975plWo/pbGJ5vOYa6G5qMDIhEk3zYglF8/hMZYfJmH
         9rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717070261; x=1717675061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhVib18Ab9yqx0g2AAhNYLKyyZhYGgQu8G+AuwymFIM=;
        b=u2QkoM3m6QyEoW2N12pfsNFOg9lkw9BKqDnWCxawAePW8PJ8vle9z8IP2aL7EOM9j0
         1k4GbNjsAwk8VOP58xwnTXgczjdL+5YbL6cpH6av9cdLVpxZpXP61COs5yKmozG6armo
         4ouffS93yVIA4EKxGYTwPKEyp2dmTk/Tapm12e+g2unce+2n+JOEQ3NXScd0/WNpnLFV
         ox68AfgHZNFVSuH60RApjMqQI4SpMGxegnE1EFcQUjrKcpF3cjmvyh2rco2IylXOC8ZO
         cCMg9l4Xp9Cy2xMGzSUIAWXMa6el76sRf9q046GFuDM8R4GM8qW6Rl6VUIc4rXn1YNGU
         EZ4A==
X-Gm-Message-State: AOJu0YzgAMNdMfIM9Xdq+lT4R48MLKQWNzYqFmK2iID6uvjBko0H179o
	lA4smQD1NrlL65uxCTuwSGMVw9rTu0WLG/zWFw3O+UeSEe+9qjFX/g0/85McZ3QUOsiyffJ5W4v
	Xh7GvvLHQwX+ELrhKKEeSR7iATvI=
X-Google-Smtp-Source: AGHT+IFMVyVKQ9n9kXz9QhtPiYQRzf5JNwBq3Q+hbgTKhorSI8WfUoy1if4gltDUTFSTLPYgZWmS4JzYPhn9qQRNaAo=
X-Received: by 2002:a17:90b:17c2:b0:2c1:9e9e:a74b with SMTP id
 98e67ed59e1d1-2c1abc4c95emr1666707a91.44.1717070260863; Thu, 30 May 2024
 04:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529140306.6663-1-stephen.smalley.work@gmail.com> <CAHC9VhRFSbkvpaGioW2o=FTXRDMvUbmBAoRif_R-9mX5Ns3o9A@mail.gmail.com>
In-Reply-To: <CAHC9VhRFSbkvpaGioW2o=FTXRDMvUbmBAoRif_R-9mX5Ns3o9A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 May 2024 07:57:28 -0400
Message-ID: <CAEjxPJ7N3d=Mj_VJbqOmUfNV2LthQm2mZxhAEaiE2HccM_GWnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools/nfs.sh: comment out the fscontext= tests for now
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 11:27=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> Thanks for the additional info in the patch description.  I think this
> change is fine, although I have a slight preference to simply removing
> the dead code rather than commenting it out (a small comment can be
> inserted referencing the change if that helps), but ultimately I'll
> leave that decision to Ondrej as he has been really driving
> maintenance of the selinux-testsuite for the past several years.
> However, Ondrej hasn't been responding much on-list lately so it is
> possible he is away for a bit; if that is the case I would say to go
> ahead with what you have and we can always adjust as needed later.
>
> Regardless, thanks for spending the time on getting the NFS tests
> working.  I wonder if this is something we could get working in the GH
> Actions CI using NFS over loopback?

Yes, that should be trivial - just need to ensure that it installs the
additional dependencies identified in the README.md for testing NFS
and runs ./tools/nfs.sh, which starts the nfs server, exports to
localhost, mounts it, and runs the tests.
