Return-Path: <SRS0=UID1=TY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64EEC072B5
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 11:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24D0217D7
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 11:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391023AbfEXLWl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 May 2019 07:22:41 -0400
Received: from ithil.bigon.be ([163.172.57.153]:33582 "EHLO ithil.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390701AbfEXLWl (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 24 May 2019 07:22:41 -0400
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 May 2019 07:22:40 EDT
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id 4DD931FCCD
        for <selinux@vger.kernel.org>; Fri, 24 May 2019 13:17:01 +0200 (CEST)
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id TiqK3qIEzZ93 for <selinux@vger.kernel.org>;
        Fri, 24 May 2019 13:17:01 +0200 (CEST)
Received: from [10.40.1.128] (mail2.vdab.be [193.53.238.200])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA
        for <selinux@vger.kernel.org>; Fri, 24 May 2019 13:17:01 +0200 (CEST)
To:     selinux@vger.kernel.org
From:   Laurent Bigonville <bigon@debian.org>
Subject: SELinux integration in sysVinit
Message-ID: <8cef19ba-5055-39fd-873f-73c7ba13cb8e@debian.org>
Date:   Fri, 24 May 2019 13:17:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

There is currently some discussion at [0] about SELinux integration in 
sysVinit and the fact that somebody wants to delegate the loading of the 
policy to an other binary than PID1.

Has somebody a remark or an objection to that proposal?

I already gave my POV regarding SELinux integration in debian.

Kind regards,

Laurent Bigonville

[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=929063

