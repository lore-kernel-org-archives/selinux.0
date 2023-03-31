Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B83C76196
	for <selinux@archiver.kernel.org>; Fri, 31 Mar 2023 18:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjCaS0Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjCaS0Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Mar 2023 14:26:24 -0400
Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4235923693
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1680287178;
        bh=BBtqS9j9+qAda7Djenc/Di4cOYIQ7PnGzBlYo7rUthI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=S17ucSH6FKYk5sGYZI8p1dAjchzMM4B8ODDdXQiHTQMcD9ioYX26VFEGXTdpJmjps
         hnIfThXQEtkRVmVFy7ayhFsNKM8+N7mZyeMm5VxWWOKKNny639QwwnCwgB4Zl2I3EJ
         6l10bHaUuRjBT5yIsQ5bF2e+zjygYuLWreFPDLs0=
Received: from paulus (paulus.lan [IPv6:2a10:3781:2099::515])
        by markus.defensec.nl (Postfix) with ESMTPSA id 42EF671;
        Fri, 31 Mar 2023 20:26:18 +0200 (CEST)
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Subject: Re: sesearch --neverallow
References: <87ileh5ckg.fsf@redhat.com>
        <CAEjxPJ675EhOoKXHzXKaVOoSXfqkqKudPzCL=F4aAG0vbd+Cdg@mail.gmail.com>
Date:   Fri, 31 Mar 2023 20:26:18 +0200
In-Reply-To: <CAEjxPJ675EhOoKXHzXKaVOoSXfqkqKudPzCL=F4aAG0vbd+Cdg@mail.gmail.com>
        (Stephen Smalley's message of "Fri, 31 Mar 2023 14:15:10 -0400")
Message-ID: <87h6u0bwvp.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Fri, Mar 31, 2023 at 8:37=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
>>
>> Hi,
>>
>> I've got a question what is `sesearch --neverallow` good for and how to
>> make it work. I wasn't able to get any output from this command.
>>
>> Is it supposed to work with current userspace and policies? How?
>
> I don't see how it could work. neverallow rules aren't preserved in
> the kernel policies.
> It would only make sense if sesearch could be run on source policies or m=
odules.

Which according to `man sesearch` is possible, but only monolithic policy.c=
onf.

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
