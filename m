Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9503FC433E0
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 19:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 672E1206D5
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 19:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbgEVTHq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 15:07:46 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:57503 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730871AbgEVTHp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 15:07:45 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E1962564699
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 21:07:42 +0200 (CEST)
Received: by mail-ot1-f41.google.com with SMTP id d7so9033772ote.6
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 12:07:42 -0700 (PDT)
X-Gm-Message-State: AOAM530N1xu6lA07QTrVvi3SXbmf4tWKdxGllkU49Z6V1yQRxrK5nkeG
        mU2y1JbbfSzRiqM/pj9pMuP2SL2jg0Ubi0aiaH8=
X-Google-Smtp-Source: ABdhPJwBnUltckWKEdau5eW+cwV4ygIZaReBWnEsA9/Rw261uitEv+Ds3G+Trf++/sOBdnuvpHB7hKl9Wuda8VWVz6s=
X-Received: by 2002:a9d:476:: with SMTP id 109mr11266234otc.96.1590174461703;
 Fri, 22 May 2020 12:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
 <20200520163421.27965-1-william.c.roberts@intel.com> <20200520163421.27965-2-william.c.roberts@intel.com>
 <CAJfZ7==gpPvF5eKJLFK=ky=UEXtbnX-r6WyB1zh6NfvRFHEHtA@mail.gmail.com> <CAFftDdpDpAw6W0d6OaCcaWYSO6g_zguO-D8u+fLYAW45nyGukA@mail.gmail.com>
In-Reply-To: <CAFftDdpDpAw6W0d6OaCcaWYSO6g_zguO-D8u+fLYAW45nyGukA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 22 May 2020 21:07:30 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mEC4hHT8AdPGhO7RoX+DUrO2y+7g_3OX-W2y09+uKKMA@mail.gmail.com>
Message-ID: <CAJfZ7=mEC4hHT8AdPGhO7RoX+DUrO2y+7g_3OX-W2y09+uKKMA@mail.gmail.com>
Subject: Re: [PATCH v2] ci: run SELinux kernel test suite
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri May 22 21:07:43 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 22, 2020 at 12:39 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> <snip>
> > * fedora-test-runner.sh uses ~, which is expanded to /root as it does
> > not make sense to run this script as non-root user. In my humble
> > opinion, using /root instead of ~ makes the script even easier to
> > read.
>
> I forgot to mention this in my previous email, this is the only thing
> I really don't
> want to change. You could, in theory, configure any user to run this.
>
> <snip>

The script executes "setenforce 0", runs dnf to install packages and
overwrites binaries and libraries in system directories (/usr/bin,
/usr/sbin, /usr/lib64, etc.). How do you allow any user to perform
these actions, without being root?

Anyway, if you do not want to hardcode /root, to could use "$HOME"
instead of ~. It makes things appear less magical, in my humble
opinion.

Nicolas

