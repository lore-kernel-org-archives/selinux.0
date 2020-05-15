Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE526C433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 00:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9468F206D8
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 00:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JOrefRhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgEOAeK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 20:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728544AbgEOAeJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 20:34:09 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816F1C061A0C
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 17:34:09 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x20so517551ejb.11
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 17:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5LP6lUnAL57PoOeWCrVIEZ6pw4nEesAZrbwvlE8GnA=;
        b=JOrefRhI1KEIxqhYBQpKuLOh+Bw1YiRzSzCd6DgosmLx1RdtLqSetAP+nzo4xJzZHs
         IcmjKw6qrWQ4DmRnOuqVL9B1p6wxI654kMDVJLtjs6Zxd7wFIHKw7Oo3Ft64fwTEcU+d
         1r6olB1c2ioM0/ZDKPKfZffa5zXwKq0DBsXd1VM4Q2BHqJGlMRIeuQipR4bIRQn507np
         AC/u591rZzjrDZEd6MzvamKTgiC/dLSAs9mnqhgQws5GXwNVFZc2cLBXIRTWznX9AEPj
         0Vut/JsKBwKfM24yEPFOwnpYHajN5mymDp8kZiTH23O4VsRKA8Bq8KI9qFevvSTAjrqa
         j1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5LP6lUnAL57PoOeWCrVIEZ6pw4nEesAZrbwvlE8GnA=;
        b=b4hyvOb6YJz88a5wWor0tqmzaVvmQFRNsq7XGNVYqfgAMnYYLgOSJrv838QyDHfXCw
         nJCyhsnCp0KzGa+bkG5QToc3bVJLQK2EYhPcuVqImUF3cdHoKwoyRf/3Ou7oMhJqFyWp
         KrLzwW6hxA8YM4YGiqVQVeyjXxi62p/jTARSdr+O8TNCECWB1wRAhENIgEZpanL9wg7s
         fgCqA0ibCsy9rGWr5aNkXgIgOmcu6jp8XpmNv5Wg7vSkolCHjysCMTScMu7PlDtThwfB
         mxAG5MeKCMkp2rQPlBkT1RKI16cJmOMSA8CpEffx2RCxe0YoySuCAP1O+C3i7YpgpkVu
         ts5g==
X-Gm-Message-State: AOAM533wXMgOVai4XEEjwShT+Mb4JRCZXVhLZ2ItMBaIY060h+NbgGqC
        o6VQdLZG0ggeH5xFVCi3AKOkP8yGP3ilysYVnYDvp2M=
X-Google-Smtp-Source: ABdhPJw4BOclUgDvILTYDcm/fsMR2NhiH9v5FHCc2FsL3lixJNAzA5rKMUkDtE8il/0dVAw4TvIv7AC27PqmEKZuwbs=
X-Received: by 2002:a17:906:4dcc:: with SMTP id f12mr607748ejw.272.1589502848065;
 Thu, 14 May 2020 17:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAO6P2QQRFBmUdjpz0GudUxyACjveCWg0yyGzz_6_5YnUQ4fLBQ@mail.gmail.com>
 <CAMN686H5K6Ohzd297giboVoD=Jud+k9tRvvCtJJZ8jvNmv_=HA@mail.gmail.com>
 <CAO6P2QS78aTzCvMHgUWmgmkVjEN9v0Wq0Lgys2puL6eRW+CLjg@mail.gmail.com>
 <CAEjxPJ4ePzeuhiRdLndM3U7sybjG8QUO8xhd5RuFNH-YB8NB1w@mail.gmail.com>
 <CAO6P2QS0ze4e7qRfZBkemZTaM9QQUwUwhNs2bG4gfTkenwcsiA@mail.gmail.com> <CAEjxPJ7kF-TB22fZmYPuH0jtBTUBzfd=BcKryPs0t-1H+CwN5g@mail.gmail.com>
In-Reply-To: <CAEjxPJ7kF-TB22fZmYPuH0jtBTUBzfd=BcKryPs0t-1H+CwN5g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 May 2020 20:33:57 -0400
Message-ID: <CAHC9VhSuxnBpJuFEoAgddA-P8DUdqcQjK9taaABTjDB0Y-uVgQ@mail.gmail.com>
Subject: Re: Configuring MLS with a daemon operating at multiple sensitivities
To:     Paul Tagliamonte <paultag@debian.org>
Cc:     Mike Palmiotto <mike.palmiotto@crunchydata.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 14, 2020 at 11:30 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, May 14, 2020 at 10:57 AM Paul Tagliamonte <paultag@debian.org> wrote:
> >
> > > Was computing the MLS label the only part you needed?  With respect to
> > > having the daemon run in the same label as the peer (or the label
> > > derived from the intersection of the peer and the daemon), you may
> > > wish to have a look at mod_selinux for Apache and/or the old xinetd
> > > LABELED option, although neither of those would have included the new
> > > glblub support so you'll have to integrate that yourself.
> >
> > Ah, really helpful pointers, thank you very much!
> >
> > > Or your daemon can just use setcon(3) directly if allowed by policy.
> >
> > My assumption was that I can use the greatest lower bound, and then
> > preform a `setexeccon` and `exec` to transition to the new security
> > context provided I can pass the open fd according to policy (for
> > now -- at least until I can find a better way to restrict a thread -- I'll
> > do some reading in mod_selinux / xinetd). Is this the case, or am
> > I going to wind up in a world of hurt?
>
> setcon(3) would avoid the need for a separate exec but requires more
> trust in the caller ...

One also has to be careful when using setcon() as it only affects the
domain of the running task and not any transient objects that may have
been created and which the task might expect to be able to access
(which of course is the right thing to do).  If it fits within your
model, setexecon()/exec() is easier, safer, etc.

-- 
paul moore
www.paul-moore.com
