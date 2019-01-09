Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B542C43444
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 20:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58C7206B6
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 20:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfAIUfS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:35:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:14712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfAIUfS (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 9 Jan 2019 15:35:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1924981DFA
        for <selinux@vger.kernel.org>; Wed,  9 Jan 2019 20:35:18 +0000 (UTC)
Received: from workstation (ovpn-204-66.brq.redhat.com [10.40.204.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E9385C57A
        for <selinux@vger.kernel.org>; Wed,  9 Jan 2019 20:35:17 +0000 (UTC)
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     "SELinux" <selinux@vger.kernel.org>
Subject: last call for selinux 2.9-rc1 release
Date:   Wed, 09 Jan 2019 21:35:15 +0100
Message-ID: <pjdy37tfu2k.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 09 Jan 2019 20:35:18 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

We are looking at making a 2.9-rc1 selinux userspace release in 
the not-too-distant future,
so if you have any additional patches you want included in 2.9, 
please post them to the list soon.

Thanks.
