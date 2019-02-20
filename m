Return-Path: <SRS0=OyWE=Q3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D19C43381
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 16:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086DF2084D
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 16:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfBTQEx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:04:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfBTQEx (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 20 Feb 2019 11:04:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8FBC7C8F91
        for <selinux@vger.kernel.org>; Wed, 20 Feb 2019 16:04:53 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AFC1183C3
        for <selinux@vger.kernel.org>; Wed, 20 Feb 2019 16:04:52 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: [RFC] Switch to Python 3 by default
Date:   Wed, 20 Feb 2019 17:04:43 +0100
Message-Id: <20190220160446.23150-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 20 Feb 2019 16:04:53 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Default instalation seems to be inconsistent a little when PYTHON
variable is not used during build. Python 2 versions of selinux and
semanage modules are built and installed, but /usr/sbin/semanage and
other tools are already changed to use /usr/bin/python3.

I'd like to propose to change to Python 3 by default and leave it on a
maintainer to use PYTHON=/usr/bin/python2 when they doesn't have Python
3 available. They would also need to change shebangs of some tools, but
this is the same situation as used to be when default was Python 2 and
maintainers needed to change shebangs to /usr/bin/python3.

Do you have any objections?


