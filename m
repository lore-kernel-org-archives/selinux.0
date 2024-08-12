Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F371953B9
	for <selinux@vger.kernel.org>; Mon, 12 Aug 2024 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723501633; cv=none; b=jf7JYfKGdIFDG/9b5pD0BDdnIp0cnISKaHhF1LO8cD8CFMuq9Lm0MNieml5hbzY/6euIF+iLSYc7YmkyD7rQ0DIBLMPB2vmYKsg27BSfVGVPlQVMGYA12YxaOL17S77QrGiFGdRdL5OdcfDtfZsaoSUxXECu0CvNKGDIkUshWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723501633; c=relaxed/simple;
	bh=dy7yOK5MzrqWEl/2qwfUfcl8WE2x7M7W0zWgkIY9jxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRybpj4YiAq5gCxl/lI6eEEQKYAS19he/vdQbea+wr4yWNqIuCWinAtS/KtYah1WfnhmUZAqfZlK/mHTpIH0Hk1DEHBpLFCHUBAc9DaqYF/OpQsE35J29drIaSxOE6kmu0PYL9UN7ACvISYeLV99nbt+5bw3riZi0PbNpa7MmYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ig4Il0MQ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ig4Il0MQ"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e08724b2a08so4369120276.1
        for <selinux@vger.kernel.org>; Mon, 12 Aug 2024 15:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723501629; x=1724106429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGTDaCBmHOMVHiR+ZwnCuo7FNJpxQ7Tx+L0Axwmh5TE=;
        b=Ig4Il0MQd8YTXQ+EsgnKQ0zp79VBLraVEnqa0FH7vuWWtDbYeuk4jt1iAWcgWp0l2B
         /SRY2oEOBsepRWJMUklOeIp2UQP1DnNkrUPL/tdfCGw5wsUuhmI8TiEJXnrczmcp6h6i
         hyyYm6KlZysdVeX6yy6BY4XbvJhq4gCo87nZ6P+AxXll8zN7Iq3w/92en/1B8EMEzOPC
         pb7IYoDFXumQ0HV/abEfmSpeWlcpV/25iZ0t6ltaqX++O1xKh6YLeSOekvVwhuVN9lTn
         dYzlKXB3qq0UHoNB2xASJS7DQR9J5sTYwoeryyY5GObGTWVRULZi0dtBN2ohcJzciHzo
         YXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723501629; x=1724106429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGTDaCBmHOMVHiR+ZwnCuo7FNJpxQ7Tx+L0Axwmh5TE=;
        b=PENZboQtlEkhRrzu0i8YknlRRgTMDc2LlHPy8AVTCtS1DuS58y8eBZPbtmXsR9o2+x
         wyJb75hQMYFcym0FDTe2x1m8d/Sv12jZe19ox4x+krYcirGyf1+MA2ND1LK1D1oxRG9z
         yRlTdWK75ljEQZgUEcUCMF5IMuEtb95rn7uc9VWDUmGF4sxMqDzoud9ghqKBGcAJI3Yb
         dffq/ODvISpD4XNEltQSQuGGO99OHFk0qn3T01Vvy5WzsJUX2dyJLO16HF/pa4HMVXM8
         C++cG3Ma/cxIYQUjLU/NUZ6ExNB5pEj1eIwXSUC14h9awY1MRwItsi3wDBlDYAcwOSoO
         lvhA==
X-Forwarded-Encrypted: i=1; AJvYcCVEnwjtux2jaxg4IVyyAED9gh/dXk98L61XJdg/KlI2pHwTJUeTLzavxFAORZTDfXlLIOyhOMViXSQ3wz1I2p/CQ1kIabizCw==
X-Gm-Message-State: AOJu0YzHhBGHWExuMIobHs3AGtCOEDfw3QL53Wz0VKXHdLSSghov7FNN
	d7+jLXF/aKEInSFwJ2mFgINpGvqFKyja0oA88EBFRR1xiSis9f84QYcroz20iAT4xFHGascRhmK
	qzzbWWuOMaGPCFuPNyitVpC88YIgKeSKmT9v9
X-Google-Smtp-Source: AGHT+IFKS+2caDqbod6lgEZY+lXsHCMzFjTHVsd+WMqpxPo/oYF8GwR074R9hauT/EOenbd7MmFhLQe842tyQml1hds=
X-Received: by 2002:a05:6902:1883:b0:e0b:26d4:6d1c with SMTP id
 3f1490d57ef6-e113cec05f5mr2548017276.26.1723501629050; Mon, 12 Aug 2024
 15:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812174421.1636724-1-mic@digikod.net>
In-Reply-To: <20240812174421.1636724-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Aug 2024 18:26:58 -0400
Message-ID: <CAHC9VhRp5hMsmZ9jUok+5c20U37XLiXmoEAguorTqRF5MQq2Gg@mail.gmail.com>
Subject: Re: [PATCH v2] fs,security: Fix file_set_fowner LSM hook inconsistencies
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 1:44=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> The fcntl's F_SETOWN command sets the process that handle SIGIO/SIGURG
> for the related file descriptor.  Before this change, the
> file_set_fowner LSM hook was used to store this information.  However,
> there are three issues with this approach:
>
> - Because security_file_set_fowner() only get one argument, all hook
>   implementations ignore the VFS logic which may not actually change the
>   process that handles SIGIO (e.g. TUN, TTY, dnotify).
>
> - Because security_file_set_fowner() is called before f_modown() without
>   lock (e.g. f_owner.lock), concurrent F_SETOWN commands could result to
>   a race condition and inconsistent LSM states (e.g. SELinux's fown_sid)
>   compared to struct fown_struct's UID/EUID.
>
> - Because the current hook implementations does not use explicit atomic
>   operations, they may create inconsistencies.  It would help to
>   completely remove this constraint, as well as the requirements of the
>   RCU read-side critical section for the hook.
>
> Fix these issues by replacing f_owner.uid and f_owner.euid with a new
> f_owner.cred [1].  This also saves memory by removing dedicated LSM
> blobs, and simplifies code by removing file_set_fowner hook
> implementations for SELinux and Smack.
>
> This changes enables to remove the smack_file_alloc_security
> implementation, Smack's file blob, and SELinux's
> file_security_struct->fown_sid field.
>
> As for the UID/EUID, f_owner.cred is not always updated.  Move the
> file_set_fowner hook to align with the VFS semantic.  This hook does not
> have user anymore [2].
>
> Before this change, f_owner's UID/EUID were initialized to zero
> (i.e. GLOBAL_ROOT_UID), but to simplify code, f_owner's cred is now
> initialized with the file descriptor creator's credentials (i.e.
> file->f_cred), which is more consistent and simplifies LSMs logic.  The
> sigio_perm()'s semantic does not need any change because SIGIO/SIGURG
> are only sent when a process is explicitly set with __f_setown().
>
> Rename f_modown() to __f_setown() to simplify code.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Link: https://lore.kernel.org/r/20240809-explosionsartig-ablesen-b039dbc6=
ce82@brauner [1]
> Link: https://lore.kernel.org/r/CAHC9VhQY+H7n2zCn8ST0Vu672UA=3D_eiUikRDW2=
sUDSN3c=3DgVQw@mail.gmail.com [2]
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>
> Changes since v1:
> https://lore.kernel.org/r/20240812144936.1616628-1-mic@digikod.net
> - Add back the file_set_fowner hook (but without user) as
>   requested by Paul, but move it for consistency.
> ---
>  fs/fcntl.c                        | 42 +++++++++++++++----------------
>  fs/file_table.c                   |  3 +++
>  include/linux/fs.h                |  2 +-
>  security/security.c               |  5 +++-
>  security/selinux/hooks.c          | 22 +++-------------
>  security/selinux/include/objsec.h |  1 -
>  security/smack/smack.h            |  6 -----
>  security/smack/smack_lsm.c        | 39 +---------------------------
>  8 files changed, 33 insertions(+), 87 deletions(-)
>
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 300e5d9ad913..4217b66a4e99 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -87,8 +87,8 @@ static int setfl(int fd, struct file * filp, unsigned i=
nt arg)
>         return error;
>  }
>
> -static void f_modown(struct file *filp, struct pid *pid, enum pid_type t=
ype,
> -                     int force)
> +void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
> +               int force)
>  {
>         write_lock_irq(&filp->f_owner.lock);
>         if (force || !filp->f_owner.pid) {
> @@ -97,20 +97,15 @@ static void f_modown(struct file *filp, struct pid *p=
id, enum pid_type type,
>                 filp->f_owner.pid_type =3D type;
>
>                 if (pid) {
> -                       const struct cred *cred =3D current_cred();
> -                       filp->f_owner.uid =3D cred->uid;
> -                       filp->f_owner.euid =3D cred->euid;
> +                       security_file_set_fowner(filp);
> +                       put_cred(rcu_replace_pointer(
> +                               filp->f_owner.cred,
> +                               get_cred_rcu(current_cred()),
> +                               lockdep_is_held(&filp->f_owner.lock)));
>                 }
>         }
>         write_unlock_irq(&filp->f_owner.lock);
>  }

Looking at this quickly, why can't we accomplish pretty much the same
thing by moving the security_file_set_fowner() into f_modown (as
you've done above) and leveraging the existing file->f_security field
as Smack and SELinux do today?  I'm seeing a lot of churn to get a
cred pointer into fown_struct which doesn't seem to offer that much
additional value.

From what I can see this seems really focused on adding a cred
reference when it isn't clear an additional one is needed.  If a new
cred reference *is* needed, please provide an explanation as to why;
reading the commit description this isn't clear.  Of course, if I'm
mistaken, feel free to correct me, although I'm sure all the people on
the Internet don't need to be told that ;)

--=20
paul-moore.com
