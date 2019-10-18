Return-Path: <SRS0=WnGO=YL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4EDCA9EA1
	for <selinux@archiver.kernel.org>; Fri, 18 Oct 2019 09:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EAE21897
	for <selinux@archiver.kernel.org>; Fri, 18 Oct 2019 09:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="LyIQOg9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442231AbfJRJAN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:00:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34820 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731444AbfJRJAN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Oct 2019 05:00:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15so8081395qtq.2
        for <selinux@vger.kernel.org>; Fri, 18 Oct 2019 02:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7FxPhRl5F+3R9MJyEiBG1nv7912AFnLxP6yR6x0JisE=;
        b=LyIQOg9dVPJ7WxO5X2jVDN3O6ZHIMVW6k3v+Hw59BCQGzlXFly4pLXN8ovWH3pITGY
         AvKJJUMkswM+8D0NMjG+Hc+0YqvZvNFB9rTgXs0gPLrwI167/yWNzjnyH1HcALl55pP0
         6aUxg3HYD7Aes9dLirfEQ/MWBeW/MGZF6Xj0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7FxPhRl5F+3R9MJyEiBG1nv7912AFnLxP6yR6x0JisE=;
        b=ucaviWYlpwwj2Ywd/vOiCUYrjpxW2XnhADvwAJ2n1O/gUuVvrkrRSjNMLgmLyty3Xa
         mKlwPIZaqh4P9+LbeuTkXubs2TpnlOYEVcSpwckwobP0x5w5yFNskoPwHoED+HmsVgBM
         aSFek429tfDIhqKIuIDV9jfKfJz9ckwws9wAGpafelYgYtptdqSYgPlT7UUp8s33ZfA+
         CSafSMqz6Jdkb5BrOON7/pagUyJFiG7wALtnXpal217IbdWDMzDLilZCOV0g1ZBp8uaQ
         4QDtT0ggS0mxXjvrQnXSho9OT/hdHCX7gr0cgx2xHa2OJU41FWGvcIYxhS7OXNMaAj0Y
         kJkQ==
X-Gm-Message-State: APjAAAX90RF1U00yR/WBNCjElXwP0d/CV2Q3j6CBTtayKJgPWoouN4Uq
        cRTH+BT3RfVC/EmWva3PK6MDb1+O7uI=
X-Google-Smtp-Source: APXvYqw4l3OpE/FRcB2vRP9f6rGY+F0wAozRsdeRQqgB7EFoq/ex1azyM9GDpfb7tS7AN9OIPttWHQ==
X-Received: by 2002:ad4:50c2:: with SMTP id e2mr8702572qvq.67.1571389212335;
        Fri, 18 Oct 2019 02:00:12 -0700 (PDT)
Received: from [192.168.1.190] (pool-108-15-23-247.bltmmd.fios.verizon.net. [108.15.23.247])
        by smtp.gmail.com with ESMTPSA id z6sm2469600qkf.125.2019.10.18.02.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 02:00:11 -0700 (PDT)
Subject: Re: [PATCH userspace] sepolicy: generate man pages in parallel
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20191014080647.19602-1-omosnace@redhat.com>
 <d6755428-b0bd-1d88-69f7-0dd953eb7300@tycho.nsa.gov>
 <CAFqZXNsMVm2OmWOTiMaKybkhX8Zerp6rDeFfEd0UwhZRiNuNXQ@mail.gmail.com>
From:   Chris PeBenito <pebenito@ieee.org>
Message-ID: <511ca06c-7786-1b90-4694-a5cb842a8fca@ieee.org>
Date:   Fri, 18 Oct 2019 05:00:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNsMVm2OmWOTiMaKybkhX8Zerp6rDeFfEd0UwhZRiNuNXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/18/19 3:44 AM, Ondrej Mosnacek wrote:
> Since there are plans to support
> only Python 3 in 3.0+ this may not be an issue, but I could also add a
> few lines to fallback to sequential execution under Python 2 for the
> sake of compatibility. Would that be OK or should I not bother?

Python 2 end of life is in less than 2 months.  Please don't add new 
code only for Python 2 compatibility.


-- 
Chris PeBenito
