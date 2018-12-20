Return-Path: <SRS0=ShWd=O5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4EBC43387
	for <selinux@archiver.kernel.org>; Thu, 20 Dec 2018 15:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F6121852
	for <selinux@archiver.kernel.org>; Thu, 20 Dec 2018 15:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeLTPOd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:14:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeLTPOc (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 20 Dec 2018 10:14:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4E00A0362
        for <selinux@vger.kernel.org>; Thu, 20 Dec 2018 15:14:32 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5624F604CC
        for <selinux@vger.kernel.org>; Thu, 20 Dec 2018 15:14:32 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Fix semanage in envinronment without default policy or when -S <store> is used
Date:   Thu, 20 Dec 2018 16:14:16 +0100
Message-Id: <20181220151420.30878-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 20 Dec 2018 15:14:32 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The following set of patches tries to fix semanage in non-standard environments.

A backtrace when semanage was run on a system without installed policy, see
https://github.com/SELinuxProject/selinux/issues/81
https://bugzilla.redhat.com/show_bug.cgi?id=1558861 

The fix is based on
https://github.com/fishilico/selinux/commit/00eb0cc86185d2145ea3ec61df08c587faba1375
by Nicolas Iooss <nicolas.iooss@m4x.org>

And when semanage was run -S <store>, sepolicy module was initialized with the
default policy file (targeted) and also selinux module used the same default. It
meant that semanage either backtraced when the default policy was not installed
or used wrong store and therefore didn't behave correctly.

E.g. # semanage login -S minimum -d -s unconfined_u -r s0-s0:c0.c1023 __default__
libsemanage.dbase_llist_query: could not query record value
OSError: [Errno 0] Error




