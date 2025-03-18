Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EE41F873E
	for <selinux@vger.kernel.org>; Tue, 18 Mar 2025 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286908; cv=none; b=TjZqp4C83IIAio0JXVbmS+CYrhjAC1tqoEeKOpYjxuNJ7Tv6m+CYlymutte7qUb556ehKiY0cDz92vmrcIGubGc3DwBDNxj3UtexerkmyzgLhBezKvAJB7ltQeHipvKnsnnblx6cBXZGK4pE2jWKd2BXjpNkOmz85ru4s7EHXfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286908; c=relaxed/simple;
	bh=p7fNJGIiNttbWC8NEmHclM0A8RSsRZCkCyljke6exa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zdd2z9WsGuvCV6X6rlstG+tnQqxt8Yyz+PnZPTlIiolmPmOvnvra7n7WDgWOLEMhs6HQr5Wu50ltUAEjszuumhosEVK+Nv1tVWhP9s9wjpG4EKzo4NAjuFqhuXoYNvz/I4gayVOqihmpEN45sYA5bX9l9FH2+HvFW3waBkmKoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=momMDVWb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="momMDVWb"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so5696361e87.1
        for <selinux@vger.kernel.org>; Tue, 18 Mar 2025 01:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742286904; x=1742891704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c2x5WJ1z9O58yTYkgyR5MhbJBEIadoVA1FMV1YtEDE=;
        b=momMDVWbN4LXFGkEbs6H+NymnCME2iSFNwk8+9C2ArEfkNoVWeuVDih9Pq9SWxevD1
         9zUqd5qxDmPbMIRlnOTlLYytl0ECqtD4tWXoYTf8z/Rr/tS1DS1phl1RadPXMwXcf1mh
         D7CTdqJFbsvXYHZ25Wlg75zPXnrz+lL1Vn1VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742286904; x=1742891704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3c2x5WJ1z9O58yTYkgyR5MhbJBEIadoVA1FMV1YtEDE=;
        b=e2KjtCY9UpdSb6ylQVPwonhPrZ0ELsga1V9joVgj/lPnwE6M6PlV5ITwlofG38m0/X
         0Lvbuvcbi/J3ocGq/yquLFXoy8GEawOI3VrsF9sXwSV8+GKIbDXsCOlxyQigCATKIDef
         D0mGf1G+5sVD/lGbCqIxqFfAvYaC8RtfcgoRobGEam+XBawaC6g/FkSfWetKNe0MkEmT
         oNG6Gm4QGzoeFS0rxtgbuFzrZI54bdB9t3vdnXfNlzfSlHxTuu2IaafbECbdLcMcp50f
         nJlXXUT+hg9hZoYLU5BncBXc04qyjMMQf6SZ6kEE/1FpU2ZOcfu2OlkzTF3pwpBKH7fR
         4m6g==
X-Forwarded-Encrypted: i=1; AJvYcCXseelD/N2J4A2FWSxnVDEvGlfS7gcr9qom3pNu2km7AXi51Z7pVccBEIPYpzyTCjcrdP4EH0g4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ELeO2G/w8eQEihlSrQeOzoOLBHkwJoq0TqzbQQMQ2l3UTr+t
	7oCRKsRVJ6nJ2vEmprjpBfNoIeQXvm5Q2jG0nrCDbq0aqQ+ukK/1u/bw6yIPBjI7zXZ8lyh6mDv
	jflyZpEiuw9lzJ0wU6HZXiZ8WxE6uDcjItIBZak/qwvSGZg==
X-Gm-Gg: ASbGncv3GPNq5A1gZ0wkre7IULeyWVWmDurveUDF8LtBcO3yvsxRPtUuluXv7MihW+c
	Dds16Qoib6Z2TUBeC5f3n3Kx86EZYGO2qFUUFVWI5H8faHDTDpNXn+XMGyTnX8L+FmOeHqy3Laa
	mhJUCRHAHgh5ceb0yB7R2vCUJy6Pbs+QxA9iysdX6ZgEAE6jMDc71x9zo=
X-Google-Smtp-Source: AGHT+IHp4q9oJ978GYSRzdmAFS/odNMCJ/nHwwa/p0OtR7swOs6Vt5M2smilRMOJ2OVshrJ8wG7u9Ap2RZAzmGFR9Cc=
X-Received: by 2002:a05:6512:3ba7:b0:549:8f4a:6ba7 with SMTP id
 2adb3069b0e04-549c396ef32mr9501887e87.36.1742286904254; Tue, 18 Mar 2025
 01:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311092920.1114210-1-takayas@chromium.org> <b193793a15fe88b6f390e824da073238@paul-moore.com>
In-Reply-To: <b193793a15fe88b6f390e824da073238@paul-moore.com>
From: Takaya Saeki <takayas@chromium.org>
Date: Tue, 18 Mar 2025 17:34:52 +0900
X-Gm-Features: AQ5f1JqNbp1AYYTLmsJeOhqkyPwiMv6DM9eNGJILdAq23KyCXalg-2sodGh62ew
Message-ID: <CAH9xa6em5EE9MG0Wh6Off7BQnsH-oNJ+iOz8RLKz=XfbChsEng@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: support wildcard match in genfscon
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 6:17=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mar 11, 2025 Takaya Saeki <takayas@chromium.org> wrote:
> >
> > Currently, genfscon only supports string prefix match to label files.
> > Thus, labeling numerous dynamic sysfs entries requires many specific
> > path rules. For example, labeling device paths such as
> > `/sys/devices/pci0000:00/0000:00:03.1/<...>/0000:04:00.1/wakeup`
> > requires listing all specific PCI paths, which is challenging to
> > maintain. While user-space restorecon can handle these paths with
> > regular expression rules, but relabeling thousands of paths under sysfs
> > after it is mounted is inefficient compared to using genfscon.
> >
> > This commit adds wildcard match to support rules efficient but
> > expressive enough. This allows users to create fine-grained sysfs rules
> > without burden of listing specific paths. When multiple wildcard rules
> > match against a path, then the longest rule (determined by the length o=
f
> > the rule string) will be applied. If multiple rules of the same length
> > match, the first matching rule encountered in the genfscon policy will
> > be applied. However, users are encouraged to write longer, more explici=
t
> > path rules to avoid relying on this behavior.
> >
> > This change resulted in nice real-world performance improvements. For
> > example, boot times on test Android devices were reduced by 15%. This
> > improvement is due to the elimination of the "restorecon -R /sys" step
> > during boot, which takes more than two seconds in the worst case.
> >
> > Signed-off-by: Takaya Saeki <takayas@chromium.org>
> > ---
> > Changelog between v2 and v1
> > - Use given genfs rules by the userspace as is, instead of appending "*=
".
> > - Fix __security_genfs_sid hadn't checked caps of the given argument.
> > - Fix the wrong strncmp usage bug.
> >
> >  security/selinux/include/policycap.h       |  1 +
> >  security/selinux/include/policycap_names.h |  1 +
> >  security/selinux/ss/services.c             | 20 ++++++++++++++++----
> >  3 files changed, 18 insertions(+), 4 deletions(-)
>
> I would mention in the commit description above that the new
> functionality is gated by the "genfs_seclabel_wildcard" policy
> capability.  Otherwise this looks much better, thank you for the
> revision; there are a couple of comments below, but they are minor
> and you already mentioned one of them ;)
>
> > diff --git a/security/selinux/include/policycap.h b/security/selinux/in=
clude/policycap.h
> > index 079679fe7254..2b4014a826f0 100644
> > --- a/security/selinux/include/policycap.h
> > +++ b/security/selinux/include/policycap.h
> > @@ -15,6 +15,7 @@ enum {
> >       POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
> >       POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> >       POLICYDB_CAP_NETLINK_XPERM,
> > +     POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> >       __POLICYDB_CAP_MAX
> >  };
>
> As far as piggy-backing on top of NETIF_WILDCARD, it's generally best to
> use individual policy capabilities unless there is some reason why making
> one change to the policy would also require you to change the other.
>
> You could consider adding a
> selinux_policycap_genfs_seclabel_wildcard() function, but since there
> isn't a need for it in this patch, and I question where else we might
> ever need it, it's fine if you want to omit the helper function and leave
> it as-is.
>
> >  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> > diff --git a/security/selinux/include/policycap_names.h b/security/seli=
nux/include/policycap_names.h
> > index e080827408c4..1053f2c95ff3 100644
> > --- a/security/selinux/include/policycap_names.h
> > +++ b/security/selinux/include/policycap_names.h
> > @@ -18,6 +18,7 @@ const char *const selinux_policycap_names[__POLICYDB_=
CAP_MAX] =3D {
> >       "ioctl_skip_cloexec",
> >       "userspace_initial_context",
> >       "netlink_xperm",
> > +     "genfs_seclabel_wildcard",
> >  };
> >  /* clang-format on */
> >
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index 8478842fbf9e..9f98c9dc71f6 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -48,6 +48,7 @@
> >  #include <linux/audit.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/lsm_hooks.h>
> > +#include <linux/parser.h>
> >  #include <net/netlabel.h>
> >
> >  #include "flask.h"
> > @@ -2863,6 +2864,7 @@ static inline int __security_genfs_sid(struct sel=
inux_policy *policy,
> >       struct genfs *genfs;
> >       struct ocontext *c;
> >       int cmp =3D 0;
> > +     bool wildcard =3D 0;
>
> As you mentioned earlier, I think we can get rid of this assignment.
>
> >       while (path[0] =3D=3D '/' && path[1] =3D=3D '/')
> >               path++;
> > @@ -2879,11 +2881,21 @@ static inline int __security_genfs_sid(struct s=
elinux_policy *policy,
> >       if (!genfs || cmp)
> >               return -ENOENT;
> >
> > +
> > +     wildcard =3D ebitmap_get_bit(&policy->policydb.policycaps,
> > +                                POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);
>
> It looks like you're adding an extra blank line above the wildcard
> assignment, please don't do that, a single blank line is sufficient
> vertical whitespace.
>
> >       for (c =3D genfs->head; c; c =3D c->next) {
> > -             size_t len =3D strlen(c->u.name);
> > -             if ((!c->v.sclass || sclass =3D=3D c->v.sclass) &&
> > -                 (strncmp(c->u.name, path, len) =3D=3D 0))
> > -                     break;
> > +             if (!c->v.sclass || sclass =3D=3D c->v.sclass) {
> > +                     if (wildcard) {
> > +                             if (match_wildcard(c->u.name, path))
> > +                                     break;
> > +                     } else {
> > +                             size_t len =3D strlen(c->u.name);
> > +
> > +                             if ((strncmp(c->u.name, path, len)) =3D=
=3D 0)
> > +                                     break;
> > +                     }
> > +             }
> >       }
> >
> >       if (!c)
> > --
> > 2.49.0.rc1.451.g8f38331e32-goog
>
> --
> paul-moore.com


Thank you for the review, Paul! I've sent a v3 patch that fixes the
extra blank line and assignment.
