Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13996C43334
	for <selinux@archiver.kernel.org>; Thu, 30 Jun 2022 17:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiF3RDL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiF3RDK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jun 2022 13:03:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8111D7
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 10:03:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g26so40204402ejb.5
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxe9kae+x9KUsXxKF/JWDQxftw5rSR0Eq7r60UFQZYc=;
        b=DFP8mWU2MAIef9uuvtvxyuWvhHWPTBSmbCNFyuc6Cod4NEJGFN36tc9g28fe5tHt9n
         qjNeuaAYPCWZV6uBscLQf1Z82mpAJM/m+zHTRZH2tou4jlqH9Iq/ko/Er9zl5Qr93KR5
         OYcbS3ZDmWrb/SznufNoSLDHncgJ4NaNLhTp9dW3AZpdOvy7MHdzj93rZBtgHx2vcMmY
         QNZQROsEnHi2WBsDSWhFPLmRxwCB+EwR7+vV1xx6ae3lbSjLy7VUdBPuWrVQQdr30ao1
         CESBc7H1JHFh/0ViMz0fE+k9bQvj/pzcUq6Pfphuhi1D7vm9OTq0aZVghcAr+zmzu6/c
         2N7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxe9kae+x9KUsXxKF/JWDQxftw5rSR0Eq7r60UFQZYc=;
        b=aoA9GSn801vY8sQLt8f1ub7sbmmfgFTw0uH6KiNRkV+WOCvGVqu+ONuj7QLLkMMQGV
         cY6YhPVSGQw4XPsXplVOyN9YnACbyHAtQC/TUEcea7ao40PB6fyc8EdKVzuXbXCKHm93
         dnrSv+LKJRSB+e1yjx1S6ZShZi8b3wf97GBR7CNMaqBau/LjLjSLvILs0SmmhuLZ0wdm
         o9tl9g1nkzANacYuMz2SyKEG2M/w0gNC/GiZ7+Z3aRjwd28IirSXWLfkP2B6BhftErtf
         3c8gIkP6pwI/15Re39HD7kc+ufyQF7CdcA1hkb7StgVjLo932sl6EjsRquhq36i9qzXN
         LheQ==
X-Gm-Message-State: AJIora+caFTQXypLI1lFcDY2FLVDyPFMFUDgcRK0Q4DfG02lfW8xMBoF
        hfvkLBmtXYKmB0mPqsHI8KsQvzcE13fUtA==
X-Google-Smtp-Source: AGRyM1toz2+lAZVs8bbsqYI4LdF6mGUrhhAYCJJ9AKgRSQr+5d4+XbJz1Si+UPQmM7lfoF0PuDE52g==
X-Received: by 2002:a17:906:72cd:b0:722:d84b:30e3 with SMTP id m13-20020a17090672cd00b00722d84b30e3mr10036470ejl.726.1656608587424;
        Thu, 30 Jun 2022 10:03:07 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-187-037.77.3.pool.telefonica.de. [77.3.187.37])
        by smtp.gmail.com with ESMTPSA id m9-20020a509989000000b004355d27799fsm13822581edb.96.2022.06.30.10.03.06
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 10:03:06 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: do not modify policy during write
Date:   Thu, 30 Jun 2022 19:03:01 +0200
Message-Id: <20220630170301.4431-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not modify the in memory default_range value of a class datum while
writing a policy.

While on it fix indentation.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/write.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 48ed21ea..a9fdf93a 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1097,16 +1097,18 @@ static int class_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 	     p->policyvers >= POLICYDB_VERSION_NEW_OBJECT_DEFAULTS) ||
 	    (p->policy_type == POLICY_BASE &&
 	     p->policyvers >= MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS)) {
+		char default_range = cladatum->default_range;
+
 		buf[0] = cpu_to_le32(cladatum->default_user);
 		buf[1] = cpu_to_le32(cladatum->default_role);
-		if (!glblub_version && cladatum->default_range == DEFAULT_GLBLUB) {
+		if (!glblub_version && default_range == DEFAULT_GLBLUB) {
 			WARN(fp->handle,
-                             "class %s default_range set to GLBLUB but policy version is %d (%d required), discarding",
-                             p->p_class_val_to_name[cladatum->s.value - 1], p->policyvers,
-                             p->policy_type == POLICY_KERN? POLICYDB_VERSION_GLBLUB:MOD_POLICYDB_VERSION_GLBLUB);
-                        cladatum->default_range = 0;
-                }
-		buf[2] = cpu_to_le32(cladatum->default_range);
+			     "class %s default_range set to GLBLUB but policy version is %d (%d required), discarding",
+			     p->p_class_val_to_name[cladatum->s.value - 1], p->policyvers,
+			     p->policy_type == POLICY_KERN? POLICYDB_VERSION_GLBLUB:MOD_POLICYDB_VERSION_GLBLUB);
+			default_range = 0;
+		}
+		buf[2] = cpu_to_le32(default_range);
 		items = put_entry(buf, sizeof(uint32_t), 3, fp);
 		if (items != 3)
 			return POLICYDB_ERROR;
-- 
2.36.1

