Return-Path: <SRS0=XfoM=WT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5464DC3A5A2
	for <selinux@archiver.kernel.org>; Fri, 23 Aug 2019 11:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2357721848
	for <selinux@archiver.kernel.org>; Fri, 23 Aug 2019 11:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IUnWnbLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393011AbfHWLlw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Aug 2019 07:41:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39883 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732963AbfHWLlw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Aug 2019 07:41:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id x4so8564089ljj.6
        for <selinux@vger.kernel.org>; Fri, 23 Aug 2019 04:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wc0pBV8XYSwempgeR3yggrLrzcmJJBDB5ERRq19QP4w=;
        b=IUnWnbLScb1sugwDDrGxqMlHj/JXkMfX4z4uuO9U6yHS5KHJK9DFMSGSFJLfbBFnka
         bgNqVz0VssAEuGgxdSTJQQsrCEXiCtJ9hM+u75ufGAYUzEBUKZDwvP1RNg/OmBeAwRwc
         +sonJewfnrQp3IWhIjAEnjn/mVUrYhP+QON2sSin9pO5PIy3xLvN+nmNL0XfQedWsDfk
         VWbYca0GncQtpQh8WdIvH6NeEKjVAzPSf+EPh98YVuBGofsp6CT+PsRceJDw+HklzBE0
         kNtdPOBlzSYblHeP4Wm+pBoABI3lYqvOttY6AAHjjHAJo4O9iUhQo9WqnnFUsz4XtNOa
         T9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wc0pBV8XYSwempgeR3yggrLrzcmJJBDB5ERRq19QP4w=;
        b=gmt6uEPKYBQ3TGakh1H0GZ8RGbq1xLVPEhKSpsKyyczzJgeFt+TszemuMqPIHTCiBj
         9FVY8WvwdI07RusgkG+i91pl0dFlNXppNPiJ+OMQI5yPpb0WY2jBBLDur81/Vm5QdTrV
         3Q9MugiTGwpOHY/7CZEwWNlAq38dqDN25U+jpz3BdsGKzG7jBGA4rxRobuljvstkKpzh
         dLtpTq8qJmYsf3DxAJJGS4O6heEd4S6bnFnf7tNmlMQQ197MSofyvy4wX5T84DtBiodt
         hVdA2ejoRoPVGnraBuXAPN4sGnK9S++8KXkSUXmDZzvNo2fdKUj6gVFg/UGP9I1GkQm9
         4A/Q==
X-Gm-Message-State: APjAAAXQYxPH+40n51JFd0NEPK4kvejLTel0MgXHptgpYIDnlHL/JGlY
        BTFuPhiYHn8Yn05yHnOg2HwoMPobQq4l52o1Hnp5YazTsyw=
X-Google-Smtp-Source: APXvYqwEuB/cMhl/nAEC7z/qHRnNiNTz/9Il2JH8941tpayvBx6eYlh6aTC2ePXDkr4MAsscUOZ/3mxjMhMkFFMl2ek=
X-Received: by 2002:a2e:2b0a:: with SMTP id q10mr2628388lje.203.1566560510230;
 Fri, 23 Aug 2019 04:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190821134547.96929-1-jeffv@google.com> <20190822.161913.326746900077543343.davem@davemloft.net>
In-Reply-To: <20190822.161913.326746900077543343.davem@davemloft.net>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Fri, 23 Aug 2019 13:41:38 +0200
Message-ID: <CABXk95BF=RfqFSHU_---DRHDoKyFON5kS_vYJbc4ns2OS=_t0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] rtnetlink: gate MAC address with an LSM hook
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 23, 2019 at 1:19 AM David Miller <davem@davemloft.net> wrote:
>
> From: Jeff Vander Stoep <jeffv@google.com>
> Date: Wed, 21 Aug 2019 15:45:47 +0200
>
> > MAC addresses are often considered sensitive because they are
> > usually unique and can be used to identify/track a device or
> > user [1].
> >
> > The MAC address is accessible via the RTM_NEWLINK message type of a
> > netlink route socket[2]. Ideally we could grant/deny access to the
> > MAC address on a case-by-case basis without blocking the entire
> > RTM_NEWLINK message type which contains a lot of other useful
> > information. This can be achieved using a new LSM hook on the netlink
> > message receive path. Using this new hook, individual LSMs can select
> > which processes are allowed access to the real MAC, otherwise a
> > default value of zeros is returned. Offloading access control
> > decisions like this to an LSM is convenient because it preserves the
> > status quo for most Linux users while giving the various LSMs
> > flexibility to make finer grained decisions on access to sensitive
> > data based on policy.
> >
> > [1] https://adamdrake.com/mac-addresses-udids-and-privacy.html
> > [2] Other access vectors like ioctl(SIOCGIFHWADDR) are already covered
> > by existing LSM hooks.
> >
> > Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
>
> I'm sure the MAC address will escape into userspace via other means,
> dumping pieces of networking config in other contexts, etc.  I mean,
> if I can get a link dump, I can dump the neighbor table as well.

These are already gated by existing LSM hooks and capability checks.
They are not allowed on mandatory access control systems unless explicitly
granted.

>
> I kinda think this is all very silly whack-a-mole kind of stuff, to
> be quite honest.

We evaluated mechanisms for the MAC to reach unprivileged apps.
A number of researchers have published on this as well such as:
https://www.usenix.org/conference/usenixsecurity19/presentation/reardon

Three "leaks" were identified, two have already been fixed.
-ioctl(SIOCGIFHWADDR). Fixed using finer grained LSM checks
on socket ioctls (similar to this change).
-IPv6 IP addresses. Fixed by no longer including the MAC as part
of the IP address.
-RTM_NEWLINK netlink route messages. The last mole to be whacked.

>
> And like others have said, tomorrow you'll be like "oh crap, we should
> block X too" and we'll get another hook, another config knob, another
> rulset update, etc.

This seems like an issue inherent with permissions/capabilities. I don=E2=
=80=99t
think we should abandon the concept of permissions because someone
can forget to add a check.  Likewise, if someone adds new code to the
kernel and omits a capable(CAP_NET_*) check, I would expect it to be
fixed like any other bug without the idea of capability checks being tossed
out.

We need to do something because this information is being abused. Any
recommendations? This seemed like the simplest approach, but I can
definitely appreciate that it has downsides.

I could make this really generic by adding a single hook to the end of
sock_msgrecv() which would allow an LSM to modify the message to omit
the MAC address and any other information that we deem as sensitive in the
future. Basically what Casey was suggesting. Thoughts on that approach?

Thanks for your help on this.
