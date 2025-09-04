Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B87C1DBB2E;
	Thu,  4 Sep 2025 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996901; cv=none; b=H4BJonHVGyt77JzEJnDUd9DVcP1vjuCOrI4iHj7vjFzjtG8NaJuhQeQWiwsk9ChtHyGQLWOjbekgaogFCLjOID5ZWbWSrIDQnkvjKaS2ZpEHorKeHxYCCMEKc0FFurMMNmcxClYWpSvlpl40cVaFoJYvzrRD02FaAM5wRehwbi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996901; c=relaxed/simple;
	bh=2joExFgktJ0U04+oEfwxmaLUEusCRafxUPE6bI/EK10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuIlzQ7KgrVX7fVGqRDIx4rYpiBDRO/QcZe8DAcUh7F3eDEi9dd/Oc3kR8zJc+wFBCs52o4Iu4pVnegABHNvXeNucEEBW0/om6mreWYBjpiFwqWuKPh5m4Wsi7qO9yFtdOfuJ92MYw6H7E/W7VfKyGzqkid/qBF13aX4W/7ohnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2h9lGDj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2h9lGDj"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77281ea2dc7so963112b3a.2;
        Thu, 04 Sep 2025 07:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756996899; x=1757601699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKg/ZYGNwFgwY5/RisX+55mfydlp6tmDkwSYcmTW7/U=;
        b=J2h9lGDjYJx1xgZS6sMIBc2EkU+XwYBUlSesD9voyi+LBYJEQrXcUR0GI9J4t6tCAl
         FGRtj6XHuPqdZjVdFzv39hOQ0tnNlFq0bztZ2ZL2PvlNI1QElyBvcs0/zVmjmMX9UqXt
         +FA/9XaalxkwA/6ZZpfEZjoLY2z9Ky0xp6GAEy7VVMbv77ipnWF5LgJ4l+gcQ2HllH1I
         VOdaaZd7vT3ZFPWGv0/CImgXPwyzHZqQIhsQ7LuXgL691lPy4fzdhFAD+qtix8xh5qgN
         0TbJAkyhybo132Tnvl/46PUCk3i7vdf+1xOdPVaE0KmQgVIRNhy6iI4CT5e3VpxqX4j0
         wnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756996899; x=1757601699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKg/ZYGNwFgwY5/RisX+55mfydlp6tmDkwSYcmTW7/U=;
        b=N7KMRj/y77fFneKNec9MrBXBaCYC/q6Y9SE3Si4rbjcSTA6MOaFMwdbrS9iglFXyd4
         5rJR8eGodoNZe589JqyNV3qLSxMtOcyqHhELocFtOXzzsDrtTbIWhTBVPk5Xhel5wkmO
         QbRfH35y3ZzPwT0YDt5g+jh/wer4Q7OB3NeSrl19lLvis/0lj8uUgQFjk4Ijj9Kfucjj
         2WzPhxa8Tx0vmUL+X+I1s1lO1/jklfvbBgsakEwocTDLxvzVtTK4z6W/Zi58jMR+Twfg
         yYcjJl9THOwNpaC+55oVuCidhj+tvb9ALgqk6xTgatTqSoA+TDq831Tu9aT/bnomVjPl
         NdSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUKB09hculV4B6fLGq3M9eGFZUps+G97uWZSjhDbwz3gfu6w6xHRR29OKYayvPj9sFBGSrxXsulEqveVtpMz3pKS9Xnhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjybGZ4rzpt5HHIOLVjt1LPYquI9jFDoz6XWj86cx5pgqI3el1
	w7rWyRuOhleEUcSlCGGFpyo/+pXkIL6G/QmuzxykWa4mxF6MHPD5c+HXBRp5HA9KI6sjccAQEuH
	nAbF4yC9bs0fLGdbhUk2JpVlSzn/HUhN90Q==
X-Gm-Gg: ASbGncvNUppLCB/a4v7bkTBZAtNlcJwds0HJ+ztYBxR7q8jLt/X5f/f2lCKs6YwFmdj
	3CEWpmbKJayHxs6TXDNSHsi3bo8QzvW6W09tkO3H2n36mlUzu0yYiCfM3Rd1IfFZcPWPFb8FVha
	hneyv9u4tFbabj8I/yc8q/JRfUQkE8KaAN8WRrBIAo+ZmM1bU+WNwcCdRHdgz8uS9OIhDPOqqYf
	t3cOFw=
X-Google-Smtp-Source: AGHT+IHL8L0IyBSI0YwefsTZgL+7gj28TISq8IwGp3PZBLIGpxsmtmOKbRPdhMZ/Pf+Zz2Yijir5itMvp9NqerXojUU=
X-Received: by 2002:a05:6a20:4322:b0:243:b8c8:a25a with SMTP id
 adf61e73a8af0-243d6dc8911mr26848466637.4.1756996898881; Thu, 04 Sep 2025
 07:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903192426.215857-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250903192426.215857-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 4 Sep 2025 10:41:26 -0400
X-Gm-Features: Ac12FXzxOlJoLDmy2ATTu3V44F-DSNF1fg17qEQNjJ1YxNNV0JFKsFzhuSmwBLM
Message-ID: <CAEjxPJ4ctFLY=_AUaNso_a4XJ8AziRoebR2ExFss_s3qNnYhJA@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm,selinux: introduce LSM_ATTR_UNSHARE and wire it
 up for SELinux
To: selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com, john.johansen@canonical.com, 
	serge@hallyn.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 3:28=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> In the hopes of nudging the conversation in [1] in a more focused
> direction with a goal of getting SELinux namespaces upstreamed, this
> RFC provides a starting point for a concrete discussion. This is RFC
> only and has only been build-tested thus far.
>
> This defines a new LSM_ATTR_UNSHARE attribute for the
> lsm_set_self_attr(2) system call and wires it up for SELinux to invoke
> the underlying function for unsharing the SELinux namespace. As with
> the selinuxfs interface, this immediately unshares the SELinux
> namespace of the current process just like an unshare(2) system call
> would do for other namespaces. I have not yet explored the
> alternatives of deferring the unshare to the next unshare(2),
> clone(2), or execve(2) call and would want to first confirm that doing
> so does not introduce any issues in the kernel or make it harder to
> integrate with existing container runtimes.
>
> Differences between this syscall interface and the selinuxfs interface
> that need discussion before moving forward:
>
> 1. The syscall interface does not currently check any Linux capability
> or DAC permissions, whereas the selinuxfs interface can only be set by
> uid-0 or CAP_DAC_OVERRIDE processes. We need to decide what if any
> capability or DAC check should apply to this syscall interface and if
> any, add the checks to either the LSM framework code or to the SELinux
> hook function.
>
> Pros: Checking a capability or DAC permissions prevents misuse of this
> interface by unprivileged processes, particularly on systems with
> policies that do not yet define any of the new SELinux permissions
> introduced for controlling this operation. This is a potential concern
> on Linux distributions that do not tightly coordinate kernel updates
> with policy updates (or where users may choose to deploy upstream
> kernels on their own), but not on Android.
>
> Cons: Checking a capability or DAC permissions requires any process
> that uses this facility to have the corresponding capability or
> permissions, which might otherwise be unnecessary and create
> additional risks. This is less likely if we use a capability already
> required by container runtimes and similar components that might
> leverage this facility for unsharing SELinux namespaces.
>
> 2. The syscall interface checks a new SELinux unshare_selinuxns
> permission in the process2 class between the task SID and itself,
> similar to other checks for setting process attributes. This means
> that:
>     allow domain self:process2 *; -or-
>     allow domain self:process2 ~anything-other-than-unshare_selinuxns; -o=
r-
>     allow domain self:process2 unshare_selinuxns;
> would allow a process to unshare its SELinux namespace.
>
> The selinuxfs interface checks a new unshare permission in the
> security class between the task SID and the security initial SID,
> likewise similar to other checks for setting selinuxfs attributes.
> This means that:
>     allow domain security_t:security *; -or-
>     allow domain security_t:security ~anything-other-than-unshare; -or-
>     allow domain security_t:security unshare;
> would allow a process to unshare its SELinux namespace.
>
> Technically, the selinuxfs interface also currently requires open and
> write access to the selinuxfs node; hence:
>     allow domain security_t:file { open write };
> is also required for the selinuxfs interface.
>
> We need to decide what we want the SELinux check(s) to be for the
> syscall and whether it should be more like the former (process
> attributes) or more like the latter (security policy settings). Note
> that the permission name itself is unimportant here and only differs
> because it seemed less evident in the process2 class that we are
> talking about a SELinux namespace otherwise.
>
> Regardless, either form of allow rule can be prohibited in policies
> via neverallow rules on systems that enforce their usage
> (e.g. Android, not necessarily on Linux distributions).
>
> 3. The selinuxfs interface currently offers more functionality than I
> have implemented here for the sycall interface, including:
>
> a) the ability to read the selinuxfs node to see if your namespace has
> been unshared, which should be easily implementable via
> lsm_get_self_attr(2).  However, questions remain as to when that
> should return 1 versus 0 (currently returns 1 whenever your namespace
> is NOT the initial SELinux namespace, useful for the testsuite to
> detect it is in a child, but could instead be reset to 0 by a
> subsequent policy load to indicate completion of the setup of the
> namespace, thus hiding from child processes that they are in a child
> namespace once its policy has been loaded).
>
> b) the abilities to get and set the maximum number of SELinux
> namespaces (via a /sys/fs/selinux/maxns node) and to get and set the
> maximum depth for SELinux namespaces (via a /sys/fs/selinux/maxnsdepth
> node). These could be left in selinuxfs or migrated to some other LSM
> management APIs since they are global in scope, not per-process
> attributes.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  include/uapi/linux/lsm.h            | 1 +
>  security/selinux/hooks.c            | 8 ++++++++
>  security/selinux/include/classmap.h | 4 +++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index 938593dfd5da..fb1b4a8aa639 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -83,6 +83,7 @@ struct lsm_ctx {
>  #define LSM_ATTR_KEYCREATE     103
>  #define LSM_ATTR_PREV          104
>  #define LSM_ATTR_SOCKCREATE    105
> +#define LSM_ATTR_UNSHARE       106
>
>  /*
>   * LSM_FLAG_XXX definitions identify special handling instructions
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c544b3e2fd5c..11b0b3c5b74a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6812,6 +6812,10 @@ static int selinux_lsm_setattr(u64 attr, void *val=
ue, size_t size)
>                 error =3D avc_has_perm(state, mysid, mysid, SECCLASS_PROC=
ESS,
>                                      PROCESS__SETCURRENT, NULL);
>                 break;
> +       case LSM_ATTR_UNSHARE:
> +               error =3D avc_has_perm(state, mysid, mysid, SECCLASS_PROC=
ESS,

Ignore the obvious typo here (should be SECCLASS_PROCESS2 above). Will
be fixed before submission. Otherwise, the RFC remains the same.

> +                                    PROCESS2__UNSHARE_SELINUXNS, NULL);
> +               break;
>         default:
>                 error =3D -EOPNOTSUPP;
>                 break;
> @@ -6923,6 +6927,10 @@ static int selinux_lsm_setattr(u64 attr, void *val=
ue, size_t size)
>                 }
>
>                 tsec->sid =3D sid;
> +       } else if (attr =3D=3D LSM_ATTR_UNSHARE) {
> +               error =3D selinux_state_create(new);
> +               if (error)
> +                       goto abort_change;
>         } else {
>                 error =3D -EINVAL;
>                 goto abort_change;
> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index be52ebb6b94a..07fe316308cd 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -60,7 +60,9 @@ const struct security_class_mapping secclass_map[] =3D =
{
>             "siginh",       "setrlimit",     "rlimitinh",   "dyntransitio=
n",
>             "setcurrent",   "execmem",       "execstack",   "execheap",
>             "setkeycreate", "setsockcreate", "getrlimit",   NULL } },
> -       { "process2", { "nnp_transition", "nosuid_transition", NULL } },
> +       { "process2",
> +         { "nnp_transition", "nosuid_transition", "unshare_selinuxns",
> +           NULL } },
>         { "system",
>           { "ipc_info", "syslog_read", "syslog_mod", "syslog_console",
>             "module_request", "module_load", "firmware_load",
> --
> 2.51.0
>
