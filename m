Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889A5C433ED
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 14:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3489F613B5
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 14:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhELOd2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 May 2021 10:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20890 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230347AbhELOd1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 May 2021 10:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620829939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=k6WjGNdVI5s/XueA7H3RfaiFy6KCgOR9zOfxHuJsUe4=;
        b=fnYtpAqpMieIh8O25lHoKvldVOeX+0VvAQdIIvj1Ta/lvR03PcEJTyfqrPQqUfvR35R/gs
        MxztLmKD2tyiVFx6VdMkW5if8G4tDi1QiaBkMCQF/WP3Bn32aui1+sLXRxzX3/AR1UmV7A
        0bnEmAPv5xNrTkdSJT2qA4iwINvwvfw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-_l27G5i6PdGHPuwj19Qv9Q-1; Wed, 12 May 2021 10:32:14 -0400
X-MC-Unique: _l27G5i6PdGHPuwj19Qv9Q-1
Received: by mail-ed1-f71.google.com with SMTP id d18-20020aa7d6920000b0290388b4c7ee24so13038391edr.12
        for <selinux@vger.kernel.org>; Wed, 12 May 2021 07:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k6WjGNdVI5s/XueA7H3RfaiFy6KCgOR9zOfxHuJsUe4=;
        b=aSbmOESVM8cByK0NkbUjrQppbc26Le25t3kHkcwA/j9xAcyF0SwmySh9CWBl4K045V
         a+SAGG4ax2lZhyAGIbvn/5WDNc3sEnbURK5XCwg4BoeSlVe9DaWjc2JKKp02copAqcA6
         r0fypCzGtdRExGoZcghNnncPmT/Bgaict9RW1rYQZG97ZNXLyVfSUxpuwz5nNIPeHcuJ
         0gPlzFnTPagrovIHu4sl+j0Ke0lIzgliVyqZRfBFhaAsxTLsmXH3SlLFu9jqoAJe/DAP
         nmBJ/qA8+H/r0VY8/EyPzYmVmJtnTeRzVOkziZoheRU7aVQa4AprJhmQvQUG1bAJq4j3
         CxKw==
X-Gm-Message-State: AOAM530uXlnH8EaFinU58WcykS3m0vSPdUUeUryFGXAaFZXGmBFShl38
        5HRd/J15CgMWt+ImWCEEaMQbLeCmFoclZfTC4CFOPS0gcXNAjPagnoDuYF7e/fmxRnPycUgEN+k
        w9FrIkT+IJuCi0lb6t/psJzWmAGFKMhVMpLQXqy08RKL6pQfVsRJNEoIC3EZ8+0kWxixMAw==
X-Received: by 2002:a17:906:edaf:: with SMTP id sa15mr638484ejb.174.1620829933192;
        Wed, 12 May 2021 07:32:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvW62KAq0mgD50KcxlTXW8iq3RcS0AfwbEADXLl4Dvq584PEnqYDFi2JR61u7TNCmOqOPphw==
X-Received: by 2002:a17:906:edaf:: with SMTP id sa15mr638462ejb.174.1620829933001;
        Wed, 12 May 2021 07:32:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id h9sm17265749ede.93.2021.05.12.07.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 07:32:12 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com
Subject: [PATCH v2] lsm_audit,selinux: pass IB device name by reference
Date:   Wed, 12 May 2021 16:32:10 +0200
Message-Id: <20210512143210.248684-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

While trying to address a Coverity warning that the dev_name string
might end up unterminated when strcpy'ing it in
selinux_ib_endport_manage_subnet(), I realized that it is possible (and
simpler) to just pass the dev_name pointer directly, rather than copying
the string to a buffer.

The ibendport variable goes out of scope at the end of the function
anyway, so the lifetime of the dev_name pointer will never be shorter
than that of ibendport, thus we can safely just pass the dev_name
pointer and be done with it.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_audit.h | 8 ++++----
 security/selinux/hooks.c  | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

v2: just pass the dev_name pointer and avoid the string copy

v1:
https://lore.kernel.org/selinux/20210507130445.145457-1-omosnace@redhat.com/T/

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index cd23355d2271..17d02eda9538 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -48,13 +48,13 @@ struct lsm_ioctlop_audit {
 };
 
 struct lsm_ibpkey_audit {
-	u64	subnet_prefix;
-	u16	pkey;
+	u64 subnet_prefix;
+	u16 pkey;
 };
 
 struct lsm_ibendport_audit {
-	char	dev_name[IB_DEVICE_NAME_MAX];
-	u8	port;
+	const char *dev_name;
+	u8 port;
 };
 
 /* Auxiliary data to use in generating the audit record. */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 92f909a2e8f7..4d9764dad18f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6864,7 +6864,7 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
 		return err;
 
 	ad.type = LSM_AUDIT_DATA_IBENDPORT;
-	strncpy(ibendport.dev_name, dev_name, sizeof(ibendport.dev_name));
+	ibendport.dev_name = dev_name;
 	ibendport.port = port_num;
 	ad.u.ibendport = &ibendport;
 	return avc_has_perm(&selinux_state,
-- 
2.31.1

