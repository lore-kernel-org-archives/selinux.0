Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2963AECAAD8
	for <selinux@archiver.kernel.org>; Tue, 20 Sep 2022 13:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiITNp5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Sep 2022 09:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiITNp4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Sep 2022 09:45:56 -0400
Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A34F3B9
        for <selinux@vger.kernel.org>; Tue, 20 Sep 2022 06:45:53 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2a10:3781:2099::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id 992F0FC0955;
        Tue, 20 Sep 2022 15:45:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1663681551;
        bh=UVy8u42yqdYP3EPF9oW2b1DXCRRm8esvmUcP1NCWF2M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AxkoPwtFaeQNPITVJ3hn6jM9fBAjXRJck2TqC4X0oJ3wHaAu7Pj6l43xqTfOFNVIm
         Yg9CMJxJAkleZsEWjCpzjRD48bkfKXJ7FlcxYRXaqjoUCaFkKwQQ9lEmPw89Kioah0
         KXNjmXshkAGi+iUvel/WACnOZK9CzwBgk4ihxgww=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH userspace] fixfiles: do not cross mounts when traversing
 directories
In-Reply-To: <CAFqZXNte=_rax99_m06VGSnsJxNiUZ0k_1EZxrHLn-26PBZYWg@mail.gmail.com>
        (Ondrej Mosnacek's message of "Tue, 20 Sep 2022 15:06:26 +0200")
References: <20220919112901.1127409-1-omosnace@redhat.com>
        <CAJ2a_DcJkATZNBKH8Ua9_Wa1KKL16K-TopHQVW2hYOavPMjgWQ@mail.gmail.com>
        <CAFqZXNvp3hLUbR=0t7vfD1oQmL1mdKOpXRyfgWOoeZCv9UU5tw@mail.gmail.com>
        <87illj73vg.fsf@defensec.nl>
        <CAFqZXNte=_rax99_m06VGSnsJxNiUZ0k_1EZxrHLn-26PBZYWg@mail.gmail.com>
Date:   Tue, 20 Sep 2022 15:45:50 +0200
Message-ID: <87edw66twx.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:

> On Mon, Sep 19, 2022 at 5:58 PM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>> Ondrej Mosnacek <omosnace@redhat.com> writes:
>>
>> > On Mon, Sep 19, 2022 at 1:35 PM Christian G=C3=B6ttsche
>> > <cgzones@googlemail.com> wrote:
>> >>
>> >> On Mon, 19 Sept 2022 at 13:29, Ondrej Mosnacek <omosnace@redhat.com> =
wrote:
>> >> >
>> >> > Always run find with -xdev to avoid unintended deleting/relabeling.
>> >> > While this may sometimes skip subdirectories that should be relabel=
ed,
>> >> > the danger of crossing into random mounts is greater than leaving b=
ehind
>> >> > some unlabeled files. The find commands are just best-effort attemp=
ts to
>> >> > fix the labels anyway.
>> >>
>> >> The xdev option does not work for bind mounts (they are still followe=
d).
>> >
>> > Hm... it does not if the bind mounted dir is on the same filesystem
>> > (superblock), so in the case where /tmp is a plain directory on the
>> > root filesystem it will allow traversing to other directories directly
>> > on the root filesystem. I guess that's still better than nothing,
>> > though...
>> >
>> > An alternative (at least for the more dangerous -delete part) could be
>> > to change the prompt to suggest switching to do the equivalent of
>> > `fixfiles -F onboot` + reboot. The current prompt instructs the user
>> > to reboot the machine anyway, so it wouldn't really make things more
>> > complicated for the user. Maybe I'll draft a patch for this...
>>
>> The reason why one is presented with an option to "clear" /tmp is because
>> /tmp is a shared location. That property makes it so that file context
>> specifications usually do not work for these locations in general and
>> /tmp in particular. Relabeling does not apply there -because setfiles is
>> told to ignore these locations- also not with
>> fixfiles (-F) onboot. So telling people to run fixfiles onboot && reboot
>> instead of clearing /tmp does not address the challenge.
>
> Oh, sorry, I meant -f, not -F. That is, the user would be given two choic=
es:
> a) Don't touch /tmp and do the general relabeling immediately. In this
> case the user will be warned that /tmp contents may remain incorrectly
> labeled.
> b) Schedule /tmp resetting + relabeling for next early boot (where the
> recursive delete should be safe). In this case the user will be warned
> that they need to reboot for anything to happen.

Yes, something like that. Here are a few aspects to consider:

- We should be careful with clearing /tmp in general as it could
  interfere with the running system. (for example /tmp/.X11-unix/X0)

- The issue, i think, were trying to solve is not limited to /tmp. The
  up-side is that we can determine what is affected by just
  interpretting the <<none>> specs from the file_contexts were using to
  relabel the file system. Anything with a <<none>> spec is affected and
  not just /tmp/.*

- One alternative would be to, instead of giving the caller to option to
  clear /tmp, explain the issue and how to solve it manually.

- If we leave /tmp uncleared then that might affect the next boot. For
  example youre enforcing a new policy, youre relabeling the filesystem
  according to new specifications. the context currently associated
  with /tmp/.X11-unix/X0 is invalidated by the to be enforced policy. Now
  Xserver might no longer be allowed to operate on the sock file with
  invalid label, and break. (of course I suppose any currently
  running Xserver might "break" as well if you clear /tmp/.X11-unix/X0
  at run-time).

>
>> What I find strange is that one is not also presented with an option to
>> clear /var/tmp, because the same applies there. In that sense, I believe,
>> this opportunity to clear /tmp is half baked. It does not solve the
>> underlying issue of addressing locations that have no file context
>> specifications associated with them for one reason or another.
>
> To be fair, the whole fixfiles script is a mess... Feel free to
> propose a patch, but my goal right now is just to make it less prone
> to unexpected consequences.

True.

Just stating that something is currently half-baked does not
necessarily mean I can do a better job.

>
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
