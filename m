Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F52DC433DF
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 07:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E51207CB
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 07:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7RPJb4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgE0HCi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 03:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgE0HCh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 03:02:37 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4E8C061A0F
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 00:02:36 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so5101127ljn.4
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 00:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bsQ7X1Nyu50b/0LwBVNLTefGmhCHjAPf/cGkS9IutBM=;
        b=t7RPJb4uaqBA5CocpVurXK/nZURpalses3OpTnXoIzaynf+lltLczBZ6ivVE02xKTO
         Of8ZbBYQyFcUX/Zt9XrL1RuG1xHf9ohw8WCTswD0Wx4GTCTfG+EwT8r/kHdOnNmLJp2M
         NUjjfaEtCDvbMjzr3rBOcmngDA9K+2CIJoEZkf5+ztvzCOpsVXYgpOcA8aAF3amycclj
         QHZHvXJRfT6ibxiBpWmTmavNnnZF0Um4S5m16lSMCsYYTDOOL9KR2OnaZpli3ivDwFpV
         LpFqBGqIx/T7MmX80CdlQGEySDQHRNUM6aWHeRKmEmMGDBWSxw80vOUXtpBmPb83tp3N
         m2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bsQ7X1Nyu50b/0LwBVNLTefGmhCHjAPf/cGkS9IutBM=;
        b=VTrbJq/myLGb+wLgREiwMgv5V6mVPjPyT1u4p1Es/VuZCPcNDSIfyLDeUNJcgqhulV
         lXRSKeceqGV8eZA95CnhCd3oorSBG8zylhLZ5eONsq2qbeosrYEnxtInnKoGL4WFEutn
         OUOYRguaZlvMfPPr6yhJRBRNB9eLGi8XMa1XJ1V5a9YAE8GI1+nrsP4M5O+DQ/oVi+Jt
         7/W/Da+B9HZaZxh3L0FYAh9gzfXylhn+EZvVo+xKUSpfEO4uPosXZSY6CkkRtISgTBee
         pFeXkHA1cAgb4Ja2wLkojNFynuQ3+lPtUy2aOAGVHoUj0YPUSFZsmPeu+6ahRpycvOkt
         CVXw==
X-Gm-Message-State: AOAM531cwwzhpSnwYbJvJK9CGy7m54+V/D9GUjqdTFTDop4mjcZCAATM
        Fx4zHt5juSvbXKZm6/ZsSKefAuPJ
X-Google-Smtp-Source: ABdhPJw7UKohhj4owSTPDsLY3xCrOHP5S+Ba4Qlm1rSfCogYXzH0BH4ycs4FngP1JheEcWokQFo7vA==
X-Received: by 2002:a2e:87d7:: with SMTP id v23mr2380235ljj.334.1590562950228;
        Wed, 27 May 2020 00:02:30 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id u8sm594667lff.38.2020.05.27.00.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 00:02:29 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] libsepol/cil: Return error when identifier
 declared as both type and attribute
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
References: <20200526185058.42827-1-jwcart2@gmail.com>
 <20200526185058.42827-2-jwcart2@gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <0cd7a2db-3b3f-fb03-19f9-f8984a913833@gmail.com>
Date:   Wed, 27 May 2020 10:02:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200526185058.42827-2-jwcart2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 26.5.2020 21.50, James Carter wrote:
> CIL allows a type to be redeclared when using the multiple declarations
> option ("-m" or "--muliple-decls"), but make it an error for an identifier
> to be declared as both a type and an attribute.
> 
> Change the error message so that it always gives the location and flavor
> of both declarations. The flavors will be the same in all other cases,
> but in this case they explain why there is an error even if multiple
> declartions are allowed.
> 
> Fixes: Commit fafe4c212bf6c32c ("libsepol: cil: Add ability to redeclare types[attributes]")
> Reported-by: Topi Miettinen <toiwoton@gmail.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Thanks, this prevents mismatching declarations. Does this also fix the 
memory issue and prevent that buggy policy could get loaded sometimes?

-Topi
