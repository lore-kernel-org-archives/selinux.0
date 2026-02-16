Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5E2328633
	for <selinux@vger.kernel.org>; Mon, 16 Feb 2026 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255545; cv=pass; b=drSXDe0Rqi/q0JNXvKkVpzG3+lQUXG1vvlyCrv9HFY9niepCWW2kLvR18cJkgeGI5QD0F0F2pARnGB6zdefbZaXyJeX5AVzmNFmmO4prNxiBCrpnKjMGxcELVQkVaaeTKCgNhcabPE2OESuCk/j+bcnDAmlA7O3ccJ0OAtnWD8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255545; c=relaxed/simple;
	bh=0WdtWYEHI09V+05DDbCwX5t6QJHUAd3cuf9OggMni3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q665FbFc/U7RJD2Hgp1LlMYAVsQQoPtCnUQk49NKBL8Cia+OnxQdtf2cTINw7RpJ3txr/amrXXBDn/AQ6QXemcJPK5UEwmBrz0OdZ4+l+NTUVHq6RxFB4Q5ViJBlkHrzpM9+KP0XNfrXjv1nuxPPQuXPj9U4jSuWcdy7zvzt+vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsNuEOh5; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsNuEOh5"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-658b6757f7fso6432855a12.1
        for <selinux@vger.kernel.org>; Mon, 16 Feb 2026 07:25:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771255543; cv=none;
        d=google.com; s=arc-20240605;
        b=HjBhuiwS5srMnOjDpXzgBmPuc0R0i/tUUOzD3SUEddOW8nhdsDT3dTlN9b44sXno0T
         bvwvVEXir6+6axGKfJNmirxyGDCJOklheAx+kMRV/sukPLIPa1MRCwM5hl4xnFjVHf+/
         DPp0WJ6zV/4NSTBjIyN0b1eoVo+b1p52zsPmw+eaysB1ZGYrCVokI0oqCnmlrSsb2WkO
         BxFsUnBs0hwoOk4YpSsxwXMSStYnAFTa6t2D3LfNd22MHDTtTL+f6BhdgFtWgwYf61Tt
         1y/gyW7pwYRhtL4W8A4CgeR7OU0eLge8STDjzLuZD8AB5zST6uSJb6i5TvA1CZXzL58k
         eU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a8y53YFMQ+PYRig6TGH6tdnzevZp9DGRe/1ufZbEm3k=;
        fh=Hgewe6MGyg78SuqPEUsWp9HjjYzolG7+X9N+8WslGPs=;
        b=BGSl+8lGQH9Dw5olkdguIz7jHOfbP/ljO2a8pIewKkpfXRdhjfBBPcjV151zeW7fNr
         nZHYn5OiduPoeEb8e1CNSIP6+nrUDwnqr523jnCNobvo9Rjm8dN7sMV+zAfiSh9DbDKB
         Bhzh9UhRLTQ1NrYz7U7GytxH7mA/LbSjWd9Gkt21f5ldRfaK7q/N5p3v5+y+UEQ7eUAG
         G2L4gfrVI8HfgHN9ly8pSf+dEjI/jY+A2MkwpaKBmcnN1eotRWGizQW6COjCP4MWvT38
         JkaODociooFUC1MP/YQORfvtX0gdCStEvWgQn6raz0SsRgaw9qKn6IwCOsKd+fl9bYIW
         FYlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771255543; x=1771860343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8y53YFMQ+PYRig6TGH6tdnzevZp9DGRe/1ufZbEm3k=;
        b=CsNuEOh52WRAGxSHidc+/x9Gnktz/c9FVE5FB1EcKq1X9mrZrVMnqgwwh21NcidTTu
         lMVJvD7djqUYMQcasW0KFtKnh3U152DI28pgBxdTM3ooGNF0khPKIzo0XUutevw6XX+J
         5EBgE0bASqwwrydhQcfX8kR9hcRhqXZIAIzz3OfDcSuV1ElT2PMuIOohhVP+h8QKzz6b
         HmZ3n4Rk941Y9SSVKdnENzPcwkqYa/g64gU35Kz4JAOJlzDIIu/HtDyyUTFHGzICPd8u
         cjwt/VbtSgStIRPj0BC7+/bJlAk/tuijL3J8AOH5jeNug1XPnxkQJSs1hRYea9EL38Xn
         GT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771255543; x=1771860343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a8y53YFMQ+PYRig6TGH6tdnzevZp9DGRe/1ufZbEm3k=;
        b=IZIOw8tftu0SAqgUa6OpAy+ncuwOhINASd9bCDYzUPs60JKtT8rUNG2myW1hgXvxkN
         LE6GPSs2gGEBbYx5HAfychjplU4hjvhFw9yQwkJQYaxiz+8iYoTUQrKyH04FWOf95xBd
         XwSBZsxfA0k5PuLaLke0jSIFEi7AHYoXqD7QsPzyq/FyWrn0l/dA1O8FLshbjJXoF1EI
         4L2f7vusMKdi3NNt85kf2GZOmnRjJ6d2K+2tLmcPIL0mFT2czdFBZ1H77D/iTVB57yLC
         zkZ1+jnjd3iXSbsI1+J9v1k8zRF6FF90Snkk1/gtlA8UqeNQxL75xr6crHHnD5aBQXuf
         aHmA==
X-Forwarded-Encrypted: i=1; AJvYcCWEHhcxD9GWGQcYQDPNzjCuEqKIZFpjx+Qo2CV5ZIQlWgnKBUPkrJ6ZqEp/pSBggZNkFEHKjpW5@vger.kernel.org
X-Gm-Message-State: AOJu0YwM9HIDu7UzojDtnqW9dKaqjS2WUDnzUkfHOXkJdK8FeLMz9z2b
	hoxHh4VPLoXl3HKJ5BB2I/Lr4uuXufNXi5aJ7DPS/mLSTTeDfsKgn6zDJ1BiauTOhipwU1MAok1
	3DQflfcYZB044gSxQEc/52KBIOi3J/B8=
X-Gm-Gg: AZuq6aIKMJrjKwBQSlSpKGlmQDJhUbPtkMWsUmE8p/5pksOX2sA5Lz3yWAcUo7aNxo6
	4oL8uNfLC73RjzWKFBaW1NwuKSdXl0zRzrOtC5z3QVkMVgSXaZ9J1nldm7Kx6Dp76Su/1l0IxMW
	gVvN9pB3bDAZ0V5UGhTJyeLJD5NfiKtRHEFGFqx8oKOH4vN91R2dd7k+P82wdvlQb2wriiZhVCy
	MLmmXDMvvEniZUywtr/FiC6aXOyC1FynMXdfA3MpZB/TGxk92EL6aLiciSQ08xV2qSpMptHWYvI
	wefp78rH
X-Received: by 2002:a17:907:2684:b0:b88:1e2:ed49 with SMTP id
 a640c23a62f3a-b8fc053d4a8mr461131666b.8.1771255542306; Mon, 16 Feb 2026
 07:25:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216150625.793013-1-omosnace@redhat.com> <20260216150625.793013-2-omosnace@redhat.com>
In-Reply-To: <20260216150625.793013-2-omosnace@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Feb 2026 16:25:31 +0100
X-Gm-Features: AaiRm509zvV_5nztV_clDc8zDOEZuzPTyg08_yWfQUzaOuSbDQzEo3YOHZWR_N4
Message-ID: <CAOQ4uxiggWbj6p4giuXgKkjdV1aOB5SO-4grEW_H7FCE6iw1=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] fanotify: avoid/silence premature LSM capability checks
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 5:06=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Make sure calling capable()/ns_capable() actually leads to access denied
> when false is returned, because these functions emit an audit record
> when a Linux Security Module denies the capability, which makes it
> difficult to avoid allowing/silencing unnecessary permissions in
> security policies (namely with SELinux).
>
> Where the return value just used to set a flag, use the non-auditing
> ns_capable_noaudit() instead.
>
> Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivi=
leged users")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index d0b9b984002fe..9c9fca2976d2b 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1615,17 +1615,18 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
>         pr_debug("%s: flags=3D%x event_f_flags=3D%x\n",
>                  __func__, flags, event_f_flags);
>
> -       if (!capable(CAP_SYS_ADMIN)) {
> -               /*
> -                * An unprivileged user can setup an fanotify group with
> -                * limited functionality - an unprivileged group is limit=
ed to
> -                * notification events with file handles or mount ids and=
 it
> -                * cannot use unlimited queue/marks.
> -                */
> -               if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
> -                   !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT)))
> -                       return -EPERM;
> +       /*
> +        * An unprivileged user can setup an fanotify group with
> +        * limited functionality - an unprivileged group is limited to
> +        * notification events with file handles or mount ids and it
> +        * cannot use unlimited queue/marks.

Please extend line breaks to 80 chars

> +        */
> +       if (((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
> +            !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT))) &&
> +           !capable(CAP_SYS_ADMIN))
> +               return -EPERM;
>
> +       if (!ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {

Not super pretty, but I don't have a better idea, so with line breaks fix
feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

>                 /*
>                  * Setting the internal flag FANOTIFY_UNPRIV on the group
>                  * prevents setting mount/filesystem marks on this group =
and
> @@ -1990,8 +1991,8 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>          * A user is allowed to setup sb/mount/mntns marks only if it is
>          * capable in the user ns where the group was created.
>          */
> -       if (!ns_capable(group->user_ns, CAP_SYS_ADMIN) &&
> -           mark_type !=3D FAN_MARK_INODE)
> +       if (mark_type !=3D FAN_MARK_INODE &&
> +           !ns_capable(group->user_ns, CAP_SYS_ADMIN))
>                 return -EPERM;
>
>         /*
> --
> 2.53.0
>
