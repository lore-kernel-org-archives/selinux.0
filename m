Return-Path: <SRS0=LEY+=7R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D682C433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 20:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76BDC206C3
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 20:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLOfHMRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgFDUaa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgFDUa3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Jun 2020 16:30:29 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E98C08C5C0
        for <selinux@vger.kernel.org>; Thu,  4 Jun 2020 13:30:29 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id y9so381881ooa.12
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2020 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jibYXcMslU3TGQWCIu8wcuMBQjrX8RjIQW/7LkVos/I=;
        b=QLOfHMRVshMyIoY0tqzWlDBIJ5mtvp7CQ8XjWGD25eICNCDOY6GBIjBCsWS3lYe9NC
         TxMqKNyZ1lkQ07aeLkoYedSf3W58OqK7BCB80Nn/lrJkPqaKsdKZCWyAuljY+wgjenn1
         Uh1OOn2hk00dT5Tsu9IgB+hc1KzRs5lBLomtRdIHMtkr4dhO0b5HFd2WWE18EsyohQDe
         o6+dmmaxTOd7KEIRZqnRA4INwrCgKTLfQ3zNuSJLY9Er7cMYCCOpPh5YeebIT9b7m7S4
         U5x3KfF25IZ6T/z6t/qDWYcYUJed1Qsw8rxr32Qb0n+Am6S39KycPVUEoZat0XKZNShv
         ATgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jibYXcMslU3TGQWCIu8wcuMBQjrX8RjIQW/7LkVos/I=;
        b=VuHSexXtSfp3fREDaQHMV9hsf3j5T2O30/tt1q+zjuENQBIClOCjTXMXQArz6/CNA0
         8aMvTGBA6fsmrvbcOl3rpoYr578oMbmC9x0bw8dEJnCSwWPHm/6LcDvM/SacSPDwqr05
         IuTmedrlqQpfC2f0EU3HUrAweHySefyxaXWDyUt8UXEbDlYW88emYU/lkU1hokOQYEAM
         SO1+CegVxYlUQhBtYcT9JTfVfnH6Sgyk2MvM8OEdZtahVJlMaXyuwSiLbnCSPJ526Qta
         0MUsDHDt4F3Dfoiw9PDKUaOH52xr4HTKfPXvGv4vO5lHWHxybV+n63Y3mkKuXkAz7Ckf
         765A==
X-Gm-Message-State: AOAM532opn/UHmK8eTBPNqMGNJB0iObcfQCpKHwZ+OUGkMjs+oqE+oTY
        9SP6Ti3vfVNOAb3twFzOxbRiUmWkKJspbwGhoaSX9BbNOCw=
X-Google-Smtp-Source: ABdhPJzU75FE5unJx1MtsHVwpaxgY8osBX/43oc56yyvxMxvK48nPVkJNuDI9G06SthW+W4nWfI028wE+conMIlZ6A4=
X-Received: by 2002:a4a:e74a:: with SMTP id n10mr5004203oov.71.1591302629215;
 Thu, 04 Jun 2020 13:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200602141935.24722-1-toiwoton@gmail.com>
In-Reply-To: <20200602141935.24722-1-toiwoton@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 4 Jun 2020 16:30:18 -0400
Message-ID: <CAEjxPJ6t2xyQ54y83AN5bMJuHMRwi=4haEFXCR6Fw9JhdqcqhQ@mail.gmail.com>
Subject: Re: [PATCH] Avoid using getprotobyname()
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 2, 2020 at 10:21 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> At least on Debian, /etc/protocols, which is used by
> socket.getprotobyname() to resolve protocols to names, does not
> contain an entry for "ipv4", so let's avoid using
> socket.getprotobyname() since the protocol names are not used in
> socket context anyway.
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>

Only concern I have here is that it could change the resulting audit
record content. Not sure how the audit people feel about that.
Maybe ask on linux-audit mailing list?

> ---
>  python/semanage/seobject.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 6e0b87f2..dfb165a2 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1942,7 +1942,7 @@ class nodeRecords(semanageRecords):
>          semanage_node_key_free(k)
>          semanage_node_free(node)
>
> -        self.mylog.log_change("resrc=node op=add laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, socket.getprotobyname(self.protocol[proto]), "system_u", "object_r", ctype, serange))
> +        self.mylog.log_change("resrc=node op=add laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, self.protocol[proto], "system_u", "object_r", ctype, serange))
>
>      def add(self, addr, mask, proto, serange, ctype):
>          self.begin()
> @@ -1987,7 +1987,7 @@ class nodeRecords(semanageRecords):
>          semanage_node_key_free(k)
>          semanage_node_free(node)
>
> -        self.mylog.log_change("resrc=node op=modify laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, socket.getprotobyname(self.protocol[proto]), "system_u", "object_r", setype, serange))
> +        self.mylog.log_change("resrc=node op=modify laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, self.protocol[proto], "system_u", "object_r", setype, serange))
>
>      def modify(self, addr, mask, proto, serange, setype):
>          self.begin()
> @@ -2020,7 +2020,7 @@ class nodeRecords(semanageRecords):
>
>          semanage_node_key_free(k)
>
> -        self.mylog.log_change("resrc=node op=delete laddr=%s netmask=%s proto=%s" % (addr, mask, socket.getprotobyname(self.protocol[proto])))
> +        self.mylog.log_change("resrc=node op=delete laddr=%s netmask=%s proto=%s" % (addr, mask, self.protocol[proto]))
>
>      def delete(self, addr, mask, proto):
>          self.begin()
> --
> 2.26.2
>
