Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B50914F70
	for <selinux@vger.kernel.org>; Wed,  5 Nov 2025 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369262; cv=none; b=id6l6SQoly+0DI2QsGbtTi9AZHfFgJuqdxLVusOlmtn6H0Gg/snoScrG4WBH0IUXBAZ22MbzNwEjCGIqnuIVkCSfAHMDLZl8QurJeSqf+gg95lUPqwJWTfGsTu7UjKeDTtZH/Iuim6jw2gRrsPdfvloXsNtXS9Q9EzrWgUeTruU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369262; c=relaxed/simple;
	bh=ClNuJ1Y6XYQmkAmt7nVz3o3mLNe9u2TbsH6ZJxaC8YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+PD8CEop8oU3MFEUopGzwrsRTMrijXz41D912W9RdgFoRdvDArJxjMoON7MKG7EkhOrsdlFLR3uOjylW9NMKX8x2DGhi8oAgW8hrhdIceweebxROKM2OUNXbqf2gpNg9aSKUWkJPyOf/LsGDdBORYuQ8b+7UR4Z0Z3T7AhZKDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmBwfaY8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmBwfaY8"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34088fbd65aso236979a91.0
        for <selinux@vger.kernel.org>; Wed, 05 Nov 2025 11:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762369260; x=1762974060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yq2Ky4t7cfMyyVkj8/URnOlqBTnSkjkMnycGsKvT2+M=;
        b=JmBwfaY8ko1NadqnvP3mLAVV3F2LFsqKlANttDl7SeK+qq1kwByrVy3QkD77fxkoK1
         TUBPq3fM7WMHPezyLMzsRYyFTBllGzDFa4ndWTKp418tGgbHqwY+/7eVeoEcCDp0VuH1
         nMGe8nfSb3vMw+6l4kWcQ+dUgSToAEpfTnAtx1YpIS4AzoOYzlNfu6P9vT3LQUgtRgLj
         7RWkuIP98ktlckWO0fF/rjjDqcYw1mNGFmMe+bxlbU9Pc+yEtP5Gom1kWnBVwJZNrdx/
         bPJaGs8PlpmgBd2VBBu9QU0APIJ1b2q9Y2uxGbjzBmKLDilWJ2TYrA4+V7CUQ868IZRq
         wYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369260; x=1762974060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yq2Ky4t7cfMyyVkj8/URnOlqBTnSkjkMnycGsKvT2+M=;
        b=M9STkDnujiFMe15+A+gJKrDPlA61jYKn8iwJCoJy1UADZ5hyzbTqK5BBdVrmCQ/SCn
         LNR1OfJpYXagFgGbjYwAWuRbPRGOMe3QtZOlQ4nxlhJRzbCsdhgzSftCbgc5FSDmRS1i
         IaAMNZtM+BE8DuL9uMy6boVAJvBNEpMmT7E4ogivw9gbz0uDmp14R/es7cQn5aUU2IPk
         jOp9FSdsWwEHmg14+pTdmYXyXvqAGD0jeT27nRNjpFHeqk4vSw2TLBxTmmmACDO/UN18
         n/NitlrL40rXTVvbRQgGsW4AyXaBY4SoGlzmUiafw6zF+KiwIg5K1uwWTphJBFlsvM76
         zZBw==
X-Gm-Message-State: AOJu0YzZz/NHdKGZHvfWu95Y9fssF2cDJZ6DJfEe0KEQ1wupmDEPiGdr
	A6EhcMsCcReVPMZ6rq7yVuxWxRS07qZw6uvXT0tjxebpIdBHAdSoo/lSMQ25sApPxq/8y4vzSMV
	35JIQsN3meroC0fQOHCSugBjIk9h07Zk=
X-Gm-Gg: ASbGncvNmhNU5Qbx4814cWR+CSXB/YmD5krlMjozuJjUOcQJudd7G6iOFLrdnxEY3GB
	IASqP+hQroMk2S5LBJ5+lUJ8HsXhKrKCDCRw5UOL5d8At+HtReakbz8N6Zp6D7ZeGFbv8TPUafM
	P6WzM75AuboIcAZYv6qdqciu1wAzc1BScnHJHGvjzc7JmFZSMQdYg9D0hNzx66RPKnUrh/b4W7X
	bO3Qbz6geUIJS4GAi6Rcju1ABL0b+2j/mg26GHL0J3Q1/SJuuP9GEgIhc9jBUIX5e+V+F0=
X-Google-Smtp-Source: AGHT+IF4zBcYZMfRSB+DnDF4ZCaq1db6erxjGoot5ZhF7mVdcSokY5bWHY9sp3tqRMCkQIsE1mFwlyiHyv9X66IOvew=
X-Received: by 2002:a17:90b:4c92:b0:329:ca48:7090 with SMTP id
 98e67ed59e1d1-341a7009d01mr5213644a91.37.1762369260353; Wed, 05 Nov 2025
 11:01:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104205236.60931-1-jwcart2@gmail.com> <20251104205236.60931-2-jwcart2@gmail.com>
In-Reply-To: <20251104205236.60931-2-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 5 Nov 2025 14:00:48 -0500
X-Gm-Features: AWmQ_bk-AUR9HxaGT7c8K5q-lQ0_Feshl-ejLyVhoCO8G0O5WhGClkSg51P79hE
Message-ID: <CAEjxPJ5F7CQL26n_LzhfVeaHu4JX3_NmSzTLJObDP=yvTvZjAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkpolicy/tests: Modify tests to check handling of
 initial sids
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, russell@coker.com.au, 
	Chris PeBenito <pebenito@ieee.org>, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:52=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> For policy_allonce.conf and policy_allonce_xen.conf declare the
> first three initial sids, but only assign a context to the first
> and third. This will cause the second initial sid to be dropped
> from the binary policy and cause the handling of a gap in the
> initial sids to be tested.
>
> Update the expected and expected_opt policies to reflect the new
> expected resulting policies.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  checkpolicy/tests/policy_allonce.conf                  | 3 +++
>  checkpolicy/tests/policy_allonce.expected.conf         | 3 +++
>  checkpolicy/tests/policy_allonce.expected_opt.conf     | 3 +++
>  checkpolicy/tests/policy_allonce_xen.conf              | 3 +++
>  checkpolicy/tests/policy_allonce_xen.expected.conf     | 3 +++
>  checkpolicy/tests/policy_allonce_xen.expected_opt.conf | 3 +++
>  6 files changed, 18 insertions(+)
>
> diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/po=
licy_allonce.conf
> index 4b1edb4f..5e09f74b 100644
> --- a/checkpolicy/tests/policy_allonce.conf
> +++ b/checkpolicy/tests/policy_allonce.conf
> @@ -7,6 +7,8 @@ class dir
>  class file
>  class process
>  sid kernel
> +sid security
> +sid unlabeled
>  common COMMON1 { CPERM1 }
>  class CLASS1 { PERM1 ioctl }
>  class CLASS2 inherits COMMON1
> @@ -64,6 +66,7 @@ constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D =
r2 and t1 =3D=3D t2));
>  # sameuser will be turned into (u1 =3D=3D u2)
>  validatetrans CLASS2 sameuser and t3 =3D=3D ATTR1;
>  sid kernel USER1:ROLE1:TYPE1
> +sid unlabeled USER1:ROLE1:TYPE1
>  # fscon statements are not dumped
>  fscon 2 3 USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
>  fs_use_xattr btrfs USER1:ROLE1:TYPE1;
> diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpolicy=
/tests/policy_allonce.expected.conf
> index 17eff98c..a88d8785 100644
> --- a/checkpolicy/tests/policy_allonce.expected.conf
> +++ b/checkpolicy/tests/policy_allonce.expected.conf
> @@ -7,6 +7,8 @@ class dir
>  class file
>  class process
>  sid kernel
> +sid security
> +sid unlabeled
>  common COMMON1 { CPERM1 }
>  class CLASS1 { PERM1 ioctl }
>  class CLASS2 inherits COMMON1
> @@ -72,6 +74,7 @@ user USER1 roles ROLE1;
>  constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=3D =
t2));
>  validatetrans CLASS2 (u1 =3D=3D u2 and t3 =3D=3D ATTR1);
>  sid kernel USER1:ROLE1:TYPE1
> +sid unlabeled USER1:ROLE1:TYPE1
>  fs_use_xattr btrfs USER1:ROLE1:TYPE1;
>  fs_use_trans devpts USER1:ROLE1:TYPE1;
>  fs_use_task pipefs USER1:ROLE1:TYPE1;
> diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/checkpo=
licy/tests/policy_allonce.expected_opt.conf
> index 6b0f73fe..3d21c310 100644
> --- a/checkpolicy/tests/policy_allonce.expected_opt.conf
> +++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
> @@ -7,6 +7,8 @@ class dir
>  class file
>  class process
>  sid kernel
> +sid security
> +sid unlabeled
>  common COMMON1 { CPERM1 }
>  class CLASS1 { PERM1 ioctl }
>  class CLASS2 inherits COMMON1
> @@ -72,6 +74,7 @@ user USER1 roles ROLE1;
>  constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=3D =
t2));
>  validatetrans CLASS2 (u1 =3D=3D u2 and t3 =3D=3D ATTR1);
>  sid kernel USER1:ROLE1:TYPE1
> +sid unlabeled USER1:ROLE1:TYPE1
>  fs_use_xattr btrfs USER1:ROLE1:TYPE1;
>  fs_use_trans devpts USER1:ROLE1:TYPE1;
>  fs_use_task pipefs USER1:ROLE1:TYPE1;
> diff --git a/checkpolicy/tests/policy_allonce_xen.conf b/checkpolicy/test=
s/policy_allonce_xen.conf
> index 6402683a..dfdf979f 100644
> --- a/checkpolicy/tests/policy_allonce_xen.conf
> +++ b/checkpolicy/tests/policy_allonce_xen.conf
> @@ -6,6 +6,8 @@ class dir
>  class file
>  class process
>  sid kernel
> +sid dom0
> +sid domio
>  common COMMON1 { CPERM1 }
>  class CLASS1 { PERM1 }
>  class CLASS2 inherits COMMON1
> @@ -53,6 +55,7 @@ user USER1 roles ROLE1;
>  constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=3D =
t2));
>  validatetrans CLASS2 sameuser and t3 =3D=3D ATTR1;
>  sid kernel USER1:ROLE1:TYPE1
> +sid domio USER1:ROLE1:TYPE1
>  pirqcon 13 USER1:ROLE1:TYPE1
>  iomemcon 13 USER1:ROLE1:TYPE1
>  iomemcon 23-31 USER1:ROLE1:TYPE1
> diff --git a/checkpolicy/tests/policy_allonce_xen.expected.conf b/checkpo=
licy/tests/policy_allonce_xen.expected.conf
> index a4573ccb..e72517f4 100644
> --- a/checkpolicy/tests/policy_allonce_xen.expected.conf
> +++ b/checkpolicy/tests/policy_allonce_xen.expected.conf
> @@ -6,6 +6,8 @@ class dir
>  class file
>  class process
>  sid xen
> +sid dom0
> +sid domio
>  common COMMON1 { CPERM1 }
>  class CLASS1 { PERM1 }
>  class CLASS2 inherits COMMON1
> @@ -56,6 +58,7 @@ user USER1 roles ROLE1;
>  constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=3D =
t2));
>  validatetrans CLASS2 (u1 =3D=3D u2 and t3 =3D=3D ATTR1);
>  sid xen USER1:ROLE1:TYPE1
> +sid domio USER1:ROLE1:TYPE1
>  pirqcon 13 USER1:ROLE1:TYPE1
>  iomemcon 0xd USER1:ROLE1:TYPE1
>  iomemcon 0x17-0x1f USER1:ROLE1:TYPE1
> diff --git a/checkpolicy/tests/policy_allonce_xen.expected_opt.conf b/che=
ckpolicy/tests/policy_allonce_xen.expected_opt.conf
> index 8fd3b226..932ff1f8 100644
> --- a/checkpolicy/tests/policy_allonce_xen.expected_opt.conf
> +++ b/checkpolicy/tests/policy_allonce_xen.expected_opt.conf
> @@ -6,6 +6,8 @@ class dir
>  class file
>  class process
>  sid xen
> +sid dom0
> +sid domio
>  common COMMON1 { CPERM1 }
>  class CLASS1 { PERM1 }
>  class CLASS2 inherits COMMON1
> @@ -52,6 +54,7 @@ user USER1 roles ROLE1;
>  constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=3D =
t2));
>  validatetrans CLASS2 (u1 =3D=3D u2 and t3 =3D=3D ATTR1);
>  sid xen USER1:ROLE1:TYPE1
> +sid domio USER1:ROLE1:TYPE1
>  pirqcon 13 USER1:ROLE1:TYPE1
>  iomemcon 0xd USER1:ROLE1:TYPE1
>  iomemcon 0x17-0x1f USER1:ROLE1:TYPE1
> --
> 2.50.0
>
