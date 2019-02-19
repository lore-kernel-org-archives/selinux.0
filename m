Return-Path: <SRS0=HWKQ=Q2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8D3C43381
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 12:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B352146E
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 12:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfBSMLf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:11:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfBSMLf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 19 Feb 2019 07:11:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2EBB3C00734A;
        Tue, 19 Feb 2019 12:11:35 +0000 (UTC)
Received: from workstation (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D10DB61B85;
        Tue, 19 Feb 2019 12:11:33 +0000 (UTC)
References: <5da1e226-1c75-a732-7d92-89a9dfd4c857@tycho.nsa.gov> <0e556b37-90fa-7f3a-f60f-fa77acce6f5b@tycho.nsa.gov> <87zhqxkn8a.fsf@gmail.com> <87r2c9klrh.fsf@gmail.com> <CAHC9VhR9b8udyh7WWAw0-G64DuaLBN59QXByteBdVbtZKnUj-A@mail.gmail.com> <87lg2g97sr.fsf@gmail.com> <98436a4a-0048-2839-acff-b1bc38075a8c@tycho.nsa.gov> <87h8d4974p.fsf@gmail.com> <27efd865-7d08-fc61-e004-0a07f27e165e@tycho.nsa.gov> <20190216120412.GA11908@brutus.lan> <20190216121256.GB11908@brutus.lan> <CAHC9VhQsj8UnV=CZ+vkvruB6Nn_W7SzW-W4oTK9=QcJRkfeiJg@mail.gmail.com> <87d0np8tfw.fsf@gmail.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Dominick Grift <dac.override@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        Petr Lautrbach <plautrba@redhat.com>
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
In-reply-to: <87d0np8tfw.fsf@gmail.com>
Date:   Tue, 19 Feb 2019 13:11:32 +0100
Message-ID: <pjdmumsm0zv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 19 Feb 2019 12:11:35 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Dominick Grift <dac.override@gmail.com> writes:

> Paul Moore <paul@paul-moore.com> writes:
>
>> On Sat, Feb 16, 2019 at 7:12 AM Dominick Grift 
>> <dac.override@gmail.com> wrote:
>>>
>>> On Sat, Feb 16, 2019 at 01:04:12PM +0100, Dominick Grift 
>>> wrote:
>>> > On Fri, Feb 15, 2019 at 02:48:45PM -0500, Stephen Smalley 
>>> > wrote:
>>> > <snip>
>>> >
>>> > >
>>> > > Oh, I see: scripts/selinux/install_policy.sh just invokes 
>>> > > checkpolicy
>>> > > without specifying -U / --handle-unknown, so the policy 
>>> > > defaults to deny,
>>> > > and that would indeed render dbus-daemon and systemd 
>>> > > broken with that
>>> > > policy.  Might be as simple to fix as passing -U allow.
>>> >
>>> > I have looked a litte into this and here are some 
>>> > observations:
>>> >
>>> > 1. You can boot mdp as-is in permissive mode if you use 
>>> > `checkpolicy` with `-U allow`
>>> >
>>> > 2. You need *at least* an `/etc/selinux/dummy/seusers` with
>>> > `__default__:user_u` and an accompanying
>>> > `/etc/selinux/dummy/contexts/failsafe_context` with
>>> > `base_r:base_t` to boot mdp in enforcing
>>
>> Wow.  I didn't expect we would get to this point so quickly.
>>
>> Originally my plan had been to just merge the mdp changes that 
>> Stephen
>> submitted, and leave the rest for some other time.  Although 
>> based on
>> everything in this thread, it looks like we are really close to 
>> having
>> something that you can build and boot without too many hacks.
>>
>>> > 3. There is an issue with checkpolicy and object_r:
>>> >
>>> > PAM libselinux clients such as `login` try to associate 
>>> > `object_r` with the tty and fail.
>>> >
>>> > if you try to append: `role object_r; role object_r types 
>>> > base_t;`
>>> > to policy.conf and compile that with `checkpolicy` then the
>>> > `roletype-rule` does *not* end up in the compiled policy for 
>>> > some
>>> > reason.
>>
>> This sounds like a bug in checkpolicy ... ?
>
> Yes, looks like it
>
>>
>>> > thus, you cannot log in because object_r:base_t is not 
>>> > valid.
>>> >
>>> > To hack around this add `default_role * source` rules to 
>>> > policy.conf and recompile.
>>> >
>>> > This will allow you to log into the system locally in 
>>> > enforcing mode.
>>> >
>>> > 4. I also noticed that fedoras' ssh seems to hardcode 
>>> > `sshd_net_t`
>>> > for its "privsep" functionality so, while untested, you 
>>> > probably
>>> > need an `openssh_contexts` with `privsep_preauth=base_t`

"sshd_net_t" is really hardcoded as a fallback but
ssh_selinux_change_context("sshd_net_t"); is not a fatal 
operation.
If it fails it just logs a debug message and the type of the 
process
stays unaffected - by default it's sshd_t

I believe that openssh_context is not necessary if you don't mind 
or
want to use different type for privsep preauth sshd processes.


>> Petr, what's the deal with ssh on Fedora?
>
> I wonder whether it would be possible (and feasible) to not 
> transition on
> privsep_preauth at all *unless* a privsep preauth type is 
> specified in
> openssh_context.
>
> Currently it falls back to a hardcoded type to transition to if
> openssh_contexts does not exist.
>
> Then again, i would not want to risk breaking or regressing some 
> of the nice
> functionality openssh in fedora has for selinux. It's state is 
> currently
> very good even compared to RHEL.

I think it's feasible without a big risk. 

https://bugzilla.redhat.com/show_bug.cgi?id=1678695

>>
>>> The `install_policy.sh` script should probably also do a bash 
>>> file test for `checkpolicy` and fail gracefully if its not 
>>> found

