Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293F1C43381
	for <selinux@archiver.kernel.org>; Sat, 30 Jan 2021 10:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2E064E04
	for <selinux@archiver.kernel.org>; Sat, 30 Jan 2021 10:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhA3KSa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 30 Jan 2021 05:18:30 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58276 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhA3Arn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jan 2021 19:47:43 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6CA4C20B7192;
        Fri, 29 Jan 2021 16:45:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6CA4C20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1611967528;
        bh=op5LjItHRUfPUox9OsELY1x2Al+yZ2A++LNqhTcTBoc=;
        h=From:To:Cc:Subject:Date:From;
        b=RUWvjxV/i144TnYQuhCikj+0Zvb0VvhCZH7VRCa3SNsiSUKEdSjHBqZhL7P2uPx3s
         9EQGRRkcsFRISQHBEqkeA+8z27MYnqfgHmo1pP+gEgZ6M54hS9YpZViTP4ZTLUn/fZ
         nit3Ee+z+fu76B3ifaGmmRhBnBJ4wXx8Ldyobppg=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 0/3] support for duplicate measurement of integrity critical data
Date:   Fri, 29 Jan 2021 16:45:16 -0800
Message-Id: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

IMA does not measure duplicate buffer data since TPM extend is a very
expensive operation.  However, in some cases for integrity critical
data, the measurement of duplicate data is necessary to accurately
determine the current state of the system.  Eg, SELinux state changing
from 'audit', to 'enforcing', and back to 'audit' again.  In this
example, currently, IMA will not measure the last state change to
'audit'.  This limits the ability of attestation services to accurately
determine the current state of the integrity critical data on the
system.

This series addresses this gap by providing the ability to measure
duplicate entries for integrity critical data, driven by policy.

This series is based on the following repo/branch/commit:
 repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 branch: next-integrity-testing
 commit b3f82afc1041 ("IMA: Measure kernel version in early boot") 

Tushar Sugandhi (3):
  IMA: add policy condition to measure duplicate critical data
  IMA: update functions to read allow_dup policy condition
  IMA: add support to measure duplicate buffer for critical data hook

 Documentation/ABI/testing/ima_policy  |  4 +++-
 security/integrity/ima/ima.h          |  8 +++----
 security/integrity/ima/ima_api.c      | 15 +++++++------
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/ima/ima_init.c     |  2 +-
 security/integrity/ima/ima_main.c     |  9 ++++----
 security/integrity/ima/ima_policy.c   | 31 ++++++++++++++++++++++++---
 security/integrity/ima/ima_queue.c    |  5 +++--
 8 files changed, 54 insertions(+), 22 deletions(-)

-- 
2.17.1

