Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1009BC4361B
	for <selinux@archiver.kernel.org>; Tue,  8 Dec 2020 15:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC38623A7B
	for <selinux@archiver.kernel.org>; Tue,  8 Dec 2020 15:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgLHPhV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Dec 2020 10:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730148AbgLHPhV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Dec 2020 10:37:21 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A921DC0613D6
        for <selinux@vger.kernel.org>; Tue,  8 Dec 2020 07:36:40 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id 7so12203920qtp.1
        for <selinux@vger.kernel.org>; Tue, 08 Dec 2020 07:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d1l06EzuXi1Z/ejrQbyaJmmkIf7TrkQv6PGe4mdpQIM=;
        b=KJ3Vui96V3oUtQctr6LZeqjF+gUimkL/U8WIDxixUrpEOo968ShOSKeFeQ/mHHV7aO
         LktihjF2peiw+69zTG0GTYreuw1SpUweSowo6IjeM4lvCjVfKEGFAtDW2zjio0di+9KE
         /4PvT+uX9c4if0zKYKiajq+J80dN26eH4qaCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d1l06EzuXi1Z/ejrQbyaJmmkIf7TrkQv6PGe4mdpQIM=;
        b=FL3VVuNTDuRmBScmLdqyGwrqcr3iDmxUY0V0k3ZcMU8ZoVNjRWUs2XN6+EDpykBeNd
         wUeedjUFDGa6eX16LoJnoe7ZdWCJskCYRqeSf6OdSIuQsyqSoR0KpMFBEpO/imLhCR/o
         N2ueGglmWmMbAAOd0seatUbmxnLTqxPhmkoYS9+gAj3VyklFiHruUwBEv9HlGYJnosTj
         z4wtfO+yUORsab/G0tQWD7m5Bvm3qnd8IHQ4cFMjy4Cgd9KIuXZDwPpleikWDGwmGHKy
         G7Xx/7kzyjHzRKLEHFgDnqVAcXd4FBnLMwQ2waLrONVTMYxBVAhB5AqommoXwJqtiRc1
         yQ2A==
X-Gm-Message-State: AOAM533q1TCfM9x7YVbMBOTO85V4MyZ5bjZHX5FVeQVXwEZOQkcp+DU2
        64dXZTGJqGk5qFGn1iaME5CWIW9ndXW4uQ==
X-Google-Smtp-Source: ABdhPJzgvTIgIAdBxSbwMmULxl+bc/UmoplJVq3BWAu45uGJO5InvMYcG89UjdeuEkQRR3gCaKMv/w==
X-Received: by 2002:ac8:877:: with SMTP id x52mr31217761qth.334.1607441799475;
        Tue, 08 Dec 2020 07:36:39 -0800 (PST)
Received: from fedora.pebenito.net (pool-96-234-173-17.bltmmd.fios.verizon.net. [96.234.173.17])
        by smtp.gmail.com with ESMTPSA id y22sm4772822qkj.129.2020.12.08.07.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 07:36:38 -0800 (PST)
Subject: Re: How is policy.31 created from modules under /usr/share/selinux
To:     Ashish Mishra <ashishm@mvista.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux-refpolicy@vger.kernel.org, Paul Moore <paul@paul-moore.com>
References: <CAP2OjcjCFYiyMfqa=X__X6g0U0143U5Fd-xGaKJgGNabFUpr7w@mail.gmail.com>
 <858c9383f7c75e1e39bafaeab6388cd6af902c4f.camel@btinternet.com>
 <CAP2OjciTWXRsYWw9VtOJGUOGj9B35HMXBHF94O6Qc=csg5=Spw@mail.gmail.com>
 <e82841a8b652f4b4b697ba1e417fdac56f443adb.camel@btinternet.com>
 <CAP2OjchJjMo8zMVvHk-_esu-53E0=367yV8cuZtwQwubi7+q=Q@mail.gmail.com>
 <0b58a502b5036e8b92b274068fbea53ca915992e.camel@btinternet.com>
 <CAP2Ojcg7DgQsEHJP3TZj=Q9NjZjqb3ugw+D2UYC4qmqt-PcZWw@mail.gmail.com>
From:   Chris PeBenito <pebenito@ieee.org>
Message-ID: <2806a33b-87ad-61b1-9143-5a24d770a180@ieee.org>
Date:   Tue, 8 Dec 2020 10:36:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAP2Ojcg7DgQsEHJP3TZj=Q9NjZjqb3ugw+D2UYC4qmqt-PcZWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

(SELinux main mail list to BCC since this is a refpolicy question.)

On 12/7/20 8:26 AM, Ashish Mishra wrote:
>   4)  Further debugging I can confirm that the final binary (policy.31)
> seems to be
>        using HARD-CODDED location of /etc/selinux instead of what is
> being passed as DESTDIR.
>       The policy.31 is created not at custom-embedded-rootfs location.
> 
>        Due to this :
>          - policy.31 is created in /etc/selinux/refpolicy/policy/policy.31
>            instead of what i was expecting at
> /tmp/custom-embedded-rootfs/etc/selinux/refpolicy/policy/policy.31
>            as DESTDIR=${ROOT}  and i do get *.pp at the expected
> location of /tmp/custom-embedded-rootfs/etc/selinux/refpolicy/src/policy
>                   ${MAKE} -C ${ROOT}/etc/selinux/${PKG}/src/policy load
> DESTDIR=${ROOT}


I can't reproduce your issue.  I use monolithic policy regularly in the way 
you're using it.

Here's the Makefile variables:

 From Makefile:
   topdir := $(DESTDIR)/etc/selinux
   installdir := $(topdir)/$(strip $(NAME))
   policypath := $(installdir)/policy

 From Rules.monolithic:
   loadpath = $(policypath)/$(notdir $(polver))

$(notdir $(polver)) is "policy.31" and NAME is what you have in build.conf, e.g. 
"refopolicy".


Then the install target for monolithic looks like this (with "echo"s removed):

$(loadpath): $(policy_conf)
         @$(INSTALL) -d -m 0755 $(@D)
         $(verbose) $(CHECKPOLICY) -U $(UNK_PERMS)  $^ -o $@

-- 
Chris PeBenito
