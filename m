Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BAE13F42F
	for <selinux@vger.kernel.org>; Thu, 31 Oct 2024 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730413234; cv=none; b=EXS7/Ntbj9Rz3LvNSxf78PzbS7TFB6mlnBXyO6WL+UQczEeUiQfWoxp7k2783C1uZ5694wDgFSg4uQrsVY9CqDjPYaqJaXRjEDZ+MSPT3ip6LptZAT2y3mg6ENk8fKECu8PUaCbae5kCnGlR5H+GlztQxRE249vWFfrhldYNVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730413234; c=relaxed/simple;
	bh=hD6FD16CqkuWDTUTgZo6lpVEDlKMOdFJ8ITeyCcqwtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5V0vup9RtGgtu4Uezy1fpbiZfwJuGzB5r0L6aTV5GvNlpG4sBwci7qJlSFnIwwuPiaYSbfOtNWnLnkQRP/p1JtwukIhvyQ5yi76ByLju4WlJfcT18gq7BOrH0OU6Y4lD5yRTJp6wkvaeQg23V/nA3oIlNkOqT9RSizQgwkMuXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CH0h5DD6; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CH0h5DD6"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso1434075276.1
        for <selinux@vger.kernel.org>; Thu, 31 Oct 2024 15:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730413227; x=1731018027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQa7r/RlLtRu4piUR195BMCUdGYG4O9N4Miv/czlIOI=;
        b=CH0h5DD6iDTYUFdJMM3Rfn6Oc9nxUpPF+83u8w/GEAs9EGSCf03VzpNb+uzNgKGOeK
         x/yVNPOCmHJOrCwXNmDVVewThw3F8PGn/yHMKbN34VH60YnrUujaOKSGdT36ENUlwnL7
         0WwlV6DeakcGCGxvKplE84Kx2evG9USAble57Oo1+17rWG/+1qYAxfGXh39wzm1IM7NR
         ashPmPCb9fS8ILtbvqNxYXWbOwKG22td6UrP+Dqal6SWCDec5y5jOLOlWQSS1SLBWeR7
         YH8eQJ8gfvbY/7076lDvePKYzlf9z6zoT6v8iNxhI8ll1+IBZm48yFI80W4wnzImINIu
         WCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730413227; x=1731018027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQa7r/RlLtRu4piUR195BMCUdGYG4O9N4Miv/czlIOI=;
        b=M+lCHvhV967wnD2augKq+iwT2i6YQq9J+Z9p3SiYpl39Jc3+fPNRzKXmZLm2VMaAxy
         AlS3O8aQaw791z/HXUtb3oEnSoyDcjgt51H+3M9Cxzz14eoRWYcf1qsV6XrlSzeJA4le
         S0QFlKWio0JPQ/67z9WSDgij8HNca7NdcQRMxKnIQXq8C9dlxMzvM+edesvZZk4tCjxz
         IpYqNwmu9xLbI1hFt7PDwjRYaJZsi2LGBcdb5nN6QdXWYg4eHP3OMK1B6xCDCUKxLpEB
         vGaNbQTPkMYTFaBZB4M7P237C4UygANQBE0nWEK5KYqyRZ98z8Qq6YncAmSayQhWm5T2
         bTOw==
X-Forwarded-Encrypted: i=1; AJvYcCXqiJfxVgRF4ky4HjbAuJq4V2cpE9mNkkzFLcuZTNmx8Vw0/hQJV4v6sQjR9dN7iEQQFQtlELn7@vger.kernel.org
X-Gm-Message-State: AOJu0YxQJMyIvMLDPpImi3V1Oy3Hj9L8MK82qt+hOCbThegvqwAqylvK
	a5Ajx7Taw5vNwOEGrcAZnIp5rb9GW1u79n9pH8t4hq5exJwSTirbriooLVIeEoTN7allVQTgVtP
	93v5uCwfe66z2OkT0Af7M6wfetbukRFwtMcPN
X-Google-Smtp-Source: AGHT+IH/kGkXG6glEIjff2VpkKyaD9IIr/q+FjANR+s08/jBcbBq/p/8Fx7nmRrY+dKCnt3meJ3TNMOP/b2/BH6X9f8=
X-Received: by 2002:a05:6902:154f:b0:e2b:d5ab:986f with SMTP id
 3f1490d57ef6-e30e5ab5b16mr5247526276.31.1730413227190; Thu, 31 Oct 2024
 15:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405161042.260113-1-cgoettsche@seltendoof.de> <20241023152719.24118-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241023152719.24118-1-cgoettsche@seltendoof.de>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 31 Oct 2024 18:20:16 -0400
Message-ID: <CAHC9VhQ+SmaYB-1zz2q9j1XJeAFaY+emn_KoNiXxqJDt6wjT0w@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: add support for xperms in conditional policies
To: cgzones@googlemail.com, selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Jacob Satterfield <jsatterfield.linux@gmail.com>, Eric Suen <ericsu@linux.microsoft.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	Canfeng Guo <guocanfeng@uniontech.com>, GUO Zihua <guozihua@huawei.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 11:27=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Add support for extended permission rules in conditional policies.
> Currently the kernel accepts such rules already, but evaluating a
> security decision will hit a BUG() in
> services_compute_xperms_decision().  Thus reject extended permission
> rules in conditional policies for current policy versions.
>
> Add a new policy version for this feature.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>   rebased onto the netlink xperm patch
> ---
>  security/selinux/include/security.h |  3 ++-
>  security/selinux/ss/avtab.c         | 11 +++++++++--
>  security/selinux/ss/avtab.h         |  2 +-
>  security/selinux/ss/conditional.c   |  2 +-
>  security/selinux/ss/policydb.c      |  5 +++++
>  security/selinux/ss/services.c      | 12 ++++++++----
>  6 files changed, 26 insertions(+), 9 deletions(-)

This looks fine to me, but I believe there are some outstanding
userspace issues that need to be resolved?

--=20
paul-moore.com
