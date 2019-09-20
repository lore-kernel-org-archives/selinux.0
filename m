Return-Path: <SRS0=JJ8R=XP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F607C4CECD
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 10:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59325208C0
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 10:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dci6WWip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438011AbfITKPT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:15:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49735 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438042AbfITKPT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Sep 2019 06:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568974517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+7nDa+TUyh+LnMh8k6IqeByFZpRJN1ChAfwm7LS+Bk=;
        b=Dci6WWipgejArWsnxn6RTi1Io+ATYyiiWGRG6WuOs4kSzcqdHf0E1ifA8/CIe0B5lo7li6
        5Zr96GIMxsLdAQ9ppxLTyK2Or791M7az2x3FrshqFfEjE8Stc73c8BqBr5X3L6YET/KPyd
        /wNK+PORT3jU9UaUBc54aAlctwwotC8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-REekZsUCMhCjiGIGPdqSqA-1; Fri, 20 Sep 2019 06:15:15 -0400
Received: by mail-wr1-f70.google.com with SMTP id n6so2061834wrm.20
        for <selinux@vger.kernel.org>; Fri, 20 Sep 2019 03:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aG9y36sXtDSiMIAH0hrmLmRBZaaFzLKFgDZ0kRbg+Ok=;
        b=kN+ECJQbIPNIRFMl3t3N856zhvjkkQZeQV1tl5hGXZ8rl2h4B3WpY85BYBrnrZZeh6
         oUJczxbqPmTTvVieh4bNyMTjVajPr1Bkf93K0evwqQIAAgRQA3rJxDAu5SCny2YnBTrS
         ugMIJipf7onKWLcnOa53ISkrIOa9ElRT3/+Y9yiH0fhLRJTxUp92VHiihLrZYa711zYC
         BLrnO1oVFzumbeyXE9Q2Bw0QU40Ac1Gn+NliR1XH0WMdw7q/APfSGGZNyyr5W/zbYqMQ
         kfouzLfvqjWi8jTL7IlimO4rt/jqlUN3Cmad0CcorFwWK5H65hFPNkvqZjFCI0wzoUaj
         jy3w==
X-Gm-Message-State: APjAAAVp+Y32uc6BNhh7PLLxNhDGJbbV4/DrJayRUcZdN2xfO3Uc4CMI
        YboaFbOa4lz0Rwl7LosLjpHcPcBkrMeJlhxBef9WqklLFlIijJpwbwiTaMUfb7rHS3aHNfSP4Fk
        o5crbqWpCcQKPm8OiNg==
X-Received: by 2002:adf:ed88:: with SMTP id c8mr10630638wro.329.1568974514393;
        Fri, 20 Sep 2019 03:15:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxe0jb4eq5DxVBgEXX8LbGLRA0D/y/ZRXARb/GsS3BxGdaCnNWpIrjuyQ3KcStcAhS6JWW7SA==
X-Received: by 2002:adf:ed88:: with SMTP id c8mr10630620wro.329.1568974514147;
        Fri, 20 Sep 2019 03:15:14 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y14sm2246059wrd.84.2019.09.20.03.15.13
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 03:15:13 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 1/2] tests/task_setscheduler: fix for old kernels
Date:   Fri, 20 Sep 2019 12:15:09 +0200
Message-Id: <20190920101510.13907-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920101510.13907-1-omosnace@redhat.com>
References: <20190920101510.13907-1-omosnace@redhat.com>
MIME-Version: 1.0
X-MC-Unique: REekZsUCMhCjiGIGPdqSqA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On some old kernels (e.g. RHEL-5) the setscheduler test hangs the system
after commit 26a3b59d5f5a ("selinux-testsuite: fix potential races when
starting bg programs"). The issue seems to be that the new 'target'
program does a busy loop, whereas the old one did sleep() in a loop.

Fix this by sleeping inside the loop as before. Note that the policy
needs to be updated to allow running the sleep command from
a test_setsched_target_t process.

Fixes: 26a3b59d5f5a ("selinux-testsuite: fix potential races when starting =
bg programs")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_task_setsched.te | 1 +
 tests/task_setscheduler/test | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/policy/test_task_setsched.te b/policy/test_task_setsched.te
index 32569b7..794de65 100644
--- a/policy/test_task_setsched.te
+++ b/policy/test_task_setsched.te
@@ -11,6 +11,7 @@ type test_setsched_target_t;
 domain_type(test_setsched_target_t)
 unconfined_runs_test(test_setsched_target_t)
 corecmd_shell_entry_type(test_setsched_target_t)
+corecmd_exec_bin(test_setsched_target_t)
 typeattribute test_setsched_target_t test_setsched_d;
 typeattribute test_setsched_target_t testdomain;
=20
diff --git a/tests/task_setscheduler/test b/tests/task_setscheduler/test
index 9e712a8..fa7d9cb 100755
--- a/tests/task_setscheduler/test
+++ b/tests/task_setscheduler/test
@@ -10,7 +10,7 @@ $basedir =3D~ s|(.*)/[^/]*|$1|;
 system("mkfifo $basedir/flag");
 if ( ( $pid =3D fork() ) =3D=3D 0 ) {
     exec
-"runcon -t test_setsched_target_t sh -c 'echo >$basedir/flag; while :; do =
:; done'";
+"runcon -t test_setsched_target_t sh -c 'echo >$basedir/flag; while :; do =
sleep 1; done'";
 }
=20
 # Wait for it to start.
--=20
2.21.0

