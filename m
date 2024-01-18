Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54372C6A4
	for <selinux@vger.kernel.org>; Thu, 18 Jan 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597351; cv=none; b=iH5uCYgn8O4Xq3k94cNsoEbouxaRLHOOtiZ6XOfdVUkb8Z7q0CHG17xcjHZe9RumYAn7Gb/XHM8xhu1NMeg+p2nqCy4pfh1tGNaj3z6MkDWcYIK72SeQCDTbAmzer9mC4htedBn9ZKGQxTIVT+hTDA4s7uSpB/5noLDw1rpuygY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597351; c=relaxed/simple;
	bh=uwPj3q9XGtTCZcmx+a3b/eWuPshZBtyULCjcQrjQv3s=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=OyV8qpgJ8W+kh9bInNCBVksbIlpHDayCUZIQQYYJLkgqVZICb70VMlqwjCdLiGuTffiaaVcLpWcsXBQ/cRlhB+t23kfpM3QTBH87X4nqzcO9hbBo4klYrG2ZC2dzV1lSpqs0oU7m/3EYuPm29coaou7/QBVN2/VUzjdRLX8AIHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIPWL51a; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIPWL51a"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28e79182570so2498178a91.2
        for <selinux@vger.kernel.org>; Thu, 18 Jan 2024 09:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705597349; x=1706202149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqEZKCjZX82e5H7QVwlfiLN0oQSLx5I174o3fBkUq2w=;
        b=JIPWL51agrjYgBTpX6tzUkudBgyCXUsYPRMK3Nzp9FHG4dts4Jk0ZJv+rteEf7oAaw
         XpgBK/TAvPcqLhruMzxt/gyaNEMrcwYzmEs76dJVoI2kk3McHiRHt6L0dmd7qyx+TVNw
         38vuyID+MDYtdnocGeDE6QC/IfdKnDdwW242DcOzi9W6R3sPIETfuT1ZtB5kg+XHBnyq
         Jn6Jf23pcAuCqhtEjHVPEbmKqn3Q548gudMt32KY/pmj0joP0lJMSI+aA3X/DlP2y4dr
         jGDyk9hoa1EJWM0YnKwPhZKyAI2xJi5KrgiUq8pTQoKeooxFmkYG0j1Da6GkZP7Vr+cm
         9DxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705597349; x=1706202149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqEZKCjZX82e5H7QVwlfiLN0oQSLx5I174o3fBkUq2w=;
        b=R18pcXrJ4JKRSLnyTRunoo1ZAWz1AFermJZto749KaVhxNPum2uXJ6gGtmCQAn+co+
         DtOyKqtAgRAWKlKKW9nBfSNStfXutM71nLzi4zqMJLSDVFgCx3toD0ze4d+X6C6yycab
         Tdz2zFqbz/VFFhRp8wvJS6G9ADyvk6F/mQbmGBY+kJ3GGSGqK4NfwDdcmsPcO8v8RN8L
         K2vV6baqtNn91z0NWzhXrCYOkp8n53Afm1CABCV+1bevPEHz5ls42EulDnr5Wz6l3mhI
         vByDVbdBRx4XNBa7U4lXzq0Oj3LY+JqwbO0GrxYA+i+2bUek/ETStZi6I2IZfNPqIUhR
         fNIA==
X-Gm-Message-State: AOJu0YyKxP6WKGgPTfKPkh0HlMef800nnDB8M2aQv4qRv3TbsKJ++6JE
	QEl4tUXRx+bP13pbOrRTKb32ue94nFHisAjzWI4OkbjPBNq7drygjHtKvReOviHWSc1jJ+RIJnA
	yXP69BVhvL45GjfzpJauFtuzWZEY=
X-Google-Smtp-Source: AGHT+IGILXNhN+6GmvcRwRt4ktwCrSHNz3z6ChiyHQf4e0Aiv8JZVwhWnXb9kfhXjue/YBRvIO6Sy+2mPos8o+0xUxQ=
X-Received: by 2002:a17:90b:11c3:b0:290:12af:745e with SMTP id
 gv3-20020a17090b11c300b0029012af745emr947876pjb.31.1705597348877; Thu, 18 Jan
 2024 09:02:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALbthtcf4m5vPK7xLZhzk8W_7ETkNPeR3bnaM06BtzuQy8w-jQ@mail.gmail.com>
In-Reply-To: <CALbthtcf4m5vPK7xLZhzk8W_7ETkNPeR3bnaM06BtzuQy8w-jQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 18 Jan 2024 12:02:17 -0500
Message-ID: <CAEjxPJ7ZB3PtVjvJf9u-C7JGNpGv53O9TGu7o5EadMHy2hHE5w@mail.gmail.com>
Subject: Re: Race in security/selinux/hooks.c on isec->sclass and isec->sid usage
To: Gabriel Ryan <gabe@cs.columbia.edu>
Cc: Paul Moore <paul@paul-moore.com>, omosnace@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:26=E2=80=AFAM Gabriel Ryan <gabe@cs.columbia.edu=
> wrote:
>
> We found a race in selinux for kernel v6.6 using a prototype race
> testing tool based on modified KCSAN we are developing. We are
> reporting the race because it appears to be a potential bug. The race
> occurs on isec->sclass and isec->sid, which are set in
>
> security/selinux/hooks.c:3329-3330 selinux_inode_post_setxattr
>
>         isec->sclass =3D inode_mode_to_security_class(inode->i_mode);
>         isec->sid =3D newsid;
>
> Where isec->lock is held when isec->sclass and isec->sid are set above
> but not held when they are read in the following 3 locations:
>
> security/selinux/hooks.c:1671 inode_has_perm
> security/selinux/hooks.c:3125 selinux_inode_permission
> security/selinux/hooks.c:3690 ioctl_has_perm
>
>
> This seems like it could lead to undefined behavior if multiple
> threads are reading the isec struct and updating it concurrently,
> (e.g., reading an old isec->sid value but new isec->sclass value).
>
> In some other cases in security/selinux/hooks.c, isec->lock is held
> when isec->sclass and isec->sid are accessed, such as in
> security/selinux/hooks.c:4942-4945 selinux_socket_accept. Therefore,
> extending the isec->lock to cover when sclass and sid are read from
> the isec struct in these three locations might be a suitable fix.

isec->sclass should only really need to be set once when isec is first
initialized after mode format bits have been set.
Not sure why it is getting assigned again in post_setxattr.
In general, handling of isec->sid needs an overall cleanup but putting
that within isec->lock would be a big hammer.
Proper use of READ_ONCE/WRITE_ONCE or smp_load_acquire/store_release
may suffice.
