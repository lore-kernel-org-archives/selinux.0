Return-Path: <SRS0=arMl=CG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDD9C43461
	for <selinux@archiver.kernel.org>; Fri, 28 Aug 2020 16:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A99208C9
	for <selinux@archiver.kernel.org>; Fri, 28 Aug 2020 16:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KyS3Wibp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgH1QAs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:00:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44728 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgH1QAe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Aug 2020 12:00:34 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1A8A520B7178;
        Fri, 28 Aug 2020 09:00:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A8A520B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598630432;
        bh=9nE+PsjwfQS+D6IahYRzHVUgseWRlLvBJtDDOfDrxAE=;
        h=From:To:Cc:Subject:Date:From;
        b=KyS3WibpFvtlwHm9qmDOeuHV6J8X1UW0M7WHcB4XY8VbYwqwghFXQ2/31MUX37SRx
         md4w+ZOsPBj5HS9qfAzMWriNx2XL/4H+jAMD9aKjxTx/fS0eckBshhUMr91wasM+cQ
         7IeDsrf6tl//9XoOpWnsKNz4F3V7QrTBrIByFF6k=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] IMA: Generalize early boot data measurement
Date:   Fri, 28 Aug 2020 09:00:18 -0700
Message-Id: <20200828160021.11537-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The current implementation of early boot measurement in the IMA
subsystem is very specific to asymmetric keys. It does not handle
early boot measurement of data from other subsystems such as
Linux Security Module (LSM), Device-Mapper, etc. As a result, data
provided by these subsystems during system boot are not measured by IMA.

This patch series makes the early boot key measurement functions generic
such that they can be used to measure any early boot data. The functions
in ima_queue_keys.c are refactored to a new file ima_queue_data.c.
The kernel configuration CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS is renamed to
CONFIG_IMA_QUEUE_EARLY_BOOT_DATA so it can be used for enabling any
early boot data measurement. Since measurement of asymmetric keys is
the first consumer of early boot measurement, this kernel configuration
is enabled if IMA_MEASURE_ASYMMETRIC_KEYS and SYSTEM_TRUSTED_KEYRING are
both enabled.

The IMA hook to measure kernel critical data ima_measure_critical_data()
is updated to utilize early boot measurement support.

This series is based on the following repo/branch:
 repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 branch: next-integrity
 commit d012a7190fc1 ("Linux 5.9-rc2") 

This patch is dependent on the following patch series:
	https://patchwork.kernel.org/patch/11709527/
	https://patchwork.kernel.org/patch/11742047/

Change Log:
  v2:
    => Split the patches to first rename the file and functions,
       and then introduce new arguments, followed by adding queuing
       support in ima_measure_critical_data().

Lakshmi Ramasubramanian (3):
  IMA: Generalize early boot measurement of asymmetric keys
  IMA: Support measurement of generic data during early boot
  IMA: Support early boot measurement of critical data

 security/integrity/ima/Kconfig               |   2 +-
 security/integrity/ima/Makefile              |   2 +-
 security/integrity/ima/ima.h                 |  39 ++--
 security/integrity/ima/ima_asymmetric_keys.c |   7 +-
 security/integrity/ima/ima_init.c            |   2 +-
 security/integrity/ima/ima_main.c            |  10 +
 security/integrity/ima/ima_policy.c          |   2 +-
 security/integrity/ima/ima_queue_data.c      | 191 +++++++++++++++++++
 security/integrity/ima/ima_queue_keys.c      | 175 -----------------
 9 files changed, 232 insertions(+), 198 deletions(-)
 create mode 100644 security/integrity/ima/ima_queue_data.c
 delete mode 100644 security/integrity/ima/ima_queue_keys.c

-- 
2.28.0

