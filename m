Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6F2C433F5
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 13:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349418AbhKXNmF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Nov 2021 08:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:32976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349075AbhKXNkE (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 24 Nov 2021 08:40:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AAAF6187A;
        Wed, 24 Nov 2021 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637758623;
        bh=ma3+/MsV3dPimc2kWHKUSKOiOxAkRuw68gL41V3FpRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7c2s8lGRHhXx1GsyLgAbbHR4g1/PQ4rOhxHe3V+zMBzEahb4aiTzn6sK9QzaJtzL
         xSTf9BlyQsgfXLseXGlUe1jZAjnNuRCj7y/EH4qgIlsEq1ma/nrk9EWlSAoxf8Mq6q
         MTF2gKgEVq4abbPkj4QXq8Ue6Kn3CX3q+aY8TIfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alistair Delva <adelva@google.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Serge Hallyn <serge@hallyn.com>, Jens Axboe <axboe@kernel.dk>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@android.com
Subject: [PATCH 5.10 130/154] block: Check ADMIN before NICE for IOPRIO_CLASS_RT
Date:   Wed, 24 Nov 2021 12:58:46 +0100
Message-Id: <20211124115706.507376250@linuxfoundation.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211124115702.361983534@linuxfoundation.org>
References: <20211124115702.361983534@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Alistair Delva <adelva@google.com>

commit 94c4b4fd25e6c3763941bdec3ad54f2204afa992 upstream.

Booting to Android userspace on 5.14 or newer triggers the following
SELinux denial:

avc: denied { sys_nice } for comm="init" capability=23
     scontext=u:r:init:s0 tcontext=u:r:init:s0 tclass=capability
     permissive=0

Init is PID 0 running as root, so it already has CAP_SYS_ADMIN. For
better compatibility with older SEPolicy, check ADMIN before NICE.

Fixes: 9d3a39a5f1e4 ("block: grant IOPRIO_CLASS_RT to CAP_SYS_NICE")
Signed-off-by: Alistair Delva <adelva@google.com>
Cc: Khazhismel Kumykov <khazhy@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com
Cc: stable@vger.kernel.org # v5.14+
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Acked-by: Serge Hallyn <serge@hallyn.com>
Link: https://lore.kernel.org/r/20211115181655.3608659-1-adelva@google.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/ioprio.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -69,7 +69,14 @@ int ioprio_check_cap(int ioprio)
 
 	switch (class) {
 		case IOPRIO_CLASS_RT:
-			if (!capable(CAP_SYS_NICE) && !capable(CAP_SYS_ADMIN))
+			/*
+			 * Originally this only checked for CAP_SYS_ADMIN,
+			 * which was implicitly allowed for pid 0 by security
+			 * modules such as SELinux. Make sure we check
+			 * CAP_SYS_ADMIN first to avoid a denial/avc for
+			 * possibly missing CAP_SYS_NICE permission.
+			 */
+			if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
 				return -EPERM;
 			fallthrough;
 			/* rt has prio field too */


