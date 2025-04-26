Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BFA2D78A
	for <selinux@vger.kernel.org>; Sat, 26 Apr 2025 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745686615; cv=none; b=WjDc860+yGKuYBdDzr2UOchKCg5ZebBMbKmET5bXI5o3h+hJdNOKC12ddV1GK78E+lG5Vcp0gWytyk7yXWqgXzIyqWbnzpTEhJVyJvuf/+4DX8T6qV436WKg6cBnqHZ+N3HGU/xiHJt8YuuI/iwIowfbqnVSpwk0tkW2HDs6ZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745686615; c=relaxed/simple;
	bh=hVc53GkaWp8guAZtyjJGkUTbCiqvI//qAfPqEmrP2x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyIK+D3ejIsRYRFYN3BFll+Q1Pb1iMj4gSrp+YZNDEXMXMN0om3NCMd19xPUDeKJhQUysdNVdYPlPQVKcCxVyFCKyDEEWPvxL7FE6jHkHXMScRe3h3UE/XZnpGWrjCyCXUdM+KX4zPuZPceox+2iEAUcANmjhhbm3UOSF7Wj4Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Bo5B4yek; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Bo5B4yek"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e6dd991a0e6so2505742276.1
        for <selinux@vger.kernel.org>; Sat, 26 Apr 2025 09:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745686612; x=1746291412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Qvcm4ZlifMLzpCFaQIQMUnlx9IKvnlCR33o+043/5o=;
        b=Bo5B4yekCk2tcK4dOxf/+wg4A4VOd4gaCE6gzZg6xNL6XwJrKJAUe7In9CT3jd/ByK
         3mFiuKQ/kBqhhfXMD4x1XS89NAVFslk3eiJjrNO5SNQGPOmhi7stVQ+2jKWMWr8Tpb0N
         D8AVkZNls/GntEL9tX3TvVRNRu4i/zKQnIHOOvkP2ytxZvRHb4oFNuOgrowplqyyXhYh
         0E+RjuYs5HoEZkajw0Mnwq2Be1g5Iz7q/CpydrErAQM4PmWkd0a1wnbgsiqhmbj568qN
         TgXEbSeF9r6buPQkCIGL0TSuHfNOlH4yG1PYfAFPoqs/JD3l2rSjulgY2+k1of0+xAPo
         hWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745686612; x=1746291412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Qvcm4ZlifMLzpCFaQIQMUnlx9IKvnlCR33o+043/5o=;
        b=E2pnLvRUWsNPWCuaaURLVqqZZV58BDTifCMIb1gdaF3iC/8se9zO6KAzkUOXhOuHpr
         xZEl21Pi+VYzb5jMi4Quyoc6y7zHOdIokXjuc5JrgcGpI/kdq/XIotLqcl691qjoP/q5
         ofOf/CvK7GTHBrh0BtBthGW9C+6+Eh5TQaUmVzMBObsw+2GaeQ65s3b+88LnOj5/2gLA
         +LK91vSzgLTorSO6uQgPURgMY8Ym+Z/ZtbLBLCG2gZN8Yq7JrVnINn2cK1LDsCuvBg11
         +9lUZKTEDOiyblJh2sbBUxSi9PFw/5v8M4vfKVcNkPHONO8Sswf8L8hSHPwrrYOUG9Oz
         Uo7g==
X-Forwarded-Encrypted: i=1; AJvYcCV7K11D2ynMFGB5IGY/dokubuZAQGxWN7ViG6h3Oxa/U47o8ZHnrpabsa8jLVi8Zl8N7Njb1+76@vger.kernel.org
X-Gm-Message-State: AOJu0YxaHXJBXL4Kl5BusA8x5aCg3DpCBSVqqoaWTnuw/GMFZAetUQFe
	0s2Gmq2sMS0miLR0UlCfETpIx8lsUAEQdNVqVdxhuVAPPql+vnouViO1HKNXfKy3WVdAJR01tWl
	T99Y756nUJagkqCgbt3sILdapY6wMgWMnppaW
X-Gm-Gg: ASbGnct3TJMBDBOM7uyiPR5xrfM5oI2w2W3qCRmiXab8ZCNyPjaD0Uy4r+44DFpgImY
	kKtZqo32+JgipTxWBmXIEXXiIWaQQxA6i0xtbQu7pnRPtXLwrv37hSl7AhVeraFdSz3e7uV4dnb
	LjzRH5a4ZvgNG/EnU3lGucCQ==
X-Google-Smtp-Source: AGHT+IE+1k4f+bo/fo02wyG4A49rhL7JuhfWYS6qNllUowtLP4beqhuLJsS4Vr/rE1m1d3RlfWQDKcP50bIe7h2CUvI=
X-Received: by 2002:a05:6902:158c:b0:e63:efca:6692 with SMTP id
 3f1490d57ef6-e732334565bmr4790627276.6.1745686612561; Sat, 26 Apr 2025
 09:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424152822.2719-1-stephen.smalley.work@gmail.com>
 <20250425-einspannen-wertarbeit-3f0c939525dc@brauner> <CAEjxPJ4vntQ5cCo_=KN0d+5FDPRwStjXUimE4iHXJkz9oeuVCw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4vntQ5cCo_=KN0d+5FDPRwStjXUimE4iHXJkz9oeuVCw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 26 Apr 2025 12:56:41 -0400
X-Gm-Features: ATxdqUEbSGq7jI0-7V0Nbdw0096xjbVILUivTxTYtxScdYz_SrmH_Xrk5Jt5Gbk
Message-ID: <CAHC9VhSOqvKm5wNPp_7O+cayMf3gopeLu=uDoP5kmfvqtp40WQ@mail.gmail.com>
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list to always include
 security.* xattrs
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, omosnace@redhat.com, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 11:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Apr 25, 2025 at 5:20=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> > On Thu, Apr 24, 2025 at 11:28:20AM -0400, Stephen Smalley wrote:

...

> > > +     if (err < 0)
> > > +             return err;
> > > +
> > > +     if (buffer) {
> > > +             if (remaining_size < err)
> > > +                     return -ERANGE;
> > > +             buffer +=3D err;
> > > +     }
> > > +     remaining_size -=3D err;
> >
> > Really unpleasant code duplication in here. We have xattr_list_one() fo=
r
> > that. security_inode_listxattr() should probably receive a pointer to
> > &remaining_size?
>
> Not sure how to avoid the duplication, but willing to take it inside
> of security_inode_listsecurity() and change its hook interface if
> desired.

We talked about moving to xattr_list_one() in the other RFC thread
earlier this week and as previously mentioned I think it's the right
thing to do.  However, considering the issue with the new coreutils
release, I think it's best to keep this patch limited to the fixes
necessary to restore the desired behavior with the recent coreutils;
this should make life easier for distro and stable backports.  We can
address the LSM hook cleanup/rework in a second patch{set} afterwards.

--
paul-moore.com
