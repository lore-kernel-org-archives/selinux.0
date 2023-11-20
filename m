Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892F0C2BB3F
	for <selinux@archiver.kernel.org>; Mon, 20 Nov 2023 23:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjKTXDY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Nov 2023 18:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKTXDY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Nov 2023 18:03:24 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF23A9F
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 15:03:19 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9beb865a40so4636310276.1
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 15:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700521399; x=1701126199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcx1O4WZkW9lPEGbS1WuKh9uKwQmfhNTK/5zQiqlRjM=;
        b=XjiUeyqLN45Ith9i1sl9lpw3NhEIaYMXdFn+Qd4VwL5PoivCVxWuYveMsOG+Io09SI
         lEQ3eTXh3fPrEjLL+xngRjjAPSd/FcHv1MRGWtXTJh8VHquVqMP2QKtk2NDqVoLhYq/Q
         UZjRRn1ofQ93T1gLxAVoSPdv7ohLEgv8h7y2FRq9/cRvvdUeK2t07HtG+dNuMlLttE4w
         ShlzyxTkxlN+R7jtLboV3HpSL7A4G0Ccjl0we+2d7du84TkYKJhhSFkdS/CaG62nqRGI
         IY4eYLOJq2nGT0PqOdg7qfcqKPcq4Dq4zbzixTgs7+6GnQ7QBmvLHcMAYOkuiBRv8nDl
         NZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700521399; x=1701126199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcx1O4WZkW9lPEGbS1WuKh9uKwQmfhNTK/5zQiqlRjM=;
        b=odENdct0krFokRmIRiRpNULmkdcm2wC9txNVRi8bMvrqyCZqGWMO3GTaw+PQdoOgs1
         5ZjU6yEVQvKJmRvueYFjXR5GkDr7A+JwRRisyVNmGlJScclDbxr7KBOU86x4TJwSKKAt
         S96eL3o69Iu2OtQeZn7Fh0lpucj7/7Y5kwOossKqIbu337MMRI8MRNjTZ6dd4a8vi5Cb
         mDGd5GLaEzJmJnu49JmWgXbXzdjEmHX1j1A/8P1jBjRkKsULNRGdZtaFf3sDQz3FwgKO
         HLv6Nnv23LESyHLj+cgZ4IXRz9GaxarViwd/A3Ve+Nf6PfjPibw1a97IP/+cbYjVuM4A
         +FVA==
X-Gm-Message-State: AOJu0YzhB66vdrOOXIP732aWsPZ1U9DXveAqy0YC2GziTLpiDka62rKq
        ggXE4VP5swjCL2SNntHJ2evIJ/W9bCK8lvvY+xXO
X-Google-Smtp-Source: AGHT+IEj/EkYlF2Cfty/fg0eKdElXPWPH5PHzzR4nbrd5O5pXcFkWDSd0Gz1dQZM82iONs/wFeJ0H0cTf0AW1mJ1DjQ=
X-Received: by 2002:a25:ab30:0:b0:da0:66ed:ea1e with SMTP id
 u45-20020a25ab30000000b00da066edea1emr8782208ybi.11.1700521399032; Mon, 20
 Nov 2023 15:03:19 -0800 (PST)
MIME-Version: 1.0
References: <20231018100815.26278-1-ddiss@suse.de> <CAEjxPJ6o8T=K+FHEHdWxn1PQN=Ew+KjooXL=coS0gx4YLuEFhw@mail.gmail.com>
 <CAHC9VhTLjcQXNoc8L3Uw=TRRghLuA_TnQbRkGtwnCu4kxVXE0g@mail.gmail.com> <20231020223327.09a6a12b@echidna.fritz.box>
In-Reply-To: <20231020223327.09a6a12b@echidna.fritz.box>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Nov 2023 18:03:08 -0500
Message-ID: <CAHC9VhTh-2TfE+0Kb551E=Ld0TwER=-N+mkr2R=122TbNvcHRw@mail.gmail.com>
Subject: Re: [PATCH] RFC: selinux: don't filter copy-up xattrs while uninitialized
To:     David Disseldorp <ddiss@suse.de>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 20, 2023 at 4:33=E2=80=AFPM David Disseldorp <ddiss@suse.de> wr=
ote:
>
> Hi Paul and Stephen,
>
> On Fri, 20 Oct 2023 11:55:31 -0400, Paul Moore wrote:
>
> > On Fri, Oct 20, 2023 at 8:21=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Wed, Oct 18, 2023 at 6:08=E2=80=AFAM David Disseldorp <ddiss@suse.=
de> wrote:
> > > >
> > > > Extended attribute copy-up functionality added via 19472b69d639d
> > > > ("selinux: Implementation for inode_copy_up_xattr() hook") sees
> > > > "security.selinux" contexts dropped, instead relying on contexts
> > > > applied via the inode_copy_up() hook.
> > > >
> > > > When copy-up takes place during early boot, prior to selinux
> > > > initialization / policy load, the context stripping can be unwanted
> > > > and unexpected. Make filtering dependent on selinux_initialized().
> > > >
> > > > RFC: This changes user behaviour so is likely unacceptable. Still,
> > > > I'd be interested in hearing other suggestions for how this could b=
e
> > > > addressed.
> > >
> > > IMHO, this is fixing a bug, only affects early userspace (pre policy
> > > load), and is likely acceptable.
> > > But Paul will make the final call. We can't introduce and use a new
> > > policy capability here because this is before policy has been loaded.
> >
> > I agree with Stephen, this is a bug fix so I wouldn't worry too much
> > about user visible behavior.  For better or worse, the
> > SELinux-enabled-but-no-policy-loaded case has always been a bit
> > awkward and has required multiple patches over the years to correct
> > unwanted behaviors.
>
> Understood.
>
> > I'm open to comments on this, but I don't believe this is something we
> > want to see backported to the stable kernels, and considering we are
> > currently at v6.6-rc6, this isn't really a candidate for the upcoming
> > merge window.  This means we have a few more weeks to comment, test,
> > etc. and one of the things I would like to see is a better description
> > of before-and-after labeling in the commit description.  This helps
> > people who trip over this change, identify what changed, and helps
> > them resolve the problem on their systems.
> >
> > Does that sound good?
>
> That sounds good to me. I'll rework the commit description (and comment
> above this change), do some further testing and then submit a v2.

Hi David,

No rush, I just wanted to check in on this and see how things were going?

--=20
paul-moore.com
