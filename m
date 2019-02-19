Return-Path: <SRS0=HWKQ=Q2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF599C43381
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 12:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0002146F
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 12:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puCWSI0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfBSMhU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:37:20 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46790 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfBSMhU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Feb 2019 07:37:20 -0500
Received: by mail-ed1-f66.google.com with SMTP id f2so16553505edy.13
        for <selinux@vger.kernel.org>; Tue, 19 Feb 2019 04:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rsX5QUcll2tVpoj5fTVOaZCJu/ZeP43F09e/HXSberw=;
        b=puCWSI0EOQXuPeNP6IrmB0LpqFU9dLfGPta801X33RPNy9875vmtXmavUcqdwJ0Cx0
         DDMwXMDp9u7YIlYaCwjaj7zsGRLsdP/Mdx3L9K18EZjGrvPh+2Ub2DjhZoyfydR3UvBq
         +uf/MI70W4Z9igEGIyGG74fjCzlnYkEhh0FWr8BsUMo4WzKwT+7CuSGUEbxpYRItAO3U
         kZyJzc5wSV2z/02zVE2b221hd2W0JoJHlOttiWz4GwrP3RqVs9CFCEdQbF4Lf9n7b5bJ
         OQ0PINln7+ogd2km5jE60zjjdMNvd7nkG3Svxb7g+ZSS3gqY9Ifq4UmjJWYWzkgRt/hx
         cGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=rsX5QUcll2tVpoj5fTVOaZCJu/ZeP43F09e/HXSberw=;
        b=EFtBgEDGr9gnZwVZfWYSvnkTMVfUe+WjYP/7Ba9n1QDMHNQiwFWQL6hWWm9OHQJ7YF
         Rr12zhp6WUKy5vxoZ/SFVlGK0hDxLbrcPEv9eRgHuqOvS/thjMqzFHLmrqA1+pj7JVPR
         yG5P2u2yWQ0x3Vf5wDS889t+j1Qm+5v7Ske69ddZjSKRish1hxd0sA/7Vv7THaTodClU
         NeqeJU3Qsmv6zG6bY62p+6+LQBaqCaofbJ8MVBnKgUfoD1SPbVwdOHgJCmnWermPShfA
         WS5hVJCo/E76OTqNYfI4BWbExl2weSiTxKk8uFG4EZZFOPXFoTGu3jwZP5W+r3qXrRgF
         GIuw==
X-Gm-Message-State: AHQUAubQMnFD1m0HiXGjuQQfteLV88IPxawHvQK2GlxMyYSDZXomauvt
        2OszC3eZhpvytj4C+jEjcoUuWiM7
X-Google-Smtp-Source: AHgI3IaoykNrEaqBAieLUtV9JDgziIf4NIfbu4NJB3YnU5pfDAm0cbT/hBhWb88lbgjk3sbZPe/c4g==
X-Received: by 2002:a50:a982:: with SMTP id n2mr22764924edc.236.1550579837326;
        Tue, 19 Feb 2019 04:37:17 -0800 (PST)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id a9sm4457532edl.63.2019.02.19.04.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 04:37:16 -0800 (PST)
From:   Dominick Grift <dac.override@gmail.com>
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
References: <5da1e226-1c75-a732-7d92-89a9dfd4c857@tycho.nsa.gov>
        <0e556b37-90fa-7f3a-f60f-fa77acce6f5b@tycho.nsa.gov>
        <87zhqxkn8a.fsf@gmail.com> <87r2c9klrh.fsf@gmail.com>
        <CAHC9VhR9b8udyh7WWAw0-G64DuaLBN59QXByteBdVbtZKnUj-A@mail.gmail.com>
        <87lg2g97sr.fsf@gmail.com>
        <98436a4a-0048-2839-acff-b1bc38075a8c@tycho.nsa.gov>
        <87h8d4974p.fsf@gmail.com>
        <27efd865-7d08-fc61-e004-0a07f27e165e@tycho.nsa.gov>
        <20190216120412.GA11908@brutus.lan>
        <20190216121256.GB11908@brutus.lan>
        <CAHC9VhQsj8UnV=CZ+vkvruB6Nn_W7SzW-W4oTK9=QcJRkfeiJg@mail.gmail.com>
        <87d0np8tfw.fsf@gmail.com> <pjdmumsm0zv.fsf@redhat.com>
Date:   Tue, 19 Feb 2019 13:37:16 +0100
In-Reply-To: <pjdmumsm0zv.fsf@redhat.com> (Petr Lautrbach's message of "Tue,
        19 Feb 2019 13:11:32 +0100")
Message-ID: <87wolw6jk3.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Dominick Grift <dac.override@gmail.com> writes:
>
>> Paul Moore <paul@paul-moore.com> writes:
>>
>>> On Sat, Feb 16, 2019 at 7:12 AM Dominick Grift
>>> <dac.override@gmail.com> wrote:
>>>>
>>>> On Sat, Feb 16, 2019 at 01:04:12PM +0100, Dominick Grift wrote:
>>>> > On Fri, Feb 15, 2019 at 02:48:45PM -0500, Stephen Smalley >
>>>> wrote:
>>>> > <snip>
>>>> >
>>>> > >
>>>> > > Oh, I see: scripts/selinux/install_policy.sh just invokes > >
>>>> checkpolicy
>>>> > > without specifying -U / --handle-unknown, so the policy > >
>>>> defaults to deny,
>>>> > > and that would indeed render dbus-daemon and systemd > >
>>>> broken with that
>>>> > > policy.  Might be as simple to fix as passing -U allow.
>>>> >
>>>> > I have looked a litte into this and here are some >
>>>> observations:
>>>> >
>>>> > 1. You can boot mdp as-is in permissive mode if you use >
>>>> `checkpolicy` with `-U allow`
>>>> >
>>>> > 2. You need *at least* an `/etc/selinux/dummy/seusers` with
>>>> > `__default__:user_u` and an accompanying
>>>> > `/etc/selinux/dummy/contexts/failsafe_context` with
>>>> > `base_r:base_t` to boot mdp in enforcing
>>>
>>> Wow.  I didn't expect we would get to this point so quickly.
>>>
>>> Originally my plan had been to just merge the mdp changes that
>>> Stephen
>>> submitted, and leave the rest for some other time.  Although based
>>> on
>>> everything in this thread, it looks like we are really close to
>>> having
>>> something that you can build and boot without too many hacks.
>>>
>>>> > 3. There is an issue with checkpolicy and object_r:
>>>> >
>>>> > PAM libselinux clients such as `login` try to associate >
>>>> `object_r` with the tty and fail.
>>>> >
>>>> > if you try to append: `role object_r; role object_r types >
>>>> base_t;`
>>>> > to policy.conf and compile that with `checkpolicy` then the
>>>> > `roletype-rule` does *not* end up in the compiled policy for >
>>>> some
>>>> > reason.
>>>
>>> This sounds like a bug in checkpolicy ... ?
>>
>> Yes, looks like it
>>
>>>
>>>> > thus, you cannot log in because object_r:base_t is not > valid.
>>>> >
>>>> > To hack around this add `default_role * source` rules to >
>>>> policy.conf and recompile.
>>>> >
>>>> > This will allow you to log into the system locally in >
>>>> enforcing mode.
>>>> >
>>>> > 4. I also noticed that fedoras' ssh seems to hardcode >
>>>> `sshd_net_t`
>>>> > for its "privsep" functionality so, while untested, you >
>>>> probably
>>>> > need an `openssh_contexts` with `privsep_preauth=base_t`
>
> "sshd_net_t" is really hardcoded as a fallback but
> ssh_selinux_change_context("sshd_net_t"); is not a fatal operation.
> If it fails it just logs a debug message and the type of the process
> stays unaffected - by default it's sshd_t
>
> I believe that openssh_context is not necessary if you don't mind or
> want to use different type for privsep preauth sshd processes.

Thanks. So just a warning message. Might be possible to only log it if
debug is enabled?

>
>
>>> Petr, what's the deal with ssh on Fedora?
>>
>> I wonder whether it would be possible (and feasible) to not
>> transition on
>> privsep_preauth at all *unless* a privsep preauth type is specified
>> in
>> openssh_context.
>>
>> Currently it falls back to a hardcoded type to transition to if
>> openssh_contexts does not exist.
>>
>> Then again, i would not want to risk breaking or regressing some of
>> the nice
>> functionality openssh in fedora has for selinux. It's state is
>> currently
>> very good even compared to RHEL.
>
> I think it's feasible without a big risk. 
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1678695
>
>>>
>>>> The `install_policy.sh` script should probably also do a bash file
>>>> test for `checkpolicy` and fail gracefully if its not found
>

-- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
