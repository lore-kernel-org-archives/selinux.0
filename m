Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A601C38147
	for <selinux@archiver.kernel.org>; Wed, 18 Jan 2023 19:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjARTTT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Jan 2023 14:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjARTTI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Jan 2023 14:19:08 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1364053B3E
        for <selinux@vger.kernel.org>; Wed, 18 Jan 2023 11:19:02 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 127so9742255pfe.4
        for <selinux@vger.kernel.org>; Wed, 18 Jan 2023 11:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qv2KYqSSFZ+ANyK5ssSSVDV3Rhttf1BtBfGakcH582s=;
        b=QSyEntPCn5MCdn3Pfa3YWFT6lOT8BIIgzIeGBVuRH3Me4/ClZKxvacrJhXCjZ9k5jQ
         6Q5P40G4b2fKFncjRFWE7HoPGl4EQpzbNtO7zE/GBlCMS7c0YPihrsY4EjvnL3qlO6Zg
         ri9i+364/88xcmd0p6OdrUsO8AkizSiPc6QNsD6NM76DhlNvObKxnmAw7GQHhaTYIWLA
         mVdUGxMSXL2Um7Jy1v8I29kYC8Fl2tF8wLZnlHV2JgOmuZzZBahGUi3Qk563LL+bde5M
         HZfCvHvinZFH5IwT3KMYsCy3lAo+XhPXxb4RFSeQsghZi88Xlm1kXhVK5/OYl0/YWH8/
         oRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qv2KYqSSFZ+ANyK5ssSSVDV3Rhttf1BtBfGakcH582s=;
        b=hCMeLM8xwa2GmDdKxvV9yLNQdC7nBzCXEnqJjFXgw/LrE+GyXncuQUDyeJSDxD4UoH
         idGU5bR5QRNcROgifZ1M07ZvJkM//JKjVTnD95AQUPIZSnqvLvFHJvWhc+iUpmJnLcbO
         i2jxjmQJ5xrEPvOzHMpUQpJ+d0S9hEO3WgU153I1A47yG/JyeOFpC9VE7ffm3UiXp39I
         qTX/YKeZ2W+98V1EHWWRFWBLaZbSDsJPbhNqrD2cDsM9sj1yPQZmQF0K6wnTHdxViZ53
         rWYZOxp+RMthGCu4i4MUAEYc+PI7OYjIIlVfK6AOw8RsqkgI31osIOeqrEnOj/gkBb6Z
         4tDw==
X-Gm-Message-State: AFqh2kpE3+yqU69xxmN5dGvqh9qmE89So4+qvrSU5OHsvPaMiMTAr9Ab
        KpVsp0W21GPn/y16I0ir7cfkqO9oPRyqP9BOM6yU
X-Google-Smtp-Source: AMrXdXs/Hm+1DNAFh9mYNRbzdhESmUWR3RD84Ypn9yd5f6cYBonBHwWuXIqbCRo/E9LAzkcUU6oWAflrO2dp7LDGXkk=
X-Received: by 2002:a62:e814:0:b0:588:e66e:4f05 with SMTP id
 c20-20020a62e814000000b00588e66e4f05mr719841pfi.23.1674069541107; Wed, 18 Jan
 2023 11:19:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673666803.git.lucien.xin@gmail.com> <d19e0bd55ea5477d94567c00735b78d8da6a38cb.1673666803.git.lucien.xin@gmail.com>
 <CAHC9VhRXd+RkHSRLUt=0HFm42xPKGsSdSkxA6EHwipDukZH_mA@mail.gmail.com>
 <CADvbK_e_V_scDpHiGw+Qqmarw8huYYES2j8Z36KYkgT2opED3w@mail.gmail.com>
 <CAHC9VhQeaOeX-5SENhpScKN9kF1rAKoZX23KOUqQ5=uz6v92iA@mail.gmail.com>
 <CADvbK_cR5paEunENmWd62XfXtMSf+MHhhc-S1z_gLWp_dUx=8w@mail.gmail.com>
 <CAHC9VhSk8pYtOJHCZ1uNvv1SJiazWkJVd1BCfyiLCXPMPKe_Pg@mail.gmail.com>
 <CADvbK_ds4ixHgPGA4iKb1kkFc=SF8SXPM-ZL-kb-ZA0B-70Xqg@mail.gmail.com>
 <CAHC9VhR4_ae=QzrUUM=1MZTWJ9MQom0fEAME3b+z+uBrA8PpcQ@mail.gmail.com>
 <CAHC9VhSRgQuyPgio7d9ZNbs53oCvpq3KQJ9gG5rKX67Wn+P6kw@mail.gmail.com> <54d89f4a-c7ca-2226-64dd-adc81ebbc314@gmail.com>
In-Reply-To: <54d89f4a-c7ca-2226-64dd-adc81ebbc314@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Jan 2023 14:18:50 -0500
Message-ID: <CAHC9VhQb66rKaz+1DNqhiu6Oo5QbXHZHgFp0stGJYbN9K85CFA@mail.gmail.com>
Subject: Re: [PATCH net-next 06/10] cipso_ipv4: use iph_set_totlen in skbuff_setattr
To:     David Ahern <dsahern@gmail.com>
Cc:     Xin Long <lucien.xin@gmail.com>,
        network dev <netdev@vger.kernel.org>, davem@davemloft.net,
        kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Pravin B Shelar <pshelar@ovn.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Ilya Maximets <i.maximets@ovn.org>,
        Aaron Conole <aconole@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Mahesh Bandewar <maheshb@google.com>,
        Guillaume Nault <gnault@redhat.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 17, 2023 at 9:47 PM David Ahern <dsahern@gmail.com> wrote:
> On 1/17/23 3:46 PM, Paul Moore wrote:
> >>
> >> In the BIG TCP case, when is the IPv4 header zero'd out?  Currently
> >> cipso_v4_skbuff_setattr() is called in the NF_INET_LOCAL_OUT and
> >> NF_INET_FORWARD chains, is there an easy way to distinguish between a
> >> traditional segmentation offload mechanism, e.g. GSO, and BIG TCP?  If
> >> BIG TCP allows for arbitrarily large packets we can just grow the
> >> skb->len value as needed and leave the total length field in the IPv4
> >> header untouched/zero, but we would need to be able to distinguish
> >> between a segmentation offload and BIG TCP.
> >
> > Keeping the above questions as they still apply, rather I could still
> > use some help understanding what a BIG TCP packet would look like
> > during LOCAL_OUT and FORWARD.
>
> skb->len > 64kb. you don't typically look at the IP / IPv6 header and
> its total length field and I thought the first patch in the series added
> a handler for doing that.

Thanks, I was just curious if there was some other mechanism but that works.

As of this moment, the patchset I'm working on is still independent of
the BIG TCP patches, and I want to make sure I'm not doing anything
that will make the BIG TCP patches any more challenging.

> >>>> In the GRO case, is it safe to grow the packet such that skb->len is
> >>>> greater than 64k?  I presume that the device/driver is going to split
> >>>> the packet anyway and populate the IPv4 total length fields in the
> >>>> header anyway, right?  If we can't grow the packet beyond 64k, is
> >>>> there some way to signal to the driver/device at runtime that the
> >>>> largest packet we can process is 64k minus 40 bytes (for the IPv4
> >>>> options)?
> >>>
> >>> at runtime, not as far as I know.
> >>> It's a field of the network device that can be modified by:
> >>> # ip link set dev eth0 gro_max_size $MAX_SIZE gso_max_size $MAX_SIZE
> >>
> >> I need to look at the OVS case above, but one possibility would be to
> >> have the kernel adjust the GSO size down by 40 bytes when
> >> CONFIG_NETLABEL is enabled, but that isn't a great option, and not
> >> something I consider a first (or second) choice.
> >
> > Looking more at the GSO related code, this isn't likely to work.
>
> icsk_ext_hdr_len is adjusted by cipso for its options. Does that not
> cover what is needed?

Adjusting the icsk_ext_hdr_len only applies to CIPSO labels that are
attached via the associated local sock, traffic that is labeled by
cipso_v4_skbuff_setattr() in the LOCAL_OUT or FORWARD netfilter hooks
does not have the icsk_ext_hdr_len adjustment.

Although as I mentioned earlier, I am adding a patch which would pad
out the IPv4 option header in the LOCAL_OUT labeling scenario so
icsk_ext_hdr_len will be adjusted for all locally generated
TCP/connected/is_icsk traffic.  Forwarded traffic still remains an
issue; but I think the only thing we can do is drop it and send an
icmp message back to the sender with an adjusted MTU value.

--
paul-moore.com
