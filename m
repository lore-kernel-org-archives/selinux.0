Return-Path: <SRS0=NQFP=7X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C35C433E0
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 21:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A60CB2072E
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 21:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDBaKRt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgFJV5Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:57:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22040 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJV5X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Jun 2020 17:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591826242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=VtM0DL68Z0YFosoxESBYhFToC2wio2RnB4Rs6A9Gq0Q=;
        b=PDBaKRt8MdOMk4G8S+3Mi9CmMg7+oSIi122aKidYZ5bQTEUPHqbVhH3h7rQFv7N4rJd9cr
        0kV4echZL8x7c/UPmcnoy0I5jf+0r9ku31vQa8PqCCDFBEQY1cxr4UC7KmYX0QaCrULTZZ
        i8aT51EdnqPpSU2EDejjkYw0k+IXkq8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-2Te5aIlHNGOx0HbJqfsTSA-1; Wed, 10 Jun 2020 17:57:21 -0400
X-MC-Unique: 2Te5aIlHNGOx0HbJqfsTSA-1
Received: by mail-qv1-f71.google.com with SMTP id s15so2916662qvo.6
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2020 14:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VtM0DL68Z0YFosoxESBYhFToC2wio2RnB4Rs6A9Gq0Q=;
        b=M26K5apPYeQlr6RjUmTtJS3eMF4SreJSZFju4JLajhb+mAuGKGsAKNHuRKKwNB5cLu
         XkTiDIn87hOne1HH0nXBG9lLz0juS1CCq74Nr5tKGBeNR6jVPC5V0nFVDHcWhl3bbkmF
         rg9dhPKhz5TYlqHilQpgcKQNMAcEq2IB8joKxhak3VGWlG91jE9nocTL4zMoK7lpRbhU
         pGnoF4XvZps11At1BDybwHdgi69eMfKIBV4QzxDRcPxymqZW3PPHKs7sx1sRZQ5EBPbF
         iy6ipPoCUb3J7Dq+6LdJDQAlNESrCyQp4rmx3/RTNZssvYGAklfgYqTpgstitisA4Lj/
         o4Kg==
X-Gm-Message-State: AOAM531elrBWCk1x9WNRWoPOCkCeK2eRUDwNhvpyAQw5HsS0gIztzhx7
        WrvNYIW80sljSukW51TbzZXiYzZhThO1LjrWqgttF5eXtR140+MTgnQx5zScHnf7yld5f6bvVAf
        ztMnfjjcSJGlpt5ehag==
X-Received: by 2002:ac8:724c:: with SMTP id l12mr5577987qtp.259.1591826240758;
        Wed, 10 Jun 2020 14:57:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUGaUnW2MRK/CuEdTtnHZ83OpYSRBECQomqVsEp7ut6CzN65E6n+gKJs8MBh4jIgj4Z8QUqw==
X-Received: by 2002:ac8:724c:: with SMTP id l12mr5577972qtp.259.1591826240578;
        Wed, 10 Jun 2020 14:57:20 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t13sm934883qtc.77.2020.06.10.14.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:57:19 -0700 (PDT)
From:   trix@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, omosnace@redhat.com, jeffv@google.com,
        rgb@redhat.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/1] selinux: fix double free
Date:   Wed, 10 Jun 2020 14:57:12 -0700
Message-Id: <20200610215713.5319-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Tom Rix <trix@redhat.com>

repo: linux-next
tag: next-20200610

Running clang scan-view over linux-next uncovers many problem only a
few are memory related, this one looked like the most serious.

Changes from v1

Fix call to kfree
-		kfree(names);
+		kfree(*names);


Tom Rix (1):
  selinux: fix double free

 security/selinux/ss/services.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.18.1

