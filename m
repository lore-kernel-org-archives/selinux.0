Return-Path: <SRS0=LxTM=M4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE959C04EBD
	for <selinux@archiver.kernel.org>; Tue, 16 Oct 2018 10:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C89C20881
	for <selinux@archiver.kernel.org>; Tue, 16 Oct 2018 10:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C89C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeJPRzZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:55:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeJPRzZ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 16 Oct 2018 13:55:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21B0846202
        for <selinux@vger.kernel.org>; Tue, 16 Oct 2018 10:05:45 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-163.brq.redhat.com [10.40.204.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D2DF7A7A7
        for <selinux@vger.kernel.org>; Tue, 16 Oct 2018 10:05:44 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: Fix alias handling in sepolicy and semanage 
Date:   Tue, 16 Oct 2018 12:05:30 +0200
Message-Id: <20181016100533.12249-1-vmojzis@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 16 Oct 2018 10:05:45 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Sepolicy and semanage do not work with aliases properly (aliases are 
mostly treated as invalid types). Fix this by determining corresponding
type when an alias is used and working with the type instead.

python/semanage/seobject.py          | 21 ++++++++++-----------
python/sepolicy/sepolicy.py          |  8 +++-----
python/sepolicy/sepolicy/__init__.py | 22 ++++++++++++++++++----
3 files changed, 31 insertions(+), 20 deletions(-)


