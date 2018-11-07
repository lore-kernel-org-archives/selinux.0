Return-Path: <SRS0=WkJB=NS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5024C46464
	for <selinux@archiver.kernel.org>; Wed,  7 Nov 2018 20:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FC920892
	for <selinux@archiver.kernel.org>; Wed,  7 Nov 2018 20:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FC920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeKHGRU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:17:20 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:37377 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKHGRT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Nov 2018 01:17:19 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8829E5611E6
        for <selinux@vger.kernel.org>; Wed,  7 Nov 2018 21:45:12 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id g27so16073471oth.6
        for <selinux@vger.kernel.org>; Wed, 07 Nov 2018 12:45:12 -0800 (PST)
X-Gm-Message-State: AGRZ1gLb7BVLPh50K15lMT2QzEddeUjOjfeHQAueCC855vZj90f6CV5/
        z3YaVEft4ElP0ab1E9cBaM+scVegy/5pCdR+ev8=
X-Google-Smtp-Source: AJdET5cEjNk5pQSyLNq/Uc8OPCmu/tkFcBbRoP5Wx/D2Vqk9EWR58BwiGoGU2El7DDVaWmPlS2w6zITVcn+YF+1ITf0=
X-Received: by 2002:a9d:2f66:: with SMTP id h93mr1167277otb.165.1541623511455;
 Wed, 07 Nov 2018 12:45:11 -0800 (PST)
MIME-Version: 1.0
References: <20181106192021.17556-1-sds@tycho.nsa.gov>
In-Reply-To: <20181106192021.17556-1-sds@tycho.nsa.gov>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 7 Nov 2018 21:45:00 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kYppH2JjSkpcgX1FXnaRtHB7c561hkgRZ0XOym_T7_Ww@mail.gmail.com>
Message-ID: <CAJfZ7=kYppH2JjSkpcgX1FXnaRtHB7c561hkgRZ0XOym_T7_Ww@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: set selinux policy root to match semanage
 root or storename
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Nov  7 21:45:13 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 6, 2018 at 8:18 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> As reported in #109, semodule -p /path/to/policyroot -s minimum -n -B
> tries to use /etc/selinux/targeted/booleans.subs_dist.  This is because
> it invokes the libselinux selinux_boolean_sub() interface, which uses
> the active/installed policy files rather than the libsemanage ones.
>
> To fix, we need to set the selinux policy root when either the semanage
> root or the semanage storename is set.  When setting the semanage root,
> we need to prepend the semanage root to the selinux policy root.  When
> setting the semanage storename, we need to replace the last component
> of the selinux policy root with the new storename.
>
> Test:
> strace semodule -p ~/policy-root -s minimum -n -B
>
> Before:
> openat(AT_FDCWD, "/etc/selinux/targeted/booleans.subs_dist", O_RDONLY|O_CLOEXEC) = 5
>
> After:
> openat(AT_FDCWD, "/home/sds/policy-root/etc/selinux/minimum/booleans.subs_dist", O_RDONLY|O_CLOEXEC) = 5
>
> Fixes https://github.com/SELinuxProject/selinux/issues/109
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  libsemanage/src/handle.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
> index a6567bd4..c163e553 100644
> --- a/libsemanage/src/handle.c
> +++ b/libsemanage/src/handle.c
> @@ -43,8 +43,21 @@ static char *private_semanage_root = NULL;
>
>  int semanage_set_root(const char *root)
>  {
> +       char *new_selinux_root = NULL;
> +
> +       asprintf(&new_selinux_root, "%s%s", root, selinux_policy_root());
> +       if (!new_selinux_root)
> +               return -1;

https://travis-ci.org/SELinuxProject/selinux/builds/451528669 failed
because the return value of asprintf needs to be checked instead of
new_selinux_root. http://man7.org/linux/man-pages/man3/asprintf.3.html
states:

    If memory allocation wasn't possible, or some other error occurs,
these functions will return -1, and the contents of strp are
undefined.

[...]

> +
> +       char *newroot = NULL;
> +       asprintf(&newroot, "%s%s", root, storename);
> +       assert(newroot);

Same here.

Nicolas

