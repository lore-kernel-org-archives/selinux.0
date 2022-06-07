Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796E8C43334
	for <selinux@archiver.kernel.org>; Wed,  8 Jun 2022 00:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbiFHAm5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386774AbiFHAWb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jun 2022 20:22:31 -0400
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E4F19EC34
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 12:26:36 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2a10:3781:2099::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id 6F1EAFC0457
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 21:26:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1654629990;
        bh=QB89DkTpuF7sUb0CfKXSaLJDojnJy4YDdXjG7b70S0U=;
        h=From:To:Subject:Date:From;
        b=D//0RwOklNspqJhg7iVs0/iFh0e8H2fH/we+gt3xwSX35kKtIvF+FR7tRrEIpNoy1
         609hQbNz6z9Yn6bbvERTRUhIJ9ICPKxOxfSarD5bhi/btN9CNjrCadtpz9thggRErH
         p+KVdXhEyWAneONNSvedfhSu2J0XEL82c8BP2RC8=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: why arent we checking MS_BIND?
Date:   Tue, 07 Jun 2022 21:26:29 +0200
Message-ID: <87v8tccm1m.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


I suppose there is a reason why we cannot control bind mounts with
SELinux. I would like to determine whether the decision not to provide
controls for bind mounts is still feasible in this day and age.

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
