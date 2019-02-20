Return-Path: <SRS0=OyWE=Q3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CC5C43381
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 10:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092182089F
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 10:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfBTK1h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:27:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfBTK1h (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 20 Feb 2019 05:27:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 531EDAC2D1;
        Wed, 20 Feb 2019 10:27:36 +0000 (UTC)
Received: from workstation (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4FAF19C70;
        Wed, 20 Feb 2019 10:27:33 +0000 (UTC)
References: <CAHC9VhR9b8udyh7WWAw0-G64DuaLBN59QXByteBdVbtZKnUj-A@mail.gmail.com> <87lg2g97sr.fsf@gmail.com> <98436a4a-0048-2839-acff-b1bc38075a8c@tycho.nsa.gov> <87h8d4974p.fsf@gmail.com> <27efd865-7d08-fc61-e004-0a07f27e165e@tycho.nsa.gov> <20190216120412.GA11908@brutus.lan> <20190216121256.GB11908@brutus.lan> <CAHC9VhQsj8UnV=CZ+vkvruB6Nn_W7SzW-W4oTK9=QcJRkfeiJg@mail.gmail.com> <87d0np8tfw.fsf@gmail.com> <CAB9W1A3f1jxJQPrU-o=gEKzgjRGmbThoqPvzbK7QNqprdE-LAw@mail.gmail.com> <20190219110813.GA22984@brutus.lan> <CAB9W1A2s+PcrC=fPXA9AYRm1oVYArsRCGKihM5mjUqnQtuLe3w@mail.gmail.com> <CAB9W1A3Pef5pfAZ8UEvSQYvWA9oZTRNPvWFCHw8e9eqZsGvGWA@mail.gmail.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        "Stephen D. Smalley" <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>,
        Stephen Smalley <stephen.smalley@gmail.com>
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
In-reply-to: <CAB9W1A3Pef5pfAZ8UEvSQYvWA9oZTRNPvWFCHw8e9eqZsGvGWA@mail.gmail.com>
Date:   Wed, 20 Feb 2019 11:27:32 +0100
Message-ID: <pjdef82n4a3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 20 Feb 2019 10:27:36 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Stephen Smalley <stephen.smalley@gmail.com> writes:

> On Tue, Feb 19, 2019, 8:21 AM Stephen Smalley 
> <stephen.smalley@gmail.com
> wrote:
>
>> On Tue, Feb 19, 2019, 6:08 AM Dominick Grift 
>> <dac.override@gmail.com
>> wrote:
>>
>>> On Mon, Feb 18, 2019 at 07:07:33PM -0500, Stephen Smalley 
>>> wrote:
>>> > On Mon, Feb 18, 2019, 2:09 AM Dominick Grift 
>>> > <dac.override@gmail.com
>>> wrote:
>>> >
>>> > > Paul Moore <paul@paul-moore.com> writes:
>>> > >
>>> > > > On Sat, Feb 16, 2019 at 7:12 AM Dominick Grift <
>>> dac.override@gmail.com>
>>> > > wrote:
>>> > > >>
>>> > > >> On Sat, Feb 16, 2019 at 01:04:12PM +0100, Dominick 
>>> > > >> Grift wrote:
>>> > > >> > On Fri, Feb 15, 2019 at 02:48:45PM -0500, Stephen 
>>> > > >> > Smalley wrote:
>>> > > >> > <snip>
>>> > > >> >
>>> > > >> > >
>>> > > >> > > Oh, I see: scripts/selinux/install_policy.sh just 
>>> > > >> > > invokes
>>> > > checkpolicy
>>> > > >> > > without specifying -U / --handle-unknown, so the 
>>> > > >> > > policy
>>> defaults to
>>> > > deny,
>>> > > >> > > and that would indeed render dbus-daemon and 
>>> > > >> > > systemd broken
>>> with
>>> > > that
>>> > > >> > > policy.  Might be as simple to fix as passing -U 
>>> > > >> > > allow.
>>> > > >> >
>>> > > >> > I have looked a litte into this and here are some 
>>> > > >> > observations:
>>> > > >> >
>>> > > >> > 1. You can boot mdp as-is in permissive mode if you 
>>> > > >> > use
>>> `checkpolicy`
>>> > > with `-U allow`
>>> > > >> >
>>> > > >> > 2. You need *at least* an 
>>> > > >> > `/etc/selinux/dummy/seusers` with
>>> > > >> > `__default__:user_u` and an accompanying
>>> > > >> > `/etc/selinux/dummy/contexts/failsafe_context` with
>>> > > >> > `base_r:base_t` to boot mdp in enforcing
>>> > > >
>>> > > > Wow.  I didn't expect we would get to this point so 
>>> > > > quickly.
>>> > > >
>>> > > > Originally my plan had been to just merge the mdp 
>>> > > > changes that
>>> Stephen
>>> > > > submitted, and leave the rest for some other time. 
>>> > > > Although based
>>> on
>>> > > > everything in this thread, it looks like we are really 
>>> > > > close to
>>> having
>>> > > > something that you can build and boot without too many 
>>> > > > hacks.
>>> > > >
>>> > > >> > 3. There is an issue with checkpolicy and object_r:
>>> > > >> >
>>> > > >> > PAM libselinux clients such as `login` try to 
>>> > > >> > associate
>>> `object_r`
>>> > > with the tty and fail.
>>> > > >> >
>>> > > >> > if you try to append: `role object_r; role object_r 
>>> > > >> > types
>>> base_t;`
>>> > > >> > to policy.conf and compile that with `checkpolicy` 
>>> > > >> > then the
>>> > > >> > `roletype-rule` does *not* end up in the compiled 
>>> > > >> > policy for some
>>> > > >> > reason.
>>> > > >
>>> > > > This sounds like a bug in checkpolicy ... ?
>>> > >
>>> > > Yes, looks like it
>>> > >
>>> >
>>> > I don't think so. object_r has always been handled 
>>> > specially. The kernel
>>> > ignores the role-type definition for it and always exempts 
>>> > contexts that
>>> > contain it from user-role, role-type, and user-range 
>>> > restrictions. We
>>> > didn't use to include it in the policy at all; I think CIL 
>>> > does but we
>>> only
>>> > generate a stub in the kernel policy with the role name and 
>>> > value but no
>>> > types and the kernel ignores it. What exactly breaks with 
>>> > pam_selinux?
>>> >
>>>
>>> Tried it again and this time I tried to run install_selinux.sh 
>>> with
>>> selinux disabled (previously i did not bother to boot with 
>>> selinux disabled)
>>>
>>> Now I think I see what you were seeing:
>>>
>>> 1. setfiles is called in install_selinux.sh but it does not 
>>> relabel when
>>> selinux is disabled
>>>
>>
>> That's a bug in setfiles / libselinux selinux_restorecon. I 
>> thought that
>> was fixed recently. If selinux is disabled, we should not 
>> exclude
>> filesystem based on seclabel.
>>
>
> Was it never merged?
> https://lore.kernel.org/selinux/20180926151254.1794-1-sds@tycho.nsa.gov/

Apparently it was not merged. Since there was no objection, only a 
LGTM
comment I've just merged it.

>
>>
>> 2. the system is misabeled and when you boot, that prompts an 
>> autorelabel
>>> (don't what does that but maybe systemd) which ,for some 
>>> reason, does not
>>> work either even though it looks like its doing something
>>> 3. system does not start properly (even in permissive mode) 
>>> because it
>>> looks like systemd can't compute a valid context using the 
>>> mislabeled
>>> /sbin/init
>>>
>>> This, i think, would address that:
>>>
>>> 1. dont try to run setfiles in install_selinux.sh because it 
>>> does not
>>> work in the scenario where you run install_selinux.sh when 
>>> selinux is
>>> disabled (audit actually prints an FS_RELABEL event but 
>>> nothing is
>>> relabeled)
>>> 2. in /etc/selinux/config use SELINUX=permissive instead of
>>> SELINUX=enforcing (it needs to relabel in permissive mode in 
>>> the next step)
>>> 3. echo '-F' > /.autorelabel
>>>
>>> When all is said and done I still hit the issue where I am not 
>>> able to
>>> log into the system in enforcing mode:
>>>
>>> Feb 19 12:05:04 myguest login[1175]: 
>>> pam_selinux(login:session): Setting
>>> file context "user_u:object_r:base_t" failed for /dev/ttyS0: 
>>> Operation not
>>> supported
>>>
>>
>> Operation not supported means that the filesystem type isn't 
>> configured
>> for labeling. Looks like mdp was never updated to include 
>> devtmpfs among
>> other filesystems.
>>
>>
>>> >
>>> > > >
>>> > > >> > thus, you cannot log in because object_r:base_t is 
>>> > > >> > not valid.
>>> > > >> >
>>> > > >> > To hack around this add `default_role * source` rules 
>>> > > >> > to
>>> policy.conf
>>> > > and recompile.
>>> > > >> >
>>> > > >> > This will allow you to log into the system locally in 
>>> > > >> > enforcing
>>> mode.
>>> > > >> >
>>> > > >> > 4. I also noticed that fedoras' ssh seems to hardcode
>>> `sshd_net_t`
>>> > > >> > for its "privsep" functionality so, while untested, 
>>> > > >> > you probably
>>> > > >> > need an `openssh_contexts` with 
>>> > > >> > `privsep_preauth=base_t`
>>> > > >
>>> > > > Petr, what's the deal with ssh on Fedora?
>>> > >
>>> > > I wonder whether it would be possible (and feasible) to 
>>> > > not
>>> transition on
>>> > > privsep_preauth at all *unless* a privsep preauth type is 
>>> > > specified in
>>> > > openssh_context.
>>> > >
>>> > > Currently it falls back to a hardcoded type to transition 
>>> > > to if
>>> > > openssh_contexts does not exist.
>>> > >
>>> > > Then again, i would not want to risk breaking or 
>>> > > regressing some of
>>> the
>>> > > nice
>>> > > functionality openssh in fedora has for selinux. It's 
>>> > > state is
>>> currently
>>> > > very good even compared to RHEL.
>>> > >
>>> > > >
>>> > > >> The `install_policy.sh` script should probably also do 
>>> > > >> a bash file
>>> test
>>> > > for `checkpolicy` and fail gracefully if its not found
>>> > >
>>> > > --
>>> > > Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 
>>> > > 2C7B 6B02
>>> > >
>>> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
>>> > > Dominick Grift
>>> > >
>>>
>>> --
>>> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 
>>> 6B02
>>> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
>>> Dominick Grift
>>>
>>

