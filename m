Return-Path: <SRS0=yj3S=6M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919BBC83000
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 21:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783D82072A
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 21:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgD1V22 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:28:28 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:49211 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgD1V22 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Apr 2020 17:28:28 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 319E95648FC
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2020 23:28:25 +0200 (CEST)
Received: by mail-ot1-f44.google.com with SMTP id m18so35400146otq.9
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2020 14:28:25 -0700 (PDT)
X-Gm-Message-State: AGi0PuZt6i3AKQ1/k1kCeLuoaHFcKVc/A2X2jS/sWPEJF4bif5lU6ONi
        OdoX4uGCdvDzg7PwubAVHjZFeDPDn9L+56WCQiU=
X-Google-Smtp-Source: APiQypKUNiKlH38MlJ4aWuD1puBoDXrfzNVOrATDPteuKh5DzasRTsnxMDzNSOZqmP3RqO2N4zDNJOKOxwiUl4RNXXA=
X-Received: by 2002:a05:6808:3d5:: with SMTP id o21mr4686784oie.40.1588109304168;
 Tue, 28 Apr 2020 14:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7=mv_e7zo2T8MBOmODW8NHc48cr3GB1Jvi8=Gg-qm7QPTQ@mail.gmail.com>
 <20200427153438.17061-1-plautrba@redhat.com>
In-Reply-To: <20200427153438.17061-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 28 Apr 2020 23:28:13 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mjM5YqgaF0sjibssaj3Jdb03f5HDtXdwg-VQcF7_ygPg@mail.gmail.com>
Message-ID: <CAJfZ7=mjM5YqgaF0sjibssaj3Jdb03f5HDtXdwg-VQcF7_ygPg@mail.gmail.com>
Subject: Re: [PATCH v2] python/semanage: Use ipaddress module instead of IPy
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Apr 28 23:28:25 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 27, 2020 at 5:35 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> ipaddress python module was added to standard library in Python 3.3 -
> https://docs.python.org/3/library/ipaddress.html
>
> seobject.py was the only consumer of IPy module so this dependency is not needed
> anymore.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>
> Based on Nicolas input:
>
> - improved the check comment
> - dropped the unnecessary check

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

I will apply this patch tomorrow if nobody else has any comment.
Thanks,
Nicolas

>  python/semanage/seobject.py | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index f2a139c970bd..6e0b87f2fa3c 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -32,7 +32,7 @@ from semanage import *
>  PROGNAME = "policycoreutils"
>  import sepolicy
>  import setools
> -from IPy import IP
> +import ipaddress
>
>  try:
>      import gettext
> @@ -1858,15 +1858,12 @@ class nodeRecords(semanageRecords):
>          if addr == "":
>              raise ValueError(_("Node Address is required"))
>
> -        # verify valid combination
> +        # verify that (addr, mask) is either a IP address (without a mask) or a valid network mask
>          if len(mask) == 0 or mask[0] == "/":
> -            i = IP(addr + mask)
> -            newaddr = i.strNormal(0)
> -            newmask = str(i.netmask())
> -            if newmask == "0.0.0.0" and i.version() == 6:
> -                newmask = "::"
> -
> -            protocol = "ipv%d" % i.version()
> +            i = ipaddress.ip_network(addr + mask)
> +            newaddr = str(i.network_address)
> +            newmask = str(i.netmask)
> +            protocol = "ipv%d" % i.version
>
>          try:
>              newprotocol = self.protocol.index(protocol)
> --
> 2.26.2
>

