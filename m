Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803FBC761A6
	for <selinux@archiver.kernel.org>; Fri, 31 Mar 2023 20:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCaUFu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Mar 2023 16:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCaUFt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Mar 2023 16:05:49 -0400
Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6150120C0F
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1680293143;
        bh=eUjAT+TMoz2z7goMpkWL7vs+Bold+/HoiWLLqekQOMg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iIzfZtjHN0HLbG6OTFlIz87YnNMXsK4QfOI5rm1Z6lGMCYqKahLYf6ylum0YEgmcc
         Fi1owSb+6ZU7FdXe9fjUyq4osQV3osrie7XOUQs03X+2h5SD8Tb0sKeP0J05CQwJlO
         WynQCExSzDWktbTlAiMnV2VMeTV/UP38H0LS1gqA=
Received: from paulus (paulus.lan [IPv6:2a10:3781:2099::515])
        by markus.defensec.nl (Postfix) with ESMTPSA id 531D371;
        Fri, 31 Mar 2023 22:05:43 +0200 (CEST)
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Subject: Re: sesearch --neverallow
References: <87ileh5ckg.fsf@redhat.com>
        <CAEjxPJ675EhOoKXHzXKaVOoSXfqkqKudPzCL=F4aAG0vbd+Cdg@mail.gmail.com>
        <87h6u0bwvp.fsf@defensec.nl>
        <CAEjxPJ72BTh3MzGje82uN4ayCGFGnJyz7uKobprRhx0R1R0JNA@mail.gmail.com>
Date:   Fri, 31 Mar 2023 22:05:43 +0200
In-Reply-To: <CAEjxPJ72BTh3MzGje82uN4ayCGFGnJyz7uKobprRhx0R1R0JNA@mail.gmail.com>
        (Stephen Smalley's message of "Fri, 31 Mar 2023 15:59:18 -0400")
Message-ID: <87cz4obsa0.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Fri, Mar 31, 2023 at 2:26=E2=80=AFPM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>>
>> > On Fri, Mar 31, 2023 at 8:37=E2=80=AFAM Petr Lautrbach <lautrbach@redh=
at.com> wrote:
>> >>
>> >> Hi,
>> >>
>> >> I've got a question what is `sesearch --neverallow` good for and how =
to
>> >> make it work. I wasn't able to get any output from this command.
>> >>
>> >> Is it supposed to work with current userspace and policies? How?
>> >
>> > I don't see how it could work. neverallow rules aren't preserved in
>> > the kernel policies.
>> > It would only make sense if sesearch could be run on source policies o=
r modules.
>>
>> Which according to `man sesearch` is possible, but only monolithic polic=
y.conf.
>
> Even that doesn't seem to be supported by setools 4,
> $ sesearch --neverallow policy.conf
> Invalid policy: policy.conf. A binary policy must be specified. (use
> e.g. policy.33 or sepolicy) Source policies are not supported.
>
> $ rpm -q -f /usr/bin/sesearch
> setools-console-4.4.0-9.fc37.x86_64

I was probably looking at the man for setools3 then. (the one on linux.die.=
net)

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
