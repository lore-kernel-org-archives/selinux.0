Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05584C35DEA
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 01:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BB8218AC
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 01:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Jaw3+hQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgBYBwF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Feb 2020 20:52:05 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41803 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBYBwF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Feb 2020 20:52:05 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so14322890eds.8
        for <selinux@vger.kernel.org>; Mon, 24 Feb 2020 17:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEztz9TlMo/tyS7LDrot+lt0Z6MwHydlgzWc72Lx6ko=;
        b=Jaw3+hQnLdyGte/F7U9g+o20SYnQE5XYmiwv8tAK/L0h13EPSnl0CgU4c14LBCQpzS
         EAFRGxkjK/C+TYhnsrQeRwOYQp91JCBrUUBKkG1Ar23rAg+sTnpwIvDtRRzqNMpYEEjR
         7xWugaipKVgoVMpy7vz5iyH5Z2pGb08w7on8zAtxlutIiw14MKlxosSnirbBGl68ytsd
         etd5LPbiRXKFXX5Imo/Y1E6AbfJmrO/g9rypTTpGMQKAZnf8fHXM57viNYOMEk2jBHHh
         7V4WikhsVtBx46kW6+xNzJb6PEkCn6D4LjLbs6faWSPKoRYuR7RX/EpfH49dft6L4D22
         SJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEztz9TlMo/tyS7LDrot+lt0Z6MwHydlgzWc72Lx6ko=;
        b=jH2KFV4sdfIZ42jqqQn+U67I8avPyVaZV4bhTy9dHyaQ6jnRwJKrmRaToNrRmWMuwD
         Wcx9Qmh6zmBAfR08qKhtF2IkPVmSWrdJ6ldI0XVCF0AIHATXiRkzgoOQS1vrtLOqA3IG
         xLZcnKrrnAjYTBnCwLyPM8RfJ4p2/QvP7AuF8igr+JztxWAruYqq6ebwJ/BaN3m6djOG
         Cj5Hh653CrLCxVaF14Gxj620yipdDBX70fAE6W3HsblGm9qcaX2C6tya42LrLXFN8Bqs
         kANz0BoaGgwBLbFT7KAKbUnfKLir5JuA0kjQ+v5HRyFhzfdbzr00B2bxC+LDyhgDP+NX
         ofkw==
X-Gm-Message-State: APjAAAV7Vs1RO1QMve6xvEOCYGt2cMayoF7W5uF5Bw2v1NlvyT5kkz2e
        xzmkz19A3a4IOwAGJK7bvW8Yb4h5megAzUwuAGbb
X-Google-Smtp-Source: APXvYqyvHau4zoiCLz2+r6QJ8bFE/RWmmqHD2BYqBf5tdGf6Ek8v5EMuRIJLbRrL47jBKawCn4qgYjYRNkUgIswz15c=
X-Received: by 2002:a05:6402:22cf:: with SMTP id dm15mr11902777edb.31.1582595522328;
 Mon, 24 Feb 2020 17:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20200129164256.3190-1-sds@tycho.nsa.gov> <CAFqZXNsk_fyPuLDz-jtjtjzJR5rZmBAKgFzPk3Z0y35ahyaeRw@mail.gmail.com>
 <f9f12adf-51b1-3ba5-fef2-f290b69d974e@tycho.nsa.gov> <CAHC9VhQ8W4id4_v+YN9qXwzp-baa+57bcaqm3vSkZ4QaxkKVQg@mail.gmail.com>
 <63a0ca0b-e791-2607-ed94-94b67308cb3c@tycho.nsa.gov>
In-Reply-To: <63a0ca0b-e791-2607-ed94-94b67308cb3c@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Feb 2020 20:51:50 -0500
Message-ID: <CAHC9VhQCVd_++8r5zRp+1UJ2zE2g0p_GMgF9m=m5opRQyGVnbQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: remove unused initial SIDs and improve handling
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 24, 2020 at 8:27 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/22/20 4:33 PM, Paul Moore wrote:
> > On Fri, Feb 14, 2020 at 8:22 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 2/14/20 7:46 AM, Ondrej Mosnacek wrote:
> >>> On Wed, Jan 29, 2020 at 5:42 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>>> Fully decoupling the policy and kernel initial SID values will
> >>>> require introducing a mapping between them and dyhamically
> >>>
> >>> Nit: s/dyhamically/dynamically/
> >>
> >> Ah, thanks; will fix if I need to re-spin.
> >
> > Normally this would fall under the category of something I could
> > fix-up during a merge, but I think there are a few changes, mostly
> > documentation, that we should add to this patch.
> >
> > First off, I know MLS is the policy everyone wants to forget, but it
> > *is* used so let's not cause them any more pain then they are already
> > feeling.  That should add a few initial SIDs back into the list, but I
> > think it still frees up plenty.
>
> Not sure exactly what you mean here.  The patch should still remove all
> the unused initial SIDs (i.e. all initial SIDs for which there are no
> hardcoded references to SECINITSID_name).  The MLS discussion (which was
> only in the GH issue, not in the patch description) is about which
> initial SIDs can we start reusing in the near term without any
> compatibility implications.  So at most this affects what we say in the
> revised patch description when we pull in the GH issue information, not
> the patch itself.

Yes, I was thinking of isid reuse, but I wasn't very clear.

> I'd also question whether any MLS users would ever try to use a new
> kernel without also having a correspondingly updated policy; MLS users
> seems unlikely to run the latest kernels on existing distros.

That's a good point, but I see no reason why we should not preserve
that ability.  Especially since I don't see us adding a lot of new
initial SIDs in the near future.

> > Second, when we load the initial SIDs, in policydb_load_isids(), you
> > show an error if one of these isid's is assigned a context:
> >
> > + if (sid == SECSID_NULL) {
> > +   pr_err("SELinux:  SID null was assigned a context.\n");
> >
> > ... I would suggest that we also display the SID number like below so
> > that policy devs have a better idea of which isid is causing the
> > problem:
> >
> > + if (sid == SECSID_NULL) {
> > +   pr_err("SELinux:  SID null(%u) was assigned a context.\n", sid);
>
> This isn't an error check for unused initial SIDs; it is retaining the
> existing test for the NULL (0) SID, which isn't supposed to ever be
> assigned a context, while dropping the restriction on adding initial
> SIDs > SECINITSID_NUM.  sid can only be 0 here, and the message already
> says "null".  If you'd prefer it say "SID 0 was assigned a context" I
> can do that if/when I can ever post to vger again.

Sorry, I misread the patch; it's fine the way it is.

I've kept your reply intact (no trimming), with the exception of my
own inline comments, since your mail didn't hit the list.  Until you
find a way to workaround your mailing list problems Stephen I would
encourage others to do the same.

> > Lastly, and most importantly, there is a lot of good discussion,
> > including a "roadmap" in the GH issue, let's try to capture that in
> > this patch description (maybe minus your retirement plans Stephen
> > <g>).  I have no idea where GH may be in a few years, but the git log
> > is FOREVER ;)

-- 
paul moore
www.paul-moore.com
