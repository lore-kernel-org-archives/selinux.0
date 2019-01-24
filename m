Return-Path: <SRS0=cSl0=QA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685EBC282C3
	for <selinux@archiver.kernel.org>; Thu, 24 Jan 2019 11:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC31218A2
	for <selinux@archiver.kernel.org>; Thu, 24 Jan 2019 11:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfAXLCU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:02:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbfAXLCU (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 24 Jan 2019 06:02:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F5A1356E5
        for <selinux@vger.kernel.org>; Thu, 24 Jan 2019 11:02:20 +0000 (UTC)
Received: from workstation (unknown [10.43.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19F955C21C
        for <selinux@vger.kernel.org>; Thu, 24 Jan 2019 11:02:19 +0000 (UTC)
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     <selinux@vger.kernel.org>
Subject: [GitHub PR #118] Add russian translations for man pages
Date:   Thu, 24 Jan 2019 12:02:18 +0100
Message-ID: <pjdzhrqtj2d.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 24 Jan 2019 11:02:20 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


There's a github PR - 
https://github.com/SELinuxProject/selinux/pull/118

---
From: Aleksei Nikiforov <darktemplar@basealt.ru>
Date: Tue, 25 Dec 2018 18:25:27 +0300
Subject: [PATCH 1/2] Add man pages translation by Olesya 
Gerasimenko

Signed-off-by: Olesya Gerasimenko <gammaray@basealt.ru>
Signed-off-by: Aleksei Nikiforov <darktemplar@basealt.ru>
---

From: Aleksei Nikiforov <darktemplar@basealt.ru>
Date: Tue, 25 Dec 2018 18:25:05 +0300
Subject: [PATCH 2/2] Allow installing translated man pages

Signed-off-by: Aleksei Nikiforov <darktemplar@basealt.ru>
---

Dominick Grift did a review using google translate and it's going 
to be 
merged in 2 days if there's no other objection.

Petr
