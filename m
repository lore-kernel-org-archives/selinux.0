Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5CBC433DF
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 22:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6952070A
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 22:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="QwUfjQoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgG1WBE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbgG1WBD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jul 2020 18:01:03 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B61C061794
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 15:01:03 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qc22so7409593ejb.4
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FUJ5vAjxfH9RGyExuu4teEDEPb6j1IZqtO872mqHvXc=;
        b=QwUfjQoeJDcfixBwW9wiSbSYmrBEMGdMCwE7WuEJ0BQy6/M6zgT5HUL6eRdYBGMEPo
         Rql8sVcCoO71JvgD73immWBZEKq7JTj8Jxkd7bdbpZJrKvD0sgHuSNanDqxnXOyaOAly
         5CYmvMRM/RQ44xBRdkN8ne6btIBA+3VG/vdn8q1UlLRWmhoM8JBnL3tHPG38Ys1YHpA1
         /+a+ujoK2RHQBptvEfufRw/Fsgo7xaGA4MGnJUP29ybgyQmwOnU+8k7UtCnMEKuEENL8
         3h4qyI19dS3ziDYWgMgOOqfWXE67tu2sERSl8cU6Ffy1JLKXIMuQySqcgyE4bAuYxiK+
         RMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUJ5vAjxfH9RGyExuu4teEDEPb6j1IZqtO872mqHvXc=;
        b=Vvqowa+rPmCLGtPtMpWaZ97dQjbZNFsOKkZ88OPkEixHs1T0V9q/G/TmtTFu6467vZ
         5nzSg+QFUBgPqI5kckButriPrN+CdIuV2rz7nLDu6kPypurqBFlVpv/BH2iCPTK7Iv6Q
         fxOlna4F/Xis9rdNTzfzkulW267Q4d+2zanVUtAUhOZpE+vi8XbFWH1UpEJSoJKS7Xfn
         DCNJs4nl/PWkR37UtMm823R3UyjACZFYO2CSCD2GKlJ3dk0jlgolm01PfTGcRzDqw/w8
         3mfMJ8kRx/efJIvVGyOeSzeyTHC8JrH9K9o94nZJkDOqQ1A7UyeYMzYEOAnywq0KJcns
         enyA==
X-Gm-Message-State: AOAM5316O8sts0vm9xpNeRkL6mH8N0fgkNKWdlv6p9x4v/EVuf0hkbWf
        5rwkLAkXSeuDwgWEX6UXhXZZzlGrYssaHDRP2n9/+ufz4Q==
X-Google-Smtp-Source: ABdhPJwpefFwsB4dwyotatonpFFLsl2L0OFctwpYbzy26muifSNLoNfFFLtYzO8qmqN2nOfZv1X6RRVywQuQI6TxOXQ=
X-Received: by 2002:a17:906:c1d8:: with SMTP id bw24mr26758804ejb.91.1595973662017;
 Tue, 28 Jul 2020 15:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200727130428.8234-1-toiwoton@gmail.com> <CAHC9VhR=Sa-P=jbpLJ7L91hJgbTgD5Pgq-PxQigetGrPDfChRA@mail.gmail.com>
 <62d3c8f0-38a4-a71b-5f09-36e5287d3d08@gmail.com>
In-Reply-To: <62d3c8f0-38a4-a71b-5f09-36e5287d3d08@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Jul 2020 18:00:50 -0400
Message-ID: <CAHC9VhSmF9oUoR2LT=T8Gs5Wz8m7DRWD=_h7fubBa2W19xJS5A@mail.gmail.com>
Subject: Re: [PATCH v2] Improve network_support.md
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 28, 2020 at 6:30 AM Topi Miettinen <toiwoton@gmail.com> wrote:
> On 28.7.2020 5.44, Paul Moore wrote:
> > On Mon, Jul 27, 2020 at 9:04 AM Topi Miettinen <toiwoton@gmail.com> wrote:
> >>
> >> List all access control methods available for networking and provide
> >> examples for each.
> >>
> >> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> >>
> >> ---
> >> v2: address comments from Richard Haines
> >> ---
> >>   src/network_statements.md |   2 +-
> >>   src/network_support.md    | 170 +++++++++++++++++++++++++++++++++-----
> >>   2 files changed, 150 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/src/network_statements.md b/src/network_statements.md
> >> index ef1c873..357c3b1 100644
> >> --- a/src/network_statements.md
> >> +++ b/src/network_statements.md
> >> @@ -102,7 +102,7 @@ the interface to a security context.
> >>   <tr>
> >>   <td><code>packet_context</code></td>
> >>   <td><p>The security context allocated packets. Note that these are defined but unused.</p>
> >> -<p>The iptables(8)/nftables(8) <a href="network_support.md#secmark">SECMARK services</a> should be used to label packets.</p></td>
> >> +<p>The iptables(8)/nftables(8) <a href="network_support.md#internal-labeling-secmark">SECMARK services</a> should be used to label packets.</p></td>
> >>   </tr>
> >>   </tbody>
> >>   </table>
> >> diff --git a/src/network_support.md b/src/network_support.md
> >> index 309e863..6f9896b 100644
> >> --- a/src/network_support.md
> >> +++ b/src/network_support.md
> >> @@ -1,20 +1,17 @@
> >>   # SELinux Networking Support
> >>
> >> -SELinux supports the following types of network labeling:
> >> +SELinux supports several methods for access control of networks. These are
> >>
> >> -**Internal labeling** - This is where network objects are labeled and
> >> -managed internally within a single machine (i.e. their labels are not
> >> -transmitted as part of the session with remote systems). There are two
> >> -types supported: SECMARK and NetLabel. There was a service known as
> >> -'compat_net' controls, however that was removed in kernel 2.6.30.
> >> +* Packet labeling: class `packet`
> >> +* Peer labeling: class `peer`
> >> +* Interface control: class `netif`
> >> +* Network node control: class `node`
> >> +* TCP/UDP/SCTP/DCCP ports: class `port`
> >
> > For whatever it is worth, I've always thought of the SELinux network
> > access controls as being composed of two parts: socket layer controls
> > and packet layer controls (or per-packet controls).  The packet layer
> > controls are further divided into the "peer" and "secmark" controls.
>
> This could be a more easily understandable way to describe the access
> controls, at least `port` would fall to socket layer controls nicely.

Yes, I personally think it is better way to explain the network access controls.

> Would this division work with netifs and nodes?

I'm not entirely clear on the question, but both the netif/node
ingress and egress controls fall into the packet layer.


> >> -To support peer labeling, CIPSO and CALIPSO the NetLabel tools need to
> >> -be installed:
> >> +SELinux supports the following types of network labeling:
> >> +
> >> +**Internal labeling** - This is where network objects are labeled and
> >> +managed internally within a single machine (i.e. their labels are not
> >> +transmitted as part of the session with remote systems). There are two
> >> +types supported: SECMARK and NetLabel. There was a service known as
> >> +'compat_net' controls, however that was removed in kernel 2.6.30.
> >
> > Using your terminology, NetLabel is external or "labeled networking".
>
> It's not my terminology, the text is just moved down.

My apologies, using the *existing* terminology ...

> I think
> fallback/static labeling part of NetLabel is not external, the labeling
> happens internally and the labels are not transmitted.

I guess this is another problem with the "internal" vs "external"
approach to the current text.  I prefer to think in terms of how the
access controls are structured, and as far as SELinux is concerned it
only has to worry about calling the general NetLabel APIs; it doesn't
matter if CIPSO, CALIPSO, or the static/fallback labeling is
concerned, it's all the same.

Things get more complicated if you start digging into individual
protocols.  Look at the different CIPSO tag types, vs the tagless
approach taken in CALIPSO.  Not to mention the way labeled IPsec
works; people get enamored by the encryption/authentication aspects,
but it's really a very poor fit for SELinux.  There are a number of
problems caused by the fact that labeled IPsec is an implicit labeling
mechanism that labels SAs and not packets, there are issues around
ensuring all of the labels have the same (or close enough) meaning on
both systems, and it is likely only to ever work between the SELinux
systems.

-- 
paul moore
www.paul-moore.com
