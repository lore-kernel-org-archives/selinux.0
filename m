Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4350CDB483
	for <selinux@archiver.kernel.org>; Tue, 17 Oct 2023 20:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjJQU3J (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Oct 2023 16:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQU3I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Oct 2023 16:29:08 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC747F0
        for <selinux@vger.kernel.org>; Tue, 17 Oct 2023 13:29:04 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d84c24a810dso7161912276.2
        for <selinux@vger.kernel.org>; Tue, 17 Oct 2023 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697574544; x=1698179344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roSMLNHP+gwwhTlf1XgKo9nsppqOzmaJeO33fNjYZrs=;
        b=LHg3lNh1F51W5OV4SYB2lmGKVQKH7e+yhqd/eB9+xSKwyYepok7895AZFBYT5gd2KR
         cYvnyXxqg2/ijVsrer42IH5dXydBpht9bMds0n0o6fset6C9jRAa1PBMoPBUf80SIlMO
         /MWI/cnOvo+pyTQIpY4X5Ov49Ab+fUgaagiXVSBf8K5Q8aE+TigiODo0sRT4TtiyW8he
         KMddW5Rs2JEOXK2+jMnt0hXGRrlLr/pkERIObqkF97fdyC7EyKg7u1WwSDQtweIrMF2j
         iasmne18dl3/qdwS0HOfR9/rVl1TSGkdj6U4toXWCEdSajyjzki7Cbl44iu8I9gEiVwE
         nLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697574544; x=1698179344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roSMLNHP+gwwhTlf1XgKo9nsppqOzmaJeO33fNjYZrs=;
        b=OXVFq2A4lPRjRuU1Oz4WbIKwDfgHbPN8r6nu/d/1FimonqylwpX5vNwgxewFuAQIvm
         7G1+5xlWTIdXPiU2uta4W9xkzAtbKJwfjX36xbm8eQT6LaJboG5XcPRVF1AAEFb0ehto
         we5Gu5LvpXQd7Tf9qLaG91stX0FQEtKWeamSygbn1KBK71fM/IQlubnOvRUkiFsktTjv
         CREJ6UGVlR72s+YoYIZTI8ysrpSg0hCxE1pDoEAszmbR8EN4pEaUk032PUDdOgqo4uDf
         hOqgjHK4kXN3t94TPccjQY/RLPZSQYxMQ3duH3JbV0romX6IpGMvCwnMJUJ1/5px0Dz3
         H9BQ==
X-Gm-Message-State: AOJu0Yymd/Yaix+Un2771ecI5iTmERPBqe/hfOvpHQktEA2PlAJPdmyZ
        QTPD6guQzkoZBDWl0srfg8n7yMS2tJT2ApVYURrH7dSXEMhGPuL30A==
X-Google-Smtp-Source: AGHT+IGvNV1FfJaLKzey6xiCnly4wAs5hFFddtmKpsUjR1qoFsj84V/1SbJSw10p4QdGugFMtNNhrLE1hlfj+3vZx9Y=
X-Received: by 2002:a25:b120:0:b0:d9a:ca1f:4c0 with SMTP id
 g32-20020a25b120000000b00d9aca1f04c0mr3519306ybj.43.1697574543993; Tue, 17
 Oct 2023 13:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231016220835.GH800259@ZenIV>
In-Reply-To: <20231016220835.GH800259@ZenIV>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 17 Oct 2023 16:28:53 -0400
Message-ID: <CAHC9VhTToc-rELe0EyOV4kRtOJuAmPzPB_QNn8Lw_EfMg+Edzw@mail.gmail.com>
Subject: Re: [PATCH][RFC] selinuxfs: saner handling of policy reloads
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 16, 2023 at 6:08=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> [
> That thing sits in viro/vfs.git#work.selinuxfs; I have
> lock_rename()-related followups in another branch, so a pull would be mor=
e
> convenient for me than cherry-pick.  NOTE: testing and comments would
> be very welcome - as it is, the patch is pretty much untested beyond
> "it builds".
> ]
>
> On policy reload selinuxfs replaces two subdirectories (/booleans
> and /class) with new variants.  Unfortunately, that's done with
> serious abuses of directory locking.
>
> 1) lock_rename() should be done to parents, not to objects being
> exchanged
>
> 2) there's a bunch of reasons why it should not be done for directories
> that do not have a common ancestor; most of those do not apply to
> selinuxfs, but even in the best case the proof is subtle and brittle.
>
> 3) failure halfway through the creation of /class will leak
> names and values arrays.
>
> 4) use of d_genocide() is also rather brittle; it's probably not much of
> a bug per se, but e.g. an overmount of /sys/fs/selinuxfs/classes/shm/inde=
x
> with any regular file will end up with leaked mount on policy reload.
> Sure, don't do it, but...
>
> Let's stop messing with disconnected directories; just create
> a temporary (/.swapover) with no permissions for anyone (on the
> level of ->permission() returing -EPERM, no matter who's calling
> it) and build the new /booleans and /class in there; then
> lock_rename on root and that temporary directory and d_exchange()
> old and new both for class and booleans.  Then unlock and use
> simple_recursive_removal() to take the temporary out; it's much
> more robust.
>
> And instead of bothering with separate pathways for freeing
> new (on failure halfway through) and old (on success) names/values,
> do all freeing in one place.  With temporaries swapped with the
> old ones when we are past all possible failures.
>
> The only user-visible difference is that /.swapover shows up
> (but isn't possible to open, look up into, etc.) for the
> duration of policy reload.

Thanks Al.

Giving this a very quick look, I like the code simplifications that
come out of this change and I'll trust you on the idea that this
approach is better from a VFS perspective.

While the reject_all() permission hammer is good, I do want to make
sure we are covered from a file labeling perspective; even though the
DAC/reject_all() check hits first and avoids the LSM inode permission
hook, we still want to make sure the files are labeled properly.  It
looks like given the current SELinux Reference Policy this shouldn't
be a problem, it will be labeled like most everything else in
selinuxfs via genfscon (SELinux policy construct).  I expect those
with custom SELinux policies will have something similar in place with
a sane default that would cover the /sys/fs/selinux/.swapover
directory but I did add the selinux-refpol list to the CC line just in
case I'm being dumb and forgetting something important with respect to
policy.

The next step is to actually boot up a kernel with this patch and make
sure it doesn't break anything.  Simply booting up a SELinux system
and running 'load_policy' a handful of times should exercise the
policy (re)load path, and if you want a (relatively) simple SELinux
test suite you can find one here:

* https://github.com/SELinuxProject/selinux-testsuite

The README.md should have the instructions necessary to get it
running.  If you can't do that, and no one else on the mailing list is
able to test this out, I'll give it a go but expect it to take a while
as I'm currently swamped with reviews and other stuff.

--=20
paul-moore.com
