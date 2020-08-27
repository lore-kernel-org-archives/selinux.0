Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02738C433DF
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 08:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C6422B47
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 08:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UfQV18cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgH0ILI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:11:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43937 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727115AbgH0ILH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 04:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598515866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xw5Rh1qIWftfpObVGWnLw4PGuWPAKEkFUdPwHxq4uMY=;
        b=UfQV18cwKvQ9Di6RR4p5a32lwZ0+wdj9kK3ZgtXFH7K1I+EcksHoHBtiyzvN2zBTlz4m51
        8zggJYxFhSoqXz5Vte0t+wTUO6LFGiKFiW8gTqGe3jsyY12ZsGOsyGOdpRfiG4IqRmsgWR
        8DcsLcnDpne+/AKnH5HkS8dOC4Ii0Xs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-duTYbiwMOkihko8UO0drlw-1; Thu, 27 Aug 2020 04:11:04 -0400
X-MC-Unique: duTYbiwMOkihko8UO0drlw-1
Received: by mail-wm1-f71.google.com with SMTP id p184so1839287wmp.7
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 01:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xw5Rh1qIWftfpObVGWnLw4PGuWPAKEkFUdPwHxq4uMY=;
        b=fzk71onLUwHZKwzISKmkanv96H1aFVXheicc6EvTlaO7KLK2MeZdUXiMBskcvhCprF
         BFz3sgC/5GrEmmgtQLgs9A7dNdsmZHnNzm20x3b62GTCfB2hhE7QYczdMRSzKFgPYhkq
         1dyDDu2BKFbYGtEEteQ9rxaNDIxs4/dhYWeLmAR/x5TSMopmHp957VQ5wdksllReBZj9
         vOgoRN+qGl1VpOIl9kaUjJYwzU6Vqjlwt2X3expbM8hp8OzdSurPk4XfoxVIfkODdGpk
         hXXGed7ggrOtDCT56/8gpC9hwGYTwf2SEdgBX+Zj3WOsBZyXr6wlfNUFaNOBWDGmYEYr
         TrpA==
X-Gm-Message-State: AOAM533r/ukFoUX+Y9qz75xK9VGPzO86Bp+m1HJwCmadF9NEtbmkOv8y
        oyg7uJdBqPpM104w4VdpxSe/wsy5ctBuZn4Q9v9bWVxoxST2+ejcNKXNIkr2ID+GrPnRKpr/xFn
        Wg2eeBdIRRw6Sg5AJrQ==
X-Received: by 2002:adf:c552:: with SMTP id s18mr18580692wrf.209.1598515863217;
        Thu, 27 Aug 2020 01:11:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhJbje0nADYiaDBftqn6Wko4GRJNJwhqrynWe+NLvr45YgsA2cqMs5gvj+LsatLrp2NLM8rA==
X-Received: by 2002:adf:c552:: with SMTP id s18mr18580672wrf.209.1598515862972;
        Thu, 27 Aug 2020 01:11:02 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id z8sm3521258wmf.10.2020.08.27.01.11.01
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 01:11:01 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/sctp: bump connect timeout to 4 seconds
Date:   Thu, 27 Aug 2020 10:11:00 +0200
Message-Id: <20200827081100.1954467-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The current value of 2 seconds causes transient failures too often in
certain slow/unstable environments (including the nested KVM Travis CI
setup). Our experience from downstream testing at Red Hat (across a
variety of HW and architectures) has shown that a value of 4 seconds
yields only very sporadic failures.

Therefore, change the value to 4 to trade off some testing time for more
stability.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/sctp/sctp_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/sctp/sctp_client.c b/tests/sctp/sctp_client.c
index 595da75..2f527ed 100644
--- a/tests/sctp/sctp_client.c
+++ b/tests/sctp/sctp_client.c
@@ -99,7 +99,7 @@ int main(int argc, char **argv)
 	 *    EAGAIN - Resource temporarily unavailable - SOCK_SEQPACKET
 	 *        Uses SO_RCVTIMEO when NO connects are called.
 	 */
-	tm.tv_sec = 2;
+	tm.tv_sec = 4;
 	tm.tv_usec = 0;
 	result = setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, &tm, sizeof(tm));
 	if (result < 0) {
-- 
2.26.2

