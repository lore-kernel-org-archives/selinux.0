Return-Path: <SRS0=VxLC=ZD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D355C17445
	for <selinux@archiver.kernel.org>; Mon, 11 Nov 2019 15:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037B5222C5
	for <selinux@archiver.kernel.org>; Mon, 11 Nov 2019 15:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qhx6V4WN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKKPkN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:40:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39173 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727002AbfKKPkN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Nov 2019 10:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573486811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fDzsr/BdRJIF4dBI9LS4zVJf7d3Njl+DRdSCscLb33s=;
        b=Qhx6V4WNWI5RHAHYXMkOza05nPC1rJ6bqPr0FJoqWfhbyVspAS03JFWqg9j8lrxKvWTAO4
        rLlmQciRJ04/T9F9cX9w1ix0RguWXtokmdSSKZAkWs8VZVJeKv1oa7rqr3NkvFZNM1Qbfd
        4vpXrjkqtrZEAv5YAkLX7YhN1fmE1DA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-F5UAp10dOaal-oNb6yX0vg-1; Mon, 11 Nov 2019 10:40:09 -0500
Received: by mail-wm1-f72.google.com with SMTP id t203so7076556wmt.7
        for <selinux@vger.kernel.org>; Mon, 11 Nov 2019 07:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j9YNUa5HoP/znaIPJ9klPUMyELTPK/E1qsJwuD/1sQw=;
        b=PLQpNcGE9XJtA5ikRQPQC43RhNKnn42UgJnTsUXPtfoMFmWmMNgzBQG8JChHAxoOkw
         lDe96aTSGTZwzeVnOuxKqogjZSBGpc/hTV5keDgJuLwFJlYGC82ix4KCeQrWNa1V12mS
         WbNVbkTUZnkXhsq0/guguoJOzgpxMe6JpI4xctqzu8htR/GKlDwyg7O0orJIWFgy0maT
         xSp9RGaWXYYzUHMTzRAbGwg3O1QHW4DZrjV8ijDyPXKKN/grQbrQDQ7yjWT23R2svRB5
         McQQicPNeEbydqGNCTb359dqsA+R5WRMFcY3Mw70lWD92vQNzEuuoQXz4EnfmHLDGsBZ
         52lw==
X-Gm-Message-State: APjAAAW4MBjK0EpNVXnLp6TsqepS4bScffz0Or4qKv6ERVMJ7ilr+edI
        W0OfN4ZV63nHJGLVQILCyOo/cQBuCpMOmGzGZ6Gx8XLf5FEZOuf9+DMWMPjrEwOLxj5R+b4gSRr
        tX/yf6ZzhbKCsBed+Fg==
X-Received: by 2002:a1c:30b:: with SMTP id 11mr19485691wmd.171.1573486808060;
        Mon, 11 Nov 2019 07:40:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqxy8tJcn0YsnXfRwAfMfKUEstyy86UZFY/Ux0FpFmEa+JfJ50ey9Z+Bxu1dKVxkh2XRYLIsYw==
X-Received: by 2002:a1c:30b:: with SMTP id 11mr19485638wmd.171.1573486807295;
        Mon, 11 Nov 2019 07:40:07 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 65sm32866901wrs.9.2019.11.11.07.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 07:40:05 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Sekletar <msekleta@redhat.com>
Subject: [PATCH v4] selinux: cache the SID -> context string translation
Date:   Mon, 11 Nov 2019 16:40:04 +0100
Message-Id: <20191111154004.1790-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: F5UAp10dOaal-oNb6yX0vg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Translating a context struct to string can be quite slow, especially if
the context has a lot of category bits set. This can cause quite
noticeable performance impact in situations where the translation needs
to be done repeatedly. A common example is a UNIX datagram socket with
the SO_PASSSEC option enabled, which is used e.g. by systemd-journald
when receiving log messages via datagram socket. This scenario can be
reproduced with:

    cat /dev/urandom | base64 | logger &
    timeout 30s perf record -p $(pidof systemd-journald) -a -g
    kill %1
    perf report -g none --pretty raw | grep security_secid_to_secctx

Before the caching introduced by this patch, computing the context
string (security_secid_to_secctx() function) takes up ~65% of
systemd-journald's CPU time (assuming a context with 1024 categories
set and Fedora x86_64 release kernel configs). After this patch
(assuming near-perfect cache hit ratio) this overhead is reduced to just
~2%.

This patch addresses the issue by caching a certain number (compile-time
configurable) of recently used context strings to speed up repeated
translations of the same context, while using only a small amount of
memory.

The cache is integrated into the existing sidtab table by adding a field
to each entry, which when not NULL contains an RCU-protected pointer to
a cache entry containing the cached string. The cache entries are kept
in a linked list sorted according to how recently they were used. On a
cache miss when the cache is full, the least recently used entry is
removed to make space for the new entry.

The patch migrates security_sid_to_context_core() to use the cache (also
a few other functions where it was possible without too much fuss, but
these mostly use the translation for logging in case of error, which is
rare).

Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1733259
Cc: Michal Sekletar <msekleta@redhat.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Changes in v4:
 - use rcu_dereference_protected() instead of rcu_dereference_raw() in
   sidtab_sid2str_put()
 - fix typo in comment
 - remove unnecessary rcu_head_init() call

Changes in v3:
 - add rcu@vger.kernel.org and Paul McKenney to Cc for review of the RCU
   logic
 - add __rcu annotation to the cache entry pointer (sidtab.c now passes
   sparse checks with C=3D1)

Changes in v2:
 - skip sidtab_sid2str_put() when in non-task context to prevent
   deadlock while avoiding the need to lock the spinlock with
   irqsave/-restore (which is slower)

 security/selinux/Kconfig       |  11 ++
 security/selinux/ss/services.c | 138 +++++++++++++++----------
 security/selinux/ss/sidtab.c   | 179 +++++++++++++++++++++++++++------
 security/selinux/ss/sidtab.h   |  58 +++++++++--
 4 files changed, 294 insertions(+), 92 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 5711689deb6a..35fe8878cf1c 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -85,3 +85,14 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
 =09  via /selinux/checkreqprot if authorized by policy.
=20
 =09  If you are unsure how to answer this question, answer 0.
+
+config SECURITY_SELINUX_SID2STR_CACHE_SIZE
+=09int "NSA SELinux SID to context string translation cache size"
+=09depends on SECURITY_SELINUX
+=09default 256
+=09help
+=09  This option defines the size of the internal SID -> context string
+=09  cache, which improves the performance of context to string
+=09  conversion.  Setting this option to 0 disables the cache completely.
+
+=09  If unsure, keep the default value.
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.=
c
index 3a29e7c24ba9..b6dda5261166 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -91,6 +91,12 @@ static int context_struct_to_string(struct policydb *pol=
icydb,
 =09=09=09=09    char **scontext,
 =09=09=09=09    u32 *scontext_len);
=20
+static int sidtab_entry_to_string(struct policydb *policydb,
+=09=09=09=09  struct sidtab *sidtab,
+=09=09=09=09  struct sidtab_entry *entry,
+=09=09=09=09  char **scontext,
+=09=09=09=09  u32 *scontext_len);
+
 static void context_struct_compute_av(struct policydb *policydb,
 =09=09=09=09      struct context *scontext,
 =09=09=09=09      struct context *tcontext,
@@ -716,20 +722,21 @@ static void context_struct_compute_av(struct policydb=
 *policydb,
 }
=20
 static int security_validtrans_handle_fail(struct selinux_state *state,
-=09=09=09=09=09   struct context *ocontext,
-=09=09=09=09=09   struct context *ncontext,
-=09=09=09=09=09   struct context *tcontext,
+=09=09=09=09=09   struct sidtab_entry *oentry,
+=09=09=09=09=09   struct sidtab_entry *nentry,
+=09=09=09=09=09   struct sidtab_entry *tentry,
 =09=09=09=09=09   u16 tclass)
 {
 =09struct policydb *p =3D &state->ss->policydb;
+=09struct sidtab *sidtab =3D state->ss->sidtab;
 =09char *o =3D NULL, *n =3D NULL, *t =3D NULL;
 =09u32 olen, nlen, tlen;
=20
-=09if (context_struct_to_string(p, ocontext, &o, &olen))
+=09if (sidtab_entry_to_string(p, sidtab, oentry, &o, &olen))
 =09=09goto out;
-=09if (context_struct_to_string(p, ncontext, &n, &nlen))
+=09if (sidtab_entry_to_string(p, sidtab, nentry, &n, &nlen))
 =09=09goto out;
-=09if (context_struct_to_string(p, tcontext, &t, &tlen))
+=09if (sidtab_entry_to_string(p, sidtab, tentry, &t, &tlen))
 =09=09goto out;
 =09audit_log(audit_context(), GFP_ATOMIC, AUDIT_SELINUX_ERR,
 =09=09  "op=3Dsecurity_validate_transition seresult=3Ddenied"
@@ -751,9 +758,9 @@ static int security_compute_validatetrans(struct selinu=
x_state *state,
 {
 =09struct policydb *policydb;
 =09struct sidtab *sidtab;
-=09struct context *ocontext;
-=09struct context *ncontext;
-=09struct context *tcontext;
+=09struct sidtab_entry *oentry;
+=09struct sidtab_entry *nentry;
+=09struct sidtab_entry *tentry;
 =09struct class_datum *tclass_datum;
 =09struct constraint_node *constraint;
 =09u16 tclass;
@@ -779,24 +786,24 @@ static int security_compute_validatetrans(struct seli=
nux_state *state,
 =09}
 =09tclass_datum =3D policydb->class_val_to_struct[tclass - 1];
=20
-=09ocontext =3D sidtab_search(sidtab, oldsid);
-=09if (!ocontext) {
+=09oentry =3D sidtab_search_entry(sidtab, oldsid);
+=09if (!oentry) {
 =09=09pr_err("SELinux: %s:  unrecognized SID %d\n",
 =09=09=09__func__, oldsid);
 =09=09rc =3D -EINVAL;
 =09=09goto out;
 =09}
=20
-=09ncontext =3D sidtab_search(sidtab, newsid);
-=09if (!ncontext) {
+=09nentry =3D sidtab_search_entry(sidtab, newsid);
+=09if (!nentry) {
 =09=09pr_err("SELinux: %s:  unrecognized SID %d\n",
 =09=09=09__func__, newsid);
 =09=09rc =3D -EINVAL;
 =09=09goto out;
 =09}
=20
-=09tcontext =3D sidtab_search(sidtab, tasksid);
-=09if (!tcontext) {
+=09tentry =3D sidtab_search_entry(sidtab, tasksid);
+=09if (!tentry) {
 =09=09pr_err("SELinux: %s:  unrecognized SID %d\n",
 =09=09=09__func__, tasksid);
 =09=09rc =3D -EINVAL;
@@ -805,15 +812,16 @@ static int security_compute_validatetrans(struct seli=
nux_state *state,
=20
 =09constraint =3D tclass_datum->validatetrans;
 =09while (constraint) {
-=09=09if (!constraint_expr_eval(policydb, ocontext, ncontext,
-=09=09=09=09=09  tcontext, constraint->expr)) {
+=09=09if (!constraint_expr_eval(policydb, &oentry->context,
+=09=09=09=09=09  &nentry->context, &tentry->context,
+=09=09=09=09=09  constraint->expr)) {
 =09=09=09if (user)
 =09=09=09=09rc =3D -EPERM;
 =09=09=09else
 =09=09=09=09rc =3D security_validtrans_handle_fail(state,
-=09=09=09=09=09=09=09=09     ocontext,
-=09=09=09=09=09=09=09=09     ncontext,
-=09=09=09=09=09=09=09=09     tcontext,
+=09=09=09=09=09=09=09=09     oentry,
+=09=09=09=09=09=09=09=09     nentry,
+=09=09=09=09=09=09=09=09     tentry,
 =09=09=09=09=09=09=09=09     tclass);
 =09=09=09goto out;
 =09=09}
@@ -855,7 +863,7 @@ int security_bounded_transition(struct selinux_state *s=
tate,
 {
 =09struct policydb *policydb;
 =09struct sidtab *sidtab;
-=09struct context *old_context, *new_context;
+=09struct sidtab_entry *old_entry, *new_entry;
 =09struct type_datum *type;
 =09int index;
 =09int rc;
@@ -869,16 +877,16 @@ int security_bounded_transition(struct selinux_state =
*state,
 =09sidtab =3D state->ss->sidtab;
=20
 =09rc =3D -EINVAL;
-=09old_context =3D sidtab_search(sidtab, old_sid);
-=09if (!old_context) {
+=09old_entry =3D sidtab_search_entry(sidtab, old_sid);
+=09if (!old_entry) {
 =09=09pr_err("SELinux: %s: unrecognized SID %u\n",
 =09=09       __func__, old_sid);
 =09=09goto out;
 =09}
=20
 =09rc =3D -EINVAL;
-=09new_context =3D sidtab_search(sidtab, new_sid);
-=09if (!new_context) {
+=09new_entry =3D sidtab_search_entry(sidtab, new_sid);
+=09if (!new_entry) {
 =09=09pr_err("SELinux: %s: unrecognized SID %u\n",
 =09=09       __func__, new_sid);
 =09=09goto out;
@@ -886,10 +894,10 @@ int security_bounded_transition(struct selinux_state =
*state,
=20
 =09rc =3D 0;
 =09/* type/domain unchanged */
-=09if (old_context->type =3D=3D new_context->type)
+=09if (old_entry->context.type =3D=3D new_entry->context.type)
 =09=09goto out;
=20
-=09index =3D new_context->type;
+=09index =3D new_entry->context.type;
 =09while (true) {
 =09=09type =3D policydb->type_val_to_struct[index - 1];
 =09=09BUG_ON(!type);
@@ -901,7 +909,7 @@ int security_bounded_transition(struct selinux_state *s=
tate,
=20
 =09=09/* @newsid is bounded by @oldsid */
 =09=09rc =3D 0;
-=09=09if (type->bounds =3D=3D old_context->type)
+=09=09if (type->bounds =3D=3D old_entry->context.type)
 =09=09=09break;
=20
 =09=09index =3D type->bounds;
@@ -912,10 +920,10 @@ int security_bounded_transition(struct selinux_state =
*state,
 =09=09char *new_name =3D NULL;
 =09=09u32 length;
=20
-=09=09if (!context_struct_to_string(policydb, old_context,
-=09=09=09=09=09      &old_name, &length) &&
-=09=09    !context_struct_to_string(policydb, new_context,
-=09=09=09=09=09      &new_name, &length)) {
+=09=09if (!sidtab_entry_to_string(policydb, sidtab, old_entry,
+=09=09=09=09=09    &old_name, &length) &&
+=09=09    !sidtab_entry_to_string(policydb, sidtab, new_entry,
+=09=09=09=09=09    &new_name, &length)) {
 =09=09=09audit_log(audit_context(),
 =09=09=09=09  GFP_ATOMIC, AUDIT_SELINUX_ERR,
 =09=09=09=09  "op=3Dsecurity_bounded_transition "
@@ -1255,6 +1263,23 @@ static int context_struct_to_string(struct policydb =
*p,
 =09return 0;
 }
=20
+static int sidtab_entry_to_string(struct policydb *p,
+=09=09=09=09  struct sidtab *sidtab,
+=09=09=09=09  struct sidtab_entry *entry,
+=09=09=09=09  char **scontext, u32 *scontext_len)
+{
+=09int rc =3D sidtab_sid2str_get(sidtab, entry, scontext, scontext_len);
+
+=09if (rc !=3D -ENOENT)
+=09=09return rc;
+
+=09rc =3D context_struct_to_string(p, &entry->context, scontext,
+=09=09=09=09      scontext_len);
+=09if (!rc && scontext)
+=09=09sidtab_sid2str_put(sidtab, entry, *scontext, *scontext_len);
+=09return rc;
+}
+
 #include "initial_sid_to_string.h"
=20
 const char *security_get_initial_sid_context(u32 sid)
@@ -1271,7 +1296,7 @@ static int security_sid_to_context_core(struct selinu=
x_state *state,
 {
 =09struct policydb *policydb;
 =09struct sidtab *sidtab;
-=09struct context *context;
+=09struct sidtab_entry *entry;
 =09int rc =3D 0;
=20
 =09if (scontext)
@@ -1302,21 +1327,23 @@ static int security_sid_to_context_core(struct seli=
nux_state *state,
 =09read_lock(&state->ss->policy_rwlock);
 =09policydb =3D &state->ss->policydb;
 =09sidtab =3D state->ss->sidtab;
+
 =09if (force)
-=09=09context =3D sidtab_search_force(sidtab, sid);
+=09=09entry =3D sidtab_search_entry_force(sidtab, sid);
 =09else
-=09=09context =3D sidtab_search(sidtab, sid);
-=09if (!context) {
+=09=09entry =3D sidtab_search_entry(sidtab, sid);
+=09if (!entry) {
 =09=09pr_err("SELinux: %s:  unrecognized SID %d\n",
 =09=09=09__func__, sid);
 =09=09rc =3D -EINVAL;
 =09=09goto out_unlock;
 =09}
-=09if (only_invalid && !context->len)
-=09=09rc =3D 0;
-=09else
-=09=09rc =3D context_struct_to_string(policydb, context, scontext,
-=09=09=09=09=09      scontext_len);
+=09if (only_invalid && !entry->context.len)
+=09=09goto out_unlock;
+
+=09rc =3D sidtab_entry_to_string(policydb, sidtab, entry, scontext,
+=09=09=09=09    scontext_len);
+
 out_unlock:
 =09read_unlock(&state->ss->policy_rwlock);
 out:
@@ -1574,19 +1601,20 @@ int security_context_to_sid_force(struct selinux_st=
ate *state,
=20
 static int compute_sid_handle_invalid_context(
 =09struct selinux_state *state,
-=09struct context *scontext,
-=09struct context *tcontext,
+=09struct sidtab_entry *sentry,
+=09struct sidtab_entry *tentry,
 =09u16 tclass,
 =09struct context *newcontext)
 {
 =09struct policydb *policydb =3D &state->ss->policydb;
+=09struct sidtab *sidtab =3D state->ss->sidtab;
 =09char *s =3D NULL, *t =3D NULL, *n =3D NULL;
 =09u32 slen, tlen, nlen;
 =09struct audit_buffer *ab;
=20
-=09if (context_struct_to_string(policydb, scontext, &s, &slen))
+=09if (sidtab_entry_to_string(policydb, sidtab, sentry, &s, &slen))
 =09=09goto out;
-=09if (context_struct_to_string(policydb, tcontext, &t, &tlen))
+=09if (sidtab_entry_to_string(policydb, sidtab, tentry, &t, &tlen))
 =09=09goto out;
 =09if (context_struct_to_string(policydb, newcontext, &n, &nlen))
 =09=09goto out;
@@ -1645,7 +1673,8 @@ static int security_compute_sid(struct selinux_state =
*state,
 =09struct policydb *policydb;
 =09struct sidtab *sidtab;
 =09struct class_datum *cladatum =3D NULL;
-=09struct context *scontext =3D NULL, *tcontext =3D NULL, newcontext;
+=09struct context *scontext, *tcontext, newcontext;
+=09struct sidtab_entry *sentry, *tentry;
 =09struct role_trans *roletr =3D NULL;
 =09struct avtab_key avkey;
 =09struct avtab_datum *avdatum;
@@ -1682,21 +1711,24 @@ static int security_compute_sid(struct selinux_stat=
e *state,
 =09policydb =3D &state->ss->policydb;
 =09sidtab =3D state->ss->sidtab;
=20
-=09scontext =3D sidtab_search(sidtab, ssid);
-=09if (!scontext) {
+=09sentry =3D sidtab_search_entry(sidtab, ssid);
+=09if (!sentry) {
 =09=09pr_err("SELinux: %s:  unrecognized SID %d\n",
 =09=09       __func__, ssid);
 =09=09rc =3D -EINVAL;
 =09=09goto out_unlock;
 =09}
-=09tcontext =3D sidtab_search(sidtab, tsid);
-=09if (!tcontext) {
+=09tentry =3D sidtab_search_entry(sidtab, tsid);
+=09if (!tentry) {
 =09=09pr_err("SELinux: %s:  unrecognized SID %d\n",
 =09=09       __func__, tsid);
 =09=09rc =3D -EINVAL;
 =09=09goto out_unlock;
 =09}
=20
+=09scontext =3D &sentry->context;
+=09tcontext =3D &tentry->context;
+
 =09if (tclass && tclass <=3D policydb->p_classes.nprim)
 =09=09cladatum =3D policydb->class_val_to_struct[tclass - 1];
=20
@@ -1797,10 +1829,8 @@ static int security_compute_sid(struct selinux_state=
 *state,
=20
 =09/* Check the validity of the context. */
 =09if (!policydb_context_isvalid(policydb, &newcontext)) {
-=09=09rc =3D compute_sid_handle_invalid_context(state, scontext,
-=09=09=09=09=09=09=09tcontext,
-=09=09=09=09=09=09=09tclass,
-=09=09=09=09=09=09=09&newcontext);
+=09=09rc =3D compute_sid_handle_invalid_context(state, sentry, tentry,
+=09=09=09=09=09=09=09tclass, &newcontext);
 =09=09if (rc)
 =09=09=09goto out_unlock;
 =09}
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 7d49994e8d5f..6d6ce1c43b49 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -9,6 +9,8 @@
  */
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/rcupdate.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
@@ -17,6 +19,14 @@
 #include "security.h"
 #include "sidtab.h"
=20
+struct sidtab_str_cache {
+=09struct rcu_head rcu_member;
+=09struct list_head lru_member;
+=09struct sidtab_entry *parent;
+=09u32 len;
+=09char str[];
+};
+
 int sidtab_init(struct sidtab *s)
 {
 =09u32 i;
@@ -34,24 +44,33 @@ int sidtab_init(struct sidtab *s)
 =09s->convert =3D NULL;
=20
 =09spin_lock_init(&s->lock);
+
+#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
+=09s->cache_free_slots =3D CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE;
+=09INIT_LIST_HEAD(&s->cache_lru_list);
+=09spin_lock_init(&s->cache_lock);
+#endif
 =09return 0;
 }
=20
 int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
 {
-=09struct sidtab_isid_entry *entry;
+=09struct sidtab_isid_entry *isid;
 =09int rc;
=20
 =09if (sid =3D=3D 0 || sid > SECINITSID_NUM)
 =09=09return -EINVAL;
=20
-=09entry =3D &s->isids[sid - 1];
+=09isid =3D &s->isids[sid - 1];
=20
-=09rc =3D context_cpy(&entry->context, context);
+=09rc =3D context_cpy(&isid->entry.context, context);
 =09if (rc)
 =09=09return rc;
=20
-=09entry->set =3D 1;
+#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
+=09isid->entry.cache =3D NULL;
+#endif
+=09isid->set =3D 1;
 =09return 0;
 }
=20
@@ -88,7 +107,8 @@ static int sidtab_alloc_roots(struct sidtab *s, u32 leve=
l)
 =09return 0;
 }
=20
-static struct context *sidtab_do_lookup(struct sidtab *s, u32 index, int a=
lloc)
+static struct sidtab_entry *sidtab_do_lookup(struct sidtab *s, u32 index,
+=09=09=09=09=09     int alloc)
 {
 =09union sidtab_entry_inner *entry;
 =09u32 level, capacity_shift, leaf_index =3D index / SIDTAB_LEAF_ENTRIES;
@@ -125,10 +145,16 @@ static struct context *sidtab_do_lookup(struct sidtab=
 *s, u32 index, int alloc)
 =09=09if (!entry->ptr_leaf)
 =09=09=09return NULL;
 =09}
-=09return &entry->ptr_leaf->entries[index % SIDTAB_LEAF_ENTRIES].context;
+=09return &entry->ptr_leaf->entries[index % SIDTAB_LEAF_ENTRIES];
+}
+
+/* use when you know that there is enough entries */
+static struct context *sidtab_lookup_unsafe(struct sidtab *s, u32 index)
+{
+=09return &sidtab_do_lookup(s, index, 0)->context;
 }
=20
-static struct context *sidtab_lookup(struct sidtab *s, u32 index)
+static struct sidtab_entry *sidtab_lookup(struct sidtab *s, u32 index)
 {
 =09/* read entries only after reading count */
 =09u32 count =3D smp_load_acquire(&s->count);
@@ -139,33 +165,34 @@ static struct context *sidtab_lookup(struct sidtab *s=
, u32 index)
 =09return sidtab_do_lookup(s, index, 0);
 }
=20
-static struct context *sidtab_lookup_initial(struct sidtab *s, u32 sid)
+static struct sidtab_entry *sidtab_lookup_initial(struct sidtab *s, u32 si=
d)
 {
-=09return s->isids[sid - 1].set ? &s->isids[sid - 1].context : NULL;
+=09return s->isids[sid - 1].set ? &s->isids[sid - 1].entry : NULL;
 }
=20
-static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int f=
orce)
+static struct sidtab_entry *sidtab_search_core(struct sidtab *s, u32 sid,
+=09=09=09=09=09       int force)
 {
-=09struct context *context;
-
 =09if (sid !=3D 0) {
+=09=09struct sidtab_entry *entry;
+
 =09=09if (sid > SECINITSID_NUM)
-=09=09=09context =3D sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
+=09=09=09entry =3D sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
 =09=09else
-=09=09=09context =3D sidtab_lookup_initial(s, sid);
-=09=09if (context && (!context->len || force))
-=09=09=09return context;
+=09=09=09entry =3D sidtab_lookup_initial(s, sid);
+=09=09if (entry && (!entry->context.len || force))
+=09=09=09return entry;
 =09}
=20
 =09return sidtab_lookup_initial(s, SECINITSID_UNLABELED);
 }
=20
-struct context *sidtab_search(struct sidtab *s, u32 sid)
+struct sidtab_entry *sidtab_search_entry(struct sidtab *s, u32 sid)
 {
 =09return sidtab_search_core(s, sid, 0);
 }
=20
-struct context *sidtab_search_force(struct sidtab *s, u32 sid)
+struct sidtab_entry *sidtab_search_entry_force(struct sidtab *s, u32 sid)
 {
 =09return sidtab_search_core(s, sid, 1);
 }
@@ -230,7 +257,7 @@ static int sidtab_rcache_search(struct sidtab *s, struc=
t context *context,
 =09=09if (v >=3D SIDTAB_MAX)
 =09=09=09continue;
=20
-=09=09if (context_cmp(sidtab_do_lookup(s, v, 0), context)) {
+=09=09if (context_cmp(sidtab_lookup_unsafe(s, v), context)) {
 =09=09=09sidtab_rcache_update(s, v, i);
 =09=09=09*index =3D v;
 =09=09=09return 0;
@@ -245,7 +272,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, stru=
ct context *context,
 =09unsigned long flags;
 =09u32 count, count_locked, level, pos;
 =09struct sidtab_convert_params *convert;
-=09struct context *dst, *dst_convert;
+=09struct sidtab_entry *dst, *dst_convert;
 =09int rc;
=20
 =09rc =3D sidtab_rcache_search(s, context, index);
@@ -273,7 +300,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, stru=
ct context *context,
=20
 =09/* if count has changed before we acquired the lock, then catch up */
 =09while (count < count_locked) {
-=09=09if (context_cmp(sidtab_do_lookup(s, count, 0), context)) {
+=09=09if (context_cmp(sidtab_lookup_unsafe(s, count), context)) {
 =09=09=09sidtab_rcache_push(s, count);
 =09=09=09*index =3D count;
 =09=09=09rc =3D 0;
@@ -293,7 +320,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, stru=
ct context *context,
 =09if (!dst)
 =09=09goto out_unlock;
=20
-=09rc =3D context_cpy(dst, context);
+=09rc =3D context_cpy(&dst->context, context);
 =09if (rc)
 =09=09goto out_unlock;
=20
@@ -305,13 +332,14 @@ static int sidtab_reverse_lookup(struct sidtab *s, st=
ruct context *context,
 =09=09rc =3D -ENOMEM;
 =09=09dst_convert =3D sidtab_do_lookup(convert->target, count, 1);
 =09=09if (!dst_convert) {
-=09=09=09context_destroy(dst);
+=09=09=09context_destroy(&dst->context);
 =09=09=09goto out_unlock;
 =09=09}
=20
-=09=09rc =3D convert->func(context, dst_convert, convert->args);
+=09=09rc =3D convert->func(context, &dst_convert->context,
+=09=09=09=09   convert->args);
 =09=09if (rc) {
-=09=09=09context_destroy(dst);
+=09=09=09context_destroy(&dst->context);
 =09=09=09goto out_unlock;
 =09=09}
=20
@@ -341,9 +369,9 @@ int sidtab_context_to_sid(struct sidtab *s, struct cont=
ext *context, u32 *sid)
 =09u32 i;
=20
 =09for (i =3D 0; i < SECINITSID_NUM; i++) {
-=09=09struct sidtab_isid_entry *entry =3D &s->isids[i];
+=09=09struct sidtab_isid_entry *isid =3D &s->isids[i];
=20
-=09=09if (entry->set && context_cmp(context, &entry->context)) {
+=09=09if (isid->set && context_cmp(context, &isid->entry.context)) {
 =09=09=09*sid =3D i + 1;
 =09=09=09return 0;
 =09=09}
@@ -453,6 +481,14 @@ int sidtab_convert(struct sidtab *s, struct sidtab_con=
vert_params *params)
 =09return rc;
 }
=20
+static void sidtab_destroy_entry(struct sidtab_entry *entry)
+{
+=09context_destroy(&entry->context);
+#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
+=09kfree(rcu_dereference_raw(entry->cache));
+#endif
+}
+
 static void sidtab_destroy_tree(union sidtab_entry_inner entry, u32 level)
 {
 =09u32 i;
@@ -473,7 +509,7 @@ static void sidtab_destroy_tree(union sidtab_entry_inne=
r entry, u32 level)
 =09=09=09return;
=20
 =09=09for (i =3D 0; i < SIDTAB_LEAF_ENTRIES; i++)
-=09=09=09context_destroy(&node->entries[i].context);
+=09=09=09sidtab_destroy_entry(&node->entries[i]);
 =09=09kfree(node);
 =09}
 }
@@ -484,7 +520,7 @@ void sidtab_destroy(struct sidtab *s)
=20
 =09for (i =3D 0; i < SECINITSID_NUM; i++)
 =09=09if (s->isids[i].set)
-=09=09=09context_destroy(&s->isids[i].context);
+=09=09=09sidtab_destroy_entry(&s->isids[i].entry);
=20
 =09level =3D SIDTAB_MAX_LEVEL;
 =09while (level && !s->roots[level].ptr_inner)
@@ -492,3 +528,88 @@ void sidtab_destroy(struct sidtab *s)
=20
 =09sidtab_destroy_tree(s->roots[level], level);
 }
+
+#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
+
+void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
+=09=09=09const char *str, u32 str_len)
+{
+=09struct sidtab_str_cache *cache, *victim;
+
+=09/* do not cache invalid contexts */
+=09if (entry->context.len)
+=09=09return;
+
+=09/*
+=09 * Skip the put operation when in non-task context to avoid the need
+=09 * to disable interrupts while holding s->cache_lock.
+=09 */
+=09if (!in_task())
+=09=09return;
+
+=09spin_lock(&s->cache_lock);
+
+=09cache =3D rcu_dereference_protected(entry->cache,
+=09=09=09=09=09  lockdep_is_held(&s->cache_lock));
+=09if (cache) {
+=09=09/* entry in cache - just bump to the head of LRU list */
+=09=09list_move(&cache->lru_member, &s->cache_lru_list);
+=09=09goto out_unlock;
+=09}
+
+=09cache =3D kmalloc(sizeof(struct sidtab_str_cache) + str_len, GFP_ATOMIC=
);
+=09if (!cache)
+=09=09goto out_unlock;
+
+=09if (s->cache_free_slots =3D=3D 0) {
+=09=09/* pop a cache entry from the tail and free it */
+=09=09victim =3D container_of(s->cache_lru_list.prev,
+=09=09=09=09      struct sidtab_str_cache, lru_member);
+=09=09list_del(&victim->lru_member);
+=09=09kfree_rcu(victim, rcu_member);
+=09=09rcu_assign_pointer(victim->parent->cache, NULL);
+=09} else {
+=09=09s->cache_free_slots--;
+=09}
+=09cache->parent =3D entry;
+=09cache->len =3D str_len;
+=09memcpy(cache->str, str, str_len);
+=09list_add(&cache->lru_member, &s->cache_lru_list);
+
+=09rcu_assign_pointer(entry->cache, cache);
+
+out_unlock:
+=09spin_unlock(&s->cache_lock);
+}
+
+int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry,
+=09=09       char **out, u32 *out_len)
+{
+=09struct sidtab_str_cache *cache;
+=09int rc =3D 0;
+
+=09if (entry->context.len)
+=09=09return -ENOENT; /* do not cache invalid contexts */
+
+=09rcu_read_lock();
+
+=09cache =3D rcu_dereference(entry->cache);
+=09if (!cache) {
+=09=09rc =3D -ENOENT;
+=09} else {
+=09=09*out_len =3D cache->len;
+=09=09if (out) {
+=09=09=09*out =3D kmemdup(cache->str, cache->len, GFP_ATOMIC);
+=09=09=09if (!*out)
+=09=09=09=09rc =3D -ENOMEM;
+=09=09}
+=09}
+
+=09rcu_read_unlock();
+
+=09if (!rc && out)
+=09=09sidtab_sid2str_put(s, entry, *out, *out_len);
+=09return rc;
+}
+
+#endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index 1f4763141aa1..5fe67a0c307b 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -16,13 +16,13 @@
=20
 #include "context.h"
=20
-struct sidtab_entry_leaf {
+struct sidtab_entry {
 =09struct context context;
+#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
+=09struct sidtab_str_cache __rcu *cache;
+#endif
 };
=20
-struct sidtab_node_inner;
-struct sidtab_node_leaf;
-
 union sidtab_entry_inner {
 =09struct sidtab_node_inner *ptr_inner;
 =09struct sidtab_node_leaf  *ptr_leaf;
@@ -38,7 +38,7 @@ union sidtab_entry_inner {
 =09(SIDTAB_NODE_ALLOC_SHIFT - size_to_shift(sizeof(union sidtab_entry_inne=
r)))
 #define SIDTAB_INNER_ENTRIES ((size_t)1 << SIDTAB_INNER_SHIFT)
 #define SIDTAB_LEAF_ENTRIES \
-=09(SIDTAB_NODE_ALLOC_SIZE / sizeof(struct sidtab_entry_leaf))
+=09(SIDTAB_NODE_ALLOC_SIZE / sizeof(struct sidtab_entry))
=20
 #define SIDTAB_MAX_BITS 32
 #define SIDTAB_MAX U32_MAX
@@ -48,7 +48,7 @@ union sidtab_entry_inner {
 =09=09     SIDTAB_INNER_SHIFT)
=20
 struct sidtab_node_leaf {
-=09struct sidtab_entry_leaf entries[SIDTAB_LEAF_ENTRIES];
+=09struct sidtab_entry entries[SIDTAB_LEAF_ENTRIES];
 };
=20
 struct sidtab_node_inner {
@@ -57,7 +57,7 @@ struct sidtab_node_inner {
=20
 struct sidtab_isid_entry {
 =09int set;
-=09struct context context;
+=09struct sidtab_entry entry;
 };
=20
 struct sidtab_convert_params {
@@ -83,6 +83,13 @@ struct sidtab {
 =09struct sidtab_convert_params *convert;
 =09spinlock_t lock;
=20
+#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
+=09/* SID -> context string cache */
+=09u32 cache_free_slots;
+=09struct list_head cache_lru_list;
+=09spinlock_t cache_lock;
+#endif
+
 =09/* reverse lookup cache - access atomically via {READ|WRITE}_ONCE() */
 =09u32 rcache[SIDTAB_RCACHE_SIZE];
=20
@@ -92,8 +99,22 @@ struct sidtab {
=20
 int sidtab_init(struct sidtab *s);
 int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)=
;
-struct context *sidtab_search(struct sidtab *s, u32 sid);
-struct context *sidtab_search_force(struct sidtab *s, u32 sid);
+struct sidtab_entry *sidtab_search_entry(struct sidtab *s, u32 sid);
+struct sidtab_entry *sidtab_search_entry_force(struct sidtab *s, u32 sid);
+
+static inline struct context *sidtab_search(struct sidtab *s, u32 sid)
+{
+=09struct sidtab_entry *entry =3D sidtab_search_entry(s, sid);
+
+=09return entry ? &entry->context : NULL;
+}
+
+static inline struct context *sidtab_search_force(struct sidtab *s, u32 si=
d)
+{
+=09struct sidtab_entry *entry =3D sidtab_search_entry_force(s, sid);
+
+=09return entry ? &entry->context : NULL;
+}
=20
 int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)=
;
=20
@@ -101,6 +122,25 @@ int sidtab_context_to_sid(struct sidtab *s, struct con=
text *context, u32 *sid);
=20
 void sidtab_destroy(struct sidtab *s);
=20
+#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
+void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
+=09=09=09const char *str, u32 str_len);
+int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry,
+=09=09       char **out, u32 *out_len);
+#else
+static inline void sidtab_sid2str_put(struct sidtab *s,
+=09=09=09=09      struct sidtab_entry *entry,
+=09=09=09=09      const char *str, u32 str_len)
+{
+}
+static inline int sidtab_sid2str_get(struct sidtab *s,
+=09=09=09=09     struct sidtab_entry *entry,
+=09=09=09=09     char **out, u32 *out_len)
+{
+=09return -ENOENT;
+}
+#endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
+
 #endif=09/* _SS_SIDTAB_H_ */
=20
=20
--=20
2.21.0

