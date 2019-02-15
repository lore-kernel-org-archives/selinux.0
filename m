Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DD8C43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 19:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5642921B18
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 19:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdQnIOuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfBOTVo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:21:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39339 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfBOTVo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Feb 2019 14:21:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so3539091wmg.4
        for <selinux@vger.kernel.org>; Fri, 15 Feb 2019 11:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/S2m892hx10PVvgE/YZydPA1rew+Qw7ulPx+R8VWSwY=;
        b=AdQnIOuBOLJo54lnWJleDj4nY9ZiQS+dwBpg5hPEs0ik8574d6pYykLhTY0zFcen6B
         0jBzADar/RVE4bb+IYRZW/RkjioAj6uJ1n0HbxZhhZRGnTD4ek1z8u+XRCxXh7yuJivI
         y33av8WEi/9Rit6BYdO08vXjImCvueRYs7Z+tdQvDdaYKQJ8y4PnYSzRgZJzK+4rK1LW
         P03KXqBHjN0qxiUVm4/0yHEc8sVBSfTyn0eQr2uSzMhCchLkTyEcE4kqhqKBHMxDZdpN
         mvy3x29R3ycQk+DH5H+mlwt00fysHtc/Pq7fNhkv8DsIBT+UJWfiyYUARlOV182qx1ck
         dDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=/S2m892hx10PVvgE/YZydPA1rew+Qw7ulPx+R8VWSwY=;
        b=mFkrzc92ar2MI1nmW7/hY72iLNq2z+3TKo0VD3XdsTeH5krLem28U57xZNzsrPB2h+
         oyt48+vYzfMRmC9p0jWxBhOlvwLzzX4hdgau/2A0eNd5MjSMxJQZchIv8UYc7YQeADrI
         t3i+SCwbsypv+ZA/Kts26qfWDmg8+oQuUBhTDSd4638vP3ylywtYkvrFpbDDPL2PTC9q
         9S0GUfJj1YDX7CnPot6Ac6feuj96GwU2ai1qCvBshIT0uca5h5cPsy0NWFKdxKpygNAq
         nRg8WJuv4Q9W4PNHh6L75glqPjCJJtUXohV8ciXNTqwYE7OOf+9jB9TtgbuALu8RgTLz
         To8g==
X-Gm-Message-State: AHQUAuaNGkNkUZkxfYKvP88oIn0kePnR0WTbZKvLmrtX5iJlpcrWvFcC
        OVr9vS3bZW2/nyvadknCfpNm+UgX
X-Google-Smtp-Source: AHgI3IYWtUjbkTaWkQVxvi+0zRDw7gxyj2y/aoj64N0f1FQ4Il3itwS9VqdXT8DM97HD9otY6O7pFg==
X-Received: by 2002:a50:b36f:: with SMTP id r44mr8660447edd.284.1550258502098;
        Fri, 15 Feb 2019 11:21:42 -0800 (PST)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id t12sm1736106edj.61.2019.02.15.11.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 11:21:41 -0800 (PST)
From:   Dominick Grift <dac.override@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
References: <20190215145045.31945-1-sds@tycho.nsa.gov>
        <CAHC9VhS+F-QBU-oJpXw1aAP1=TpekD1GEYB8y-QqEib1mzbwMA@mail.gmail.com>
        <5c95e956-6d38-78dd-75e2-df2c37bd998a@tycho.nsa.gov>
        <3f279367-2c4f-5b26-e31b-58eb037b687b@tycho.nsa.gov>
        <5da1e226-1c75-a732-7d92-89a9dfd4c857@tycho.nsa.gov>
        <0e556b37-90fa-7f3a-f60f-fa77acce6f5b@tycho.nsa.gov>
        <87zhqxkn8a.fsf@gmail.com> <87r2c9klrh.fsf@gmail.com>
        <CAHC9VhR9b8udyh7WWAw0-G64DuaLBN59QXByteBdVbtZKnUj-A@mail.gmail.com>
Date:   Fri, 15 Feb 2019 20:21:40 +0100
In-Reply-To: <CAHC9VhR9b8udyh7WWAw0-G64DuaLBN59QXByteBdVbtZKnUj-A@mail.gmail.com>
        (Paul Moore's message of "Fri, 15 Feb 2019 14:11:40 -0500")
Message-ID: <87lg2g97sr.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> On Fri, Feb 15, 2019 at 12:24 PM Dominick Grift <dac.override@gmail.com> wrote:
>> Dominick Grift <dac.override@gmail.com> writes:
>> > Stephen Smalley <sds@tycho.nsa.gov> writes:
>> >
>> >> On 2/15/19 10:25 AM, Stephen Smalley wrote:
>> >>> On 2/15/19 10:05 AM, Stephen Smalley wrote:
>> >>>> On 2/15/19 10:03 AM, Stephen Smalley wrote:
>> >>>>> On 2/15/19 10:00 AM, Paul Moore wrote:
>> >>>>>> On Fri, Feb 15, 2019 at 9:51 AM Stephen Smalley
>> >>>>>> <sds@tycho.nsa.gov> wrote:
>> >>>>>>> Add basic MLS policy support to mdp.  Declares
>> >>>>>>> two sensitivities and two categories, defines
>> >>>>>>> mls constraints for all permissions requiring
>> >>>>>>> dominance (ala MCS), assigns the system-high
>> >>>>>>> level to initial SID contexts and the default user
>> >>>>>>> level, and assigns system-low level to filesystems.
>> >>>>>>>
>> >>>>>>> Also reworks the fs_use and genfscon rules to only
>> >>>>>>> generate rules for filesystems that are configured
>> >>>>>>> in the kernel.  In some cases this depends on a specific
>> >>>>>>> config option for security xattrs, in other cases security
>> >>>>>>> xattrs are unconditionally supported by a given filesystem
>> >>>>>>> if the filesystem is enabled, and in some cases the filesystem
>> >>>>>>> is always enabled in the kernel.  Dropped obsolete pseudo
>> >>>>>>> filesystems.
>> >>>>>>>
>> >>>>>>> NB The list of fs_use_* and genfscon rules emitted by mdp
>> >>>>>>> is very incomplete compared to refpolicy or Android sepolicy.
>> >>>>>>> We should probably expand it.
>> >>>>>>>
>> >>>>>>> Usage:
>> >>>>>>> scripts/selinux/mdp/mdp -m policy.conf file_contexts
>> >>>>>>> checkpolicy -M -o policy policy.conf
>> >>>>>>>
>> >>>>>>> Then install the resulting policy and file_contexts as usual.
>> >>>>>>>
>> >>>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> >>>>>>> ---
>> >>>>>>> v3 fixes up the file contexts generation code to also use
>> >>>>>>> SYSTEMLOW and
>> >>>>>>> collapse down to a single fprintf call per line.
>> >>>>>>>   scripts/selinux/mdp/mdp.c | 131
>> >>>>>>> ++++++++++++++++++++++++++++++--------
>> >>>>>>>   1 file changed, 103 insertions(+), 28 deletions(-)
>> >>>>>>
>> >>>>>> This is great Stephen, thanks for working on this - and rather quickly
>> >>>>>> too!  For those who don't follow the GitHub issues, I just opened an
>> >>>>>> issue yesterday mentioning it would be nice to add MLS support to the
>> >>>>>> mdp tool.
>> >>>>>>
>> >>>>>> Are you planning to keep playing with this?  I'm asking not because I
>> >>>>>> think it needs more work to be worthwhile, but rather I don't want to
>> >>>>>> merge something that you want to continue working on.  If you are
>> >>>>>> happy with this latest patch I think it is okay to merge this into
>> >>>>>> selinux/next, even at this late stage, simply because it is not part
>> >>>>>> of a built kernel, but rather a developer's tool.
>> >>>>>
>> >>>>> No, I think I'm done for now unless you find a problem with
>> >>>>> it. Absent some compelling use case for mdp it is hard to justify
>> >>>>> spending any more time on it.
>> >>>>
>> >>>> Note however that the instructions in
>> >>>> Documentation/admin-guide/LSM/SELinux.rst just say to run
>> >>>> scripts/selinux/install_policy.sh and since that doesn't pass -m to
>> >>>> mdp or -M to checkpolicy, no one will use this support unless they
>> >>>> do it all by hand.
>> >>>
>> >>> FWIW, a Fedora system wouldn't come up cleanly with this policy.
>> >>> Partly appears to be due to systemd having embedded security
>> >>> contexts specific to Fedora/refpolicy into its own configurations
>> >>> and partly due to MLS denials.  I don't even know if it would work
>> >>> before this change though...
>> >>
>> >> Couldn't seem to get a mdp-generated policy to boot on Fedora even in
>> >> permissive, before or after this change.  I assume it has to do with
>> >> leaking of contexts outside of the policy and/or missing config files
>> >> from the dummy policy (e.g. /etc/selinux/targeted/contexts/ has
>> >> systemd_contexts and other userspace config files that don't exist in
>> >> the mdp policy).  More evidence of the irrelevance of mdp...
>> >
>> > Oh, right you need a "dbus_contexts" file probably. DBUS refuses to
>> > start without it, and these day's without dbus no system
>>
>> My dssp2-minimal [1] policy is my alternative to mdp.
>>
>> https://github.com/DefenSec/dssp2-minimal
>>
>> It is not quite as simple as mpd but it think it is decent balance
>> between having something useful and still easy to read.
>
> While dssp2-minimal is much smaller than reference policy, it's still
> an order of magnitude larger than the mdp generated policy.  I'm not
> sure if this is something you care about, but if you wanted to work on
> getting mdp to the point where it would allow a Fedora system (or any
> modern SELinux based system for that matter) to boot, that could be
> useful, even if I'm not convinced it needs to be a priority at the
> moment.

It is also an order of magnitude more useful than mdp.

I suppose I could look at what it would take to get it to boot on some
rainy afternoon. Should not be hard, but i hesitate to polute mdp with
user space access vectors. It feels like setting a precendent somehow.

>
> Besides, haven't you always wanted to get a patch accepted into the
> kernel Dominick? ;)

Not particularly, no.

-- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
