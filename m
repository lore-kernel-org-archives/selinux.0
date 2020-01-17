Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE980C33CB1
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 15:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885D92064C
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 15:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WnawCU3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAQPTE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:19:04 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45581 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgAQPTD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 10:19:03 -0500
Received: by mail-oi1-f193.google.com with SMTP id n16so22463907oie.12
        for <selinux@vger.kernel.org>; Fri, 17 Jan 2020 07:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=d/IgzLjyi17RR9V+mKKuuxAC2PufGDYSdzjMCRQJA34=;
        b=WnawCU3U8dN4MdebxUvChehjMkgSR7AoFdnCHDYnlSNneUj/z7SfA/UdpmvA+8R7MZ
         Bau7MUb5VZcZR/KZ5haKqs7qchaOY4VaG+cmPnDp07VaSwqW6QiggcmbRM3cj5xVx7G7
         O17RjYZCtBdGsfGi9gE3Q0CScg5rEGDPypb8dz1PM/3vaeE+9vSCCHa6plOMSX/tvDTU
         uMr0ult+Hjre+HMmdxqu01fo1D/Be4BOLPigVBYaAYppr2X05S7nrSc7iOFaI8Pg5G/8
         BDXNCTJKrgaOW9GR1TUW122tduqQEXrdx0ehgIL7xSPQ7o/CG7/tM1N2wJWisFRyXFa+
         wkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=d/IgzLjyi17RR9V+mKKuuxAC2PufGDYSdzjMCRQJA34=;
        b=t+Y4hWWyzPIOtGvTLE1jynVTJZubHLaH2YmhOSHEKpA4MQgko+fSUQ0d7L7UEeiSBO
         5mBFxyRzeYg0FE2ecjSpRoNMtzMEY3YYOZCc9y1IFnXErwLd9xDwBxBkiXTx8mnsKVJB
         +RJb1kgH2S5RU+qc0IdpwOpgzbd6pNaOEVsN4+dOPjmMkpTENx4KOwqUK7IsDQl+rH38
         wCp5w+Lv/c8MN8DZS+VX9Ni6cnE8Gk2mIJV0C2ZK9LEcHhVia6btS+xzmC5z1nOoHJt1
         j/sVMb8yCQABPeeEBsaiLs6c+jHJpfE6OTAcZWLiTpYG1SiE23Dxd/yEgqCzkHtv1XQ1
         q6wQ==
X-Gm-Message-State: APjAAAWLIWRQmTXOf68dAW4s3X1Z0gQ1zvQoPs/KEgxxC+hbxMkd6yDE
        MouRBS0NcAPUmk4WvU3UWsT5
X-Google-Smtp-Source: APXvYqySp++L8fOxuXS0gY/6h3BsGAqf3to3Xyrdl4UmsnWE7eyvljPxj2VjDlz5zoQm9eH6WOyMDA==
X-Received: by 2002:aca:2207:: with SMTP id b7mr3843224oic.109.1579274342682;
        Fri, 17 Jan 2020 07:19:02 -0800 (PST)
Received: from [192.168.160.102] ([12.226.92.2])
        by smtp.gmail.com with ESMTPSA id g19sm8969126otj.1.2020.01.17.07.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Jan 2020 07:19:01 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     Jeffrey Vander Stoep <jeffv@google.com>
CC:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Date:   Fri, 17 Jan 2020 10:19:00 -0500
Message-ID: <16fb415d3d8.27e8.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CABXk95B77UXxhiG3=xRmJmG5c7knoF2pbdpweskreftggZzkUQ@mail.gmail.com>
References: <20200116142653.61738-1-jeffv@google.com>
 <CAHC9VhRSUhozBycHMZcMaJsibJDxNMsTsKVT2zOnW=5H4R4mdg@mail.gmail.com>
 <CABXk95B77UXxhiG3=xRmJmG5c7knoF2pbdpweskreftggZzkUQ@mail.gmail.com>
User-Agent: AquaMail/1.22.0-1511 (build: 102200004)
Subject: Re: [PATCH] selinux: map RTM_GETLINK to a privileged permission
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On January 17, 2020 3:21:10 AM Jeffrey Vander Stoep <jeffv@google.com> wrot=
e:
> On Fri, Jan 17, 2020 at 1:32 AM Paul Moore <paul@paul-moore.com> wrote:
>> Our current handling of netlink messages is rather crude, especially
>> when you consider the significance of the netlink messages and the
>> rather coarse granularity when compared to other SELinux object
>> classes.  I believe some (most? all?) of this is due to the number of
>> netlink messages compared to the maximum number of permissions in an
>> object class.  Back when xperms were added, one of the motivations for
>> making it a general solution was to potentially use them for netlink;
>> we obviously haven't made the change in the netlink controls, but I
>> think this might be the right time to do it.
> That's a very large change with some unanswered questions - like how to
> handle
> generic netlink. I will have time later this year to make that change.
>
> In the meantime, this change is small (ideal for backporting) and
> consistent with
> how we differentiate between levels of sensitivity on netlink_audit
> messages.
> Would you consider taking v3 of this change with your suggested adjustmen=
t
> to
> selinux_policycaps_init()?

Yes, it is a big change and there are some open questions, but both of the =
changes we are discussing here are exposed to userspace so there is a need =
to make sure we get this as right as possible the first time.  I am not a f=
an of exposing a change to userspace knowing that we will be replacing it i=
n the future.

If we need to update the netlink controls, and I think we do, let's do it p=
roperly and not one message at a time.

--
paul moore
www.paul-moore.com




