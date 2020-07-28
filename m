Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B22C433E5
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 02:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24CF20825
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 02:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="YM9hSFT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgG1C5R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgG1C5P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jul 2020 22:57:15 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7307FC061794
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 19:57:15 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g7so10841050ejw.12
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 19:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I9qCj6R6wXWFc2o+n8IzoDIhgRelfe2s0JOjj3gICEc=;
        b=YM9hSFT5rMXPOsFppHZW5QXOn9Mw6CCRqZkZl7eYVBNP7rvhsUbt6QWJvjXpyhPPTn
         XaK24fAFRPvwQnQcUIMbUn8D6YxYnhppMZssuFOySe2VvGswnIrU8Isw97ZaSKmuVbUk
         mFFf0wOCqdvikiJHVVTY7RwR6/nr7UCVoQOAsl2RZAUe2LK3T2tisiJvNgBMH8kD6c7S
         m9gaA1q1KhG+kewdwYm57e4mqcNVF4FlPL6g2D/9ESRaX7Vord1RJOWcxiXsm3M5Lojw
         EfTj9uSJazwI1rdMm4b22zU3ttUDMbdfesCkPoB0x5IkCzsJ4FTW3LZnPSwpzbYM1XIK
         ZKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9qCj6R6wXWFc2o+n8IzoDIhgRelfe2s0JOjj3gICEc=;
        b=kNfPJ0WvB/OJubDFspSkGxaR6liLRWgccmJm6Xox9MqqDsm05s2MMqxvoP0tzkrzrU
         7yXJVQGl++VqdQn9C+2IYEqjrS+AW+sa7vODOI12KqaxjEdyvPauTuCmoS19eT74YIBh
         fcSzR/Qa8Q8PARlOMa3hppSOMCyte80EGhrqjQ8RGyyJ1H4bc8G/przwN1s0r8EibVT5
         lLT6AoWZT/8nmZ7zSekrD6NcMCWTzd40KX/n7gOoZPst1BX+rFELI4cO3tL/tM7BhGrt
         KhkTV93/eqw0ThbnjrQ6J0uuY20SJ9m/qFuqCvzg+6RBIPaozkvW2OPAU/9j22p09TJ1
         4PIg==
X-Gm-Message-State: AOAM5339lgVOvWGfnkAA6nxWq477ZdSqai2MlCpPrkSOdlp277xgljND
        aORtxtG1CqBOpmSYGwJ+pW/ncWn74uo9q+PDG3QoJu0=
X-Google-Smtp-Source: ABdhPJwmAdWL9tyVeUnroaI5d31G17HrYMncxYCr69xrodwFRl5keVMaEDIrIdE+DpqwFaiaAHaWFz73ft066WPHzAY=
X-Received: by 2002:a17:906:1911:: with SMTP id a17mr14721841eje.431.1595905034052;
 Mon, 27 Jul 2020 19:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200727130428.8234-1-toiwoton@gmail.com> <ypjlwo2pm56q.fsf@defensec.nl>
 <100b1c8c-a756-c6e5-5514-a8a9dc6fc117@gmail.com> <ypjlsgddm0gv.fsf@defensec.nl>
In-Reply-To: <ypjlsgddm0gv.fsf@defensec.nl>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Jul 2020 22:57:03 -0400
Message-ID: <CAHC9VhQsDU2DZ5eew1eEo2Wt20D7BskD0p4ZyEs0hFYZAE8pXQ@mail.gmail.com>
Subject: Re: [PATCH v2] Improve network_support.md
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Topi Miettinen <toiwoton@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 27, 2020 at 11:39 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
> Topi Miettinen <toiwoton@gmail.com> writes:
> > I'm no expert, but the only netif ingress rules which I have are
> > rather generic:
> >
> > allow internet_peer_t external_if_t:netif ingress;
> > allow link_local_peer_t external_if_t:netif ingress;
> > allow localnet_peer_t external_if_t:netif ingress;
> > allow multicast_peer_t external_if_t:netif ingress;
> > allow loopback_peer_t loopback_if_t:netif ingress;
> >
> > `peer` types above have been added with NetLabel rules like:
> >
> > netlabelctl unlbl add default address:2000::/3
> > label:system_u:object_r:internet_peer_t:s0
> >
> > Perhaps this would be better:
> >
> > Note that reception for application domains can't be controlled with
> > `netif` class.
> >
>
> I look at it this way: peers *are* processes, You seem to
> essentually use peers as nodes above.

Peer labels are essentially process labels (that isn't 100% correct,
but it is close enough for this particular discussion).

In the netif/ingress access control, the subject is the peer label of
the *remote* peer, not the receiving process on the local system.  If
you were running a web server on your system under httpd_t and a
remote node connected to your web server with firefox running under
firefox_t, you would need the following netif/ingress rule:

  allow firefox_t external_if_t:netif ingress;

You will note that it is firefox_t and *not* httpd_t as the subject.

> It would become more clear if you would try this out with labeled ipsec.
> A peer, in my experience is kind of the same as an association in the
> labeled ipsec scenario (the classes actually overlap). That is also why
> you should probably disable the netlabel_peer_controls polcap if you use
> labeled ipsec.

-- 
paul moore
www.paul-moore.com
