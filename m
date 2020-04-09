Return-Path: <SRS0=zGJ6=5Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873AEC2D0EA
	for <selinux@archiver.kernel.org>; Thu,  9 Apr 2020 08:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AC32075E
	for <selinux@archiver.kernel.org>; Thu,  9 Apr 2020 08:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBOLufIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgDIIMz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:12:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55773 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbgDIIMz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Apr 2020 04:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586419975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JQLRyNEjWiQcnKWGbCq9vc8VJUmbYHYj1lYCIfCRaVs=;
        b=iBOLufIG4b5DE9xeTWYYtjsetPfcKwPliVmD64n8NcGsBUhCxStlXzEHvyw5KzkhNxdxoD
        Wo0pCOorJpMPGRRaN0u4QaLB53eak9RMt1C/oougpSfKayVn8jtAzl8V6Ferp/lgolpBkZ
        SgHJPpfQT2NkIwuicJqZCyR4bwZ1E7c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-B9Q01YcBPjyBXeE53peFhg-1; Thu, 09 Apr 2020 04:12:53 -0400
X-MC-Unique: B9Q01YcBPjyBXeE53peFhg-1
Received: by mail-wr1-f71.google.com with SMTP id j12so5932627wrr.18
        for <selinux@vger.kernel.org>; Thu, 09 Apr 2020 01:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JQLRyNEjWiQcnKWGbCq9vc8VJUmbYHYj1lYCIfCRaVs=;
        b=fdXrbCnunA3zFXEcXit0vJ2NO0BulG/rzT+kSpoolq6pem34ieG+qnxNT6vuORarlo
         Rnd7v2hjmfwhSk1G78maxQTeDeZOmMxDHPwKjV2fQgPn38AEfIpMkqCUA9erxymhwYhL
         elG1XSBBSbHJJ3iak6+bsKWDa7O8OR8rVGtEtpQefVwQP+K36gkYcZtmI21fsLLgUAYQ
         FVR6VaEJ3UIXoxVq4RJ0HsjUokAbmNa2IG58IQgernmKXDSzXjnwir3Y2vL4A33auK/0
         1qHwHFZHEeiBfqwKQCombludKxoqamemkcx+cORuRXWFcM6qeNMD5qwb4FRS2V1NVTOB
         vZXg==
X-Gm-Message-State: AGi0PuZ28qIbh2TVAjTOCh2xjJCaaFDe38AjEy/nC5gypYL/m//c6ZXm
        HGIe7XgRdSRD+tcPgzYNww9PWbMxnM3BHDfFkAsvqoXReZwS+Mr78XhkeJ0UGIvLL3KCmMAmHPe
        m3WBIgxBqEenYztSqFA==
X-Received: by 2002:a7b:c213:: with SMTP id x19mr3828385wmi.53.1586419971747;
        Thu, 09 Apr 2020 01:12:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypIfDCPdJHOUfNgoAw2DP6aDuIVGwvAdtN+09gYazTMGdcS8KjI1vxVAyksD+bVqGmGuFAsglQ==
X-Received: by 2002:a7b:c213:: with SMTP id x19mr3828375wmi.53.1586419971526;
        Thu, 09 Apr 2020 01:12:51 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id a7sm2772782wmj.12.2020.04.09.01.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 01:12:50 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Jeff Vander Stoep <jeffv@google.com>
Subject: [PATCH 0/2] Hash context structures directly
Date:   Thu,  9 Apr 2020 10:12:46 +0200
Message-Id: <20200409081248.1273383-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Converting a valid context to string and hashing that is inefficient
because the conversion is slow. Instead we can hash the stucture
contents directly, which is about 10 times faster.

After that, it is possible to move the hashing under sidtab.c, which
avoids the complexity of calling context_add_hash() all over the place.

Ondrej Mosnacek (2):
  selinux: hash context structure directly
  selinux: move context hashing under sidtab

 security/selinux/Makefile      |  2 +-
 security/selinux/ss/context.c  | 28 +++++++++++
 security/selinux/ss/context.h  | 11 +----
 security/selinux/ss/ebitmap.c  | 14 ++++++
 security/selinux/ss/ebitmap.h  |  1 +
 security/selinux/ss/policydb.c |  5 --
 security/selinux/ss/services.c | 86 ++++++++++------------------------
 security/selinux/ss/services.h |  3 --
 security/selinux/ss/sidtab.c   | 32 ++++++++-----
 security/selinux/ss/sidtab.h   |  1 +
 10 files changed, 92 insertions(+), 91 deletions(-)
 create mode 100644 security/selinux/ss/context.c

-- 
2.25.2

