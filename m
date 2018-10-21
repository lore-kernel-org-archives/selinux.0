Return-Path: <SRS0=UzCa=NB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_NAME_FM_MR_MRS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531E4ECDE44
	for <selinux@archiver.kernel.org>; Sun, 21 Oct 2018 19:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E943420658
	for <selinux@archiver.kernel.org>; Sun, 21 Oct 2018 19:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRmS19Xg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E943420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeJVDiN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Oct 2018 23:38:13 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:37381 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbeJVDiN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Oct 2018 23:38:13 -0400
Received: by mail-lf1-f54.google.com with SMTP id a82-v6so28711613lfa.4
        for <selinux@vger.kernel.org>; Sun, 21 Oct 2018 12:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tmtjleuwHRZ+1FcGkGQb+pVGf3qJLeOgEsBSIWMOfXM=;
        b=WRmS19XgUlsUQR+kRNXZaWNfx1UwwThiP7jX5ZCE9nLbnOfDtD8mjYVWPAdUhYyJMa
         eR+za2twqIwJkde42VcQw3iS8OgiuqM7YmVxNPDjc3P5a24GcvCKFb0JwHHsW7s4Afh3
         mzZ82bZQisUayOiCDUOaq9KlaBeoMim97tgpZLRhvoepwEmKVJneJadp2XKfy2wrtpHe
         z5iEdhNiVLQC+7XRMVWAfsKDTiYVLPteyyp7BXHK2doQlrbfw7Co1gm21FifTB060ydp
         uicy3YFvtIfVn4bZpChKZ16j1l5MXE4oThzKXRcpwigNjJ46jdgPhVr5XT7rxJI1tyIW
         +rEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tmtjleuwHRZ+1FcGkGQb+pVGf3qJLeOgEsBSIWMOfXM=;
        b=liLB7YEzwgIHgdkJ44WnW1VfJAYvqtelF8Zv9avp/VOM14HbeOEK0nFdvqnhH0JqwO
         3pvqR50hGOxWTjgKT3TmBRqKGohpuqXaFw6/6a3vETqGq05QwTk03DvgmyKlnuBdVgXk
         n7cRZdHPdjxToXd3QCC/Jn3ll6DV1oGnH1wJeuvEtGhc72zsH5W1ct5tCaZ8UeFR/aL2
         Wx93kwcJQDSiS9elGjzwtfSqziUfIGJA8HtH4S0OG8ebcM84ykArYJmpWpc98uwsSoSi
         1WyzHu5Vb+b9LmmENuUmO+WQE8BJFx49aC9WjDUF8f60SRl/eXwvTAY4g7r569kY5z9p
         8JEQ==
X-Gm-Message-State: ABuFfojr8MTuvqlJf4v8bmq58xax2ncx6+2ry6YQQwbG/2513X0xlynA
        Uvmitg31asPIWmyzRu9mpPVWu4LTsK+bHptjqbzdmwCp
X-Google-Smtp-Source: ACcGV618m8vjAECtxsni8QKn4AmC56CeUupPQsQZ+mCk8OXFhBzEiS76Ogs+h9SoQE92xUwydfL4tDEoG9Fg6NUS1Kg=
X-Received: by 2002:a19:ec0a:: with SMTP id b10-v6mr8187922lfa.65.1540149771619;
 Sun, 21 Oct 2018 12:22:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9dc4:0:0:0:0:0 with HTTP; Sun, 21 Oct 2018 12:22:51
 -0700 (PDT)
From:   Mr Stid <stidofficiel@gmail.com>
Date:   Sun, 21 Oct 2018 21:22:51 +0200
Message-ID: <CAFWMVF3+Agy_98zPCUEuNWAT=K9a9nx0SWKJFZRRn1VY1Jw9eA@mail.gmail.com>
Subject: Fix snprintf truncated error
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

You can see my pull request on :
https://github.com/SELinuxProject/selinux/pull/106 for fix some
snprintf errors.
