Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EED263C69
	for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719312; cv=none; b=bxouDdMX9//Hf+smpUfDdWtoOiWEYXwrdiELOO8zNtAnmIosytArtZwsRj9AeOj02KIzWEJk4VoWaKUdijoa3HgwHPXZfJcqfeOdYtWObtDmyhYTCGy+GkRVoyqnPjytLJzrRDwlNdAa9hJsFVvcsgxQ6M8Um58MyoHvS2n/W1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719312; c=relaxed/simple;
	bh=MGVWmwetvnGFnk4oM8Os41p/APY6W9RhI1cGq7ovUEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4GjbidxResPtiUsuhkVHnFhXpsKnDt+HI/eBgSLg8gf9HWKA97eovhns0FOVR6vkSF7GwQtOrIts18vb/LuTJoMyb/s/c22z7CTYDJIWPht2Xf29jqEKUilCInlL5h2VeIy5nTVL4x/FtqfZ3LdFoPaK6qAZfkFRm/RPRMbusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=guV2F2nh; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="guV2F2nh"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6fecfae554bso34486107b3.0
        for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1741719309; x=1742324109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Jp7SWAzBkm2S0wo8s26njKlJp1bL5S/6qcO6arPYUk=;
        b=guV2F2nhsECdUMtaFTPNst4pZS2hQEcUW+0rIexU2zVLWJjUvgiVxOlZoVJRGljPU7
         ABGYQvYHiMlvfYB4W49lW8Ly+ZfOg9AFAwXLI0QW3muo6p+VTxwfOHBM8tvKVhuWERXe
         BoZNHf86JSpknawgMcaop8yyiwOu+PRg011l7S7zs8m8BqFKtb5IwLLjLbtKkLb/k2va
         ZDG1s6E/zGrAo4yBvRD0RHvmr7iMWIoOW+CB1ab+c2AatsOClrGGumL3OSZlJllhk7D9
         bu6YHtBUqQSVqroVujdNoXaXiW5/nOnzNxZ0pTfkN7+hDaTJzBkFYCBnVeTvob2fsCSq
         NlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719309; x=1742324109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Jp7SWAzBkm2S0wo8s26njKlJp1bL5S/6qcO6arPYUk=;
        b=uTHPs7uxuWd156tNjebm8kwWmvwnL8kDNEwdJt2HW0UlLVB2kyzLPJ9Il8XNJbV6GV
         cC8t7zXjuwIFNbcvHJIKQr8wIL09oVjx2+pJfJvO/bmHHWwH605zUXFv9JXL8NS9PxR8
         aEHSqWWRA7QmKhgS4dmBHX7f2ucK53tlj6s8u7oDbosisOaFmLhc7IVKuq3VXECBqMo1
         Hyzxneo9zz1uvWfNXQo04XqG88ri+fP6314UkE5OhFHrZFEZW66TxWAoUBMGFxXn9L6Q
         OCB9Vb5x8ZCBeFzTOnUzKama6O4GSVg0aSG0wM8rALYOs3UOKi20prqIA4dExAS2v6up
         eHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAtCJ19t1eX5101PHPiosIp2LFzk3hMmCog5eRvD3Br1TXzs6O4CceCH6WTDrr15dDdCaTXfqd@vger.kernel.org
X-Gm-Message-State: AOJu0YxB7hqU3/+32GYK+eQAKM0wSOlP+QxKOYBkOuPbJ0p7VBFsCucC
	Lj3qKVrepJbPYRRd0mD0sDY1VU0MWW6liPqgyaFwNwUoZhi3OIt+FqExqzRDd9SM3X4vdu8E6Ld
	KfWXVa/8HNj1Yd6IpDZvl5MqmSVs=
X-Gm-Gg: ASbGncvFdir07YEgvq6gJofC6xPh4hyavtGEBMzoEjGlGHEi2KPJHgtg8ul4R/Lajhe
	izoDU+RmzPDA2ISxpmw1Ukk4xAqwTXQeOqeksQMPxTGO5TLq/fDq19gcKx3OSS2VCRB0CXDmq7T
	SAh59FaoqDyfJ5VaRslIKH2y7DxAc=
X-Google-Smtp-Source: AGHT+IHey9RuArxKnODMAvJyou7zKCt3XKjPwURlpu/Qm3wFGux0KMBii0OO17T0dfsu1tcE5T1bjSIM1DIqp5xmIx8=
X-Received: by 2002:a05:690c:a98:b0:6f9:9e25:e992 with SMTP id
 00721157ae682-6ff091c5da4mr73296887b3.10.1741719309193; Tue, 11 Mar 2025
 11:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311092920.1114210-1-takayas@chromium.org>
 <377a513c-2824-41da-874d-943190ad8937@googlemail.com> <CAEjxPJ4bv98z5Ok286ZMKSCG2ei74dWaB3wZ4xws2ejcxHaLdw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4bv98z5Ok286ZMKSCG2ei74dWaB3wZ4xws2ejcxHaLdw@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 11 Mar 2025 19:54:58 +0100
X-Gm-Features: AQ5f1Jq1FWmpZoBJfNIz-bZDyfdoJdZ28Y16a4H1Ul2a5uYTndGGsx8DfVn0vNg
Message-ID: <CAJ2a_Ddh56rspWBGhz9Kjkv75ET9aEQPBL4y-ZSPfMhYcub98A@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: support wildcard match in genfscon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Takaya Saeki <takayas@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Mar 2025 at 17:23, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Mar 11, 2025 at 6:52=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Mar 11, 2025 10:29:42 Takaya Saeki <takayas@chromium.org>:
> >
> > > Currently, genfscon only supports string prefix match to label files.
> > > Thus, labeling numerous dynamic sysfs entries requires many specific
> > > path rules. For example, labeling device paths such as
> > > `/sys/devices/pci0000:00/0000:00:03.1/<...>/0000:04:00.1/wakeup`
> > > requires listing all specific PCI paths, which is challenging to
> > > maintain. While user-space restorecon can handle these paths with
> > > regular expression rules, but relabeling thousands of paths under sys=
fs
> > > after it is mounted is inefficient compared to using genfscon.
> > >
> > > This commit adds wildcard match to support rules efficient but
> > > expressive enough. This allows users to create fine-grained sysfs rul=
es
> > > without burden of listing specific paths. When multiple wildcard rule=
s
> > > match against a path, then the longest rule (determined by the length=
 of
> > > the rule string) will be applied. If multiple rules of the same lengt=
h
> > > match, the first matching rule encountered in the genfscon policy wil=
l
> > > be applied. However, users are encouraged to write longer, more expli=
cit
> > > path rules to avoid relying on this behavior.
> > >
> > > This change resulted in nice real-world performance improvements. For
> > > example, boot times on test Android devices were reduced by 15%. This
> > > improvement is due to the elimination of the "restorecon -R /sys" ste=
p
> > > during boot, which takes more than two seconds in the worst case.
> > >
> > > Signed-off-by: Takaya Saeki <takayas@chromium.org>
> > > ---
> > > Changelog between v2 and v1
> > > - Use given genfs rules by the userspace as is, instead of appending =
"*".
> > > - Fix __security_genfs_sid hadn't checked caps of the given argument.
> > > - Fix the wrong strncmp usage bug.
> > >
> > > security/selinux/include/policycap.h       |  1 +
> > > security/selinux/include/policycap_names.h |  1 +
> > > security/selinux/ss/services.c             | 20 ++++++++++++++++----
> > > 3 files changed, 18 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/security/selinux/include/policycap.h b/security/selinux/=
include/policycap.h
> > > index 079679fe7254..2b4014a826f0 100644
> > > --- a/security/selinux/include/policycap.h
> > > +++ b/security/selinux/include/policycap.h
> > > @@ -15,6 +15,7 @@ enum {
> > >     POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
> > >     POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> > >     POLICYDB_CAP_NETLINK_XPERM,
> > > +   POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> > >     __POLICYDB_CAP_MAX
> > > };
> > > #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> > > diff --git a/security/selinux/include/policycap_names.h b/security/se=
linux/include/policycap_names.h
> > > index e080827408c4..1053f2c95ff3 100644
> > > --- a/security/selinux/include/policycap_names.h
> > > +++ b/security/selinux/include/policycap_names.h
> > > @@ -18,6 +18,7 @@ const char *const selinux_policycap_names[__POLICYD=
B_CAP_MAX] =3D {
> > >     "ioctl_skip_cloexec",
> > >     "userspace_initial_context",
> > >     "netlink_xperm",
> > > +   "genfs_seclabel_wildcard",
> > > };
> > > /* clang-format on */
> > >
> > > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/ser=
vices.c
> > > index 8478842fbf9e..9f98c9dc71f6 100644
> > > --- a/security/selinux/ss/services.c
> > > +++ b/security/selinux/ss/services.c
> > > @@ -48,6 +48,7 @@
> > > #include <linux/audit.h>
> > > #include <linux/vmalloc.h>
> > > #include <linux/lsm_hooks.h>
> > > +#include <linux/parser.h>
> > > #include <net/netlabel.h>
> > >
> > > #include "flask.h"
> > > @@ -2863,6 +2864,7 @@ static inline int __security_genfs_sid(struct s=
elinux_policy *policy,
> > >     struct genfs *genfs;
> > >     struct ocontext *c;
> > >     int cmp =3D 0;
> > > +   bool wildcard =3D 0;
> > >
> > >     while (path[0] =3D=3D '/' && path[1] =3D=3D '/')
> > >         path++;
> > > @@ -2879,11 +2881,21 @@ static inline int __security_genfs_sid(struct=
 selinux_policy *policy,
> > >     if (!genfs || cmp)
> > >         return -ENOENT;
> > >
> > > +
> > > +   wildcard =3D ebitmap_get_bit(&policy->policydb.policycaps,
> > > +                  POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);
> >
> > Commonly policy capabilities are gathered via a helper from security.h =
from selinux_state, shouldn't it here too?
>
> Those are for accessing the cached policy capabilities in the
> selinux_state from outside of the security server (and without holding
> any locks), e.g. from the hook functions.
> No need for that here, and this is more correct - using the policy we
> were passed rather than whatever selinux_state might reference at the
> time (e.g. during a policy reload).

Should this also be used in security_netif_sid()?


diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.=
c
index 1b11648d9b85..720a69fb4234 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2587,14 +2587,13 @@ int security_netif_sid(const char *name, u32 *if_si=
d)
               return 0;
       }

-       wildcard_support =3D selinux_policycap_netif_wildcard();
-
retry:
       rc =3D 0;
       rcu_read_lock();
       policy =3D rcu_dereference(selinux_state.policy);
       policydb =3D &policy->policydb;
       sidtab =3D policy->sidtab;
+       wildcard_support =3D ebitmap_get_bit(policydb->policycaps,
POLICYDB_CAP_NETIF_WILDCARD);

       c =3D policydb->ocontexts[OCON_NETIF];
       while (c) {
