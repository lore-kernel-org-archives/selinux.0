Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E4BC432BE
	for <selinux@archiver.kernel.org>; Wed, 25 Aug 2021 21:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B731C610CA
	for <selinux@archiver.kernel.org>; Wed, 25 Aug 2021 21:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhHYV0G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Aug 2021 17:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhHYVZ6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Aug 2021 17:25:58 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09919C061757;
        Wed, 25 Aug 2021 14:25:12 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y6so1110652lje.2;
        Wed, 25 Aug 2021 14:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=onNFaQ+UxK/ozeiBzbt9hRTToHp8HFwJqCJBUWKvBrU=;
        b=Hw9DIG3WKR6UBCPiv3ZJ4Z+QUqh58geNdWNEMDMx73/XBbyErz3jAY+YmwtxYvfqDV
         fTXJFhRa1nLq4p5m27DOjBnqB9i2WHWuuDKCg0rNjfAW+JcUfBVirws+cUnHRniNgLxD
         Z4+OB9WJ3ae7XPj+shi04Au1GYxMVFmML4YlF48+M9PhUi2HK7K+VkRM3rEFnYBGO7xw
         JUAcBEUvekHFP1kyrVzVNmgPTPfJICnwCpBrBB9nt+YzFoAoOFLm3SZlTqMIpWb/Wh6C
         SsAukZ3dTTF94q8G67EgdVoXFQlRHjIAMlrA5HzWIR0FVwMwibIn2Rala5F9cAgNsmrt
         Tq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onNFaQ+UxK/ozeiBzbt9hRTToHp8HFwJqCJBUWKvBrU=;
        b=a561dMvEbJ//5HAT+tn1hPCeb6CkEx+fqCC1Ea1Y+DDNCu9BLk3wwistjZtOSSA12U
         xRsPF5uufjsNun99EHR5Zb7+Q15W+4ImIVPwntcdtbm1tIg9s3H+jXjMqYb9guo3Kwci
         nRpvr2CWHIc1JwaS5radv1CpPtCX1ibcbOjlIZ4/jqZxwVWT1G8njRaHUzkdE2ZCGE+A
         ySEZBiTT7woUg4cQOaFUjh4dObQJ+1/3+ztofTAzggXdjN2nM0HF9I2s5ybmJwm/L5P+
         noGGPcg7jTtbvBcUc/oC6pmQNulyvPZXBEAXXFgzGvq+660jSjU3d3jt8XePABkW/+gl
         HPUQ==
X-Gm-Message-State: AOAM5300OEHW1Gvq78xaPhbIZCIjRyACN0wdNEozWzmQvMh6Z5V9iCDT
        7UO553yM1UDjmoAiz0QH3sDPRq8ww2z5+pniV05HvrdKPx0=
X-Google-Smtp-Source: ABdhPJxCppZXFjnf2O+KgGnsY0qChEbmyziZt+MZH684JdGnP1ABEZm1DetFI9hUT59TmMeoqwZoBvvmZKZhVnoJb7w=
X-Received: by 2002:a2e:5345:: with SMTP id t5mr245887ljd.20.1629926710348;
 Wed, 25 Aug 2021 14:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <5ab91c4a-1916-02a3-4011-93ea2c7a9fb2@redhat.com>
 <CAEjxPJ61LJK5tOX2Fr4F2Aubjfo-rkW1EAe9YDG_G6CQ-gr=-w@mail.gmail.com> <5001fd3a-7abc-9163-c912-c7d975c2fab3@schaufler-ca.com>
In-Reply-To: <5001fd3a-7abc-9163-c912-c7d975c2fab3@schaufler-ca.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 25 Aug 2021 17:24:59 -0400
Message-ID: <CAEjxPJ6dVT5XDh7jJrtcXTA4sfJwcJtvj2LOvXYRWKAz86xGyg@mail.gmail.com>
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

On Wed, Aug 25, 2021 at 5:06 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 8/25/2021 1:26 PM, Stephen Smalley wrote:
> > On Wed, Aug 25, 2021 at 3:19 PM Daniel Walsh <dwalsh@redhat.com> wrote:
> >> The problem is how do we handle a VM with SELinux enabled and the rootfs
> >> handled by virtiofsd? Or if the SELinux inside of the VM wanted to write
> >> multiple different labels on a volume mounted in via virtiofsd.
> >>
> >> Here is how Vivek defines it:
> >>
> >> ```
> >> How do we manage SELinux host and guest policy with passthrough
> >> filesystems like virtiofs. Both guest and host might have different
> >> SELinux policies and can conflict with each other in various ways. And
> >> this problem exacerbates where there are nested VM guests. Now there
> >> are 3 entities with possibly 3 different SELinux policies and still
> >> all the real security.selinux xattr is created and stored on host
> >> filesystem.
> >>
> >> One possible proposal is to remap guest SELinux xattrs to some other
> >> name, say user.virtiofs.security.selinux. That way host will enforce
> >> SELinux policy based on security.selinux xattr stored on file. Guest
> >> will get labels stored in user.virtiofs.security.selinux and guest
> >> kernel will enforce that. This in theory provides both guest and
> >> host policies to co-exist and work. And this can be extended to
> >> nested guest where its attrs are prefixed by one more level of
> >> user.virtiofs. IOW, user.virtiofs.user.virtiofs.security.selinux
> >> will be the xattr on host which will show up as security.selinux
> >> xattr when nested guest does getxattr().
> >>
> >> Virtiofsd currently has capability to do this remapping. One problem
> >> we have is that we are using "user" xattr namespace and one can
> >> not use "user" xattr on symlinks and special files. So when guest
> >> tries relabeling or chcon on these files, it fails. May be this is
> >> fixable. I have done an RFC propsal upstream.
> >>
> >> https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgoyal@redhat.com/
> >>
> >> Looking for thoughts how to fix the issue of SELinux with passthrough
> >> filesystems. What's the best way to solve this issue.
> >>
> >> Thanks
> >> Vivek
> >>
> >> ```
> >>
> >> We used to talk about this way back when, but never found a good solution. Theoretically
> >> labeled NFS has the same issue, but I don't believe there are any NFS rootfs using SELinux.
> > The early labeled NFS work included a notion of a label
> > domain-of-interpretation (DOI) field and label translation as part of
> > the infrastructure but I don't think that made it into mainline?
> > It is however part of the NFSv4.2 spec I believe (called a label
> > format specifier or LFS).
> > At present I believe the assumption is that either the NFS server is
> > just a "dumb" server that is not enforcing any SELinux policy at all
> > (just storing the labels for use by clients) or is enforcing the same
> > policy as the clients.
> >
> > A while ago James Morris proposed an approach to namespaced selinux
> > xattrs to support selinux namespaces,
> > https://lore.kernel.org/linux-security-module/alpine.LFD.2.20.1711212009330.6297@localhost/
> > .
> > However, that keeps them in the security.* namespace which on the one
> > hand better protects them from tampering but runs afoul of virtiofsd's
> > goal of avoiding the need to run with capabilities.
> >
> > If we use the user. namespace we need a way to control which processes
> > can change these attributes (or remove them) on the host; optimally we
> > could limit it to only virtiofsd itself and no other processes not
> > even
> > root processes on the host. That presumably requires some kind of LSM
> > hook or hook call; the current SELinux setxattr and removexattr hooks
> > don't care about user.* beyond a general setattr permission check.
>
>         "Wow, if only there was a round thing we could attach to this
>          wagon so it wouldn't be so hard to pull."
>
> I must be missing something really obvious. User namespaces map uids
> and gids to their parent namespace. An xattr namespace could do exactly
> the same thing, mapping security.selinux=foo in the child namespace to
> security.selinux=bar in the parent namespace. We know how to do this for
> uids, and have found and addressed a bunch of issues. Why do something
> different? There's no reason to make this LSM specific, or even something
> that's only useful for security attributes. I know that we've got partial
> "solutions", including virtiofs and various LSM specific namespace schemes.
> Nothing I've seen wouldn't be better served by an xattr namespace.
>
> Warning: I am not a fan of namespaces. I am less a fan of having dozens
> of "solutions", none of which work with any of the others, all of which
> have to be made to play nice together by user-space services.

The uid mappings for user namespaces are simplified by the fact that
uids are totally ordered so you can express the mapping compactly
using ranges.
Even for MLS/BLP, labels are only partially ordered and in TE, there
is no order at all among types.
Defining a complete mapping of all SELinux labels (to include all
possible category sets with all possible sensitivities with all
possible types...) would be huge.
There may not even be any one label in any of the policies in question
that can serve as the "ground truth" label that can be stored in the
filesystem xattr and mapped to a label in every other policy.
