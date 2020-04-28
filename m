Return-Path: <SRS0=yj3S=6M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE864C83004
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 20:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97A72085B
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 20:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mWCh9UUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgD1Uiz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:38:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44192 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgD1Uiz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Apr 2020 16:38:55 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id 18BD020B4737;
        Tue, 28 Apr 2020 13:38:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 18BD020B4737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1588106333;
        bh=NjwdwGo9M/oRXXZdpr+KQPXuTCngAJv8IimTSDvxZWE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mWCh9UUrruQr0nNA1qc0adKlk1Ph7J0WHdQHvwQW7yhBzPZlKd7aossHh5hqWnYjD
         wGX8p1rTIm2BscHmrlKTuyViJZzkBDf5Ink53lBIE+JQfMjR1gwka0evvRj7HV+ZVe
         4TcdBXIYBxcZq6jKtE9Sp2b0Mnc7oAA92y+cH/x0=
Subject: Re: Race condition during policy load in kernel
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        selinux list <selinux@vger.kernel.org>,
        james.morris@microsoft.com
References: <d3abd210-928e-374f-1e9b-fddfaa203c53@linux.microsoft.com>
 <CAEjxPJ5Gx+g5U4-iXyMjyGxrvSsGa32jvpjY3_PYS_cbToQTKA@mail.gmail.com>
 <CAFqZXNs=UKNaS=xAW-R1v7o9KKR61vRjmv+90V29cG-xzn-bFw@mail.gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
Message-ID: <fcb45f43-5814-8d7d-8f66-d770d092f826@linux.microsoft.com>
Date:   Tue, 28 Apr 2020 16:38:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNs=UKNaS=xAW-R1v7o9KKR61vRjmv+90V29cG-xzn-bFw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/28/20 3:34 PM, Ondrej Mosnacek wrote:
> On Tue, Apr 28, 2020 at 8:54 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Mon, Apr 27, 2020 at 4:40 PM Daniel Burgener
>> <dburgener@linux.microsoft.com> wrote:
>>> Hello all,
>>>
>>> We've noticed a few instances of strange failures in userspace object
>>> managers happening immediately after a policy load, that we believe
>>> we've traced to a race condition in the kernel, and wanted to get your
>>> thoughts on our diagnosis and the appropriate fix before creating a
>>> patch in case we've missed something.
>>>
>>> The issue is that userspace object managers rely on /sys/fs/selinux to
>>> determine the mapping of object class and permission strings to numeric
>>> identifiers, however immediately after a policy load,
>>> /sys/fs/selinux/{booleans,class,policy_capabilities}, are deleted and
>>> recreated.  This leaves a window where the object classes (etc) appear
>>> to be not defined, even if they are defined in both the old and new
>>> policies.
>>>
>>> We have observed this with both dbus and systemd userspace object
>>> managers, and it can be reproduced straightforwardly by running the
>>> following (borrowed from bug linked below):
>>>
>>> # (while true; do cat /sys/fs/selinux/class/service/index >/dev/null;
>>> done) &
>>> # while true; do sudo load_policy; echo -n .; sleep 0.1;done
>>>
>>> Periodically, we will get "No such file or directory" messages printed
>>> to stderr.  In the event of a userspace object manager using libselinux
>>> to check a userspace permission, that will result in a USER_AVC message
>>> indicating an unknown object class, and in the event that
>>> --handle-unknown is set to "deny", it will deny the access.
>>>
>>> It seems to me as though some sort of locking should occur in the
>>> selinuxfs to prevent access to the files being deleted and recreated
>>> during the policy load, so that userspace programs relying on them (in
>>> particular userspace object managers doing class lookups) get a
>>> consistent view of the classes, perms, booleans and capabilities in the
>>> loaded policy.
>>>
>>> This seems to be related to
>>> https://github.com/SELinuxProject/selinux-kernel/issues/42 but I believe
>>> it is a different case.  The deadlock in that bug seems to be related to
>>> the underlying filesystem functions, specifically around directory
>>> deletion while this is an issue the selinuxfs logic specifically. The
>>> above linked issue appears to have been fixed in recent upstream
>>> kernels, per the bug, but I have verified the issue I am discussing here
>>> in 5.7.0 rc3.
>>>
>>> It seems to me as though from the perspective of userspace that all of
>>> sel_make_policy_nodes (or at least all of each of its component
>>> functions) should be atomic.  There was some discussion in a previous
>>> thread
>>> (https://lore.kernel.org/selinux/20181002155810.GP32577@ZenIV.linux.org.uk/)
>>> around a significant refactor of policy loading in general.  It appears
>>> as though the direct issue there of access during the deletion has been
>>> resolved (commit d4f4de5e5ef8efde85febb6876cd3c8ab1631999), although the
>>> complete suggested fix of refactoring policy_load into two parts has not
>>> been done.  Would that refactor be the right approach to the problem I
>>> am trying to solve?  Would a patch for adding locking around the
>>> selinuxfs delete/recreate operation be considered? That wouldn't address
>>> all the concerns, (namely the potential to access a view of the policy
>>> that doesn't match the currently loaded policy and error recovery in the
>>> case that sel_make_nodes fails), but would improve the reliability of
>>> existing userspace object managers
>>>
>>> I'm happy to create and submit a patch, but I wanted to get the
>>> communities thought on the problem and correct approach first.
>> I think the best approach is the one sketched by viro but I recognize
>> that's a big lift.
>> Willing to help but not entirely clear on the interactions with the
>> dcache for atomically swapping
>> the new trees into place.
>>
>> I suspect this is just being exposed now due to more recent changes in
>> userspace to try to fully support
>> changes in class/permission values at runtime.  Previously userspace
>> object managers tended to only
>> map them during initialization or on first use and then would just
>> keep using the cached values, whereas
>> now they try to map them lazily and flush their caches on a reload
>> notification.  Some of those changes
>> were in libselinux and others in the userspace object managers (e.g.
>> systemd, dbus-broker or dbusd).
>> Not sure exactly what versions of libselinux, systemd, and
>> dbusd/dbus-broker you are using.
>>
>> selinuxfs itself does take a mutex around the entire policy load
>> including the delete/re-create sequence but
>> that only serializes with other policy operations (load, read,
>> booleans), not with dcache walk/lookup.
>>
>> cc'ing Ondrej since he attempted to fix the earlier selinuxfs bug and
>> may have an opinion on the best way
>> forward for this issue.
> Well, I attempted a few times and each time failed miserably :)
> Thankfully, hitting the bug via another fs eventually forced viro to
> fix it (in a way I could probably never come up with myself). However,
> I remember trying to originally fix the bug by means of making the
> swapover atomic, but later I realized that these two are actually
> independent issues. After that I didn't get back to atomizing the
> swapover, but IIRC I had the impression that it might not be all that
> difficult... (at least if I ignore possible failures during the new
> dentry tree creation for now - it would still be unsafe, but it would
> be a start). But knowing VFS, I bet when I actually try it will prove
> to be much more tricky ;)
>
> I'll try to find some time to sit down to it again, but at the moment
> I'm juggling a bunch of higher priority stuff so it might be a while
> before I get to it.
>
The weird thing about atomizing the swapover in isolation is that it's 
unclear what action to take on failure.  The existing code looks like it 
would leave a broken version of the selinuxfs laying around.  Completing 
the swapover even on failure would give us an atomic version of the 
current situation, but feels extra weird. If ignoring the failure case 
as Ondrej suggests would be acceptable in a patch, that sounds like the 
quickest way to addressing at least part of the problem (the refactor of 
security_load_policy by itself doesn't get us much by itself, since we 
can't roll back the selinuxfs after we've started in the current state.)

I'd be happy to start looking at either half, although I'd prefer to 
start with atomizing the tree swapover to solve my immediate problem if 
that would have a chance at getting merged by itself given the issues 
around the failure case.

-Daniel

