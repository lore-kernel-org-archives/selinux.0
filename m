Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B731C4742C
	for <selinux@archiver.kernel.org>; Tue, 10 Nov 2020 23:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444C8207BB
	for <selinux@archiver.kernel.org>; Tue, 10 Nov 2020 23:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/fVu7S6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbgKJXlB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Nov 2020 18:41:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgKJXlA (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 10 Nov 2020 18:41:00 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B1C520781;
        Tue, 10 Nov 2020 23:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605051660;
        bh=N/bq3fNU8AZcMGTAR1nBPqzuFyJ9hKeOgb5V0mnuHyo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N/fVu7S6g9v/6rvRItkIPU0XEs/N+WF7KtfNdo5DMIXCLzyDzB8Bdp8YR1FYv1LBy
         k3BY9aTc+DsfT0/wbjPqCWlD39l9VyaTWX/sLOBtcn5Turst0MC/yJBD/HpDuRlx8j
         4CYBrhez+int/4Aor4DuSJWQ1p3V5erBr7XsEqqk=
Date:   Tue, 10 Nov 2020 15:40:59 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Joe Nall <joe@nall.com>,
        Waseem Chaudary <waseem.a.chaudary@accenturefederaldefense.com>
Subject: Re: [PATCH] netlabel: fix our progress tracking in
 netlbl_unlabel_staticlist()
Message-ID: <20201110154055.44b1ca16@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <160484450633.3752.16512718263560813473.stgit@sifl>
References: <160484450633.3752.16512718263560813473.stgit@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, 08 Nov 2020 09:08:26 -0500 Paul Moore wrote:
> The current NetLabel code doesn't correctly keep track of the netlink
> dump state in some cases, in particular when multiple interfaces with
> large configurations are loaded.  The problem manifests itself by not
> reporting the full configuration to userspace, even though it is
> loaded and active in the kernel.  This patch fixes this by ensuring
> that the dump state is properly reset when necessary inside the
> netlbl_unlabel_staticlist() function.
> 
> Fixes: 8cc44579d1bd ("NetLabel: Introduce static network labels for unlabeled connections")
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Applied to net, thank you!
