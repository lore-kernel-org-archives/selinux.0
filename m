Return-Path: <SRS0=nReO=7T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57723C433DF
	for <selinux@archiver.kernel.org>; Sat,  6 Jun 2020 12:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F1F206A2
	for <selinux@archiver.kernel.org>; Sat,  6 Jun 2020 12:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUrTAsZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFFM1S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 6 Jun 2020 08:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgFFM1R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 6 Jun 2020 08:27:17 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3CEC03E96A
        for <selinux@vger.kernel.org>; Sat,  6 Jun 2020 05:27:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z9so14966463ljh.13
        for <selinux@vger.kernel.org>; Sat, 06 Jun 2020 05:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=3DMuy0B5ea+gtw0i3oqGcmO5UpSDFl7M05svc5HPspU=;
        b=mUrTAsZ1jTJQu+IXabvAAgGkgtMCyCOY80enEgVbNCp1fBOp4m9cwtGnvp645+BYA3
         0PcZhiuuThm8raHVoeQkW5ZdOJkX98V1Fj5T2IySVfNCsqsWsXgH45xGpwt8QQ+uGeiu
         NkReiUwoHO+b2gkIYH/TC1n6/08DVhAVgEQJCHvL0zSDS/0y2wJbIPXLGAU0r8SoK2sR
         /Z30AQYBSUZBHjVd43WJImPFrMjWtKu+XL+Eq0bdBRgUkwG/IswtGiuls3MFLHXriRCw
         L/CqqYXOqYqBqvsQ7XW2koWTwRoL+ilfqSTai6kxGcrmkUkaKCmhocxuh4TWzWZP7Kxw
         r27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=3DMuy0B5ea+gtw0i3oqGcmO5UpSDFl7M05svc5HPspU=;
        b=UrR16sYnM7lb+oNKP4DXTBSULpdNFzbxQNSF/njlxoiXfofagxNqrj7U8AaWiMB8Ps
         q+koLGSb7AafYpOZ5oU/q6N1Yfy7aFgloikfQklt7eCZiXJzCWs0YCz8pftf/5M+racQ
         4nlSUyoFcr/wf7z/CxuxPOa2cb4P/ZaBaspPdwaaw0Rfo+Gwarik/t6fV1D9uJ7ce39l
         Zrn+tQW0zOBN4aMyp4LOe1VwiwPmE9lQzUb1q1zfnD1VdV3eq4lyO02mxNixBrkYkEJe
         PEMP302iqWJ/lGlmK03i8kvpD4/2qyi5+klirvhVimdMiOcyDNwonrlGwg1Ycn02J8B+
         jMww==
X-Gm-Message-State: AOAM532Nz2wFAsk/UxsJv69shKPZrIQageKNrHXNp6sJSRzFnAGexn9m
        orJ8EYw1wzC6Vo/pYYz6+2w9buhA
X-Google-Smtp-Source: ABdhPJxttJ2n77Lvnl7jNbj2QSxEMULEe5d/qbKW25cTul4btcZzpgfdHNA48VDxDB9/8rGOgDPDQg==
X-Received: by 2002:a05:651c:1199:: with SMTP id w25mr7293722ljo.301.1591446434121;
        Sat, 06 Jun 2020 05:27:14 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id o23sm2490980lfg.0.2020.06.06.05.27.12
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2020 05:27:13 -0700 (PDT)
To:     SElinux list <selinux@vger.kernel.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Subject: Better management of dynamic networks?
Message-ID: <06f4b748-470d-8774-ffbb-5e342f6fcba8@gmail.com>
Date:   Sat, 6 Jun 2020 15:27:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

I have a SELinux setup for networks, where packets, nodes, interfaces 
and peers are labeled and subject to TE rules. In general the system 
works very well and I'm thankful to be able to control network access 
for each individual application in great detail.

I'm still learning SELinux, so maybe I have missed something, but it 
seems to me that these systems have been designed with rather static 
network configuration in mind. For example, I have classified IPv4 and 
most of IPv6 addresses to loopback, localnet (e.g. 10.0.0.0/8), 
multicast and "internet" node types. This can be used with a fixed set 
of TE rules. But when using a laptop, actually the rules for local 
network should depend on whether I'm at home, at a friend's place or 
some random public network and then there are VPNs.

The interfaces and peers are labeled with netlabelctl, but the 
interfaces change when kernel modules are loaded and removed for 
interfaces and it's also possible to plug in a USB network adapter any 
time. With Netlabel it's possible to label peers without modifying the 
policy (for example during boot), but `semanage node` and `semanage 
interface` require writable policy. Netlabelctl can't label an interface 
if the interface does not exist yet, but I've opened a PR for a possible 
workaround.

The tools don't support for example pattern matching for interfaces. It 
would be nice to assign SELinux labels based on various properties of 
the interface and network, for example with udevd, systemd-networkd or 
NetworkManager, without requiring policy rebuild.

A minor issue is that reference policy also has rules which allow 
network access when using the default initial types (netif_t, node_t). 
It could be preferrable that new network interfaces would not get labels 
which allow access. In my case I've tried to make sure that the initial 
types are never used. Perhaps the related rules could simply be made 
optional.

I suppose using CIPSO/CALIPSO/Labeled IPsec can solve some of these 
issues when you can positively identify the other parties in a network, 
but they are not fit for general Internet access or when the network is 
friendly but not under your control.

So, what could be done to lift these restrictions (if they really exist 
and I haven't missed something obvious)?

-Topi
