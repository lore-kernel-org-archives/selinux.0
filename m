Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707B9C43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 17:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1923121925
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 17:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGCgDJtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfBORYj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:24:39 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46378 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfBORYj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Feb 2019 12:24:39 -0500
Received: by mail-ed1-f65.google.com with SMTP id f2so8553841edy.13
        for <selinux@vger.kernel.org>; Fri, 15 Feb 2019 09:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ekbHbQTL5SX0GPNp2iwpWz4k0S+b/sqEhTQc2QppY/8=;
        b=RGCgDJtj2x9EoFG6TqHknnifmzlyKY1PjLloIiUja8zxCZcxgkzOnoIg7/Gcujh7D7
         ihUNvrAv1+Gbbt7RaZzeXX5id9IcbaIcuyxdNwgL0qOeyLlMTqB48MtR8AabhvznLcoO
         Z8EmZ7wVAWsy8l4tJEWrieE+7x+jxTgfn6ve6YL7+grgfucGRI6/EmQMqbS7jiCRmVqA
         PBCf7yB+6VuhGLzZgvzU1SSFIQgUYUEJaDk9uMudFi+AaNywxRPFGgQg5Ggdr3oomeWm
         JO/EJjZbyjLUYly7Btu+u6BLi821+1nI7WRmYSz4f/p638giJqc7VqT9XtgPZUGun5wN
         tyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=ekbHbQTL5SX0GPNp2iwpWz4k0S+b/sqEhTQc2QppY/8=;
        b=uUgmeHpi8sORPrIr9a7LaTaqXgqLGjvitwiHpNnUehJOdyhu70vVZ/ecSosjlzjxJ6
         aQCm83PBxI6JnMf8vKpezMApafEV3sN/TlGMDIseU7EnXjUOvmTPYItGK9gCIXMICw/V
         HmzzdZ2rRt3sgMzyTlOIHeN/wmg8NFzcQY5AwSw7edmYJcYlszMC99f3CXiakSFJyd5w
         nAagsC2zvcv8fndhFkpgKKjkbuTUYTjJMmXEDz3BjnYGOWJM301po3ujndbTtsjNLitB
         HfjlR+gwCxpuMg6CnKMinOr0pXYcjD5NLl1J3/6L7Wz2t6Y1Ju4ioo09+sV7mryfB2my
         gf0w==
X-Gm-Message-State: AHQUAuYT6ba6IwQ0O7SHOlyxoeK61uOQjcI8387+5LzN/MGKLWu8DVDc
        639XzNH5awsrWHezNuvmqJdPnod4
X-Google-Smtp-Source: AHgI3IZJclTsNHxxYXpiYPyNj6UxsJ498jzGtp/REPUcPy7y6gZtcBHGkNI06TNwyR/8qHSHLI9dgQ==
X-Received: by 2002:a50:c344:: with SMTP id q4mr8549946edb.250.1550251475897;
        Fri, 15 Feb 2019 09:24:35 -0800 (PST)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id q14sm1623344eds.19.2019.02.15.09.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 09:24:35 -0800 (PST)
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
References: <20190215145045.31945-1-sds@tycho.nsa.gov>
        <CAHC9VhS+F-QBU-oJpXw1aAP1=TpekD1GEYB8y-QqEib1mzbwMA@mail.gmail.com>
        <5c95e956-6d38-78dd-75e2-df2c37bd998a@tycho.nsa.gov>
        <3f279367-2c4f-5b26-e31b-58eb037b687b@tycho.nsa.gov>
        <5da1e226-1c75-a732-7d92-89a9dfd4c857@tycho.nsa.gov>
        <0e556b37-90fa-7f3a-f60f-fa77acce6f5b@tycho.nsa.gov>
        <87zhqxkn8a.fsf@gmail.com>
Date:   Fri, 15 Feb 2019 18:24:34 +0100
In-Reply-To: <87zhqxkn8a.fsf@gmail.com> (Dominick Grift's message of "Fri, 15
        Feb 2019 17:52:53 +0100")
Message-ID: <87r2c9klrh.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Dominick Grift <dac.override@gmail.com> writes:

> Stephen Smalley <sds@tycho.nsa.gov> writes:
>
>> On 2/15/19 10:25 AM, Stephen Smalley wrote:
>>> On 2/15/19 10:05 AM, Stephen Smalley wrote:
>>>> On 2/15/19 10:03 AM, Stephen Smalley wrote:
>>>>> On 2/15/19 10:00 AM, Paul Moore wrote:
>>>>>> On Fri, Feb 15, 2019 at 9:51 AM Stephen Smalley
>>>>>> <sds@tycho.nsa.gov> wrote:
>>>>>>> Add basic MLS policy support to mdp.=C2=A0 Declares
>>>>>>> two sensitivities and two categories, defines
>>>>>>> mls constraints for all permissions requiring
>>>>>>> dominance (ala MCS), assigns the system-high
>>>>>>> level to initial SID contexts and the default user
>>>>>>> level, and assigns system-low level to filesystems.
>>>>>>>
>>>>>>> Also reworks the fs_use and genfscon rules to only
>>>>>>> generate rules for filesystems that are configured
>>>>>>> in the kernel.=C2=A0 In some cases this depends on a specific
>>>>>>> config option for security xattrs, in other cases security
>>>>>>> xattrs are unconditionally supported by a given filesystem
>>>>>>> if the filesystem is enabled, and in some cases the filesystem
>>>>>>> is always enabled in the kernel.=C2=A0 Dropped obsolete pseudo
>>>>>>> filesystems.
>>>>>>>
>>>>>>> NB The list of fs_use_* and genfscon rules emitted by mdp
>>>>>>> is very incomplete compared to refpolicy or Android sepolicy.
>>>>>>> We should probably expand it.
>>>>>>>
>>>>>>> Usage:
>>>>>>> scripts/selinux/mdp/mdp -m policy.conf file_contexts
>>>>>>> checkpolicy -M -o policy policy.conf
>>>>>>>
>>>>>>> Then install the resulting policy and file_contexts as usual.
>>>>>>>
>>>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>>>> ---
>>>>>>> v3 fixes up the file contexts generation code to also use
>>>>>>> SYSTEMLOW and
>>>>>>> collapse down to a single fprintf call per line.
>>>>>>> =C2=A0 scripts/selinux/mdp/mdp.c | 131
>>>>>>> ++++++++++++++++++++++++++++++--------
>>>>>>> =C2=A0 1 file changed, 103 insertions(+), 28 deletions(-)
>>>>>>
>>>>>> This is great Stephen, thanks for working on this - and rather quick=
ly
>>>>>> too!=C2=A0 For those who don't follow the GitHub issues, I just open=
ed an
>>>>>> issue yesterday mentioning it would be nice to add MLS support to the
>>>>>> mdp tool.
>>>>>>
>>>>>> Are you planning to keep playing with this?=C2=A0 I'm asking not bec=
ause I
>>>>>> think it needs more work to be worthwhile, but rather I don't want to
>>>>>> merge something that you want to continue working on.=C2=A0 If you a=
re
>>>>>> happy with this latest patch I think it is okay to merge this into
>>>>>> selinux/next, even at this late stage, simply because it is not part
>>>>>> of a built kernel, but rather a developer's tool.
>>>>>
>>>>> No, I think I'm done for now unless you find a problem with
>>>>> it. Absent some compelling use case for mdp it is hard to justify
>>>>> spending any more time on it.
>>>>
>>>> Note however that the instructions in
>>>> Documentation/admin-guide/LSM/SELinux.rst just say to run
>>>> scripts/selinux/install_policy.sh and since that doesn't pass -m to
>>>> mdp or -M to checkpolicy, no one will use this support unless they
>>>> do it all by hand.
>>>
>>> FWIW, a Fedora system wouldn't come up cleanly with this policy.=C2=A0
>>> Partly appears to be due to systemd having embedded security
>>> contexts specific to Fedora/refpolicy into its own configurations
>>> and partly due to MLS denials.=C2=A0 I don't even know if it would work
>>> before this change though...
>>
>> Couldn't seem to get a mdp-generated policy to boot on Fedora even in
>> permissive, before or after this change.  I assume it has to do with
>> leaking of contexts outside of the policy and/or missing config files
>> from the dummy policy (e.g. /etc/selinux/targeted/contexts/ has
>> systemd_contexts and other userspace config files that don't exist in
>> the mdp policy).  More evidence of the irrelevance of mdp...
>
> Oh, right you need a "dbus_contexts" file probably. DBUS refuses to
> start without it, and these day's without dbus no system

My dssp2-minimal [1] policy is my alternative to mdp.

https://github.com/DefenSec/dssp2-minimal

It is not quite as simple as mpd but it think it is decent balance
between having something useful and still easy to read.

>
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
>>>>>>> index 073fe7537f6c..4223e2fea441 100644
>>>>>>> --- a/scripts/selinux/mdp/mdp.c
>>>>>>> +++ b/scripts/selinux/mdp/mdp.c
>>>>>>> @@ -33,6 +33,7 @@
>>>>>>> =C2=A0 #include <unistd.h>
>>>>>>> =C2=A0 #include <string.h>
>>>>>>> =C2=A0 #include <sys/socket.h>
>>>>>>> +#include <linux/kconfig.h>
>>>>>>>
>>>>>>> =C2=A0 static void usage(char *name)
>>>>>>> =C2=A0 {
>>>>>>> @@ -95,10 +96,31 @@ int main(int argc, char *argv[])
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "\n"=
);
>>>>>>>
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* NOW PRINT OUT MLS STUFF */
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* print out mls declarations=
 and constraints */
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mls) {
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 printf("MLS not yet implemented\n");
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 exit(1);
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "sensitivity s0;\n");
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "sensitivity s1;\n");
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "dominance { s0 s1 }\n");
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "category c0;\n");
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "category c1;\n");
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "level s0:c0.c1;\n");
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "level s1:c0.c1;\n");
>>>>>>> +#define SYSTEMLOW "s0"
>>>>>>> +#define SYSTEMHIGH "s1:c0.c1"
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 for (i =3D 0; secclass_map[i].name; i++) {
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct s=
ecurity_class_mapping *map =3D
>>>>>>> &secclass_map[i];
>>>>>>> +
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(=
fout, "mlsconstrain %s {\n",
>>>>>>> map->name);
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (j =
=3D 0; map->perms[j]; j++)
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "\t%s\n",
>>>>>>> map->perms[j]);
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =
This requires all subjects and
>>>>>>> objects to be
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =
single-level (l2 eq h2), and that the
>>>>>>> subject
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =
level dominate the object level (h1 dom h2)
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =
in order to have any permissions to it.
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(=
fout, "} (l2 eq h2 and h1 dom
>>>>>>> h2);\n\n");
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* types, roles, a=
nd allows */
>>>>>>> @@ -108,34 +130,87 @@ int main(int argc, char *argv[])
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; secc=
lass_map[i].name; i++)
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "allow base_t base_t:%s *;\n",
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 secclass_map[i].name);
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "user user_u ro=
les { base_r };\n");
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "\n");
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "user user_u ro=
les { base_r }");
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mls)
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, " level %s range %s - %s", SYSTEMHIGH,
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SYSTEMLO=
W, SYSTEMHIGH);
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, ";\n");
>>>>>>> +
>>>>>>> +#define USERROLETYPE "user_u:base_r:base_t"
>>>>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* default sids */
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 1; i < =
initial_sid_to_string_len; i++)
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "sid %s user_u:base_r:base_t\n",
>>>>>>> initial_sid_to_string[i]);
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "sid %s " USERROLETYPE "%s\n",
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initial_=
sid_to_string[i], mls ? ":"
>>>>>>> SYSTEMHIGH : "");
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "\n"=
);
>>>>>>>
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_xattr e=
xt2 user_u:base_r:base_t;\n");
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_xattr e=
xt3 user_u:base_r:base_t;\n");
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_xattr e=
xt4 user_u:base_r:base_t;\n");
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_xattr j=
fs user_u:base_r:base_t;\n");
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_xattr x=
fs user_u:base_r:base_t;\n");
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_xattr r=
eiserfs
>>>>>>> user_u:base_r:base_t;\n");
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_xattr j=
ffs2 user_u:base_r:base_t;\n");
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_xattr g=
fs2 user_u:base_r:base_t;\n");
>>>>>>> -
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_task ev=
entpollfs
>>>>>>> user_u:base_r:base_t;\n");
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_task pi=
pefs user_u:base_r:base_t;\n");
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_task so=
ckfs user_u:base_r:base_t;\n");
>>>>>>> -
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_trans m=
queue user_u:base_r:base_t;\n");
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_trans d=
evpts user_u:base_r:base_t;\n");
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_trans h=
ugetlbfs
>>>>>>> user_u:base_r:base_t;\n");
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_trans t=
mpfs user_u:base_r:base_t;\n");
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_trans s=
hm user_u:base_r:base_t;\n");
>>>>>>> -
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "genfscon proc =
/ user_u:base_r:base_t\n");
>>>>>>> +#define FS_USE(behavior, fstype)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_%s %s "=
 USERROLETYPE "%s;\n", \
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 behavior, fstype, mls ? ":" SYSTEMLOW : "")
>>>>>>> +
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Filesystems whose ino=
de labels can be fetched via getxattr.
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>> +#ifdef CONFIG_EXT2_FS_SECURITY
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("xattr", "ext2");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_EXT3_FS_SECURITY
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("xattr", "ext3");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_EXT4_FS_SECURITY
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("xattr", "ext4");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_JFS_SECURITY
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("xattr", "jfs");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_REISERFS_FS_SECURITY
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("xattr", "reiserfs");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_JFFS2_FS_SECURITY
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("xattr", "jffs2");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_XFS_FS
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("xattr", "xfs");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_GFS2_FS
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("xattr", "gfs2");
>>>>>>> +#endif
>>>>>>> +
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Filesystems whose ino=
des are labeled from allocating task.
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("task", "pipefs");
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("task", "sockfs");
>>>>>>> +#ifdef CONFIG_POSIX_MQUEUE
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("task", "mqueue");
>>>>>>> +#endif
>>>>>>> +
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Filesystems whose ino=
de labels are computed from both
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the allocating task a=
nd the superblock label.
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>> +#ifdef CONFIG_UNIX98_PTYS
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("trans", "devpts");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_HUGETLBFS
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("trans", "hugetlbfs");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_TMPFS
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("trans", "tmpfs");
>>>>>>> +#endif
>>>>>>> +
>>>>>>> +
>>>>>>> +#define GENFSCON(fstype, prefix)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "genfscon %s %s=
 " USERROLETYPE "%s\n", \
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fstype, prefix, mls ? ":" SYSTEMLOW : "")
>>>>>>> +
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Filesystems whose ino=
des are labeled from path prefix match
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * relative to the files=
ystem root.=C2=A0 Depending on the
>>>>>>> filesystem,
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * only a single label f=
or all inodes may be supported.
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENFSCON("proc", "/");
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENFSCON("selinuxfs", "/");
>>>>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fclose(fout);
>>>>>>>
>>>>>>> @@ -144,8 +219,8 @@ int main(int argc, char *argv[])
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Wrote policy, but cannot open %s for
>>>>>>> writing\n", ctxout);
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usage(argv[0]);
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "/ user_u:base_=
r:base_t\n");
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "/.* user_u:bas=
e_r:base_t\n");
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "/ " USERROLETY=
PE "%s\n", mls ? ":"
>>>>>>> SYSTEMLOW : "");
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "/.* " USERROLE=
TYPE "%s\n", mls ? ":"
>>>>>>> SYSTEMLOW : "");
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fclose(fout);
>>>>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>> --=20
>>>>>>> 2.20.1
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift
