Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F3FC433F5
	for <selinux@archiver.kernel.org>; Sat,  1 Oct 2022 07:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJAHOR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 Oct 2022 03:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiJAHOP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 Oct 2022 03:14:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE36DC843E
        for <selinux@vger.kernel.org>; Sat,  1 Oct 2022 00:14:12 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d42so9988766lfv.0
        for <selinux@vger.kernel.org>; Sat, 01 Oct 2022 00:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date;
        bh=cpmjFORbr//2vmlhvIVl1KCxQ/6eZe8hTAlXuY9YIFY=;
        b=aaDrUAMugZgDdeS86ISF9kSd6M7xlSWSiSYnaTubcA7nBgz6Z3xQV4Z+C+qzVNLkVp
         aBVRpuQDT4L43MLQCz0GilTGPz/N82qe0gitYBKhEAeT1ut8k/NTzJrs3l0Z8GQLTOgQ
         yoz6uAxEwiUkDtUX8RGLnjuT5AmbjnC+DkwDm4Sj7ONPjHEnOfxNJtPMmQvsYioGR5dq
         xuinNXhEegg+LK/sbL7EHInuuxMiQp9mQtS9iVRtBuxwqkQm3oKDbpGSe9qAJvqS7sIY
         d50tzT70lVup/RqEJfkzpfJv4+damP14IiFQWlYXHDWI+l1iM6mRs7qTTZU/JAgNPYv6
         LHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cpmjFORbr//2vmlhvIVl1KCxQ/6eZe8hTAlXuY9YIFY=;
        b=7YvVwzUDn51pGGaCvbc0dIEOPqaKWE6ShcWepJPMTEh5Q2nUctW5+u4aOy3Cls5v9W
         mq7zY8Ab8UajwMhiJJriN9OXmCCjoI6B0mxMVKv0d3XqIIFCOflzq97Qiv8KupjwATP2
         tWwDaqEUfU0Q4eqB/rqJWErgESgwJQ7RUFcieKNKLE43SmuS4dZro40oR8YJg37fk69u
         uED3M//KzEYuWzURLdUv+J0Oc8HC77DIzapmr/31/FbYMifiAxw6kVZWMxTeOMy9Falj
         iPuE91Rn0/9LxAh7eL+/ekX6/+kqzZkwbjyr1b+ENhrrr3660zG2G1U6YG1Zi/Gdw/Rl
         IHmg==
X-Gm-Message-State: ACrzQf3X+sx2aBwitxW7Rrdxx9g/XJeI1w1Jg6nekz3K5diwlLMIimq3
        9noQ0ePxoABgVmMcX5ji5PKvrDU7Yh4=
X-Google-Smtp-Source: AMsMyM4npIVBzXjb+z73aX4XSHbzikIwz8MLZ3QaSe9V7Y8ArXa5osy0luDFkPaJsLcHSB6UkrvNdA==
X-Received: by 2002:a05:6512:39d6:b0:498:f615:df07 with SMTP id k22-20020a05651239d600b00498f615df07mr4243122lfu.387.1664608451035;
        Sat, 01 Oct 2022 00:14:11 -0700 (PDT)
Received: from [192.168.1.8] (81-197-199-207.elisa-laajakaista.fi. [81.197.199.207])
        by smtp.gmail.com with ESMTPSA id g14-20020a056512118e00b0048b0099f40fsm649423lfr.216.2022.10.01.00.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 00:14:10 -0700 (PDT)
Message-ID: <584c2285-0c86-8e31-77ad-4ad2e31931b7@gmail.com>
Date:   Sat, 1 Oct 2022 10:14:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] docs: update the README.md with a basic SELinux
 description
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <166457327058.375622.15969426802353557144.stgit@olly>
Content-Language: en-US
From:   Topi Miettinen <toiwoton@gmail.com>
In-Reply-To: <166457327058.375622.15969426802353557144.stgit@olly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1.10.2022 0.27, Paul Moore wrote:
> This is to help meet the OpenSSF Best Practices requirements.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>   README.md |   19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/README.md b/README.md
> index 74b0a0c3..306d9ed6 100644
> --- a/README.md
> +++ b/README.md
> @@ -7,13 +7,18 @@ SELinux Userspace
>   [![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
>   [![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)
>   
> -Please submit all bug reports and patches to <selinux@vger.kernel.org>.
> -
> -Subscribe by sending "subscribe selinux" in the body of an email
> -to <majordomo@vger.kernel.org>.
> -
> -Archive of this mailing list is available on https://lore.kernel.org/selinux/.
> -
> +SELinux is a flexible Mandatory Access Control (MAC) system built into the
> +Linux Kernel.  SELinux provides administrators with a comprehensive access
> +control mechanism that enables greater access granularity over the existing
> +Linux Discretionary Access Controls (DAC) and is present in many major Linux
> +distributions.  This repository contains the sources for the SELinux utilities
> +and system libraries which allow for the configuration and management of a
> +SELinux-based system.
> +
> +Please submit all bug reports and patches to the <selinux@vger.kernel.org>
> +maling list.  You can subscribe by sending "subscribe selinux" in the body of

s/maling/mailing/

> +an email to <majordomo@vger.kernel.org>.  Archives of the mailing list are
> +available at https://lore.kernel.org/selinux.
>   
>   Installation
>   ------------
> 

