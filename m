Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AE0C433DF
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 18:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D185422CAF
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 18:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p7MI4D7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgHFSQk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:16:40 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36088 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgHFSJ2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 14:09:28 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id 35DCC20B4908;
        Thu,  6 Aug 2020 11:09:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35DCC20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596737352;
        bh=+xhv+PYITtK4a8arpLOdk8tow+c7QggVkIuuU5/z2RQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=p7MI4D7Tu17w1yhS7IebGtz3aL/hqG4kk96NeCv8A9nQNHwKzK6qCvgLJjfSrcZy9
         0qSD/w84XL7H4ZyT7vGBurDKr8P8X5SMYH/ohgx3LVXpPy+FUpCq50yQVkTS5/WAS0
         vacBR4S5dcXyP6wJjt2GtUUesA2tOqI1f0eRK2us=
Subject: Re: [RFC PATCH v2 2/2] selinux: move policy commit after updating
 selinuxfs
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        paul@paul-moore.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org
References: <20200805155240.26473-1-stephen.smalley.work@gmail.com>
 <20200805155240.26473-2-stephen.smalley.work@gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
Message-ID: <6d681eeb-7c26-1419-29ab-2ad71ecf3bda@linux.microsoft.com>
Date:   Thu, 6 Aug 2020 14:09:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200805155240.26473-2-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/5/20 11:52 AM, Stephen Smalley wrote:
> With the refactoring of the policy load logic in the security
> server from the previous change, it is now possible to split out
> the committing of the new policy from security_load_policy() and
> perform it only after successful updating of selinuxfs.  Change
> security_load_policy() to return the newly populated policy
> data structures to the caller, export selinux_policy_commit()
> for external callers, and introduce selinux_policy_cancel() to
> provide a way to cancel the policy load in the event of an error
> during updating of the selinuxfs directory tree.  Further, rework
> the interfaces used by selinuxfs to get information from the policy
> when creating the new directory tree to take and act upon the
> new policy data structure rather than the current/active policy.
> Update selinuxfs to use these updated and new interfaces.  While
> we are here, stop re-creating the policy_capabilities directory
> on each policy load since it does not depend on the policy, and
> stop trying to create the booleans and classes directories during
> the initial creation of selinuxfs since no information is available
> until first policy load.
>
> After this change, a failure while updating the booleans and class
> directories will cause the entire policy load to be canceled, leaving
> the original policy intact, and policy load notifications to userspace
> will only happen after a successful completion of updating those
> directories.  This does not (yet) provide full atomicity with respect
> to the updating of the directory trees themselves.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

I spent a while generating userspace AVC lookups during policy load and 
everything worked as expected.

I did note unsurprisingly that the approach of querying 
/sys/fs/selinux/class directly continues to periodically fail to find 
classes, which is still expected.

Tested-by: Daniel Burgener <dburgener@linux.microsoft.com>

