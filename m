Return-Path: <SRS0=6R7b=XU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92294C432C2
	for <selinux@archiver.kernel.org>; Wed, 25 Sep 2019 10:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7313A214D9
	for <selinux@archiver.kernel.org>; Wed, 25 Sep 2019 10:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390090AbfIYKgy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Sep 2019 06:36:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55529 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389655AbfIYKgx (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 25 Sep 2019 06:36:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B98CB300BEA9
        for <selinux@vger.kernel.org>; Wed, 25 Sep 2019 10:36:53 +0000 (UTC)
Received: from localhost (unknown [10.43.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 64FDB1001B11
        for <selinux@vger.kernel.org>; Wed, 25 Sep 2019 10:36:53 +0000 (UTC)
User-agent: mu4e 1.2.0; emacs 26.2
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Subject: last call for selinux 3.0-rc1 release
Date:   Wed, 25 Sep 2019 12:36:51 +0200
Message-ID: <pjd5zlg64sc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 25 Sep 2019 10:36:53 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

We are looking at making a 3.0-rc1 selinux userspace release in 
the not-too-distant future,
so if you have any additional patches you want included in 3.0, 
please post them to the list soon.

Thanks,

Petr
