Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6627C04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 16:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C4921479
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 16:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfEJQqw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 12:46:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53750 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbfEJQqw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 May 2019 12:46:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7424914F78BCC;
        Fri, 10 May 2019 09:46:51 -0700 (PDT)
Date:   Fri, 10 May 2019 09:46:47 -0700 (PDT)
Message-Id: <20190510.094647.158721076246887498.davem@davemloft.net>
To:     pabeni@redhat.com
Cc:     netdev@vger.kernel.org, selinux@vger.kernel.org,
        paul@paul-moore.com
Subject: Re: [PATCH net v2] Revert "selinux: do not report error on
 connect(AF_UNSPEC)"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <bc0123c474c2c581d673ddf753f7ff75ecf9dc71.1557480936.git.pabeni@redhat.com>
References: <bc0123c474c2c581d673ddf753f7ff75ecf9dc71.1557480936.git.pabeni@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 10 May 2019 09:46:51 -0700 (PDT)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 10 May 2019 11:37:58 +0200

> This reverts commit c7e0d6cca86581092cbbf2cd868b3601495554cf.
> 
> It was agreed a slightly different fix via the selinux tree.
> 
> v1 -> v2:
>  - use the correct reverted commit hash
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note: this is targeting the 'net' tree

Applied.
