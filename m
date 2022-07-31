Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230B0C00140
	for <selinux@archiver.kernel.org>; Sun, 31 Jul 2022 16:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbiGaQpt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 31 Jul 2022 12:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGaQps (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 31 Jul 2022 12:45:48 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E55E011
        for <selinux@vger.kernel.org>; Sun, 31 Jul 2022 09:45:47 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so11053878fac.13
        for <selinux@vger.kernel.org>; Sun, 31 Jul 2022 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yWKcNi8pv3NLgu4jfdLQABVQjKSZmdG3vAFHE5A8CNM=;
        b=ZTe5W0rX0B1cgIhAUbAT7TwIERbD6LV6qXfOZXt2KNTn6vaAVldgf9dIuBlDMan/YN
         hIaUDVthMDe1C6chEXS+K2Su1xsMRPp5K/mqQwjoW8ctWMeF9z6Af3kobvEF/idVRgWq
         fbLVpTt7dFPrEfjRA9TJ7hxLxm60hTTj1dSKgWwWpmoYaCWasj3LMQHZeU7QxPXltQ4D
         G79KNi5lTB85Km4RdKnCnp5NqOnQH4RVp1JIY7RVg5UTDJPnq4RSdjlKDQqhFo7zlN6E
         m5Ln32HxH4GKoHDR+UZgHadjS4knhdSKJEP6WM9Xzdiw1gYCnma3U+xOcAS6jm49OrH9
         s/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yWKcNi8pv3NLgu4jfdLQABVQjKSZmdG3vAFHE5A8CNM=;
        b=vzU1mX49EqlKM1TU67Jx5Z5tJyqOv1CieWEQlUTaXnKnB8SfN3dUXzC2sHAT9+VRyS
         2rdvdcIECWHjT1ckWCM72Ki/RHeqXCaFW69jp9zce+1rIi6A0r/IDzGpBhIfmasAUXi/
         PW4jZA/Ed54/zQ4Z2CtEi7mBcd7Nn+H1C/LWryDKM2WwzxNtURwBOlT4/QBOhPZvAU5K
         poWHW16x4doD6PtbmE6PHJLrcEbX2t9NPX5ZZzA4JTKqcH9DjWuDE8smA/47aYEi9NBT
         94O2mwiITnUNAcL21qpnghFp1inxvsB/Rt12k3bXgVIYe4Tj7bQP/GKG4uzBWYaTwSqR
         YmfA==
X-Gm-Message-State: AJIora/neDYTcNMo3knD0+bL/wyQt2F9gA8ZuuB/ZJfACD1WvRUnEqb5
        CaH62+VaIQILVhO1LOC3hk3v7DfgyDDIvD0dzeUsnYBiyayQ
X-Google-Smtp-Source: AGRyM1uOPKoL5PiY0r4L1PTOUSg0Y0zQBTWKvQZEyxl8plnLhPHDPaf3wzdqHnL62FwY8TzwAD9IYYbO91phBlnx5UM=
X-Received: by 2002:a05:6870:b40d:b0:10b:8586:9d91 with SMTP id
 x13-20020a056870b40d00b0010b85869d91mr6004248oap.136.1659285945479; Sun, 31
 Jul 2022 09:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+EEuAgfGhTWBWXgtHSVU22feM+0PS=h-z-eVF4JxmSf2qyZzg@mail.gmail.com>
In-Reply-To: <CA+EEuAgfGhTWBWXgtHSVU22feM+0PS=h-z-eVF4JxmSf2qyZzg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 31 Jul 2022 12:45:34 -0400
Message-ID: <CAHC9VhS6A9yaywmRBVg9+AijAqZXxeB=e=HiZ3sUe_Zf+uahuw@mail.gmail.com>
Subject: Re: KVM / virtual networking access control
To:     Karl MacMillan <karl@bigbadwolfsecurity.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 29, 2022 at 11:36 PM Karl MacMillan
<karl@bigbadwolfsecurity.com> wrote:
>
> Hi,
>
> I'm trying to do some access control over the networking between KVM
> virtual machines using Secmark and things are not working as I expect.
> The key is that this is _between_ virtual machines, not just ingress /
> egress to the virtual machines from external address.
>
> Quick summary: I'm connecting two VMs together using veth pairs and a
> virtual bridge and I only ever see:
>
>     allow unlabeled_t bare_packet_a_t:packet { forward_in forward_out };

Just to make sure I'm understanding this correctly, we are talking
about the SELinux controls from the perspective of the
host/hypervisor, yes?

Assuming that is the case, the "packet/{ forward_in forward_out }"
permissions look correct to me.  In the case of the secmark forwarding
rules you basically have this:

  allow <peer> <secmark>:packet { forward_in };
  allow <peer> <secmark>:packet { forward_out };

... and I'm guessing you haven't setup any peer labeling between the
two guests so you are seeing unlabeled_t for "<peer>".

> What I want is packet { send recv } because that would be against the
> label of the KVM process rather than the peer label (which on the same
> system would always be unlabeled - I see no way to use CIPSO/CALIPSO
> to get peer labels to work here).

The "packet/{ send recv }" controls are for packets that originate and
terminate on the node applying the policy; think of your typical
client/server nodes.  The "packet/{ forward_in forward_out }" controls
are for packets that are passing through the node applying the policy,
e.g. intermediate nodes such as bridges and switches ... even software
bridges like that found in hypervisors ;)

> I would appreciate any insight into what might be going on. This is
> mainly tested on a RHEL 8.6 box, but some testing has been done on a
> Fedora 36 box as well.

I don't know all the details of your setup, or the security goals you
are trying to enforce, but since it looks like you are bridging the
network traffic between the guests, you might want to try setting up
the NetLabel static/fallback mechanism to assign a peer label to
traffic on those interfaces (no more unlabeled_t in the secmark
forwarding rules).  Adding the peer labeling information will also
trigger the network peer label controls in the kernel so you will see
additional "netif/{ ingress egress}" and "node/{ recvfrom sendto }"
checks.

Here are few slides that might be helpful (they are older, but still relevant):

https://www.paul-moore.com/docs/selinux_network_controls-pmoore-122012-r1.pdf
https://www.paul-moore.com/docs/labeled_networking-lfjapan-07092008.pdf

-- 
paul-moore.com
