Return-Path: <SRS0=gWJv=57=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC72C2BA19
	for <selinux@archiver.kernel.org>; Wed, 15 Apr 2020 17:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE5620784
	for <selinux@archiver.kernel.org>; Wed, 15 Apr 2020 17:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="EIdPmdhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404508AbgDORRh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404504AbgDORRf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Apr 2020 13:17:35 -0400
X-Greylist: delayed 146901 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Apr 2020 10:17:34 PDT
Received: from smtp.sws.net.au (smtp.sws.net.au [IPv6:2a01:4f8:140:71f5::dada:cafe])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27B9C061A0C
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 10:17:34 -0700 (PDT)
Received: from liv.localnet (localhost [127.0.0.1])
        by smtp.sws.net.au (Postfix) with ESMTP id 472BCED55;
        Thu, 16 Apr 2020 03:17:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
        s=2008; t=1586971051;
        bh=d2yecgE8eWDRLMBKgvl+Va2ghaxf0RNv9L9uc0ODzdM=; l=1045;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIdPmdhVWcWF8+8o4AL3mb+il2Ih5z7dBjevmsCehNxT5goyWRHOlEKOoxVUkier1
         i58K+V4FiBHX9JMYv6RqqtLxxuryFDed4FxjmqR4iEn/NjjGIKkkab2fB+wK3SQL/D
         Y5a3xnJtYdhrwYz6RomQCJYZb8qKaoqUImDdqum0=
From:   Russell Coker <russell@coker.com.au>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Laurent Bigonville <bigon@debian.org>
Subject: Re: semodule -i and load_policy coredumps on version 3.0 - not latest GIT
Date:   Thu, 16 Apr 2020 03:17:25 +1000
Message-ID: <3781162.572I9EPuCd@liv>
In-Reply-To: <CAJfZ7==9L2PZkbBO22=RapRKvdiZQ1Fj7jgEhNSUcZ1hTDyKPA@mail.gmail.com>
References: <2203189.X40rEyH0Y1@liv> <CAJfZ7==9L2PZkbBO22=RapRKvdiZQ1Fj7jgEhNSUcZ1hTDyKPA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wednesday, 15 April 2020 3:27:38 AM AEST Nicolas Iooss wrote:
> This looks a pretty difficult issue. The facts that it is not easily
> reproducible and that the stack trace changes even though the 2
> modules you are testing do not are interesting. They imply that there
> is some randomness involved. As far as I remember the code I've read

I'm still debugging this.  My first belief that the bug was fixed in the latest 
git seems incorrect.  I've now got a collection of valgrind logs from libsepol 
from git revision 5447c8490b318ef64c61eb6022baddca69233733 (latest as of 
yesterday afternoon).  I presume that the valgrind logs of "Conditional jump 
or move depends on uninitialised value(s)" corresponds to a SEGV when not 
running valgrind but haven't proven that yet.

I have not yet worked out how to reproduce the bug on another system.  
Nickolas, thanks for all your suggestions I will go back to them once I have 
more test results.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/



