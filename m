Return-Path: <SRS0=0msR=X3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D521C10F14
	for <selinux@archiver.kernel.org>; Wed,  2 Oct 2019 20:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1173520673
	for <selinux@archiver.kernel.org>; Wed,  2 Oct 2019 20:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ColS0Ai6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfJBUIt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:08:49 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38847 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfJBUIt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Oct 2019 16:08:49 -0400
Received: by mail-ot1-f49.google.com with SMTP id e11so301810otl.5
        for <selinux@vger.kernel.org>; Wed, 02 Oct 2019 13:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Mr3B/DhRcstKqug5MUWD/B0NUXceCQUfNeXL+JFTgGc=;
        b=ColS0Ai6uPlYqrle3BUF9ukErKoIX6JKI/PA0u+AM86q/oLrC8BVTfjwV1rfBvwm4W
         xque4yi7npIIJn/LCDo6iewFW9ZQ5dLp2Kb1PxglqU0/Foi0qBsvgTw9Vwb68y9Y85OH
         BP/2iwwFgp9ud63y6OcOEkPe9I4/6ITRGGaH3gq+rar0AJBRhyap5VgDGivr/CQKY2wQ
         y2MQLSqm54xh2Ufa5KRmiJ3QDw1Frp8bGdXutNf/DVsQ063kN/ZmVHenqcfebAwLTteS
         RoQmpOqeA7gffybpjRsdWXxqYIJh4aGpQDnR8zrIdSa3fPfudM9MUzIuEcOnQT8/ZnT1
         sa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mr3B/DhRcstKqug5MUWD/B0NUXceCQUfNeXL+JFTgGc=;
        b=Yol0bGihbYfJ8Xa3z3uqY90Mz+StX4Ii/g+F9Wq8Js/yp0ynBTEq2VOJehpWdU3wqS
         TSurfRH4D9ywAEV5ikpAkS3Br8x0xOxJMITeUNyf0uilhrYMQr7KbknpqFjbWIWqE6go
         4sY/v1sQfugBeRpb+98Bwqy4WyOC7Y+vbCWVpomkHkjpvgVYmstVXkrT6ukWN3+KIZKj
         HAlyT61tc/F14RqGICVfm01sqJz6xpXgPVJXLdSqJaVEkHOSDJqvoHw4PtCj6nh1zK8B
         +xAzt3uZyJwPzELUixmah4GlMFZArWX/HkXfm2OcpxcYK9avCcXpS2rGqyM+1aIjM0eK
         wALw==
X-Gm-Message-State: APjAAAXyBj+1Kkvn1vVYZtABJs9sL7KN73uS+cujwz3cvE3WM3MW3uod
        zi8KGfJHoY8Jzc8O5wr9+wtwV/Qs
X-Google-Smtp-Source: APXvYqyrCysLD0OikxSDBxK0rYLPGyvzmCoXh/SJkP+QKIIR9YFXO25W92V8UJY3OkezxGWsJTVPmQ==
X-Received: by 2002:a9d:404:: with SMTP id 4mr4181140otc.204.1570046928091;
        Wed, 02 Oct 2019 13:08:48 -0700 (PDT)
Received: from ian.penurio.us ([2605:6000:8c82:1efa:222:4dff:fe4f:c7ed])
        by smtp.gmail.com with ESMTPSA id 21sm133655oin.26.2019.10.02.13.08.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 13:08:47 -0700 (PDT)
Subject: Re: execve silently blocked
To:     selinux@vger.kernel.org
References: <43c6d9cc-bf9f-b729-2a0c-54a73fa79fdc@gmail.com>
 <20191002194100.GB1167620@brutus.lan>
From:   Ian Pilcher <arequipeno@gmail.com>
Message-ID: <9f7730fd-fd01-3a56-aebb-ddea8cf6df19@gmail.com>
Date:   Wed, 2 Oct 2019 15:08:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002194100.GB1167620@brutus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/2/19 2:41 PM, Dominick Grift wrote:
> Are you also looking for "selinux_err" records?

Nope, because I had never heard of them before.  :-)

That found the error:

   type=SELINUX_ERR msg=audit(1570044939.773:845):
   op=security_compute_sid
   invalid_context=system_u:system_r:denatc_sudo_t:s0
   scontext=system_u:system_r:denatc_t:s0
   tcontext=system_u:object_r:sudo_exec_t:s0 tclass=process

It seems that I was missing a role-type statement:

   role system_r types denatc_sudo_t;

Adding that gets me back to more conventional denials, which I know how
to deal with.

Thanks!

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
