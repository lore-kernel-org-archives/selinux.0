Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC46C433DF
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 13:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F2120825
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 13:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6vLbNsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHRNGN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgHRNGF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Aug 2020 09:06:05 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB72C061389
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 06:06:04 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id n128so13990118oif.0
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 06:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESzY/xhWatbmW6dbu979w1RKTpwBdWWvMpcpjn8mg/c=;
        b=m6vLbNsUJkuaSmruymxC4RbGguzlHvqBffdbkeMFXKwU/IJ3mawzNIpXJIARwvxoat
         Y5HgKsAr4Rszm5h/y7Uju6hkiVMmW17TVBExvzUkMifi3cq4N0Lux8cMK0+xp3UxN4rS
         pZPyNfvox1U9eAjLkw/YQSHPlU1DtM1WnBXmSzjxUQuOa9rc1K9k8HZDVRdD+mH+pF9l
         9fV2dGB3YGN5IlGNmUzyoy8Uz8bj74oV2f9dE3stoLXXEfChb13LgCozAEe3L5zX8qMt
         cac87iHqTrspfVtvwfkz3Z9QglP+xhEaa6OWqDfFa0nCjoXwFgZyl3SS/+SblPo4tAAM
         0sUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESzY/xhWatbmW6dbu979w1RKTpwBdWWvMpcpjn8mg/c=;
        b=tqlfLjfLDzCNoIcxkuIDmZLaDex3ztPwju/+bHmRFj+valJnAEoVfRjGdZHisIQui3
         V/NMoB425CGSGWOhY3J1yd0jq1aw6/XJ5Fp89Ft7EvV70rWQG6N9Ov0pbhdof3Jx2jNQ
         RH8dkvWV76iS8sQXAGlP+AN4MuK8flGFuf40UYjdpD2oQAhya3F9ALxrC/OmchQmLpjI
         /jCrqJ6DbtFQRpEeCGfRv8sAjBs+VXgU0xesvAacI4Fz11oBK8+DZ6m6Wc4GR7FVAGqt
         tiMZTR5+/9lT+vK4I7VbLmUVTu9s+WY6Gzr/V84d2JMC2xhlEBlF2/4VTwLeEIaad99R
         5gxA==
X-Gm-Message-State: AOAM532Mznmnd5v6TQ/syTyj60Szd2wNCmlu/pm8R2zUjW+ILVnP6oHa
        PAHoXUoT/kkFv3bKYe5FfdSPS+dOW6HAQ7qMMIA=
X-Google-Smtp-Source: ABdhPJxE1xAcOMtG+Lav/O9tsCmIiHco3QOQQ0G4SjteTgwkDrEueVoSq7Td71igHK0VFsmzt02kCKVvls+Hllsa8JY=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr12301823oic.92.1597755964246;
 Tue, 18 Aug 2020 06:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6b0MM-04XwcE58N-BiOBBi2g-1AZovoBmPGgcfU_wZiQ@mail.gmail.com>
 <CAHC9VhQurFFNfjx22RxKp-QG_GJ6VDZy3yEOWwWY++wfn+2C9Q@mail.gmail.com>
 <CAEjxPJ693_3xX=VJTkQejfSatox9YxER9L0y=0H781noSGA-Hw@mail.gmail.com>
 <CAEjxPJ6TEk=iXHkB0=6EytMeJo1R+ZSgS8O0-32NPHpR43PhsQ@mail.gmail.com> <CAEjxPJ5T5Dht0G1XZYVKgL5Zz1gTqcDVzJZaStHnyHQmOy_PbA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5T5Dht0G1XZYVKgL5Zz1gTqcDVzJZaStHnyHQmOy_PbA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 18 Aug 2020 09:05:53 -0400
Message-ID: <CAEjxPJ7d1Si+FcsanaKUvENCrMnHPQOohOdKF6A7VFaigw8bFg@mail.gmail.com>
Subject: Re: potential memory leak in netlbl_mgmt_add_common
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 18, 2020 at 8:59 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 18, 2020 at 8:52 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > If I am decoding this correctly, it looks like the leaking allocation
> > is at net/netlabel/netlabel_mgmt.c:152:
> >    147         if (info->attrs[NLBL_MGMT_A_IPV4ADDR]) {
> >     148                 struct in_addr *addr;
> >     149                 struct in_addr *mask;
> >     150                 struct netlbl_domaddr4_map *map;
> >     151
> >     152                 addrmap = kzalloc(sizeof(*addrmap), GFP_KERNEL);
> >     153                 if (addrmap == NULL) {
> >     154                         ret_val = -ENOMEM;
> >     155                         goto add_doi_put_def;
> >     156                 }
>
> And the full stacktrace fed through decode_stacktrace.sh (which I
> didn't realize existed until just now, was doing it by hand) is:
> netlbl_mgmt_add_common (net/netlabel/netlabel_mgmt.c:153)
> netlbl_mgmt_adddef (net/netlabel/netlabel_mgmt.c:546)
> genl_rcv_msg (net/netlink/genetlink.c:693 net/netlink/genetlink.c:736
> net/netlink/genetlink.c:753)
> netlink_rcv_skb (net/netlink/af_netlink.c:2470)
> genl_rcv (net/netlink/genetlink.c:765)
> netlink_unicast (net/netlink/af_netlink.c:1304 net/netlink/af_netlink.c:1329)
> netlink_sendmsg (net/netlink/af_netlink.c:1918)
> sock_sendmsg (net/socket.c:652 net/socket.c:672)
> ____sys_sendmsg (net/socket.c:2352)
> ___sys_sendmsg (net/socket.c:2408)
> __sys_sendmsg (./include/linux/file.h:31 net/socket.c:2441)
> do_syscall_64 (arch/x86/entry/common.c:359)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:124)

Also, there appear to be other leaks of memory allocated near
net/netlabel/netlabel_mgmt.c:88
net/netlabel/netlabel_mgmt.c:201:
     86         struct netlbl_dom_map *entry = kzalloc(sizeof(*entry),
GFP_KERNEL);
     87
     88         if (!entry)
     89                 return -ENOMEM;
...
    195         } else if (info->attrs[NLBL_MGMT_A_IPV6ADDR]) {
    196                 struct in6_addr *addr;
    197                 struct in6_addr *mask;
    198                 struct netlbl_domaddr6_map *map;
    199
    200                 addrmap = kzalloc(sizeof(*addrmap), GFP_KERNEL);
    201                 if (addrmap == NULL) {
    202                         ret_val = -ENOMEM;
    203                         goto add_doi_put_def;
    204                 }

Probably the same cause for all of them.
