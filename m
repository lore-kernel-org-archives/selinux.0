Return-Path: <SRS0=xdbR=5S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4D5C43331
	for <selinux@archiver.kernel.org>; Thu,  2 Apr 2020 15:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DF220737
	for <selinux@archiver.kernel.org>; Thu,  2 Apr 2020 15:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GNS8Trkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389329AbgDBPp2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:45:28 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40194 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389416AbgDBPp2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Apr 2020 11:45:28 -0400
Received: from chpebeni.northamerica.corp.microsoft.com (pool-108-15-23-247.bltmmd.fios.verizon.net [108.15.23.247])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7953920B46F0
        for <selinux@vger.kernel.org>; Thu,  2 Apr 2020 08:45:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7953920B46F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1585842327;
        bh=p0ByehIUZ6QggKiKfaQ2flIPZ9uBUxaqLOwdzZRfIoE=;
        h=From:To:Subject:Date:From;
        b=GNS8TrkreQSat+x/IQu7sH2YH7YecRifb8+SxTFdzKZkB8Mvw25bV4JReaumPbfOz
         W8lD2/OTyNOubiQVNWDod0cobwlA87mvrJQiv6OKuMFIocUd+dzu+WpZfe8b6bDpwU
         Sg1tdlo3O54fBw4zyslGn8q+Qb/aUQ1MBGp0NLRc=
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 0/2] setfiles: Add -E option to treat conflicting
 specifications as errors.
Message-ID: <921250f5-e2aa-f7a3-0455-8ebf76630a7d@linux.microsoft.com>
Date:   Thu, 2 Apr 2020 11:45:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The following patch set is for adding the -E option to setfiles which would 
treat conflicting specifications as errors, rather than choosing from one of the 
specifications.  Choosing one of the specs introduces non-determinism which is 
problematic, such as where filesystem images are being built in Yocto.  Without 
this option, the build is not repeatable, since you can have the same source 
tree and have different labeling outcomes in the output image.

This results in setfiles output like the following:

# ./setfiles -E file_contexts /tmp
./setfiles: conflicting specifications for /tmp/testfile and /tmp/hardlink, 
using system_u:object_r:no_access_t:s0.
./setfiles: treating conflicting specifications as an error.
./setfiles: filespec_add error: /tmp/testfile



  libselinux/include/selinux/restorecon.h  | 37 
+++++++++++++++++++++----------------
  libselinux/man/man3/selinux_restorecon.3 |  4 ++++
  libselinux/src/selinux_restorecon.c      | 13 +++++++++++--
  policycoreutils/setfiles/restore.c       |  2 +-
  policycoreutils/setfiles/restore.h       |  1 +
  policycoreutils/setfiles/setfiles.8      |  5 +++++
  policycoreutils/setfiles/setfiles.c      | 10 +++++++---
  7 files changed, 50 insertions(+), 22 deletions(-)

-- 
Chris PeBenito
