Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB613A0B18
	for <selinux@vger.kernel.org>; Tue, 24 Feb 2026 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944298; cv=pass; b=qRPze/N3Q/i5Z7uNjZ3XCf4GpC/Uyq5PgEuIobwpgpPCtBXShQTBiVducVKS/UQXE49iMv4vspGXDF3uMGr7HfefmLktmkWtw/uIhBSSgtz0NhJ0P7PlOp87MmkbcuTo2BsFNu+XiCimnVomBWNZF3AG7WAOKjTtnlQKs8f9M4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944298; c=relaxed/simple;
	bh=NpXDBXAqbPlLtzWPxOL/h0QZP9LJz3X72C7AQTPy0jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZmXiDz66dEoZrvSGdukOF1N79Cbo1vVF+AltpkcSV9nNlKF5pfeLS6KJb2eaBnhyVvGWfLZ7gRVgD1pN5jLzoZ3hMIfJ6woGDMxxrUUekfTvtZCoCxrMru5XdqKCmPscrlXhjC7e9Ctov0wogbOwosLxYONdDKfIXGmlOWogS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBOcavK0; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBOcavK0"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6e1e748dc1so1542047a12.1
        for <selinux@vger.kernel.org>; Tue, 24 Feb 2026 06:44:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771944296; cv=none;
        d=google.com; s=arc-20240605;
        b=Z04HgzeEyYWuG+pWYeDueHk9jAiCBHu4/C6eiwwLEiOX3DiVpWl5DcV+YGTiGwtMww
         m9gQrVJJMtSaQH3zosEK/SuHDyEQ18D8yrCkL2u4YZ08AMjgmbSIjQfuJUKiL5tFVB06
         PPql0w2vr7QXpD3qlsGAyfac8vfLkz56itavYxieGk8jGPHUU+lRnkVQyvGFjKg3OIRW
         1To2yG56cPLs6hfr2mUWx5Pvx/xYbTmeFFtgFKyztexluoqRf3eRFfjyU55BP/2tmIUa
         c51v0AnC248SdHmZgmZcXHTwz08FfkvESjZH/LaKo1bLTwcJ6OliDpknw9FO6EKyUI7L
         74EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g3vFWFpXe0pZI7fYc1bsMNxvQ7fGJt0aDflHuDb/YTs=;
        fh=ShtU1g3JYjTfICXzx1DEbJsWls8pCMNYpLxxqR6sf+0=;
        b=D4BPSn6akuNNqtaEi6gLs0syGWlVU8BuhvyPCd8hwkurL+ckmBgViQLdCNP+HNmNbn
         gs+JEmp5Cvh07iykF/hzezOgGd7nvUa+/mF/v58UYFNgFANWWyi2cwGvLTf1W9EGYY9K
         namDgeOyattpVfxUyeIJwQjEmdkPhKd9UMBQF0EqfOCJxH6stMtuc2iaKfZTI58wL7+W
         ZCFx6nNtuEh5h20U8Qzieny2yvp2lm8u24uD7kZDCMbbt4rDNhNaaTp4DXS/2IvJoVKj
         6cyG57s9EkZDvb+WGM1hUwpBmSL6AOHM4H9K9ybJ/orMbbU2wbzImfd9iJEpB4D5/Red
         0wFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771944296; x=1772549096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3vFWFpXe0pZI7fYc1bsMNxvQ7fGJt0aDflHuDb/YTs=;
        b=LBOcavK0uZWARHpfwTPAPRL5N89Z1QVZ43J6IN1qDaESM80vqGti73ZLcQ2HqG8aLQ
         FP4xrvcPMnUTPHoo+zyhHmBSI6Q0wLvzsoh5iVk3aifVv0xFKbCeuAkeQYp5Vc9FrYni
         5LSl679JJ0OP7GlIqLGhgA57/k+40Mu6UHwz3k4Fx94frpv4tQItF5rFAA7XVGoH2q8n
         OhP8N71bZ4OtpTypA9Z8inSlfz/QYYT04pnSWEX9LMRe3/gP7IsrDOd6Mj19H2NAO2zK
         7xv0bp3GMOxqTSyG+sx0m0Tg+n24tMxDiiGlsi4qzxfLC1/81hu+Pp6I55JIwNNbLALT
         /byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771944296; x=1772549096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g3vFWFpXe0pZI7fYc1bsMNxvQ7fGJt0aDflHuDb/YTs=;
        b=uDnf3yu4gVRXrF39iLavqAq6hvN9doSAA35DddGY57qXpBXJ2udErGpgbAGPCiwcsD
         0cbwRtO9L2My6lFK8KGOVOsVwObpsdIoW/8YZsBXhf0lxuZqdHj69PCXOQYR+N/6XN/D
         qFlaD7eAAs52kZydAM4/5/+VhJI8ZsSmEznrRTkrz5alREjTAwYdtv0wCZ0qghF3LE+X
         fxgqVCNGsyEAgK0b9hSUTBSqQb+AsC4qHqj0PjU1zKvublE37Jd8LL6hf+84d2tdf3JV
         mxtLcuu0E/e0U8ciO4ixz8CrzhFF5N7y4ECk3gFK/jbBXzqt3ON4LOXBlerRJGh68MED
         5zlg==
X-Forwarded-Encrypted: i=1; AJvYcCW6b7IgBj5OPzJdJg44BLYz+zr0Vi8ApC3w1BN6OmJAY3pjqd4U74DEvZlMPb2PNfbEfQybVeTz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30PpdQH6xj0M0gFd88CBpiVhsbPRHuUF1XCoEmuJk2ybS/Csr
	Z2xAtzk4mRWdUeKHILj7bzDSnXrRC4ee3GS32//FcQESDwCfY88RQJmbteB35/yEBogd9jsO/hx
	ob1kmWZpl96N2ALdXzyGLke6IWywnU4k=
X-Gm-Gg: ATEYQzylznG850wR5lgg3/ECiPxu4ZXYuzatREugKSdLGAh5sfj8f81GU0JV4qBQFHd
	CArZoRJ5pXJ72ip5fHc/f4mVR1r8xZXniaQDJXhaBG0OIOgGZhFXRvLB/mMC4egcI+0IZngMte2
	x1BwnWLAQZd5UpL/fnTrVQb4cD9niUXHEP4yUAOxzpUkw8pG5KR2WMsbFt4UdhLETnGZWdbizP6
	MdmJX66ZDmu5PB/0weoF+pPQ4GSukp1TR8JPp4WhbjeAaPvdin6e/0RvmUYJjC2ckuvIGw63Tzm
	iu8stfU=
X-Received: by 2002:a17:90a:e7d1:b0:343:3898:e7c7 with SMTP id
 98e67ed59e1d1-35903849c76mr121288a91.12.1771944296292; Tue, 24 Feb 2026
 06:44:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220195405.30612-1-danieldurning.work@gmail.com>
 <9229d70d-aa7a-459f-b005-695e99888783@schaufler-ca.com> <CAHC9VhSp+X8YNocS7sDz+UyhdJh2yY8CRoi6dwV1eOGdCu9f9w@mail.gmail.com>
In-Reply-To: <CAHC9VhSp+X8YNocS7sDz+UyhdJh2yY8CRoi6dwV1eOGdCu9f9w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 24 Feb 2026 09:44:45 -0500
X-Gm-Features: AaiRm50Bs0-On7LLkESDz1iNdkf3h1DBjn6hYvjZSdJVINzCMBHE_JQir6F04Vo
Message-ID: <CAEjxPJ79V7hM=VnbB1dVA96jjr1yeN9qsLjXb4ALv1VmcRfJ-A@mail.gmail.com>
Subject: Re: [PATCH] lsm: move inode IS_PRIVATE checks to individual LSMs
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, danieldurning.work@gmail.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-integrity@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	john.johansen@canonical.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, mic@digikod.net, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 5:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> I'm not going to argue with that, and perhaps that is a good next
> step: send a quick RFC patch to the VFS folks, with the LSM list CC'd,
> that drops setting the S_PRIVATE flag to see if they complain too
> loudly.  Based on other threads, Christian is aware that we are
> starting to look at better/proper handling of pidfds/pidfs so he may
> be open to dropping S_PRIVATE since it doesn't really have much impact
> outside of the LSM, but who knows; the VFS folks have been growing a
> bit more anti-LSM as of late.

Adding S_PRIVATE to pidfs inodes was originally motivated by this bug repor=
t:
https://lore.kernel.org/linux-fsdevel/20240222190334.GA412503@dev-arch.thel=
io-3990X/
when pidfs was first introduced as its own distinct filesystem type.
Otherwise, Fedora (and likely any other system enforcing SELinux)
stopped working.
So we can't unconditionally remove S_PRIVATE from pidfs inodes without brea=
king
existing userspace/policy. If we want to introduce controls over pidfs
inodes and do so in a
backward-compatible manner, we have to either move the S_PRIVATE
handling into the
individual LSMs or introduce a new hook in pidfs_init_inode() to
determine whether or not to
set S_PRIVATE. Such a hook might also handle labeling the pidfs inode
although we'd have to
see if we have enough information there to do so fully. Note that such
an approach will still likely
end up leaving pidfs inodes created before initial policy load with
the S_PRIVATE flag and hence
uncontrolled; not sure if that is a problem in practice.

>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 318253344b5c..4cec73b4cbcf 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -921,7 +921,7 @@ static int pidfs_init_inode(struct inode *inode, void=
 *data)
>        const struct pid *pid =3D data;
>
>        inode->i_private =3D data;
> -       inode->i_flags |=3D S_PRIVATE | S_ANON_INODE;
> +       inode->i_flags |=3D S_ANON_INODE;
>        /* We allow to set xattrs. */
>        inode->i_flags &=3D ~S_IMMUTABLE;
>        inode->i_mode |=3D S_IRWXU;
>
> --
> paul-moore.com
