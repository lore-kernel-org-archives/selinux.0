Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7360C433E0
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 22:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBE020656
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 22:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="d6IFiVYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFKWTn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgFKWTn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 18:19:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA926C03E96F
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 15:19:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id mb16so8099022ejb.4
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 15:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XfvncZ5Sjp/GDYFSt8CG7QAbH8CvaStPhtss10VQgtE=;
        b=d6IFiVYrOQdPzGALPFMN5D4Op5Thagusri4MXb40bP9zZyP/Oq9w2/PRFVqmPhYBAl
         kYLeBH2P0QnkqTySWgGnpBpFY9+w2eVGArQANWL64haDZJG46haDLfmkMLekb+sc9IJT
         RN5Tg3VArBT8k9EYhcgobzITTWBX3y4CXdTCUgICqc9450Czyyzg9WzG69h38+ds+otX
         5X0FnNHSXBaqYDg5fR4ykeG+ELjrjUnAJXg9qzg4z/D6tLRQ74jR7ImdbKuChOYL/V8N
         mn3sVH/cnbiRFKuhNGx3sz8J1XAxZQTfljarMQuPa45rVRRCJyGJd5qK0U8VCWp8qu8j
         Diag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XfvncZ5Sjp/GDYFSt8CG7QAbH8CvaStPhtss10VQgtE=;
        b=kknHkAJi5NLDlZxbp+GjgHfSnkXBha3TpU9AChFA5B6O5XC+6LjPSCmNvCD5044sit
         o3cqWYX534t1itgPO6xdWUGfF4JT+bmxNsR77EHb0tw9TXQOXu24zkS0lnfrDowC+ddG
         UpOxai8O4yrPBr16QFl498Y132EzYz0K4hVQjrHBd5VnQ6ZGBbZfAw9wU2oee6rlfbVK
         rkfhH4hRCf9AeuTmDmB20h1mLc+EalDQzUAYY8ZVCG5EzYf0G3BsSeCHd5DUkCJnqK8F
         C8pXLdHsnd2kaHEOsR2Ssujq3zy8CtMscvvfALC4PYquZjHCankvCwwWH/SZyVVMqYTV
         Ee5w==
X-Gm-Message-State: AOAM530F99rfGABQgD9fxYed2FActDYliUuSlTlGcDLR1Ereo8q0cTip
        r4P231bgXAkX5sgVtJGOTFcRp6wi3uAK7d38QnR1
X-Google-Smtp-Source: ABdhPJyxaHPXFeRFVm2537AbFzIyyd/kzxH0lDXGjKe9cjApjxyLeIIi4FhV5ayuU4pi8CGYf6T4O8ncyid0cs0w3DE=
X-Received: by 2002:a17:906:8684:: with SMTP id g4mr9768160ejx.431.1591913980904;
 Thu, 11 Jun 2020 15:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <06f4b748-470d-8774-ffbb-5e342f6fcba8@gmail.com>
 <CAHC9VhSjPqsb9ZCWKchhN2ParSR6XH+57jzc7fQ0FjxK28tZOA@mail.gmail.com>
 <1741fd62-ec03-9d70-d2b6-e1416cf8ae05@gmail.com> <CAEjxPJ72S4nXS=D_4O1WaaoSR7Dc08TRofWpi75cZU-NXtYv1A@mail.gmail.com>
In-Reply-To: <CAEjxPJ72S4nXS=D_4O1WaaoSR7Dc08TRofWpi75cZU-NXtYv1A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 11 Jun 2020 18:19:29 -0400
Message-ID: <CAHC9VhR5f+yanLSX1R2B7R5Qb37Fr91WrUpCQbESjzq2DyyaJA@mail.gmail.com>
Subject: Re: Better management of dynamic networks?
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 9, 2020 at 10:05 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Jun 9, 2020 at 4:39 AM Topi Miettinen <toiwoton@gmail.com> wrote:
> > On 9.6.2020 0.16, Paul Moore wrote:
> > > I can't say I'm an expert on all the various userspace device
> > > managers, network or otherwise, but so long as they can execute an
> > > arbitrary command then one should be able to use them to label the
> > > device when it is added to the system.  Although perhaps we could make
> > > this easier with docs and/or tools.
> >
> > Perhaps this could be solved at least partially by adding a layer of
> > indirection. So instead of directly assigning TE rules to interfaces,
> > nodes and peers, the rules could apply to type attributes (or something
> > else). Then the interfaces, nodes and peers would be tagged somehow with
> > suitable attributes. Preferably tagging should be a faster operation
> > than rebuilding the policy, but the operation should still be controlled
> > by policy.
> >
> > So, instead of assigning for example localnet_node_t directly to subnets
> > (which may have different levels of trust depending on the location)
> > with commands (which rebuild the policy) like:
> >
> > semanage node -a -t localnet_node_t -p ipv4 -M /8 10.0.0.0
> >
> > there would be a static TE rule which states that networks with type
> > (attribute?) 'trusted_localnet' get the label localnet_node_t. Then
> > something else (what, how?) would assign the address ranges with the
> > attributes when the network configuration (like interface up/down
> > status, SSID, routing tables...) changes.
> >
> > Likewise, instead of direct assignment like
> > semanage interface -a -t external_if_t -r s0 wlan0
> >
> > there would be static TE rules which state that only interfaces with
> > type attributes 'company_approved_model', 'not_random_usb_device',
> > 'company_authenticated_vpn' can get the label external_if_t. Then when
> > new interfaces appear, something else (udevd? how?) would tag the
> > interfaces with the attributes.
> >
> > Would this solve anything?

I'm still not entirely sure this really solves the problem, it just
changes it slightly.  You would now need to worry about making sure
you have the right types defined in the policy, and I'm not sure we
can generalize the world's network configurations into a reasonable
set of types.  Not to mention the problem of mapping the
subnets/interfaces to those types.

> The kernel doesn't label objects with attributes; it labels them with types.
> Attributes are only used within rules (and originally they didn't even
> exist in the kernel policy; they were entirely expanded by the policy
> compilation process, first as a preprocessor stage and later directly
> in checkpolicy/libsepol).

-- 
paul moore
www.paul-moore.com
