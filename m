Return-Path: <SRS0=NQFP=7X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9046C433DF
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 18:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE9A206F4
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 18:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iikiN/nz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgFJSKc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:10:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44295 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbgFJSKc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Jun 2020 14:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591812631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=74sBb+yxIp+tJHGKwpQ6iTCCpQrRwqCUIhMJtvCFJYM=;
        b=iikiN/nze1zJQ7J2/P9oWlDbLjVfYn7g1OBbuuBkPCijCZMAeDNwRZbnJgYHL4PYCZcSzv
        0t27YghHjWPMFCYIKfPvJPVrIYD8axPaoz7dAtjfCRNJm0VwbLtyuA6RUrKFC/FYTIUJEL
        DJJjyey1ov9nP1W+jBHf3gHwVqR6ph4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-eb1R6mhxMBuYlqVcfcC4Gw-1; Wed, 10 Jun 2020 14:10:29 -0400
X-MC-Unique: eb1R6mhxMBuYlqVcfcC4Gw-1
Received: by mail-qv1-f72.google.com with SMTP id s15so2483999qvo.6
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2020 11:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=74sBb+yxIp+tJHGKwpQ6iTCCpQrRwqCUIhMJtvCFJYM=;
        b=b9S37cokm3sFhxXDpm28Jo9yE+NtCU04PTkHT8RqXWkAtclF3XC7m2egheMyspbXBJ
         RyRALWLcejic1RrPxbWyAPdzxNPM7TSSLRhmARTaH9wJ+cDWnZ8NRYBDnNYK1W/UVDwD
         0j6eCC+9mZQF9LDTxdRivwvmekytjQ6ClvW9Q8y5wI6qHM7rbHojYPUBM+aghrT4yBVA
         ttShupKlvkThxIbqCC757572aY3pnn2xcGu4Ft00uHlyaoNQPo8gPq2gU6wvFf5bLAOV
         2L5UQGvDltATQviz2qcWEShe0vxW2jUpKy2/9TqPsKDtM6oqkuzFrwHPK7WAOLgMDK3e
         RIkg==
X-Gm-Message-State: AOAM533qU5h8IQXug9BnRwRiEAaWnXH9MHgkC2+C3RmS47y+qAz1Z7UO
        3rzVWbfW1803gB1Oso41PMWgxEdZ9rdEf1xGZ9yvFRojMi14V0/01KuNNjh4Jo+XaXHOctfSGSC
        ecWKf1QOxpxgUKjyU1Q==
X-Received: by 2002:ae9:ed4c:: with SMTP id c73mr4376644qkg.309.1591812628977;
        Wed, 10 Jun 2020 11:10:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEaMK2wTrmwuS0DisPNUk+/CQtYQCLvOThCsH3bZsWrmkNzuZQ9rHWGQ2cnmbOk4hRyYZaXg==
X-Received: by 2002:ae9:ed4c:: with SMTP id c73mr4376624qkg.309.1591812628790;
        Wed, 10 Jun 2020 11:10:28 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w13sm339047qkb.91.2020.06.10.11.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 11:10:27 -0700 (PDT)
From:   trix@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, omosnace@redhat.com, jeffv@google.com,
        rgb@redhat.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 0/1] selinux: fix double free
Date:   Wed, 10 Jun 2020 11:10:20 -0700
Message-Id: <20200610181021.19209-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Repo: linux-next
Tag: next-20200609

Running clang scan-view over linux-next uncovers many problem only a
few are memory related, this one looked like the most serious.

Tom Rix (1):
  selinux: fix double free

 security/selinux/ss/services.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.18.1

