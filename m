Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA523A9D96
	for <selinux@vger.kernel.org>; Thu,  5 Feb 2026 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294398; cv=pass; b=ANlKy+xPRnaYBmQKlnHGj+GYzVVlBsXUwrurZYiwbSn3BKoUNAfEb3VSA1VpwKu7dC0bh8PZBM5MQt/6KclQOOMkjgmSMgThKKmvTYGFHghQIN0Fz3zvuUmJ2K/ukmIRR5J0Dn88426bdFejluGM1vR9Mi0Yaw4qxCIWlOX8Z8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294398; c=relaxed/simple;
	bh=C5vOLxPnRhY6qi4kHmtoIzIplBE7B/w6zl9ie5PvVMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQkQPE9Gwl7T5yBxjGp1xW7t7moC8+5Nz/LcoUXyitXrjz/k2Zd0RHBQnE9lTZ+R0FavZ4mqlTGQ3oXbv1iOA/abZXeOI1I4U9TqBvelIWmDzKmKAvgJDKo3IhFypTCDTmLnqngq0oAHxVW2MTR6ahMWLp9utK2ctCSFCGtnqTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ/kpL9h; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ/kpL9h"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6581327d6baso1385919a12.3
        for <selinux@vger.kernel.org>; Thu, 05 Feb 2026 04:26:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770294396; cv=none;
        d=google.com; s=arc-20240605;
        b=QeCOK4H4xpl8cIPDWyjpN2CpevGXD+zc278k1K8i5LeXxKf1zjF1qVkjBh59KZgd+B
         BBZAkeyFOi6EY5Lay4NthjPbnEHkvEWLrosuFQzIxAYv69d2J5PM/Ru1EM+RlLk8uyar
         jfHK8XLECkqReig2IQjeYg19Mb7KEUsrY1I3gYKrhmrDZ7XUaQgXZ0QyDx7dfSM5arWH
         KuApNYgbeKvoeTIZiZcLXWNk6VbHuEg9Y0ttZfcDi5tjt4dzMrFW2JdzEKy1LaZnwh+E
         x1lpnMygNj4X41YQDJrYGEiyAtjDnI6hKnkz88+5E9b4vQBf9zPmJCQxca892Alv3JFO
         2vBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UfB0UXxHCYVgd7CIr3QzJ56G7ROPE9D9qGfdOM8KDP8=;
        fh=AxfQcRCm5c+GsNUuyMd7DRMiIL+hCC58xM6G0ifOErQ=;
        b=fI4LEpqaOSlnb7UxHHcBZI3cugHM+mmknOY1VC4HAxiIyG4Kvg/tSXNK+RZy9QIHJY
         KFB52zysz7rzD0RwW8Qr+pIBVzDtnm9t7A7RPedTye/G0W6dXY9KGqhXyjZE0SYM3m/J
         GralE0aCGbkp7tGZFQeThpFUS1xfdoQHf8yosoeLNZykRnKUA1IEBkWpR2B1cg6a0XZa
         WgGxEyMrylOy1/x91pR7XdYZM9uYGJTB8lkM6DyKxYwjlqAB6sIwyCCNaSCGFNlVKOE2
         6ev9wbgeHqWYNek7rd8twY1CMa3dl2HZaM7o0iMQVdnRgBkVfdqmEjdBqo4B9T2UwtNV
         eDnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770294396; x=1770899196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfB0UXxHCYVgd7CIr3QzJ56G7ROPE9D9qGfdOM8KDP8=;
        b=fZ/kpL9hZrFuXxqlS1kf2FfrnO/ztwaBbfZ/BlG0wBhoFgNZEsapLLAefnFQgMqkq1
         XXvGhaSwnWhmNbZikkTCHoBgcVDl2axU+pJ+wlbZMXdx4fHUB2xuMNyZ261p+ZgJ3qup
         xhcqU3iR0u6y7+u8IPd2D9FCJgEmXsQnr6SFDs7c5/IrEwrqYFAmk7SLoD1I3Z6hudiw
         NfL9PkCt9G1fmewoD7gqXVEV006stKo16cyVFIJ9soAxUyxzATAbArOcRxmZNb3v95iw
         yt7t3Qf5K7kDqDaPrewJLZ+f2OmdX8RJOgo7zjinRhCbBk6sG+ARRxe6RSVg9Pg5Zh8N
         Yk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770294396; x=1770899196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UfB0UXxHCYVgd7CIr3QzJ56G7ROPE9D9qGfdOM8KDP8=;
        b=g5P7OIjycPaygvn2yvRnsiMc6t0eRo5uPjEERIGp6YQF8oPiuoGaDQmjUu7X9z0KFm
         e3fKGNVIctUegFX8k+qVsNZ1T+TRVN9D01TNM/1oBaVQoD+rRNXzVbuSWdlPHcl/xXrL
         f8t+m+WCG3lRP1RxCFbpMqvLIFnk+mAV4M5OcNs3wCR16FnxeNkxTEKwn+PxUM5Fv5v3
         TTcMGgyrj1NxfVBfnRo6Tmho4yRlHyDupyZlW52A8lQ+T+C54uo0L+tKJm7jW+k7LfYd
         F0+1GJtANnAyiPDizW530kPahPpCsQsYNqP6YpHRokAatQexGTfplAP8sh60ob0tON/f
         zJXg==
X-Forwarded-Encrypted: i=1; AJvYcCVwawVdSsP+ARlw+aA3ayy0cdXrzd9V6F6u9R9C1urPg6xfYWAoYsPNigkkSqRpC9xzjprYhsB1@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+zGreeLUY1rYNo1WebIr4zKYthnXdgX6Ukw3NP0Sk5vkkY+C
	OjJPv0TzohT/Mkc4QiXRdTCu1Keh50YnOHBMR93dDF5TaQCYOTXroMrRjV+X+GhNNp+U8G9aic7
	0DpyuChcu8Ti7IEUH6DUrYNpRnhswkbZU52pq8qhxvw==
X-Gm-Gg: AZuq6aJFvAfm/DKMWhCEgjKi5lNFNPqliV/KcKS1xxd5MraA1acmO2x2BgfSF2jVgK6
	Rdr7j+AuQyYErRQExBaNx+xDobe2kB+fY0Txog6+aKAWL2QzNY1Neoi4mdCPRSGI353kg1IsU+S
	yD0v9B9RHqcSkdeLBdifYTeLaltXZgoowRj9sCXUiVSIFMYJT0xL1x+uY7hUgjyjmHVR5bO7WPz
	NwGerlmRBCDstGY9aWmm53MSqET5N+2LtlfiOTCXbIK+PfwYtJkYK9QyDe93w+i5LAMj+GWI0w3
	3AuBMGzPBU5LGniUtXZ5iqa4rVmQ+A==
X-Received: by 2002:a05:6402:2711:b0:658:da9:787d with SMTP id
 4fb4d7f45d1cf-65949dc2762mr3243637a12.21.1770294396096; Thu, 05 Feb 2026
 04:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-11-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-11-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 13:26:24 +0100
X-Gm-Features: AZwV_QhSomAYq3e-9LVlkwiUvLVwnQqEgYbdyasP4aBJdb_z_a8NyX57euMmGhk
Message-ID: <CAOQ4uxh-MLgwZCstwr6HyPXHVRmtj2F_=xS8pE3FN6Ex-wex4w@mail.gmail.com>
Subject: Re: [PATCH 10/13] ovl: change ovl_create_real() to get a new lock
 when re-opening created file.
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> When ovl_create_real() is used to create a file on the upper filesystem
> it needs to return the resulting dentry - positive and hashed.
> It is usually the case the that dentry passed to the create function
> (e.g.  vfs_create()) will be suitable but this is not guaranteed.  The
> filesystem may unhash that dentry forcing a repeat lookup next time the
> name is wanted.
>
> So ovl_create_real() must be (and is) aware of this and prepared to
> perform that lookup to get a hash positive dentry.
>
> This is currently done under that same directory lock that provided
> exclusion for the create.  Proposed changes to locking will make this
> not possible - as the name, rather than the directory, will be locked.
> The new APIs provided for lookup and locking do not and cannot support
> this pattern.
>
> The lock isn't needed.  ovl_create_real() can drop the lock and then get
> a new lock for the lookup - then check that the lookup returned the
> correct inode.  In a well-behaved configuration where the upper
> filesystem is not being modified by a third party, this will always work
> reliably, and if there are separate modification it will fail cleanly.
>
> So change ovl_create_real() to drop the lock and call
> ovl_start_creating_upper() to find the correct dentry.  Note that
> start_creating doesn't fail if the name already exists.
>
> This removes the only remaining use of ovl_lookup_upper, so it is
> removed.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/dir.c       | 24 ++++++++++++++++++------
>  fs/overlayfs/overlayfs.h |  7 -------
>  2 files changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index ff3dbd1ca61f..ec08904d084d 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -219,21 +219,33 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, =
struct dentry *parent,
>                 err =3D -EIO;
>         } else if (d_unhashed(newdentry)) {
>                 struct dentry *d;
> +               struct name_snapshot name;
>                 /*
>                  * Some filesystems (i.e. casefolded) may return an unhas=
hed
> -                * negative dentry from the ovl_lookup_upper() call befor=
e
> +                * negative dentry from the ovl_start_creating_upper() ca=
ll before
>                  * ovl_create_real().


According to the new locking rules, if the hashed dentry itself is
the synchronization object, is it going to be allowed to
filesystem to unhash the dentry while the dentry still in the
"creating" scope? It is hard for me to wrap my head around this.

Or do we need this here because some filesystems (casefold in
particular) are not going to support parallel creations?

>                  * In that case, lookup again after making the newdentry
>                  * positive, so ovl_create_upper() always returns a hashe=
d
>                  * positive dentry.
> +                * As we have to drop the lock before the lookup a race
> +                * could result in a lookup failure.  In that case we ret=
urn
> +                * an error.
>                  */
> -               d =3D ovl_lookup_upper(ofs, newdentry->d_name.name, paren=
t,
> -                                    newdentry->d_name.len);
> -               dput(newdentry);
> -               if (IS_ERR_OR_NULL(d))
> +               take_dentry_name_snapshot(&name, newdentry);
> +               end_creating_keep(newdentry);
> +               d =3D ovl_start_creating_upper(ofs, parent, &name.name);
> +               release_dentry_name_snapshot(&name);

OK. not saying no to this (yet) but I have to admit that it is pretty
ugly that the callers of ovl_create_real() want to create a specific
stable name, which is could be passed in as const char *name
and yet we end up doing this weird dance here just to keep the name
from newdentry.

Thanks,
Amir.
