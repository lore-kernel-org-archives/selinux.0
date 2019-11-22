Return-Path: <SRS0=8Pnr=ZO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271FAC432C0
	for <selinux@archiver.kernel.org>; Fri, 22 Nov 2019 13:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39A220707
	for <selinux@archiver.kernel.org>; Fri, 22 Nov 2019 13:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Oxmtbpj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKVNj0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:39:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43236 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfKVNj0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Nov 2019 08:39:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id y23so7377213ljh.10
        for <selinux@vger.kernel.org>; Fri, 22 Nov 2019 05:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSwPfEliwTYs8XfX0tWFXufuL44SFMrvv0cgwP+QxSc=;
        b=Oxmtbpj39VVoIAjoHmj396d0ghocsSwrmUspcac4QDS7bAcNcgsbNO7CU1r7kMoT5w
         wtVXdDB/KJiifBSXGS3qrSxSe+HZzh/AvIrFJxbAJMmUm1T67SxGhoJpWFpLAgp3aqdr
         nyA36w0QIgcE0zSiyeS9MXObnf7DaQsL5pbNKN+fiV02eof7yIq5nEWLZReiyqqD1opH
         gJmzuaFcpoUMDdEYylYDBzkxh3JXy5SlAWWTNEprqdrbN5YbVfBZLXHYDWcjMqt5yDGP
         lBGiYPX7wOSKfemvHojNbSMjal2WrU+2H6cpH+vHb6OwZsSGMivfPwIWk1Mk7RJtRw6N
         JHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSwPfEliwTYs8XfX0tWFXufuL44SFMrvv0cgwP+QxSc=;
        b=O54/9KMNFz+E3Wjd2qY7DJeJK2PzGHLYC9JIw0VPLi6T6sJPDoKfQJQQ3dlNpnFb0T
         gfVtSP6iRgXcFPUd8wUmtTogV06GAPtVcqvq0UKQa6QFwKztPz9LTmlp6EMuyLICbms8
         q6fMU5rz+0IWnvtBam+NmC3OATRFxohlx9gEENPjsNV74PEKj/es8kak7eoHEJn+lsEJ
         7kyyK7HE+FdMriA4xccqBdvDLLNzHWuatsl0hxNI2oIKP544fw6PcnjlXNiHi2e4QBPW
         g/gl/uW0RgrRQeYR3ilB/fBN9ylFcbGqcPfRNxpyc6uPNM7mVtply9pURozwWfeZN0rU
         suKw==
X-Gm-Message-State: APjAAAUg+T8lKdUNzEZIXcurfeIUQLpSZP1+7X4aH2qCQ5iqjBIKAIYa
        U7buY0coqPuNn6DY7OR5/Vr4zROz3z4T5qDMl2tU
X-Google-Smtp-Source: APXvYqw73290esDnFIreT/aGgSdcLqWd6c3xj6uwc3VqdRWzIdWI5NxWkCqiCuCDCp0ec3ofhUK03KuACNhKTo0NeuQ=
X-Received: by 2002:a2e:7811:: with SMTP id t17mr12429521ljc.225.1574429963109;
 Fri, 22 Nov 2019 05:39:23 -0800 (PST)
MIME-Version: 1.0
References: <20191119113845.89951-1-richard_c_haines@btinternet.com>
 <CAFqZXNtdWNSma6Y55bPcRvJinCe=F4YNwuciDAhhdgr95ef0Dg@mail.gmail.com>
 <CAFqZXNtZ8TVWP=6Rsp81u5NOHsvgc0Xr2yMtATTv2R-u5YmOhw@mail.gmail.com> <57736f19-2b1b-aa1f-39ea-19f5c837ad9a@tycho.nsa.gov>
In-Reply-To: <57736f19-2b1b-aa1f-39ea-19f5c837ad9a@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Nov 2019 08:39:12 -0500
Message-ID: <CAHC9VhS3jdaCH+jdmTG=Qk+r_zBuaNdWtFKnQ=ntQL-PpDqjPA@mail.gmail.com>
Subject: Re: [PATCH V4] selinux-testsuite: Add kernel module tests
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 22, 2019 at 8:04 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/22/19 5:40 AM, Ondrej Mosnacek wrote:
> > When trying this on RHEL-7, I realized there is a missing kernel
> > version check here (module_load kernel support was introduced in v4.7
> > [1]):
> >
> > ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
> > ...
> > endif
> >
> > It is quite a corner case to have a policy that supports module_load
> > and a kernel that does not, but there is at least one distro that hits
> > it, so I think it's worth it to add the explicit check.
> >
> > Stephen/Paul, is it trivial enough to add when merging the patch or
> > should Richard repost it?
> >
> > [1] https://github.com/torvalds/linux/commit/61d612ea731e57dc510472fb746b55cdc017f371
>
> Alternatively, you could exclude it on RHEL7 by adding it to the
> filter-out line under ifeq ($(DISTRO),RHEL7).  Regardless, it is
> entirely up to you as to whether you want to fix it up on merge yourself
> or request a re-spin.

Yes, each project and maintainer handle this differently.  I
personally try to have the original submitter make the change(s)
whenever possible (assuming they are not merge related); I do this for
a few reasons: 1) it is their name on the code, and I don't want to
cause them problems by others mistaking my changes for the submitters
changes (aside, this is why I try to mark my edits in the commit
metadata) 2) changes made during the merge don't go through the normal
mailing list review 3) the mailing list feedback loop is a Very Good
Thing in my opinion and we should do what we can to keep it going.

That said, there are cases where the change is mindlessly trivial
(e.g. misspellings, nonconformant whitespace, etc.) and I don't have a
problem making that edit.  I'll also consider making larger changes if
I know the original submitter to be unreliable and we want/need to get
the commit into the tree soon.

-- 
paul moore
www.paul-moore.com
