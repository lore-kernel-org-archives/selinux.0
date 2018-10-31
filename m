Return-Path: <SRS0=k0zu=NL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E11C0044C
	for <selinux@archiver.kernel.org>; Wed, 31 Oct 2018 12:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E8A20685
	for <selinux@archiver.kernel.org>; Wed, 31 Oct 2018 12:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E8A20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeJaV0I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:26:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44617 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbeJaV0I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Oct 2018 17:26:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17-v6so15962480wre.11
        for <selinux@vger.kernel.org>; Wed, 31 Oct 2018 05:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Et2gJfsA902kIkg1Y9m7MAmZ/QQg81NWfB+TCvc3grI=;
        b=s+2E9xMlg2UmtjKGPGBptoSZOSTbWZg3RIHo4qGfbTf9I6H0tCfD591I1Uqh7Ar1we
         MEURWUS6VUd9BcMOregPzfvf2EJB9mooyWJfcsa1EYeGXkNT6K7XitvPSZCbPssbKQuA
         13a70qg0w7Ee0ytQVOqHkZTzNZrs9OyD/DMzC88dgXK9M3Z5Le0n90Vbm++JiOWiiXtD
         VrC31coFZi0DNA5RiTRZOpkWX1PNJ+T3dRTLZ3yNd7KAxVsxGeGP+ivjFkm4ufn25Y8a
         9T2FF13SWNMUimvW8N1/ZrQoU2/Z36/vYEyk5ufe2pmQYIaeI54k0MtLSyNiFqMym1u3
         8N/A==
X-Gm-Message-State: AGRZ1gJtfj1CGfkseKAwE21vAuNY+YStKHDRMFpOuHR1jwYj29fanIRb
        2o3JDkq5ERdBggQ5OkHsiUBd9qoAlBI=
X-Google-Smtp-Source: AJdET5fjUR/0w8A9uIVdX4MPMj0hwt1HsaauArTSk0l+2WUSiVI9KJxLqNl0WDFW6N6vWtBJgl8NKw==
X-Received: by 2002:adf:de89:: with SMTP id w9-v6mr1444065wrl.41.1540988898069;
        Wed, 31 Oct 2018 05:28:18 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m192-v6sm9131737wmb.29.2018.10.31.05.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 05:28:17 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 0/2] Fix ENOMEM errors during policy reload
Date:   Wed, 31 Oct 2018 13:27:16 +0100
Message-Id: <20181031122718.18735-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset revamps the SID table implementation to fix ENOMEM errors returned from sidtab_context_to_sid() during policy reload.

The first patch prepares the way for the second one by moving the handling of initial SIDs to a separate table. This is needed since the second patch will do the sidtab conversion in-place and handling the initial SIDs would complicate things too much.

The second patch changes the way that sidtab is transitioned to the new policy so that it does not need to be frozen for modifications during the conversion of entries to the new policy.

See individual patches for more details.

Resolves: https://github.com/SELinuxProject/selinux-kernel/issues/38
Testing:
 - passed selinux-testsuite
 - verified using the reproducer from GH issue
 - tested with the following stress test on SMP (with lock debugging enabled):

function rand_cat() {
	echo $(( $RANDOM % 1024 ))
}

function do_work() {
	while runcon -l s0:c$(rand_cat),c$(rand_cat) echo -n x; do :; done
}

do_work >/dev/null &
do_work >/dev/null &
do_work >/dev/null &

while load_policy; do echo -n .; sleep 0.1; done

kill %1
kill %2
kill %3

--
Ondrej Mosnacek (2):
  selinux: use separate table for initial SID lookup
  selinux: fix ENOMEM errors during policy reload

 security/selinux/include/security.h |   3 +
 security/selinux/ss/mls.c           |  22 +-
 security/selinux/ss/mls.h           |   5 +-
 security/selinux/ss/policydb.c      |  24 ++-
 security/selinux/ss/policydb.h      |  26 ++-
 security/selinux/ss/services.c      | 314 +++++++++++++---------------
 security/selinux/ss/services.h      |   1 +
 security/selinux/ss/sidtab.c        | 141 +++++++------
 security/selinux/ss/sidtab.h        |  26 +--
 9 files changed, 296 insertions(+), 266 deletions(-)

-- 
2.17.2

