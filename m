Return-Path: <SRS0=Kca8=BP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3ABC433E0
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 12:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CE8206D7
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 12:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQz4D+WN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgHEMlN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Aug 2020 08:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgHEMgj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Aug 2020 08:36:39 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF433C034617
        for <selinux@vger.kernel.org>; Wed,  5 Aug 2020 05:35:28 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id a19so14622348qvy.3
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2020 05:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=m2d+C57lAiG6bL8T9Mp4uI3V1kykEd/A23ppTi7YgsA=;
        b=ZQz4D+WNjmsLLzlFBM7QzLg1l7n3fyPWY2Lc9sjf0oWkIgaRSkips2fXYD2KpsURa6
         38ILvMptlfDEBpQBfqTiNhgIIcGwyn5Xzd+nvfaOwiY/Caim3bBFLBo9INYw+pFnHwQP
         bPc1EZ6T02iR2/CDcmSMwt5qT5bNVSrqC3XFmfnI0ltgNL1paMQ1ClJPbraLD2FjxTUm
         9E+p7IvMJ6d4C6vsI4MZrzD48JybZyx+WapbANMwVVHyZVwAm137JZ03/pkRdonW7Vba
         Z8u6h69NLOQAU5KCuBonyZGFK0E6l5IBeNFYjLbaB1lrQHvEWTp3zbVwIcztHfXSvJIX
         CQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=m2d+C57lAiG6bL8T9Mp4uI3V1kykEd/A23ppTi7YgsA=;
        b=RVuRD2G974ako2azkD5oWjYRDr5cmOSS/ufu/XTaxBEpO4oUnA6o3FKxQYSqnQ+P7a
         AQ/7pJJ4qE/hvfBsj503uO+1YizJgvRvJavM6Kj7YdRc1772X67QZ4dyRHDUcSMPOwCw
         onFlg1lhF2czkPETdJl3p1Jl39ydSxzZitofm3H8SIkZy8b0SHqMG6+50h2VWNuXoEc4
         sfaksYkk2moPnw5GETr14PWWFAnPN9m4YkRwz5Avt8nyMskNZjs5XuwSx8H0LuGyZwAl
         4GqbwXTkrfBPJFhutv/2dRc0L7e7Msv5+niuGwKwoEg/cjdiNGigfR/9WB+JWi1+2BEE
         gbfg==
X-Gm-Message-State: AOAM532b0DHFLifc2h/6VFXbnJF4BYbFhnjGolFsLIigFiWzj4+J2rQR
        fAseQnhwYNS24W0HSVlpPIkUVM72uhA=
X-Google-Smtp-Source: ABdhPJwBUlw9UtsAVoaegaHFmZ420mdLHesXFnVk++hX5Ix3i4Ybn0EIPnLdK9rP8FT91x1fo7D0mQ==
X-Received: by 2002:ad4:470f:: with SMTP id k15mr3356723qvz.216.1596630927549;
        Wed, 05 Aug 2020 05:35:27 -0700 (PDT)
Received: from [192.168.1.190] (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id g136sm1520539qke.82.2020.08.05.05.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 05:35:27 -0700 (PDT)
Subject: Re: [RFC PATCH] selinux: move policy commit after updating selinuxfs
To:     Daniel Burgener <dburgener@linux.microsoft.com>,
        paul@paul-moore.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org
References: <20200804135352.5650-1-stephen.smalley.work@gmail.com>
 <88c312b3-0abd-96ed-35c3-a80ab57a9fe3@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <685a0fd4-d5a2-0cc8-4b9d-ad39cf916b16@gmail.com>
Date:   Wed, 5 Aug 2020 08:35:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <88c312b3-0abd-96ed-35c3-a80ab57a9fe3@linux.microsoft.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/4/20 4:51 PM, Daniel Burgener wrote:

> On 8/4/20 9:53 AM, Stephen Smalley wrote:
>> With the refactoring of the policy load logic in the security
>> server from the previous change, it is now possible to split out
>> the committing of the new policy from security_load_policy() and
>> perform it only after successful updating of selinuxfs.  Change
>> security_load_policy() to return the newly populated policy
>> data structures to the caller, export selinux_policy_commit()
>> for external callers, and introduce selinux_policy_cancel() to
>> provide a way to cancel the policy load in the event of an error
>> during updating of the selinuxfs directory tree.  Further, rework
>> the interfaces used by selinuxfs to get information from the policy
>> when creating the new directory tree to take and act upon the
>> new policy data structure rather than the current/active policy.
>> Update selinuxfs to use these updated and new interfaces.  While
>> we are here, stop re-creating the policy_capabilities directory
>> on each policy load since it does not depend on the policy, and
>> stop trying to create the booleans and classes directories during
>> the initial creation of selinuxfs since no information is available
>> until first policy load.
>>
>> After this change, a failure while updating the booleans and class
>> directories will cause the entire policy load to be canceled, leaving
>> the original policy intact, and policy load notifications to userspace
>> will only happen after a successful completion of updating those
>> directories.  This does not (yet) provide full atomicity with respect
>> to the updating of the directory trees themselves.
>
> I have a patch series to perform the atomic updates very close to 
> done, using vfs_rename with RENAME_EXCHANGE to update the directories 
> out of tree and then swap them in as discussed earlier.  I've just 
> been doing some final style cleanup before sending to the list.  I'll 
> need to rebase on top of these changes of course.  I didn't touch any 
> of the error recovery portions, so I hope my series will complement 
> this patch nicely.

Great, I was trying to ensure that we wouldn't conflict/overlap 
significantly.

>> This patch is relative to my previous one,
>> https://patchwork.kernel.org/patch/11698505/. Although this does
>> not ensure atomicity when updating the selinuxfs directoty tree,
>> I suspect it will solve Daniel's original bug because systemd/dbusd
>> won't get the policy load notifications until the kernel is done
>> updating selinuxfs and therefore won't try to re-read selinuxfs
>> in the middle of it (because libselinux caches the class/perm
>> mappings and only flushes on a reload).
> I agree with your suspicion that this will resolve the bug we've been 
> seeing (although only as a result of changing the timing, as you point 
> out).  Thanks for your work on this!

If you can easily test that my patches resolve that bug for you, you 
could add a Tested-by tag.  One caveat is that it sounds like I'll be 
making one more change to the previous patch per Ondrej's request to 
avoid taking the read lock around sidtab_convert().

>>   @@ -563,15 +560,19 @@ static ssize_t sel_write_load(struct file 
>> *file, const char __user *buf,
>>       if (copy_from_user(data, buf, count) != 0)
>>           goto out;
>>   -    length = security_load_policy(fsi->state, data, count);
>> +    length = security_load_policy(fsi->state, data, count, &newpolicy);
>>       if (length) {
>>           pr_warn_ratelimited("SELinux: failed to load policy\n");
>>           goto out;
>>       }
>>   -    length = sel_make_policy_nodes(fsi);
>> -    if (length)
>> +    length = sel_make_policy_nodes(fsi, newpolicy);
>> +    if (length) {
>> +        selinux_policy_cancel(fsi->state, newpolicy);
>>           goto out1;
> As things stand as of this patch, I think that this means that in the 
> event of a failure in recreating the directories, that directory will 
> be left unpopulated or partially populated.  We could even get in a 
> state where the booleans directory has already been updated to the new 
> policy and the class directory has not. The full solution is of course 
> atomic swapover, which as I mentioned above I hope to submit a series 
> for soon, but I wonder if recreating the directories on the old policy 
> would be a better interim state?  That probably depends on what sorts 
> of errors are possible.  If we've failed because of something about 
> the new policy, recreating the old directories should get us back to a 
> good state.  If we can't create new directories at all for whatever 
> reason, trying to recreate might leave us worse off than before we 
> started.

I deliberately avoided any changes to the error handling during 
re-creation of the booleans and class directories because I viewed that 
as logically separate from my change and likely to conflict with your 
changes.  So I expect to revisit that issue after both my patches and 
yours land. I think the only scenario where sel_make_bools/classes() can 
fail is an out-of-memory condition and if we are out of memory then we 
are unlikely to be able to re-create the old directories/files again.  
Hence, I don't think there is anything useful we can do without the 
atomic swapover. At most, we can delete everything under booleans and 
class on any failure while re-creating so that we aren't left with the 
partial set of booleans/classes.

The other possibility I considered is explicitly checking whether there 
are any changes to booleans or classes between the old and new policies 
and if not, skipping that part of the selinuxfs update.  That however 
would require a new security server function to iterate over all of the 
booleans and classes in two selinux_policy structures and compare them 
for equality.  Didn't seem worth it if the atomic swapover support was 
coming anyway.


