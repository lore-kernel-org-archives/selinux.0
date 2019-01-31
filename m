Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EB5C169C4
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 21:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A2520869
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 21:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfAaVr6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:47:58 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:48801 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfAaVr5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Jan 2019 16:47:57 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6CF735611EA
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 22:47:55 +0100 (CET)
Received: by mail-ot1-f53.google.com with SMTP id i20so4266209otl.0
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 13:47:55 -0800 (PST)
X-Gm-Message-State: AJcUukfryKPDZpZIc6YSqrxw8jYbVXdmy3j6PsEfZ/wK1OyFpqTq950j
        2ro75XqWZhC92el9euVPENxfZQcWEDz6Wsgcaa4=
X-Google-Smtp-Source: ALg8bN4s4AVyWrJU0SSlAZoBQO7Z3XelPyEGS/LjrjkOvOgN/4NMkmZTHG03dJnODG4AS4+Q1QMdGygBY5Qe7aVdXzE=
X-Received: by 2002:a9d:60cf:: with SMTP id b15mr25895294otk.144.1548971274397;
 Thu, 31 Jan 2019 13:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20190131132226.19030-1-plautrba@redhat.com> <20190131132226.19030-2-plautrba@redhat.com>
In-Reply-To: <20190131132226.19030-2-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 31 Jan 2019 22:47:43 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mO29pHKvNH7r6WWabyNth=nJboYU1rP4DpW5E41Q_YQQ@mail.gmail.com>
Message-ID: <CAJfZ7=mO29pHKvNH7r6WWabyNth=nJboYU1rP4DpW5E41Q_YQQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] libselinux: Fix RESOURCE_LEAK defects reported by
 coverity scan
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jan 31 22:47:55 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 31, 2019 at 2:22 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libselinux/src/checkAccess.c        |  4 +++-
>  libselinux/src/label_db.c           |  3 +++
>  libselinux/src/label_file.c         |  4 +++-
>  libselinux/src/load_policy.c        |  4 +++-
>  libselinux/src/selinux_config.c     | 17 +++++++++--------
>  libselinux/src/selinux_restorecon.c | 12 ++++++++++--
>  6 files changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
> index 8de57477..16bfcfb6 100644
> --- a/libselinux/src/checkAccess.c
> +++ b/libselinux/src/checkAccess.c
> @@ -89,8 +89,10 @@ int selinux_check_passwd_access(access_vector_t requested)
>                 int retval;
>
>                 passwd_class = string_to_security_class("passwd");
> -               if (passwd_class == 0)
> +               if (passwd_class == 0) {
> +                       freecon(user_context);
>                         return 0;
> +               }
>
>                 retval = security_compute_av_raw(user_context,
>                                                      user_context,
> diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
> index c46d0a1d..fa481e04 100644
> --- a/libselinux/src/label_db.c
> +++ b/libselinux/src/label_db.c
> @@ -283,10 +283,12 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
>         }
>         if (fstat(fileno(filp), &sb) < 0) {
>                 free(catalog);
> +    fclose(filp);
>                 return NULL;
>         }
>         if (!S_ISREG(sb.st_mode)) {
>                 free(catalog);
> +    fclose(filp);
>                 errno = EINVAL;
>                 return NULL;
>         }

Please indent with tabs instead of spaces, like the other lines.
All the other changes in this patch look good to me.

Nicolas

