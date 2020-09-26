Return-Path: <SRS0=welR=DD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3484AC4727E
	for <selinux@archiver.kernel.org>; Sat, 26 Sep 2020 16:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E623C21527
	for <selinux@archiver.kernel.org>; Sat, 26 Sep 2020 16:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oZeayLHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgIZQkG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 26 Sep 2020 12:40:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59980 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZQkG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 26 Sep 2020 12:40:06 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1741620B7178;
        Sat, 26 Sep 2020 09:40:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1741620B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601138405;
        bh=mWES1csgVFhFSglcvOcet7m0CajCa4brDEhfU5+HE5Q=;
        h=From:To:Cc:Subject:Date:From;
        b=oZeayLHoYqoBfB4c4M18jk1WUJ0xS22MwhjmqQ7M/5ewAeZlE9sYS7QC5HqNaj1Y+
         aFG+dTNFFNytXHBurLMjLihLyoY/s6TfM9uA4B1JZHEvLimA4sZxCjnrokwd7KKeZf
         mJZLZ2WJ1tEnUa+M0QsDeI7ynk1V8SZxwfW9ntUo=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        paul@paul-moore.com, omosnace@redhat.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] selinux: Measure state and hash of policy using IMA
Date:   Sat, 26 Sep 2020 09:39:59 -0700
Message-Id: <20200926164000.2926-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Critical data structures of security modules are currently not measured.
Therefore an attestation service, for instance, would not be able to
attest whether the security modules are always operating with the policies
and configurations that the system administrator had setup. The policies
and configurations for the security modules could be tampered by rogue
user mode agents or modified through some inadvertent actions on
the system. Measuring such critical data would enable an attestation
service to reliably assess the security configuration of the system.

SELinux configuration and policy are some of the critical data for this
security module that need to be measured. This measurement can be used
by an attestation service, for instance, to verify if the configurations
and policies have been setup correctly and that they haven't been
tampered at run-time.

This patch set adds support for measuring SELinux configuration,
policy capabilities settings, and the hash of the loaded policy by
calling the IMA hook ima_measure_critical_data().

Since the size of the loaded policy can be large (several MB), hash
of the policy is measured instead of the entire policy to avoid
bloating the IMA log entry.

This patch is based on commit 8861d0af642c ("selinux: Add helper functions to get and set checkreqprot")
in "next" branch in https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git

This patch is dependent on the following patch series and must be
applied in the given order:
  1, https://patchwork.kernel.org/patch/11709527/
  2, https://patchwork.kernel.org/patch/11795559/
  3, https://patchwork.kernel.org/patch/11801525/

Lakshmi Ramasubramanian (1):
  selinux: Measure state and hash of policy using IMA

 security/integrity/ima/ima.h            |   1 +
 security/integrity/ima/ima_queue_data.c |   5 +-
 security/selinux/Makefile               |   2 +
 security/selinux/hooks.c                |   3 +
 security/selinux/include/security.h     |  11 +-
 security/selinux/measure.c              | 154 ++++++++++++++++++++++++
 security/selinux/selinuxfs.c            |   9 ++
 security/selinux/ss/services.c          |  71 +++++++++--
 8 files changed, 244 insertions(+), 12 deletions(-)
 create mode 100644 security/selinux/measure.c

-- 
2.28.0

