Return-Path: <SRS0=MU1A=5P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2B7C43331
	for <selinux@archiver.kernel.org>; Mon, 30 Mar 2020 13:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D8620733
	for <selinux@archiver.kernel.org>; Mon, 30 Mar 2020 13:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="XlEJVwUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgC3NFi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:05:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42474 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbgC3NFh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Mar 2020 09:05:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id t9so14875263qto.9
        for <selinux@vger.kernel.org>; Mon, 30 Mar 2020 06:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HPFYTm8rBugEI1VD9vpw672WdO7Arw9oh3IR7kBQNyY=;
        b=XlEJVwUXtQzc4Yc8jYg6LPX+dh63flG8UjagBXc+rzzjrxXnUsQc+2B5XTOb3HIE6k
         RRQRAJwCftir3x8nDq9+XI0hpFSrBj5u4dPKf1lBynKPiNV1ISPbBHv565niskI7S6vF
         2uN9zs1VttQi7hkEs4d5Sd01JDYeWaGvR0hMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HPFYTm8rBugEI1VD9vpw672WdO7Arw9oh3IR7kBQNyY=;
        b=V5fbvfIl7VXGa7h7OpB9JfZDEi2YrAvb0+kMBKQ5nAwuyHzxbZ9ZdIXRHMp51aOjLZ
         6JWydATecNmOJLpTSUkFB98aksoUKd0Ot+V1LH29g3aLi2kQn7M2QezfNx9kBddYiOtm
         CB/DiytoLpn0utlWQuq1gtPG0rp3HIKzlbDXbCqRWsYdpyw6AcYpd80NxCNljvEGOkZL
         eOmCZwcWhxifUbmnk38H0kb5vuyTT4YPHGEuM8m3LiQCnJyiDS46Wc/Rn1eTJ3v+vvJ6
         80V44Vx5pzbIKk9Ba/owEqNCawTtJZOHfzg83sZLifwqfrmV25E2sjwbPVbEmLVaLr7v
         OzaQ==
X-Gm-Message-State: ANhLgQ3dRL3KNwHbzD+gllyzscyb7pFn1Qz3u3ReZQOT8HGo9Ir2ZfyF
        3t544efrmsNlFtfz5MEB8H8anwWsdl4=
X-Google-Smtp-Source: ADFU+vuQcD0sj2xLQbZHi4cC2WXwf4BP139LK5USe2FJ3CXRjttDmasNKlwL2aZ+mepSvREFkHk4BA==
X-Received: by 2002:ac8:2921:: with SMTP id y30mr11455492qty.161.1585573534443;
        Mon, 30 Mar 2020 06:05:34 -0700 (PDT)
Received: from fedora.pebenito.net (pool-108-15-23-247.bltmmd.fios.verizon.net. [108.15.23.247])
        by smtp.gmail.com with ESMTPSA id q7sm190195qkn.118.2020.03.30.06.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 06:05:33 -0700 (PDT)
Subject: Re: [PATCH 0/2] userspace: Implement new format of filename trans
 rules
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20200327152107.95915-1-omosnace@redhat.com>
 <daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov>
From:   Chris PeBenito <pebenito@ieee.org>
Message-ID: <7549b0e2-f845-1c3a-d9d5-314cb2b9225f@ieee.org>
Date:   Mon, 30 Mar 2020 09:05:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/27/20 3:21 PM, Stephen Smalley wrote:
> On 3/27/20 11:21 AM, Ondrej Mosnacek wrote:
>> These patches are the userspace side of the kernel change posted at [1].
>>
>> The first patch changes libsepol's internal representation of filename
>> transition rules in a way similar to kernel commit c3a276111ea2
>> ("selinux: optimize storage of filename transitions") [2].
>>
>> The second patch then builds upon that and implements reading and
>> writing of a new binary policy format that uses this representation also
>> in the data layout.
>>
>> See individual patches for more details.
>>
>> NOTE: This series unfortunately breaks the build of setools. Moreover,
>> when an existing build of setools dynamically links against the new
>> libsepol, it segfaults. Sadly, there doesn't seem to be a nice way of
>> handling this, since setools relies on non-public libsepol policydb
>> API/ABI.
> 
> I think this has happened before a few years ago when we made a 
> different change to those structures, and required updates on the 
> setools side.
> 
> Maybe we need to figure out what setools needs to be encapsulated and 
> exported as part of the libsepol public ABI/API, and then stop having it 
> peer into libsepol internals?

I'd be fine with that :)

Ultimately SETools does 2 thing for the policy access:
* iterate over the entire policy, reading data out of the various objects
* use linkages between objects in the policy, e.g. get the 
type/attributes from an AV rule, get types from an attribute, etc. using 
the stuff like class_val_to_struct as needed.

So if sufficient functionality to do dispol was exported, that would get 
close to all that was needed.  There are some optimizations I made by 
digging at the structs a bit more than the above, but that could 
potentially be dropped if libsepol has sufficient support.  See 
<https://github.com/SELinuxProject/setools/blob/master/setools/policyrep/selinuxpolicy.pxi#L673> 
for the policy loading code.


-- 
Chris PeBenito
