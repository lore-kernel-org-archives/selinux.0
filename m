Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E054C282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 16:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9AB20844
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 16:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfAYQPd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:15:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38467 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAYQPd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 11:15:33 -0500
Received: by mail-oi1-f194.google.com with SMTP id a77so8049541oii.5
        for <selinux@vger.kernel.org>; Fri, 25 Jan 2019 08:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTYFnfXapl85KudwV4wO9qpsGluhrWfAMUMXFPKHR7k=;
        b=NYWU83hBRPW8xQ5YsF3itfeQ1UvNfLJrfhuBDXXYXg4ZIAD+2gRAwC3/uIvEcuLo/d
         88IrH0N8Za72rI88lemvkLCoYrRBtOXL5XmPvDgJWi6Cg2B8bU3BOkYpKWsFTQzwbF9M
         wkHO5ONJzM1SI0k8Ev06/AyvMYF5oy9hWQOL475UsvbuHgRb1Tc2aR8BX9eOK59bMtb2
         +2PHsdFjMtnZgsOeH4RojP4uLmebHzpIBRVHNaQeuRAayR8RLp2d2B37elEQGKiatghG
         hrDoBLLXLRqBJPGS5zKv60+fiI7qEIXe2J3mFwg/QIgrafSrAQtj5fGkVlISjlNnQ9Wc
         n27Q==
X-Gm-Message-State: AJcUukcKGB8RbreOiVHL3FMiRf6i8JJvVnD37xN/JZxMiSaE3ag18LF6
        1CbW+j/VcqnPJQ8BJRUEQhetH0ASxR46RoANE3r8bcDY
X-Google-Smtp-Source: ALg8bN7YsLJLP5ysQDbOLwkgrGyCKMvpIcTcTAR2KKdNX8u6pYIpdofRr0lxnwS/7HLxNslJOKJJkI6m/3LoKA8nDWc=
X-Received: by 2002:aca:293:: with SMTP id 141mr1713446oic.28.1548431732030;
 Fri, 25 Jan 2019 07:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20190125100651.21753-1-omosnace@redhat.com> <20190125100651.21753-4-omosnace@redhat.com>
 <0e0ce852-12ab-4855-7794-c1744160e78e@tycho.nsa.gov>
In-Reply-To: <0e0ce852-12ab-4855-7794-c1744160e78e@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 25 Jan 2019 16:55:21 +0100
Message-ID: <CAFqZXNtuue8dQGigBR0SkiXbeohVxHhh5vdJxX7f=2p6C072gA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] selinux: remove some useless BUG_ONs
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 25, 2019 at 2:49 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/25/19 5:06 AM, Ondrej Mosnacek wrote:
> > These BUG_ONs do not really protect from any catastrophic situation so
> > there is no need to have them there.
>
> They are to catch bugs in callers that pass requested==0.  That is
> always indicative of a bug in the caller (e.g. failed to correctly
> compute the permissions).  Otherwise, we will silently allow such calls
> and not notice them.
>
> At the least, they should be WARN_ONs.

OK, seems that switching to WARN_ON() will be a better choice.

Paul, you can apply the series without this patch and I will post a
corrected patch separately (if that's OK with you).

>
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   security/selinux/avc.c | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index 5ebad47391c9..478fa4213c25 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -1044,7 +1044,6 @@ int avc_has_extended_perms(struct selinux_state *state,
> >       int rc = 0, rc2;
> >
> >       xp_node = &local_xp_node;
> > -     BUG_ON(!requested);
> >
> >       rcu_read_lock();
> >
> > @@ -1134,8 +1133,6 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
> >       int rc = 0;
> >       u32 denied;
> >
> > -     BUG_ON(!requested);
> > -
> >       rcu_read_lock();
> >
> >       node = avc_lookup(state->avc, ssid, tsid, tclass);
> >
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
