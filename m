Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48F02153EA
	for <selinux@vger.kernel.org>; Thu, 30 Oct 2025 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842239; cv=none; b=dnwvYKfNJtqhR7mogdqEe8p4OVECA8uv6svPNfYm+TTqd6+Udh3r7Dt0ogi863dI6Db736QbSAyMryd95weVjUQVjjYvXk+xoc4pbmL9R8S3u36QQBRndqJxAHyEuG5PRlbQeite8QKUv8t+YBeEzhJjxCnHz7qbCrCYhll5Wkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842239; c=relaxed/simple;
	bh=Rk4+7utdOH91zF2Ue649kreyUpMR584peiln8k/WKpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPqDLRTup3Cuidhjj2ORcCw1ID22hReK9tte4/pgeA2lb9sReZw4fqPLeGPIqR4Bds17/NSXKFh2xnx+B1UUfeNryqh3hmCQVcW2if3Pm714k8vC5EOFd/9YJUpX/k3X3bxaI26mVdO7Ks1KYHM/IaKHUW4De5Q0pgnkLklhziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaDhE1b8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaDhE1b8"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34077439166so410930a91.2
        for <selinux@vger.kernel.org>; Thu, 30 Oct 2025 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842237; x=1762447037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34IZ4PPrIS3/a88zh5daBrgYdp8BI0L76LgAi0EH/PQ=;
        b=NaDhE1b8XSfOBmfMZpgBhLvHep/6bSIZQqQDyyPd04NepZ7voWXehxfhkm6JBaqeS6
         V2kqtSGIzW2pIWKKeTn0ykuNOirMqLrts7mBysYh+zLi5dckogPdiVw3zCcmwADl1W6a
         rY0RU7UZXDOPwuUddRDkW783ZLVfS+MwhFUxslxulRCVXRHM8aHUn1zDWi2u9dJJIJts
         s3K3+1O+W2vmSa4MRIG3pAuYIOI0R4u/L1xYdnsf8n0gGvLdEwA1rOTB7gvFx1FPOkHf
         ireqJ0INEIf5jNAxSC2vmTmdkfUe9HbvvOKnnVSlwbfe3KlHP8ERZHmZGiuzitQ4eZoh
         N9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842237; x=1762447037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34IZ4PPrIS3/a88zh5daBrgYdp8BI0L76LgAi0EH/PQ=;
        b=KN+wWH/iI4sWrYYUnNWOYiwp3O6TvVQSll6VBPtOj10CUnxXJt0bJWdheTH+7fKr/g
         iHW2zUUIcedQr0tK8VbA5NTGXNEC9NffIa7IsxtVjLfcOJ/VNEcTVJZcIKHO8SGhoQDi
         W6oivj+rKuG2SXV9U8JX1gsBDh77m6pmK3SXHxV+eVHNQ/mfEkW1DcfbhgPdKbSgYfw/
         mSN/pq1mlOyKGksbZ+eWijXV+WYUOE/1DNKbEccrreWKbmTrbNikKiVjwXcGVKjQ+AxQ
         6aOiOGWj7463GN415U4fqbZJ96JqW7eqzw+01wZBpeszEO+1mfnoQeCNawbMIigPm8vb
         ewvw==
X-Gm-Message-State: AOJu0YwSb/QeNzIlX5JvxDLm49m2oEj+k6kaZtjxyk3CKFYUDkZTHIiW
	DhZYjaBI27wgyMEMGSw9yJ7ZPPwpurCrp9TkRdMGOUpy4U/oF0J1gZin2UIDBHhOLEJTpp6VmDJ
	83scje4AjJiRrQ2t/QcbDII3E/911A3o=
X-Gm-Gg: ASbGncv/lv/YASqX96+4ykD+k4Iq7GKWhh5d3SsY93K/vyLc2vhLBZHcsFvcC2L4fJH
	qtVse7mORf5lZLKYd6q7EKefulpadGBWyqBvolv8C5cHUpQraVJBe9cMZQIVCbHXRsaBdAHp1yb
	pj8CkDgQqEVRGIpNi1Zj6g7DfQx9dTklSlkut7QFAcgnGz27ldrW+ijS+LLW/9VDfYZsmv4UH/R
	uL+nZibpvMGmHjHMrs1oNvmNnirL1+1ugAgee9FdfRDEnFCmkblzHPSKnMu
X-Google-Smtp-Source: AGHT+IEK4RjBY0PWrOIu/J4usYNuVgxi0S38/nSPOXkr4prVzB2ZxwkWfL9hlG2YyWMybzT+CqnBdjgXYoGG1sV0K7s=
X-Received: by 2002:a17:90b:3fd0:b0:340:6b5e:7578 with SMTP id
 98e67ed59e1d1-34082fc645amr507374a91.4.1761842236959; Thu, 30 Oct 2025
 09:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200224161023.116134-1-sds@tycho.nsa.gov> <CAHC9VhRhzeLCYHEavt6qFePFDgg8btbG2JQTQmmDMXiGu7-JPQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRhzeLCYHEavt6qFePFDgg8btbG2JQTQmmDMXiGu7-JPQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Oct 2025 12:37:03 -0400
X-Gm-Features: AWmQ_bmvMG_YMJymAvs18N08ZaEp3fxnFrJumPctdhCbR9TO-vPGvQhOdSX4wMU
Message-ID: <CAEjxPJ7eTNMMPxK93wE53Xq_YxSiSttaJO3jMY3Y9TuVi2aq4g@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: remove unused initial SIDs and improve handling
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, pebenito@ieee.org, 
	selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 8:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> FWD'ing this to the mailing list while Stephen is having problems posting=
.
>
> ---------- Forwarded message ---------
> From: Stephen Smalley <sds@tycho.nsa.gov>
> Date: Mon, Feb 24, 2020 at 11:09 AM
> Subject: [PATCH v4] selinux: remove unused initial SIDs and improve handl=
ing
> To: <selinux@vger.kernel.org>
> Cc: <paul@paul-moore.com>, <omosnace@redhat.com>, <pebenito@ieee.org>,
> Stephen Smalley <sds@tycho.nsa.gov>
>
>
> Remove initial SIDs that have never been used or are no longer used by
> the kernel from its string table, which is also used to generate the
> SECINITSID_* symbols referenced in code.  Update the code to
> gracefully handle the fact that these can now be NULL. Stop treating
> it as an error if a policy defines additional initial SIDs unknown to
> the kernel.  Do not load unused initial SID contexts into the sidtab.
> Fix the incorrect usage of the name from the ocontext in error
> messages when loading initial SIDs since these are not presently
> written to the kernel policy and are therefore always NULL.
>
> After this change, it is possible to safely reclaim and reuse some of
> the unused initial SIDs without compatibility issues.  Specifically,
> unused initial SIDs that were being assigned the same context as the
> unlabeled initial SID in policies can be reclaimed and reused for
> another purpose, with existing policies still treating them as having
> the unlabeled context and future policies having the option of mapping
> them to a more specific context.  For example, this could have been
> used when the infiniband labeling support was introduced to define
> initial SIDs for the default pkey and endport SIDs similar to the
> handling of port/netif/node SIDs rather than always using
> SECINITSID_UNLABELED as the default.
>
> The set of safely reclaimable unused initial SIDs across all known
> policies is igmp_packet (13), icmp_socket (14), tcp_socket (15), kmod
> (24), policy (25), and scmp_packet (26); these initial SIDs were
> assigned the same context as unlabeled in all known policies including
> mls.  If only considering non-mls policies (i.e. assuming that mls
> users always upgrade policy with their kernels), the set of safely
> reclaimable unused initial SIDs further includes file_labels (6), init
> (7), sysctl_modprobe (16), and sysctl_fs (18) through sysctl_dev (23).
>
> Adding new initial SIDs beyond SECINITSID_NUM to policy unfortunately
> became a fatal error in commit 24ed7fdae669 ("selinux: use separate
> table for initial SID lookup") and even before that it could cause
> problems on a policy reload (collision between the new initial SID and
> one allocated at runtime) ever since commit 42596eafdd75 ("selinux:
> load the initial SIDs upon every policy load") so we cannot safely
> start adding new initial SIDs to policies beyond SECINITSID_NUM (27)
> until such a time as all such kernels do not need to be supported and
> only those that include this commit are relevant. That is not a big
> deal since we haven't added a new initial SID since 2004 (v2.6.7) and
> we have plenty of unused ones we can reclaim if we truly need one.
>
> If we want to avoid the wasted storage in initial_sid_to_string[]
> and/or sidtab->isids[] for the unused initial SIDs, we could introduce
> an indirection between the kernel initial SID values and the policy
> initial SID values and just map the policy SID values in the ocontexts
> to the kernel values during policy_load_isids(). Originally I thought
> we'd do this by preserving the initial SID names in the kernel policy
> and creating a mapping at load time like we do for the security
> classes and permissions but that would require a new kernel policy
> format version and associated changes to libsepol/checkpolicy and I'm
> not sure it is justified. Simpler approach is just to create a fixed
> mapping table in the kernel from the existing fixed policy values to
> the kernel values. Less flexible but probably sufficient.
>
> A separate selinux userspace change was applied in
> https://github.com/SELinuxProject/selinux/commit/8677ce5e8f592950ae6f14ce=
a1b68a20ddc1ac25
> to enable removal of most of the unused initial SID contexts from
> policies, but there is no dependency between that change and this one.
> That change permits removing all of the unused initial SID contexts
> from policy except for the fs and sysctl SID contexts.  The initial
> SID declarations themselves would remain in policy to preserve the
> values of subsequent ones but the contexts can be dropped.  If/when
> the kernel decides to reuse one of them, future policies can change
> the name and start assigning a context again without breaking
> compatibility.
>
> Here is how I would envision staging changes to the initial SIDs in a
> compatible manner after this commit is applied:
>
> 1. At any time after this commit is applied, the kernel could choose
> to reclaim one of the safely reclaimable unused initial SIDs listed
> above for a new purpose (i.e. replace its NULL entry in the
> initial_sid_to_string[] table with a new name and start using the
> newly generated SECINITSID_name symbol in code), and refpolicy could
> at that time rename its declaration of that initial SID to reflect its
> new purpose and start assigning it a context going
> forward. Existing/old policies would map the reclaimed initial SID to
> the unlabeled context, so that would be the initial default behavior
> until policies are updated. This doesn't depend on the selinux
> userspace change; it will work with existing policies and userspace.
>
> 2. In 6 months or so we'll have another SELinux userspace release that
> will include the libsepol/checkpolicy support for omitting unused
> initial SID contexts.
>
> 3. At any time after that release, refpolicy can make that release its
> minimum build requirement and drop the sid context statements (but not
> the sid declarations) for all of the unused initial SIDs except for
> fs and sysctl, which must remain for compatibility on policy
> reload with old kernels and for compatibility with kernels that were
> still using SECINITSID_SYSCTL (< 2.6.39). This doesn't depend on this
> kernel commit; it will work with previous kernels as well.

This never happened AFAICT and I'm not sure if it was even tried.
Might need/want to retain the sid context statement for the init SID
too since it was re-activated by a later patch by Ondrej.

> 4. After N years for some value of N, refpolicy decides that it no
> longer cares about policy reload compatibility for kernels that
> predate this kernel commit, and refpolicy drops the fs and sysctl
> SID contexts from policy too (but retains the declarations).

Checking to see if N =3D=3D 5 here ;)

> 5. After M years for some value of M, the kernel decides that it no
> longer cares about compatibility with refpolicies that predate step 4
> (dropping the fs and sysctl SIDs), and those two SIDs also become
> safely reclaimable.  This step is optional and need not ever occur unless
> we decide that the need to reclaim those two SIDs outweighs the
> compatibility cost.
>
> 6. After O years for some value of O, refpolicy decides that it no
> longer cares about policy load (not just reload) compatibility for
> kernels that predate this kernel commit, and both kernel and refpolicy
> can then start adding and using new initial SIDs beyond 27. This does
> not depend on the previous change (step 5) and can occur independent
> of it.
>
> Fixes: https://github.com/SELinuxProject/selinux-kernel/issues/12
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> v4 fixes the commit hashes that I cut-and-pasted from the GH issue
> comments to be the proper length and added the one-line descriptions.
> Oddly checkpatch.pl didn't catch that originally.
>
>  scripts/selinux/genheaders/genheaders.c       | 11 +++-
>  .../selinux/include/initial_sid_to_string.h   | 57 +++++++++----------
>  security/selinux/selinuxfs.c                  |  6 +-
>  security/selinux/ss/policydb.c                | 25 ++++----
>  security/selinux/ss/services.c                | 26 ++++-----
>  5 files changed, 66 insertions(+), 59 deletions(-)
>
> diff --git a/scripts/selinux/genheaders/genheaders.c
> b/scripts/selinux/genheaders/genheaders.c
> index 544ca126a8a8..f355b3e0e968 100644
> --- a/scripts/selinux/genheaders/genheaders.c
> +++ b/scripts/selinux/genheaders/genheaders.c
> @@ -67,8 +67,12 @@ int main(int argc, char *argv[])
>         }
>
>         isids_len =3D sizeof(initial_sid_to_string) / sizeof (char *);
> -       for (i =3D 1; i < isids_len; i++)
> -               initial_sid_to_string[i] =3D stoupperx(initial_sid_to_str=
ing[i]);
> +       for (i =3D 1; i < isids_len; i++) {
> +               const char *s =3D initial_sid_to_string[i];
> +
> +               if (s)
> +                       initial_sid_to_string[i] =3D stoupperx(s);
> +       }
>
>         fprintf(fout, "/* This file is automatically generated.  Do
> not edit. */\n");
>         fprintf(fout, "#ifndef _SELINUX_FLASK_H_\n#define
> _SELINUX_FLASK_H_\n\n");
> @@ -82,7 +86,8 @@ int main(int argc, char *argv[])
>
>         for (i =3D 1; i < isids_len; i++) {
>                 const char *s =3D initial_sid_to_string[i];
> -               fprintf(fout, "#define SECINITSID_%-39s %2d\n", s, i);
> +               if (s)
> +                       fprintf(fout, "#define SECINITSID_%-39s %2d\n", s=
, i);
>         }
>         fprintf(fout, "\n#define SECINITSID_NUM %d\n", i-1);
>         fprintf(fout, "\nstatic inline bool
> security_is_socket_class(u16 kern_tclass)\n");
> diff --git a/security/selinux/include/initial_sid_to_string.h
> b/security/selinux/include/initial_sid_to_string.h
> index 4f93f697f71c..5d332aeb8b6c 100644
> --- a/security/selinux/include/initial_sid_to_string.h
> +++ b/security/selinux/include/initial_sid_to_string.h
> @@ -1,34 +1,33 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/* This file is automatically generated.  Do not edit. */
>  static const char *initial_sid_to_string[] =3D
>  {
> -    "null",
> -    "kernel",
> -    "security",
> -    "unlabeled",
> -    "fs",
> -    "file",
> -    "file_labels",
> -    "init",
> -    "any_socket",
> -    "port",
> -    "netif",
> -    "netmsg",
> -    "node",
> -    "igmp_packet",
> -    "icmp_socket",
> -    "tcp_socket",
> -    "sysctl_modprobe",
> -    "sysctl",
> -    "sysctl_fs",
> -    "sysctl_kernel",
> -    "sysctl_net",
> -    "sysctl_net_unix",
> -    "sysctl_vm",
> -    "sysctl_dev",
> -    "kmod",
> -    "policy",
> -    "scmp_packet",
> -    "devnull",
> +       NULL,
> +       "kernel",
> +       "security",
> +       "unlabeled",
> +       NULL,
> +       "file",
> +       NULL,
> +       NULL,
> +       "any_socket",
> +       "port",
> +       "netif",
> +       "netmsg",
> +       "node",
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       "devnull",
>  };
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 533ab170ad52..4781314c2510 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1701,7 +1701,11 @@ static int sel_make_initcon_files(struct dentry *d=
ir)
>         for (i =3D 1; i <=3D SECINITSID_NUM; i++) {
>                 struct inode *inode;
>                 struct dentry *dentry;
> -               dentry =3D d_alloc_name(dir, security_get_initial_sid_con=
text(i));
> +               const char *s =3D security_get_initial_sid_context(i);
> +
> +               if (!s)
> +                       continue;
> +               dentry =3D d_alloc_name(dir, s);
>                 if (!dentry)
>                         return -ENOMEM;
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 32b3a8acf96f..406fb02d80ae 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -867,29 +867,28 @@ int policydb_load_isids(struct policydb *p,
> struct sidtab *s)
>
>         head =3D p->ocontexts[OCON_ISID];
>         for (c =3D head; c; c =3D c->next) {
> -               rc =3D -EINVAL;
> -               if (!c->context[0].user) {
> -                       pr_err("SELinux:  SID %s was never defined.\n",
> -                               c->u.name);
> -                       sidtab_destroy(s);
> -                       goto out;
> -               }
> -               if (c->sid[0] =3D=3D SECSID_NULL || c->sid[0] > SECINITSI=
D_NUM) {
> -                       pr_err("SELinux:  Initial SID %s out of range.\n"=
,
> -                               c->u.name);
> +               u32 sid =3D c->sid[0];
> +               const char *name =3D security_get_initial_sid_context(sid=
);
> +
> +               if (sid =3D=3D SECSID_NULL) {
> +                       pr_err("SELinux:  SID 0 was assigned a context.\n=
");
>                         sidtab_destroy(s);
>                         goto out;
>                 }
> +
> +               /* Ignore initial SIDs unused by this kernel. */
> +               if (!name)
> +                       continue;
> +
>                 rc =3D context_add_hash(p, &c->context[0]);
>                 if (rc) {
>                         sidtab_destroy(s);
>                         goto out;
>                 }
> -
> -               rc =3D sidtab_set_initial(s, c->sid[0], &c->context[0]);
> +               rc =3D sidtab_set_initial(s, sid, &c->context[0]);
>                 if (rc) {
>                         pr_err("SELinux:  unable to load initial SID %s.\=
n",
> -                               c->u.name);
> +                              name);
>                         sidtab_destroy(s);
>                         goto out;
>                 }
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index f90e6550eec8..8ad34fd031d1 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1322,23 +1322,22 @@ static int security_sid_to_context_core(struct
> selinux_state *state,
>         if (!selinux_initialized(state)) {
>                 if (sid <=3D SECINITSID_NUM) {
>                         char *scontextp;
> +                       const char *s =3D initial_sid_to_string[sid];
>
> -                       *scontext_len =3D strlen(initial_sid_to_string[si=
d]) + 1;
> +                       if (!s)
> +                               return -EINVAL;
> +                       *scontext_len =3D strlen(s) + 1;
>                         if (!scontext)
> -                               goto out;
> -                       scontextp =3D kmemdup(initial_sid_to_string[sid],
> -                                           *scontext_len, GFP_ATOMIC);
> -                       if (!scontextp) {
> -                               rc =3D -ENOMEM;
> -                               goto out;
> -                       }
> +                               return 0;
> +                       scontextp =3D kmemdup(s, *scontext_len, GFP_ATOMI=
C);
> +                       if (!scontextp)
> +                               return -ENOMEM;
>                         *scontext =3D scontextp;
> -                       goto out;
> +                       return 0;
>                 }
>                 pr_err("SELinux: %s:  called before initial "
>                        "load_policy on unknown SID %d\n", __func__, sid);
> -               rc =3D -EINVAL;
> -               goto out;
> +               return -EINVAL;
>         }
>         read_lock(&state->ss->policy_rwlock);
>         policydb =3D &state->ss->policydb;
> @@ -1362,7 +1361,6 @@ static int security_sid_to_context_core(struct
> selinux_state *state,
>
>  out_unlock:
>         read_unlock(&state->ss->policy_rwlock);
> -out:
>         return rc;
>
>  }
> @@ -1552,7 +1550,9 @@ static int security_context_to_sid_core(struct
> selinux_state *state,
>                 int i;
>
>                 for (i =3D 1; i < SECINITSID_NUM; i++) {
> -                       if (!strcmp(initial_sid_to_string[i], scontext2))=
 {
> +                       const char *s =3D initial_sid_to_string[i];
> +
> +                       if (s && !strcmp(s, scontext2)) {
>                                 *sid =3D i;
>                                 goto out;
>                         }
> --
> 2.24.1
>
>
>
> --
> paul moore
> www.paul-moore.com
