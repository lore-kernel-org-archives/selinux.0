Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF9C7261A
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317590; cv=none; b=FI7w0/X0TRgv13O6Go+t0jG+b4tbDxs8R3yIdH50YLJ8DwINURRnyRbJ0rDRB2fpsWDW6I/Aia12QHTq/BchliIN77Rm4WW6q2tRXg9MuYOlwLvK6wywFmVmILMBNku+7D5iWbCBDs+BgcVZUFAh66D0Ii5U1UZQZHGFHVqQ1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317590; c=relaxed/simple;
	bh=9cVcEINgHDOaBqVdUrINjyeXAmHsLQWEvcbyFY/U34k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyDE+Lz5jlZtr5HD1AMmP+vGlhuMnY16lOGcX9/y8ohF82S/J1Emoh4lzO4bGVFlooWXFZ2acPexNMry9qDSLR60ruafiE6zul4CeCiHyjCNfgGtLbhSgOMN5dci7b1bBUQKTvbYrolpCw7DmVGo65Kz3oNGXk+rmTjjgl85Uzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifUzSlIL; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifUzSlIL"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b239763eeddso699388a12.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747317588; x=1747922388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX6ly8PCTvwjynK/36iG5Gyjp8BOdT1mlQVOO78bWoE=;
        b=ifUzSlILajehDpHpHffxZijhKTU2qYrmbj1XG9dPgK5EgTnbjZ1stHKTw95+blKItB
         +tqRSvO6tStfB3Gi3KyJRzRYJ1qanY2laPSLoUqKmje/LdY9FkbDBFUYmXKTa7GZ9Ofo
         2cz1dyQGOpV/PKqjPbaP/rlHOBJoPhD5j3wQ2cjSOu7rtS5cnOHZ1/G2TTcWgMuU8fnC
         8jDcdBETV9NKoa83CP5Bop4TKmnGEKgTCyyIYTZOjXhAytPZplZVmmJUE9I3KVSxJFyq
         NnWW9x1Vtx5j0stUmvcfrr8yiYtJo8ZlMRcmgmh6hbK+OyOMyqyT2sl59TkoyltAw3Xs
         D86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747317588; x=1747922388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WX6ly8PCTvwjynK/36iG5Gyjp8BOdT1mlQVOO78bWoE=;
        b=TJKrEI9O72AC3k7HO5uo1876F6yJtgszUW5ifXgug9cjaSu9Z9OfCKW3mn3SPJNPpM
         Z0VHgb694q7+93HN08eG56u1j/gKR6ORN2MoPB9ycWoQZu61hKUwDBA0SG5+WVgaF1DD
         sGKpD3v96QxzpwWB+DLcQNUtfK4YzoGIgy2qeCiBXd7dkAvFQ7vGmKLUzslpmgkg+cw1
         6DQtF0BNuRCmGUTl+sZQ7toMb4HO0VUkE604SIgZCCgtxwKlNabQjS5oVxXaJupKdk4B
         QAO0fVcJCVPX0Vg14UZ0GWUJAmPTxTuaq3Wu+3E96pHII1SbefACT4N6lyflT+2lSZOI
         Z6cg==
X-Gm-Message-State: AOJu0YyWaAaR9kooN7xOCctB0xE3J4gsCoOOf0jdvV4ppK02Ry0FtG8l
	px/IpQVKUjpJI+ZlQ+WC48tZ/YP51l0EbDDoo7aov1C/+HXQqc3wm7Qyo8lm74eTkpAmaP19zq3
	D91iFAAKc3JGSE5tCN6Sr9NEH7ESe4G9B
X-Gm-Gg: ASbGncu1hLNm2jQGkyKNWI9F+58aGDOexKnwjb5uG8m0Xn1WdvrnaOR9JjWLS/t99wT
	O0ccTAwye+E2ohuDtBxDwpzCEibrBezGgtgEc1X037pMf3B5GVd+WHzlyRVVVXtCRmuWqQUS5Q9
	UxJXthD+s71gavHIKuHDbcXo3QIyMhA7nQ
X-Google-Smtp-Source: AGHT+IHTSqpzLsdLKDjME/6mMSVd2vr18TwJIc30zF7m9XY0BUGHa4WDJCIH7F3RxjGeXgb0B/ElibNutdMkPnd/Lzo=
X-Received: by 2002:a17:90b:1cce:b0:306:b6f7:58ba with SMTP id
 98e67ed59e1d1-30e5156ea36mr3598986a91.6.1747317587889; Thu, 15 May 2025
 06:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com> <CAEjxPJ5Tt_xPiFQ5ftfMjRwCLZ9T-MiAaPfE8hsd3YyD5OTLZA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5Tt_xPiFQ5ftfMjRwCLZ9T-MiAaPfE8hsd3YyD5OTLZA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 May 2025 09:59:36 -0400
X-Gm-Features: AX0GCFs95FLeQw3_8_WevLpkiQWW-RyBQpZ2IYk7lVXwsz8zoKSPUjI5iA_cCVU
Message-ID: <CAEjxPJ4K2=4AXU7dQJepgaNiOp5sm8nNxhYS3gvsAgrd3u1W_Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/49] SELinux namespace support
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 9:35=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, May 15, 2025 at 9:10=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > This series introduces support for a SELinux namespace, i.e.
> > the ability to namespace the SELinux policy, AVC, and
> > enforcing mode. This support can be leveraged by Linux
> > container runtimes to establish a private SELinux namespace
> > for each container, enabling the container to load and
> > enforce its own policy while still remaining bound by the
> > host OS policy (if any). More information about SELinux
> > namespaces can be found at the following URL:
> >         https://github.com/stephensmalley/selinuxns
>
> NB Some of the later patches could potentially be moved up and
> squashed into earlier ones before merge if desired.
> I've identified a few candidates below. I've left some separate for
> ease of review or because they are
> somewhat sticky to untangle from intermediate commits and because I
> don't have a sense as to which
> parts might be deemed mergeable at this time. That said, given the
> performance data which I've shared
> privately (happy to post on list), I don't see any performance-related
> concerns with any of the patches
> especially when CONFIG_SECURITY_SELINUX_NS=3Dn which would be the default=
.

Here is the performance data, which I could put into one of the patch
descriptions if desired (not sure which one though since it was based
on all of the patches being applied):

Baseline =3D v6.15-rc1+selinux/dev@05f1a939225ec8
No NS =3D my working-selinuxns branch with SECURITY_SELINUX_NS=3Dn
Init NS =3D Same but with SECURITY_SELINUX_NS=3Dy from init SELinux namespa=
ce
Child NS =3D Same but from a child SELinux namespace

kbench (automated kernel compilation benchmark packaged by Fedora, run
with -s 6.13 for 10 runs, computing average and standard deviation):
| CPUs | Baseline (sec) |  Std Dev | No NS (sec) | Init NS (sec) |
Child NS (sec) |
| 16 | 122.56 | 0.68 | 122.94 | 122.86 | 122.76 |
| 19 | 123.61 |  0.34 | 124.11 | 124.15 | 123.65 |

perf record make =E2=80=93jN on fully built allmodconfig kernel tree as per
Linus' specs,
NB This is NOT including my neveraudit|permissive patches which would
greatly reduce these percentages.
| Function | Baseline | NoNS | InitNS | ChildNS |
| __d_lookup_rcu | 1.68% | 1.79% | 1.63% | 1.69% |
| selinux_inode_permission | 0.59% |  0.53% | 0.46% | 0.47% |
| selinux_inode_getattr | 0.37% | 0.42% | 0.39% | 0.40% |
| avc_lookup | 0.20% | 0.09% | 0.11% | 0.22% |
| avc_has_perm/_noaudit | 0.10% | 0.04% | 0.04% | 0.09% |
| avc_policy_seqno | 0.02% | 0.15% | 0.14% | 0.14% |
| cred_tsid_has_perm | N/A | 0.07% | 0.06% | 0.11% |
| Total SELinux | 1.28% | 1.30% | 1.20% | 1.43% |
| SELinux/d_lookup_rcu | 0.762 |  0.726 | 0.736 | 0.846 |

ApacheBench, packaged by Fedora, run as ab =E2=80=93n 100000 =E2=80=93c 100=
0 http://localhost/
ten times computing average and stddev:
| Metric | Baseline | Std Dev | No NS | Init NS | Child NS |
| Time taken (sec) |  7.7115 | 0.805 |  7.3128 | 7.5505 | 7.6774 |
| Reqs / sec | 13112.2 | 1394.9 | 13731.8 | 13443.5 | 13155 |
| Time per req (ms) | 77.1154 | 8.0497 | 73.1283 | 75.505 | 76.7726 |
| Transfer rate (KB/sec) | 112069 | 11922 | 117364 | 114900 | 112434 |
| Connect time median (ms) | 30.4 | 5.95 | 28.5 | 28.2 | 31.3 |
| Total time median (ms) | 75.5 | 11.5 | 69.0 | 70.4 | 73.7 |

Also ran iperf3 and netperf but results all seemed to be in the noise
(within stddev).

Happy to run with different parameters or run different benchmarks if
that would help.
Looked at both lkp-tests and phoronix but wasn't obvious which tests
of the former to run or how to automate and the latter seemed to
mostly fail to build and/or run on Fedora despite being packaged for
it.

>
> >
> > Stephen Smalley (49):
> >   selinux: restore passing of selinux_state
> >   selinux: introduce current_selinux_state
> >   selinux: support multiple selinuxfs instances
> >   selinux: dynamically allocate selinux namespace
> >   netstate,selinux: create the selinux netlink socket per network
> >     namespace
>
> I likely should have copied the net namespace maintainers on this one,
> will do so in later submissions.
> Regardless, it would make sense to squash the later "selinux: limit
> selinux netlink notifications to init namespace"
> commit into this one since it addresses the concern noted in the patch
> description.
>
> >   selinux: support per-task/cred selinux namespace
> >   selinux: introduce cred_selinux_state() and use it
> >   selinux: add a selinuxfs interface to unshare selinux namespace
> >   selinuxfs: restrict write operations to the same selinux namespace
> >   selinux: introduce a global SID table
> >   selinux: wrap security server interfaces to use the global SID table
> >   selinux: update hook functions to use correct selinux namespace
> >   selinux: introduce cred_task_has_perm()
> >   selinux: introduce cred_has_extended_perms()
> >   selinux: introduce cred_self_has_perm()
> >   selinux: introduce cred_has_perm()
> >   selinux: introduce cred_ssid_has_perm() and cred_other_has_perm()
> >   selinux: introduce task_obj_perm()
> >   selinux: fix selinux_lsm_getattr() check
>
> This could be squashed into the original commit where I first convert
> this check.
>
> >   selinux: update bprm hooks for selinux namespaces
> >   selinux: add kerneldoc to new permission checking functions
>
> Could be split up and squashed into the commits that introduce those func=
tions.
>
> >   selinux: convert selinux_file_send_sigiotask() to namespace-aware
> >     helper
> >   selinux: rename cred_has_perm*() to cred_tsid_has_perm*()
>
> Could be squashed into the original commit so that it always uses this na=
me.
>
> >   selinux: convert additional checks to cred_ssid_has_perm()
> >   selinux: introduce selinux_state_has_perm()
> >   selinux: annotate selinuxfs permission checks
> >   selinux: annotate process transition permission checks
> >   selinux: convert xfrm and netlabel permission checks
> >   selinux: switch selinux_lsm_setattr() checks to current namespace
>
> Could be squashed into earlier commits converting these checks.
>
> >   selinux: add limits for SELinux namespaces
> >   selinux: fix namespace creation
>
> Could be squashed into the original commit introducing namespace creation=
.
>
> >   selinux: limit selinux netlink notifications to init namespace
> >   selinux: refactor selinux_state_create()
>
> Could be squashed into the original commit introducing this function.
>
> >   selinux: make open_perms namespace-aware
> >   selinux: split cred_ssid_has_perm() into two cases
> >   selinux: set initial SID context for init to "kernel" in global SID
> >     table
> >   selinux: disallow writes to /sys/fs/selinux/user in non-init
> >     namespaces
> >   selinux: convert nlmsg_sock_has_extended_perms() to namespace-aware
> >   selinux: init inode from nearest initialized namespace
> >   selinux: allow userspace to detect non-init SELinux namespace
> >   selinux: exempt creation of init SELinux namespace from limits
>
> Could be squashed into original commit introducing limits.
>
> >   selinux: introduce a Kconfig option for SELinux namespaces
> >   selinux: eliminate global SID table if !CONFIG_SECURITY_SELINUX_NS
>
> Both could be moved earlier in the series.
>
> >   selinux: maintain a small cache in the global SID table
> >   selinux: change /sys/fs/selinux/unshare to check current process stat=
e
>
> Could be squashed into original commit introducing /sys/fs/selinux/unshar=
e.
>
> >   selinux: acquire/release SELinux state properly in socket hooks
>
> Could be squashed into original commit introducing the state field of
> the sock security blob.
>
> >   selinux: update cred_tsid_has_perm_noaudit() to return the combined
> >     avd
>
> Could be squashed into the original commit introducing this function.
>
> >   selinux: repair security_fs_use() interface and its users
>
> Could be squashed into the original commit introducing the wrapper functi=
ons.
>
> >   selinux: style cleanups for node_sid prototypes
>
> Could be squashed into the original commit introducing the wrapper functi=
ons.
>
> >
> >  include/net/net_namespace.h                   |    3 +
> >  security/selinux/Kconfig                      |   65 +
> >  security/selinux/Makefile                     |    1 +
> >  security/selinux/avc.c                        |  782 ++++++++--
> >  security/selinux/global_sidtab.c              |  810 ++++++++++
> >  security/selinux/hooks.c                      | 1339 +++++++++++------
> >  security/selinux/ibpkey.c                     |    2 +-
> >  security/selinux/ima.c                        |   37 +-
> >  security/selinux/include/audit.h              |    8 +
> >  security/selinux/include/avc.h                |   77 +-
> >  security/selinux/include/avc_ss.h             |    3 +-
> >  security/selinux/{ss =3D> include}/avtab.h      |    0
> >  security/selinux/include/classmap.h           |    2 +-
> >  security/selinux/include/conditional.h        |    4 +-
> >  security/selinux/{ss =3D> include}/constraint.h |    0
> >  security/selinux/{ss =3D> include}/context.h    |    0
> >  security/selinux/{ss =3D> include}/ebitmap.h    |    0
> >  security/selinux/include/global_sidtab.h      |   26 +
> >  security/selinux/{ss =3D> include}/hashtab.h    |    0
> >  security/selinux/include/ima.h                |   11 +-
> >  security/selinux/{ss =3D> include}/mls.h        |    0
> >  security/selinux/{ss =3D> include}/mls_types.h  |    0
> >  security/selinux/include/netif.h              |    4 +-
> >  security/selinux/include/netlabel.h           |   14 +-
> >  security/selinux/include/netnode.h            |    4 +-
> >  security/selinux/include/objsec.h             |   43 +-
> >  security/selinux/{ss =3D> include}/policydb.h   |    0
> >  security/selinux/include/security.h           |  473 +++++-
> >  security/selinux/include/selinux_ss.h         |  119 ++
> >  security/selinux/{ss =3D> include}/sidtab.h     |   34 +
> >  security/selinux/{ss =3D> include}/symtab.h     |    0
> >  security/selinux/include/xfrm.h               |    8 +-
> >  security/selinux/netif.c                      |   31 +-
> >  security/selinux/netlabel.c                   |   32 +-
> >  security/selinux/netlink.c                    |   42 +-
> >  security/selinux/netnode.c                    |   26 +-
> >  security/selinux/netport.c                    |    2 +-
> >  security/selinux/selinuxfs.c                  |  551 ++++++-
> >  security/selinux/ss/services.c                |  453 +++---
> >  security/selinux/ss/services.h                |    1 +
> >  security/selinux/ss/sidtab.c                  |  105 +-
> >  security/selinux/status.c                     |   44 +-
> >  security/selinux/xfrm.c                       |   47 +-
> >  43 files changed, 4071 insertions(+), 1132 deletions(-)
> >  create mode 100644 security/selinux/global_sidtab.c
> >  rename security/selinux/{ss =3D> include}/avtab.h (100%)
> >  rename security/selinux/{ss =3D> include}/constraint.h (100%)
> >  rename security/selinux/{ss =3D> include}/context.h (100%)
> >  rename security/selinux/{ss =3D> include}/ebitmap.h (100%)
> >  create mode 100644 security/selinux/include/global_sidtab.h
> >  rename security/selinux/{ss =3D> include}/hashtab.h (100%)
> >  rename security/selinux/{ss =3D> include}/mls.h (100%)
> >  rename security/selinux/{ss =3D> include}/mls_types.h (100%)
> >  rename security/selinux/{ss =3D> include}/policydb.h (100%)
> >  create mode 100644 security/selinux/include/selinux_ss.h
> >  rename security/selinux/{ss =3D> include}/sidtab.h (81%)
> >  rename security/selinux/{ss =3D> include}/symtab.h (100%)
> >
> > --
> > 2.49.0
> >
