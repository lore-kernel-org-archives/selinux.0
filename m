Return-Path: <SRS0=LEY+=7R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A0BC433DF
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 15:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C969D207DF
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 15:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdMDHXDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgFDPd3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgFDPd3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Jun 2020 11:33:29 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADA9C08C5C0;
        Thu,  4 Jun 2020 08:33:28 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j189so5416401oih.10;
        Thu, 04 Jun 2020 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AtgVM+6A77er24Q+A6g9v9mzs9lX03TOCiFz1KIlUSM=;
        b=SdMDHXDU1rgTx+wjts5cAAVZzI8PH4x+evoQ+9wNhbQ4pAy6QDUIgVwnnxHp41EgDG
         0yQHKyhqYJmyWolFnxaRv5tIkX5dQkUw7EFUpqbi+LbFLQWHuBYITsRBuRxcLFrlJ8UN
         B5s9GdVoBin7ri8qbp0wPPFA2XvGksgADmlAtBP/RokTMKdpjdhBvDetQOjVr+5aG4JO
         yTvLVGE/BFb6MCFCQmtJteGzfTZeSwTHd8p1SSzIy42satSw4L3LsqOK1L//iZ1H5IQu
         iNdFRKGB+ls0tze4wmVWb9swU/RHoIYBa5j1qKMkUkIt/iVDMk+/8z611S0YiTBoDCrm
         Rglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AtgVM+6A77er24Q+A6g9v9mzs9lX03TOCiFz1KIlUSM=;
        b=sGuMr8NeqlI/8ApG914kmSic3oAOr7b9m0JXQPVPho6Ti5XMSJdqvQsRClIkEtHZpu
         qBNAC2oQHu7IbhJKifOWI8bJreFivJWZGdF6204J4aq2cIBLoUZrBmeh+UyhBWsH7AB1
         4CmZZHszBhcm/aVKNCPadeipxF0BONla+uE102ktZ1TXKv7XerCO2W4F7hVz9Tx3xcf6
         KeKfSCzxEyqGkCl6vdhslCwuHeoLQWNFOByFPrDczQeWUogpBPxYq3LriAkqlZU4CXnA
         R3xdCxUWV7dch1rMen+tzazy81FdsCPaPKSLq2DwhtMOyx6HKoOmnDrdiWmcMihLJHF4
         Lalw==
X-Gm-Message-State: AOAM532o2QAE7sZGA8ByaZ+GUhPqzBLgi8qsCeGxlw2UaNhrVuoHt/aG
        7tLNfIhfDT7K0qWRnhGSXrwOP56qMpP0xj8QBRQj6/+j
X-Google-Smtp-Source: ABdhPJxKZVxO2GZgY9pBarFgPeriOj/aGCeUld1RpPNMX4yzJ610oxzVEzXFz4IMUgKf8RxXpijCTZ8hE0LQZALe2CI=
X-Received: by 2002:aca:ec97:: with SMTP id k145mr3279320oih.92.1591284808395;
 Thu, 04 Jun 2020 08:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
 <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com>
 <290017a8-d943-570f-1f90-acecf1c075a1@schaufler-ca.com> <alpine.LRH.2.21.2006040809280.6050@namei.org>
 <761f5d15-3422-1834-7be5-8f3276d10172@schaufler-ca.com> <CAEjxPJ49ownvc=3OnvkaMD-oYm-aUta98kKs4LDTJTnm65RD=Q@mail.gmail.com>
 <86bd50bd-b5b2-e4a1-d62f-e5eaa0764585@schaufler-ca.com>
In-Reply-To: <86bd50bd-b5b2-e4a1-d62f-e5eaa0764585@schaufler-ca.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 4 Jun 2020 11:33:17 -0400
Message-ID: <CAEjxPJ7=yLKU7JrRdTAj1z=0rEMvLKbUqAL=-M=tgA38sjwdfw@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.8
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 4, 2020 at 11:28 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 6/4/2020 5:45 AM, Stephen Smalley wrote:
> > On Wed, Jun 3, 2020 at 6:39 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 6/3/2020 3:12 PM, James Morris wrote:
> >>> On Wed, 3 Jun 2020, Casey Schaufler wrote:
> >>>
> >>>> The use of security modules was expected to be rare.
> >>> This is not correct. Capabilities were ported to LSM and stacked from the
> >>> beginning, and several major distros worked on LSM so they could ship
> >>> their own security modules.
> >> Capabilities has always been a special case.
> >> Until Android adopted SELinux the actual use of LSMs was rare.
> > I don't think that is correct.  Fedora/RHEL were enabling SELinux by
> > default since around 2004/2005 and for a while Fedora was tracking
> > SELinux status as part of their "smolt" hardware profiling project and
> > SELinux enablement was trending above 80% IIRC before they
> > de-commissioned smolt. SuSE/SLES and Ubuntu were enabling AppArmor by
> > default for quite some time too prior to SE Android.
>
> POSIX ACLs have been enabled just as long. Their use is still
> incredibly rare.
>
> >   It is certainly
> > true that Android's adoption of SELinux massively increased the size
> > of the SELinux install base (and was the first to make SELinux usage
> > mandatory, not just default-enabled) but I don't think it is accurate
> > to say that LSM usage was rare prior to that.
>
> That will depend on whether you consider presence to be usage.
> That gets into the whole "transparent security" argument.

The distros were shipping policies for their respective LSMs that
confined some subset of the processes, and userspace was leveraging
those LSMs (both to get/set labels and to get policy decisions for
userspace enforcers) well before Android adopted SELinux.  I think
that counts as usage.  If by usage you mean end users were writing
their own policies, that certainly is a more specialized class of
users but that's even less so in Android, where end users aren't
allowed to modify the policy at all.

> Sorry I brought this up. I don't mean to disrespect the achievement
> of SELinux. My experience of the Orange Book and early Common
> Criteria era, including the Unix to Linux transition, seems to
> have differed somewhat from that others.
