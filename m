Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F97433CD
	for <selinux@vger.kernel.org>; Fri,  5 Jul 2024 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720199477; cv=none; b=EtVFo4m+EnsPmwE9m+3bnld4+yYJDUg7evUCfYt6pQKL1Mg86K4C5dIVA1+fezYII3RniUmxKUaZpZiRRceyIpBDuO9m8vC0VfDxwF5bbDRGKhokUxMtotLJcUx+ozgm7a8hf6pJbDKvWcvLOnfqwPMKdoBQd7xO8s9dO6C5r0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720199477; c=relaxed/simple;
	bh=uFoZhI+y8PqW89rv42XL15MiRKjZkSfGtLddBoynQSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4K8bFxNztD1G1hwV2bzNa/AIwejfASWYd0X1EiZ5am6Ek3K5FBEm/9kSjG7esSmu+cQhW5o8iAjQTZ+Wvsnl0NTZoAVD7Rhi4i1mIiXd4Pv6ZNysG2e8fRZqOg/1XcRy2JvH47b530JUNqw63X04ZzMlrhALzdRKHQpl9APpSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KADqoiAg; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KADqoiAg"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-651815069f8so24860877b3.1
        for <selinux@vger.kernel.org>; Fri, 05 Jul 2024 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720199475; x=1720804275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84qVFb2nDbAUCwkzyJJKS1FbfelcLQzwoo/l877IkBU=;
        b=KADqoiAg4JLLNSHgthscqMRHcYvIF/m8qiySEaTO419mtjkzQXlO3+8oJA8JIYSCj7
         Rg6VJXYPc4NeqE+x2VmOjELBXiKUtXIeR/49UD2D37zd2lNlZOlcJlX+mm+VwdYUoJBt
         QAIYwGFzaS4NIz2QOn2NusdWxflNjJEsu+Yf5de16k4j8yc3aSVsBmmSh7fjn/ZrJzCl
         LkmC9jvGAeAMXPJub0/BjX2CUsMcC4zyAv0rKpVm6mB5VBRBjLhEu+IwGUdF93dcAAgs
         1S3EvE2xqXxtCllq3QKR6W0yVNPAfuzUaprMDuPwftMEsyfjuCyVZPcBT/vM82KTsd6a
         0isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720199475; x=1720804275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84qVFb2nDbAUCwkzyJJKS1FbfelcLQzwoo/l877IkBU=;
        b=XSW03it4FnOd2hQEMg4Fa5hgPDP/W4w/K7QQvBQoB1JQ7qBy30XPCRPittUrgHZIKa
         DZztKxI0m8yK0bl5Y7oNJj9e+7nNbbsJ6kzD6nkQ+qXG9cS5rxd/gMvgpAIyJpbutEYl
         e4MJdPz4uMOsX7P5Lusempt48IZie1xS3PhBYAQt/xNjDTN+24dg1Ogrj1+Briu0gAo3
         wccHM7Sxtx9SDoFwTM9dtA7SX/SdNNRF8f4VEZ+FRJgvHX5MkTRPdtNAVdoyUoEcv9t7
         EIewIR76j3BAz10AUV8UUas570Gx9+WGnVA3oM1u9L08M3zuLok7PoPQNkhcPFmPpwLP
         fYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW82MgckuK0zoOsfAqWURqAySu3e4leQtubKnbyDr72OIVS+inahy7YpqH1SX1IWP/Qh2DdODi3Si7VMikCzK4Y/F4hPW9T7Q==
X-Gm-Message-State: AOJu0YxnDPrF7rp55p1ZvdW1uJNPMvcaib9dzZWWuXZYDDoDRPfGjD1B
	BZ2UAl4Spbi59ybhznmebhUJlZaOPWH/x/8BMm+Qz0wYX1ArMa+TVBwxhhwh9Zs71P9fOwE8+Bc
	cnTfhE6jWU4iPHtBbcbm3RMBEsOD5rHih6j6U4d+u9PlCjOk=
X-Google-Smtp-Source: AGHT+IEUehfLkP/b0qCwvoZnMsa8LDPHzos4+YAaeUMFI2pMvO/QgLHw9mWVUzg3TySRzEnKB7mNaQ+fUn5DhyQgIc8=
X-Received: by 2002:a81:430c:0:b0:618:90cc:bc4a with SMTP id
 00721157ae682-652f8184b19mr27843367b3.26.1720199474812; Fri, 05 Jul 2024
 10:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703211134.349950-2-paul@paul-moore.com> <9335721c-db66-43a4-8fc1-078d94550a0a@schaufler-ca.com>
In-Reply-To: <9335721c-db66-43a4-8fc1-078d94550a0a@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 5 Jul 2024 13:11:04 -0400
Message-ID: <CAHC9VhR6Xdo9tMnbDpJ=1F8YraPGvnrUjw9okYbxo88gbByOwg@mail.gmail.com>
Subject: Re: [PATCH] selinux,smack: remove the capability checks in the
 removexattr hooks
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 7:13=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 7/3/2024 2:11 PM, Paul Moore wrote:
> > Commit 61df7b828204 ("lsm: fixup the inode xattr capability handling")
> > moved the responsibility of doing the inode xattr capability checking
> > out of the individual LSMs and into the LSM framework itself.
> > Unfortunately, while the original commit added the capability checks
> > to both the setxattr and removexattr code in the LSM framework, it
> > only removed the setxattr capability checks from the individual LSMs,
> > leaving duplicated removexattr capability checks in both the SELinux
> > and Smack code.
> >
> > This patch removes the duplicated code from SELinux and Smack.
> >
> > Fixes: 61df7b828204 ("lsm: fixup the inode xattr capability handling")
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks Casey.  As this is a pretty minor fix, I'm going to go ahead
and merge it into lsm/dev so it will go up to Linus during the next
merge window; if anyone has any objections to that please let me know
soon.

--=20
paul-moore.com
