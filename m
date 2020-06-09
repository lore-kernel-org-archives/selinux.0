Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0437BC433E0
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 08:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC972078D
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 08:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiFk4w6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgFIIdM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgFIIdM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jun 2020 04:33:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A17C05BD43
        for <selinux@vger.kernel.org>; Tue,  9 Jun 2020 01:33:11 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id n24so23914156lji.10
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2020 01:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V+c2UL+wWYIKX0mSmKyt0MVVCkbc5KYz0RHu7/mXoZ8=;
        b=BiFk4w6Q9LnhMW4WE2Olr69EfSHWoZlnW0/Xe0UHP0sWERJ5H8oy84Nulqc8qrYAxu
         aVhdHZdCq3sOEtBYXm5YYvH501l6JNHFdwAVygxy2fd1qQM6T9ZLTwhw20Hh5Cvw2m9s
         t9JK5zzSt0saM+EJ3k1jcCoCHTrnObTb4F1Gs/g3pAVsvjUwjzkHR3gXbgL1VmXo6S5C
         nac5rBBE3xt08mj9oCfFBWVYI3/moq7+4gSiJ5hAEY/5m7ximxuhG7Qxqs+4cN0JwJ0+
         NozuuiiIdN8QfGHCYus2OXO0qD/jtR8BDyAwqAO9qUeE5dctzwqG5jCbmDQ56TlUkEuO
         rBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V+c2UL+wWYIKX0mSmKyt0MVVCkbc5KYz0RHu7/mXoZ8=;
        b=oBGLhDKlUbA3YAsCT3nvc7vfQG2lwVfR8BX3yLCDX6sX+WPBzm7JA7nSAOHkRMQXZ9
         KsegwfkLRrTY2Z5lQQzj9FhlT81tDUjdrb6pgP9BXrmnoxWmGr9aB6EBIPHMnHCQAOhC
         KjN7fWf0zN3ui2RIajPVVS4DCXwILKMxpmkV65r8sucMIhu4kiB8WUON6XWTYkja4kOM
         x44qvnPKuyX1v03e7UGV6HRlJ1cJQL0lRGP+Ap3oonSWG7an6ZGJZ6P81/s+wB32Lhj9
         LirwCJ2/P1SkSuSAU+qgUMA6zzovjSKu9cm5msVRWRUyNinSJoDXcw3aXhxaQPV0MO2v
         PTWg==
X-Gm-Message-State: AOAM531tdbqM2g60f5DBcPCRNc0WamVQMpiOv9PaQkUnI3AjJ9NLVZHl
        0T6pwxv5c5N2n9SWB9SWBAyXThtm
X-Google-Smtp-Source: ABdhPJw5bTFk2ydkmGFxLBFvxgHp1q+Ie8HqsRNT4n9TptnfI6H0RFBwtqqBmWXy/mjZOY3nM73MIw==
X-Received: by 2002:a2e:b814:: with SMTP id u20mr14072583ljo.261.1591691588313;
        Tue, 09 Jun 2020 01:33:08 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id o18sm4198639ljd.32.2020.06.09.01.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 01:33:07 -0700 (PDT)
Subject: Re: Better management of dynamic networks?
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <06f4b748-470d-8774-ffbb-5e342f6fcba8@gmail.com>
 <CAHC9VhSjPqsb9ZCWKchhN2ParSR6XH+57jzc7fQ0FjxK28tZOA@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <1741fd62-ec03-9d70-d2b6-e1416cf8ae05@gmail.com>
Date:   Tue, 9 Jun 2020 11:33:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSjPqsb9ZCWKchhN2ParSR6XH+57jzc7fQ0FjxK28tZOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9.6.2020 0.16, Paul Moore wrote:
> I can't say I'm an expert on all the various userspace device
> managers, network or otherwise, but so long as they can execute an
> arbitrary command then one should be able to use them to label the
> device when it is added to the system.  Although perhaps we could make
> this easier with docs and/or tools.

Perhaps this could be solved at least partially by adding a layer of 
indirection. So instead of directly assigning TE rules to interfaces, 
nodes and peers, the rules could apply to type attributes (or something 
else). Then the interfaces, nodes and peers would be tagged somehow with 
suitable attributes. Preferably tagging should be a faster operation 
than rebuilding the policy, but the operation should still be controlled 
by policy.

So, instead of assigning for example localnet_node_t directly to subnets 
(which may have different levels of trust depending on the location) 
with commands (which rebuild the policy) like:

semanage node -a -t localnet_node_t -p ipv4 -M /8 10.0.0.0

there would be a static TE rule which states that networks with type 
(attribute?) 'trusted_localnet' get the label localnet_node_t. Then 
something else (what, how?) would assign the address ranges with the 
attributes when the network configuration (like interface up/down 
status, SSID, routing tables...) changes.

Likewise, instead of direct assignment like
semanage interface -a -t external_if_t -r s0 wlan0

there would be static TE rules which state that only interfaces with 
type attributes 'company_approved_model', 'not_random_usb_device', 
'company_authenticated_vpn' can get the label external_if_t. Then when 
new interfaces appear, something else (udevd? how?) would tag the 
interfaces with the attributes.

Would this solve anything?

-Topi
