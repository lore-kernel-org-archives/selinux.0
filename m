Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3E6C433ED
	for <selinux@archiver.kernel.org>; Fri,  2 Apr 2021 16:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD7261106
	for <selinux@archiver.kernel.org>; Fri,  2 Apr 2021 16:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhDBQuw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Apr 2021 12:50:52 -0400
Received: from smtp2.unipi.it ([131.114.21.21]:39272 "EHLO smtp.unipi.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235341AbhDBQuv (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 2 Apr 2021 12:50:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.unipi.it (Postfix) with ESMTP id 03B23811CD
        for <selinux@vger.kernel.org>; Fri,  2 Apr 2021 18:50:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at unipi.it
Received: from [192.168.1.8] (net-93-70-46-220.cust.vodafonedsl.it [93.70.46.220])
        (Authenticated User)
        by smtp.unipi.it (Postfix) with ESMTPSA id 39C8780F2D
        for <selinux@vger.kernel.org>; Fri,  2 Apr 2021 18:50:48 +0200 (CEST)
Subject: [Request] CIL configurations
References: <df18624a-106a-6fde-6276-0c1aa13d5fd1@phd.unipi.it>
To:     selinux@vger.kernel.org
From:   lorenzo ceragioli <lorenzo.ceragioli@phd.unipi.it>
X-Forwarded-Message-Id: <df18624a-106a-6fde-6276-0c1aa13d5fd1@phd.unipi.it>
Message-ID: <9cab1338-5b88-b30a-19ec-7d557d939668@phd.unipi.it>
Date:   Fri, 2 Apr 2021 18:50:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <df18624a-106a-6fde-6276-0c1aa13d5fd1@phd.unipi.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

We are currently working on a tool for verifying information flow 
properties on CIL configurations. We want to allow reasoning about such 
properties with respect to the constructs of the configuration (block 
inheritance and nesting, macro). To test our approach, we are looking 
for configurations that make use of block inheritance, macros etc (hence 
CIL policies compiled from .pp files are not good for us). Do you know 
something that may help us? Are there repositories, or groups where we 
can ask?

Thanks
Lorenzo

