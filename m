Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4560FC433EF
	for <selinux@archiver.kernel.org>; Wed,  1 Jun 2022 01:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiFABcf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 May 2022 21:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiFABcf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 31 May 2022 21:32:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F023A5B3F9
        for <selinux@vger.kernel.org>; Tue, 31 May 2022 18:32:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x17so284760wrg.6
        for <selinux@vger.kernel.org>; Tue, 31 May 2022 18:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iusQpBgADQZFtf81PUd9wGbuxiCTNqHoaJLA1+rYus0=;
        b=X9NbzJO+B7FME2e+AR39vWX+HmTqjcipXOM61F+Z1m7DRPyM1+RWt74f2d515L7Z7g
         2xf11ipZNfS88Ra30Hd2r4ZPHcVxGFkL0mKbmzyLSj6ga7+cNZbqx2pUanYIzePlTf13
         Q1dUb9jPiB/U6ursqIqPyKE2Vvz2D/Fbp7zSJ+FzGRpDliChT5CX24AcwDN1ugghv2a9
         hGRlrXkof9FV+d3fRAdPJD0QWfdL8iNku8s7DVqpqE5DXsM7CT2ndF8s71UM6fIhXuOE
         E1u3iZTjvWzhxut81AVzRLNb1gwtHRkN7/RDmSyqI/gE+tE7WAWc2lS+gOYKfKIruWZZ
         vN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iusQpBgADQZFtf81PUd9wGbuxiCTNqHoaJLA1+rYus0=;
        b=HHH9N6KnYGfcsj3lJfeQGZrVCCcNJkPVphiRbm/nT5ajF8MZ7b0bXBsOydRh7OgNB6
         gVTu2Gf3v9nUiS6Y00U1iJ7vFDp6kM5EiQ4LaYSVbIbHW5tfP4P/U/ES9+TCExee/1Va
         sLhYs4m6cE6gysZ1AKf/Fq01qQ8ES4BIL1N6KImyV4uWeJ9GIYf0GfzsKNiJl35YuVG1
         /w5U7pAc++sUcjIG9OR3RmEgoiMb+kvspo5zRRwzoJh1RtOT9TUZN8BK2hZauI9/uKdf
         ddmqzMv0CusgY32NmwY42QJK0oxb2aKaIcAb3cEfbmWWaWPHfsihMZiB8uW0vArmrBaP
         /Z0g==
X-Gm-Message-State: AOAM5336DbSzPuBtypQ/1GkeDZVmmPi7tM1QaYTBzjQdKC9ULSxGJ+ne
        zMSODA2CcNtskE1QtOGKqVNaPDD2NRcIHalkqwRUv7l9mw==
X-Google-Smtp-Source: ABdhPJxrSkAL0Vh4gA7oUahplGpVu7H2Ze4FQvKnmnwKd3yqYBEM+xIR2LMB6Vejiowmb5CXpNM52Jf7tNK7VJ3ZgzM=
X-Received: by 2002:a5d:4f05:0:b0:210:2e8c:33a6 with SMTP id
 c5-20020a5d4f05000000b002102e8c33a6mr12582726wru.241.1654047152479; Tue, 31
 May 2022 18:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsO0HSqP2n3W_Su07LPggUm5_M1tGJBuJDW_VL-pWHOWw@mail.gmail.com>
 <CAHC9VhTqrPeqSFhBKNXvmyf-upN4L73qKSPxBSSRKa+3Ks3oPg@mail.gmail.com>
In-Reply-To: <CAHC9VhTqrPeqSFhBKNXvmyf-upN4L73qKSPxBSSRKa+3Ks3oPg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 31 May 2022 21:32:21 -0400
Message-ID: <CAHC9VhQ9FG9kFBJrwS2P_cxkGs8frQ0b=Wz+Hu=e6mrnZXi23A@mail.gmail.com>
Subject: Re: Bug in SELinux SCTP ASCONF handling
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 31, 2022 at 7:53 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, May 31, 2022 at 1:05 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > Hello everyone,
> >
> > Investigating the yet still spuriously failing SCTP ASCONF test [1]
>
> FWIW, I haven't seen failures with the SCTP tests when doing my
> testing, but perhaps I've just been lucky with the timing windows.
>
> > has led me to realize that the SCTP_PARAM_* chunk handling is in fact
> > severely flawed. The SCTP_PARAM_* code paths reuse the
> > security_sctp_bind_connect() hook, but that hook uses the current
> > task's sid when checking the socket::connect permission, which is not
> > correct, since there is no guarantee on the task context in which the
> > incoming ASCONF packet will be processed.
> >
> > The relevant selinux-testsuite test [1] expects the subject sid to be
> > the one of the server, which has been true only by accident, as SCTP
> > often processes the incoming ASCONF chunk via softirq right after it
> > is sent.
> >
> > This seems tricky to fix, as we don't have any appropriate subject
> > context at hand at the time of receiving the ASCONF chunk... Any
> > ideas?

From a quick skim of the SCTP RFCs, the ASCONF chunk is sent from a
remote endpoint to update the SCTP parameters so in this case I
believe the subject should be the remote peer (the association/sock's
peer_secid) and the object should be the local association/socket.
It's important to note that any access control checks using the remote
peer label should be gated by the selinux_peerlbl_enabled() function,
see selinux_socket_sock_rcv_skb() for an example.

I haven't looked too closely, but my initial gut feeling would be to
move the sock_has_perm() call out of selinux_socket_connect_helper()
and either modify the sock_has_perm() function to take the subject as
a parameter, or open code it inside selinux_sctp_bind_connect() using
the peer label.  I suspect the additional parameter will be cleaner
due to the common_audit_data requirement of avc_has_perm().

-- 
paul-moore.com
