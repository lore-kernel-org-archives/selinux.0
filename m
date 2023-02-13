Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848B6C636D4
	for <selinux@archiver.kernel.org>; Mon, 13 Feb 2023 07:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjBMHn2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Feb 2023 02:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBMHn2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Feb 2023 02:43:28 -0500
X-Greylist: delayed 224 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Feb 2023 23:43:26 PST
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1665DE3B3;
        Sun, 12 Feb 2023 23:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1676273977;
        bh=LuSv/ObJNfdtGO6IGR6S5btqxR4kKo4DU9AXXJIKnu0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=R7w/M17qSsT1f9JfteUGLnCwZw/8x7IaBgzoddXDSjkNjzbg0mWC9HD1ZuhC8KXy2
         323uKLo/1hhH2D9IYKukCYpliD/1V8XEtY47qC0+q5sUb+SR3yV3Qbbi8MPPFAmPzR
         5w7c4xIXMkNees4IIY85Q0pvE7wEptAIVkeBR1H8=
Received: from paulus (paulus.lan [IPv6:2a10:3781:2099::515])
        by markus.defensec.nl (Postfix) with ESMTPSA id 236B05F74;
        Mon, 13 Feb 2023 08:39:37 +0100 (CET)
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        groeck@chromium.org, Luis Hector Chavez <lhchavez@google.com>,
        Luis Hector Chavez <lhchavez@chromium.org>
Subject: Re: [PATCH 1/1] Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
References: <20220921185426.1663357-1-jeffxu@chromium.org>
        <20220921185426.1663357-2-jeffxu@chromium.org>
        <CAHC9VhS-jv5cpSdq7dxFGYH=z=5grQceNMyjroeL2KHdrVUV6g@mail.gmail.com>
        <CABi2SkXRxomrYn-xUf3B+XswmQjXZUJXmYJECmr_nBfrZWwqkA@mail.gmail.com>
        <CAHC9VhRuUZxdsVQftqWa0zEuNAxk8ur0-TZp5KecJ537hRONRQ@mail.gmail.com>
        <875yhe6ial.fsf@defensec.nl>
        <CABi2SkXU+C77PqXnH_OHs9rjsiOQAHMmkDF5H9EYkU=ZG_tNrg@mail.gmail.com>
Date:   Mon, 13 Feb 2023 08:39:36 +0100
In-Reply-To: <CABi2SkXU+C77PqXnH_OHs9rjsiOQAHMmkDF5H9EYkU=ZG_tNrg@mail.gmail.com>
        (Jeff Xu's message of "Sun, 12 Feb 2023 21:44:27 -0800")
Message-ID: <875yc6c8uf.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Jeff Xu <jeffxu@chromium.org> writes:

> On Fri, Sep 23, 2022 at 11:45 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> Paul Moore <paul@paul-moore.com> writes:
>>
>> > On Fri, Sep 23, 2022 at 1:43 PM Jeff Xu <jeffxu@chromium.org> wrote:
>> >> On Wed, Sep 21, 2022 at 12:11 PM Paul Moore <paul@paul-moore.com> wrote:
>> >> > On Wed, Sep 21, 2022 at 2:54 PM <jeffxu@chromium.org> wrote:
>> >> > >
>> >> > > From: Jeff Xu <jeffxu@chromium.org>
>> >> > >
>> >> > > When SECURITY_SELINUX_DEVELOP=y and the system is running in permissive
>> >> > > mode, it is useful to disable logging from permissive domain, so audit
>> >> > > log does not get spamed.
>> >> > >
>> >> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>> >> > > Signed-off-by: Luis Hector Chavez <lhchavez@google.com>
>> >> > > Tested-by: Luis Hector Chavez <lhchavez@chromium.org>
>> >> > > Tested-by: Jeff Xu<jeffxu@chromium.org>
>> >> > > ---
>> >> > >  security/selinux/Kconfig | 10 ++++++++++
>> >> > >  security/selinux/avc.c   |  9 +++++++++
>> >> > >  2 files changed, 19 insertions(+)
>> >> >
>> >> > I'm sorry, but I can't accept this into the upstream kernel.
>> >> > Permissive mode, both per-domain and system-wide, is not intended to
>> >> > be a long term solution.  Permissive mode should really only be used
>> >> > as a development tool or emergency "hotfix" with the proper solution
>> >> > being either an adjustment of the existing policy (SELinux policy
>> >> > booleans, labeling changes, etc.) or the development of a new policy
>> >> > module which better fits your use case.
>> >>
>> >> Thanks for the response.
>> >> For a system that wants to control a few daemons, is there a
>> >> recommended pattern from selinux ?
>>
>> That is effectively a "targeted" policy model. You target a selection of
>> entities and everything else is "unconfined" (ie not targeteed).
>>
>> An "unconfined" domain is just a process type that has many allow rules
>> associated with it making it effectively similar to an "permissive"
>> domain. The difference is that since "unconfined" domains have full
>> access there should not be any AVC denials (nothing is blocked by
>> SELinux because the policy does not target the entity)
>>
> It seems that my system doesn't have unconfined_t, so
> I am trying to get an example.

It does not necessarily have to be unconfined_t.

>
> Can I use a wildcard, something like below ?
> type unconfined_t
> allow unconfined_t *

I took some time to try and come up with an example that goes to the
essence. For this i used the example tiny cil-policy from the SELinux
notebook. You would need `secilc`, `seinfo` and, `sesearch` to try it
out yourself:

curl \
https://raw.githubusercontent.com/SELinuxProject/selinux-notebook/main/src/notebook-examples/cil-policy/cil-policy.cil \
> cil-policy.cil

secilc -vvv cil-policy.cil
seinfo policy.33

this is "tiny CIL policy" it can be used for demonstration.
it has a single type "sys.isid":

seinfo policy.33 -t

and it has only one security class that has two access vector permissions
associated with it namely: "process { dyntransition transition }"

seinfo policy.33 -xc

the single type "sys.isid" has "unconfined" access:

sesearch policy.33 -A

this is essentially the simplest example of an "unconfined" domain.

lets add a new type, and new security class and some permissions. to demonstrate what
it takes to have a unconfined domain in an environment that has more than just one
type, one security class and two permission.

I will do it in stages.

echo '(type mytype) ;; a new type' >> cil-policy.cil
echo '(class myclass ( myperm1 myperm2 )) (classorder (unordered myclass)) ;; a new class with two new permissions' >> cil-policy.cil

secilc -vvv cil-policy.cil
seinfo policy.33
seinfo policy.33 -t
seinfo policy.33 -xc
sesearch policy.33 -A

now type sys.isid is no longer an unconfined domain because it does not have access
to "myclass { myperm1 myperm2 }". The new "mytype" type has no permisssions associated with it at all.

to make sys.isid unconfined again we have to:

1. (allow sys.isid sys.isid (myclass (myperm1 myperm2)))
2. (allow sys.isid mytype (myclass (myperm1 myperm2)))
3. (allow sys.isid mytype (process (dyntransition transition)))

this is a bit hard to manage. we can use type attributes to group types:

echo '(typeattribute mytypes) ;; a new type attribute' >> cil-policy.cil
echo '(typeattributeset mytypes (sys.isid mytype)) ;; all our types are associates' >> cil-policy.cil

secilc -vvv cil-policy.cil
seinfo policy.33 -xamytypes

now the above 3 rules can be written in a simpler way:

echo '(allow sys.isid mytypes (myclass (all))) ;; access to effectively: * myclass *' >> cil-policy.cil
echo '(allow sys.isid mytypes (process (all))) ;; access to effectively: * process *' >> cil-policy.cil

secilc -vvv cil-policy.cil
seinfo policy.33
seinfo policy.33 -t
seinfo policy.33 -xc
sesearch policy.33 -A

I think this is probably the simplest example of an unconfined domain.
type attributes can be used to "organise your policy"
if you plan your policy well then eventually making a "domain" unconfined could be as
easy as associating it with a type attribute.

sesearch policy.33 -A -t sys.isid -t mytypes -dt
seinfo policy.33 -xa mytypes

for example we could create a type attribute called "unconfined_access" and associate
all access vectors with it:

(typeattribute unconfined_access)
(allow unconfined_access mytypes (myclass (all)))
(allow unconfined_access mytypes (process (all)))

then to make type "mytype" unconfined as well; simple associate it with unconfined_access

(typeattributeset unconfined_access (mytype)))

>
> An example would be appreciated.
>
> Thanks!
> -Jeff
>
>
>
>> The stock policy enforced in Red Hat based distributions is a "targeted"
>> policy model for example. The unconfined_t domain is one of various
>> "unconfined" domains (other examples are unconfined_service_t but
>> effectively any type could be made unconfined by simply allowing all accesses.
>>
>> >
>> > Guidance on how to write a SELinux policy for an application is a bit
>> > beyond what I have time for in this email, but others on this mailing
>> > list might be able to help.  There has definitely been a lot written
>> > on the subject, both available online and offline.  My suggestion
>> > would be to start "small" with a single SELinux domain for the
>> > application and a single type for any configuration, data, or log
>> > files it might need; get this initial domain working properly and then
>> > you can add increasing levels of access control granularity until
>> > you've met your security requirements.  If you've never done this
>> > before, go slow, the start might be challenging as you get used to the
>> > tools, but you can do it :)
>> >
>> >> I read this blog about unconfined domain (unconfined_t), maybe this is one way ?
>> >> https://wiki.gentoo.org/wiki/SELinux/Tutorials/What_is_this_unconfined_thingie_and_tell_me_about_attributes
>> >
>> > It is important to remember that an unconfined domain is, as the name
>> > would imply, effectively unconfined by SELinux.  Perhaps this is what
>> > you want, but generally speaking if you are running SELinux it is
>> > because you have a need or desire for additional access controls
>> > beyond the legacy Linux discretionary access controls.
>> >
>> >> I have two questions on unconfined domain:
>> >> 1> Is unconfined_t domain supported in SECURITY_SELINUX_DEVELOP=n mode ?
>> >
>> > Yes.  The SECURITY_SELINUX_DEVELOP kernel build configuration only
>> > enables the admin to boot the kernel initially in permissive mode
>> > and/or determine the SELinux mode using the "enforcing=X" kernel
>> > command line option and a sysfs/securityfs tunable under
>> > /sys/fs/selinux/enforce.  The unconfined_t domain is defined purely in
>> > the SELinux policy and not the kernel; you could write a SELinux
>> > policy without it you wanted, or you could grant unconfined_t-like
>> > permissions to multiple different domains in your policy.  It's been a
>> > while since I played with it, but I believe the SELinux reference
>> > policy (refpol) provides a macro interface to define an arbitrary
>> > domain with unconfined_t-like permissions.
>> >
>> >> 2> will unconfined_t domain log also as permissive domain ?
>> >
>> > The intent of the unconfined_t domain is that there would be no access
>> > denials due to SELinux and thus no AVC audit records related to the
>> > unconfined_t domain.  It is not permissive in the sense of the SELinux
>> > "mode" (enforcing/permissive/disabled), but it is permissive in the
>> > sense that it is given a large number of permissions.
>>
>> --
>> gpg --locate-keys dominick.grift@defensec.nl
>> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
>> Dominick Grift

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
