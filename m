Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AEDC433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 13:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3992214F1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 13:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KZ9Xi4Hh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgHZNZU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:25:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41690 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbgHZNZU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 09:25:20 -0400
Received: from chpebeni.northamerica.corp.microsoft.com (pool-108-15-23-247.bltmmd.fios.verizon.net [108.15.23.247])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8D9CE20B4908
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 06:25:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D9CE20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598448319;
        bh=G8LpQPPiUKG7GaL7k97WPQSlCpd3TP7pVtA+sPceO2Q=;
        h=To:From:Subject:Date:From;
        b=KZ9Xi4HhqkcOkQQOyWllcFQPARsXxeJ/Bj3Ut2MZk3GnP+eR7Wx/yt+83eyWTwsRl
         rPUgxjB3odpFFz1+JiUvgw0yMKG28NBLsLHyu/iS0oEXFUVm1iLbYKA9aFm17mFAaw
         4LACoKVGcLmAefAhh8hUw0WGOhl80MEmTHcE29eI=
To:     selinux@vger.kernel.org
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
Subject: Userspace AVC auditing on policy load
Message-ID: <cb7451da-24d3-4a0c-e4f8-205e6539ed54@linux.microsoft.com>
Date:   Wed, 26 Aug 2020 09:25:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I was looking into this dbus-broker audit message, which has the wrong audit type:

audit[422]: USER_AVC pid=422 uid=999 auid=4294967295 ses=4294967295 
subj=system_u:system_r:system_dbusd_t msg='avc:  received policyload notice 
(seqno=2)

This is due to dbus-broker setting their avc log callback to send USER_AVC audit 
messages for everything that comes to the libselinux log callback. I think the 
right thing to do there is to change it to emit USER_SELINUX_ERR audit messages 
if the log message is SELINUX_ERROR, otherwise log the message using their 
regular method (stderr I think).

But the question became, why is the userspace AVC not simply emitting its own 
USER_MAC_POLICY_LOAD audit message instead of sending a message to the log callback?

-- 
Chris PeBenito
