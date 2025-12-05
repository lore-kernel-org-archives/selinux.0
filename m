Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CBC310624
	for <selinux@vger.kernel.org>; Fri,  5 Dec 2025 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764924625; cv=none; b=MqFW/UhHX/V+B7y8+Q9GXUhSYzQIv/0mnk1icBQ9VsvrT7nH9N1QWFT6LiWaBrYoXX4NS7qt3aqaBD6m2TKZ6xULXR06+mBb8k9xYY4Nx+EDc9aklX1l8P/rIveyAU0/cIwK4QjtekOi+YpGYI7nxEx/BZVMHmyr5hE3wDQzYI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764924625; c=relaxed/simple;
	bh=umtlRGx5EL/Darbl/2rxiYcpP31JcGWYNq7tr1JvXJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8ycK+TIx8+sfEi0SM2nepyM72FkSll5Hw3dx2Xi+vniB49xjezYWD/JhZqC92XjyOk0tXcSLpyCRqVw+tE9oNdCG2w7ZkIyVRypJPoh6xhn/Ly1WCwbWI3IEOTfHxkjAAqaelS8TKyxnFBwR/fOGDxmIP5NRoYJ3L7sAS/x72o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OG+3QOFK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n2gQ5eBN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OG+3QOFK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n2gQ5eBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764924618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mu4vhDBoG/9WX9EFo4RIO76XRCI3bL/HXhvs+9OJge4=;
	b=OG+3QOFKGdFjG5A3cwQBEMvOBAAcUHRKVwt2NgKElJFrR1V3In5aJpzl2+57M3UJi8FvDP
	fkwb0+kHLFjEKxOfesMLXnAUTwesI754rl7biSoAl0WP0YlbENPe2/T1HFZgudNo9H31cg
	GE8rDV0anYW3sBxypi2IURi4gPRuNNM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-3M8W6yXpMtu3PRhV3W0diA-1; Fri, 05 Dec 2025 03:50:16 -0500
X-MC-Unique: 3M8W6yXpMtu3PRhV3W0diA-1
X-Mimecast-MFC-AGG-ID: 3M8W6yXpMtu3PRhV3W0diA_1764924615
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-343e262230eso2330962a91.2
        for <selinux@vger.kernel.org>; Fri, 05 Dec 2025 00:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764924615; x=1765529415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mu4vhDBoG/9WX9EFo4RIO76XRCI3bL/HXhvs+9OJge4=;
        b=n2gQ5eBNROTJphP3Uc9b/wJikltdttBENQvvHaf0iaYKWq57ft8/oQdE0Aih9lbKT7
         BSNAi2+uOxXZ1kWGdlIbwM3u7KC+XWvyh74pUUjPW+pseQPpLucuh4UbF8xOGoQ+KFFy
         4NrGfVrK0FQSuEAOSSkOJXYN7qO9++cA48b6Wg/VMHqU+9ndni29sKvSX5ihuKCsrCIo
         X7NvVdJ+I+s4bRHS/njGQPBTUdW+/uxKOxshyP5MltVjo9aaUlCELhi3R/CIPh7Q7fH5
         TJ0F7kU+5QjnCRxkOlHAqIwrRJ277WJX3BaXnmNZXQFFDz8LtTU6vDhfqd1PSgb3vrG5
         bEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764924615; x=1765529415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mu4vhDBoG/9WX9EFo4RIO76XRCI3bL/HXhvs+9OJge4=;
        b=XvnP1zu4antRv7ssTE/uatN2EQXyCyNXFpq3eCsLNzT4AFeLvTlpy5hejQ3KpbWjf1
         HohCiuZIGiLT5BnatsdTvAyInrAqe+jIOCnVZg7h/SWDxypmepfSIDHYtkdKPrz6Pluk
         nVDHCgcDK50eeTlMkya2F/EMU0yatPAsMz8cRb1zsa0ARGxf78zcstl+7qA92/R7DBUs
         1sO6IZ+PlaylHmskDtdwLzpHxngzQULpFe563aWrdjC8Ut6/U3sKCuwqtedNI4xYQBDf
         cjDmocbbn15tWEvddxwJgl+rCBSPdhgHQAj6QSF9q7cBjHWnd6YaE5bor4d2IMeLRsCQ
         XEdw==
X-Gm-Message-State: AOJu0YxlaXiKpZkLJtoM9PtzvB+eyQOCtU1DvZENFVsv41TU7khbHQOh
	Mij4J5vuA1ZrRiHbnVWoiLLFTBU558H2fFd40IKH1xjBH7ZCpJq+zIsjMKmZ/18xIFxVTfHAPTn
	W0NUsobHuxiIdO9izWxDCf2iYLoSRsNI5XTc/MWGcZG+QBJQUPeTorL39g9VXiZzRl268G1I5uC
	/jBPCigGmmRGUc5INkBt/KmgAxQrjpZfNvhw==
X-Gm-Gg: ASbGnctDX9uZIj4nYvBTlkDp+AASCa+jBBwax/I9kK8baVpzmtq2Fc00B4egQc66Pz/
	nCIcgVMsSSZDQWzu+MdhbHcv7J9pkb32Xy5onjY4YJbP7Ewwk4W1nf+jZsAJ2sEm6NoYjy8bEmH
	CvRuPB0sd2dzo4OZv5Ej5gNG3I4xoCJa/KjRujj+6UabQeIQLiUCmnUTfiAJsztfwljEGP14OkM
	rFEjRhHoe64uWE2RAko7wYmwVk=
X-Received: by 2002:a17:90b:5101:b0:349:7f0a:381b with SMTP id 98e67ed59e1d1-3497f0a38cfmr722897a91.8.1764924615552;
        Fri, 05 Dec 2025 00:50:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxpl8nhnsm5A0Jf0tNdztoBLeKfKGGFhMtxDcEJNxWg5wU0TFBdOzIF/jbehPxHYjViqqf2YHleDsPoD3CxZ0=
X-Received: by 2002:a17:90b:5101:b0:349:7f0a:381b with SMTP id
 98e67ed59e1d1-3497f0a38cfmr722869a91.8.1764924615172; Fri, 05 Dec 2025
 00:50:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSaM6Hkbe+VHpRXir9OJd1=S=e1BB3zLkSTD+CXwXaqHg@mail.gmail.com>
In-Reply-To: <CAHC9VhSaM6Hkbe+VHpRXir9OJd1=S=e1BB3zLkSTD+CXwXaqHg@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 5 Dec 2025 09:50:04 +0100
X-Gm-Features: AWmQ_bkqx9hXWJfAa0OD0GP1AsTD2CoA7wXj3vHVaodmsfNKvjiCR2RIZwD1OvY
Message-ID: <CAFqZXNvL1ciLXMhHrnoyBmQu1PAApH41LkSWEhrcvzAAbFij8Q@mail.gmail.com>
Subject: Re: overlayfs test failures on kernels post v6.18
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-unionfs@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 12:46=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Those of you running tests on kernels during the merge window may have
> noticed overlayfs test failures in the selinux-testsuite.  I just took
> a quick look and the failure is occurring in test function sub_42() in
> tests/overlay/test.  That particular test is expecting a file type of
> "test_overlay_transition_files_t" but the actual file type is
> "test_overlay_files_rwx_t".
>
> I only had a few minutes to look at it just now, but there were a
> *lot* of overlayfs patches sent up to Linus for this merge window,
> most of them relating to overlayfs credentials (moving to scoped
> guards), so it is possible there are other SELinux/overlayfs failures
> as well.  Has anyone else noticed any odd SELinux/overlayfs bugs in
> recent kernels?

Didn't notice any other recent bug except the newly failing testsuite
test, but I managed to bisect that to:

commit e566bff963220ba0f740da42d46dd55c34ef745e
Author: Christian Brauner <brauner@kernel.org>
Date:   Mon Nov 17 10:34:42 2025 +0100

   ovl: port ovl_create_or_link() to new ovl_override_creator_creds
cleanup guard

I can't see anything obviously wrong with that commit, though. Perhaps
the author/maintainers will be able to spot the bug.

SELinux testsuite can be found here:
https://github.com/SELinuxProject/selinux-testsuite/

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

