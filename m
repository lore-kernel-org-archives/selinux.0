Return-Path: <SRS0=LEY+=7R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C81FC433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 21:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3157C206DC
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 21:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ylsm/dk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgFDVew (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgFDVew (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Jun 2020 17:34:52 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F34AC08C5C0
        for <selinux@vger.kernel.org>; Thu,  4 Jun 2020 14:34:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 82so4524190lfh.2
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2020 14:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R/R4O/rUcOk49ymyGoTx/dpXSRvO+efKixAwDjqCmi8=;
        b=Ylsm/dk+bGIxMfGJI8kUkN9nLkvCDoLV7mvQ5PZLl8cYHsHmEVnnABZWy2zq8pbdLs
         5Ii4sFx/lngvebAjXt+ivlyZGk42GOeY89emDQBfl+XmvuEMcHhOdGpAACFTVR61pdqU
         2AdaYRT6dqtDkrZVn0dsFiShPH5uVZQTtdMuHFXvWILbvZXBs3JzcvpnZAfvZZ8+q/Dc
         nOFHX0TI83U46AXJi/D+5/T+iJGye0JMU94hpXJpyhEjuvNpNqIzMm8HjKrD6uk8GHti
         /jap10Y25L81jO3Lf+sV593xIUB4UOz7z1JBEGlpCbNRDfjqF7CR4xSLec+oGQwlmRUj
         xz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R/R4O/rUcOk49ymyGoTx/dpXSRvO+efKixAwDjqCmi8=;
        b=kAOs/8QX2Urs4HsBMsoyrw1CgHP36F2h06NoQ+nfsf9Wb5E6k1/NIwILZNNahoDD53
         Thx2UyYsFxj9bzrueoaerbF9TUGGFv6tIPjMBS2nKB5GaJXVWoa8gBgevoaO/vuYcc/h
         BNWlDorj9Z/yoLZ8ApenSdMhl/8SUzwF01DSK9C9rM1LxX0058SRvDazCEFEO/qZkW+D
         byGF29dbIolhrNQWiWtTD55947jhjdy1PfLjYGjgKJ8FFwMX/i4bKFIiQIJklEEeldyC
         vdM1ActNZnEA7xXpIPe4WU2tyHg3W12cVt9r9/PqTCmJtZ+Z6NOXlpVSKvYnhpLS2pPO
         gu+g==
X-Gm-Message-State: AOAM5335RPoXYQqJyynFYu1wBB8NkDkCc4wG7buvNrP3NLs+y2lnO2nS
        Oaz+h6rZjoEiVPtip6AEFzfqnm2O
X-Google-Smtp-Source: ABdhPJzYC6URMtYc7yoecqifQ4+QzP4p3Y7q1RnTPYr+vyPFkN8C6iJP83sQSw55KJ8BbzmH57S2Fw==
X-Received: by 2002:a19:c3c5:: with SMTP id t188mr3561636lff.149.1591306489464;
        Thu, 04 Jun 2020 14:34:49 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id t5sm182160lff.39.2020.06.04.14.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 14:34:47 -0700 (PDT)
Subject: Re: [PATCH] Avoid using getprotobyname()
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20200602141935.24722-1-toiwoton@gmail.com>
 <CAEjxPJ6t2xyQ54y83AN5bMJuHMRwi=4haEFXCR6Fw9JhdqcqhQ@mail.gmail.com>
 <CAHC9VhRHHOB+kmpg0tjJ5YNyY5SGnobS=HE_QW8PyVURDKFKCQ@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <400bd691-450d-8e00-169f-04b561ac07eb@gmail.com>
Date:   Fri, 5 Jun 2020 00:34:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRHHOB+kmpg0tjJ5YNyY5SGnobS=HE_QW8PyVURDKFKCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4.6.2020 23.40, Paul Moore wrote:
> On Thu, Jun 4, 2020 at 4:30 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Tue, Jun 2, 2020 at 10:21 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>>>
>>> At least on Debian, /etc/protocols, which is used by
>>> socket.getprotobyname() to resolve protocols to names, does not
>>> contain an entry for "ipv4", so let's avoid using
>>> socket.getprotobyname() since the protocol names are not used in
>>> socket context anyway.
>>>
>>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>
>> Only concern I have here is that it could change the resulting audit
>> record content. Not sure how the audit people feel about that.
>> Maybe ask on linux-audit mailing list?
> 
> If/when you do, it would be good to show before/after audit records.
> However, record formatting is a very tricky issue and it's best to not
> change them unless absolutely necessary.

Right, let's not change it.

One solution would be to try to resolve "ipv4" first and if it fails, 
try something else. On Fedora "ipv4" resolves to 4. For Debian "IP" 
would be 0 and 4 can be found with "ipencap".

The original problem was that the protocol "ipv4" is not accepted by 
"semanage node":
# semanage node -a -t internet_node_t -p ipv4 -M /4 208.0.0.0
OSError: protocol not found

This makes me believe that nobody before me had ever used "semanage 
node" successfully on Debian. Therefore there shouldn't be compatibility 
issues with old audit logs, but I suppose it's better to try to match 
the value used by Fedora (4), so "ipencap" would be a better choice or 
perhaps simply hardcode the value as 4 if "ipv4" does not resolve.

-Topi
