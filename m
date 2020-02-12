Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D385DC2BA83
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 11:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BF02073C
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 11:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijhZjn87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgBLLXC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:23:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30488 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726146AbgBLLXC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Feb 2020 06:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581506580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eLF8OBHdTw0JfqkAXWlgthSWu/c1aN4z4XxYHWQvRf8=;
        b=ijhZjn87EFhPOawNOjWKB2xhMtlPxeb6QcqPc6wgN6K6kUmcBNGhtDmCgWP6a2wHRr5VWi
        HHFjC/30kgSaVnko090F3lNWVhxykmuhiVpQQvilmSLwYcmLCGN25uSCI7lbi1+qe/vMJZ
        BN0bdYnN/MM5IjXT5fhbFhhwVgUzBpw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-FXvxwtyZMhy48wZBudJKDw-1; Wed, 12 Feb 2020 06:22:59 -0500
X-MC-Unique: FXvxwtyZMhy48wZBudJKDw-1
Received: by mail-wr1-f70.google.com with SMTP id r1so678457wrc.15
        for <selinux@vger.kernel.org>; Wed, 12 Feb 2020 03:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eLF8OBHdTw0JfqkAXWlgthSWu/c1aN4z4XxYHWQvRf8=;
        b=YlwwP1IxCWp4p0K4Ub721tnx5h3cblCcGkuwoj9PTy8xjL6R5z2Ij/xOT8Gghzhz8L
         tEobCgpy03YczwBV5cHFUBvPc/OQ0OtvozUFGas5wlGanAkbHTkzXxrpbjF1+I7Q379X
         ClV2cKaqSYFZMg+ayTPvx3rIoSFF050u9nOmtv845KahCEUBh0eZGuQnjdRT5vsw6o9X
         PmDSCG0U65VnsAYsszDsvwHCh9q1Xlmw2RAiMwditDrZTEkuAC/slaCdJSHHqcvGFYJC
         EVQd69iutGwxd6XFbBBWEmBdJUv6+2O8uRgV6b3V0KgSJELLtkNbLqtQnqRapBpQaZ44
         /B+Q==
X-Gm-Message-State: APjAAAXgyzrFm+6f4fWgv8FAWinMM19QjeleCJFii0aO/kCrWAA10S1b
        CgqR/Pqi5jd4x0nRIKw5LAtdzAn9XmOWNEpgm/fXyTBcHOc0AAqp0YJDssTMS0xvMxUzinSV3US
        nwuCi7mmkGcZguzNAcg==
X-Received: by 2002:adf:81c2:: with SMTP id 60mr14422120wra.8.1581506578247;
        Wed, 12 Feb 2020 03:22:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwAux1bBSt4xU73FdGwFp+NRa4uXdUIjAlTOvMIkJsPQgBl/LzadGuzUsuCufl5qCcpZXz/6Q==
X-Received: by 2002:adf:81c2:: with SMTP id 60mr14422094wra.8.1581506577955;
        Wed, 12 Feb 2020 03:22:57 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c9sm282160wmc.47.2020.02.12.03.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 03:22:57 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2 0/2] Optimize storage of filename transitions 
Date:   Wed, 12 Feb 2020 12:22:53 +0100
Message-Id: <20200212112255.105678-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series improves the computational and memory efficiency of filename
transition rules in SELinux. The first patch is only cosmetic, see the
second patch for more details about its effects.

Changes in v2:
 - removed unnecessary assigment of 'last'
 - renamed 'exists' variable to 'already_there' which is more clear
 - added more likely/unlikely annotations (there will almost always be
   just one datum per key)

Ondrej Mosnacek (2):
  selinux: factor out loop body from filename_trans_read()
  selinux: optimize storage of filename transitions

 security/selinux/ss/policydb.c | 225 +++++++++++++++++++--------------
 security/selinux/ss/policydb.h |   8 +-
 security/selinux/ss/services.c |  16 ++-
 3 files changed, 146 insertions(+), 103 deletions(-)

-- 
2.24.1

