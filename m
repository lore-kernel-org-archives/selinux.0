Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B135CC432BE
	for <selinux@archiver.kernel.org>; Thu, 26 Aug 2021 16:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967A860F4C
	for <selinux@archiver.kernel.org>; Thu, 26 Aug 2021 16:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242967AbhHZQ2a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbhHZQ23 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Aug 2021 12:28:29 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B2C061757;
        Thu, 26 Aug 2021 09:27:42 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id p15so6207591ljn.3;
        Thu, 26 Aug 2021 09:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vTVe3K2jzyVGGpaJ21J8YZk9RJ+xgkCK4sscol6OLcI=;
        b=h2Z248qR8jh2Xeg+JlqhLsvFrqHGATu0KQWd8YpcMU51OQKeH56frWQ67fRWTnO/Ju
         rOBbBpXf0BJsBjx2NJ2k7lm6+LQqdaRM60+NU6xs887cL6+W+Ku7wGuspzE2wkhxSGl0
         NDimIeTV7CpXkPL0XSqigsGrz2kh812I5v6zGPCjrhxVLIi+WdFpkuQatQC+9DbgiNja
         vTschAyju0helD3IrqS9TXVl43krtDg5N7Ik/zIrHIatc0eI1J4fXz+jjtilDy06yYdn
         1og2WEcnS/QexiJLAxqtcjHlgf9BI7XVRbD4BNHHW1kc0Dwes7gXiKR87hwj2qwiZ9eZ
         F0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTVe3K2jzyVGGpaJ21J8YZk9RJ+xgkCK4sscol6OLcI=;
        b=NXA0DB/SbfqOnYwdOGjkUeCrE9gc5vBFHQm4950jGrpi/AKQFClgFGviePe99EEKoj
         /d8ljmj5nDv6yyGNWj9cTIAK42mtyp3/q+NtfLFqrmIAhBYhdhlERdEF8K9MMgLRivxr
         awHFE62tt5BbvGlUBp8mTPmIt9w0PTtvUBjouDanASIJbb8SwOi8uo1JQYnIu+g4cjc4
         NKQpQf6XNcqRhYBFxEoEy+EANwWJdQZFUdR8qeVErnSjN2Qa3ZdOdSecPxyKJvCq146E
         2BSWE61+pZbanCqqwXqyAUe8y74/PigptIn8TX5boDJVk3Cy1u+jZtKnAFjAFNvr0enP
         oinw==
X-Gm-Message-State: AOAM530v/yIDWz46WFLTCMnOgSBdkZ+YbqDL45SPgJA2BD64EhAgb8UE
        FGo+Ohgzr4pwLeheCosylL2HCXai+5c5iLfejvo=
X-Google-Smtp-Source: ABdhPJyvMjEmiRpSEsjZizA4a8YqQH45aQoDuDtT0hs6cVXpkxZGFkDE/E90EiooNGvJOObPWKIechjSqjoA+123iNw=
X-Received: by 2002:a2e:b52d:: with SMTP id z13mr3871472ljm.376.1629995260363;
 Thu, 26 Aug 2021 09:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <5ab91c4a-1916-02a3-4011-93ea2c7a9fb2@redhat.com>
 <CAEjxPJ61LJK5tOX2Fr4F2Aubjfo-rkW1EAe9YDG_G6CQ-gr=-w@mail.gmail.com>
 <5001fd3a-7abc-9163-c912-c7d975c2fab3@schaufler-ca.com> <CAEjxPJ6dVT5XDh7jJrtcXTA4sfJwcJtvj2LOvXYRWKAz86xGyg@mail.gmail.com>
 <74d0e554-1c22-75ba-e427-1ea3501ec8e8@schaufler-ca.com> <CAEjxPJ6LZ9MATpEoWcARDQgmAVJ222RcRk=ri6O61fviSqrKcA@mail.gmail.com>
 <d47062d7-eeab-3094-80dd-a50cd7e626e6@schaufler-ca.com>
In-Reply-To: <d47062d7-eeab-3094-80dd-a50cd7e626e6@schaufler-ca.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 26 Aug 2021 12:27:28 -0400
Message-ID: <CAEjxPJ4411vL3+Ab-J0yrRTmXoEf8pVR3x3CSRgPjfzwiUcDtw@mail.gmail.com>
Subject: Re: There is an interesting conversation going on about virtiofsd and SELinux
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dwalsh@redhat.com, Vivek Goyal <vgoyal@redhat.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 26, 2021 at 11:09 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 8/26/2021 6:46 AM, Stephen Smalley wrote:
> > On Wed, Aug 25, 2021 at 6:12 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 8/25/2021 2:24 PM, Stephen Smalley wrote:
> >>> On Wed, Aug 25, 2021 at 5:06 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>> On 8/25/2021 1:26 PM, Stephen Smalley wrote:
> >>>>> On Wed, Aug 25, 2021 at 3:19 PM Daniel Walsh <dwalsh@redhat.com> wrote:
> >>>>>> The problem is how do we handle a VM with SELinux enabled and the rootfs
> >>>>>> handled by virtiofsd? Or if the SELinux inside of the VM wanted to write
> >>>>>> multiple different labels on a volume mounted in via virtiofsd.
> >>>>>>
> >>>>>> Here is how Vivek defines it:
> >>>>>>
> >>>>>> ```
> >>>>>> How do we manage SELinux host and guest policy with passthrough
> >>>>>> filesystems like virtiofs. Both guest and host might have different
> >>>>>> SELinux policies and can conflict with each other in various ways. And
> >>>>>> this problem exacerbates where there are nested VM guests. Now there
> >>>>>> are 3 entities with possibly 3 different SELinux policies and still
> >>>>>> all the real security.selinux xattr is created and stored on host
> >>>>>> filesystem.
> >>>>>>
> >>>>>> One possible proposal is to remap guest SELinux xattrs to some other
> >>>>>> name, say user.virtiofs.security.selinux. That way host will enforce
> >>>>>> SELinux policy based on security.selinux xattr stored on file. Guest
> >>>>>> will get labels stored in user.virtiofs.security.selinux and guest
> >>>>>> kernel will enforce that. This in theory provides both guest and
> >>>>>> host policies to co-exist and work. And this can be extended to
> >>>>>> nested guest where its attrs are prefixed by one more level of
> >>>>>> user.virtiofs. IOW, user.virtiofs.user.virtiofs.security.selinux
> >>>>>> will be the xattr on host which will show up as security.selinux
> >>>>>> xattr when nested guest does getxattr().
> >>>>>>
> >>>>>> Virtiofsd currently has capability to do this remapping. One problem
> >>>>>> we have is that we are using "user" xattr namespace and one can
> >>>>>> not use "user" xattr on symlinks and special files. So when guest
> >>>>>> tries relabeling or chcon on these files, it fails. May be this is
> >>>>>> fixable. I have done an RFC propsal upstream.
> >>>>>>
> >>>>>> https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgoyal@redhat.com/
> >>>>>>
> >>>>>> Looking for thoughts how to fix the issue of SELinux with passthrough
> >>>>>> filesystems. What's the best way to solve this issue.
> >>>>>>
> >>>>>> Thanks
> >>>>>> Vivek
> >>>>>>
> >>>>>> ```
> >>>>>>
> >>>>>> We used to talk about this way back when, but never found a good solution. Theoretically
> >>>>>> labeled NFS has the same issue, but I don't believe there are any NFS rootfs using SELinux.
> >>>>> The early labeled NFS work included a notion of a label
> >>>>> domain-of-interpretation (DOI) field and label translation as part of
> >>>>> the infrastructure but I don't think that made it into mainline?
> >>>>> It is however part of the NFSv4.2 spec I believe (called a label
> >>>>> format specifier or LFS).
> >>>>> At present I believe the assumption is that either the NFS server is
> >>>>> just a "dumb" server that is not enforcing any SELinux policy at all
> >>>>> (just storing the labels for use by clients) or is enforcing the same
> >>>>> policy as the clients.
> >>>>>
> >>>>> A while ago James Morris proposed an approach to namespaced selinux
> >>>>> xattrs to support selinux namespaces,
> >>>>> https://lore.kernel.org/linux-security-module/alpine.LFD.2.20.1711212009330.6297@localhost/
> >>>>> .
> >>>>> However, that keeps them in the security.* namespace which on the one
> >>>>> hand better protects them from tampering but runs afoul of virtiofsd's
> >>>>> goal of avoiding the need to run with capabilities.
> >>>>>
> >>>>> If we use the user. namespace we need a way to control which processes
> >>>>> can change these attributes (or remove them) on the host; optimally we
> >>>>> could limit it to only virtiofsd itself and no other processes not
> >>>>> even
> >>>>> root processes on the host. That presumably requires some kind of LSM
> >>>>> hook or hook call; the current SELinux setxattr and removexattr hooks
> >>>>> don't care about user.* beyond a general setattr permission check.
> >>>>         "Wow, if only there was a round thing we could attach to this
> >>>>          wagon so it wouldn't be so hard to pull."
> >>>>
> >>>> I must be missing something really obvious. User namespaces map uids
> >>>> and gids to their parent namespace. An xattr namespace could do exactly
> >>>> the same thing, mapping security.selinux=foo in the child namespace to
> >>>> security.selinux=bar in the parent namespace. We know how to do this for
> >>>> uids, and have found and addressed a bunch of issues. Why do something
> >>>> different? There's no reason to make this LSM specific, or even something
> >>>> that's only useful for security attributes. I know that we've got partial
> >>>> "solutions", including virtiofs and various LSM specific namespace schemes.
> >>>> Nothing I've seen wouldn't be better served by an xattr namespace.
> >>>>
> >>>> Warning: I am not a fan of namespaces. I am less a fan of having dozens
> >>>> of "solutions", none of which work with any of the others, all of which
> >>>> have to be made to play nice together by user-space services.
> >>> The uid mappings for user namespaces are simplified by the fact that
> >>> uids are totally ordered so you can express the mapping compactly
> >>> using ranges.
> >> True. A useful optimization.
> >>
> >>> Even for MLS/BLP, labels are only partially ordered and in TE, there
> >>> is no order at all among types.
> >> Ordering or the lack thereof is not critical to the issue.
> >>
> >>> Defining a complete mapping of all SELinux labels (to include all
> >>> possible category sets with all possible sensitivities with all
> >>> possible types...) would be huge.
> >> Without question. But you really only need the labels identified in
> >> the policy, right? SELinux has to be able to deal with a combination
> >> of categories that it hasn't seen before already.
> >>
> >>> There may not even be any one label in any of the policies in question
> >>> that can serve as the "ground truth" label that can be stored in the
> >>> filesystem xattr and mapped to a label in every other policy.
> >> That's true with UIDs and GIDs as well. Except for UID 0, of course,
> >> but that's special in user namespaces. I'm also not convinced that
> >> the policies in the child namespace are really going to deviate from
> >> those in the parent that greatly. Writing a system level SELinux policy
> >> (or Smack rule set, for that matter) is *hard*. Sure, I can see running
> >> an Android policy in a container on a RHEL system, but the mapping has
> >> to be done once by someone in the community, not for every deployment.
> >> And at that, most of the policy will be common.
> >>
> >> I realize that the issues aren't trivial. But to dismiss a technology
> >> because you can't apply a specific set of optimizations to it in a
> >> specific case just ain't right.
> > As a concrete example, an Android policy from a particular
> > device/firmware has 565 file types defined while a CentOS 8.4 policy
> > has 2990 file types defined.
> > There are no types in common between them. Both policies make use of
> > category sets for different purposes; Android encodes information
> > about the
> > user and app IDs into the category set associated with the app data
> > files in order to enforce user/app isolation while CentOS encodes
> > information about the
> > container ID into the category set associated with all container files
> > in order to enforce container isolation. On the host, all files
> > associated with the container
> > are labeled with a single type and a per-container category set.
> > Within the Android container, the files use the full range of types in
> > the Android policy and
> > app data files are assigned a category set representing their user/app
> > ID.  This is just one use case among many.
>
> The virtiofs proposal has the same problem. Any "mapping" mechanism
> has the same problem. The virtiofs mechanism puts guest MAC data into
> attributes protected by DAC on the host. It has a number of other
> issues that have been discussed on the thread. It's a clever hack,
> but like most clever hacks some clever attacker(s) probably already
> have exploits lined up.
>
> If mapping labels and/or policy is too expensive and/or difficult,
> what does make sense? I mean in general, not in just in a special
> case like a VM host exporting a filesystem to its guest?

I think you are conflating things. Any label mapping/translation
mechanism where the label at every layer has to resolve to a single
underlying label will have problems with divergent policies between
the host and guest.
The virtiofsd approach avoids that problem by allowing each layer to
store its own label that only needs to be meaningful with respect to
its policy. Within each layer, that label is protected by the layer's
MAC policy. No mapping is required.
At the host, the guest label is also protected by the host's MAC
policy but not as a MAC label (because it isn't a MAC label for the
host), just as an attribute of the file. In the case of SELinux, a
process must have setattr permission
to the file to set one of its attributes; that's a MAC check separate
from the DAC check.
So for example if the host policy says that only virtiofsd can set
attributes on those files, then the guest MAC labels along with all
the other attributes are protected against tampering by any other
process on the host.
And obviously virtiofsd was already free to fake whatever guest MAC
labels it wants since it is implementing the filesystem to the guest.
Offering an explicit check over the ability of a process on the host
to set one of these guest MAC label attributes would be nice for
additional safety (especially if we cannot in fact limit setting of
attributes of these files
to only virtiofsd on the host) but it isn't strictly required.
