Return-Path: <SRS0=Kca8=BP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D78CC433DF
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 19:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4096D206F6
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 19:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gdQb9kf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgHET21 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:28:27 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49966 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbgHERLb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Aug 2020 13:11:31 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id CA60120B4908;
        Wed,  5 Aug 2020 05:37:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA60120B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596631063;
        bh=JYxQh5HDRtdGXM5MNnERvMqtl0ye3vvdzDIHqIgr9iY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gdQb9kf4lUK5J+6cBCV7sBf3V3bJ87T2E/9NCIcqz7ORMCGIUKE4Zn/0UM5EViL3Q
         9iD8bIlOgrgzGqXQzPAm8va9ajjVY990wyIU9Q7gK8Q9VZzOAEPfudn/QHm67jRexA
         VG0bllM2MBxyNaknlRu2BK6e+Th5cBen+1gOo+gU=
Subject: Re: [RFC PATCH] selinux: move policy commit after updating selinuxfs
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        paul@paul-moore.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org
References: <20200804135352.5650-1-stephen.smalley.work@gmail.com>
 <88c312b3-0abd-96ed-35c3-a80ab57a9fe3@linux.microsoft.com>
 <685a0fd4-d5a2-0cc8-4b9d-ad39cf916b16@gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
Message-ID: <c4610708-3bc6-e5fe-29da-f07c1323eaff@linux.microsoft.com>
Date:   Wed, 5 Aug 2020 08:37:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <685a0fd4-d5a2-0cc8-4b9d-ad39cf916b16@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/5/20 8:35 AM, Stephen Smalley wrote:
> On 8/4/20 4:51 PM, Daniel Burgener wrote:
>
>> On 8/4/20 9:53 AM, Stephen Smalley wrote:
>>> With the refactoring of the policy load logic in the security
>>> server from the previous change, it is now possible to split out
>>> the committing of the new policy from security_load_policy() and
>>> perform it only after successful updating of selinuxfs. Change
>>> security_load_policy() to return the newly populated policy
>>> data structures to the caller, export selinux_policy_commit()
>>> for external callers, and introduce selinux_policy_cancel() to
>>> provide a way to cancel the policy load in the event of an error
>>> during updating of the selinuxfs directory tree.  Further, rework
>>> the interfaces used by selinuxfs to get information from the policy
>>> when creating the new directory tree to take and act upon the
>>> new policy data structure rather than the current/active policy.
>>> Update selinuxfs to use these updated and new interfaces. While
>>> we are here, stop re-creating the policy_capabilities directory
>>> on each policy load since it does not depend on the policy, and
>>> stop trying to create the booleans and classes directories during
>>> the initial creation of selinuxfs since no information is available
>>> until first policy load.
>>>
>>> After this change, a failure while updating the booleans and class
>>> directories will cause the entire policy load to be canceled, leaving
>>> the original policy intact, and policy load notifications to userspace
>>> will only happen after a successful completion of updating those
>>> directories.  This does not (yet) provide full atomicity with respect
>>> to the updating of the directory trees themselves.
>>
>> I have a patch series to perform the atomic updates very close to 
>> done, using vfs_rename with RENAME_EXCHANGE to update the directories 
>> out of tree and then swap them in as discussed earlier.  I've just 
>> been doing some final style cleanup before sending to the list.  I'll 
>> need to rebase on top of these changes of course.  I didn't touch any 
>> of the error recovery portions, so I hope my series will complement 
>> this patch nicely.
>
> Great, I was trying to ensure that we wouldn't conflict/overlap 
> significantly.
>
>>> This patch is relative to my previous one,
>>> https://patchwork.kernel.org/patch/11698505/. Although this does
>>> not ensure atomicity when updating the selinuxfs directoty tree,
>>> I suspect it will solve Daniel's original bug because systemd/dbusd
>>> won't get the policy load notifications until the kernel is done
>>> updating selinuxfs and therefore won't try to re-read selinuxfs
>>> in the middle of it (because libselinux caches the class/perm
>>> mappings and only flushes on a reload).
>> I agree with your suspicion that this will resolve the bug we've been 
>> seeing (although only as a result of changing the timing, as you 
>> point out).  Thanks for your work on this!
>
> If you can easily test that my patches resolve that bug for you, you 
> could add a Tested-by tag.  One caveat is that it sounds like I'll be 
> making one more change to the previous patch per Ondrej's request to 
> avoid taking the read lock around sidtab_convert().
Sounds good.  I will wait for your update, and then test this series.
>
>>>   @@ -563,15 +560,19 @@ static ssize_t sel_write_load(struct file 
>>> *file, const char __user *buf,
>>>       if (copy_from_user(data, buf, count) != 0)
>>>           goto out;
>>>   -    length = security_load_policy(fsi->state, data, count);
>>> +    length = security_load_policy(fsi->state, data, count, 
>>> &newpolicy);
>>>       if (length) {
>>>           pr_warn_ratelimited("SELinux: failed to load policy\n");
>>>           goto out;
>>>       }
>>>   -    length = sel_make_policy_nodes(fsi);
>>> -    if (length)
>>> +    length = sel_make_policy_nodes(fsi, newpolicy);
>>> +    if (length) {
>>> +        selinux_policy_cancel(fsi->state, newpolicy);
>>>           goto out1;
>> As things stand as of this patch, I think that this means that in the 
>> event of a failure in recreating the directories, that directory will 
>> be left unpopulated or partially populated.  We could even get in a 
>> state where the booleans directory has already been updated to the 
>> new policy and the class directory has not. The full solution is of 
>> course atomic swapover, which as I mentioned above I hope to submit a 
>> series for soon, but I wonder if recreating the directories on the 
>> old policy would be a better interim state?  That probably depends on 
>> what sorts of errors are possible.  If we've failed because of 
>> something about the new policy, recreating the old directories should 
>> get us back to a good state.  If we can't create new directories at 
>> all for whatever reason, trying to recreate might leave us worse off 
>> than before we started.
>
> I deliberately avoided any changes to the error handling during 
> re-creation of the booleans and class directories because I viewed 
> that as logically separate from my change and likely to conflict with 
> your changes.  So I expect to revisit that issue after both my patches 
> and yours land. I think the only scenario where 
> sel_make_bools/classes() can fail is an out-of-memory condition and if 
> we are out of memory then we are unlikely to be able to re-create the 
> old directories/files again.  Hence, I don't think there is anything 
> useful we can do without the atomic swapover. At most, we can delete 
> everything under booleans and class on any failure while re-creating 
> so that we aren't left with the partial set of booleans/classes.
>
> The other possibility I considered is explicitly checking whether 
> there are any changes to booleans or classes between the old and new 
> policies and if not, skipping that part of the selinuxfs update.  That 
> however would require a new security server function to iterate over 
> all of the booleans and classes in two selinux_policy structures and 
> compare them for equality.  Didn't seem worth it if the atomic 
> swapover support was coming anyway.
>
Sounds good.

-Daniel

