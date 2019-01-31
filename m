Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDD1C169C4
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 22:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7AE20833
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 22:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfAaWCh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:02:37 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:58957 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfAaWCh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Jan 2019 17:02:37 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1DFCB56129C
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 23:02:35 +0100 (CET)
Received: by mail-oi1-f177.google.com with SMTP id t204so4124114oie.7
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 14:02:35 -0800 (PST)
X-Gm-Message-State: AHQUAuZcL9T6c4QcxFPJ7ChGDrBIJD6wHsm9Wm3aRk/SwM/RwJsI4q8K
        2HKCEwtivJ1xsQAjh6PsLk4zyx7Q47LIMVynUI0=
X-Google-Smtp-Source: AHgI3IbiOh+jg/stm3tbje4eFvFWlDsB4sv6MvxsEoKUtvIoY0a6Zk22+JxKPKCvQ34MFwRH1v0WVOBD8sOkCvpa6n8=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr15735245oig.232.1548972154240;
 Thu, 31 Jan 2019 14:02:34 -0800 (PST)
MIME-Version: 1.0
References: <20190131194824.4944-1-plautrba@redhat.com> <20190131194824.4944-2-plautrba@redhat.com>
In-Reply-To: <20190131194824.4944-2-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 31 Jan 2019 23:02:23 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==7=Jntk=7_Np3O6R0kE9H7AOdZ3VDu+=Dhnp-ORzKmOg@mail.gmail.com>
Message-ID: <CAJfZ7==7=Jntk=7_Np3O6R0kE9H7AOdZ3VDu+=Dhnp-ORzKmOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: Change matchpathcon usage to match with
 matchpathcon manpage
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jan 31 23:02:35 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 31, 2019 at 8:48 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libselinux/utils/matchpathcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpathcon.c
> index 67e4a433..9756d7d9 100644
> --- a/libselinux/utils/matchpathcon.c
> +++ b/libselinux/utils/matchpathcon.c
> @@ -14,7 +14,7 @@
>  static __attribute__ ((__noreturn__)) void usage(const char *progname)
>  {
>         fprintf(stderr,
> -               "usage:  %s [-N] [-n] [-f file_contexts] [ -P policy_root_path ] [-p prefix] [-Vq] path...\n",
> +               "usage:  %s [-V] [-N] [-n] [-m type] [-f file_contexts_file] [-p prefix] [-P policy_root_path] filepath...\n",
>                 progname);
>         exit(1);
>  }
> --
> 2.20.1
>

