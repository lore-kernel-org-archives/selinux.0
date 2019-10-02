Return-Path: <SRS0=0msR=X3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7879DC4360C
	for <selinux@archiver.kernel.org>; Wed,  2 Oct 2019 23:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A70921D82
	for <selinux@archiver.kernel.org>; Wed,  2 Oct 2019 23:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5IR+c+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfJBXTw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:19:52 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:39451 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfJBXTw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Oct 2019 19:19:52 -0400
Received: by mail-oi1-f176.google.com with SMTP id w144so907614oia.6
        for <selinux@vger.kernel.org>; Wed, 02 Oct 2019 16:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=V1CZqB39y3QK2vFdd27oU3/4DG5AgZ4a4XhqloeiB9E=;
        b=R5IR+c+Hy2jL6Pcvthi2J25UDAPQnJVHQzsJFgf2AhUXcI91+9Gj3nULhsr+N5sU16
         TJgCzlVd8G2QSfOT4i+c3wkLBrLR1pXDcnx+1ga3eZ+6nYnVJNGYJ4vqaza3qfyLDrWU
         rab0x5PR6gN3BOUwZPSHWnEKauS9HjiO0aSBiAqsVyNUCy2u/03n+uWxQ4bkqq8mq2gG
         sdJE56qYs35dvy5eF83Ck99SdDkqPFMpTn1XKT5I2ylsSBV88QVQMx92G2WkCxFCIMqa
         pVNYL67vilKPQtoQLkXdCxdWqyi0BqOZ3Mrm1WeRx7SE/oB5/jON1/7S0v36moBSmw3p
         Q1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V1CZqB39y3QK2vFdd27oU3/4DG5AgZ4a4XhqloeiB9E=;
        b=PFT8YnY0UEqADaLjz0Nw8B4vx8K3GZaqBwXwdsn8CMeNv38NN7LQV0VFYkqdu+48N+
         F9XHpmi3M0A4+74xxCSDzeg9I2maTbDpvhAQsO1TiaSCDRWFptmxtbWLGsIEeZ/1ydNd
         reT9bJRX7vv5iAolnJr5rnXBZqp+XRyLYcboEWBxXmFbQtCfN4epBgg2AF78BYbt4H/P
         xTGqR3KCfWctwPqTzIl7L6Iudh+fSgW1Ki3FTGaiQDiUiWNbN61ilBCgeMeNib4eg+E2
         4T77v9dJmFfkzd15yhYdfEyO9zYkpnKOUdFE8OLgEgS5iCi5Ni2e+H09B8n2//cQJAiQ
         0qQg==
X-Gm-Message-State: APjAAAV0B3MaslmSHUvrOE/OVjkyXlKjx4l09pV9n/Oxov4QoX+YSmEU
        3xCUr7GXxgkIFQl/IPFBIYtgovyH
X-Google-Smtp-Source: APXvYqy/fUBgxxrG09+9Yu/YD64wcPdYWnGpCGCOALFBP3KINoMbp9Euk+/S6esIC18Ea9QJ/IUIlw==
X-Received: by 2002:aca:d988:: with SMTP id q130mr434017oig.13.1570058391382;
        Wed, 02 Oct 2019 16:19:51 -0700 (PDT)
Received: from ian.penurio.us ([2605:6000:8c82:1efa:222:4dff:fe4f:c7ed])
        by smtp.gmail.com with ESMTPSA id t22sm289084otc.9.2019.10.02.16.19.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 16:19:50 -0700 (PDT)
Subject: Re: Failed to resolve typeattributeset statement
From:   Ian Pilcher <arequipeno@gmail.com>
To:     selinux@vger.kernel.org
References: <7fb2cb6d-69c2-1471-bb9c-0abc52130e17@gmail.com>
Message-ID: <c3676f35-40ff-0ace-2e9a-6e9a0bfa2ffa@gmail.com>
Date:   Wed, 2 Oct 2019 18:19:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <7fb2cb6d-69c2-1471-bb9c-0abc52130e17@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/2/19 6:15 PM, Ian Pilcher wrote:
> type=AVC msg=audit(1570051321.409:1773): avc:  denied  { getattr } for 
> pid=3682 comm="sudo" path="/usr/bin/systemctl" dev="dm-0" ino=12586503 
> scontext=system_u:system_r:denatc_sudo_t:s0 
> tcontext=system_u:object_r:systemd_systemctl_exec_t:s0 tclass=file 
> permissive=0
> 
> I would have expected this to be simple.  Add the following to my
> policy:
> 
> require {
>      type systemctl_exec_t;
> }
> 
> allow denatc_sudo_t systemctl_exec_t:file { getattr };

And it is simple ... if one uses the correct type:

   systemd_systemctl_exec_t

Sorry for the noise!

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
