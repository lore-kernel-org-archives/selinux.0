Return-Path: <SRS0=LfCf=UQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1B9C31E57
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 12:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F23208E4
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 12:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="PZaoyAYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbfFQMGq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:06:46 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:35506 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfFQMGp (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 17 Jun 2019 08:06:45 -0400
Received: from 34-41-5D-CA-59-C7 (82-203-159-32.bb.dnainternet.fi [82.203.159.32])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x5HC62eO020314
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 15:06:03 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x5HC62eO020314
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1560773163;
        bh=+G+7F8Mgsd7Wi9xK7pub34TaNaYv0YtkdEmrgUi81lU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=PZaoyAYvBrSQelvAJYipDCNt+3QNn9mvI5op/p4QZCgc/Sy5jC6v6FXTOaAKmPQK0
         UkvSe4hLhDAgx8OPngGo1UoeHrnGFvHTB+pgdFX5bnBNwg+jB2Yjjke+kW4yNcNUuo
         ISOY1d6MT1G8aEjKJbHxaV37fbrmbCFBkNEP2s81ZJMCLTgWrkinpSZMVZJFIuTCEX
         zeJXpOUOYg94hXd3zx2/EQXxRACh0GepRRHs3svMXSmQNu1pZZ2VzeUTX/hJr7MHZ0
         26gi7NJE6mgyeraszF1vfWZB8ypZs16nEywZv2BLKRjg3IAOzaWq2zFz3oSOnnOKcI
         KbEL2dOvvYY9Q==
Date:   Mon, 17 Jun 2019 15:06:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jokke_H=E4m=E4l=E4inen?= 
        <jokke.hamalainen@kolttonen.fi>
To:     William Roberts <bill.c.roberts@gmail.com>
cc:     selinux@vger.kernel.org
Subject: Re: [PATCH] libsepol: check strdup() failures and replace constant
In-Reply-To: <CAFftDdrxyX2MPzexBOdaATmt6YTA4qM3+xJ5uzkHWAJUZxVPXQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1906171505250.6521@34-41-5D-CA-59-C7>
References: <alpine.LFD.2.21.1906150215140.18365@34-41-5D-CA-59-C7> <CAFftDdrxyX2MPzexBOdaATmt6YTA4qM3+xJ5uzkHWAJUZxVPXQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463786495-1473049847-1560773202=:6521"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463786495-1473049847-1560773202=:6521
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


Hello,

On Sun, 16 Jun 2019, William Roberts wrote:

> When ever you do "also" and "and" in a patch description, that's usually
> an indication it should be 2 separate patches. The only case where this
> is generally not followed is when both patches modify the same hunk.
> Please split this, one for strdup() checks and 1 for the sizeof() usage.

Okay, done and reposted. Stephen only asked me to add the signed-off-by 
line so I figured the patch was okay as is.

Best regards,
Jokke Hämäläinen
---1463786495-1473049847-1560773202=:6521--
