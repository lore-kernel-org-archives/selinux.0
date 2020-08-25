Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DFFC433E1
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 07:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C1E2076C
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 07:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHQoyEZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgHYHAo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:00:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729259AbgHYHA0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 03:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598338800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CD/R2YXDk7VvoUMwpokfjv4L8gFwuEH2P5rRSJT6vgw=;
        b=JHQoyEZS4QjQs1U8h/wsNy+NT4nDdvk/STw1P3Y/OdLCyd63gh9qVCY/2l/da4qVE968A9
        L2bDJbZwdSqGycZS8V2xSh3DvLx977RP2luGJyNhYWGJEa7QO+ENp9unRyqhP6igX7sfL7
        h/DroJRf2aX4XwzE2tF9EJfX4UvPDmU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-Qi9oIgr8NviQbaYlXPyIQw-1; Tue, 25 Aug 2020 02:59:57 -0400
X-MC-Unique: Qi9oIgr8NviQbaYlXPyIQw-1
Received: by mail-wm1-f71.google.com with SMTP id z1so576468wmk.1
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 23:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CD/R2YXDk7VvoUMwpokfjv4L8gFwuEH2P5rRSJT6vgw=;
        b=NRke4KbLJBMdXe4alEnnveKzgPeuv7b6RWHCyK7AzpH7Iu4kCd1dE9UpRRoJHN4pX0
         ymuqXEqUtMJ5vg1B73Ip01/vhW9Z+TGXLgz0yr9jTuVkFLH+E1AHwhg41hMrKtGZW4hr
         JESi8pbe4DPkpZUCfBGt5kGVUAi+qItWmNHf39XcSopCjVhL+Rrx7C5spj1S2QCQA613
         U3bSDjMla4jS1kPLzi8IoAFDpc5C56OiE0ik7Ydx9NvV9BTR1HoVk5ciq58esY0nklQB
         r5gmc8lR/x1/giklCbB5kxuILH6FeX5b4LqqN8mCQ8HgcaIlJ8thrcfhkgceGpwTrBrO
         3JZQ==
X-Gm-Message-State: AOAM531ATenQMZUGzXMwr5ug7835zYQL31BXeZqU0DWL7CjUhwjY6/Af
        jlH7LmWlQzt3EokA/n6ltDDBD6UqHaInEQY2gBNhHEBAOK/SHq6vEgp9LoH9QkZEOWlmNY4cB10
        g5K/aClRAka1cKVr2rw==
X-Received: by 2002:a7b:cc95:: with SMTP id p21mr539713wma.167.1598338795856;
        Mon, 24 Aug 2020 23:59:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnmzai7di+dmfN+b7pZEx9giLjFAgztqP2FJ52LwFA873panfvkFB52ZkDxtph0sLeNsQbdg==
X-Received: by 2002:a7b:cc95:: with SMTP id p21mr539698wma.167.1598338795661;
        Mon, 24 Aug 2020 23:59:55 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id h6sm28714644wrv.40.2020.08.24.23.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 23:59:54 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 0/2] selinux: Clean up GFP flag usage
Date:   Tue, 25 Aug 2020 08:59:51 +0200
Message-Id: <20200825065953.1566718-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series corrects a few places where GFP_ATOMIC was used instead of
GFP_KERNEL for no reason and removes the no longer needed GFP flag
argument from str_read().

v2: convert a few more occurences found in services.c

Ondrej Mosnacek (2):
  selinux: switch unnecessary GFP_ATOMIC allocs to GFP_KERNEL
  selinux: drop the gfp_t argument from str_read()

 security/selinux/hooks.c       |  6 ++---
 security/selinux/ss/policydb.c | 42 +++++++++++++++++-----------------
 security/selinux/ss/services.c |  4 ++--
 3 files changed, 26 insertions(+), 26 deletions(-)

-- 
2.26.2

