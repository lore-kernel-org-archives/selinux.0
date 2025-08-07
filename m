Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0A221737
	for <selinux@vger.kernel.org>; Thu,  7 Aug 2025 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589643; cv=none; b=s9xtMFFzVKKYKdAOg6dGBKmBcfbJrM56W1Ktgx0ITyekxQkLr2MPg3EqGGgKps31ES98vRgA37641noNqaJl8Z5nvvEqMI7KD9GiN51owizloszJ7WR8965eHvtpgvxmFIhZxUIW+8/pfzTIKtjL5nVngClK35NtjIXCuo6SgTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589643; c=relaxed/simple;
	bh=lUJ7qUrC5og8Kb8iqYp9RPYjKfgfRoSKxDWbfwoyLH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kn7KM3tkKeBQUswQS6wWmWvwYN+ucJx+hytb05TREJKnqqxIMYSAqpfGBpeipBeHBj6NxbzNTyX8zywJQ2lTpxyNISEgXDRaGZs2oxgZbHSCLnSETXEBDwAjrILgHo3nUYJgWh0nxID7VB3/6X11DdEW8X36XNnSZThLYYc8L0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMpOrXOm; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMpOrXOm"
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-55b733911b3so1329677e87.2
        for <selinux@vger.kernel.org>; Thu, 07 Aug 2025 11:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754589639; x=1755194439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/17g1x147eg6gCczXQybR64W4EilFRg7u1DvN8cwNE=;
        b=NMpOrXOmWo55OUY198aABH3T5bYouPqwwiaicOjBAGNX5iuJnLq28GcQhNGpPXHOr8
         uAp1mhz2jAU9ps+5oYOByrFWRpwLF3VI09BqHohDwxzO3FCPjJ++efpmNvuQ5TmZFIz8
         NmSDHUW9LWugsI+G8KT2QiPy2GLvAe7C6jlWF1O5c1W1iM7hY4b3sKJJFrcJgOE2RluP
         UaQJMf3b17CgjMdaRzgkw2OddB9XdLJcakMcY+yKRUgp7JqYV3NYnEudh6uZpO/c1bxn
         NKXd+l+0Dzpazzkh0NM+TGZNSeCswxjzYMMRtB91CzgAiU2jygWebJjipnmSKuujGOY9
         rpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754589639; x=1755194439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/17g1x147eg6gCczXQybR64W4EilFRg7u1DvN8cwNE=;
        b=O2zkxH73evyfx09x3Yr3MkN6+ligqi6Wb3R2Bs5f7WeGK7sUQsDZ3ULN3fokDjw2JQ
         u+b6m9O0/sn9GMAm56TDQvbnwtqQF0GQ3vvUo4LNBQ+I67jOJQw2Gzg+hvWNLuxFl0Bk
         Ng/p7HKrvPkv24+osINBU8Ez2lXOnq/E5RKrFk9KGVqP9NIyHuSeUbEywd4KTUK/5RCo
         ACmiul1kCm+CSFo8UTWakg0YUOxpE1gnNnHfVxgFXQZB+It0dYONnULorP+qSBCVv/j1
         HUfUhL+SIEoyy843LmNgl7+EthdGXAQCYgUyuJ/wgWkqNOkRlBhrrfPl8inTSVbzaDFA
         2Zhw==
X-Gm-Message-State: AOJu0YxhG7Se6XRJHPrvXBRghCC+cyBD7AkaJdQTr4R1xkriJPb/jPPS
	vsRLwmgM5hfJUmUCcNNIM8aZZRw6An9/AFMj95V5BFx4rXsLuBrOF5z/gnR1M+HLHjs8d7w4vrG
	qaA8YFP48xtqg1Hn2XhBjgUBtWdaLnAQONjKvu/Y=
X-Gm-Gg: ASbGncuqBFxDDpJQPx6fAuYVuiTDdI0zetpQFmOOBmKc51/RJ9QsqzzpOsSm9Sps0uX
	Wdt2tcabsMrRxA5ulad4B5fTEnovQhX3iFI+Y4yulVX4qKVVxr7kHTxFjAt0ZQ3r7zDkLE+2B0P
	BykJ7OTLSWpsDiuPZtiNvFQBTS7JFS3wEIDWY04ilml02gchhmzF6ajfOgZLJ5fzYotn6C4xTRC
	e+/8KQ=
X-Google-Smtp-Source: AGHT+IGE24s7jEhsbBIaGyrw8I9Q3na6sekHMVjl/RfkTtOIddEmvDuR79t2kn7NxPN6kVHgWXJRTWaO4NplbC7YbcY=
X-Received: by 2002:a05:6512:b24:b0:55b:5adc:51ff with SMTP id
 2adb3069b0e04-55cbe6c4ed0mr223634e87.38.1754589638991; Thu, 07 Aug 2025
 11:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806180149.1995-1-ericsu@linux.microsoft.com>
In-Reply-To: <20250806180149.1995-1-ericsu@linux.microsoft.com>
From: Daniel Durning <danieldurning.work@gmail.com>
Date: Thu, 7 Aug 2025 14:00:27 -0400
X-Gm-Features: Ac12FXzyw5fg97auQ04uYvmIjPG_1a54P7hdb5mBuk8jB_RnU6yqwcIe6IudX2s
Message-ID: <CAKrb_fGECzqWO+Kq7n+5Q=J404npPyttrkLcXwLkdM-UZcZmLA@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Add support for BPF token access control
To: ericsu@linux.microsoft.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 2:07=E2=80=AFPM <ericsu@linux.microsoft.com> wrote:
>
> From: Eric Suen <ericsu@linux.microsoft.com>
>
> BPF token support was introduced to allow a privileged process to delegat=
e
> limited BPF functionality=E2=80=94such as map creation and program loadin=
g=E2=80=94to an
> unprivileged process:
>   https://lore.kernel.org/linux-security-module/20231130185229.2688956-1-=
andrii@kernel.org/
>
> This patch adds SELinux support for controlling BPF token access. With
> this change, SELinux policies can now enforce constraints on BPF token
> usage based on both the delegating (privileged) process and the recipient
> (unprivileged) process.
>
> Supported operations currently include:
>   - map_create
>   - prog_load
>
> High-level workflow:
>   1. An unprivileged process creates a VFS context via `fsopen()` and
>      obtains a file descriptor.
>   2. This descriptor is passed to a privileged process, which configures
>      BPF token delegation options and mounts a BPF filesystem.
>   3. SELinux records the `creator_sid` of the privileged process during
>      mount setup.
>   4. The unprivileged process then uses this BPF fs mount to create a
>      token and attach it to subsequent BPF syscalls.
>   5. During verification of `map_create` and `prog_load`, SELinux uses
>      `creator_sid` and the current SID to check policy permissions via:
>        avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
>                     BPF__MAP_CREATE, NULL);
>
> To verify the logic introduced by this patch, my fork of the SELinux
> testsuite with relevant test cases is available here:
>   https://github.com/havefuncoding1/selinux-testsuite
>

I like your approach. I have added some comments below. I think it
would be worth implementing and testing the bpf_token_capable hook in
your patch as well. You are welcome to reference my implementation.

> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> ---
>  security/selinux/hooks.c                   | 107 ++++++++++++++++++++-
>  security/selinux/include/classmap.h        |   2 +-
>  security/selinux/include/objsec.h          |   4 +
>  security/selinux/include/policycap.h       |   1 +
>  security/selinux/include/policycap_names.h |   1 +
>  security/selinux/include/security.h        |   6 ++
>  6 files changed, 118 insertions(+), 3 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 335fbf76cdd2..ef9771542737 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -733,6 +733,8 @@ static int selinux_set_mnt_opts(struct super_block *s=
b,
>                 goto out;
>         }
>
> +       sbsec->creator_sid =3D current_sid();
> +
>         if (strcmp(sb->s_type->name, "proc") =3D=3D 0)
>                 sbsec->flags |=3D SE_SBPROC | SE_SBGENFS;
>
> @@ -7002,9 +7004,13 @@ static int selinux_ib_alloc_security(void *ib_sec)
>  static int selinux_bpf(int cmd, union bpf_attr *attr,
>                        unsigned int size, bool kernel)
>  {
> +       bool bpf_token_perms =3D selinux_policycap_bpf_token_perms();
>         u32 sid =3D current_sid();
>         int ret;
>
> +       if (bpf_token_perms)
> +               return 0;

Why are you just returning 0 here instead of checking the permissions
of the token regardless? Since you appear to do that in
selinux_bpf_token_create, selinux_bpf_map_create and
selinux_bpf_prog_load.

> +
>         switch (cmd) {
>         case BPF_MAP_CREATE:
>                 ret =3D avc_has_perm(sid, sid, SECCLASS_BPF, BPF__MAP_CRE=
ATE,
> @@ -7086,10 +7092,34 @@ static int selinux_bpf_prog(struct bpf_prog *prog=
)
>                             BPF__PROG_RUN, NULL);
>  }
>
> +static int selinux_bpffs_creator_sid(const union bpf_attr *attr)
> +{
> +       struct path path;
> +       struct super_block *sb;
> +       struct superblock_security_struct *sbsec;
> +
> +       CLASS(fd, f)(attr->token_create.bpffs_fd);
> +
> +       if (!fd_file(f))
> +               return SECSID_NULL;

Is it possible for this value to be null assuming there is not a bug
in the kernel? You would not want to do a runtime check for something
that would indicate a kernel bug lest you accidentally hide the bug.

> +
> +       path =3D fd_file(f)->f_path;
> +       sb =3D path.dentry->d_sb;
> +       if (!sb)
> +               return SECSID_NULL;

I do not think this value should ever be null barring a bug in the kernel.

> +
> +       sbsec =3D selinux_superblock(sb);
> +       if (!sbsec)
> +               return SECSID_NULL;

Again, I do not think this value should ever be null barring a bug in
the kernel.

> +
> +       return sbsec->creator_sid;
> +}
> +
>  static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *a=
ttr,
>                                   struct bpf_token *token, bool kernel)
>  {
>         struct bpf_security_struct *bpfsec;
> +       u32 ssid;
>
>         bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>         if (!bpfsec)
> @@ -7098,7 +7128,15 @@ static int selinux_bpf_map_create(struct bpf_map *=
map, union bpf_attr *attr,
>         bpfsec->sid =3D current_sid();
>         map->security =3D bpfsec;
>
> -       return 0;
> +       if (!token)
> +               ssid =3D bpfsec->sid;
> +       else {
> +               ssid =3D selinux_bpffs_creator_sid(attr);
> +               if (ssid =3D=3D SECSID_NULL)
> +                       return -EPERM;

Should this ever be null? See above (for this and all repeated
occurrences of this check).

> +       }
> +
> +       return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__MAP_CRE=
ATE, NULL);

In the token case, why is this not already handled by selinux_bpf_token_cre=
ate?

>  }
>
>  static void selinux_bpf_map_free(struct bpf_map *map)
> @@ -7113,6 +7151,7 @@ static int selinux_bpf_prog_load(struct bpf_prog *p=
rog, union bpf_attr *attr,
>                                  struct bpf_token *token, bool kernel)
>  {
>         struct bpf_security_struct *bpfsec;
> +       u32 ssid;
>
>         bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>         if (!bpfsec)
> @@ -7121,7 +7160,15 @@ static int selinux_bpf_prog_load(struct bpf_prog *=
prog, union bpf_attr *attr,
>         bpfsec->sid =3D current_sid();
>         prog->aux->security =3D bpfsec;
>
> -       return 0;
> +       if (!token)
> +               ssid =3D bpfsec->sid;
> +       if (token) {
> +               ssid =3D selinux_bpffs_creator_sid(attr);
> +               if (ssid =3D=3D SECSID_NULL)
> +                       return -EPERM;
> +       }
> +
> +       return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__PROG_LO=
AD, NULL);
>  }
>
>  static void selinux_bpf_prog_free(struct bpf_prog *prog)
> @@ -7132,10 +7179,18 @@ static void selinux_bpf_prog_free(struct bpf_prog=
 *prog)
>         kfree(bpfsec);
>  }
>
> +#define bpf_token_cmd(T, C) \
> +       ((T)->allowed_cmds & (1ULL << (C)))
> +
>  static int selinux_bpf_token_create(struct bpf_token *token, union bpf_a=
ttr *attr,
>                                     const struct path *path)
>  {
>         struct bpf_security_struct *bpfsec;
> +       u32 sid =3D selinux_bpffs_creator_sid(attr);
> +       int err;
> +
> +       if (sid =3D=3D SECSID_NULL)
> +               return -EPERM;
>
>         bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>         if (!bpfsec)
> @@ -7144,6 +7199,29 @@ static int selinux_bpf_token_create(struct bpf_tok=
en *token, union bpf_attr *att
>         bpfsec->sid =3D current_sid();
>         token->security =3D bpfsec;
>
> +       bpfsec->perms =3D 0;
> +
> +       /**
> +        * 'token->allowed_cmds' is a bit mask of allowed commands
> +        * Convert the BPF command enum to a bitmask representing its pos=
ition in the
> +        * allowed_cmds bitmap.
> +        */
> +       if (bpf_token_cmd(token, BPF_MAP_CREATE)) {
> +               err =3D avc_has_perm(bpfsec->sid, sid, SECCLASS_BPF, BPF_=
_MAP_CREATE_AS, NULL);
> +               if (err)
> +                       return err;
> +
> +               bpfsec->perms |=3D BPF__MAP_CREATE;
> +       }
> +
> +       if (bpf_token_cmd(token, BPF_PROG_LOAD)) {
> +               err =3D avc_has_perm(bpfsec->sid, sid, SECCLASS_BPF, BPF_=
_PROG_LOAD_AS, NULL);
> +               if (err)
> +                       return err;
> +
> +               bpfsec->perms |=3D BPF__PROG_LOAD;
> +       }
> +
>         return 0;
>  }
>
> @@ -7154,6 +7232,30 @@ static void selinux_bpf_token_free(struct bpf_toke=
n *token)
>         token->security =3D NULL;
>         kfree(bpfsec);
>  }
> +
> +static int selinux_bpf_token_cmd(const struct bpf_token *token, enum bpf=
_cmd cmd)
> +{
> +       struct bpf_security_struct *bpfsec;
> +
> +       if (!token || !token->security)
> +               return -EINVAL;

Not sure if these should ever be null barring a kernel bug either.
