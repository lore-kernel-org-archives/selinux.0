Return-Path: <SRS0=8zWZ=P2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C2FC43387
	for <selinux@archiver.kernel.org>; Fri, 18 Jan 2019 14:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028C62087E
	for <selinux@archiver.kernel.org>; Fri, 18 Jan 2019 14:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="XjoS2t+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfAROxu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:53:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42124 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfAROxt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Jan 2019 09:53:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so11840321lja.9
        for <selinux@vger.kernel.org>; Fri, 18 Jan 2019 06:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpZe3pdqYJrV9gZcM+ikCK2IVNmbxJ98lnifRbr6ttk=;
        b=XjoS2t+L4DdceYTn1d69FrZSWXJ0CIxMGjii/g1rpufiiDqqCLl+oRfI+vlytKqQLD
         Itx/PQqPtZXZPsJrErZxMf1YjcleyX9ytK/rv3SyvymGdmiCsuBLHMYr4BdCiJqIUoUO
         HpaZjqF/tdAomdrI7zGNW4t5pPnX++LO0uLFGuICPJ259hqfc1p92RB9CrpyaYCJpfX3
         b6ZPnmF6g1mojzertkR+AeAMZOr47xuV+WxTmOoBBW7wW3okavzOBaQ5S+UCAxG9W+Ih
         k6ABI9RuvSR7IwSipRRhn2rm8IjXKL+E3H0gY0NcjaJLDRfiap6t3RMTI1PIYEYZf+it
         3obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpZe3pdqYJrV9gZcM+ikCK2IVNmbxJ98lnifRbr6ttk=;
        b=i2hcZKpccm3BLxp8eQfvfEz2lcIWlmR7PqSIjc2dG6pIGdslQKL9NwaifeclCms/0Y
         MOg33rCyG1xfGNI9OrN781SlerYg5Sgv1ceAN3wvrqICPCtoH/Y+l7D/f2xrajjHdQt5
         83hIM08HRHz7QjzMMH2yK5hqOXJ2iRmVqTZAwU79OD+eD/yurdY74/wEAP0b2QsEjXEf
         PnUy9yth4nCJehM57iDvUvhgfFt8fAwX0FWmwxZtMVGatUkOzjyaXenBdzLIeGdy2UXJ
         n9jkF2fhbhWXoLSQd2CsSiBCDcptwfecB+pgvz1h2qyrPiznV0AfQkofGEO2+s2zGp+3
         3OKA==
X-Gm-Message-State: AJcUukcgy2UFckn06bgMhhhz0/+QrVP5WktINYo8yVYAN5kwtckjOkAQ
        M9kIiy0aL8XSLdIYOLsd70lKdCHHEbEFBPHkCzp1
X-Google-Smtp-Source: ALg8bN4s1QS6DIhypX4qF7IGy/bFO8+mR9tmChTfbeX8KqP1TZ030DTykIvuNp6D1fgAPRwxCOjL9EfdLy9XpPINN6g=
X-Received: by 2002:a2e:834a:: with SMTP id l10-v6mr11985852ljh.42.1547823222623;
 Fri, 18 Jan 2019 06:53:42 -0800 (PST)
MIME-Version: 1.0
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
 <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
In-Reply-To: <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Jan 2019 09:53:31 -0500
Message-ID: <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
To:     Nazarov Sergey <s-nazarov@yandex.ru>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        netdev@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 15, 2019 at 2:52 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jan 15, 2019 at 12:55 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 1/15/2019 9:06 AM, Nazarov Sergey wrote:
> > > Hello!
> > > Security modules (selinux, smack) use icmp_send for discarded incorrectly labeled network packets.
> > > This could be on TCP level too (security_sock_rcv_skb -> cipso_v4_error for INET stream connection, for example).
> > > icmp_send calls ip_option_echo, which uses IPCB to take compiled IP options.
> > > After moving IP header data to the end of the struct tcp_skb_cb (since 3.18 kernel), this could lead to
> > > kernel memory corruption when IP options copying.
> >
> > Can you explain how that corruption might occur?
> > Do you have a test case?
>
> Thanks for pointing this out Nazarov.
>
> Presumably we are going to hit a problem whenever icmp_send is called
> from outside the IP layer in the stack.  We fixed a similar problem a
> few years back with 04f81f0154e4 ("cipso: don't use IPCB() to locate
> the CIPSO IP option").
>
> I've CC'd netdev, as I'm guessing they will have some thoughts on
> this, but my initial reaction is that your proposed patch isn't as
> generic as it should be for code that lives in icmp_send().  I suspect
> the safe thing to do would be to call ip_options_compile() again on
> skb_in and build a local copy of the ip_options struct that could then
> be used in the call to __ip_options_echo(); the code could either live
> in icmp_send() or some new ip_options_echo() variant
> (ip_options_echo_safe()?  I dunno).  Unfortunately, calling
> ip_options_compile() is going to add some overhead, and may be a
> non-starter for the netdev folks, but this is error path code, so it
> might be acceptable.  Hopefully the netdev folks will have some
> better, more clever suggestions.

It's been a few days now with no comments from the netdev folks, so I
think it's probably best to start putting together a RFC patch for
review/comment.  Nazarov, would you like to do that?  If not, that's
okay, just let me know.

I'm still concerned about calling ip_options_compile() in icmp_send()
and I'm thinking we might be better off to add a new ip_options
parameter to icmp_send(); if the parameter is NULL we behave as we do
today, but if it is non-NULL we use the given ip_options parameter in
place of calling ip_options_echo().  With that change in place, we
would need to update cipso_v4_error() to do the extra work of calling
ip_options_compile() and __ip_options_echo().  There looks to be maybe
a dozen (or two?) existing icmp_send() callers, but it should be
pretty trivial to update them to pass NULL for the new parameter.

What do you think?

> > > This patch fix a bug, but I'm not sure, that this is a best solution. Perhaps someone more familiar with the
> > > linux TCP/IP stack will offer a better one.
> > > Thanks.
> > >
> > > --- a/net/ipv4/icmp.c
> > > +++ b/net/ipv4/icmp.c
> > > @@ -679,7 +679,8 @@ void icmp_send(struct sk_buff *skb_in, i
> > >                                         iph->tos;
> > >       mark = IP4_REPLY_MARK(net, skb_in->mark);
> > >
> > > -     if (ip_options_echo(&icmp_param->replyopts.opt.opt, skb_in))
> > > +     if (__ip_options_echo(&icmp_param->replyopts.opt.opt, skb_in,
> > > +                     ip_hdr(skb_in)->protocol == IPPROTO_TCP ? &TCP_SKB_CB(skb_in)->header.h4.opt : &IPCB(skb_in)->opt))
> > >               goto out_unlock;
> > >
> > >

-- 
paul moore
www.paul-moore.com
