Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6695C0015E
	for <selinux@archiver.kernel.org>; Sat, 22 Jul 2023 15:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGVPN7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Jul 2023 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGVPN6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Jul 2023 11:13:58 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AFA26A2;
        Sat, 22 Jul 2023 08:13:56 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7658430eb5dso300665585a.2;
        Sat, 22 Jul 2023 08:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690038835; x=1690643635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dl3kjTmeisaenWV1hFG6e2Uin26namN1YT4lqRWCihU=;
        b=CeViR0BABdGBHqwQw1GRZhIX1A7EBB5OfrPuMrXD1avRP+XTnKtHbDq9RAP8hDhAw+
         L0v2Hy66z154nlQfpG4rA+zBSu2dBoVNxUr+aBXYmywPHR/Se3pin7hwP1MDHvdcnADQ
         GL8YAZI2DfXpTD/awJ13PS2KFPyen3vWUc20Yb2urssffc7QfoUX1Bisu1M6tsueoru8
         t8B2xtfi4/Hi5/SXmv4oU5OQK7xpERSlOidNW4vgxVsyEEgcuCWQyL5gK+gLD2qTiRNc
         KlSFTR5+opAZMpAdccZl2cj9a9FuAmT2H7POp5J5sK6Ub5zZCI4u2Gl4n2THHkgOc8nK
         mkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690038835; x=1690643635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dl3kjTmeisaenWV1hFG6e2Uin26namN1YT4lqRWCihU=;
        b=QRZG2BmqBgQgf5UcyZx3dnx6me2iY3Yy0oClKYWeZjeIK3j1SfEhwmHIuQxyBRMoKy
         Y3n4lW4Ib/DqepY+5smHicpORhqqVS0iozV/HmlBG2OPxQ3/Fg8xIZPklC1zHDP1GfH/
         2mSqeb8eCr9U+RiIGQ+mz17AnA9P8ba9XMyAn0+WVv4cFx5ezjRufssDoMc7zwFgRTYJ
         bAtwI69C6Ble0tEZDa+E7B+36GM56RWorUM2HstaoP0pr/qhl4P2DDAZmqXJruJIl9bD
         cgxiwDzjNPjQRP82KbkpnUHBSZUADukKjOhclLDWupq1dQfyrDinQ4bM4KhwD1QIXstY
         lMTQ==
X-Gm-Message-State: ABy/qLYVYRVbFgz1vb7ptqoUSwIgHaGeZbqBuRLMyuWEfVAjNCYXEwJk
        jFhLJyylE0f2Txscy3bdOgC74QY1Ov0bFHROKpLOeMh3KE73NMGB
X-Google-Smtp-Source: APBJJlE/DtiyqePdri7zCe6LRSji/7mCWTQuI1Pw0xpbS0N+tMXCFwQEv0iPEpZwFJrNTnRFk17GxvY+MTMKm2Ww5LI=
X-Received: by 2002:a05:620a:4610:b0:767:464e:c529 with SMTP id
 br16-20020a05620a461000b00767464ec529mr3958017qkb.2.1690038835579; Sat, 22
 Jul 2023 08:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220125145931.56831-1-cgzones@googlemail.com>
 <CAHC9VhTCf4L9rif-+7gTK64JoUiDv28DFwS1vUsvzv8rG+JCuQ@mail.gmail.com>
 <8ea4d17a-f2fd-b6a5-b988-0edbc63022f6@ieee.org> <CAHC9VhQE4B89ybnGooy599CVoA7aLd06jUkSZoWAYZWgD=BT8A@mail.gmail.com>
In-Reply-To: <CAHC9VhQE4B89ybnGooy599CVoA7aLd06jUkSZoWAYZWgD=BT8A@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Sat, 22 Jul 2023 17:13:44 +0200
Message-ID: <CAJ2a_DeqYmo0mv9VSWFLv-vg46NdFWo0jj7yZ7ZDarZcYReWQg@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: split no transition execve check
To:     selinux@vger.kernel.org
Cc:     Chris PeBenito <pebenito@ieee.org>,
        Paul Moore <paul@paul-moore.com>,
        selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 28 Jan 2022 at 02:47, Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Jan 27, 2022 at 8:42 AM Chris PeBenito <pebenito@ieee.org> wrote:
> > On 1/26/22 17:51, Paul Moore wrote:
> > > On Tue, Jan 25, 2022 at 9:59 AM Christian G=C3=B6ttsche
> > > <cgzones@googlemail.com> wrote:
> > >>
> > >> In case a setuid or setgid binary is mislabeled with a generic conte=
xt,
> > >> either via a policy mistake or a move by the distribution package,
> > >> executing it will be checked by the file permission execute_no_trans=
 on
> > >> the generic file context (e.g. bin_t).  The setuid(2)/setgid(2) sysc=
all
> > >> within will then be checked against the unchanged caller process
> > >> context, which might have been granted the capability permission set=
uid/
> > >> setgid to initially drop privileges.  To avoid that scenario split t=
he
> > >> execute_no_trans permission in case of a setuid/setgid binary into a=
 new
> > >> permission execute_sxid_no_trans.
> > >>
> > >> For backward compatibility this behavior is contained in a new polic=
y
> > >> capability.
> > >>
> > >> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >> ---
> > >>   security/selinux/hooks.c                   | 9 ++++++++-
> > >>   security/selinux/include/classmap.h        | 2 +-
> > >>   security/selinux/include/policycap.h       | 1 +
> > >>   security/selinux/include/policycap_names.h | 3 ++-
> > >>   security/selinux/include/security.h        | 8 ++++++++
> > >>   5 files changed, 20 insertions(+), 3 deletions(-)
> > >
> > > Adding the refpolicy list to this thread as their opinion seems
> > > particularly relevant to this discussion.
> > >
> > > FWIW, this looks reasonable to me but I would like to hear what other=
s
> > > have to say.
> >
> > I think this a band-aid to cover up the real problem, which is the misl=
abeled files.
>
> It's hard to disagree with that, and the kernel is probably the wrong
> place to apply a band-aid unless it is the only option left.
>

Adding a new datapoint to this RFC:

An unprivileged user can via the setuid binary newgrp(1) write
arbitrary content to files he can open in write mode but not actually
write to, e.g. /proc/sys/kernel/ns_last_pid [1].
This also is reproducible on Fedora where /usr/bin/newgrp has the
generic context bin_t, so the write (and capable check) happens in the
caller context of unconfined_t.

With the proposed permission split applied and instead of granting
unconfined_t the new permission execute_sxid_no_trans but relying on
an intermediate template domain $1_newgrp_t the access would have been
denied, due to lack of permissions of the templated newgrp domain.
With a generic file type of bin_t newgrp would not be executable for
callers otherwise. Most setuid binaries are already labeled with a
private type, newgrp and pkexec are the only ones left on a head-less
Fedora system.
One could still argue this is a policy neglect, but normally policy
neglects result in missing permissions and reduced functionality, not
in unintended privilege escalation.


[1]: https://github.com/shadow-maint/shadow/pull/758

> > >> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > >> index 5b6895e4fc29..b825fee39a70 100644
> > >> --- a/security/selinux/hooks.c
> > >> +++ b/security/selinux/hooks.c
> > >> @@ -2348,9 +2348,16 @@ static int selinux_bprm_creds_for_exec(struct=
 linux_binprm *bprm)
> > >>          ad.u.file =3D bprm->file;
> > >>
> > >>          if (new_tsec->sid =3D=3D old_tsec->sid) {
> > >> +               u32 perm;
> > >> +
> > >> +               if (selinux_policycap_execute_sxid_no_trans() && is_=
sxid(inode->i_mode))
> > >> +                       perm =3D FILE__EXECUTE_SXID_NO_TRANS;
> > >> +               else
> > >> +                       perm =3D FILE__EXECUTE_NO_TRANS;
> > >> +
> > >>                  rc =3D avc_has_perm(&selinux_state,
> > >>                                    old_tsec->sid, isec->sid,
> > >> -                                 SECCLASS_FILE, FILE__EXECUTE_NO_TR=
ANS, &ad);
> > >> +                                 SECCLASS_FILE, perm, &ad);
> > >>                  if (rc)
> > >>                          return rc;
> > >>          } else {
> > >> diff --git a/security/selinux/include/classmap.h b/security/selinux/=
include/classmap.h
> > >> index 35aac62a662e..53a1eeeb86fb 100644
> > >> --- a/security/selinux/include/classmap.h
> > >> +++ b/security/selinux/include/classmap.h
> > >> @@ -65,7 +65,7 @@ struct security_class_mapping secclass_map[] =3D {
> > >>              "quotaget", "watch", NULL } },
> > >>          { "file",
> > >>            { COMMON_FILE_PERMS,
> > >> -           "execute_no_trans", "entrypoint", NULL } },
> > >> +           "execute_no_trans", "entrypoint", "execute_sxid_no_trans=
", NULL } },
> > >>          { "dir",
> > >>            { COMMON_FILE_PERMS, "add_name", "remove_name",
> > >>              "reparent", "search", "rmdir", NULL } },
> > >> diff --git a/security/selinux/include/policycap.h b/security/selinux=
/include/policycap.h
> > >> index 2ec038efbb03..23929dc3e1db 100644
> > >> --- a/security/selinux/include/policycap.h
> > >> +++ b/security/selinux/include/policycap.h
> > >> @@ -11,6 +11,7 @@ enum {
> > >>          POLICYDB_CAPABILITY_CGROUPSECLABEL,
> > >>          POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
> > >>          POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
> > >> +       POLICYDB_CAPABILITY_EXECUTE_SXID_NO_TRANS,
> > >>          __POLICYDB_CAPABILITY_MAX
> > >>   };
> > >>   #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> > >> diff --git a/security/selinux/include/policycap_names.h b/security/s=
elinux/include/policycap_names.h
> > >> index b89289f092c9..4c014c2cf352 100644
> > >> --- a/security/selinux/include/policycap_names.h
> > >> +++ b/security/selinux/include/policycap_names.h
> > >> @@ -12,7 +12,8 @@ const char *selinux_policycap_names[__POLICYDB_CAP=
ABILITY_MAX] =3D {
> > >>          "always_check_network",
> > >>          "cgroup_seclabel",
> > >>          "nnp_nosuid_transition",
> > >> -       "genfs_seclabel_symlinks"
> > >> +       "genfs_seclabel_symlinks",
> > >> +       "execute_sxid_no_trans",
> > >>   };
> > >>
> > >>   #endif /* _SELINUX_POLICYCAP_NAMES_H_ */
> > >> diff --git a/security/selinux/include/security.h b/security/selinux/=
include/security.h
> > >> index ac0ece01305a..ab95241b6b7b 100644
> > >> --- a/security/selinux/include/security.h
> > >> +++ b/security/selinux/include/security.h
> > >> @@ -219,6 +219,14 @@ static inline bool selinux_policycap_genfs_secl=
abel_symlinks(void)
> > >>          return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_GENFS=
_SECLABEL_SYMLINKS]);
> > >>   }
> > >>
> > >> +static inline bool selinux_policycap_execute_sxid_no_trans(void)
> > >> +{
> > >> +       struct selinux_state *state =3D &selinux_state;
> > >> +
> > >> +       return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_EXECUT=
E_SXID_NO_TRANS]);
> > >> +}
> > >> +
> > >> +
> > >>   struct selinux_policy_convert_data;
> > >>
> > >>   struct selinux_load_state {
> > >> --
> > >> 2.34.1
> > >>
> > >
> > >
> >
> >
> > --
> > Chris PeBenito
>
>
>
> --
> paul-moore.com
