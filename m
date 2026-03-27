Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FF52DEA68
	for <selinux@vger.kernel.org>; Fri, 27 Mar 2026 01:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774573617; cv=pass; b=usfsDy7nMhgxZ7etITOYbl3rZVjQ0AoZ7eRBbYJbG8Sz3yRCSfXmZ0xTATFK64s08p70IuLOJds7qXb5O85yWmEuP3H/NhUsGRE9AVGFL9eVkFh2CuZ/YMaMDhBe9PTDmzsPjrUSRwvkzuNFXCsdTFvVSOOVy6hQ+BAzPgLWYzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774573617; c=relaxed/simple;
	bh=KeWbF+sH5V49VasvoUwepM1LdJoATosJLZoY9VySM00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjKQWpeMn8kMnioJyZ4HDd6twp2yNVp4vNKhDRDdfEVoqJj44IjBd8osNvqzbKyj92OVcSx0CTcu1Q1ieQIAy7/MN6u5mb0EvUVRdiGHmMkvWcujBVim5B62o3roXPpnQVJ3JNAiieY1Q11Wa2IHg0fc2x74JI8+AKOHZ+Rlffw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cYL8cSf8; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cYL8cSf8"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aecc6b0861so9871155ad.2
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2026 18:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774573614; cv=none;
        d=google.com; s=arc-20240605;
        b=EjTTeSWgRWbtAG1IeDRTommT49V1NMVD5gj//G2bvmzd0346Nq/wHKm+NCxhQxrkuh
         9xemBk4gOxdhrMKPrITSpPF3do7p9W8gKENVPVDfyWKTiEflfQ+GGgpiqupqhB0++pl4
         UDsB+u//ZkK+wJEoicD+CrlnbMuvCGk2mQUyfJZ4nn01Ci81rLzz+LHQ3I6k6TF1WUO7
         /WCQ+Vm5KJ3oScsX4hp/RYxAKAxfMLPjl/fY0A2oKd1xhmO2zkCzPInlBj6eO1fIFYcb
         cUuf+nOI7cPnKhHe4b86I9lSvsaKUoBPp2I3LeACfWyVpVhhlibgsJ0h1WSomenuHxwx
         +NGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NnHkamm+AEobpA8psr45RG6jMwGE1Y1ScbSXU6OCnyU=;
        fh=0SGdWHNu2GGPgzuCr2xblomFxJw9/5vq/eyyJwVteaE=;
        b=AVHo+Tslp/jrfhT5Z6kJaGnAiuskr7rJOd34nSbXn+pLxCUjR2tRSkXTVg4T+vFRCi
         rdfk1jEGLq0ZRi5Ne08ntL4fIW6zBzrXlhZRtoJgpck5Ru7kxUizKS2w0xdrRGQzIilx
         Sc66BVy2mW5Q5ZYLb9fWAmwwKznXUq/VJGuHh9srTyPOg2JQviKOoBT4a++e6Y6oMivg
         FpJdvG9DiUv5Fw7HB78kpvq5BScdgvksDl1KSgVFrCiDWi2c/aPSHbHZFnwlTawGuCjU
         oD/25CrRTXPJW9PzoqEoZB/ePoVNx5RHENsoOZg1wSpg/eU78TOvwXe7xpBzvoXphmCf
         m7Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774573614; x=1775178414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnHkamm+AEobpA8psr45RG6jMwGE1Y1ScbSXU6OCnyU=;
        b=cYL8cSf8NDB0HIRMHK4tAVG03Ua0EQnoUA01/dFQOnZPLqMoShmKMGruN+aMrYYtEp
         4ZbB9vLpk36qoIpjixi01Qg91rrF1GfkGBVOJSA9j0VhKca+cJnK6uKzeV305tYZFFqD
         jrOi4AbHQhpjC4MBYDC6jXgWbkujta7SSQ5LN+yRr11Cxf1iny012RHgPBI8iaqrfk9q
         RLSPFP/hzk05SX3kP1A1Rsnsx/HV4DINpDS25aIHT6oCcUopV1gRVSntM1DJzbqiXZFE
         iXtopPIeAGyYBmm26xAxDJ92j9KLM5NY92jzoAHSznQ0wx8UTlj7D/fRHGg/NFVbnoJ0
         5F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774573614; x=1775178414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NnHkamm+AEobpA8psr45RG6jMwGE1Y1ScbSXU6OCnyU=;
        b=lfmVH3eSs9hIG8MFFk+kYLkEm29DYXWty/JR2xlkQ+OvINNH0dyPD6lV/lRROtqrve
         lm3L9WPDbFOQe3p/CYDsenlI2aSHz89EQe5JWLHNDS1fJnFmcy1txFvD7iJoe80a17Bv
         yJDhA3q6u22JN9SfXoZwqyRXC4YhQve9fsXprVD3OoloolN4iXopOXntpO/ts4B8KX0y
         g43o5ZnIMEZvyeWGmhcb7zcj6OFDXMuM5TmSjEH1z47NU+vV8kJB8kEvS0ESQmxZh3Kl
         1BsJ29sNmOTrg3vTDhwecGoy2gi3fj3WeW04TnYWKKNyaYS8wpgRlrRJAqba72ehSfKz
         B0rw==
X-Forwarded-Encrypted: i=1; AJvYcCW3JmMtsJIiAhVzA9pRT5o7CkYox+pmBdN6ZJq/twppz/FF3RYXUWp4eOD2eiJpS/p0Awv4a/Wj@vger.kernel.org
X-Gm-Message-State: AOJu0YwwapV3VCZmsZNZLUhsLN+HU0GsOOaVurXpaXVPSK9gYZJ3dZ+g
	BBEbZkNCaYap5UwFHBlnwrSTTGfFQX0Mf409VPIz5BPhiE6HLe/TF4IkL5Cttf5zp09/8CCIXz5
	NMxkJwufK62i9CYg/wMns0Tg493FdxCg7vWp3DIqE
X-Gm-Gg: ATEYQzw+R7Ljlz41RukRJ1zadbWk+00QcWJ21SZkLEB0lXKl62SK4t2zMWkgrwIegii
	lIuJl1Z9vkH83tPBHYiEWvEZzhIYcPFLC45bxWp7cOm+oqVi9chH/3g0nChFui9zXdwO/ELHl6f
	2SuKB6P6+R1Vn6Pft6W8m8WToY31QUJC+VCmvBBinGB8moXUa64sgf56EtvZxUWxkH/EXMrYXuw
	O7r+UFKadQYsLnZEBoVAbRUD2NKlvKDNTvTriENYNOfDcEcRjrU01zVJDrkVKogbuUe6yYas5Gm
	sCWjM6s=
X-Received: by 2002:a17:903:4407:b0:2b0:6621:cedd with SMTP id
 d9443c01a7336-2b0cdd31a51mr5581795ad.49.1774573613689; Thu, 26 Mar 2026
 18:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318184400.3502908-1-song@kernel.org> <CAPhsuW5h=-BVp6g2UtHTUO8PQtbiSmqDrn0BT3rbdN4BkhQpeA@mail.gmail.com>
In-Reply-To: <CAPhsuW5h=-BVp6g2UtHTUO8PQtbiSmqDrn0BT3rbdN4BkhQpeA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 26 Mar 2026 21:06:42 -0400
X-Gm-Features: AQROBzBKwxHMqZrCazbp_EEoFhocvn47dYCOH9CjcWVrjXYp2B_xhHc7YALOkis
Message-ID: <CAHC9VhQUU9L9OTtyo+2mdi0P5jCk1RXnJBxT1+YUyywMSfLuPg@mail.gmail.com>
Subject: Re: [PATCH 0/7] lsm: Replace security_sb_mount with granular mount hooks
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, 
	john.johansen@canonical.com, mic@digikod.net, jmorris@namei.org, 
	serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 8:31=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Hi folks, especially SELinux, AppArmor, and LandLock maintainers,
>
> Could you please share your comments on this set?

I think we are all aware of this patchset, but most of us are fairly
busy at the moment.  This patchset is in my queue to review, but it
isn't something I'm going to be able to review this week.

> If there are no issues with these changes, can we land the set in 7.1
> kernels?

Given that we are near the end of -rc5, that is highly unlikely.

https://github.com/LinuxSecurityModule/kernel?tab=3Dreadme-ov-file#kernel-d=
evelopment-process

--=20
paul-moore.com
