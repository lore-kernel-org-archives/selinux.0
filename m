Return-Path: <SRS0=n8ca=RC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD0DC43381
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 03:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39DC218E0
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 03:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="NucSXVXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfB0DiF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Feb 2019 22:38:05 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:43768 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfB0DiF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Feb 2019 22:38:05 -0500
Received: by mail-pl1-f173.google.com with SMTP id m10so7260268plt.10
        for <selinux@vger.kernel.org>; Tue, 26 Feb 2019 19:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=ihUjUTstiPSSFNNGqMgLu0OBV+MHiB0Xf5Rx+dbg/uE=;
        b=NucSXVXOrh/RR6S+4hpP9HfnF6i1IaWjVOuVbVt5clnR8D9HHH1l51mAN3SgOUdAdd
         fyaz8xZu08N9L2RGU3evUf5XT4ykMHG5B9k5n0IKBETs3AR1cnysrlmMvjlm1J32NTsV
         s9+E6iObKo73bK89ZGg0ODEqqiSXyNqB79Dh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ihUjUTstiPSSFNNGqMgLu0OBV+MHiB0Xf5Rx+dbg/uE=;
        b=pIpp4I9mxOng997naL8v2KZWQHCCd4bAvSJ/NzlvYJgaHbiU9rsmS1ewtyL1i+PJ6S
         cJNqi5Y8pzl0fopufTaH0AU2wLVg1+s5IrDBaFfbZigabKkAcoivccyd9zp89QV6fWPW
         UA7yc/DUUiNXB5DprbmRLYV5PbxkaIcQ9fj3M0V944WTp0Dnhk2HiDF+IPyGIOA4F3Fm
         +dzPgaKk1xHzmdHVcXllTJh7Jjbfi28m9Ycsr2RUt7QzL7paY6oE28skV/NILAEHWk9S
         12TBg+gBwYRjnYX9U9zZ57b2QwX2W+LNfuqyTienGex6A3tqJzk3eznMTt07c2KtScmY
         pQvQ==
X-Gm-Message-State: AHQUAuYhGXipyvD9h3dlwVzpSEySldOHVLaIGObs/S3GTuBaS9Hube87
        ERXcohn1FyD5dvRBmHwxBJhXa8SnU9M=
X-Google-Smtp-Source: AHgI3Ibr73QodkYdeHlUAKF5Fny3EgfBrAlKXGWjtgkjFaakSGS5uS0rSCakXmR7uYA1GlUbS2FjtQ==
X-Received: by 2002:a17:902:a7:: with SMTP id a36mr19137146pla.267.1551238684495;
        Tue, 26 Feb 2019 19:38:04 -0800 (PST)
Received: from lenovo.pebenito.net ([173.239.195.110])
        by smtp.gmail.com with ESMTPSA id g6sm19791514pgc.22.2019.02.26.19.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 19:38:03 -0800 (PST)
Message-ID: <6d65bb0be6bd5ccbdb1f99a646679e21955d6159.camel@ieee.org>
Subject: Re: neverallow rules
From:   Chris PeBenito <pebenito@ieee.org>
To:     Joe Nall <joe@nall.com>, selinux@vger.kernel.org
Date:   Tue, 26 Feb 2019 19:38:01 -0800
In-Reply-To: <10D60D97-3E05-4F8C-86B5-8A56FCEFB3B1@nall.com>
References: <10D60D97-3E05-4F8C-86B5-8A56FCEFB3B1@nall.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2019-02-26 at 19:29 -0600, Joe Nall wrote:
> Looking at neverallow rules, the semanage.conf file says
> "# expand-check check neverallow rules when executing all semanage
> commands.
>  # Large penalty in time if you turn this on. "
> 
> If I don't set expand-check=1, are the neverallow rules actually
> enforced?

Nope.

> If so, when?
> 
> An semodule -i of a policy module with neverallow rules that are
> violated by the existing binary policy succeeds without complaint
> unless expand-check=1 in RHEL 7.6. This is not what I expected.
> 
> The time taken by a trivial module installation goes from ~.3 seconds
> to ~14 seconds, so the time hit for expand-check is pretty serious.

The reason for adding the expand-check option is because the neverallow
checking is so expensive.

> We are trying to establish some policy invariants to protect against
> unexpected/unnoticed RHEL upstream policy changes, some of which have
> bitten us recently. Any suggestions are welcome.

One alternative would be to use the setools API to code up some policy
searches in Python, then process the results to find things you
do/don't want in your policy.

-- 
Chris PeBenito


