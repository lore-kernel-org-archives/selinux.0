Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4675FC04A68
	for <selinux@archiver.kernel.org>; Sat, 30 Jul 2022 03:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiG3DgU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 23:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239943AbiG3DgS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 23:36:18 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A6C3134E
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 20:36:17 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id m7so4949411qkk.6
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 20:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bigbadwolfsecurity-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=xfdj+hKd8XAAiryHfVNdJvL9rYQ3W2Ef3MvdPqfXcdE=;
        b=Zp6ObGIi9mR1HF6yYU/vfwbCFFwUoqK5OVa2FOcPipErdKd9oF8Xfk6+0SX8wtTOed
         mcGtftz4KJKtiKMgQ4gChRUSrYnuU7J4n91SqLE5QGOmkK7LBBiFRqayN/AOmCCzEjKu
         Y0xJBEq9EDpn/elGQiXEbAw4Ps8iEiehbOL/zFcL4mI8v4nWVvWiN0ZFH6zVD80wvujk
         WDjFQpZJwtaVI2sFnycLQIYiWp9I/V0aLG7jyQNYLxCPlKViEuNy4KnEwIcAE9EVwg8B
         r1df0TDAgpKmVPHYfCP2IHG2amPbYc+sTlmQ3pRdfnwS9DGBhsY8UNeOZduDf+QgxOG8
         RtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xfdj+hKd8XAAiryHfVNdJvL9rYQ3W2Ef3MvdPqfXcdE=;
        b=qVTKSVQWegxfMhkN0J9keEyR3+kDE3Ee3TsaHCFQfbT1sonmoZc2k9/aoaBhst7i1I
         Lb8xqEmw0n0PgR97PYe/K1zO6xBrjS0qxzDOpHKWxqg5WMadXdgjOuNweKZx13mYKUMj
         5zqeM9dz0pTCc/UTlBFBx4WSmPHVmFvO/VAGZAyaoRaGetIoSSR6oQjzh5TYYZvsHs4d
         mZ5ZoQzuBldMjqnE5yBI4ydIXTjpsPGkts35LnTttkucm5WUGXUb+8//fA+ArQkqJ95f
         +goCt+ce/qpzOiHGzuYv/DgciTXesHx9BQXaBOO57ZnZXEMiJ+C+pHSQdPP/oJIYBHyj
         WgoA==
X-Gm-Message-State: AJIora81fZJ5jDb5pVjNiCXqT7wFzFUJs0sbuybiBTC4HeXqqGMPUp6b
        PSrhfELcNzY9IXDWzzK4eJE5flGmGzJ6aQ+LQ3oZa7wPEHIHaQ==
X-Google-Smtp-Source: AGRyM1ujhRY4zSiCcTEFkCHa159nZ2wkfrfeYZkfdfLd3pXTgCVY7ojnpuu1btv54YW5bHO8YqD27JI4byf3DK80Dvo=
X-Received: by 2002:a05:620a:143c:b0:6b8:8d43:5581 with SMTP id
 k28-20020a05620a143c00b006b88d435581mr51278qkj.179.1659152176390; Fri, 29 Jul
 2022 20:36:16 -0700 (PDT)
MIME-Version: 1.0
From:   Karl MacMillan <karl@bigbadwolfsecurity.com>
Date:   Fri, 29 Jul 2022 23:36:05 -0400
Message-ID: <CA+EEuAgfGhTWBWXgtHSVU22feM+0PS=h-z-eVF4JxmSf2qyZzg@mail.gmail.com>
Subject: KVM / virtual networking access control
To:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

I'm trying to do some access control over the networking between KVM
virtual machines using Secmark and things are not working as I expect.
The key is that this is _between_ virtual machines, not just ingress /
egress to the virtual machines from external address.

Quick summary: I'm connecting two VMs together using veth pairs and a
virtual bridge and I only ever see:

    allow unlabeled_t bare_packet_a_t:packet { forward_in forward_out };

What I want is packet { send recv } because that would be against the
label of the KVM process rather than the peer label (which on the same
system would always be unlabeled - I see no way to use CIPSO/CALIPSO
to get peer labels to work here).

I can see that the packet send / recv LSM hook is in netfilter
postrouting code, but I simply cannot trigger this with the setup that
I have. Here are things that I have tried:

1. br_netfilter - I thought initially that my problem was that the
traffic was at layer 2 and was not traversing the netfilter hooks.
This was, in fact, a problem with my initial setup (both VMs on the
same subnet) and br_netfilter got traffic to hit netfilter hooks. But
no matter what hook I chose, the best I could get was forward_in /
forward_out.

2. various traffic selectors - I've used mac address, ip address, and
physical interface (all of the different interfaces) to set the
secmark labels.

3. ebtables - secmark support seems totally broken in ebtables, both
what is in RHEL 8.6 and upstream. It's in the options parsing.

4. nftables - to work around ebtables I used nftables bridge family to
label layer 2 traffic. None of the hooks would yield anything other
than forward_in / forward_out.

5. routing - I placed the VMs on separate subnets and added multiple
addresses to the bridge. My thought was that forcing the traffic to
route would push it up to layer 3 and would make it hit the
postrouting hook (this may be a completely broken mental model of
things).

You can see how I'm doing this with some very rough / poorly
documented scripts at
https://github.com/BigBadWolfSecurity/kvm-access-control. VMs are
created / managed through libvirt / virt-manager.

I would appreciate any insight into what might be going on. This is
mainly tested on a RHEL 8.6 box, but some testing has been done on a
Fedora 36 box as well.

Thanks - Karl
