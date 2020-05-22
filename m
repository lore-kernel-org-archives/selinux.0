Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F93CC433DF
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 18:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E57206D5
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 18:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oazneOXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbgEVSCe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 14:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbgEVSCd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 14:02:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722B8C061A0E;
        Fri, 22 May 2020 11:02:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q9so5298445pjm.2;
        Fri, 22 May 2020 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OoHWvRoP7t+NzPVsX3uJpTKcJuiXbYmPLGBSjWQjP8Y=;
        b=oazneOXniPrQlfMSbP9Fp9v+9kBWm5EO5R1n4rq3DcwOEhqDbXVHEf374ljuY1lym7
         aF/eGa3K5ihDiAO3IOXbaPMOcfAQM59NuRy+E+mATMGDVzt3uEL0HMrJ47wF23e5E0Fg
         deEbYl7NSF5US9jqt5htCoYHreOowXuysBLVPe8O7wUGr9gL7fSyLHL6qtjTDS8MXhW7
         EcLaBuZLn1Sd4ponE9w/rwURv/Tk5TAs4Rrc1B5vNqoe8OPxX9ydFUxXcnaIdElb8tkc
         817IbRGoQYNQlagHBh+ltnMY+tqWRMTealQS2CNoiy00tPAfb0JLPsI2fORn9GU5GHxz
         Mm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OoHWvRoP7t+NzPVsX3uJpTKcJuiXbYmPLGBSjWQjP8Y=;
        b=mxM6fSfkbj2tmqO148j5BxyuAhjbPdmoFC3lUikfPEO0h3IKHV0BYfZ4DT5n3DfAMb
         kfrIhQT3w1lPI8vHRWf9wnx9mqJyXBoJutFU0nyufHYKsl7/V4ucYgE7boUmfb5mw0Zk
         g6bR17xoET6xdTpFXFnEe3PZ0yGbgnE7aOMGYnsWrSG4xozQPUrmmreTMP8AsEKORKg6
         1Bz6Dzm6PfQsPuGNUT/JhtuPV9PnNKZxtBUqR6DHqtQRiGC2NNPZpQIvF0DHdEzutSPp
         LZlCyikCH5V3KSUzQ7dBmavrtIoK1d6aum6q4UZLDm57ynQNmApmUVQtRVV80Uz8A9UF
         p7cw==
X-Gm-Message-State: AOAM5302IYx8i+svsta1DWVBsn53oZIMqMMzBCz2ANkebtZEA+DEtutI
        fd0MWOGy6JHCYOHceUxJiSk=
X-Google-Smtp-Source: ABdhPJx4BI2xGS6+Jeg0fg2dQujvMCqdHmKqZB535EWOd8YNEkDBnQAmeXtXqBdZudvoUaacpI1KUw==
X-Received: by 2002:a17:90a:6b08:: with SMTP id v8mr5562967pjj.151.1590170551687;
        Fri, 22 May 2020 11:02:31 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id 78sm6649832pgd.33.2020.05.22.11.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 11:02:30 -0700 (PDT)
Date:   Fri, 22 May 2020 11:02:28 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
Message-ID: <20200522180228.GA6466@gmail.com>
References: <20200522055350.806609-1-areber@redhat.com>
 <20200522075331.ef7zcz3hbke7qvem@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200522075331.ef7zcz3hbke7qvem@wittgenstein>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 22, 2020 at 09:53:31AM +0200, Christian Brauner wrote:
> On Fri, May 22, 2020 at 07:53:50AM +0200, Adrian Reber wrote:
> > 
> > There are probably a few more things guarded by CAP_SYS_ADMIN required
> > to run checkpoint/restore as non-root, but by applying this patch I can
> > already checkpoint and restore processes as non-root. As there are
> > already multiple workarounds I would prefer to do it correctly in the
> > kernel to avoid that CRIU users are starting to invent more workarounds.
> 
> It sounds ok to me as long as this feature is guarded by any sensible
> capability. I don't want users to be able to randomly choose their pid
> without any capability required.
> 
> We've heard the plea for unprivileged checkpoint/restore through the
> grapevine and a few times about CAP_RESTORE at plumbers but it's one of
> those cases where nobody pushed for it so it's urgency was questionable.
> This is 5.9 material though and could you please add selftests?
> 
> It also seems you have future changes planned that would make certain
> things accessible via CAP_RESTORE that are currently guarded by other
> capabilities. Any specific things in mind? It might be worth knowing
> what we'd be getting ourselves into if you're planning on flipping
> switches in other places.

/proc/pid/map_files is one of the first candidate what we need to think
about. CRIU opens files from /proc/pid/map_files to dump file mappings,
shared memory mappings, memfd files.

Right now, it is impossible to open these files without CAP_SYS_ADMIN in
the root user-namespace (proc_map_files_get_link).
