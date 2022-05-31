Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B397C433F5
	for <selinux@archiver.kernel.org>; Tue, 31 May 2022 17:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346405AbiEaRFg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 May 2022 13:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346361AbiEaRFb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 31 May 2022 13:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6D108DDFC
        for <selinux@vger.kernel.org>; Tue, 31 May 2022 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654016728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=zBX5BP2y8Sze4CHpzErgdDRBehEarujA7AsSYXEBvtM=;
        b=T2FaEaylWFaze2QHXUJbYt9NHw2FTHUxPeHWKpFYASiyEeOUWs6BCr+wYwPEI6Bk4GGomi
        6gceSFW7bptSbIc/1vZRq8hPk60vxahGynUI9DLFVKvXsi+uADh/Ld5Q7XqAd2dL+G+VHL
        d3mfCciklxOgCwc97UpbkApF44Krc2g=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-GqIRUiP8PNeqqeNjvQ518A-1; Tue, 31 May 2022 13:05:27 -0400
X-MC-Unique: GqIRUiP8PNeqqeNjvQ518A-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-30047b94aa8so120167697b3.1
        for <selinux@vger.kernel.org>; Tue, 31 May 2022 10:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zBX5BP2y8Sze4CHpzErgdDRBehEarujA7AsSYXEBvtM=;
        b=HA/Dy124ElB/xbYtrOqNPurwVtyvBtNm/KY8EdEbSyoCrqh+lYfTkQn34T6YrwSZfT
         OjqvkavYfiMgHEJCfxa1MydNhGUtH/YWXlPzGf1Y1KFWbHaPkGyX74uobFd3nNwJxFaO
         BEW3RvrH4w286XJU2gI2gwumjKz1vqeumhVRA09Bu52kqhuicRZA0JCOQd2RTGBKYcEO
         nyagtv9HBIa6BHyFmi3+0BpsKCnq4aJczHMLB51EqLFGNxi71urFQkeuHWg49GZLzfto
         u1G739Bgcuw69UEthUqQW5uItWcneXgX53h9EzH5DYyKucHBz3NTi/pN0jxspMOLREyC
         cOZg==
X-Gm-Message-State: AOAM531rfXrWg4VdSl9njzuCa2elsZfcL2wYW/v8Dmyd5kmI8LxebyzC
        qfN6wx4fFKTyTnzywiaqhPxjBxW8kB3BOIsukwLLuIp/fqw/uibPA27Gx4Cmjx5iIQzLZwBVU98
        HRw/NCpPEtx8hAN8C7lc4YfwZu5e9bzO/eg==
X-Received: by 2002:a81:a50c:0:b0:30c:1f68:a375 with SMTP id u12-20020a81a50c000000b0030c1f68a375mr17359722ywg.106.1654016726095;
        Tue, 31 May 2022 10:05:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXUM7KChK635Ed/g8jlMB6NT7ifrJKP9ot/9t4kqD1OS6GrZtcQmWqpTmGDGf/GywfZR96zxRNqeouYCyjOXg=
X-Received: by 2002:a81:a50c:0:b0:30c:1f68:a375 with SMTP id
 u12-20020a81a50c000000b0030c1f68a375mr17359700ywg.106.1654016725922; Tue, 31
 May 2022 10:05:25 -0700 (PDT)
MIME-Version: 1.0
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 31 May 2022 19:05:14 +0200
Message-ID: <CAFqZXNsO0HSqP2n3W_Su07LPggUm5_M1tGJBuJDW_VL-pWHOWw@mail.gmail.com>
Subject: Bug in SELinux SCTP ASCONF handling
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello everyone,

Investigating the yet still spuriously failing SCTP ASCONF test [1]
has led me to realize that the SCTP_PARAM_* chunk handling is in fact
severely flawed. The SCTP_PARAM_* code paths reuse the
security_sctp_bind_connect() hook, but that hook uses the current
task's sid when checking the socket::connect permission, which is not
correct, since there is no guarantee on the task context in which the
incoming ASCONF packet will be processed.

The relevant selinux-testsuite test [1] expects the subject sid to be
the one of the server, which has been true only by accident, as SCTP
often processes the incoming ASCONF chunk via softirq right after it
is sent.

This seems tricky to fix, as we don't have any appropriate subject
context at hand at the time of receiving the ASCONF chunk... Any
ideas?

In the meantime I intend to remove the problematic test from the
testsuite as it is currently impossible to define the expected subject
context...

[1] https://github.com/SELinuxProject/selinux-testsuite/blob/378fd34e70753aec709c9de533966775d917b585/tests/sctp/test#L290-L307
--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

