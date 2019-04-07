Return-Path: <SRS0=lGRf=SJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B1BC10F0E
	for <selinux@archiver.kernel.org>; Sun,  7 Apr 2019 20:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A6F20896
	for <selinux@archiver.kernel.org>; Sun,  7 Apr 2019 20:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfDGUVm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 7 Apr 2019 16:21:42 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:57781 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDGUVm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 7 Apr 2019 16:21:42 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B6D6B56481A
        for <selinux@vger.kernel.org>; Sun,  7 Apr 2019 22:21:38 +0200 (CEST)
Received: by mail-ot1-f41.google.com with SMTP id 64so10131693otb.8
        for <selinux@vger.kernel.org>; Sun, 07 Apr 2019 13:21:38 -0700 (PDT)
X-Gm-Message-State: APjAAAUXV3oCdLSnLELlNTYYQBN9YL+Ly3ijAewLg/DevdPkesCJHKWT
        3LmZXP+lhBZRWhRrhRaumM5SUdmJs92Ndb473YE=
X-Google-Smtp-Source: APXvYqx1E/87Ug8ZIi3U9mO3wIv4pwuA/i35JdxK2vN6oII2xEd0MDRuMKMYQcHBAHc7wyXaj3HbgFPYY+6Q4hSfvwg=
X-Received: by 2002:a9d:6a43:: with SMTP id h3mr17667285otn.270.1554668497784;
 Sun, 07 Apr 2019 13:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190404211938.24183-1-plautrba@redhat.com>
In-Reply-To: <20190404211938.24183-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 7 Apr 2019 22:21:26 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=n3sfg9aqd-fG61s4SJXUBNTiBoAFgAqOm50UHa2TsVTA@mail.gmail.com>
Message-ID: <CAJfZ7=n3sfg9aqd-fG61s4SJXUBNTiBoAFgAqOm50UHa2TsVTA@mail.gmail.com>
Subject: Re: [PATCH] semanage/semanage-boolean.8: Fix a minor typo
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, Bogdan BOTEZ <bmbogdan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Apr  7 22:21:39 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 4, 2019 at 11:19 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> boolan -> boolean
>
> Reported-by: Bogdan BOTEZ <bmbogdan@gmail.com>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

> ---
>  python/semanage/semanage-boolean.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/semanage/semanage-boolean.8 b/python/semanage/semanage-boolean.8
> index 99a6260b..1282d106 100644
> --- a/python/semanage/semanage-boolean.8
> +++ b/python/semanage/semanage-boolean.8
> @@ -45,7 +45,7 @@ Disable the boolean
>
>  .SH EXAMPLE
>  .nf
> -Turn on the apache can send mail boolan
> +Turn on the apache can send mail boolean
>  # semanage boolean \-m \-\-on httpd_can_sendmail
>
>  List customized booleans
> --
> 2.21.0
>

