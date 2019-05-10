Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2DEC04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 09:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83BF20881
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 09:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfEJJda (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 05:33:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfEJJda (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 10 May 2019 05:33:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58C1C307D849;
        Fri, 10 May 2019 09:33:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.32.181.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60DB81001E78;
        Fri, 10 May 2019 09:33:29 +0000 (UTC)
Message-ID: <2ab9a9420ecc12cd2870e5368dfaa4262381729e.camel@redhat.com>
Subject: Re: [PATCH net] Revert "selinux: do not report error on
 connect(AF_UNSPEC)"
From:   Paolo Abeni <pabeni@redhat.com>
To:     netdev@vger.kernel.org
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        David Miller <davem@davemloft.net>
Date:   Fri, 10 May 2019 11:33:28 +0200
In-Reply-To: <7b313602784e5cbbdc7bb8028a3e746c88795060.1557478063.git.pabeni@redhat.com>
References: <7b313602784e5cbbdc7bb8028a3e746c88795060.1557478063.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 10 May 2019 09:33:30 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2019-05-10 at 11:27 +0200, Paolo Abeni wrote:
> This reverts commit 7301017039d68c920cb9120c035a1a0df3e6b30d.
> 
> It was agreed a slightly different fix via the selinux tree.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Whoops... this references the wrong hash - the local one instead of the
'-net' tree one. I'll send a v2. I'm sorry for the noise and overhead.

Paolo

