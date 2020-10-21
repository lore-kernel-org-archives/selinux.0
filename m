Return-Path: <SRS0=8FG4=D4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1041C561F8
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 12:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D9A82224B
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 12:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="K9VGQj6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394263AbgJUMHg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Oct 2020 08:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440016AbgJUMHg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Oct 2020 08:07:36 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A1AC0613CE
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2020 05:07:35 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 19so1344828pge.12
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2020 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=renYeGFy+byovKS92mhx+JvqyqsOEhO2ATHuCg5tTi8=;
        b=K9VGQj6ulHMm3bTaCkxIHUoh3/hNg65KK9p3fGBfY5wVnOM9whj7Tbjth1hYYZVpv7
         jd3FSvvu5rGOQHyYIIEJDLrBSLGq0xyWclqzu+g8AkM/lam1exqkr5N0hp3T94TcJutd
         Gs+zbx8NoKrg69NU3nyY5lZUlrlwkkR/UlP1T4RR36xN35tRnwjVXRHGxRQcO0L+I2PZ
         L8KokFmjGhy20HJRZF9NtV0Yh1YxqtfNA2FI1hZdTqywZ92TK7ygF0lNKACG+Mpf1uAX
         lPXGz3cwi7ow3CEVPE/JTr2R5JX2bHBy9/1PrlU9kAZvW9QJ2S4kmaNZdedU3+OL9P4k
         XOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=renYeGFy+byovKS92mhx+JvqyqsOEhO2ATHuCg5tTi8=;
        b=sCrS4yXEGBF2bH52r0mwEMKTAYNOaQPSAC+rt1c5KgZRzD1qsbK4K/OC1vzt8ynYAb
         X4dBovMgqPmodSCGSiz39WZWDYyZde90h3/DBeXkJBtKV8Oz56pSIUz/wS2LpKOB7t+s
         +rEIhldHqKresZsEbwJV7L2ovtsH+b2FU9yJoIzirSy9TuUnGC9s2QQyoAsrqB96vtlf
         4/suA2eCArf4W1MsB0jloyh4X9cwZgwdCETX3JNiPH8puyfKRjvpYSC1hmnl0l8ckBW7
         150YZQUAO+Z3+uwD+vxPXDC3ensmeQPE7v1iDes36jMuqmYhVMlC1u2zHPXiGWZng9bG
         MNzg==
X-Gm-Message-State: AOAM533fgbeKZPMZoRltBX7xtGMfgdCQIvUIPb/ABkFWd+k9oOEzD75f
        MIu/mmYWQUbNuFPQ5EKMdOgXFs6zmyEMdQ==
X-Google-Smtp-Source: ABdhPJwo8qGuoJxbH7a3pubNFBv4Mar/AFVZevkcLKo9gH1fVyuDgwomRnOjXA9GKl62VhL5YiVUqg==
X-Received: by 2002:a63:1c4e:: with SMTP id c14mr3034455pgm.98.1603282054928;
        Wed, 21 Oct 2020 05:07:34 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:4a0f:cfff:fe35:d61b])
        by smtp.googlemail.com with ESMTPSA id f21sm2183491pfn.173.2020.10.21.05.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 05:07:34 -0700 (PDT)
Subject: Re: [PATCH v17 1/4] Add flags option to get xattr method paired to
 __vfs_getxattr
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        David Sterba <dsterba@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
References: <20201020191732.4049987-1-salyzyn@android.com>
 <20201020191732.4049987-2-salyzyn@android.com>
 <CAHC9VhTZitGFRCnRgLJLNUnFEhM0kp7E_51No1aam3CRf-WCpg@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <ba6516a2-0d7a-3733-f974-943d296a1c15@android.com>
Date:   Wed, 21 Oct 2020 05:07:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTZitGFRCnRgLJLNUnFEhM0kp7E_51No1aam3CRf-WCpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/20/20 6:17 PM, Paul Moore wrote:
> On Tue, Oct 20, 2020 at 3:17 PM Mark Salyzyn <salyzyn@android.com> wrote:
>> Add a flag option to get xattr method that could have a bit flag of
>> XATTR_NOSECURITY passed to it.  XATTR_NOSECURITY is generally then
>> set in the __vfs_getxattr path when called by security
>> infrastructure.
>>
>> This handles the case of a union filesystem driver that is being
>> requested by the security layer to report back the xattr data.
>>
>> For the use case where access is to be blocked by the security layer.
>>
>> The path then could be security(dentry) ->
>> __vfs_getxattr(dentry...XATTR_NOSECURITY) ->
>> handler->get(dentry...XATTR_NOSECURITY) ->
>> __vfs_getxattr(lower_dentry...XATTR_NOSECURITY) ->
>> lower_handler->get(lower_dentry...XATTR_NOSECURITY)
>> which would report back through the chain data and success as
>> expected, the logging security layer at the top would have the
>> data to determine the access permissions and report back the target
>> context that was blocked.
>>
>> Without the get handler flag, the path on a union filesystem would be
>> the errant security(dentry) -> __vfs_getxattr(dentry) ->
>> handler->get(dentry) -> vfs_getxattr(lower_dentry) -> nested ->
>> security(lower_dentry, log off) -> lower_handler->get(lower_dentry)
>> which would report back through the chain no data, and -EACCES.
>>
>> For selinux for both cases, this would translate to a correctly
>> determined blocked access. In the first case with this change a correct avc
>> log would be reported, in the second legacy case an incorrect avc log
>> would be reported against an uninitialized u:object_r:unlabeled:s0
>> context making the logs cosmetically useless for audit2allow.
>>
>> This patch series is inert and is the wide-spread addition of the
>> flags option for xattr functions, and a replacement of __vfs_getxattr
>> with __vfs_getxattr(...XATTR_NOSECURITY).
>>
>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Acked-by: Jan Kara <jack@suse.cz>
>> Acked-by: Jeff Layton <jlayton@kernel.org>
>> Acked-by: David Sterba <dsterba@suse.com>
>> Acked-by: Darrick J. Wong <darrick.wong@oracle.com>
>> Acked-by: Mike Marshall <hubcap@omnibond.com>
>> To: linux-fsdevel@vger.kernel.org
>> To: linux-unionfs@vger.kernel.org
>> Cc: Stephen Smalley <sds@tycho.nsa.gov>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-security-module@vger.kernel.org
>> Cc: kernel-team@android.com
> ...
>
>> <snip>
> [NOTE: added the SELinux list to the CC line]


Thanks and <ooops>

>
> I'm looking at this patchset in earnest for the first time and I'm a
> little uncertain about the need for the new XATTR_NOSECURITY flag;
> perhaps you can help me understand it better.  Looking over this
> patch, and quickly looking at the others in the series, it seems as
> though XATTR_NOSECURITY is basically used whenever a filesystem has to
> call back into the vfs layer (e.g. overlayfs, ecryptfs, etc).  Am I
> understanding that correctly?  If that assumption is correct, I'm not
> certain why the new XATTR_NOSECURITY flag is needed; why couldn't
> _vfs_getxattr() be used by all of the callers that need to bypass
> DAC/MAC with vfs_getxattr() continuing to perform the DAC/MAC checks?
> If for some reason _vfs_getxattr() can't be used, would it make more
> sense to create a new stripped/special getxattr function for use by
> nested filesystems?  Based on the number of revisions to this
> patchset, I'm sure it can't be that simple so please educate me :)
>
It is hard to please everyone :-}

Yes, calling back through the vfs layer.

I was told not to change or remove the __vfs_getxattr default behaviour, 
but use the flag to pass through the new behavior. Security concerns 
requiring the _key_ of the flag to be passed through rather than a 
blanket bypass. This was also the similar security reasoning not to have 
a special getxattr call.

[TL;DR]

history and details

When it goes down through the layers again, and into the underlying 
filesystems, to get the getxattr, the xattributes are blocked, then the 
selinux _context_ will not be copied into the buffer leaving the caller 
looking at effectively u:r:unknown:s0. Well, they were blocked, so from 
the security standpoint that part was accurate, but the evaluation of 
the context is using the wrong rules and an (cosmetically) incorrect avc 
report. This also poisons the cache layers that may hold on to the 
context for future calls (+/- bugs) disturbing the future decisions (we 
saw that in 4.14 and earlier vintage kernels without this patch, later 
kernels appeared to clear up the cache bug).

The XATTR_NOSECURITY is used in the overlayfs driver for a substantial 
majority of the calls for getxattr only if the data is private (ie: on 
the stack, not returned to the caller) as simplification. A _real_ 
getxattr is performed when the data is returned to the caller. I expect 
that subtlety will get lost in the passage of time though.

I had a global in_security flag set when selinux was requesting the 
xattrs to evaluate security context, denied as a security risk since 
someone could set the global flag. I had a separate special getxattr 
function in the earlier patches, denied for security issues as well, and 
others took issue with an additional confusing call site. I added the 
flag parameter, and that satisfied the security concerns because the 
value was only temporarily on the stack parameters and could not be 
attacked to bypass xattr security. This flag passed to __vfs_getxattr 
was also preferred from the security standpoint so that __vfs_getxattr 
got the _key_ to bypass the xattr security checks. There was a brief 
moment where the get_xattr and set_xattr calls shared a similar single 
argument that pointed to a common call structure, but th as requested by 
a few, but then denied once it was seen by stakeholders.

