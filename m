Return-Path: <SRS0=r/KF=OS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD48C07E85
	for <selinux@archiver.kernel.org>; Sun,  9 Dec 2018 14:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F4320831
	for <selinux@archiver.kernel.org>; Sun,  9 Dec 2018 14:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F4320831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeLIOTh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:19:37 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:59497 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeLIOTh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 9 Dec 2018 09:19:37 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 107AB56122F
        for <selinux@vger.kernel.org>; Sun,  9 Dec 2018 15:19:34 +0100 (CET)
Received: by mail-oi1-f175.google.com with SMTP id c206so7032702oib.0
        for <selinux@vger.kernel.org>; Sun, 09 Dec 2018 06:19:34 -0800 (PST)
X-Gm-Message-State: AA+aEWZHv41MX8VIDXCR8RJkK4to+P5KqKigMiLtICLY7/XZC27uJTM5
        HaCeFXVMeXYEbVQ+S5fc8f7nGSfm/57j3+z+xFk=
X-Google-Smtp-Source: AFSGD/UEaDitvucSCWLNCIPEWvafIymcvOJ+/Q6gFQrpKKW4NqOKIE/kXsH6/RVToBgUnWGwmQyPiXmTz2/HU+Zwn1k=
X-Received: by 2002:aca:e142:: with SMTP id y63mr5195341oig.314.1544365173045;
 Sun, 09 Dec 2018 06:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20181204103540.6041-1-plautrba@redhat.com>
In-Reply-To: <20181204103540.6041-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 9 Dec 2018 15:19:21 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=k+dNFE7AOO_FJhSMZP7WdvkJf3zbfqeY6kSkabOm+Uag@mail.gmail.com>
Message-ID: <CAJfZ7=k+dNFE7AOO_FJhSMZP7WdvkJf3zbfqeY6kSkabOm+Uag@mail.gmail.com>
Subject: Re: [PATCH] python/chcat: use check_call instead of getstatusoutput
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, Vit Mojzis <vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Dec  9 15:19:34 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 4, 2018 at 11:35 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> From: Vit Mojzis <vmojzis@redhat.com>
>
> Use "check_call" instead of "getstatusoutput" in order for special
> characters and spaces in filenames to be handled correctly.
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1013774
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

I have tested it in a Fedora VM and it worked.

Thanks!
Nicolas

