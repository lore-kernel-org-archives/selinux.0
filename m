Return-Path: <SRS0=cHrg=RV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2B0C43381
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 22:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61D32085A
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 22:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="R7+AE6aS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfCRWmd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:42:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39957 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfCRWmd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Mar 2019 18:42:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id u68so12932385lff.7
        for <selinux@vger.kernel.org>; Mon, 18 Mar 2019 15:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XS/0dB1sN6ROCSW5fKxVSxCunCAPVkkW/sbiPeDoi5M=;
        b=R7+AE6aSA8h/12G661abqRG/u6U/OhjK5XZZ+8hkMpJ4y34uWbXRbgR8S4q6Up+pKk
         vGqjwD9htIDLQKLnCYT/c5M1R7tcfSWoq9lmt3Kmo2RNXpKKxvKGKyOT5BB1h2eJk+fO
         7gEwnZQtSx+/OBChebVGbd6pdqC3DfOkKdwiB/ifiEn97B54o923vDMIkHtSmuwWzdCD
         Vg85Vi/ke5EahEx86vfDvYrpyxIOIL8NLfcGBXc+1Su+WmjU/yBQT1+y4xHoZMAb/zFi
         AmyyS3OMu1lBtTxWwPuJmZQJOAZNm3p7cepXlIwhIdU0iNrCGg0fz6u0lOjd7jPmP581
         wINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XS/0dB1sN6ROCSW5fKxVSxCunCAPVkkW/sbiPeDoi5M=;
        b=jzuGMLf8dsNVEbQb2Tn2rzUqeeXuDgaA/v2jfBk3AvoxO7si9qhY1PGGcl6vwh4Gyv
         ZPzEyaebqItttI/iDQXBCtc248n/WM0NxxKkEIPZrnVEnZ/ppQtgh20JWBssY9lelU5V
         XwCGSX8zXJPQNE9Ajbr2L5xfEpmZOX7Wxmwd2HOGChgNsCSpMVkAAh+B997oPmDWFelX
         P1CAz8qP/8gZ7tMw8LKkRuuV82AY2zsntDnapFCBQ4lfBuVfqOTzQnb+gW0Y+kgQhc+B
         wqRftz/3YTX8kGcwjKWNdq1qwHESuaVSdfQ4S4xwI5F36RfmN4ECu+Ir8MashYogbKxW
         eqIw==
X-Gm-Message-State: APjAAAUIgPv8jmIBazU4UnMVq9IECZkbQ9xfTTyuHst3LRuxbT6NMgU2
        rleO41IIm1D7ol/Ujf1uI5EtDYxWw+WT9Ul2hehnooM=
X-Google-Smtp-Source: APXvYqx8rfq+XFFSfbDV4bglsSN0E262nX2hiWn0tXi5JSnDP5E8IF9udGVNViJFXzre45w4VG/lwJ6MuhdlizTpmEo=
X-Received: by 2002:ac2:42da:: with SMTP id n26mr10007777lfl.91.1552948950900;
 Mon, 18 Mar 2019 15:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190221213147.1590-1-sds@tycho.nsa.gov> <20190222085518.GA28321@brutus.lan>
 <2ad07cfb-33a6-d9cc-f442-560905b4d646@tycho.nsa.gov> <87o9746ix7.fsf@gmail.com>
 <bd077bbb-0499-4c7f-3f12-c1cf626ccb16@tycho.nsa.gov>
In-Reply-To: <bd077bbb-0499-4c7f-3f12-c1cf626ccb16@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 18 Mar 2019 18:42:19 -0400
Message-ID: <CAHC9VhRixFCQJqQF+KUYHdfF7-bmZXvZfHeezyzxxYVs=PG9Ow@mail.gmail.com>
Subject: Re: [PATCH v6] scripts/selinux: modernize mdp
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Dominick Grift <dac.override@gmail.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 22, 2019 at 9:51 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/22/19 8:40 AM, Dominick Grift wrote:
> > Stephen Smalley <sds@tycho.nsa.gov> writes:
> >
> >> On 2/22/19 3:55 AM, Dominick Grift wrote:
> >>> On Thu, Feb 21, 2019 at 04:31:47PM -0500, Stephen Smalley wrote:
> >>>> Derived in part from a patch by Dominick Grift.
> >>>>
> >>>> The MDP example no longer works on modern systems.  Fix it.
> >>>> While we are at it, add MLS support and enable it.
> >>>>
> >>>> NB This still does not work on systems using dbus-daemon instead of
> >>>> dbus-broker because dbus-daemon does not yet gracefully handle unknown
> >>>> classes/permissions.  This appears to be a deficiency in libselinux's
> >>>> selinux_set_mapping() interface and underlying implementation,
> >>>> which was never fully updated to deal with unknown classes/permissions
> >>>> unlike the kernel.  The same problem also occurs with XSELinux.
> >>>> Programs that instead use selinux_check_access() like dbus-broker
> >>>> should not have this problem.
> >>>>
> >>>> Changes to mdp:
> >>>> Add support for devtmpfs, required by modern Linux distributions.
> >>>> Add MLS support, with sample sensitivities, categories, and constraints.
> >>>> Generate fs_use and genfscon rules based on kernel configuration.
> >>>> Update list of filesystem types for fs_use and genfscon rules.
> >>>> Use object_r for object contexts.
> >>>>
> >>>> Changes to install_policy.sh:
> >>>> Bail immediately on any errors.
> >>>> Provide more helpful error messages when unable to find userspace tools.
> >>>> Refuse to run if SELinux is already enabled.
> >>>> Unconditionally move aside /etc/selinux/config and create a new one.
> >>>> Build policy with -U allow so that userspace object managers do not break.
> >>>> Build policy with MLS enabled by default.
> >>>> Create seusers, failsafe_context, and default_contexts for use by
> >>>> pam_selinux / libselinux.
> >>>> Create x_contexts for the SELinux X extension.
> >>>> Create virtual_domain_context and virtual_image_context for libvirtd.
> >>>> Set to permissive mode rather than enforcing to permit initial autorelabel.
> >>>> Update the list of filesystem types to be relabeled.
> >>>> Write -F to /.autorelabel to cause a forced autorelabel on reboot.
> >>>> Drop broken attempt to relabel the /dev mountpoint directory.
> >>>>
> >>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> >>>> ---

...

> Ok, in that case I'm going to consider the v6 patch the final one unless
> Paul has comments.

No major comments from me, both you and Dominick really ran with this
and I appreciate the effort.  Merged into selinux/next, thanks guys.

-- 
paul moore
www.paul-moore.com
