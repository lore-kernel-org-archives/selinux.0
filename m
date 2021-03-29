Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BA8C433DB
	for <selinux@archiver.kernel.org>; Mon, 29 Mar 2021 16:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29FFE61613
	for <selinux@archiver.kernel.org>; Mon, 29 Mar 2021 16:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhC2Q2P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhC2Q2J (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Mar 2021 12:28:09 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADAC4C061574
        for <selinux@vger.kernel.org>; Mon, 29 Mar 2021 09:28:08 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id C13382A16EF
        for <selinux@vger.kernel.org>; Mon, 29 Mar 2021 18:28:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl C13382A16EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1617035283;
        bh=68SdbVX0maxxp6BgwkJyRauwlW1G3u6kGk7ajPCs/4o=;
        h=From:To:Subject:Date:From;
        b=YG6+GMmj+ila9GjIz3gkD/1myVeFU+tewXOWgOJiXbZFOBrM5x9+cJWmLmEJd0c0u
         e+i4akb8XLabf8LQh+0EUqaiixJTcKpHTT/kMrOK5+bDsRSefFRa2JPn5ecfrA7Woz
         4AdP0doyuWsoiW9QsESCuIN3Vx7iPczgB0hd+sH4=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: typechange silently dropped in some cases
Date:   Mon, 29 Mar 2021 18:28:00 +0200
Message-ID: <ypjl8s65aprj.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


typechange rules expect three types: sourcetype loginterminaltype
targettype

1. you can use typeattributes for loginterminaltype fine
2. if you try to use typeattributes for targettype then cil wil refuse
to build it with a helpful message along the lines of: targettype cannot
be typeattribute
3. if you try to use typeattributes for sourcetype then cil wil not
refuse to build it but it will result in the rule not being added

scenario 3 is obviously less than optimal. although it would have been
nice if you could use typeattributes for not just loginterminaltype, it
should probably atleast fail to build with a helpful message such as in
scenario 2 when you try to use a type attribute for source type.

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
