Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0743EC25B72
	for <selinux@archiver.kernel.org>; Thu, 26 Oct 2023 10:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjJZKyL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Oct 2023 06:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344742AbjJZKyJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Oct 2023 06:54:09 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C661AD;
        Thu, 26 Oct 2023 03:54:03 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso1415230b3a.1;
        Thu, 26 Oct 2023 03:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698317643; x=1698922443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XwYRquauhAMHXFV0AdY3ecVlLyi7pDehYgKjNqxEadM=;
        b=E4rpbI6qCEvatB0Lv5hRcj5ZGW7pFCnLdUqP1/hCQD7ChQU0vakKDd8h0ABqheJm0i
         z2ENzWjWez5je5FQV2eBFJWihEBEjJ43uFGxCyYhW81IGFKpapVPApiO3ne5/el2aj9l
         D25IyJLYZmAaCv9P9GP/0VKtHYh7on7ySl+siWixzIcozZQlIyUeOHrApCoqyAynvyqt
         V0CVwbzBj3ghv98a2k8ssi6D/+JyrSPDVvMssURQNx7fzGzApL8GdnP3I02fdvmIY0ER
         q1N7IbehEfqgFI9pgQuL+ueS1O5+OrLdmCbEBVLSK8qXccV/PWhI6BlGobLCch/NCPZL
         q6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698317643; x=1698922443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwYRquauhAMHXFV0AdY3ecVlLyi7pDehYgKjNqxEadM=;
        b=oqgCh4o/sNnIB53BppzULRApwmAuuIrAOv4dho6wy/jQsJCz6Plitfi7M/LTNoMOgq
         2GWxPTemcBp1fi9ThVbnOC57fEgZ08MX+ZXuzkarKlJGNTaiEVOlezdTeb+SJr29fOaP
         DmPnVTvvRJUDuZFKgmsZPPG06gA7O1sFgU9J0fubKxNX4lzorLaeokRO4IGerC3nBGNV
         9yh66YjwwWcImQePGTrC5kPDsqyzsxaNUNm4d2JV3xTRn5srtpdyEpQNTu+apL9XU8go
         ch/XEn0CXsyuKiksPmEonXLfUpQxqsbKot1j0WEzDVGnbcOzDesXVPq5F+C1L3IOVeX5
         iKCw==
X-Gm-Message-State: AOJu0YwaGA7D8uNm60hHJBfNN5amTKpq6WhFG/810lRC3BFSJRKR03mK
        8ikwE/TNylTSKHJEmrgpIlTM8VFSIfI=
X-Google-Smtp-Source: AGHT+IEaeIIB/EtXex0/4qu1S8zb23wewp8plWaFw2j68eA6lH/pfKNow9i1BFuA6hmb/O2NdM2I5w==
X-Received: by 2002:a05:6a20:7348:b0:159:e4ab:15ce with SMTP id v8-20020a056a20734800b00159e4ab15cemr2822279pzc.15.1698317642763;
        Thu, 26 Oct 2023 03:54:02 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p66-20020a625b45000000b0068fe5a5a566sm11784645pfb.142.2023.10.26.03.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 03:54:02 -0700 (PDT)
Message-ID: <2019bc57-716f-4d34-8f09-a7182d344c86@gmail.com>
Date:   Thu, 26 Oct 2023 17:53:58 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ANN: kernel git branches and process changes
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux Security Module Subsystem 
        <linux-security-module@vger.kernel.org>,
        SELinux Mailing List <selinux@vger.kernel.org>,
        Linux Kernel Audit <audit@vger.kernel.org>
References: <CAHC9VhS1wwgH6NNd+cJz4MYogPiRV8NyPDd1yj5SpaxeUB4UVg@mail.gmail.com>
 <ZTm_9Bj1XYTzL0Za@debian.me>
 <CAHC9VhSeqEbtdno0mx-J53SSwCcsUr8_Ovj3QVji7rzbYS9bGw@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAHC9VhSeqEbtdno0mx-J53SSwCcsUr8_Ovj3QVji7rzbYS9bGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 26/10/2023 09:16, Paul Moore wrote:
> On Wed, Oct 25, 2023 at 9:25 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>> On Wed, Oct 25, 2023 at 05:11:51PM -0400, Paul Moore wrote:
>>> #### stable-X.Y branch
>>>
>>> The stable-X.Y branch is intended for stable kernel patches and is based on
>>> Linus' X.Y-rc1 tag, or a later X.Y.Z stable kernel release tag as needed.
>>> If serious problems are identified and a patch is developed during the kernel's
>>> release candidate cycle, it may be a candidate for stable kernel marking and
>>> inclusion into the stable-X.Y branch.  The main Linux kernel's documentation
>>> on stable kernel patches has more information both on what patches may be
>>> stable kernel candidates, and how to mark those patches appropriately; upstream
>>> mailing list discussions on the merits of marking the patch for stable can also
>>> be expected.  Once a patch has been merged into the stable-X.Y branch and spent
>>> a day or two in the next branch (see the next branch notes), it will be sent to
>>> Linus for merging into the next release candidate or final kernel release (see
>>> the notes on pull requests in this document).  If the patch has been properly
>>> marked for stable, the other stable kernel trees will attempt to backport the
>>> patch as soon as it is present in Linus' tree, see the main Linux kernel
>>> documentation for more details.
>>>
>>> Unless specifically requested, developers should not base their patches on the
>>> stable-X.Y branch.  Any merge conflicts that arise from merging patches
>>> submitted upstream will be handled by the maintainer, although help and/or may
>>> be requested in extreme cases.
>>>
>>> #### dev branch
>>>
>>> The dev branch is intended for development patches targeting the upcoming merge
>>> window, and is based on Linus' latest X.Y-rc1 tag, or a later rc tag as needed
>>> to avoid serious bugs, merge conflicts, or other significant problems.  This
>>> branch is the primary development branch where the majority of patches are
>>> merged during the normal kernel development cycle.  Patches merged into the
>>> dev branch will be present in the next branch (see the next branch notes) and
>>> will be sent to Linus during the next merge window.
>>>
>>> Developers should use the dev branch a stable basis for their own development
>>> work, only under extreme circumstances will the dev branch be rebased during
>>> the X.Y-rc cycle and the maintainer will be responsible for resolving any
>>> merge conflicts, although help and/or may be requested in extreme cases.
>>>
>>
>> If I have patches targetting current (not next) release cycle, either for
>> stabilizing that cycle or for stable backports, I have to base it on dev
>> branch (not stable-X.Y), right?
>>
>> Confused...
> 
> I would prefer that yes.  I know it sounds a little odd, but I'd
> rather see folks develop and test against what we believe to be the
> latest subsystem code, which is what lives in the dev branch.  If
> there are merge conflicts, I'd rather we see them when merging the fix
> into the stable-X.Y branch so we are aware of the conflict at
> development/submission time rather than waiting for the next merge
> window.  Having done this for a number of years at this point, I've
> learned to appreciate seeing merge conflicts as early in the
> development cycle as possible and I've also learned that they are
> often not as scary in practice as we imagine.
> 
> Of course all of this is a general rule since you can't specify every
> single situation in guidance like the above; if there is something
> that you believe is particularly ugly you can always write the mailing
> list, or me directly if the issue is sensitive, and we can sort it
> out.  If after a few months (year?) this proves to be too painful we
> can always revisit this and update the policy, it's definitely not set
> in stone.
> 
> Hopefully you are less confused now?
> 

OK, thanks for clarification!

-- 
An old man doll... just what I always wanted! - Clara

