Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDF6C433F5
	for <selinux@archiver.kernel.org>; Tue,  1 Feb 2022 09:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiBAJiV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Feb 2022 04:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiBAJiU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Feb 2022 04:38:20 -0500
X-Greylist: delayed 489 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Feb 2022 01:38:20 PST
Received: from smtp.sws.net.au (smtp.sws.net.au [IPv6:2a01:4f8:201:1e6::dada:cafe])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBE6C061714
        for <selinux@vger.kernel.org>; Tue,  1 Feb 2022 01:38:19 -0800 (PST)
Received: from xev.coker.com.au (localhost [127.0.0.1])
        by smtp.sws.net.au (Postfix) with ESMTP id F2F45111B4
        for <selinux@vger.kernel.org>; Tue,  1 Feb 2022 20:30:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
        s=2008; t=1643707803;
        bh=PWXwrag1b9WjmnstzKAgO9zDSZnsBtNY1t0rAsZJM6E=; l=427;
        h=From:To:Reply-To:Subject:Date:From;
        b=jDUflohHt9DBfgHiNoVd++V9szXXKMy2vy9a+OYJIe00xcCRijJIfG9PwhCOVt892
         b3w/kzrc1E4dkVijPc+BkORCHSKd5G+I0wCu3JWoMsBRrhYjGkowYLwA54YcQ2TuK+
         SfqSqiJPbPYwOb8IwGVISpkJCqGqBFZEbKtK60I4=
Received: by xev.coker.com.au (Postfix, from userid 1001)
        id 35254170B6AA; Tue,  1 Feb 2022 20:29:58 +1100 (AEDT)
From:   Russell Coker <russell@coker.com.au>
To:     selinux@vger.kernel.org
Reply-To: russell@coker.com.au
Subject: kmod and unsigned modules
Date:   Tue, 01 Feb 2022 20:29:58 +1100
Message-ID: <8839796.NKUDOvIH9j@xev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

[    9.002945] audit: type=1400 audit(1643707510.152:4): avc:  denied  { 
integrity } for  pid=371 comm="modprobe" lockdown_reason="unsigned module 
loading" scontext=system_u:system_r:kmod_t:s0 
tcontext=system_u:system_r:kmod_t:s0 tclass=lockdown permissive=0

We need to have a boolean for this.  Just sending email so I don't forget it.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

