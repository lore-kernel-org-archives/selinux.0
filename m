Return-Path: <SRS0=gk/B=V5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACD0C433FF
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 14:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B60A20838
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 14:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfHAOCs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:02:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53006 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730581AbfHAOCs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Aug 2019 10:02:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so64754125wms.2
        for <selinux@vger.kernel.org>; Thu, 01 Aug 2019 07:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bPITu1xJUcsyVUAunfEJ+7STRoUC8YhgbJi6vG+X1/s=;
        b=cCyaKyk+NyJYztMLDg2YctIMZfp4Az1awUXuLtWP8o6u2KqPl9vqyGNNR4j1qOLud5
         pKN3I60uQ/Y6oXTdlUucRPVb/HOCIgRLY9+4YgHmTjxu6f3An3Q+5BJPea5txOfqIxcj
         zDrf+8vnD9t1kQL0LE4k8JN2Dl1GiXXVIKMc3MtFAvFgWfBWvfY/u/NrXyKEPZryPI/X
         hPkT9/iRlqQGCKjYBNg++YMQ271r9vStS9PbZG8rAACmh3+PEOpCxmWi86xfDG3TthEC
         1yAHB8R5RfIkFTPidykwyu7cY/1UlNIeYFGoc64FobOKmzP02dTEenWSDBjL9zeZYM87
         8Ywg==
X-Gm-Message-State: APjAAAUfbZx2YIAzoR+Eg6IBv7xBBZFHnrVw0iWQWl6r6wCoasQ4kMA1
        KPrktydKJp77PzE60zm5ARB85xFnIs0=
X-Google-Smtp-Source: APXvYqx/FgRtIl2NkzGCN3MQeLmf/HhINWWXFafkm+lfRM01MDOpX+XVKqJWk+aKHTQG3EQIAM19og==
X-Received: by 2002:a05:600c:2182:: with SMTP id e2mr51998743wme.104.1564668166166;
        Thu, 01 Aug 2019 07:02:46 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z7sm69909162wrh.67.2019.08.01.07.02.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 07:02:45 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/4] selinux: fix race when removing selinuxfs entries
Date:   Thu,  1 Aug 2019 16:02:39 +0200
Message-Id: <20190801140243.24080-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

After hours and hours of getting familiar with dcache and debugging,
I think I finally found a solution that works and hopefully stands a
chance of being committed.

The series still doesn't address the lack of atomicity of the policy
reload transition, but this is part of a wider problem and can be
resolved later. Let's fix at least the userspace-triggered lockup
first.

Changes since v1:
 - switch to hopefully proper and actually working solution instead
   of the horrible mess I produced last time...
v1: https://lore.kernel.org/selinux/20181002111830.26342-1-omosnace@redhat.com/T/

Ondrej Mosnacek (4):
  d_walk: optionally lock also parent inode
  d_walk: add leave callback
  dcache: introduce d_genocide_safe()
  selinux: use d_genocide_safe() in selinuxfs

 fs/dcache.c                  | 87 +++++++++++++++++++++++++++++++-----
 include/linux/dcache.h       |  1 +
 security/selinux/selinuxfs.c |  2 +-
 3 files changed, 77 insertions(+), 13 deletions(-)

-- 
2.21.0

