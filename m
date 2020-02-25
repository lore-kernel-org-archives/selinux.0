Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABAAC35DEA
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 01:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC181218AC
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 01:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="J/YHUHkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgBYBzI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Feb 2020 20:55:08 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37455 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBYBzI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Feb 2020 20:55:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id t7so14340939edr.4
        for <selinux@vger.kernel.org>; Mon, 24 Feb 2020 17:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YP481kTLkBgv+2KO+729KVuiGurZz/LtBiQbRGMh2Q8=;
        b=J/YHUHkbURqyl/zVIkZhvbslKZtdbbPBa4A7fetobs2GOcoDAWwZoF9Dc9VMl5XJG/
         y6cI5iDeN/BfpwlDDFKQuT0zrTpwDHeDe4BFPh6BekOrDglxn+5K6W4zBS8LsaE7fkdB
         35wH8zbAh7aiKV2sY2W86GnN59S69bRe+ffDxhlK/WHCxZiRn6sCZo6CmpdliqAqotfR
         xwzEmjjPuYikM1ABecVB6Ub/++W14hb3jTcR09wXHmax+a5LaI11aM542xGCqAMi70Nj
         F+SRyVtAK0YXKQgLy5Gp5ICcD/w+r7LOoJSIdeTBqK4hAc/6py1YBtKWcSNArUeXSYkk
         XHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YP481kTLkBgv+2KO+729KVuiGurZz/LtBiQbRGMh2Q8=;
        b=XI9Y1v1jrBgx9P8g3TDMmVPx3QuP2G9fQUXggn51kXVtTFGcX7TwUFw48O+b6br8W+
         O1KH1Y0QQiP7MPzBoAK7Q2xhnyQNURndY/7vFnebLf12gVq157ArnSFM7edWR+eZqc/L
         cqmfeD+7FDsY6rurNQX9jIMNME9xd3p52Zi1JOTxnadQ9fvidXeepGVOVw+MrsKY+K5j
         vrDdnYOG6xARcaP6oRfle3Bfwl0nsQjsqigv6C65Gk+q07letuasX44otkve3HX0UR3Z
         zZiozHBXo9qWsFhdq9ORCZwP/4SVMR/QQYAdrknZiu8jLY9JYLJnUZHeH3bTlhzKG4LR
         uhSQ==
X-Gm-Message-State: APjAAAUsaQ0Rr6Xr5xfS9egnrHRlRgg5fJtCeCacFpw/SCFKGlzKhq6m
        KKKPDuo+OIDJsulyHrKIGlL33b9qPLZWC7nDOER68bs=
X-Google-Smtp-Source: APXvYqxkk7paE161GZQbRGIhTuTAzhFAAM0Mqada56GvXF8rKzUKWn0I2D0VQCrG6imTgZBqDQntl7xv9kYP67eD3sM=
X-Received: by 2002:a50:e108:: with SMTP id h8mr46605102edl.196.1582595704110;
 Mon, 24 Feb 2020 17:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20200224161023.116134-1-sds@tycho.nsa.gov>
In-Reply-To: <20200224161023.116134-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Feb 2020 20:54:53 -0500
Message-ID: <CAHC9VhRhzeLCYHEavt6qFePFDgg8btbG2JQTQmmDMXiGu7-JPQ@mail.gmail.com>
Subject: Fwd: [PATCH v4] selinux: remove unused initial SIDs and improve handling
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, pebenito@ieee.org,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

FWD'ing this to the mailing list while Stephen is having problems posting.

---------- Forwarded message ---------
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Mon, Feb 24, 2020 at 11:09 AM
Subject: [PATCH v4] selinux: remove unused initial SIDs and improve handling
To: <selinux@vger.kernel.org>
Cc: <paul@paul-moore.com>, <omosnace@redhat.com>, <pebenito@ieee.org>,
Stephen Smalley <sds@tycho.nsa.gov>


Remove initial SIDs that have never been used or are no longer used by
the kernel from its string table, which is also used to generate the
SECINITSID_* symbols referenced in code.  Update the code to
gracefully handle the fact that these can now be NULL. Stop treating
it as an error if a policy defines additional initial SIDs unknown to
the kernel.  Do not load unused initial SID contexts into the sidtab.
Fix the incorrect usage of the name from the ocontext in error
messages when loading initial SIDs since these are not presently
written to the kernel policy and are therefore always NULL.

After this change, it is possible to safely reclaim and reuse some of
the unused initial SIDs without compatibility issues.  Specifically,
unused initial SIDs that were being assigned the same context as the
unlabeled initial SID in policies can be reclaimed and reused for
another purpose, with existing policies still treating them as having
the unlabeled context and future policies having the option of mapping
them to a more specific context.  For example, this could have been
used when the infiniband labeling support was introduced to define
initial SIDs for the default pkey and endport SIDs similar to the
handling of port/netif/node SIDs rather than always using
SECINITSID_UNLABELED as the default.

The set of safely reclaimable unused initial SIDs across all known
policies is igmp_packet (13), icmp_socket (14), tcp_socket (15), kmod
(24), policy (25), and scmp_packet (26); these initial SIDs were
assigned the same context as unlabeled in all known policies including
mls.  If only considering non-mls policies (i.e. assuming that mls
users always upgrade policy with their kernels), the set of safely
reclaimable unused initial SIDs further includes file_labels (6), init
(7), sysctl_modprobe (16), and sysctl_fs (18) through sysctl_dev (23).

Adding new initial SIDs beyond SECINITSID_NUM to policy unfortunately
became a fatal error in commit 24ed7fdae669 ("selinux: use separate
table for initial SID lookup") and even before that it could cause
problems on a policy reload (collision between the new initial SID and
one allocated at runtime) ever since commit 42596eafdd75 ("selinux:
load the initial SIDs upon every policy load") so we cannot safely
start adding new initial SIDs to policies beyond SECINITSID_NUM (27)
until such a time as all such kernels do not need to be supported and
only those that include this commit are relevant. That is not a big
deal since we haven't added a new initial SID since 2004 (v2.6.7) and
we have plenty of unused ones we can reclaim if we truly need one.

If we want to avoid the wasted storage in initial_sid_to_string[]
and/or sidtab->isids[] for the unused initial SIDs, we could introduce
an indirection between the kernel initial SID values and the policy
initial SID values and just map the policy SID values in the ocontexts
to the kernel values during policy_load_isids(). Originally I thought
we'd do this by preserving the initial SID names in the kernel policy
and creating a mapping at load time like we do for the security
classes and permissions but that would require a new kernel policy
format version and associated changes to libsepol/checkpolicy and I'm
not sure it is justified. Simpler approach is just to create a fixed
mapping table in the kernel from the existing fixed policy values to
the kernel values. Less flexible but probably sufficient.

A separate selinux userspace change was applied in
https://github.com/SELinuxProject/selinux/commit/8677ce5e8f592950ae6f14cea1b68a20ddc1ac25
to enable removal of most of the unused initial SID contexts from
policies, but there is no dependency between that change and this one.
That change permits removing all of the unused initial SID contexts
from policy except for the fs and sysctl SID contexts.  The initial
SID declarations themselves would remain in policy to preserve the
values of subsequent ones but the contexts can be dropped.  If/when
the kernel decides to reuse one of them, future policies can change
the name and start assigning a context again without breaking
compatibility.

Here is how I would envision staging changes to the initial SIDs in a
compatible manner after this commit is applied:

1. At any time after this commit is applied, the kernel could choose
to reclaim one of the safely reclaimable unused initial SIDs listed
above for a new purpose (i.e. replace its NULL entry in the
initial_sid_to_string[] table with a new name and start using the
newly generated SECINITSID_name symbol in code), and refpolicy could
at that time rename its declaration of that initial SID to reflect its
new purpose and start assigning it a context going
forward. Existing/old policies would map the reclaimed initial SID to
the unlabeled context, so that would be the initial default behavior
until policies are updated. This doesn't depend on the selinux
userspace change; it will work with existing policies and userspace.

2. In 6 months or so we'll have another SELinux userspace release that
will include the libsepol/checkpolicy support for omitting unused
initial SID contexts.

3. At any time after that release, refpolicy can make that release its
minimum build requirement and drop the sid context statements (but not
the sid declarations) for all of the unused initial SIDs except for
fs and sysctl, which must remain for compatibility on policy
reload with old kernels and for compatibility with kernels that were
still using SECINITSID_SYSCTL (< 2.6.39). This doesn't depend on this
kernel commit; it will work with previous kernels as well.

4. After N years for some value of N, refpolicy decides that it no
longer cares about policy reload compatibility for kernels that
predate this kernel commit, and refpolicy drops the fs and sysctl
SID contexts from policy too (but retains the declarations).

5. After M years for some value of M, the kernel decides that it no
longer cares about compatibility with refpolicies that predate step 4
(dropping the fs and sysctl SIDs), and those two SIDs also become
safely reclaimable.  This step is optional and need not ever occur unless
we decide that the need to reclaim those two SIDs outweighs the
compatibility cost.

6. After O years for some value of O, refpolicy decides that it no
longer cares about policy load (not just reload) compatibility for
kernels that predate this kernel commit, and both kernel and refpolicy
can then start adding and using new initial SIDs beyond 27. This does
not depend on the previous change (step 5) and can occur independent
of it.

Fixes: https://github.com/SELinuxProject/selinux-kernel/issues/12
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v4 fixes the commit hashes that I cut-and-pasted from the GH issue
comments to be the proper length and added the one-line descriptions.
Oddly checkpatch.pl didn't catch that originally.

 scripts/selinux/genheaders/genheaders.c       | 11 +++-
 .../selinux/include/initial_sid_to_string.h   | 57 +++++++++----------
 security/selinux/selinuxfs.c                  |  6 +-
 security/selinux/ss/policydb.c                | 25 ++++----
 security/selinux/ss/services.c                | 26 ++++-----
 5 files changed, 66 insertions(+), 59 deletions(-)

diff --git a/scripts/selinux/genheaders/genheaders.c
b/scripts/selinux/genheaders/genheaders.c
index 544ca126a8a8..f355b3e0e968 100644
--- a/scripts/selinux/genheaders/genheaders.c
+++ b/scripts/selinux/genheaders/genheaders.c
@@ -67,8 +67,12 @@ int main(int argc, char *argv[])
        }

        isids_len = sizeof(initial_sid_to_string) / sizeof (char *);
-       for (i = 1; i < isids_len; i++)
-               initial_sid_to_string[i] = stoupperx(initial_sid_to_string[i]);
+       for (i = 1; i < isids_len; i++) {
+               const char *s = initial_sid_to_string[i];
+
+               if (s)
+                       initial_sid_to_string[i] = stoupperx(s);
+       }

        fprintf(fout, "/* This file is automatically generated.  Do
not edit. */\n");
        fprintf(fout, "#ifndef _SELINUX_FLASK_H_\n#define
_SELINUX_FLASK_H_\n\n");
@@ -82,7 +86,8 @@ int main(int argc, char *argv[])

        for (i = 1; i < isids_len; i++) {
                const char *s = initial_sid_to_string[i];
-               fprintf(fout, "#define SECINITSID_%-39s %2d\n", s, i);
+               if (s)
+                       fprintf(fout, "#define SECINITSID_%-39s %2d\n", s, i);
        }
        fprintf(fout, "\n#define SECINITSID_NUM %d\n", i-1);
        fprintf(fout, "\nstatic inline bool
security_is_socket_class(u16 kern_tclass)\n");
diff --git a/security/selinux/include/initial_sid_to_string.h
b/security/selinux/include/initial_sid_to_string.h
index 4f93f697f71c..5d332aeb8b6c 100644
--- a/security/selinux/include/initial_sid_to_string.h
+++ b/security/selinux/include/initial_sid_to_string.h
@@ -1,34 +1,33 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* This file is automatically generated.  Do not edit. */
 static const char *initial_sid_to_string[] =
 {
-    "null",
-    "kernel",
-    "security",
-    "unlabeled",
-    "fs",
-    "file",
-    "file_labels",
-    "init",
-    "any_socket",
-    "port",
-    "netif",
-    "netmsg",
-    "node",
-    "igmp_packet",
-    "icmp_socket",
-    "tcp_socket",
-    "sysctl_modprobe",
-    "sysctl",
-    "sysctl_fs",
-    "sysctl_kernel",
-    "sysctl_net",
-    "sysctl_net_unix",
-    "sysctl_vm",
-    "sysctl_dev",
-    "kmod",
-    "policy",
-    "scmp_packet",
-    "devnull",
+       NULL,
+       "kernel",
+       "security",
+       "unlabeled",
+       NULL,
+       "file",
+       NULL,
+       NULL,
+       "any_socket",
+       "port",
+       "netif",
+       "netmsg",
+       "node",
+       NULL,
+       NULL,
+       NULL,
+       NULL,
+       NULL,
+       NULL,
+       NULL,
+       NULL,
+       NULL,
+       NULL,
+       NULL,
+       NULL,
+       NULL,
+       NULL,
+       "devnull",
 };

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 533ab170ad52..4781314c2510 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1701,7 +1701,11 @@ static int sel_make_initcon_files(struct dentry *dir)
        for (i = 1; i <= SECINITSID_NUM; i++) {
                struct inode *inode;
                struct dentry *dentry;
-               dentry = d_alloc_name(dir, security_get_initial_sid_context(i));
+               const char *s = security_get_initial_sid_context(i);
+
+               if (!s)
+                       continue;
+               dentry = d_alloc_name(dir, s);
                if (!dentry)
                        return -ENOMEM;

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 32b3a8acf96f..406fb02d80ae 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -867,29 +867,28 @@ int policydb_load_isids(struct policydb *p,
struct sidtab *s)

        head = p->ocontexts[OCON_ISID];
        for (c = head; c; c = c->next) {
-               rc = -EINVAL;
-               if (!c->context[0].user) {
-                       pr_err("SELinux:  SID %s was never defined.\n",
-                               c->u.name);
-                       sidtab_destroy(s);
-                       goto out;
-               }
-               if (c->sid[0] == SECSID_NULL || c->sid[0] > SECINITSID_NUM) {
-                       pr_err("SELinux:  Initial SID %s out of range.\n",
-                               c->u.name);
+               u32 sid = c->sid[0];
+               const char *name = security_get_initial_sid_context(sid);
+
+               if (sid == SECSID_NULL) {
+                       pr_err("SELinux:  SID 0 was assigned a context.\n");
                        sidtab_destroy(s);
                        goto out;
                }
+
+               /* Ignore initial SIDs unused by this kernel. */
+               if (!name)
+                       continue;
+
                rc = context_add_hash(p, &c->context[0]);
                if (rc) {
                        sidtab_destroy(s);
                        goto out;
                }
-
-               rc = sidtab_set_initial(s, c->sid[0], &c->context[0]);
+               rc = sidtab_set_initial(s, sid, &c->context[0]);
                if (rc) {
                        pr_err("SELinux:  unable to load initial SID %s.\n",
-                               c->u.name);
+                              name);
                        sidtab_destroy(s);
                        goto out;
                }
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f90e6550eec8..8ad34fd031d1 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1322,23 +1322,22 @@ static int security_sid_to_context_core(struct
selinux_state *state,
        if (!selinux_initialized(state)) {
                if (sid <= SECINITSID_NUM) {
                        char *scontextp;
+                       const char *s = initial_sid_to_string[sid];

-                       *scontext_len = strlen(initial_sid_to_string[sid]) + 1;
+                       if (!s)
+                               return -EINVAL;
+                       *scontext_len = strlen(s) + 1;
                        if (!scontext)
-                               goto out;
-                       scontextp = kmemdup(initial_sid_to_string[sid],
-                                           *scontext_len, GFP_ATOMIC);
-                       if (!scontextp) {
-                               rc = -ENOMEM;
-                               goto out;
-                       }
+                               return 0;
+                       scontextp = kmemdup(s, *scontext_len, GFP_ATOMIC);
+                       if (!scontextp)
+                               return -ENOMEM;
                        *scontext = scontextp;
-                       goto out;
+                       return 0;
                }
                pr_err("SELinux: %s:  called before initial "
                       "load_policy on unknown SID %d\n", __func__, sid);
-               rc = -EINVAL;
-               goto out;
+               return -EINVAL;
        }
        read_lock(&state->ss->policy_rwlock);
        policydb = &state->ss->policydb;
@@ -1362,7 +1361,6 @@ static int security_sid_to_context_core(struct
selinux_state *state,

 out_unlock:
        read_unlock(&state->ss->policy_rwlock);
-out:
        return rc;

 }
@@ -1552,7 +1550,9 @@ static int security_context_to_sid_core(struct
selinux_state *state,
                int i;

                for (i = 1; i < SECINITSID_NUM; i++) {
-                       if (!strcmp(initial_sid_to_string[i], scontext2)) {
+                       const char *s = initial_sid_to_string[i];
+
+                       if (s && !strcmp(s, scontext2)) {
                                *sid = i;
                                goto out;
                        }
--
2.24.1



-- 
paul moore
www.paul-moore.com
