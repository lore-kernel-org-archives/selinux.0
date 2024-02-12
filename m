Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCE941775
	for <selinux@vger.kernel.org>; Mon, 12 Feb 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760625; cv=none; b=BFKUn2Hbog85OufRMyA7YmwDNjlNxW0VRT9yMTvpZ5mC7jRJfPOFrN6Wa2+t9b3CwSrJZfdbbqdHF0JdoBUC3L8bAXT1qYgLsK7ngRXd+cI4I6sCT+pk/qIA+v5tnuvtf9S7JjRKnT64iwGIDgGPwWGuvToon+YVj+54qeUQ4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760625; c=relaxed/simple;
	bh=GO+XqADvFPujimGfIAAMQ9biA+SOVkTb0kZua4dtRds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muO93ez7Fm8lXMjCtnMg1ZYJWL6uIub86yVo8m2hQnK1y2hVz/Tab/qmMgOYMof7Zd3Hgrqnc1DHo9+BViy5fGP+zsjaVw62mTZhifGVbPV4eaZZ5dr49/I3yWXW8oLsStTVe4ORF3QgwOzJLgVKoiTGImWNIrIrns9RTRzDSIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LRiaR+iH; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LRiaR+iH"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6077a1d441eso3397707b3.1
        for <selinux@vger.kernel.org>; Mon, 12 Feb 2024 09:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707760621; x=1708365421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GywgT/kIpRIiEaoNj7SzkmI6fseY2YuE7XBhiV1W3IM=;
        b=LRiaR+iHlnh9kzMtOaWL8uSftEEFJ52PPgddWsecZFY4BgcuAlwZK4R4dL/SZh1mrE
         Y2w7AzzbskSyTKL8jhIgfcCH1JKlqWdBJlWj/6pLDwhsGSvJ7JPrbBN/CwPj5looxEM8
         lHZ/TNidgCuBjffnQET4rpNppKqx732X6YNmBP9YmEE6Nx0uqWgRwx5aZdrWcv/7bfLq
         S6kD2XXIyP+9wPD23o3fFt4nVhgPZe6OizA3ViMyaIA5hEaSQcPiCDVyBqqBaNJARkg+
         GEz0ooTgJSysfQSHZSy7xILJ+U8sJOILqkDOKoayxnGfmKzmn0lxKxGLankZqDCiZa/w
         RTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707760621; x=1708365421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GywgT/kIpRIiEaoNj7SzkmI6fseY2YuE7XBhiV1W3IM=;
        b=Swc0C9Aq+IEK7EpmeD7FY4ezltSnomSfkFsLZsmOWclTY5ie7RS+kQ2tVTm/YtA8YZ
         18G8z9TSxwGQTGPCGAAlWkWzs5STiVJY1jHrweaJgyiKSbFO+5vvffANtu0mLF0whDUI
         bOXDCoOR1809iAmzjhU7guZPggCo0In7VkZIAhsMuPSQkAUG87BKYWocZE5Ut0A3uaet
         dZfYP42l3fwQsJbyVWiqv6EnhpYtRenZRWjYo2iLtP2dGklFYV5nqXLElYw1IAUh5l44
         Y+8hEvIf9PmDE5xZlFR36e25QBBY8Uj0M4A06OP3dRgec4pR8BrT/HJyLLRKsco3YIuP
         0big==
X-Gm-Message-State: AOJu0YxkeXCOJOLzr36YpXYsBDhDyP0AjKhuEADqVGIZcjkOcbNXCYH1
	CBwm5Ntu5pgEBDi2AdNAgNRDnTmvdGv3aJc4l9n3Z2zl1UGoJ8CyeBDOWzQNRYnacsFrk2PTIFb
	5i1C2rAzOjzfEOD4tZ15111PqWuK7AR8NB45N
X-Google-Smtp-Source: AGHT+IGjhdaYUNjwcSJFIvuNyHx9uH/3Qz50J2Oo2Jf2sLDKqyYEZrikDyUgVsDTlP7Ry4VIyaFcE3Lr2B40t4UjJbg=
X-Received: by 2002:a81:d507:0:b0:5ff:aa34:7c5f with SMTP id
 i7-20020a81d507000000b005ffaa347c5fmr4677040ywj.46.1707760621630; Mon, 12 Feb
 2024 09:57:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-20-roberto.sassu@huaweicloud.com> <fd6ddc3d-e5d3-4b9c-b00b-ac2b1f22d653@linux.ibm.com>
In-Reply-To: <fd6ddc3d-e5d3-4b9c-b00b-ac2b1f22d653@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Feb 2024 12:56:50 -0500
Message-ID: <CAHC9VhTY=X7z5SRQZzFe25FGB2E3FBBkuZ_YYA1+ETyr7pv=tA@mail.gmail.com>
Subject: Re: [PATCH v9 19/25] integrity: Move integrity_kernel_module_request()
 to IMA
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, 
	serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, 
	stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, 
	shuah@kernel.org, mic@digikod.net, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 12:48=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.c=
om> wrote:
> On 1/15/24 13:18, Roberto Sassu wrote:

...

> > +/**
> > + * ima_kernel_module_request - Prevent crypto-pkcs1pad(rsa,*) requests
> > + * @kmod_name: kernel module name
> > + *
> > + * We have situation, when public_key_verify_signature() in case of RS=
A > + * algorithm use alg_name to store internal information in order to
> > + * construct an algorithm on the fly, but crypto_larval_lookup() will =
try
> > + * to use alg_name in order to load kernel module with same name.
> > + * Since we don't have any real "crypto-pkcs1pad(rsa,*)" kernel module=
s,
> > + * we are safe to fail such module request from crypto_larval_lookup()=
.
> > + *
> > + * In this way we prevent modprobe execution during digsig verificatio=
n
> > + * and avoid possible deadlock if modprobe and/or it's dependencies
> > + * also signed with digsig.
>
> This text needs to some reformulation at some point..

There is no time like the present.  If you have a suggestion I would
love to hear it and I'm sure Roberto would too.

--=20
paul-moore.com
