Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F201360
	for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706659803; cv=none; b=auHuScGcIgtIV83+ri53LqMJUUonfQbQxUeWEy70K3AA9jslAsWNsK9sg1gP3UbDzlkmUhzfFWN9yjFTwaKbEW+w2xkpDqJT3Ss5NG+tGLtHj6lNWcqHSq3gy8CRHj77K1JKwPfwsRCKR/HfmPD0kLOnXEXjLUYqNJ9fvoPyBC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706659803; c=relaxed/simple;
	bh=xV6L6Ymilq/nlG7DvJBbGQsqFIg9Gci2q0NrbobrYho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4ckcsBTk0qug23d9slrtH30TMnaV2ZYj8jkwLRlgX4ObUkX8PINT3S52B0G1Uk8d7UAqhDqBVVCO8MmXRdh4n14HMqof9ba/jkjszsi3n9LGBUqSVL6BPX+48yzYKPArX64swdlE33TQSAD2jg/Aza8nhUPKhCRoq9O6MSnHVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RPzSY7dO; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RPzSY7dO"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6b69f0973so432626276.2
        for <selinux@vger.kernel.org>; Tue, 30 Jan 2024 16:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706659800; x=1707264600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKTptMC1WQHlaB5jTzHxrSzmxkkZFO1cYogZobPN9Ns=;
        b=RPzSY7dO0uW6c0UxPy5HhogAePaey+7kKKUvioFMSDeIEG7KeJ1+i562jt79dAGDj6
         SxMYTNCMfoxeVCCIKcFCeWjtNf+bVGKMlm51ilbWxM7l8q5u6NQK0tCmEuwsLsdDBMb7
         XJuzno2p0xQfgxBQ3ul05i6RG/xvfyDhTsL0cCOIWeint1IRXesJZz44OX/Yvy7+v9aL
         zRkEpxQ4IyPjxA6161ArAwt7kXcJyAm03zWUePfg23kmTHBaFRIueROjEQ3IFgP7x2I7
         AtCMYXgaoybxWHkyPxg0WcRnRACid9MFnyX57OwfzxA/wU1jEH0kIMhQRbiVFjGu4AYp
         jUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706659800; x=1707264600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKTptMC1WQHlaB5jTzHxrSzmxkkZFO1cYogZobPN9Ns=;
        b=DHSnq9vrBTlmlpnsI3K3gmgFdDhbmfXz/k/746wlaT5iAJaZkhXyfNvyeDCEOnXWvC
         4tAyNp+Rwr6DcMeczcp49Y+2cBo2u0dz0gQG4UCNbOBGDUCWoRt1lIK/MreubKXyc+mu
         PQKMXogmmpFP1Z/wLxl9wU8ftsEH3HI/yjtLebw22qo2pCNUyitgQK069rZUADNVwIno
         G5RtRxtZJxD7bGpbEVTIkv6vkydPbkUtqpEcw3Na3mTmMuQzbzH6S05Bk82rOBXXq4nH
         H+eAdDE7sOKR2yUDuEcLkN8azWdjxgpilM2Nh0PHCpswP1wC9MCBVMPiBZwS5yNLGIRN
         YErQ==
X-Gm-Message-State: AOJu0YzQnDWh33wq5LBkmiiU6N8KihA4TlMyrZv5084YEVqIPI85J4qd
	mIEuiaqX0OMcsvW/6RJn5vq7H410/xW3Kt0we952j0IksFpX6IYkoVdXspN+d6z4wZHsyHO3Uir
	PdzB/pBtwt56+DJZ+8a0dy3ExrMULbSf5hOdp
X-Google-Smtp-Source: AGHT+IE7TZMN3BC26M7jWlTTO+Fc+C+rbQ0sRDoOZRxuD6ci2eQf3EiAM2HB2KNiAmfIOHwnKdCgI5H4KOHX9zn875U=
X-Received: by 2002:a25:e911:0:b0:dc2:2d05:186f with SMTP id
 n17-20020a25e911000000b00dc22d05186fmr137948ybd.46.1706659800231; Tue, 30 Jan
 2024 16:10:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129133058.1627971-1-omosnace@redhat.com>
In-Reply-To: <20240129133058.1627971-1-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jan 2024 19:09:49 -0500
Message-ID: <CAHC9VhSzdvJ2DAgV75Tdxk+tOLuhY-vM+BTT--Mfn6xoxVKbxQ@mail.gmail.com>
Subject: Re: [PATCH] security: fix no-op hook logic in security_inode_{set,remove}xattr()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 8:31=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> These two hooks currently work like this:
> 1. If no LSM registers the hook, cap_inode_{set,remove}xattr() is
>    called.
> 2. If an LSM hook call returns 0, the loop continues to call further
>    LSMs (and only stops on an error return value).
> 3. The "default" return value is 0, so e.g. the default BPF LSM hook
>    just returns 0.
>
> This works if BPF LSM is enabled along with SELinux or SMACK (or not
> enabled at all), but if it's the only LSM implementing the hook, then
> the cap_inode_{set,remove}xattr() is erroneously skipped.
>
> Fix this by using 1 as the default return value and make the loop
> recognize it as a no-op return value (i.e. if an LSM returns this value
> it is treated as if it wasn't called at all). The final logic is similar
> to that of security_fs_context_parse_param().
>
> Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/lsm_hook_defs.h |  4 ++--
>  security/security.c           | 45 +++++++++++++++++++++++++----------
>  2 files changed, 35 insertions(+), 14 deletions(-)

Thanks for working on this Ondrej, I've got a couple of thoughts on
the approach taken here, but we definitely need to fix this.

My first thought is that we really should move the
cap_inode_setxattr() and cap_inode_removexattr() calls in security.c
over to using the LSM hook infrastructure just as we do with other
capability hooks in commoncap.c:

  LSM_HOOK_INIT(inode_setxattr, cap_inode_setxattr);
  LSM_HOOK_INIT(inode_removexattr, cap_inode_removexattr);

... of course we will need to adjust cap_inode_setxattr to take (and
ignore the idmap) parameter, but that is easy enough.  It looks like
cap_inode_removexattr() can be used as-is.  Modifications to the only
two LSMs, SELinux and Smack, which explicitly call out to these
capability hooks looks rather straightforward as well.  Doing this
should simplify the LSM hooks significantly, and lower the chance of a
future LSM mistakenly not doing the required capability calls.  There
should also be a slight performance bump for the few (one? two?)
people running both SELinux and Smack in a production environment.

My second thought is that we *really* need to add to the function
header block comment/description for both these hooks.  Of course the
details here will change depending on the bits above about the
capability hooks, but if we need any special handling like you're
proposing here we really should document it in the hook's header
block.

--=20
paul-moore.com
