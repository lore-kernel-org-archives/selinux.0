Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90C2C433DB
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 12:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6764E207AE
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 12:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbhADMkT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Jan 2021 07:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbhADMkT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Jan 2021 07:40:19 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC2EC061794
        for <selinux@vger.kernel.org>; Mon,  4 Jan 2021 04:39:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id c5so32011201wrp.6
        for <selinux@vger.kernel.org>; Mon, 04 Jan 2021 04:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHGry7Mwl9grWoP/tg8vcFujTTysbEr4dC2kbFsejTI=;
        b=Nz3uPfnzoNSl9Lt8MX85S1aJWdAcehHj+XnsBqgQhQ2fVFpd8fAK/2TLBBRf//xXUW
         Fkh8jk2cfD94V79+lajXoIg/bU8d9arZargDsqw6Xs6fVZNvpz66qw3wOcFm8jPYwF7I
         5hHMRSS2fI0e8vgR+qAQ344KQGon4vemOSCYU/WK6y7KA2S42GeYBPtF/PT+ifpq/HyS
         WJtnRTgIL3EBHSyKr09P7mvav6mdonwzWZ6MloyHC9yCWFsrA1hZU8rYqKtKJtY4ctMy
         hhX2+KX4EZOPk7cEZNQYAKVx4XuIaTF6W5VOb/dI9HA2DiX2blDqaLPMNp7xXSzecPgz
         WJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHGry7Mwl9grWoP/tg8vcFujTTysbEr4dC2kbFsejTI=;
        b=MJgBab8yt5hZ6YB9Z2UUA7M148u2qpKtgKZ7VSSAcEOzXreqT29CSR3pszNdgHKznE
         cTJenp/KjBjhKW2r1gjOAaeEGyNhjYedj5ixNRkl0JsNOe5X8PcJraEhfEhXGSw2gFgy
         c13dP4P2Cs+kQhRc8Rck+IWXI3oI4oq3NlggeRo4+2mS6yisiMxCSR6Q9BxzNQaayG5F
         aHzjcdYZOoqJXvThUc2G/g2BCilhBvbDO2CpXcPEbrZSXtiz5asHkFGNsdU7ivqheH2W
         KABXShCmo+pxI2lDJr8/Zn7ypSXpy/oxg6d3LU2T1TQDcUE4KH16ZLNRrntCaPXyAZ0B
         HFIA==
X-Gm-Message-State: AOAM533SgKPGHU9PfiPV0UYmoNBXXG4TiAtVZDvItosd72owEqGfzjel
        oVlg9Ly/nHT7fPXwz+5ai5g3aDvO9OMKojjFHZ94NofWpd4Q/MLs
X-Google-Smtp-Source: ABdhPJwF9CuxOsWsk6akAtFHk2/JRwgCdPVxm2ORshlPlJJEQz1H77hHKkNAv1X2pmZYu6WC5uzp/0PcklnS9/66gZ4=
X-Received: by 2002:a5d:610d:: with SMTP id v13mr80691939wrt.425.1609763977417;
 Mon, 04 Jan 2021 04:39:37 -0800 (PST)
MIME-Version: 1.0
References: <CAP2OjcjH0=HdTMr3eVkD-LkK++8XVDb05C+TtC9+1ii61kErzg@mail.gmail.com>
 <ypjlzh1o523g.fsf@defensec.nl>
In-Reply-To: <ypjlzh1o523g.fsf@defensec.nl>
From:   Ashish Mishra <ashishm@mvista.com>
Date:   Mon, 4 Jan 2021 18:09:26 +0530
Message-ID: <CAP2Ojcg2+FbjEc0mDuE6uLKL45vtNmUnwQDMAoYp97ST67XL1g@mail.gmail.com>
Subject: Re: Selinux context type is same for root & normal user both
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Dominick ,

Thanks for inputs .

a) This is an embedded board which logs in by default as a ROOT user.
     Any pointers as to where can i look to debug the cause due to
which context is "system_u"

b) Apologies , but can you please help method / approach / debug
points by which
    -> I can evaluate the expected contexts for root & testuser
    -> I can see that the labels are created using ls -alZ .
        Is there any other method / debug point to check filesystems
are labeled according to the policy.
        ( as i am using standard refpolicy to create an default policy
on board )


Thanks ,
Ashish
