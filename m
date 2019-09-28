Return-Path: <SRS0=GlX2=XX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C54C4360C
	for <selinux@archiver.kernel.org>; Sat, 28 Sep 2019 10:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFC520830
	for <selinux@archiver.kernel.org>; Sat, 28 Sep 2019 10:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbfI1KKw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 28 Sep 2019 06:10:52 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:34890 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfI1KKw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 28 Sep 2019 06:10:52 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7FF665605E3
        for <selinux@vger.kernel.org>; Sat, 28 Sep 2019 12:10:48 +0200 (CEST)
Received: by mail-ot1-f50.google.com with SMTP id 21so4393209otj.11
        for <selinux@vger.kernel.org>; Sat, 28 Sep 2019 03:10:48 -0700 (PDT)
X-Gm-Message-State: APjAAAWNLnql9NMEnKP0MffmNI1INeTpnrl6G6DN4oF/jhFzkKiSj57g
        qH3sWcisPTvFMzdK02XaCPFBuEvvYeirWiqrcP0=
X-Google-Smtp-Source: APXvYqwC1nn6y4pO+U64DOWGRyeaaqjse6hIr43eLs6BLMwuqyH/UOZd+Ztjx25uJaNwBguv1rEajSDrn8Gj70VZjb4=
X-Received: by 2002:a9d:664:: with SMTP id 91mr6467398otn.189.1569665447530;
 Sat, 28 Sep 2019 03:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190927144243.3479-1-vmojzis@redhat.com>
In-Reply-To: <20190927144243.3479-1-vmojzis@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 28 Sep 2019 12:10:36 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nBDUZYO95PN4p5FaXh_KAa3SeHu6yq4CteFGgyPkjEUw@mail.gmail.com>
Message-ID: <CAJfZ7=nBDUZYO95PN4p5FaXh_KAa3SeHu6yq4CteFGgyPkjEUw@mail.gmail.com>
Subject: Re: [PATCH] python/semaange: fix moduleRecords.customized()
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Sep 28 12:10:49 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 27, 2019 at 4:42 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Return value of "customized" has to be iterable.
>
> Fixes:
>    "semanage export" with no modules in the system (eg. monolithic policy)
>    crashes:
>
>    Traceback (most recent call last):
>      File "/usr/sbin/semanage", line 970, in <module>
>        do_parser()
>      File "/usr/sbin/semanage", line 949, in do_parser
>        args.func(args)
>      File "/usr/sbin/semanage", line 771, in handleExport
>        for c in OBJECT.customized():
>    TypeError: 'NoneType' object is not iterable
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

This looks good to me, but there is a misspelling in the subject of
the patch: semaange -> semanage.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

> ---
>  python/semanage/seobject.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 5e9e3eb5..f4c29854 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -380,7 +380,7 @@ class moduleRecords(semanageRecords):
>      def customized(self):
>          all = self.get_all()
>          if len(all) == 0:
> -            return
> +            return []
>          return ["-d %s" % x[0] for x in [t for t in all if t[1] == 0]]
>
>      def list(self, heading=1, locallist=0):
> --
> 2.21.0
>

