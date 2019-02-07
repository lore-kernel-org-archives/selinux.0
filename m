Return-Path: <SRS0=93oN=QO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA35CC282C2
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 21:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831A52175B
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 21:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfBGVr4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:47:56 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:41116 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGVr4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Feb 2019 16:47:56 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id A729C56121F
        for <selinux@vger.kernel.org>; Thu,  7 Feb 2019 22:47:53 +0100 (CET)
Received: by mail-ot1-f47.google.com with SMTP id n8so2523541otl.6
        for <selinux@vger.kernel.org>; Thu, 07 Feb 2019 13:47:53 -0800 (PST)
X-Gm-Message-State: AHQUAuZxlqvJd85LisygijzwTZmmMmrJ42RIdF8rs90+I3RfTQoKgqCi
        Cj6wP4yx9YtD0yKlG+ASJdcH1kfFMyb0d9XSTPw=
X-Google-Smtp-Source: AHgI3IYQcA15qWkSOsNeDhLcjoelZRpOOYcqKWU5dYwJS4wsePI6ZjrS+Q2IuKT/BhtKtBvO685e6W7MaDJYUo9q7bw=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr956849otq.301.1549576072789;
 Thu, 07 Feb 2019 13:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20190206194325.24875-1-plautrba@redhat.com> <20190206194325.24875-2-plautrba@redhat.com>
In-Reply-To: <20190206194325.24875-2-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 7 Feb 2019 22:47:41 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==AuhPnrqqiBDh8YAQ9X7_G2VxGTDR7wdr7xSm7UVLPrQ@mail.gmail.com>
Message-ID: <CAJfZ7==AuhPnrqqiBDh8YAQ9X7_G2VxGTDR7wdr7xSm7UVLPrQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] python/semanage: Use standard argparse.error() method
 in handlePermissive
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Feb  7 22:47:54 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 6, 2019 at 8:43 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> This method prints a usage message including the message to the standard error
> and terminates the program with a status code of 2.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

For this patch:
Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

> ---
>  python/semanage/semanage | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index 9b737fa8..a9fcb319 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -743,9 +743,7 @@ def handlePermissive(args):
>          if args.action == "delete":
>              OBJECT.delete(args.type)
>      else:
> -        args.parser.print_usage(sys.stderr)
> -        sys.stderr.write(_('semanage permissive: error: the following argument is required: type\n'))
> -        sys.exit(1)
> +        args.parser.error(message=_('semanage permissive: error: the following argument is required: type\n'))
>
>
>  def setupPermissiveParser(subparsers):
> --
> 2.20.1
>

