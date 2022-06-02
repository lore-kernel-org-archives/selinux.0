Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33E1C43334
	for <selinux@archiver.kernel.org>; Thu,  2 Jun 2022 14:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiFBOla (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Jun 2022 10:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiFBOl3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Jun 2022 10:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2459B290BD5
        for <selinux@vger.kernel.org>; Thu,  2 Jun 2022 07:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654180887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C6m7e7UAiwyuRYxIetEmAMQEnYB4OwYuyAogSk7GvtM=;
        b=CLcrhIoEyMLjvOvwCZZGspCQrzhPVwPFG+R/29PO3GaLc4ctnVuxgmhWS1BQJNkLtofngl
        9K9WFBq9DDaHx5hTSOOBsL4vbwCfgMXkh0nZp4KzLU86LMWLlxEFO22CtKBykyii3niLKO
        MHuJP2DQK28vejoq1pkSi5I+UPHQGSI=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-RACrfSgVNiGOIJwnJyhdpQ-1; Thu, 02 Jun 2022 10:41:20 -0400
X-MC-Unique: RACrfSgVNiGOIJwnJyhdpQ-1
Received: by mail-yb1-f197.google.com with SMTP id v127-20020a256185000000b0065cbe0f6999so4250841ybb.22
        for <selinux@vger.kernel.org>; Thu, 02 Jun 2022 07:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C6m7e7UAiwyuRYxIetEmAMQEnYB4OwYuyAogSk7GvtM=;
        b=3k2ixCore2RikFIJwL+m+LSxq8hiFU4L/teTrQPICLIZA80thAP13AkEEo/ivQ4xZB
         s4NYLA7YhRVUIDWumiO3yG41vuuUZomkOHgw0lYEjEFqL1KIV7vHuBt7tlUddU3wXxxI
         a2NJ6PLjV7jmkFlt+BR3gIPFnmbJ8XGNgUSTrbPebj1x0yycDEW54/4VbHwdY0LVyIGF
         G5BYxPQ0UmviN7il+llmA8DuEjS17fq0kn2Ygw5fuy6Z0do68eRqXE8baMk64IndGe4w
         h2pImKkLOwvkfreHRQpKKG2qDbfEEQFUxnXXIWbOajzXyzjA+ZEwXD3PtKtEFH8MkR2K
         TVdA==
X-Gm-Message-State: AOAM530aDSsoMQWDQhYxv0mz2A77SOtFe4Llrc5575VGkEzy7mEc8cjp
        pnzqoPhxQSMZh9C5MR3IouT004AFak/wmM9wzOR/Dcp1zyqe+BLWywrzE4yWCzYzQAC6qVDvs6U
        G9FXMiqr8WnXr2pJmSJuMDmdkrvSd2YIOnQ==
X-Received: by 2002:a25:67c2:0:b0:65d:555b:8f59 with SMTP id b185-20020a2567c2000000b0065d555b8f59mr5407231ybc.240.1654180880346;
        Thu, 02 Jun 2022 07:41:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhJF0cisq7MZ4Cn15UKZM6X09vSqJ5A0dh1g4ArwUiuRqHr4dPAVK2Z383xBu4DDe8lJkWGjnd3N3ZHWyCtZg=
X-Received: by 2002:a25:67c2:0:b0:65d:555b:8f59 with SMTP id
 b185-20020a2567c2000000b0065d555b8f59mr5407218ybc.240.1654180880171; Thu, 02
 Jun 2022 07:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsO0HSqP2n3W_Su07LPggUm5_M1tGJBuJDW_VL-pWHOWw@mail.gmail.com>
 <CAHC9VhTqrPeqSFhBKNXvmyf-upN4L73qKSPxBSSRKa+3Ks3oPg@mail.gmail.com>
In-Reply-To: <CAHC9VhTqrPeqSFhBKNXvmyf-upN4L73qKSPxBSSRKa+3Ks3oPg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 2 Jun 2022 16:41:09 +0200
Message-ID: <CAFqZXNt=fbXMqDf++Vf3gxb3nZFyn0=6TCu5og6F0qzkegj8Hg@mail.gmail.com>
Subject: Re: Bug in SELinux SCTP ASCONF handling
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 1, 2022 at 1:54 AM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, May 31, 2022 at 1:05 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Hello everyone,
> >
> > Investigating the yet still spuriously failing SCTP ASCONF test [1]
>
> FWIW, I haven't seen failures with the SCTP tests when doing my
> testing, but perhaps I've just been lucky with the timing windows.

On a standard kernel it is very unlikely for the packet processing to
not happen in the server's context right after sending, but it
recently started to fail relatively often when testing CentOS 9 & RHEL
8 realtime debug kernels on a specific kind of machine (I wasn't able
to reproduce it in a local VM).


--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

