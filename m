Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68126C433E0
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 12:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D93221E2
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 12:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+Z9qdoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgHGMUU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgHGMUH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Aug 2020 08:20:07 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1908C061574
        for <selinux@vger.kernel.org>; Fri,  7 Aug 2020 05:20:06 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s23so1052528qtq.12
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2020 05:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uEQuJw1c4daMGD8TkUIoBNG5wqA2NxEAtk5ZaZ2WpV4=;
        b=P+Z9qdoipCUucyhtOaek/AWXO9uLCyLF4sJR7aKlvh7imgu9/XoR0AWOl+fEafqhWN
         a/RVyY8B38ACTZgZFRoch8irxUP+GKC9Enpty6mNHi+3y/AEJGG7f7VM7K7tQl/zFpx6
         KUmunXvvubm1sB+feXFJWTuFYB+EIky74jLYmJIAcD9d/+JOsWep3yyA0XRYvPWvVpQr
         Ebd0E/ouJ4lmDz4IAN4wDCjP7hoWvI2C5UUmybdOhfyivVYgBg/idX8r83BU52uWcpRI
         pn3uzYquVErYn3fkFr8QNAmeDk5nl0XzSkXMwQuSsJUuWS3eASWk1Wda1BKmbrUSIfWx
         ERnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uEQuJw1c4daMGD8TkUIoBNG5wqA2NxEAtk5ZaZ2WpV4=;
        b=bpy4VOGQpWD5z1Yr8gqGW8Kcet8jDk8PV+xcgT9PDDmoALkXvDcA/E6LOOVh1a/2rT
         8e6OEhTDUHsZTxFDCEaduHBdkhj2mRxDSKOSMYnmubOViibDN5mXbNhnPX/cQ33QDv+W
         HPfzZtqH/NmdBUI6Uq7sD0vAdK9IjL1BDF87DKpyg59U1CNClS0DvhxhIcKcZg/s4f2V
         cVi/rfUbio5l5i4sVT+ZOKUOYxNZL9EWofOITCSxSnrjJy/8xUKFI8RUsLJo2BohPquw
         xiv6CxlBNWfPqqHwJ2OdRSCv1snNYOArxzphsd8QDhcXAgRSi2fKb1rwWAM33vwgdKbG
         kEPA==
X-Gm-Message-State: AOAM532Oq3eUafIfEXBpqD+yU3nhdORJs0LQFDT2p33sTXgXtrjeZ2VC
        ZSWz1i741b563qG1Qq/6+Mw=
X-Google-Smtp-Source: ABdhPJwhrMht9ucR5fC91ciASrojeYKK0kEsegPnjWQcxczLIL8/oNo9gUUSZHPbrJpshgmwBbKKaw==
X-Received: by 2002:aed:3c1c:: with SMTP id t28mr13520023qte.74.1596802805761;
        Fri, 07 Aug 2020 05:20:05 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id h13sm7437668qtu.7.2020.08.07.05.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 05:20:05 -0700 (PDT)
Subject: Re: [RFC PATCH v4 1/2] selinux: encapsulate policy state, refactor
 policy load
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        dburgener@linux.microsoft.com
References: <20200805155240.26473-1-stephen.smalley.work@gmail.com>
 <CAHC9VhTmXnHMGd8sD7343ANYkZD3RR_Tz=D2a2V8H9coOpvDNg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <39643c6a-c32e-8cd3-ba34-ac37155c314a@gmail.com>
Date:   Fri, 7 Aug 2020 08:20:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTmXnHMGd8sD7343ANYkZD3RR_Tz=D2a2V8H9coOpvDNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/6/20 11:41 PM, Paul Moore wrote:

> On Wed, Aug 5, 2020 at 11:52 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> Encapsulate the policy state in its own structure (struct
>> selinux_policy) that is separately allocated but referenced from the
>> selinux_ss structure.  The policy state includes the SID table
>> (particularly the context structures), the policy database, and the
>> mapping between the kernel classes/permissions and the policy values.
>> Refactor the security server portion of the policy load logic to
>> cleanly separate loading of the new structures from committing the new
>> policy.  Unify the initial policy load and reload code paths as much
>> as possible, avoiding duplicated code.  Make sure we are taking the
>> policy read-lock prior to any dereferencing of the policy.  Move the
>> copying of the policy capability booleans into the state structure
>> outside of the policy write-lock because they are separate from the
>> policy and are read outside of any policy lock; possibly they should
>> be using at least READ_ONCE/WRITE_ONCE or smp_load_acquire/store_release.
>> Restore the load mutex that was previously removed by
>> commit 89abd0acf033 ("SELinux: drop load_mutex in security_load_policy")
>> to make explicit the exclusion even though it is currently redundant
>> with the fsi->mutex held by selinuxfs; this makes clear that we do
>> not need to take the policy read-lock across sidtab_convert() and will
>> be useful in the future for lockdep checking.
>>
>> These changes simplify the policy loading logic, reduce the size of
>> the critical section while holding the policy write-lock, and should
>> facilitate future changes to e.g. refactor the entire policy reload
>> logic including the selinuxfs code to make the updating of the policy
>> and the selinuxfs directory tree atomic and/or to convert the policy
>> read-write lock to RCU.
>>
>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> ---
>> v4 does not take the policy read-lock across sidtab_convert() and
>> therefore does not require changing allocations by it to be atomic
>> or dropping the cond_resched() call.  To make obvious that taking
>> the policy read-lock is not necessary in security_load_policy(), restore
>> the load mutex to security_load_policy() that was removed back in
>> commit 89abd0acf033 ("SELinux: drop load_mutex in security_load_policy").
>> However, since we have refactored security_load_policy() in this change
>> to split out selinux_policy_commit(), we need to take the mutex in
>> security_load_policy() and release it in selinux_policy_commit().
> I'm not in love with the idea of splitting the lock/unlock across
> different functions, more below in the relevant code section.


Me either, but I see no alternative other than taking/releasing the 
mutex in selinuxfs, at which point it is truly no different than 
fsi->mutex.

> I can somewhat understand if you don't want to have all the old policy
> cleanup, reset, and notify code in security_load_policy(), but I
> really dislike that the mutex lock/unlock is split across the two
> functions.
>
> What if selinux_policy_commit() returned oldpolicy on success and we
> created a new function, selinux_policy_retire() (name?), that would be
> called from security_load_policy and could handle the cleanup, reset,
> and notify code.  The mutex unlock could happen between the calls to
> selinux_policy_commit() and selinux_policy_retire()?
>
> I'm open to other ideas as well.
>
I think if you look at the 2nd patch, you'll see that this won't work 
because security_load_policy() is then changed to return newpolicy to 
the caller, and selinuxfs then calls selinux_commit_policy() after 
updating selinuxfs.  In order to provide the full exclusion guarantee, 
we need the mutex held across both security_load_policy() and 
selinux_commit_policy(). At that point we'd have to take the mutex 
lock/unlock up to selinuxfs and we already have fsi->mutex there.  This 
load_mutex was just to document the exclusion guarantee at the 
security/ss/services.c level and provide something we could pass to 
lockdep for safety checking when/if we convert to RCU.  If you really 
don't like it (and I'm not super excited about it myself), then I think 
I'll just put a comment in security_load_policy() explaining why we 
don't need to take policy read-lock there and drop load_mutex.  Thoughts?


