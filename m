Return-Path: <SRS0=4SPy=7P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B765FC433DF
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 18:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B962068D
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 18:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo44aHNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgFBSKK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgFBSKI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Jun 2020 14:10:08 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E234AC05BD1E
        for <selinux@vger.kernel.org>; Tue,  2 Jun 2020 11:10:07 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j189so5366856oih.10
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2020 11:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbMwCemqSr2oI/uoIJV/RPnxnAbO5z6UGqJOfZLrbFw=;
        b=Jo44aHNuUd/rX0HLilvhXHHKY/cs2Z+H8L/oYdQY+0Uwf22xOIkSWfpmH/kIHwo+Ib
         j9GogZHc9V+yXiUflssPSN3VnV2QwgMvqShKSm1ZbHHdOMdPfS7Yve6gSlsBOPHT15VR
         loueoqBZOBudyzPgfRht6as94kfmLIa/RX8cVbuqV5DLTdweGD0Yohot6lJMNLCf/avb
         D3qg6Hq2ME9nX0fydWFwSXM+9EMgh1c19eUwGLdxGWr5XL7byG13mXVTtm/1sy4Mw+Y7
         gYPS2o2T1Kg3RMp2hL1nf+7zwlqStj+ibzUToqYuj1B6+XpjAZ+zK/XEMS0s9dIxr0lq
         1Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbMwCemqSr2oI/uoIJV/RPnxnAbO5z6UGqJOfZLrbFw=;
        b=fNBL4INco9PVSCdhmGctt8UUjd6P9AxT42UcRDCh5DzU/BRBlSdJmJe5LmYvL5OLr3
         mU+OTqrVrVjr8rgOapfUvhNUpiq51pTrkuAKAMPxdZYUwJdmnOdiG2cQUzk2qFVrlOXb
         BHv8ww2B6VWy792de2JAsNQHyuCu2phCdN2AERgPDWmORMPpqPThDDWytP4xBJU2hzVI
         E3BcBsu/RvTLGd6sEe7EzITshSLNrnpd+iBjEEliYaW6WS9le3V0LaCVrJukYBlbWj2x
         KVn0s5hZKhzPgRtFMQcNnXTY+TIp2JrAbjLlvP1jNfTvotrixtx2ifjD/cwiOsgnU3lP
         e9Cw==
X-Gm-Message-State: AOAM53251LK4tzRmm9lCpOIQPVf8tzWY4PEHzjyGTIe3smwG5vwqhNHr
        G55gAHCDte67xsu331LJztPwqLSxrjurxIZRwbU=
X-Google-Smtp-Source: ABdhPJwOQHKu8OzNlurg0QQdoBKZJmVFZBDe2EUlc/2rBzqg2K7wf7hJH/n66FNLn+jcvY+DkyUrTL10MqjXaLYqe4M=
X-Received: by 2002:aca:c704:: with SMTP id x4mr3696971oif.92.1591121407306;
 Tue, 02 Jun 2020 11:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200528184056.105774-1-jwcart2@gmail.com> <CAEjxPJ5a3BDuN2VpyMt-TWMZvPVVx+JHym3EwnMdHC4xkEXTfQ@mail.gmail.com>
 <CAP+JOzTGUJYQTSFBD2rO2_YcveKyv7RPV8gaz-2Haqke1unDoQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTGUJYQTSFBD2rO2_YcveKyv7RPV8gaz-2Haqke1unDoQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 2 Jun 2020 14:09:56 -0400
Message-ID: <CAEjxPJ6kMz4oGXRHA-CTyfKooCvKYLQGmJrSUasWFAoB_s=p5A@mail.gmail.com>
Subject: Re: [PATCH] libselpol: Sort portcon rules consistently
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Steve Lawrence <slawrence@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 29, 2020 at 11:35 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, May 29, 2020 at 10:57 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, May 28, 2020 at 2:41 PM James Carter <jwcart2@gmail.com> wrote:
> > >
> > > The comparison function, portcon_data_cmp(), only made use of the
> > > protocol to put tcp before udp, dccp, and sctp. Rules that have
> > > the same port range, but with different protocols would be considered
> > > equal unless one of the protocols was tcp. When generating a CIL or
> > > conf source policy from a binary or using the "-S" option in
> > > checkpolicy the non-tcp portcon rules with the same port range would
> > > not be consistently sorted.
> > >
> > > Changed portcon_data_cmp() to sort portcon rules like the CIL function
> > > cil_post_portcon_compare().
> > >
> > > Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > Signed-off-by: James Carter <jwcart2@gmail.com>
> >
> > Any idea why it used that logic previously?  And how does this compare
> > with sepol_port_compare/compare2() used by libsemanage?
>
> It originally followed the logic in CIL. I updated the CIL logic in
> 2018 (see commit 4ba19b541 ("libsepol/cil: Improve processing of
> context rules"), but failed to update the logic in kernel_to_common.
>
> The logic is similar, but slightly different. The logic in CIL and in
> kernel_to_common puts smaller port ranges before larger ones, but
> sepol_port_compare/compare2() do not take into account the port range.
> Other than that they are the same (with this patch). I am not sure
> where the CIL ordering logic came from, Steve Lawrence might remember.
>
> Jim
>
> > Regardless,
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
