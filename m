Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FCF2641E8
	for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721402; cv=none; b=ZH55XDfcaajUeEWmypAUSX78IiqP/HR+wcdKX2T8xS8sdy2pDu+3fhUMmVadKITt81kU4CONx0r65/8j94t/jWgfQ+DHfSp4mc3HVA4b4lUSZGiuwp3V6PLp1d2hMjc02sm/GkHjXp0+pxBPuqHoEtDtf25PkK0qUIm4sd8Cg8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721402; c=relaxed/simple;
	bh=KBsfznQSfhKn3Hm1CffN3II3QeqmkQBv8bFM7VBWQjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/jUHLOHtz9dpRt3Byd7ruIkVKCaG55UEgAXPcsr41DDkSGNUtaeoy3qbrnrCj6nf+kUKJpdJW+HvUGvSOUI9AkDteElAlxDN+rqWqVcdCOIif3Y+nvI/SVouXJgDJOZZfwu5g7pojeStBKS9aHar5lkwaeGWv2LkmpS8dzJ32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pbwxf/4F; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbwxf/4F"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fee05829edso11568939a91.3
        for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 12:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741721400; x=1742326200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYEoEzdPHJj6sGJICvhAy1BxCy1F1LUqE8fOqLUrp6M=;
        b=Pbwxf/4FKbZ5seI0iaZA1DIuig6vgcHaVTeQQodrfg4I6ZeiqaR8HP4zcFtBKJdygC
         exsfn7Z0A0eyOslVIjhe960JPrZbrpUWF6VXhkJqJLXfRsRc/983rZTZEx7UzHpsJMO8
         /QNNE71FefmE2F8+mauNRY/7Wn8EaYnkm43lu5T0HoLvxNO8wZtpYrjFMwqco9hQZsFg
         x4gNbA4pT0iX5SgvTod4ONm9Ma0NfmTxh1HDL+QWNugMQKab/qozomoEttonQmAQGLKj
         3hTOyPsEGItFrvM95CwjT7/8IjrFdv3OsFccwNB7+RDa5oVlMLnczbf2VHqwRYlmdgFh
         VCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741721400; x=1742326200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYEoEzdPHJj6sGJICvhAy1BxCy1F1LUqE8fOqLUrp6M=;
        b=Nx+5FGSByOd7/5fWafLxFyTthduRbYSARKu6ytxwFF5NsUlW4PC5fsjkfPN9IMLW+Y
         aXlWMblc7YdRwUIAx0a7DkpgocFs22fqGPer83J1gxzdLk3wQwq61v7ue0K8i2dg3ZJq
         CyZtNwnco4msicPaExfg3kynin0ir8sf2H6foJ6OO0N8OC/UZKnstI3ZkHWsRIu1384h
         NoJsQOToWKXFVo5zhVNsu+AZJotbhnN6Qi208oksABtEJ80q+4RPC+FxFOcu4TRQelOn
         b01Qkm4ou7Sedx7cLyJ5iGzbcvYdUPSS6qMWVq11Sfon5vNm7BgJ3p2u2DzB127/UUTb
         TDuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYk5UvT5g0SuS9RXvrhatIgTGU+XosYizzqpvMY63ng2fk+eqDJwEziPAKvohUfyr5oqvuqbhR@vger.kernel.org
X-Gm-Message-State: AOJu0YyxjnPXRTBs4HGGucb8jMeqso5Zp5sLx3A8VjsgDaXInFTTHjJk
	ciSulUALXWsDFUXfpf3OxbCGpb9HJhsO1eVrSfuDPIJ0BTfyX5mC/BJs1Mg6/CBqhXAaTP90R8r
	4OEamQVA2W1dbvKkGOQDWE3AB4MU=
X-Gm-Gg: ASbGncuVj+y0/wpoTXeeKtq5rYV96G2XHnGr6WJ2EvTxKEnTihbQtLfXj/VUDr9jdxQ
	XDu2I3z5bV/czTg9uHr6w9ZJZHxDttWg0EEA95SqKDFMFK7qk++j9rjNYh4rgzJ2+RxHHaSsAr+
	NrDJQTUviXqiTGRONjO6D8L7TwTg==
X-Google-Smtp-Source: AGHT+IEH4l2qCEKYoa8wsQeRi1AWiJqa9cc91wnfbc6IhC0hAe1xuJr6WkaZnZjC0v3Khty3kpjnhJ9TZ9LEXteo5iY=
X-Received: by 2002:a17:90a:d2c6:b0:2f4:4003:f3d4 with SMTP id
 98e67ed59e1d1-2ff7cf2a4d4mr26356414a91.30.1741721399687; Tue, 11 Mar 2025
 12:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311092920.1114210-1-takayas@chromium.org>
 <377a513c-2824-41da-874d-943190ad8937@googlemail.com> <CAEjxPJ4bv98z5Ok286ZMKSCG2ei74dWaB3wZ4xws2ejcxHaLdw@mail.gmail.com>
 <CAJ2a_Ddh56rspWBGhz9Kjkv75ET9aEQPBL4y-ZSPfMhYcub98A@mail.gmail.com>
In-Reply-To: <CAJ2a_Ddh56rspWBGhz9Kjkv75ET9aEQPBL4y-ZSPfMhYcub98A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 11 Mar 2025 15:29:49 -0400
X-Gm-Features: AQ5f1Jr6ZfjS9IZfUbwB9I3vgbBPi0xVTF217VMm_gljMw9d2WlUW4nEcaNnrWA
Message-ID: <CAEjxPJ4tjusymWoVuqN1nsM=MbFRKHr6B4xx+Nv3-1H9iyNq0w@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: support wildcard match in genfscon
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Takaya Saeki <takayas@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 2:55=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Tue, 11 Mar 2025 at 17:23, Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Mar 11, 2025 at 6:52=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Mar 11, 2025 10:29:42 Takaya Saeki <takayas@chromium.org>:
> > >
> > > > Currently, genfscon only supports string prefix match to label file=
s.
> > > > Thus, labeling numerous dynamic sysfs entries requires many specifi=
c
> > > > path rules. For example, labeling device paths such as
> > > > `/sys/devices/pci0000:00/0000:00:03.1/<...>/0000:04:00.1/wakeup`
> > > > requires listing all specific PCI paths, which is challenging to
> > > > maintain. While user-space restorecon can handle these paths with
> > > > regular expression rules, but relabeling thousands of paths under s=
ysfs
> > > > after it is mounted is inefficient compared to using genfscon.
> > > >
> > > > This commit adds wildcard match to support rules efficient but
> > > > expressive enough. This allows users to create fine-grained sysfs r=
ules
> > > > without burden of listing specific paths. When multiple wildcard ru=
les
> > > > match against a path, then the longest rule (determined by the leng=
th of
> > > > the rule string) will be applied. If multiple rules of the same len=
gth
> > > > match, the first matching rule encountered in the genfscon policy w=
ill
> > > > be applied. However, users are encouraged to write longer, more exp=
licit
> > > > path rules to avoid relying on this behavior.
> > > >
> > > > This change resulted in nice real-world performance improvements. F=
or
> > > > example, boot times on test Android devices were reduced by 15%. Th=
is
> > > > improvement is due to the elimination of the "restorecon -R /sys" s=
tep
> > > > during boot, which takes more than two seconds in the worst case.
> > > >
> > > > Signed-off-by: Takaya Saeki <takayas@chromium.org>
> > > > ---
> > > > Changelog between v2 and v1
> > > > - Use given genfs rules by the userspace as is, instead of appendin=
g "*".
> > > > - Fix __security_genfs_sid hadn't checked caps of the given argumen=
t.
> > > > - Fix the wrong strncmp usage bug.
> > > >
> > > > security/selinux/include/policycap.h       |  1 +
> > > > security/selinux/include/policycap_names.h |  1 +
> > > > security/selinux/ss/services.c             | 20 ++++++++++++++++---=
-
> > > > 3 files changed, 18 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/security/selinux/include/policycap.h b/security/selinu=
x/include/policycap.h
> > > > index 079679fe7254..2b4014a826f0 100644
> > > > --- a/security/selinux/include/policycap.h
> > > > +++ b/security/selinux/include/policycap.h
> > > > @@ -15,6 +15,7 @@ enum {
> > > >     POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
> > > >     POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> > > >     POLICYDB_CAP_NETLINK_XPERM,
> > > > +   POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> > > >     __POLICYDB_CAP_MAX
> > > > };
> > > > #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> > > > diff --git a/security/selinux/include/policycap_names.h b/security/=
selinux/include/policycap_names.h
> > > > index e080827408c4..1053f2c95ff3 100644
> > > > --- a/security/selinux/include/policycap_names.h
> > > > +++ b/security/selinux/include/policycap_names.h
> > > > @@ -18,6 +18,7 @@ const char *const selinux_policycap_names[__POLIC=
YDB_CAP_MAX] =3D {
> > > >     "ioctl_skip_cloexec",
> > > >     "userspace_initial_context",
> > > >     "netlink_xperm",
> > > > +   "genfs_seclabel_wildcard",
> > > > };
> > > > /* clang-format on */
> > > >
> > > > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/s=
ervices.c
> > > > index 8478842fbf9e..9f98c9dc71f6 100644
> > > > --- a/security/selinux/ss/services.c
> > > > +++ b/security/selinux/ss/services.c
> > > > @@ -48,6 +48,7 @@
> > > > #include <linux/audit.h>
> > > > #include <linux/vmalloc.h>
> > > > #include <linux/lsm_hooks.h>
> > > > +#include <linux/parser.h>
> > > > #include <net/netlabel.h>
> > > >
> > > > #include "flask.h"
> > > > @@ -2863,6 +2864,7 @@ static inline int __security_genfs_sid(struct=
 selinux_policy *policy,
> > > >     struct genfs *genfs;
> > > >     struct ocontext *c;
> > > >     int cmp =3D 0;
> > > > +   bool wildcard =3D 0;
> > > >
> > > >     while (path[0] =3D=3D '/' && path[1] =3D=3D '/')
> > > >         path++;
> > > > @@ -2879,11 +2881,21 @@ static inline int __security_genfs_sid(stru=
ct selinux_policy *policy,
> > > >     if (!genfs || cmp)
> > > >         return -ENOENT;
> > > >
> > > > +
> > > > +   wildcard =3D ebitmap_get_bit(&policy->policydb.policycaps,
> > > > +                  POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);
> > >
> > > Commonly policy capabilities are gathered via a helper from security.=
h from selinux_state, shouldn't it here too?
> >
> > Those are for accessing the cached policy capabilities in the
> > selinux_state from outside of the security server (and without holding
> > any locks), e.g. from the hook functions.
> > No need for that here, and this is more correct - using the policy we
> > were passed rather than whatever selinux_state might reference at the
> > time (e.g. during a policy reload).
>
> Should this also be used in security_netif_sid()?

Technically, yes. Not as critical there since security_netif_sid() is
not called on the new policy during policy reload, unlike
selinux_policy_genfs_sid(), but would be safer / more correct.

>
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 1b11648d9b85..720a69fb4234 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2587,14 +2587,13 @@ int security_netif_sid(const char *name, u32 *if_=
sid)
>                return 0;
>        }
>
> -       wildcard_support =3D selinux_policycap_netif_wildcard();
> -
> retry:
>        rc =3D 0;
>        rcu_read_lock();
>        policy =3D rcu_dereference(selinux_state.policy);
>        policydb =3D &policy->policydb;
>        sidtab =3D policy->sidtab;
> +       wildcard_support =3D ebitmap_get_bit(policydb->policycaps,
> POLICYDB_CAP_NETIF_WILDCARD);
>
>        c =3D policydb->ocontexts[OCON_NETIF];
>        while (c) {
