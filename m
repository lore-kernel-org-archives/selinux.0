Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234EFC433F5
	for <selinux@archiver.kernel.org>; Sat, 25 Sep 2021 21:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FE5604D2
	for <selinux@archiver.kernel.org>; Sat, 25 Sep 2021 21:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhIYVNS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 25 Sep 2021 17:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhIYVNS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 25 Sep 2021 17:13:18 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE124C061570
        for <selinux@vger.kernel.org>; Sat, 25 Sep 2021 14:11:42 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id q81so28681504qke.5
        for <selinux@vger.kernel.org>; Sat, 25 Sep 2021 14:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7C3TXYgtlHwfruABSgsT4wF8tBAEdb2jIzgPQ8s7VG4=;
        b=QvwK3MWiqIjwHGvvlC72Nozrew9AB/iYfN+bXZkBOhTyEgshp9I7kSiwUOWHuWCqNs
         dN8yyMjZDtSrfNS3svvt44yRC8S5b/3B7tOQcsu1SRWZHGvA1QqRiNjgDZ/POl/Egmkq
         AzhVdZo8IcE8QlBIUMigTKBQs03WcIF+XzEfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7C3TXYgtlHwfruABSgsT4wF8tBAEdb2jIzgPQ8s7VG4=;
        b=acVm2fDsrZBYvTfiw5Igs8dCsYH8qg7MaNVwsA+0of+G5Ifa5oWHIdnC9x/b/Ad4oC
         grkIWjCoGsTDvmqOen0RKzFlgj+WoWEfvKoMBNiy31CMqWDwv0gbRPOsfOOTO/qqWd+y
         T2odPObvTqgCbzl6j1wblTUijhI9x9ztpmcPO44tupXl0KBOH42/lFw+xzpBltjArLAP
         wPR2lyMk4rhGSpLelzwJUIR+/8WPnMwz4LwiDPMfWiFdRXo/EOysjt5GOdWdy3E+2/dy
         CPWayI7LSP0TEgwB2AuFtgcJHqGgm486tOWoVMb/cGKxn2rmdWWBZt1LwbUHG07ax2t+
         dZwA==
X-Gm-Message-State: AOAM530wOEouxKfu3uq05ai2483CDUn2w41xFDJfPbDOQQ+OfUA0Kljq
        EHQa5PdDhWbbzqlIt2vcjInBPr2yDVTxAQ==
X-Google-Smtp-Source: ABdhPJwyCSqr84gC+zpL7fx8SAzAlbX+8yGd8GdOA17SXdaI61Twm+ekQQScKbO+CLA2zKwxJgKSVQ==
X-Received: by 2002:a37:6658:: with SMTP id a85mr17409596qkc.34.1632604301484;
        Sat, 25 Sep 2021 14:11:41 -0700 (PDT)
Received: from fedora.pebenito.net ([72.85.44.115])
        by smtp.gmail.com with ESMTPSA id f24sm7790146qtq.25.2021.09.25.14.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Sep 2021 14:11:40 -0700 (PDT)
Subject: Re: [PATCH setools] __init__.py: Make NetworkX dep optional
To:     Jason Zaman <jason@perfinion.com>, selinux@vger.kernel.org
References: <20210919130904.59107-1-jason@perfinion.com>
From:   Chris PeBenito <pebenito@ieee.org>
Message-ID: <9af75de8-ffc4-abd2-2768-12f113a231b9@ieee.org>
Date:   Sat, 25 Sep 2021 17:11:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210919130904.59107-1-jason@perfinion.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/19/21 9:09 AM, Jason Zaman wrote:
> selinux commit ba23ba068364ab11ff51f52bd1e20e3c63798a62
> "python: Import specific modules from setools for less deps"
> Makes userspace tools only need specific parts of setools so that the
> NetworkX dep can be dropped for minimal installations.
> Unfortunately the __init__ still imports the parts which require
> NetworkX. Wrap them in try except to guard for missing NetworkX.
> 
> $ semanage export
> Traceback (most recent call last):
>    File "/usr/lib/python-exec/python3.9/semanage", line 29, in <module>
>      import seobject
>    File "/usr/lib/python3.9/site-packages/seobject.py", line 33, in <module>
>      import sepolicy
>    File "/usr/lib/python3.9/site-packages/sepolicy/__init__.py", line 15, in <module>
>      from setools.boolquery import BoolQuery
>    File "/usr/lib/python3.9/site-packages/setools/__init__.py", line 94, in <module>
>      from .infoflow import InfoFlowAnalysis
>    File "/usr/lib/python3.9/site-packages/setools/infoflow.py", line 24, in <module>
>      import networkx as nx
> ModuleNotFoundError: No module named 'networkx'
> 
> Bug: https://bugs.gentoo.org/809038
> Signed-off-by: Jason Zaman <jason@perfinion.com>
> ---
>   setools/__init__.py | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/setools/__init__.py b/setools/__init__.py
> index d72d343..e583737 100644
> --- a/setools/__init__.py
> +++ b/setools/__init__.py
> @@ -91,11 +91,20 @@ from .pcideviceconquery import PcideviceconQuery
>   from .devicetreeconquery import DevicetreeconQuery
>   
>   # Information Flow Analysis
> -from .infoflow import InfoFlowAnalysis
> +try:
> +    from .infoflow import InfoFlowAnalysis
> +except ImportError:
> +    # NetworkX is optional
> +    pass
> +
>   from .permmap import PermissionMap, RuleWeight, Mapping
>   
>   # Domain Transition Analysis
> -from .dta import DomainTransitionAnalysis, DomainEntrypoint, DomainTransition
> +try:
> +    from .dta import DomainTransitionAnalysis, DomainEntrypoint, DomainTransition
> +except ImportError:
> +    # NetworkX is optional
> +    pass
>   
>   # Policy difference
>   from .diff import PolicyDifference

I'd prefer that it emit an INFO message saying something like "NetworkX isn't 
available; Information Flow Analysis is unavailable", rather than being silent 
about it.

-- 
Chris PeBenito
