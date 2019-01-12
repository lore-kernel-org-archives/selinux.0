Return-Path: <SRS0=5ZFR=PU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29452C43387
	for <selinux@archiver.kernel.org>; Sat, 12 Jan 2019 18:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE7820836
	for <selinux@archiver.kernel.org>; Sat, 12 Jan 2019 18:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfALS5X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:57:23 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:58154 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfALS5X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 12 Jan 2019 13:57:23 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 35E475646F4
        for <selinux@vger.kernel.org>; Sat, 12 Jan 2019 19:57:20 +0100 (CET)
Received: by mail-ot1-f48.google.com with SMTP id n8so16061036otl.6
        for <selinux@vger.kernel.org>; Sat, 12 Jan 2019 10:57:20 -0800 (PST)
X-Gm-Message-State: AJcUukditi1kwh4Q6wEObo9g7Ve9uRr4H6qH1PXwAndM8jkeT1bwZR1b
        Ti9BUpwtkEu9TE2tWc8z3pN05H9SZxKdoa9Lojs=
X-Google-Smtp-Source: ALg8bN4z/8ju0ANCEH7hUi8CmRYfDlN/Xty4QJP6xgLyhWDgG0A1RH226peAq5rPRTgluNdJC5kYKvZEU1wJiFNihMw=
X-Received: by 2002:a9d:6c44:: with SMTP id g4mr11962321otq.368.1547319439291;
 Sat, 12 Jan 2019 10:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20190108134822.13184-1-sds@tycho.nsa.gov> <pjdo98pfpzp.fsf@redhat.com>
In-Reply-To: <pjdo98pfpzp.fsf@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 12 Jan 2019 19:57:08 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kqY=_RfHYE1GUWeeDStV4h6BOp-rEL91gVVVGy3E4DSg@mail.gmail.com>
Message-ID: <CAJfZ7=kqY=_RfHYE1GUWeeDStV4h6BOp-rEL91gVVVGy3E4DSg@mail.gmail.com>
Subject: Re: [PATCH v2] libsemanage: set selinux policy root around calls to selinux_boolean_sub
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan 12 19:57:20 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 9, 2019 at 11:03 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> Stephen Smalley <sds@tycho.nsa.gov> writes:
>
> > As reported in #109, semodule -p /path/to/policyroot -s minimum -n -B
> > tries to use /etc/selinux/targeted/booleans.subs_dist.  This is because
> > it invokes the libselinux selinux_boolean_sub() interface, which uses
> > the active/installed policy files rather than the libsemanage ones.
> >
> > Switch the selinux policy root around the selinux_boolean_sub() call
> > to incorporate the semanage root as a prefix and to use the specified
> > policy store as a suffix so that the correct booleans.subs_dist file
> > (if any) is used.
> >
> > The underlying bug is that booleans.subs_dist is not itself managed
> > via libsemanage. If it was managed and therefore lived within the
> > policy store, then libsemanage could access the appropriate
> > booleans.subs_dist file without using the libselinux interface at all,
> > and thus would not need to modify the selinux policy root.  Moving
> > booleans.subs_dist to a managed file is deferred to a future change.
> >
> > Test:
> > dnf install selinux-policy-minimum selinux-policy-targeted
> > cd / && tar cf - etc/selinux var/lib/selinux | (cd ~/policy-root; tar xvpf -)
> > strace semodule -p ~/policy-root -s minimum -n -B
> >
> > Before:
> > openat(AT_FDCWD, "/etc/selinux/targeted/booleans.subs_dist", O_RDONLY|O_CLOEXEC) = 5
> >
> > After:
> > openat(AT_FDCWD, "/home/sds/policy-root/etc/selinux/minimum/booleans.subs_dist", O_RDONLY|O_CLOEXEC) = 5
> >
> > Fixes https://github.com/SELinuxProject/selinux/issues/109
> >
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Merged. Thanks!
Nicolas

> > ---
> > v2 skips setting of the policy root if they already match, introduces a
> > hidden prototype and definition for internal callers of semanage_root(),
> > and tests that selinux_policy_root() is non-NULL before strdup'ing it.
> >  libsemanage/src/boolean_record.c  | 54 +++++++++++++++++++++++++++++--
> >  libsemanage/src/handle.c          |  2 ++
> >  libsemanage/src/handle_internal.h |  9 +++---
> >  3 files changed, 59 insertions(+), 6 deletions(-)
> >
> > diff --git a/libsemanage/src/boolean_record.c b/libsemanage/src/boolean_record.c
> > index 665c0223..c234094e 100644
> > --- a/libsemanage/src/boolean_record.c
> > +++ b/libsemanage/src/boolean_record.c
> > @@ -6,7 +6,9 @@
> >   * Implements: record_key_t (Database Record Key)
> >   */
> >
> > +#include <string.h>
> >  #include <sepol/boolean_record.h>
> > +#include "handle_internal.h"
> >
> >  typedef sepol_bool_t semanage_bool_t;
> >  typedef sepol_bool_key_t semanage_bool_key_t;
> > @@ -84,10 +86,58 @@ hidden_def(semanage_bool_get_name)
> >  int semanage_bool_set_name(semanage_handle_t * handle,
> >                          semanage_bool_t * boolean, const char *name)
> >  {
> > -     int rc;
> > -     char *subname = selinux_boolean_sub(name);
> > +     int rc = -1;
> > +     const char *prefix = semanage_root();
> > +     const char *storename = handle->conf->store_path;
> > +     const char *selinux_root = selinux_policy_root();
> > +     char *oldroot;
> > +     char *olddir;
> > +     char *subname = NULL;
> > +     char *newroot = NULL;
> > +     char *end;
> > +
> > +     if (!selinux_root)
> > +             return -1;
> > +
> > +     oldroot = strdup(selinux_root);
> > +     if (!oldroot)
> > +             return -1;
> > +     olddir = strdup(oldroot);
> > +     if (!olddir)
> > +             goto out;
> > +     end = strrchr(olddir, '/');
> > +     if (!end)
> > +             goto out;
> > +     end++;
> > +     *end = '\0';
> > +     rc = asprintf(&newroot, "%s%s%s", prefix, olddir, storename);
> > +     if (rc < 0)
> > +             goto out;
> > +
> > +     if (strcmp(oldroot, newroot)) {
> > +             rc = selinux_set_policy_root(newroot);
> > +             if (rc)
> > +                     goto out;
> > +     }
> > +
> > +     subname = selinux_boolean_sub(name);
> > +     if (!subname) {
> > +             rc = -1;
> > +             goto out;
> > +     }
> > +
> > +     if (strcmp(oldroot, newroot)) {
> > +             rc = selinux_set_policy_root(oldroot);
> > +             if (rc)
> > +                     goto out;
> > +     }
> > +
> >       rc = sepol_bool_set_name(handle->sepolh, boolean, subname);
> > +out:
> >       free(subname);
> > +     free(oldroot);
> > +     free(olddir);
> > +     free(newroot);
> >       return rc;
> >  }
> >
> > diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
> > index a6567bd4..e5109aef 100644
> > --- a/libsemanage/src/handle.c
> > +++ b/libsemanage/src/handle.c
> > @@ -58,6 +58,8 @@ const char * semanage_root(void)
> >       return private_semanage_root;
> >  }
> >
> > +hidden_def(semanage_root);
> > +
> >  semanage_handle_t *semanage_handle_create(void)
> >  {
> >       semanage_handle_t *sh = NULL;
> > diff --git a/libsemanage/src/handle_internal.h b/libsemanage/src/handle_internal.h
> > index 66ce2708..d4b4d9c7 100644
> > --- a/libsemanage/src/handle_internal.h
> > +++ b/libsemanage/src/handle_internal.h
> > @@ -5,8 +5,9 @@
> >  #include "dso.h"
> >
> >  hidden_proto(semanage_begin_transaction)
> > -    hidden_proto(semanage_handle_destroy)
> > -    hidden_proto(semanage_reload_policy)
> > -    hidden_proto(semanage_access_check)
> > -    hidden_proto(semanage_set_root)
> > +hidden_proto(semanage_handle_destroy)
> > +hidden_proto(semanage_reload_policy)
> > +hidden_proto(semanage_access_check)
> > +hidden_proto(semanage_set_root)
> > +hidden_proto(semanage_root)
> >  #endif

