Return-Path: <SRS0=ncaB=5Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC04FC2D0EE
	for <selinux@archiver.kernel.org>; Tue, 31 Mar 2020 00:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748D320784
	for <selinux@archiver.kernel.org>; Tue, 31 Mar 2020 00:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="bmi90RGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgCaAi2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Mar 2020 20:38:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43462 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbgCaAi1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Mar 2020 20:38:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id bd14so23049217edb.10
        for <selinux@vger.kernel.org>; Mon, 30 Mar 2020 17:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=gErK/ycbJv6uqf+b3FCQW59lfsmjwCyYyXfDMASF3Kk=;
        b=bmi90RGsEkcS9xmzCDYV77nBmN8IBmwM/+Y8QthDzbikrqfYed/KIeivKZhM+fHGGi
         YoMt9bctZEnfzv14hxqz0MZVnzUpH+tnNKrA30nZGmkyyGd4eO3VCRUeywUBJVdugXBR
         BRffgH77n9eYL2YuB4X8DOm094puYLo4d/KeNs3sO9aJHnmOvd71uy++X49H3idJKolm
         dhCBThw6rj0AfycOdLL/OHv1zNKF2RNjyvY6WbxZuW22Ex266CtkHAoL6DnSlfdejJop
         wWAW4DlTqm2QDjzkmUP3GvKIFSE2vr51sN/eTIx6TlrmJvLbrTQPREqIl/Ya6BkosqF1
         OXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=gErK/ycbJv6uqf+b3FCQW59lfsmjwCyYyXfDMASF3Kk=;
        b=TD4aesArYIDvE8K/VVjYV0rv2ViXLHzvpdR8C9rPMthTeaFQdosFJGaeTp96jgIDtp
         TyvPaHh+2hrJxSCodGww1b6KG7iRycjb9OibArEhH4zycZ/fx0kR2XKFL0PIzhauqPTY
         ZaNOBOZH/Qc0m33/N4ORAbaPcqHtmgHlVYRUAQV4ljXjT7ynIHhdo0vgdKgiVspsLb8E
         3zQdv3IU2zLmXbOuO8V3r2DaatWwGlwHiiGqBt8XtjfjxHDODOJsH7mtSKvHcVr5jHPn
         l4tvtqVZkomXVOh32jkeBDZdaAa3Eux8MT/N01u/DmytYfDKk6l+j9NehSyr9k4dWFci
         c+hA==
X-Gm-Message-State: ANhLgQ1m0gdQikIj4fpguqfIO5QvG0vo716T5AZm9NWzYd2NCvu9NnlH
        euwqBgobAHM4EyJhmNZr9+DjxQRbQLwSjyDQba0J
X-Google-Smtp-Source: ADFU+vvbmDfTAgpqjM3WtkbVSAeOOdDuxDWDFm6MYhl+NVQcodlPN0Tw+SISf0OLn2BcCUowitkP+UC1bMW5+D2ypsU=
X-Received: by 2002:aa7:db56:: with SMTP id n22mr13804870edt.269.1585615105547;
 Mon, 30 Mar 2020 17:38:25 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Mar 2020 20:38:17 -0400
Message-ID: <CAHC9VhQoqpqiFncTP1w0+--hGTwcm57LXgrXVsGnNqcRSof1WA@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

We've got twenty SELinux patches for the v5.7 merge window, the
highlights are below.  Beyond the highlights there a couple of things
I want to call out in this pull request: a merge conflict, and a
maintainer screw-up.

The merge conflict is in security/selinux/hooks.c and is against a
binder fs name fix we sent during the v5.6-rcX cycle; the fixup is
trivial but if you need me to fix it, let me know.  The maintainer
screw-up deals with the second patch from the top of the pull request,
the NFS fix.  The screw-up isn't the fact that this is a NFS patch, we
talked to the NFS guys and they are okay with it.  The issue is that
the commit date is today - during the merge window - which doesn't
reflect the testing the patch received.  The reality is that I merged
this patch back on March 12th, and it has been part of our testing
ever since, but when putting this pull request together I noticed that
I had dropped the subject line from the patch when I was merging it.
Not wanting a malformed commit, I popped the top two patches from the
stack and restored the missing subject line; this had the unfortunate
side effect of making it look like the two top patches were just
merged today - my apologies.

Regardless, here are the highlights:

- Deprecate setting /sys/fs/selinux/checkreqprot to 1.  This flag was
originally created to deal with legacy userspace and the
READ_IMPLIES_EXEC personality flag.  We changed the default from 1 to
0 back in Linux v4.4 and now we are taking the next step of
deprecating it, at some point in the future we will take the final
step of rejecting 1.
- Allow kernfs symlinks to inherit the SELinux label of the parent
directory.  In order to preserve backwards compatibility this is
protected by the genfs_seclabel_symlinks SELinux policy capability.
- Optimize how we store filename transitions in the kernel, resulting
in some significant improvements to policy load times.
- Do a better job calculating our internal hash table sizes which
resulted in additional policy load improvements and likely general
SELinux performance improvements as well.
- Remove the unused initial SIDs (labels) and improve how we handle
initial SIDs.
- Enable per-file labeling for the bpf filesystem.
- Ensure that we properly label NFS v4.2 filesystems to avoid a
temporary unlabeled condition.
- Add some missing XFS quota command types to the SELinux quota access cont=
rols.
- Fix a problem where we were not updating the seq_file position index
correctly in selinuxfs.
- We consolidate some duplicated code into helper functions.
- A number of list to array conversions.
- Update Stephen Smalley's email address in MAINTAINERS.

Thanks,
-Paul
--
The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9=
:

 Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20200330

for you to fetch changes up to c753924b628551564b6eea3c9896e4a95aa25ed9:

 selinux: clean up indentation issue with assignment statement
   (2020-03-30 19:57:07 -0400)

----------------------------------------------------------------
selinux/stable-5.7 PR 20200330

----------------------------------------------------------------
Christian G=C3=B6ttsche (1):
     selinux: allow kernfs symlinks to inherit parent directory context

Colin Ian King (1):
     selinux: clean up indentation issue with assignment statement

Connor O'Brien (1):
     security: selinux: allow per-file labeling for bpffs

Ondrej Mosnacek (10):
     selinux: move status variables out of selinux_ss
     selinux: simplify evaluate_cond_node()
     selinux: convert cond_list to array
     selinux: convert cond_av_list to array
     selinux: convert cond_expr to array
     selinux: generalize evaluate_cond_node()
     selinux: factor out loop body from filename_trans_read()
     selinux: optimize storage of filename transitions
     selinux: reduce the use of hard-coded hash sizes
     selinux: clean up error path in policydb_init()

Paul Moore (1):
     selinux: avtab_init() and cond_policydb_init() return void

Richard Haines (1):
     selinux: Add xfs quota command types

Scott Mayhew (1):
     NFS: Ensure security label is set for root inode

Stephen Smalley (3):
     Documentation,selinux: deprecate setting checkreqprot to 1
     selinux: remove unused initial SIDs and improve handling
     MAINTAINERS: Update my email address

Vasily Averin (1):
     selinux: sel_avc_get_stat_idx should increase position index

.../ABI/obsolete/sysfs-selinux-checkreqprot        |  23 ++
Documentation/admin-guide/kernel-parameters.txt    |   1 +
MAINTAINERS                                        |   3 +-
fs/nfs/getroot.c                                   |  39 ++-
fs/nfs/nfs4proc.c                                  |  12 +-
fs/nfs/super.c                                     |  25 --
include/linux/nfs_xdr.h                            |   1 +
scripts/selinux/genheaders/genheaders.c            |  11 +-
security/selinux/Kconfig                           |   3 +
security/selinux/Makefile                          |   4 +-
security/selinux/hooks.c                           |  18 +-
security/selinux/include/conditional.h             |   8 +-
security/selinux/include/initial_sid_to_string.h   |  57 ++--
security/selinux/include/security.h                |  12 +
security/selinux/selinuxfs.c                       |  19 +-
security/selinux/ss/avtab.c                        |   3 +-
security/selinux/ss/avtab.h                        |   2 +-
security/selinux/ss/conditional.c                  | 259 +++++-------
security/selinux/ss/conditional.h                  |  29 +-
security/selinux/ss/hashtab.c                      |  28 +-
security/selinux/ss/hashtab.h                      |   2 +-
security/selinux/ss/policydb.c                     | 326 ++++++++---------
security/selinux/ss/policydb.h                     |  13 +-
security/selinux/ss/services.c                     |  79 +++--
security/selinux/ss/services.h                     |   2 -
security/selinux/{ss =3D> }/status.c                 |  32 +-
26 files changed, 521 insertions(+), 490 deletions(-)
create mode 100644 Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
rename security/selinux/{ss =3D> }/status.c (81%)

--=20
paul moore
www.paul-moore.com
