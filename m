Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387B3ECAAD2
	for <selinux@archiver.kernel.org>; Mon, 29 Aug 2022 21:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiH2VWE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Aug 2022 17:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH2VWD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Aug 2022 17:22:03 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5125C22B1F
        for <selinux@vger.kernel.org>; Mon, 29 Aug 2022 14:22:02 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id q7so12905246lfu.5
        for <selinux@vger.kernel.org>; Mon, 29 Aug 2022 14:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FfEexeR0fdxug5T5tXNLR+Y90NZlQ+7ERJmRuGbGmjc=;
        b=uEeql5O+++hTpdR2+zwJed7Tjaq0Y2iBQvFoAonPBmwdOGrqWMYG5ci/fGkpVXT6G9
         2iK9CuSe8oI+mEH0fRHiuIEA5NgCxbodT2H6PMqQotmtxXef9nKZaCm5OXlO+68TmhIS
         Gzf9BZ4Cf+gL6bh8CDh4konLpFQrluZlS9v5pQSJIW4GWdrOGZUjWHVSHk4O3c9EKRVz
         kWLuVqjEZrF4FlYhoXiFpq5SXoDaFTjwgOLjcbDy/SdVMrbgzIOeRMmKNhSi8oXkxWi3
         xt5jeX+O6F1vNv0W40uFtI0h5EO9wtNt/zce3S7HoXnbvJKqcNQVp2xlNhfHnWFK7zLp
         iscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FfEexeR0fdxug5T5tXNLR+Y90NZlQ+7ERJmRuGbGmjc=;
        b=ZZclcfBa/8Ri5mnt43rsxYckWq/pdtjmcNapsoIbSxvpsjEHq4FTraQzQKKNWEz+Ky
         7dFShgx4skbR41DKivpiYGqOUhPVvNynIA42phdNHw82Cupiab0o4Q+rsnmHoqCXJKfZ
         BOj6lhQE2wtu36b50x2E9WkJ2FOa9LeqxmXlO1ySwivCzrFVoP5x/Ky2iXTLc43kiRw/
         0/jS0Pebz830oAqsT0snPWs3nDvt8iLIP3bHAhbzAwe69iknPJv3xA/zMwg8baGRFfAS
         b9LS6Aj4QudgJSTT+OBXlGxsYVvMQ/KiLIEa8zDAnxmW/e6FiiH8VEnMApqlN2l6W7V8
         BAcg==
X-Gm-Message-State: ACgBeo1ApPIUIygZhWRIC4H3mfHdXdVHXDF9QB+X77K96IGWem4abwgS
        fq/y44Tr+KYP5LZKGJ1QaW/rkBALZwfH78+xCOKR25ISnw==
X-Google-Smtp-Source: AA6agR5+8d7DNgbFAXrYCirnMKddPBgizWqwVmHeJnU/103KZiEtdfAwqYpxPWCJemu5sHV/U9eATpZ5eOwqnf8KGHs=
X-Received: by 2002:a05:6512:1687:b0:492:db5e:7768 with SMTP id
 bu7-20020a056512168700b00492db5e7768mr7130530lfb.118.1661808120616; Mon, 29
 Aug 2022 14:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQHS_v7gqXsdCpE3LXA4JzL=-K0U7Q9jiGY5EqT6XCoQbg@mail.gmail.com>
 <Ywc+pjOFkAEswVuQ@gardel-login> <CAFPpqQEva6Z339ZXKxF2=ueug7YFrsFD0Tk6W88cZQxx0sg7OQ@mail.gmail.com>
In-Reply-To: <CAFPpqQEva6Z339ZXKxF2=ueug7YFrsFD0Tk6W88cZQxx0sg7OQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 29 Aug 2022 17:21:49 -0400
Message-ID: <CAHC9VhST2zg4w51KnxnsXp0CSULXtp9iRiXaJ18is2dtV55cdQ@mail.gmail.com>
Subject: Re: [systemd-devel] socket activation selinux context on create
To:     Ted Toth <txtoth@gmail.com>
Cc:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 25, 2022 at 9:22 AM Ted Toth <txtoth@gmail.com> wrote:
> I asked on the systemd-devel list about enabling systemd to set the
> context of a socket and got the answer I've included below. I don't
> know how a transition rule can be written to transition tcp sockets to
> multiple different target contexts, is this possible and if so how?

Ignoring setsockcreatecon(3) as that really isn't an option here,
sockets created via socket(2) do check to see if there is a type
transition defined in the policy.  In the case of a TCP socket the
type transition would look something like this:

  type_transition <domain> <domain>:tcp_socket <new_socket_type>

... so you can see there is not much one can select on other than the
socket's object class.  The reason is that the socket(2) call itself
is rather spartan, with not even any clue as to if this is a client or
server socket in the case of TCP.

Taking a step back, what are you trying to do?  Perhaps there is
another approach that would get you where you want to go.

> ---------- Forwarded message ---------
> From: Lennart Poettering <lennart@poettering.net>
> Date: Thu, Aug 25, 2022 at 4:19 AM
> Subject: Re: [systemd-devel] socket activation selinux context on create
> To: Ted Toth <txtoth@gmail.com>
> Cc: <systemd-devel@lists.freedesktop.org>
>
>
> On Mi, 24.08.22 11:50, Ted Toth (txtoth@gmail.com) wrote:
>
> > I don't see a way to set the context of the socket that systemd
> > listens on. If there is a way to do this please tell me otherwise I'd
> > like to see an option (SELinuxCreateContext?) added to be able to set
> > the context (setsockcreatecon) to be used by systemd when creating the
> > socket. Currently as an extra layer of security I add code called in
> > the socket activation ExecStartPre process to check that the source
> > context (peercon) can connect to the target context (getcon). If a
> > sockets context was set by systemd I would have to perform this
> > additional check as my SELinux policy would do it for me.
>
> This was proposed before, but SELinux maintainers really want that the
> loaded selinux policy picks the label, and not unit files.
>
> i.e. as I understand their philosophy: how labels are assigned should
> be encoded in the database and in the policy but not elsewhere,
> i.e. in unit files. I think that philosophy does make sense.
>
> Lennart

-- 
paul-moore.com
