Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55272C34053
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 15:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB062465D
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 15:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONVLy89d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgBSPnw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:43:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48496 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726605AbgBSPnw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 10:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582127031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=c2iaG5yaj/iP1M6YR0z6GfDo3G8l6YtRVKuRLUG2jsk=;
        b=ONVLy89dZdk/6ObpI3aXBMhqHoUeR6MFQe61vLZ2QYhNpubga80lz2FRWSmE6EljqUl0eb
        37f591ILpAnMkCwofstvhrJ7L99CbmCpc8p4KtUXtZMiHoLyXp9Xj3zWPJdtSGlqfTLoxv
        lNbsSSJNm1Bsftl0PyVOd3kNa0uzmhA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-deEIWC61M06Uj9p1JMXNCQ-1; Wed, 19 Feb 2020 10:43:49 -0500
X-MC-Unique: deEIWC61M06Uj9p1JMXNCQ-1
Received: by mail-wm1-f69.google.com with SMTP id o24so381169wmh.0
        for <selinux@vger.kernel.org>; Wed, 19 Feb 2020 07:43:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c2iaG5yaj/iP1M6YR0z6GfDo3G8l6YtRVKuRLUG2jsk=;
        b=nK1ji6hVg58Lqiaqx/Tv5Dx/CqRcQIBUATSataX5IcJykem4VyhN5bOR7hlrvcz4bx
         mimAnfvU2DViQa+E7XiEVCYvqQF21dUJLyGsNp66I76BUBnLkWhKuEyIo58DgCyDJJKW
         2SH2j11XTNuGoeNOsL3taURYWKj73nCc4Du7w+78lsALh9jlaEUCoyqhyfybYNvgn0d+
         HDgPZd/6pZmhQ+XAbmly5TqRgf62sAxGrcdOx+mX+OMn+BMiV39QGFRpR8rVukkxEdAN
         Ki+zsCrEQhPmEK4/zSl9GgQ4Eb8UfX3gioBbrjODKlb66QA+P/9wDxZAhi7Vqax+LUkc
         sHXA==
X-Gm-Message-State: APjAAAXyx8+/21CCYLwFRYrQW3xbgeQRcTfFmqTEY8yohVZ8xcsAL/o+
        eAbanE031pSdlZbX3Fuv/2UY4Vsm9JWjWU9SXQLW3PwBcfY7v4+kQQbRhT0aCIbUin2GNT0AMXn
        OJUiyxoB6tqMEPcaYpg==
X-Received: by 2002:adf:f80b:: with SMTP id s11mr38090156wrp.12.1582127024635;
        Wed, 19 Feb 2020 07:43:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqykh5iouNuKBoQXmVjdsDoldG+3YTbf02uv+SF1lO0JdWDGNblHBZz1cKAVEfbgj9ezrqNUjQ==
X-Received: by 2002:adf:f80b:: with SMTP id s11mr38090140wrp.12.1582127024414;
        Wed, 19 Feb 2020 07:43:44 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t9sm181591wrv.63.2020.02.19.07.43.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 07:43:43 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 0/2] libsepol: Grow hashtab dynamically
Date:   Wed, 19 Feb 2020 16:43:40 +0100
Message-Id: <20200219154342.240852-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The first patch is just a cleanup to have a single hashtab function that
can add elements, simplifying slightly the second patch, which
implements the actual auto-growing of hash tables.

Please see the log messages of the patches for more details.

v2: simplify entry insertion in hashtab_check_resize()

Ondrej Mosnacek (2):
  libsepol,newrole: remove unused hashtab functions
  libsepol: grow hashtab dynamically

 libsepol/include/sepol/policydb/hashtab.h |  28 -----
 libsepol/src/hashtab.c                    | 126 +++++++---------------
 policycoreutils/newrole/hashtab.c         |  85 ---------------
 policycoreutils/newrole/hashtab.h         |  28 -----
 4 files changed, 41 insertions(+), 226 deletions(-)

-- 
2.24.1

