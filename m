Return-Path: <SRS0=r/KF=OS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AADC07E85
	for <selinux@archiver.kernel.org>; Sun,  9 Dec 2018 15:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4AE2081C
	for <selinux@archiver.kernel.org>; Sun,  9 Dec 2018 15:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4AE2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeLIPcf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 9 Dec 2018 10:32:35 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:38080 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeLIPce (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 9 Dec 2018 10:32:34 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 24925564712
        for <selinux@vger.kernel.org>; Sun,  9 Dec 2018 16:32:32 +0100 (CET)
Received: by mail-oi1-f172.google.com with SMTP id i6so7086613oia.6
        for <selinux@vger.kernel.org>; Sun, 09 Dec 2018 07:32:32 -0800 (PST)
X-Gm-Message-State: AA+aEWal0SFYzM/KGyGk/yirb2jb+LtSl2mmbWY6oQEusCspT4mTlxLL
        EHz4CxAeFq7SvUbitnMA/6sZPgpLmcDAvkHBZb4=
X-Google-Smtp-Source: AFSGD/VlKIuRmEXTBBaVIlXV09H+5mmD3YRmqMaGQRYQz7w3IgRVQJw7euD0kYDn5gWkiCERqCTfW9h4W/b7x1IfgaI=
X-Received: by 2002:aca:c2c3:: with SMTP id s186mr5800686oif.173.1544369551130;
 Sun, 09 Dec 2018 07:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20181204164455.13353-1-vmojzis@redhat.com>
In-Reply-To: <20181204164455.13353-1-vmojzis@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 9 Dec 2018 16:32:19 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=k5LX5ZpwZcAEKNr-3V6w7KT0Db-=ouUkQy+72LDqObKQ@mail.gmail.com>
Message-ID: <CAJfZ7=k5LX5ZpwZcAEKNr-3V6w7KT0Db-=ouUkQy+72LDqObKQ@mail.gmail.com>
Subject: Re: [PATCH] python/semanage: Start exporting "ibendport" and "ibpkey" entries
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Dec  9 16:32:32 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 4, 2018 at 5:45 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Include "ibendport" and "ibpkey" entries in "semanage export".
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  python/semanage/semanage | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index f4be9750..a192fac8 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -776,7 +776,7 @@ def setupDontauditParser(subparsers):
>
>
>  def handleExport(args):
> -    manageditems = ["boolean", "login", "interface", "user", "port", "node", "fcontext", "module"]
> +    manageditems = ["boolean", "login", "interface", "user", "port", "node", "fcontext", "module", "ibendport", "ibpkey"]
>      for i in manageditems:
>          print("%s -D" % i)
>      for i in manageditems:
> --
> 2.17.2

Thanks, I have successfully tested it and merged this patch.
Nicolas

