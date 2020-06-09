Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AF4C433DF
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 14:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA0C204EA
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 14:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM5/d/Ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgFIOFZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgFIOFY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jun 2020 10:05:24 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979CDC05BD1E
        for <selinux@vger.kernel.org>; Tue,  9 Jun 2020 07:05:24 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id v26so3165924oof.7
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2020 07:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jNWgURyHHQ44Su0C5YNNlx441JGRbiHR2Mp+4oHuHYM=;
        b=KM5/d/Kui8YA37cNoidoMLyWyBEOybQecS3jOrXbmHow77aMgn5ypeBaRR0Jp+3dst
         /mOUSQnR6VjmCdEkD2Ln89IpQvCawTsavlHpIb14EzdPhsQPDfcNSdpPomzE+w1Y8fsB
         HNzihXdHabhDQNpWzkdlpobOFRKxENTlgdU0KuU84GubU6GJlfpuWIUzDzGOJnnvTLf7
         Ley4fPX3FExJ0aBxa6hs9AWyXDUV52tmsErVKunPC/Zmt1zAPA7t905ws4E81/GTm8zw
         IgRawPoIIYQZ6Wpe3GNdB75OIRXhVMJBp6Z5c/Pnc9MvX/3GXtjdjzEOM9yka1wi9G0/
         g2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jNWgURyHHQ44Su0C5YNNlx441JGRbiHR2Mp+4oHuHYM=;
        b=uYSbgN4liUjr0vZnXuH5xyLrdXcHmYbXKETnbyK5yc+YH+aSrZfi4O6w8DqYsHpe6+
         uSWrP4sscB1aErje1xzkj7CHkeIE7oYJSiLdDrU63FTwGrCco9/xLYpaKNi0AMz5Olsj
         igfPVaG/qePdydQFCjFTCWU+JifPKZqmEMhPz9VYk4bYWgHt27xVTIEJGNq8Ac5D7wEM
         rzQJI7ptg7v4wycuj20wJcU4ARtQFUOHdgse9eXRFqZvjc+NlIOc1QnvOjBmu+Y1mpdX
         nxfKUHEgakePtUROqYraOn8Kcu3osvXeKPEy9l2mGKB8mwn1olPkAuXLaztgihd/PejG
         fpyg==
X-Gm-Message-State: AOAM530VBGSZUoSoyQAc1CqbT0N3Ref3DXvcagfnCG37NCAbc07f5qxs
        GE8l4WPak5s44sR+iTEJi/MQIIP5YdvYFTIxC/Y=
X-Google-Smtp-Source: ABdhPJwmao+NQy8VnuYNCHh042CsfWPzTRbJtOxoHjtOhJBp8Uz80W0D1RZtuhmR0kXQuO5ME9gKVdF+HCCLfddaruM=
X-Received: by 2002:a4a:e74a:: with SMTP id n10mr21022583oov.71.1591711523691;
 Tue, 09 Jun 2020 07:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <06f4b748-470d-8774-ffbb-5e342f6fcba8@gmail.com>
 <CAHC9VhSjPqsb9ZCWKchhN2ParSR6XH+57jzc7fQ0FjxK28tZOA@mail.gmail.com> <1741fd62-ec03-9d70-d2b6-e1416cf8ae05@gmail.com>
In-Reply-To: <1741fd62-ec03-9d70-d2b6-e1416cf8ae05@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 9 Jun 2020 10:05:11 -0400
Message-ID: <CAEjxPJ72S4nXS=D_4O1WaaoSR7Dc08TRofWpi75cZU-NXtYv1A@mail.gmail.com>
Subject: Re: Better management of dynamic networks?
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 9, 2020 at 4:39 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> On 9.6.2020 0.16, Paul Moore wrote:
> > I can't say I'm an expert on all the various userspace device
> > managers, network or otherwise, but so long as they can execute an
> > arbitrary command then one should be able to use them to label the
> > device when it is added to the system.  Although perhaps we could make
> > this easier with docs and/or tools.
>
> Perhaps this could be solved at least partially by adding a layer of
> indirection. So instead of directly assigning TE rules to interfaces,
> nodes and peers, the rules could apply to type attributes (or something
> else). Then the interfaces, nodes and peers would be tagged somehow with
> suitable attributes. Preferably tagging should be a faster operation
> than rebuilding the policy, but the operation should still be controlled
> by policy.
>
> So, instead of assigning for example localnet_node_t directly to subnets
> (which may have different levels of trust depending on the location)
> with commands (which rebuild the policy) like:
>
> semanage node -a -t localnet_node_t -p ipv4 -M /8 10.0.0.0
>
> there would be a static TE rule which states that networks with type
> (attribute?) 'trusted_localnet' get the label localnet_node_t. Then
> something else (what, how?) would assign the address ranges with the
> attributes when the network configuration (like interface up/down
> status, SSID, routing tables...) changes.
>
> Likewise, instead of direct assignment like
> semanage interface -a -t external_if_t -r s0 wlan0
>
> there would be static TE rules which state that only interfaces with
> type attributes 'company_approved_model', 'not_random_usb_device',
> 'company_authenticated_vpn' can get the label external_if_t. Then when
> new interfaces appear, something else (udevd? how?) would tag the
> interfaces with the attributes.
>
> Would this solve anything?

The kernel doesn't label objects with attributes; it labels them with types.
Attributes are only used within rules (and originally they didn't even
exist in the kernel policy; they were entirely expanded by the policy
compilation process, first as a preprocessor stage and later directly
in checkpolicy/libsepol).
