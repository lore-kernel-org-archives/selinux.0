Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01283ECAAD3
	for <selinux@archiver.kernel.org>; Mon, 19 Sep 2022 15:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiISP6d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Sep 2022 11:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiISP6d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Sep 2022 11:58:33 -0400
Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003FB10544
        for <selinux@vger.kernel.org>; Mon, 19 Sep 2022 08:58:30 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2a10:3781:2099::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id C788FFC0A1D;
        Mon, 19 Sep 2022 17:58:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1663603109;
        bh=aGxk0Bkd/MHW822OpMj4tJ3efLOTWxW+N4+1N4AqdgU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hapla3eSGQxPalT7r/EysfsRPUyJpnvXSeqlvYGvJmZTztqr+ot1NAaYq7wZJDV60
         R19iLqZTa9Cpb6RZN2knqjFsLp7czWTeS6UWCuT/IVAjgrZbCp5wsUWVPXzN/iChoQ
         K0KqMjqlO8eAN3jABj72Z1QoQPWBpLx66NdHrbKg=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH userspace] fixfiles: do not cross mounts when traversing
 directories
In-Reply-To: <CAFqZXNvp3hLUbR=0t7vfD1oQmL1mdKOpXRyfgWOoeZCv9UU5tw@mail.gmail.com>
        (Ondrej Mosnacek's message of "Mon, 19 Sep 2022 17:44:37 +0200")
References: <20220919112901.1127409-1-omosnace@redhat.com>
        <CAJ2a_DcJkATZNBKH8Ua9_Wa1KKL16K-TopHQVW2hYOavPMjgWQ@mail.gmail.com>
        <CAFqZXNvp3hLUbR=0t7vfD1oQmL1mdKOpXRyfgWOoeZCv9UU5tw@mail.gmail.com>
Date:   Mon, 19 Sep 2022 17:58:27 +0200
Message-ID: <87illj73vg.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:

> On Mon, Sep 19, 2022 at 1:35 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
>>
>> On Mon, 19 Sept 2022 at 13:29, Ondrej Mosnacek <omosnace@redhat.com> wro=
te:
>> >
>> > Always run find with -xdev to avoid unintended deleting/relabeling.
>> > While this may sometimes skip subdirectories that should be relabeled,
>> > the danger of crossing into random mounts is greater than leaving behi=
nd
>> > some unlabeled files. The find commands are just best-effort attempts =
to
>> > fix the labels anyway.
>>
>> The xdev option does not work for bind mounts (they are still followed).
>
> Hm... it does not if the bind mounted dir is on the same filesystem
> (superblock), so in the case where /tmp is a plain directory on the
> root filesystem it will allow traversing to other directories directly
> on the root filesystem. I guess that's still better than nothing,
> though...
>
> An alternative (at least for the more dangerous -delete part) could be
> to change the prompt to suggest switching to do the equivalent of
> `fixfiles -F onboot` + reboot. The current prompt instructs the user
> to reboot the machine anyway, so it wouldn't really make things more
> complicated for the user. Maybe I'll draft a patch for this...

The reason why one is presented with an option to "clear" /tmp is because
/tmp is a shared location. That property makes it so that file context
specifications usually do not work for these locations in general and
/tmp in particular. Relabeling does not apply there -because setfiles is
told to ignore these locations- also not with
fixfiles (-F) onboot. So telling people to run fixfiles onboot && reboot
instead of clearing /tmp does not address the challenge.

What I find strange is that one is not also presented with an option to
clear /var/tmp, because the same applies there. In that sense, I believe,
this opportunity to clear /tmp is half baked. It does not solve the
underlying issue of addressing locations that have no file context
specifications associated with them for one reason or another.

>
> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
