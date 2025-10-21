Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447E34B185
	for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066858; cv=none; b=gBvhxHO3z8YIYx4DTBcC1zxVNyXtQN1g8P6UaquvNS3Ec0q5hTJlRiWcUe1Jdp4nP9jyUE0qyN6fzpqpJ3pNf/Cvk5V298AWUv5JmTEuFQImRaRLpkd1tOJ4l09jjS/oZ5GNmKp9FQdTpY8RcmC931sWTEg0LfQ05IfARd/PdFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066858; c=relaxed/simple;
	bh=SY9hfEhnatNUm82gBt97teqVGp9h+Zsb24n9K//bMKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zz2c6i3ygmXtznNJtfttORtKdPhU8m64pt5H5CDsctzf3reRob3AOgLInj7991e3Ks9U0Dn0EYtor7TUxWLG7S/YEFfOvlVCYimOo1lqiouNwl+BVquh75/xovlFIm10Yvdp2OYB5hsTaMO1kFdaafw5aL17iV8A8LbNu69jsKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a4+58S0a; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a4+58S0a"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so2526227b3a.0
        for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 10:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761066856; x=1761671656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvDoyZiTO2VXbxNnIjJcYdI7LrR379gdB3mzEniFdXg=;
        b=a4+58S0ardeAaK0VIrysUV6jUdn7XMzjiuMaT+MNiIB41LqCLgesgB9eNCxpckWhxS
         1q/12xveBDaZfxyDkpVNGBJ/yb2sjI+LQNrdOK1mGxcj8nmJBYYcoqcp/AHqIHAmzAGz
         uGuLId2A2tsvhiTUWdVxl12XVVRrSzPLzvHLp6c4Uq8efmR5lanwZAnY4+0Tsv/Buo0u
         iUXvIo17nd0ImkHw5R/Cdy+IQxNpoQJpCTJhZ4HLzxUbCCiNiEyZ01K7xVafnfOr+bxI
         92lNha+YuP/6fgKezerxklgukuIEywo7g1OcpZyekN7NlqV3ACcsoEs8ZVVCc3UmSlwB
         VC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761066856; x=1761671656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvDoyZiTO2VXbxNnIjJcYdI7LrR379gdB3mzEniFdXg=;
        b=G5c9KnyuDk9F/0D8li0C3acEPibiF7TNVP3w8azgNxWY0DvcfLk02cGbT0BirtBrIM
         MJPOTRJAGqn8iMYWwAD58OrT2MkZPIQMdwIpDLJq1H2gjgXLIURKUfEDyGuh+6oLYdBy
         TjxOn9gvyscj6ce3f8k3OFqknjJWfykjEOahqhouACpfTdEjpxi4qIq30djQLUR0FeZZ
         e0YqIX6ZGv0+0RmUywVIhvamAr8RBcxSrwuNwLGTVMRdBN5ONUJCAyZLVML56kwu/rKI
         2f/IOBr4SIrue5Adoztr0Inil4zDPRXju3TeAQR72hMqeWtf0pIsnzdVvJJEMNUYzBe7
         acjg==
X-Forwarded-Encrypted: i=1; AJvYcCUwCj8Y97ajA+6rPolPYs8WpquQQtzN4khAhlmS1VZnhj9O/LyB07frfGJOL2RzfWEtSapSE4IG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9mpb2swm18Syi+/AAubAU8HPSa6Fu1bKFbQi/c5yR6PMRkJjU
	PzuzZPcF62x2ytgZSu40fappGDgDIMWwQrN/wqwFMfW9sDygX0pKAogp8K5HJ5xYFgRJkydKXfC
	xfk5U83s6kSeJbEqfhX8qhJGeADdURDPvXz1+ZUpL
X-Gm-Gg: ASbGnctcLPcFp8h2zY3H/z+zh3WxhV7nfV1XXPyRoAMYHykU8sXbKBteA/xIp3/Imkv
	C4aRPtEecG0PHXjdLIkoz1zLfdyIJ3HyMOL5UXtHKHNMqe1qKKDveD4SV+VsEDNMXKJkUgXajdd
	ubZjgZwLz7RTSlE/2YbUIeBaWlO67UfbYXq+ow6Jza8/Rm9B067+oXkSUSw1OOZf3Ijmys8sRBG
	0xDYNCQa20ukW+n9uV2KbXAqhCrQ3/DZX2CH6s2bC25gZs6TIOhcmPUrWNW
X-Google-Smtp-Source: AGHT+IF1CHH5DQLS0QXsOg+GgFtuH4E5gZhKbyMpbKK9JycZXpo5pI3t6VfHvnnOe9z0T6UvGQfRG/udThvZpXGcp/s=
X-Received: by 2002:a17:90b:2247:b0:32d:e780:e9d5 with SMTP id
 98e67ed59e1d1-33bcf8e5f10mr24053313a91.22.1761066855967; Tue, 21 Oct 2025
 10:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008234613.2150-1-ericsu@linux.microsoft.com>
 <9f91729c4030890ebd10a6faa1009589@paul-moore.com> <CAEjxPJ4SdB1xEM2zNwAW9hgdh7QqbCEOewjaR0t61QnKNKyw3Q@mail.gmail.com>
 <CAHC9VhSAiAbW_-f0BRGXPSDKMesPj=2-wyEbrtDouYpYrq7j2w@mail.gmail.com>
 <CAEjxPJ7YU71UuWDa8tVm-dJAF+wZrmhujC9M2zkf+UXB44cEww@mail.gmail.com>
 <CAHC9VhS5-5+LxEstKX=ZHNPK6RazRqejXOEOXv-UJjiNsvQ6GA@mail.gmail.com> <aa8862a8-1898-47e2-93e3-96584e7efaf1@linux.microsoft.com>
In-Reply-To: <aa8862a8-1898-47e2-93e3-96584e7efaf1@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Oct 2025 13:14:04 -0400
X-Gm-Features: AS18NWCIRcudCM5tYZeL3vFTW-zNjZhXcNXOeFAJaasYzt76L9tl_m-GIBLPQ2Y
Message-ID: <CAHC9VhR_0VP_7UHmVRM5kLPZmKQeSW3iP=NGWkEbfNFsPMqOkg@mail.gmail.com>
Subject: Re: [PATCH v5] SELinux: Add support for BPF token access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com, danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 1:04=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.c=
om> wrote:
>
> Paul - to help minimize merge fixups next time, should I base my next
> revision on the latest dev-staging branch? Not sure if this branch will
> have all the changes from the merge window.

My policy is generally that patches based either on Linus' tree or the
selinux/dev are okay, if any merge fuzzing is needed I'll take care of
that.  I think the guidance you received to use selinux/dev-staging
was simply due to the state of different trees during that particular
point in time of development cycle.

For the next revision I would recommend basing your patch on the
current selinux/dev branch.

--=20
paul-moore.com
