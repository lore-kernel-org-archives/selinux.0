Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EC2C43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 02:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33C1222C2
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 02:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="UTc/Bgw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfLSCUY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:20:24 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37412 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfLSCUY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 21:20:24 -0500
Received: by mail-lj1-f193.google.com with SMTP id u17so4406216lja.4
        for <selinux@vger.kernel.org>; Wed, 18 Dec 2019 18:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4MZuRDe1qNtyJglhw8ziER4PihOIF2oLpjUaybe0ME=;
        b=UTc/Bgw0DYdAU6zTuz9BoNuzLudLFwrrMAlnHWON4W/ATxpVAeAbzcIZ3AGfSOh8+a
         i9JxIGULKX3/AER8TZJWP/OGN9Un/aCfYO0CAn0XcXVtwqqEstONFeRwKdwoVKPrxB5p
         yab1ExlmLWjgnyWe7nnTRDL7tJ6DKxnI+0qye0UWFTUdXVIVderUpo18dvpxHGJiZU2D
         cy0gDzJ5OGOrKhAf0sb0sH++QV0XlL3sc/ZYOdnQUCrPyOmJa4/iswnY5iFEHKRzbWpq
         m4QJrqCCF7LYPyHaD1ivMepZ92bI12xPFIETJdvSqJmBgNdyJ1t1xOeRjP3gQXo5RtPp
         m9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4MZuRDe1qNtyJglhw8ziER4PihOIF2oLpjUaybe0ME=;
        b=nVfBK+tcSYY80Oe1SAhaZzOkij4zE66JZzbdHeNyM1L0OcXE+Wq7YnXFCgsgnl7xB8
         LUnxI28kG50j7ZU9gkf3PwUB00PN9Bft4H20sktp23WOkXipam2pIpOJg+rCai09Or0b
         mQkPxKwvDKK2eEiMlA2DOM9ZV8rM7pT6dG7kaXqZnn3My3TI2LhJuCCZqrdFworFvJlG
         QHjnSQkFUEhC5pu5eEcxWAcKxrSGZ/6dCerNtfQbyVC+8NM2AygAPWdwQPNWEGjPU4IS
         k3AKITXzxztoxu6TCW1e9uK1rSb6F/Hd8wWYwZN6nPUOh4bzhfed7Qol/VXrsBkYGFGS
         tRTw==
X-Gm-Message-State: APjAAAWk1wPYysQC52shIhkxbueGqJTmukinyme2QfSfJhf75u/CjhA0
        GxO05M+wbeGg3HZ1FsZy6XAVVUBXwII21npDioIk
X-Google-Smtp-Source: APXvYqz+PnlZnt71AqHNciSSq0K5R9A2IQ5BCu//LHgAlHbl9iBbzqAwBVIlr/mjAWeIQxhT/LqDQ9n99WesdVtdYOk=
X-Received: by 2002:a2e:7e11:: with SMTP id z17mr4135699ljc.117.1576722021919;
 Wed, 18 Dec 2019 18:20:21 -0800 (PST)
MIME-Version: 1.0
References: <0101016eeb5fdf43-18f58c0b-8670-43eb-ad08-60dae381f0fd-000000@us-west-2.amazonses.com>
 <4335f89f-d2cb-7f45-d370-6ee0699d3c20@tycho.nsa.gov> <0101016eebed2b2e-db98eae1-b92b-450b-934e-c8e92c5370b3-000000@us-west-2.amazonses.com>
 <7b047966-33c0-de62-b10f-047819890337@tycho.nsa.gov> <d6081414-613f-fdb8-8dcd-9ebf6a3baa27@tycho.nsa.gov>
 <0101016ef59a2152-41e65aac-8784-4401-b20d-45b2852872d4-000000@us-west-2.amazonses.com>
 <411fa1ea-d9b4-b89e-8cab-656db8eef259@tycho.nsa.gov> <001e01d5b4f0$495efbd0$dc1cf370$@codeaurora.org>
 <21b5511a-fdba-3c2f-e9a6-efdc890b5881@tycho.nsa.gov>
In-Reply-To: <21b5511a-fdba-3c2f-e9a6-efdc890b5881@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Dec 2019 21:20:10 -0500
Message-ID: <CAHC9VhQYA8uTRQ0OajEmsTrDytNVx+BSiL5vEsGefKEhAw+gKA@mail.gmail.com>
Subject: Re: Looks like issue in handling active_nodes count in 4.19 kernel .
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 17, 2019 at 10:51 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 12/17/19 10:40 AM, Ravi Kumar Siddojigari wrote:
> > Yes  indeed this is a stress test on ARM64 device with multicore  where most of the cores /tasks are stuck  in avc_reclaim_node .
> > We still see this issue even after picking the earlier patch " selinux: ensure we cleanup the internal AVC counters on error in avc_insert() commit: d8db60cb23e4"
> > Where selinux_state  during issue was as below where all the slots are  NULL and the count was more than threshold.
> > Which seem to be calling avc_reclaim_node always and as the all the slots are empty its going for full for- loop with locks and unlock and taking too long .
> > Not sure what could make the  slots null , for sure its not due to flush() /Reset(). We think that still we need to call  avc_kill_node  in update_node function .
> > Adding the patch below can you please review or correct the following patch .
> >
> >
> >    selinux_state = (
> >      disabled = FALSE,
> >      enforcing = TRUE,
> >      checkreqprot = FALSE,
> >      initialized = TRUE,
> >      policycap = (TRUE, TRUE, TRUE, FALSE, FALSE, TRUE),
> >      avc = 0xFFFFFF9BEFF1E890 -> (
> >        avc_cache_threshold = 512,  /* <<<<<not configured and its with default*/
> >        avc_cache = (
> >          slots = ((first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first   /*<<<< all are NULL */
> >          slots_lock = ((rlock = (raw_lock = (val = (counter = 0), locked = 0, pending = 0, locked_pending = 0, tail = 0), magic = 3735899821, owner_cpu = 4294967295, owner = 0xFFFFFFFFFFFFFFFF, dep_map = (key = 0xFFFFFF9BEFF298A8, cla
> >          lru_hint = (counter = 616831529),
> >          active_nodes = (counter = 547),   /*<<<<< increased more than 512*/
> >          latest_notif = 1)),
> >      ss = 0xFFFFFF9BEFF2E578)
> >
> >
> > --
> > In AVC update we don't call avc_node_kill() when avc_xperms_populate()
> > fails, resulting in the avc->avc_cache.active_nodes counter having a
> > false value.In last patch this changes was missed , so correcting it.
> >
> > Change-Id: Ic0298162cc766c0f21be7ab232e259766654dad3
> > Signed-off-by: Jaihind Yadav<jaihindyadav@codeaurora.org>
> > ---
> >   security/selinux/avc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index 91d24c2..3d1cff2 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -913,7 +913,7 @@ static int avc_update_node(struct selinux_avc *avc,
> >          if (orig->ae.xp_node) {
> >                  rc = avc_xperms_populate(node, orig->ae.xp_node);
> >                  if (rc) {
> > -                       kmem_cache_free(avc_node_cachep, node);
> > +                       avc_node_kill(avc, node);
> >                          goto out_unlock;
> >                  }
> >          }
> > --
>
> That looks correct to me; I guess that one got missed by the prior fix.
> Still not sure how your AVC got into that state though...
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

This looks good to me too.  Ravi, can you submit this as a proper
patch with From: set to Jaihing Yadav (assuming they are the author)
and your sign-off?

Thanks.

-- 
paul moore
www.paul-moore.com
