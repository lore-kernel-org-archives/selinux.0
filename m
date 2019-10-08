Return-Path: <SRS0=qSAh=YB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DC3C4360C
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 21:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB3D2070B
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 21:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="TrqBsP2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfJHVoE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Oct 2019 17:44:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46233 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfJHVoE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Oct 2019 17:44:04 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so17180lfc.13
        for <selinux@vger.kernel.org>; Tue, 08 Oct 2019 14:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwTokT8WtH+PcVF6GnO5LKblO9yTUwPgJYjqcfpQh1M=;
        b=TrqBsP2xtS1zTpujR4GTWyoKiVMS72JzhTDejP6u3UfMNfVPG2zm8QTLLD0tkw7h+1
         zp70F6Smrzwm8zOsuyW5Tbs+umMoF1Y9VCKTrL/WSakvxQqqNbXoSLtP+yb7VIXGxfNO
         iO1RLgKEwNenTKz4HY3ALrAcLZLT/s0LQvyAP+zrq6ucpy6jb2xqbYd2TDdQow/W1qJZ
         N3vZz7+yol6GWbr7VIfRYJqcdEKtfS8I2zpm06L+zgeyUkZ36Z0T0FnfwnGyMnsFpDmw
         DH36daasYCSND24wttuZ5kzP/H2DbzbvB2ilySWJSbgqSxFWfv4z8f6A/gpxIVW1qKNl
         raww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwTokT8WtH+PcVF6GnO5LKblO9yTUwPgJYjqcfpQh1M=;
        b=pZWQSEj1bAGUUtjEM0k6ExtrNJle6OzXTc3+ubBERjJv5imQ3EeKTC5KuMcWKgCdRg
         W6daVRr9gn3ACU/iioD+bpkf6xOCeeQpbJ2nazivcLBxC9m4fxAY5WtLHTubPxipWYlG
         x/GT4Q558mYN8FFcJ7yvZuzLT605dugGp62AD/pDosGS3I28oWTjzpxbI3fv+p7foAPc
         PcPA+IkIE6j7EGTx390l/P6N6UXTh6ZgMaTReRWunfqBE7xH5OtRs36wGqeP39ne6oUG
         JqvTNB675bwAdgEs7nnjw1wWEYK9GOd/aJFVaMUxcEuAlPEM69XmlLT2ehW7s9g186+W
         BAGQ==
X-Gm-Message-State: APjAAAWRt1XTUrk9vnMQ+glwXy6qWnffyTzPDhbnetW67vPlOsBABrGj
        OBx7N2wBJ8QtWna5DVbcCvtpBx5zPQSV/q1FHrKf
X-Google-Smtp-Source: APXvYqynFb3tGfQVv01BozTDGtURssc/RMKVxuuPU0C+xkrTd4Wk5QvKq8J37gMODqB057KnuEs6KITrsms5+df9m9E=
X-Received: by 2002:ac2:4213:: with SMTP id y19mr21453176lfh.13.1570571040779;
 Tue, 08 Oct 2019 14:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191006085121.13556-1-richard_c_haines@btinternet.com>
 <5e20d80f-909f-0bb7-4cf5-16e7ce89382b@tycho.nsa.gov> <57056c510589650446ac4dd079c112e22dffb042.camel@btinternet.com>
 <4f0c2ff54dd1ad94392ef7c2428c766e0e2a2574.camel@btinternet.com>
In-Reply-To: <4f0c2ff54dd1ad94392ef7c2428c766e0e2a2574.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Oct 2019 17:43:49 -0400
Message-ID: <CAHC9VhQcvFna_Jj5kZaJVbUtY_EW97sreAODTiaH8pb8nEqZjA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Update binder for kernel 5.4 support
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 7, 2019 at 12:35 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Mon, 2019-10-07 at 16:17 +0100, Richard Haines wrote:
> > On Mon, 2019-10-07 at 10:28 -0400, Stephen Smalley wrote:
> > > On 10/6/19 4:51 AM, Richard Haines wrote:
> > > > Kernel 5.4 commit ca2864c6e8965c37df97f11e6f99e83e09806b1c
> > > > ("binder: Add
> > > > default binder devices through binderfs when configured"),
> > > > changed
> > > > the way
> > > > the binder device is initialised and no longer automatically
> > > > generates
> > > > /dev/binder when CONFIG_ANDROID_BINDERFS=y.
> > >
> > > This seems like a userspace ABI break, no?  Same kernel config
> > > before
> > > and after this commit yields different behavior for
> > > /dev/binder.  I
> > > suppose one might argue that one would only enable
> > > CONFIG_ANDROID_BINDERFS if one wanted to use it instead of
> > > /dev/binder
> > > but the original commit that introduced binderfs specifically said
> > > that
> > > backward compatibility was preserved.
> > I'll need to check this further, but from what I've seen so far, is
> > that the /dev/binder is not available until you mount binderfs etc.
> > that's why Paul had the failure on 5.4 as before then is was
> > available
> > when the binder driver first initialised.
>
> To confirm tests using kernel 5.4-rc1
>
> Test 1 config:
> CONFIG_ANDROID=y
> CONFIG_ANDROID_BINDER_IPC=y
> CONFIG_ANDROID_BINDERFS=y
> CONFIG_ANDROID_BINDER_DEVICES="binder"
>
> On boot no /dev/binder
>
> To get this you have to:
> mkdir /dev/binderfs 2>/dev/null
> mount -t binder binder /dev/binderfs -o
> context=system_u:object_r:device_t:s0 2>/dev/null
>
> You then have devs:
> binder and binder-control
>
> Test 2 config:
> CONFIG_ANDROID=y
> CONFIG_ANDROID_BINDER_IPC=y
> # CONFIG_ANDROID_BINDERFS is not set
> CONFIG_ANDROID_BINDER_DEVICES="binder"
>
> On boot you have /dev/binder

Disabling binderfs during build is probably not the smart thing to do
considering where the world is at with namespaces/containers, whatever
we do we should make sure the tests work with
CONFIG_ANDROID_BINDERFS=y.

-- 
paul moore
www.paul-moore.com
