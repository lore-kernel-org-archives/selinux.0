Return-Path: <SRS0=ETpO=NK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D3DC2BC61
	for <selinux@archiver.kernel.org>; Tue, 30 Oct 2018 15:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A7A20657
	for <selinux@archiver.kernel.org>; Tue, 30 Oct 2018 15:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A7A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeJaAUv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:20:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeJaAUv (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 30 Oct 2018 20:20:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3DEB307DAC8
        for <selinux@vger.kernel.org>; Tue, 30 Oct 2018 15:26:56 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-167.brq.redhat.com [10.40.204.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1755C608F4
        for <selinux@vger.kernel.org>; Tue, 30 Oct 2018 15:26:55 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: Re: [PATCH 2/3] python/sepolicy: Stop rejecting aliases in sepolicy commands
Date:   Tue, 30 Oct 2018 16:26:28 +0100
Message-Id: <20181030152629.7438-1-vmojzis@redhat.com>
In-Reply-To: <CAJfZ7==UCR-a=mfLY1TRad++g+nbpZ6QMxFz5N6JV5_W6QomDQ@mail.gmail.com>
References: <CAJfZ7==UCR-a=mfLY1TRad++g+nbpZ6QMxFz5N6JV5_W6QomDQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 30 Oct 2018 15:26:56 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The previous patches where written for older version of policycoreutils
and setools 3 and where not properly tested on upstream code. The
following patch is necessary for it to work properly here.
Sorry about this.

One thing that I'm not sure about is if there should be a warning when
user enters an alias instead of a type (the output will only contain the
corresponding type and not the alias, which may be confusing).


