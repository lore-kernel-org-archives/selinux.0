Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE62134409
	for <selinux@vger.kernel.org>; Mon,  3 Jun 2024 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448650; cv=none; b=YqNCzm8xzkfamrnrbkX7Ha/nqtt0an44Kxlz5PAi8GqMVSFTnmv+TTW8U1DXl9x+wUtBdzqkBpNKqFiXyq4QLneErUWTy7i8RBiC5lPnSenEKOcA/cuRvi4FCdyiA4PdC3uwk2sKKwDbtzBk0bGp81dSI030Ri4U78C7Eb1ytJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448650; c=relaxed/simple;
	bh=kx2kvEZgNc5XsnnewjVka9co2H4QjUYDuU73T0I0Hl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/GENLWXQGfw28ieQbRjuSa59+XfgAiH/AOhkO2toG5yLjFg2XWj4Ovia4xBVcee5pyyMbWYK1EwwtJq0Qyik2RSny807wAe40ITcdmttWVqj7qiQbnJAg3LU3QawKy3+90SYtWRyZ0l5zTXgmz+tdvLPn5SGLN3N2reM4vkdh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VMn4yVx1; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VMn4yVx1"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-62a087c3a92so3957537b3.2
        for <selinux@vger.kernel.org>; Mon, 03 Jun 2024 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717448647; x=1718053447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4Xwo04AxfSK0W6mUhqUjoHJv2i+cgsYyuXRU+BzfeA=;
        b=VMn4yVx1AYSFygWtRu5+IglA1BVBZXIDkLMZdFsI6Mm7qdpKVMCWvLyJPV3NTT4HzC
         0CulDm2WXkRXh1cnRTQGZUtR3Xd4CuCUWIplnYH4Q3S0QWgiNSXrdHbBrfIf9vdhPVrR
         Ad6jqImA/J1vJLVb4a1EsfeN6pYWwd5afsuAj2gK97uEYtYJ3MTdvbi7irvogUFApxI6
         o+zdNcpF0+/AvnYCUQoTJ8CGE/+vgqlhwNKZ0nBNaDibw5tpHyEg0a8f2NWwBwJOZCzv
         5smUPWJI72Y4dnho+rlH2lXeDxKpR2tLinCMumyyk/0/96vhtngi+EtetW0uJgE4wux+
         87pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717448647; x=1718053447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4Xwo04AxfSK0W6mUhqUjoHJv2i+cgsYyuXRU+BzfeA=;
        b=keZnmKS1wWpYcZTaZjrYfLsK2BuYanmftudEXjj64C+nwF0kgRayHPzK+ZnuLsj9qB
         e6Mpi9iLSweFkvzEgjJrB2jIEVA9elPfxbdDTTU7FdRtmJV7UEndJsbeG/uKmcH6pIwg
         822eE/X6Md1yMDNTxHPBVGfnry6PyJEx8IcMqdOenbxWEtDBUX/BuhrmAGHskLyTH4e4
         Had4s+w7RhOti6S4a+7hKpuJJWPelp4eEmDZbP4hkR9ydYph5o8uKYz7vSiGuZC0SPu9
         oFDTi90Cp72EVL670vvYEOohgebSZphaD8ewKPaTPOsi1NZSkF6eArAJIVR630mghl/3
         EGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl4cHMaL2gcHvjb+cpgRGYYXy2s6YItJol/OC3ZvwyIteKf4jx8NLZGGW3LDQWDLKNg959yspCaRHjVSfQs6sz5v8voGClSQ==
X-Gm-Message-State: AOJu0YygRfQAL4c8/cBgBnfzLHYiNeLxGbyYI6lwNWABDrSWQ7Gt3yQm
	ZiLn1sAJtn/EjE7PVfvMUgXUjid2cVbXh3PHAIhxstcdEiiB0MJdzjHfMmCWsKBwa+gl9M5vAgM
	/tjg5GDCO46U5T8dHnu5p+Hk7avA0o0N63Owh
X-Google-Smtp-Source: AGHT+IGR+FpbhgOaypOj8EHAJX7D2rLdNzF0sO2h5xEd4/ttL81NSVdpzxrwxGxotbOO4RE/GArlcQx7GP4z1mOA6C8=
X-Received: by 2002:a05:690c:82e:b0:627:de5d:cf36 with SMTP id
 00721157ae682-62c79777753mr103683987b3.39.1717448646572; Mon, 03 Jun 2024
 14:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-4-laoar.shao@gmail.com>
In-Reply-To: <20240602023754.25443-4-laoar.shao@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 3 Jun 2024 17:03:55 -0400
Message-ID: <CAHC9VhRBN94QRGAmjZKDk_H0GxAEn-PBE4_2tTwuwfXps1Hr5A@mail.gmail.com>
Subject: Re: [PATCH 3/6] auditsc: Replace memcpy() with __get_task_comm()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 10:38=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Using __get_task_comm() to read the task comm ensures that the name is
> always NUL-terminated, regardless of the source string. This approach als=
o
> facilitates future extensions to the task comm.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> ---
>  kernel/auditsc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Assuming you've sorted out all the problems identified earlier in the
patchset and __get_task_comm() no longer takes task_lock() this should
be okay from an audit perspective.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6f0d6fb6523f..0459a141dc86 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2730,7 +2730,7 @@ void __audit_ptrace(struct task_struct *t)
>         context->target_uid =3D task_uid(t);
>         context->target_sessionid =3D audit_get_sessionid(t);
>         security_task_getsecid_obj(t, &context->target_sid);
> -       memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
> +       __get_task_comm(context->target_comm, TASK_COMM_LEN, t);
>  }
>
>  /**
> @@ -2757,7 +2757,7 @@ int audit_signal_info_syscall(struct task_struct *t=
)
>                 ctx->target_uid =3D t_uid;
>                 ctx->target_sessionid =3D audit_get_sessionid(t);
>                 security_task_getsecid_obj(t, &ctx->target_sid);
> -               memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
> +               __get_task_comm(ctx->target_comm, TASK_COMM_LEN, t);
>                 return 0;
>         }
>
> @@ -2778,7 +2778,7 @@ int audit_signal_info_syscall(struct task_struct *t=
)
>         axp->target_uid[axp->pid_count] =3D t_uid;
>         axp->target_sessionid[axp->pid_count] =3D audit_get_sessionid(t);
>         security_task_getsecid_obj(t, &axp->target_sid[axp->pid_count]);
> -       memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
> +       __get_task_comm(axp->target_comm[axp->pid_count], TASK_COMM_LEN, =
t);
>         axp->pid_count++;
>
>         return 0;
> --
> 2.39.1

--=20
paul-moore.com
