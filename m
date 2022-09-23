Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB6CC04A95
	for <selinux@archiver.kernel.org>; Fri, 23 Sep 2022 18:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiIWSqI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiIWSqH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Sep 2022 14:46:07 -0400
Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC94D11F129
        for <selinux@vger.kernel.org>; Fri, 23 Sep 2022 11:46:00 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2a10:3781:2099::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id 99492FC0466;
        Fri, 23 Sep 2022 20:45:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1663958756;
        bh=DNd176MENakm/BVs6abpkvgsOSnn9URQsKVzOzg3Twk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jRRGxoEY2CGHyiu6oWzd/EtfsthnrUFkDuFhkEM/GdEbsABrgIRHgarqGu207J1M3
         N+nVDYHPtvzIB2OIpFgXrgoPyujI9ocfgZHmYHy2+gRuZcPWuiXVwXOdKKAnkTMNMa
         aqnMvrmzJTn0nJv4cXF+OXXJHi7yngqcbKIdEs+Y=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jeff Xu <jeffxu@chromium.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        groeck@chromium.org, Luis Hector Chavez <lhchavez@google.com>,
        Luis Hector Chavez <lhchavez@chromium.org>
Subject: Re: [PATCH 1/1] Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
In-Reply-To: <CAHC9VhRuUZxdsVQftqWa0zEuNAxk8ur0-TZp5KecJ537hRONRQ@mail.gmail.com>
        (Paul Moore's message of "Fri, 23 Sep 2022 14:04:49 -0400")
References: <20220921185426.1663357-1-jeffxu@chromium.org>
        <20220921185426.1663357-2-jeffxu@chromium.org>
        <CAHC9VhS-jv5cpSdq7dxFGYH=z=5grQceNMyjroeL2KHdrVUV6g@mail.gmail.com>
        <CABi2SkXRxomrYn-xUf3B+XswmQjXZUJXmYJECmr_nBfrZWwqkA@mail.gmail.com>
        <CAHC9VhRuUZxdsVQftqWa0zEuNAxk8ur0-TZp5KecJ537hRONRQ@mail.gmail.com>
Date:   Fri, 23 Sep 2022 20:45:54 +0200
Message-ID: <875yhe6ial.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> On Fri, Sep 23, 2022 at 1:43 PM Jeff Xu <jeffxu@chromium.org> wrote:
>> On Wed, Sep 21, 2022 at 12:11 PM Paul Moore <paul@paul-moore.com> wrote:
>> > On Wed, Sep 21, 2022 at 2:54 PM <jeffxu@chromium.org> wrote:
>> > >
>> > > From: Jeff Xu <jeffxu@chromium.org>
>> > >
>> > > When SECURITY_SELINUX_DEVELOP=y and the system is running in permissive
>> > > mode, it is useful to disable logging from permissive domain, so audit
>> > > log does not get spamed.
>> > >
>> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>> > > Signed-off-by: Luis Hector Chavez <lhchavez@google.com>
>> > > Tested-by: Luis Hector Chavez <lhchavez@chromium.org>
>> > > Tested-by: Jeff Xu<jeffxu@chromium.org>
>> > > ---
>> > >  security/selinux/Kconfig | 10 ++++++++++
>> > >  security/selinux/avc.c   |  9 +++++++++
>> > >  2 files changed, 19 insertions(+)
>> >
>> > I'm sorry, but I can't accept this into the upstream kernel.
>> > Permissive mode, both per-domain and system-wide, is not intended to
>> > be a long term solution.  Permissive mode should really only be used
>> > as a development tool or emergency "hotfix" with the proper solution
>> > being either an adjustment of the existing policy (SELinux policy
>> > booleans, labeling changes, etc.) or the development of a new policy
>> > module which better fits your use case.
>>
>> Thanks for the response.
>> For a system that wants to control a few daemons, is there a
>> recommended pattern from selinux ?

That is effectively a "targeted" policy model. You target a selection of
entities and everything else is "unconfined" (ie not targeteed).

An "unconfined" domain is just a process type that has many allow rules
associated with it making it effectively similar to an "permissive"
domain. The difference is that since "unconfined" domains have full
access there should not be any AVC denials (nothing is blocked by
SELinux because the policy does not target the entity)

The stock policy enforced in Red Hat based distributions is a "targeted"
policy model for example. The unconfined_t domain is one of various
"unconfined" domains (other examples are unconfined_service_t but
effectively any type could be made unconfined by simply allowing all accesses.

>
> Guidance on how to write a SELinux policy for an application is a bit
> beyond what I have time for in this email, but others on this mailing
> list might be able to help.  There has definitely been a lot written
> on the subject, both available online and offline.  My suggestion
> would be to start "small" with a single SELinux domain for the
> application and a single type for any configuration, data, or log
> files it might need; get this initial domain working properly and then
> you can add increasing levels of access control granularity until
> you've met your security requirements.  If you've never done this
> before, go slow, the start might be challenging as you get used to the
> tools, but you can do it :)
>
>> I read this blog about unconfined domain (unconfined_t), maybe this is one way ?
>> https://wiki.gentoo.org/wiki/SELinux/Tutorials/What_is_this_unconfined_thingie_and_tell_me_about_attributes
>
> It is important to remember that an unconfined domain is, as the name
> would imply, effectively unconfined by SELinux.  Perhaps this is what
> you want, but generally speaking if you are running SELinux it is
> because you have a need or desire for additional access controls
> beyond the legacy Linux discretionary access controls.
>
>> I have two questions on unconfined domain:
>> 1> Is unconfined_t domain supported in SECURITY_SELINUX_DEVELOP=n mode ?
>
> Yes.  The SECURITY_SELINUX_DEVELOP kernel build configuration only
> enables the admin to boot the kernel initially in permissive mode
> and/or determine the SELinux mode using the "enforcing=X" kernel
> command line option and a sysfs/securityfs tunable under
> /sys/fs/selinux/enforce.  The unconfined_t domain is defined purely in
> the SELinux policy and not the kernel; you could write a SELinux
> policy without it you wanted, or you could grant unconfined_t-like
> permissions to multiple different domains in your policy.  It's been a
> while since I played with it, but I believe the SELinux reference
> policy (refpol) provides a macro interface to define an arbitrary
> domain with unconfined_t-like permissions.
>
>> 2> will unconfined_t domain log also as permissive domain ?
>
> The intent of the unconfined_t domain is that there would be no access
> denials due to SELinux and thus no AVC audit records related to the
> unconfined_t domain.  It is not permissive in the sense of the SELinux
> "mode" (enforcing/permissive/disabled), but it is permissive in the
> sense that it is given a large number of permissions.

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
