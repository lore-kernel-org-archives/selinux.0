Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD898C433DF
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 20:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DCDF20829
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 20:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2A2cXlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgFKUr4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 16:47:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46705 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726251AbgFKUrz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 16:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591908474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=LDTCFQAg2Fy178k9PdK2q98C18g0Yus4dT84f3qnpm0=;
        b=V2A2cXlqCWBWQI45w8ygk2CRSgmGRtAtmArbNkXLKKmOkGxtIALvqxrUd+M7UfY5cMnGyJ
        II9qbbryuwTs/c7H3NQJAJYCI4vDji70ffnhY8c3WgUitJfkuzFr3RnUAMQVZw46H2bkYo
        Wx5S3LoGEvt1hiYb5wRKwEfxin+fhI0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-XRWDCuEEPX-JxaPzE7r8WQ-1; Thu, 11 Jun 2020 16:47:53 -0400
X-MC-Unique: XRWDCuEEPX-JxaPzE7r8WQ-1
Received: by mail-qv1-f71.google.com with SMTP id r15so5313197qvv.5
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 13:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LDTCFQAg2Fy178k9PdK2q98C18g0Yus4dT84f3qnpm0=;
        b=KbyoLDINbbbsGAPGo6ezgITUh9dBeC3iSuXayUSgSG8uRnQaYn/hPIoNIF+1dYCEUj
         L3vCy9e251pnZ+vSTyp/ifsMbRFGs+GcxXm9ZKb87dTQXLAN5QusGZSR8rRhcn7HMHVp
         8oErKrCrH3B4aNKLhiRhUDfdJh9cQXQHYIs18QrQUCm8gInNLn9Ahp29HA1SN4Z8nbw0
         t3h/btGexozD6zNnxpRL4a+RzjZDcpBC7cPQSjeU4ExvQCGK58n/xipqVbjNhLnIzDtz
         gFCYKr2GbPt7H4h2mc8GF/edDfaD7MVDju3zVpsqxwlcswpKT9oxSY30Tnx021UFJwVK
         IYVA==
X-Gm-Message-State: AOAM530KkVDb2Co7v/e2JMlrzjLcnv8TaMzcZdlaiW9sYtqajV9K8pfE
        nhZYOUQa7Q5z4HwTZUvhWXlZToRppgUL4P5SkInXNDEEX5gevo2N01BBZMSNqhP3Cux1ghdNatu
        udqwpP1zt5Q54qprPMw==
X-Received: by 2002:ac8:ece:: with SMTP id w14mr8596411qti.298.1591908472819;
        Thu, 11 Jun 2020 13:47:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2uFSUZb9MHs2sdD0gN7lYSZvGA513ik+MotlOpCk8DfEfIkHf7hZ+UrBhCPdycJEt2UMuBA==
X-Received: by 2002:ac8:ece:: with SMTP id w14mr8596394qti.298.1591908472634;
        Thu, 11 Jun 2020 13:47:52 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z4sm3302663qtu.33.2020.06.11.13.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 13:47:51 -0700 (PDT)
From:   trix@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, omosnace@redhat.com, weiyongjun1@huawei.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/1] selinux: fix another double free
Date:   Thu, 11 Jun 2020 13:47:45 -0700
Message-Id: <20200611204746.6370-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Tom Rix <trix@redhat.com>

repo: linux-next
tag: next-20200611

Change from v1
Convert goto's to returns
Remove extra 'the' in the commit log
Add note on commit this is fixing in the commit log


Tom Rix (1):
  selinux: fix another double free

 security/selinux/ss/conditional.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

-- 
2.18.1

