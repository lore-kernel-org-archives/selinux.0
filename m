Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A39C2BA83
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 12:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3B42086A
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 12:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbIli7tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgBNMqd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 07:46:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44618 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727822AbgBNMqd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 07:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581684391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ht+JYT0w+WD5HFRWBhme4YPKIyv6ksZSD2q5DWJ5FJo=;
        b=LbIli7tpbwv4NBpq+xlJ8mZyAkZ6L55h1kbfmMKlAk0YiireSFIB/Zf7uLyHwCL4tNZsPb
        6j3v7h2ayaZQaU8FO5h//MJA58ZAQxOA+gfXuHaoqXkbnUtx+4d6O+5FjH9IgSLtHpKCF4
        HztByvjAy1q+9J5m/wb0TmGSAHNxPOY=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-cOZFJwOLPri2zD9WkVBOpg-1; Fri, 14 Feb 2020 07:46:26 -0500
X-MC-Unique: cOZFJwOLPri2zD9WkVBOpg-1
Received: by mail-oi1-f199.google.com with SMTP id d9so4509605oij.4
        for <selinux@vger.kernel.org>; Fri, 14 Feb 2020 04:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ht+JYT0w+WD5HFRWBhme4YPKIyv6ksZSD2q5DWJ5FJo=;
        b=G82C5raXT25BTbu2dx9bZ/ij18UXydfu7F4H42hqDzFNsxuWwugEUsnH+JrNvJMm5d
         MDXLZU4QPV+VsToV+fg4v39ApVes/vFTbdP2Z3LJwVoyOekXJdULUrUih6jgRjcHhL4o
         pUJDX0XbwZVMOoQ7rRtm5OrnBAB11yrYby1FT+PQKYISNSpedQSwYVqpLOPR0e8s1xMa
         c4BisUSKYV7uD++uLJt9In4Pl3QUOzUXwfQPaR0ttTJMuHqpDfSOqpLp+5IQoYXzyFFR
         pnBod85AtQEl67PlTYiIyJnHhhwvp4pe3ByRJ8FjHOlX3XCddNq8xLG6O6BSUaaZrvDl
         I/dg==
X-Gm-Message-State: APjAAAWNsC0TpXInZhNV31CRxCoQfomFhiYJBE4/Syh4BOgZy9LibnSd
        k5WXHLkyKNzPMbPy2KB/uHxEjIVvrbo1wVzmyqOqdBo7O9HOh58c6e9FPMhJv3WWn3mggdOV6+/
        0wAkxCDI3Hkphjm8LA0nJP3d3bFYbE9qpNw==
X-Received: by 2002:a9d:6283:: with SMTP id x3mr2011726otk.367.1581684385986;
        Fri, 14 Feb 2020 04:46:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqxKOQbPxTqA+JvitmGsmg9dRDqhkkkETHAYnXDKY+Odrt1G80LdemHo4/nQsg6mHzZvGYd7/WhbRFJ9qYAac9o=
X-Received: by 2002:a9d:6283:: with SMTP id x3mr2011709otk.367.1581684385630;
 Fri, 14 Feb 2020 04:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20200129164256.3190-1-sds@tycho.nsa.gov>
In-Reply-To: <20200129164256.3190-1-sds@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 14 Feb 2020 13:46:14 +0100
Message-ID: <CAFqZXNsk_fyPuLDz-jtjtjzJR5rZmBAKgFzPk3Z0y35ahyaeRw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: remove unused initial SIDs and improve handling
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 29, 2020 at 5:42 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Remove initial SIDs that have never been used or are no longer
> used by the kernel from its string table, which is also used
> to generate the SECINITSID_* symbols referenced in code.
> Update the code to gracefully handle the fact that these can
> now be NULL. Stop treating it as an error if a policy defines
> additional initial SIDs unknown to the kernel.  Do not
> load unused initial SID contexts into the sidtab.
> Fix the incorrect usage of the name from the ocontext in error
> messages when loading initial SIDs since these are not presently
> written to the kernel policy and are therefore always NULL.
>
> This is a first step toward enabling future evolution of
> initial SIDs. Further changes are required to both userspace
> and the kernel to fully address
> https://github.com/SELinuxProject/selinux-kernel/issues/12
> but this takes a small step toward that end.
>
> Fully decoupling the policy and kernel initial SID values will
> require introducing a mapping between them and dyhamically

Nit: s/dyhamically/dynamically/

> mapping them at load time.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> v2 avoids loading all unused initial SID contexts into the sidtab,
> not just ones beyond SECINITSID_NUM.  It also drops the unnecessary
> check for an undefined context because all contexts in the OCON_ISID
> list were already validated at load time via context_read_and_validate().
>
>  scripts/selinux/genheaders/genheaders.c       | 11 +++-
>  .../selinux/include/initial_sid_to_string.h   | 57 +++++++++----------
>  security/selinux/selinuxfs.c                  |  6 +-
>  security/selinux/ss/policydb.c                | 25 ++++----
>  security/selinux/ss/services.c                | 26 ++++-----
>  5 files changed, 66 insertions(+), 59 deletions(-)

<snip>

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 2aa7f2e1a8e7..768a9d4e0b86 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -865,29 +865,28 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
>
>         head = p->ocontexts[OCON_ISID];
>         for (c = head; c; c = c->next) {
> -               rc = -EINVAL;
> -               if (!c->context[0].user) {
> -                       pr_err("SELinux:  SID %s was never defined.\n",
> -                               c->u.name);
> -                       sidtab_destroy(s);
> -                       goto out;
> -               }
> -               if (c->sid[0] == SECSID_NULL || c->sid[0] > SECINITSID_NUM) {
> -                       pr_err("SELinux:  Initial SID %s out of range.\n",
> -                               c->u.name);
> +               u32 sid = c->sid[0];
> +               const char *name = security_get_initial_sid_context(sid);
> +
> +               if (sid == SECSID_NULL) {
> +                       pr_err("SELinux:  SID null was assigned a context.\n");
>                         sidtab_destroy(s);
>                         goto out;
>                 }

Your sentence "Stop treating it as an error if a policy defines
additional initial SIDs unknown to the kernel." and the removed check
for > SECINITSID_NUM suggest that you intend to not treat this
condition as an error, but sidtab_set_initial() called bellow will
reject such SID with -ENIVAL. Or am I misreading it and you just
wanted to remove the duplicate check?

> +
> +               /* Ignore initial SIDs unused by this kernel. */
> +               if (!name)
> +                       continue;
> +
>                 rc = context_add_hash(p, &c->context[0]);
>                 if (rc) {
>                         sidtab_destroy(s);
>                         goto out;
>                 }
> -
> -               rc = sidtab_set_initial(s, c->sid[0], &c->context[0]);
> +               rc = sidtab_set_initial(s, sid, &c->context[0]);
>                 if (rc) {
>                         pr_err("SELinux:  unable to load initial SID %s.\n",
> -                               c->u.name);
> +                              name);
>                         sidtab_destroy(s);
>                         goto out;
>                 }

<snip>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

