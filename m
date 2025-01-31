Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A91B87FE
	for <selinux@vger.kernel.org>; Fri, 31 Jan 2025 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320828; cv=none; b=fTDCIjbWD1lOAqixYGoZp5GeNsb5aeux31Kx2P9swCL50DS6fPWjMFS5+aaXNCYVDqAG4CK15WV06iY1DFNqVBXV1Wo8yxZI00g800ev/0D3Rdmthfk49kLdRuoPoe/1vb3DKO7+TZtqFbKykXUAOWp/G+3xpGMtTZI7ln4jfNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320828; c=relaxed/simple;
	bh=3hgXlMVhcYDMAsw2gDN/SsigYYRtx/3Q0mYMmRqGjPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNSXYiNjsAlRXftAT5A/il+PTF2K24DMFZ5dfDn+7YgsBe3t/1uD2dUfqq/H468BaH5M3qECDtRSZKIDtDZMNeJORHLGQe1sbsobxv9mzW9ttm+hZMF/CB69apiZaDgQrOayoOsrojHONCutgo/kATCZQYWWiIlNlO3Sb7booPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=N/qek0Av; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="N/qek0Av"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46b1d40abbdso14748941cf.2
        for <selinux@vger.kernel.org>; Fri, 31 Jan 2025 02:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1738320824; x=1738925624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Gz7xi3O43Ehum+iPQ9UUZJFWDqVki37iCW9g6uPJck=;
        b=N/qek0Av7+ThM2uead7lhlFud0zEJBJUagVromze9POHfLyLSaESaINw8XPya2cN1i
         5U5ygAaaPDs0A2b2m7z9T/0l4mGhXpHS1V6UM3+9MmrBhzeOVn8+StKA2VVTyYzJhBcK
         giWQvA7QpwTU/ttu/AiS/jmYxgEjNDFCYtzWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738320824; x=1738925624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Gz7xi3O43Ehum+iPQ9UUZJFWDqVki37iCW9g6uPJck=;
        b=jk5/iZbDeNbcnH3PNZBAd6BQtrwEs9lXX4RMJRgPPNBB2rkXWBM08dJZcojN2tfu+j
         KZlkB4Yum7GdvlypW0+Ygj9cS3IzDCM52pYwWGUfdae74gf8F4E/49rogFCqXcIgI8PZ
         X71wRGGLA2iq8Q3IoPLDNV4seuf+HXHKcKBkrMDiu1vlp7xO4PEVUA/aLbxpRaImzReW
         ksqtf+Esw9vgqYMp8nbqdG4XPjDrQWi3s3/Q7ohELZDFheGmsn1wr7eAz/RPjWwLPnGZ
         o2jIHWk3JGeSfnnalu5qyF4nRJR+xA3Amez46A3HPefgTinWlO0qdiSVZIGtgf0DBBFt
         QTnw==
X-Forwarded-Encrypted: i=1; AJvYcCXzyTY6hbUeJobRYzOfVM0OXRly16gg5WW4zC1l9kHjahp/BqKtIA+HHIvHcc3nwNVPyO4KFj6E@vger.kernel.org
X-Gm-Message-State: AOJu0YxTG03EuxKiQ3jhnK613vaOCtgHdXNVrRB6pPnTklyY+zfE4UKK
	iRRxBtJwbrJ3aArpTBMYIN0obVrrxSvfJ/ZoHm2lx0NAyIXNvSWCHdCmJjR7Pn616It/pV9rXg4
	IK0EdibXDbCkyYu4z+3lvKyXy4Lt+JOtnjVHREA==
X-Gm-Gg: ASbGncs5Ucho8WIrDXrzcuYO3hCTDZArcArKNn5EWppWiSil1Y76MW8L4J1n8MWis/T
	e4lM7YAv0L9ABJeI/KaYvbrF0lmLWz8DCyUiq2hEToaxAL9YfZ/d7PaHLbaDJv1O+Ui53hp6qp+
	E=
X-Google-Smtp-Source: AGHT+IGQs7Swg2gHWVL9TEZAftmQSjqdSY2+1HDzTpdlHt+nPPJXWc2CGYdtUcQGvQVdbfa8zhiVpNeTdhC3/S9tzaE=
X-Received: by 2002:a05:622a:4892:b0:466:a091:aa3f with SMTP id
 d75a77b69052e-46fd0bda639mr157983931cf.51.1738320823911; Fri, 31 Jan 2025
 02:53:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129165803.72138-1-mszeredi@redhat.com> <20250129165803.72138-3-mszeredi@redhat.com>
 <CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com>
In-Reply-To: <CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Jan 2025 11:53:33 +0100
X-Gm-Features: AWEUYZnIaqZ2L8wnwxQyaF6vo-Q8TTduPo-90Aj83nHgX6WhuWWuru9KNDGRYME
Message-ID: <CAJfpegu3N9T4cTQ5z+a_nsTpK1KFNDL-NduhMp15stB3O31=+Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: notify on mount attach and detach
To: Paul Moore <paul@paul-moore.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Jan 2025 at 22:06, Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Jan 29, 2025 at 11:58=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.=
com> wrote:
> >
> > Add notifications for attaching and detaching mounts.  The following ne=
w
> > event masks are added:
> >
> >   FAN_MNT_ATTACH  - Mount was attached
> >   FAN_MNT_DETACH  - Mount was detached
> >
> > If a mount is moved, then the event is reported with (FAN_MNT_ATTACH |
> > FAN_MNT_DETACH).
> >
> > These events add an info record of type FAN_EVENT_INFO_TYPE_MNT contain=
ing
> > these fields identifying the affected mounts:
> >
> >   __u64 mnt_id    - the ID of the mount (see statmount(2))
> >
> > FAN_REPORT_MNT must be supplied to fanotify_init() to receive these eve=
nts
> > and no other type of event can be received with this report type.
> >
> > Marks are added with FAN_MARK_MNTNS, which records the mount namespace =
from
> > an nsfs file (e.g. /proc/self/ns/mnt).
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/mount.h                         |  2 +
> >  fs/namespace.c                     | 14 +++--
> >  fs/notify/fanotify/fanotify.c      | 38 +++++++++++--
> >  fs/notify/fanotify/fanotify.h      | 18 +++++++
> >  fs/notify/fanotify/fanotify_user.c | 87 +++++++++++++++++++++++++-----
> >  fs/notify/fdinfo.c                 |  5 ++
> >  include/linux/fanotify.h           | 12 +++--
> >  include/uapi/linux/fanotify.h      | 10 ++++
> >  security/selinux/hooks.c           |  4 ++
> >  9 files changed, 167 insertions(+), 23 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 7b867dfec88b..06d073eab53c 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3395,6 +3395,10 @@ static int selinux_path_notify(const struct path=
 *path, u64 mask,
> >         case FSNOTIFY_OBJ_TYPE_INODE:
> >                 perm =3D FILE__WATCH;
> >                 break;
> > +       case FSNOTIFY_OBJ_TYPE_MNTNS:
> > +               /* Maybe introduce FILE__WATCH_MOUNTNS? */
> > +               perm =3D FILE__WATCH_MOUNT;
> > +               break;
> >         default:
> >                 return -EINVAL;
> >         }
>
> Ignoring for a moment that this patch was merged without an explicit
> ACK for the SELinux changes, let's talk about these SELinux changes
> ...
>
> I understand that you went with the "simpler version" because you
> didn't believe the discussion was converging, which is fair, however,
> I believe Daniel's argument is convincing enough to warrant the new
> permission.

Fine, I'll work on this.

>  Yes, it has taken me approximately two days to find the
> time to revisit this topic and reply with some clarity, but personally
> I feel like that is not an unreasonable period of time, especially for
> a new feature discussion occurring during the merge window.

Definitely not.

Christian is definitely very responsive and quick to queue things up,
and that can have drawbacks.   In this he made it clear that he wants
to get this queued ASAP regardless of whether there's decision on the
SELinux side or not.

What I think might be a good thing if Christian could record
conditional NAKs such as this one from you, that need to be worked on
before sending a feature upstream.  That would prevent wrong code
being sent upstream due to lack of attention.

Thanks,
Miklos
