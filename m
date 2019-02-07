Return-Path: <SRS0=93oN=QO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CC6C282C2
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 21:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445AF2175B
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 21:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfBGVES (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:04:18 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:47172 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfBGVES (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Feb 2019 16:04:18 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 64EF55606B4
        for <selinux@vger.kernel.org>; Thu,  7 Feb 2019 22:04:15 +0100 (CET)
Received: by mail-ot1-f51.google.com with SMTP id e24so2244150otp.11
        for <selinux@vger.kernel.org>; Thu, 07 Feb 2019 13:04:15 -0800 (PST)
X-Gm-Message-State: AHQUAuZPM7I+LGcX6vTJ5s8WbICKWABbZ9ZL8e77uHsKnxIKUEWVUBr/
        nWqeu4hYANw0IlIQm72KC/8fiOrcIuNfwsnKJN8=
X-Google-Smtp-Source: AHgI3IaxmfoPqRLM5nFaMqbjfKv3O8aKrkxjPd2NnTJyLId2Wc7L5ImS7F3WdhLa8xtOD46XbeKmespQCZ70LUnL1Ns=
X-Received: by 2002:a9d:2f66:: with SMTP id h93mr10183902otb.165.1549573454530;
 Thu, 07 Feb 2019 13:04:14 -0800 (PST)
MIME-Version: 1.0
References: <pjdmun8x8v1.fsf@redhat.com> <20190207091844.11336-1-plautrba@redhat.com>
In-Reply-To: <20190207091844.11336-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 7 Feb 2019 22:04:03 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mCJu_e1hzkmWHZpctCgQgzW9jPzt19Lw1rVsP=N2ygDw@mail.gmail.com>
Message-ID: <CAJfZ7=mCJu_e1hzkmWHZpctCgQgzW9jPzt19Lw1rVsP=N2ygDw@mail.gmail.com>
Subject: Re: [PATCH v2] dbus: Fix name of polkit function
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, Dan Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Feb  7 22:04:15 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 7, 2019 at 10:18 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> From: Dan Walsh <dwalsh@redhat.com>
>
> Add missing action org.selinux.change_default_mode for change_default_mode() and
> remove unused action org.selinux.change_policy_type.
>
> Fixes: e8718ef51463 ("Make sure we do the polkit check on all dbus interfaces.")
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  dbus/org.selinux.policy | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/dbus/org.selinux.policy b/dbus/org.selinux.policy
> index 01266102..9772127b 100644
> --- a/dbus/org.selinux.policy
> +++ b/dbus/org.selinux.policy
> @@ -70,9 +70,9 @@
>           <allow_active>auth_admin_keep</allow_active>
>          </defaults>
>      </action>
> -    <action id="org.selinux.change_policy_type">
> -        <description>SELinux write access</description>
> -        <message>System policy prevents change_policy_type access to SELinux</message>
> +    <action id="org.selinux.change_default_mode">
> +        <description>Change SELinux default enforcing mode</description>
> +        <message>System policy prevents change_default_policy access to SELinux</message>
>          <defaults>
>            <allow_any>no</allow_any>
>            <allow_inactive>no</allow_inactive>
> --
> 2.20.1
>

