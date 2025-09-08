Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22957318120;
	Mon,  8 Sep 2025 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349161; cv=none; b=CEQ5fFghYrbGFgQobP8pXevdmYVh6MoWibZ0GdGCOyWCl/AKEDWfWbJahyOEdQjtD+gCz5D1xShjSP0k+P40L8+05OfiRn5L5mAOo+jcIZP+9SwtsC2tGNroTjXjFB/lWrh5mTHBt31jIgRys6t9GPsNwgsp1ODLxnygic6CF2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349161; c=relaxed/simple;
	bh=h94Ed2IVeIKEwLEIoqQ+TPX8Hru32fLME9+HrvVhov0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQiMjC8zPa/R69FyT3Ert9opcMbOJ4B74t07hwmvoFJgxohEQTcvB07Rhj/AmpScADF9csKsg656zvByBz82szhQ8QUYBxYw0QdjgnYGhaOboFRdEkFYcnqfPFGjcuyng8hWXmVt47yjDp5TU8PIo3pZ6CbEiTcNs3aD0seXHTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OK7c+gxL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OK7c+gxL"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24457f581aeso41445995ad.0;
        Mon, 08 Sep 2025 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757349159; x=1757953959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+0WKcZRkSZVexNJkaEUVOZobbDOUey9tRoQsX6OtrY=;
        b=OK7c+gxLZBppEqBuc0enZxXsmoN2SSY2QX93jJ/Uq1nrpeeNx+mRhiv/kaI46JY1rz
         kzyxV25NxrRgz1EmQrGoy3T7BGc3y/ckv2TrsYV8T5AtPyIZ0tPfBIEvRGxLx6Oh/C/M
         SuaYvNhNZcI7elHVJT6lhkxFcBKakuUVk9aYWUIINkcQw92tY3nqCd30R6/ykykrS1Yr
         EUB8ACuumxxTH8YstwarT+9rxaMdLmuWREHujEtJ2Pn32najgjrVe6wE7xU7XNcU3SYP
         Ab7C6Snd03LFZdW3Tik40IDoA+iAiJYB9CeLg/2UroH0lZYmLAqXK4WM2zX69rrjKLEK
         mh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757349159; x=1757953959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+0WKcZRkSZVexNJkaEUVOZobbDOUey9tRoQsX6OtrY=;
        b=IkHAeLXV3wYAc9sN7ZdszuawsHvnZRS1JwWWll/4hj+g4IK7e/8ZiOfGpfZp81GvrA
         TAOie/dmo422bIOCauOk6OoZH+JBQp6GIo2Ktg7sqjrB6MY/37NIGjo72d29cB2MOMxP
         eyi73Hp00vXcZz3vNL8pKEQOZWlgqvU2V+wQe2CIiKgTNtIbqYu5GsSJAuLMHTPF58V0
         wx/LheanAXzRyouiqbIDL4P2ZEUR08tnc+sonf3rWMWQkHzWXgeZ6CR/dWn4v7Cq3ZTw
         Us0fzxS8JhOSW+6Ba3BLWBTkqqGZEjzFgfk8bY5sh6cKtZeVR/3rLfIvbFVmcrM0nUjW
         rVVg==
X-Forwarded-Encrypted: i=1; AJvYcCUnbMk4O0nZo+UmKRvHrLuGsNtBWoFi2XtA1voOLwBRAsDKLsa4LNXM/SLihZgQB9r1fHmExmGJFZsgYXE=@vger.kernel.org, AJvYcCV9BYWY483Ke9pWqPbzy+tlhZkm03sayWFQ7SylTLdaFp7UtQ3+7YnCdvK1m47A6G3jkgwznurmDQ==@vger.kernel.org, AJvYcCWctcVPPGN6A1XYINPCthNTBIy4r/E39EYmkIex8WaMOI8mVfn4/4XJkymOvQKAr7Cv74g47S31eiVRxw8NJAsa+nwTLZAc@vger.kernel.org
X-Gm-Message-State: AOJu0YyfBly8jzIE7K14g4HdlzvwYZGNUIiRFhPM7U+9ScvIkRlgwk8A
	EcQXv+ZNZU0Eh8/KY+OACr7sXTcYNqadiLvUO3Tpt+H40MHK1KyFDUViDxZOX1GUw1+cC0oxuR0
	0oioUdxB5yMNY5hpQ7CfIbzHg/QAKj0g=
X-Gm-Gg: ASbGnct5v/0LicjW/DomLM/5ZNCkjxplWPzk1d+yNK2UODfJDdFpIWBpyHsPj2itCi5
	AMC2QHOXgs5CCypJ/6+kGJQ5s+v9sXKpk/oQ1iNc9oJxcDpHs0V3F3zFcGA9HIDkzYHvde7aS6G
	gimOK0SXkMNgf9zE3fKJjXMEjartdPKBMtdn0B9tLmsZAlGmjivk4wkY1aVlLcjAWBIIZlIcFjK
	SAIh8Sht7aX9vA57w==
X-Google-Smtp-Source: AGHT+IETc3c3cLRTFof5BKTTblzeGAw5qubihFCD5fgwYnPWwAqzknEw27hmimwnbjSTr9fXTHNyB/WBEs118AnTKKw=
X-Received: by 2002:a17:902:fc8e:b0:23f:f96d:7579 with SMTP id
 d9443c01a7336-2517330a5e7mr103859335ad.37.1757349159078; Mon, 08 Sep 2025
 09:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908013419.4186627-1-tweek@google.com>
In-Reply-To: <20250908013419.4186627-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 8 Sep 2025 12:32:28 -0400
X-Gm-Features: Ac12FXxJdxahVvmzM4YiQBodWGcP75VV7B_u38XfqggRVTZSjI_XSg54VA1OJx0
Message-ID: <CAEjxPJ5q0eriGjo1tdfN+pzBBN5OeyfMaYp_sNQcOg-rDaXVCA@mail.gmail.com>
Subject: Re: [PATCH v2] memfd,selinux: call security_inode_init_security_anon
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Isaac Manjarres <isaacmanjarres@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 9:34=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@google=
.com> wrote:
>
> Prior to this change, no security hooks were called at the creation of a
> memfd file. It means that, for SELinux as an example, it will receive
> the default type of the filesystem that backs the in-memory inode. In
> most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it will
> be hugetlbfs. Both can be considered implementation details of memfd.
>
> It also means that it is not possible to differentiate between a file
> coming from memfd_create and a file coming from a standard tmpfs mount
> point.
>
> Additionally, no permission is validated at creation, which differs from
> the similar memfd_secret syscall.
>
> Call security_inode_init_security_anon during creation. This ensures
> that the file is setup similarly to other anonymous inodes. On SELinux,
> it means that the file will receive the security context of its task.
>
> The ability to limit fexecve on memfd has been of interest to avoid
> potential pitfalls where /proc/self/exe or similar would be executed
> [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> similarly to the file class. These access vectors may not make sense for
> the existing "anon_inode" class. Therefore, define and assign a new
> class "memfd_file" to support such access vectors.
>
> Guard these changes behind a new policy capability named "memfd_class".
>
> [1] https://crbug.com/1305267
> [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.com=
/
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> Changes since v1:
> - Move test of class earlier in selinux_bprm_creds_for_exec
> - Remove duplicate call to security_transition_sid
>
> Changes since RFC:
> - Remove enum argument, simply compare the anon inode name
> - Introduce a policy capability for compatility
> - Add validation of class in selinux_bprm_creds_for_exec
>
>  include/linux/memfd.h                      |  2 ++
>  mm/memfd.c                                 | 14 ++++++++++--
>  security/selinux/hooks.c                   | 26 +++++++++++++++++-----
>  security/selinux/include/classmap.h        |  2 ++
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/include/security.h        |  5 +++++
>  7 files changed, 44 insertions(+), 7 deletions(-)
>

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c95a5874bf7d..6adf2f393ed9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2315,6 +2316,9 @@ static int selinux_bprm_creds_for_exec(struct linux=
_binprm *bprm)
>         new_tsec =3D selinux_cred(bprm->cred);
>         isec =3D inode_security(inode);
>
> +       if (isec->sclass !=3D SECCLASS_FILE && isec->sclass !=3D SECCLASS=
_MEMFD_FILE)
> +               return -EPERM;
> +

Sorry, I should have mentioned this earlier, but usually we try to
avoid triggering silent denials from SELinux since it provides no hint
to the user as to what went wrong or how to resolve.
Arguably reaching this code would be suggestive of a kernel bug but I
know that BUG_ON() is frowned upon these days.
Maybe we should WARN_ON_ONCE() here or similar? We also rarely return
-EPERM from SELinux outside of capability checks since usually EPERM
means a failed capability check
(vs -EACCES). Defer to Paul on how/if he wants to handle this and
whether it requires re-spinning this patch or just a follow-on one.

>         /* Default to the current task SID. */
>         new_tsec->sid =3D old_tsec->sid;
>         new_tsec->osid =3D old_tsec->sid;
