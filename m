Return-Path: <SRS0=wOFf=QL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA531C282D8
	for <selinux@archiver.kernel.org>; Mon,  4 Feb 2019 09:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58982147A
	for <selinux@archiver.kernel.org>; Mon,  4 Feb 2019 09:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfBDJsr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:48:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37178 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfBDJsr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Feb 2019 04:48:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id s13so11943413otq.4
        for <selinux@vger.kernel.org>; Mon, 04 Feb 2019 01:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6FBCNv8Amd2T6qCzRKYhQAWznNu2sLvBARf0W5Lu0p8=;
        b=JZyNEKMrG81ZeulVVc00CIVvWn0oNEeCi0DCBkWx7562AG/gyLdGZhusfJtLp52iNS
         Pyzh7gbWbW/69RpqJwwBZFLIUFJ4w6Ez4RZIaJWDP7NYiA+OrgmQIXVgoJhboIrZrCD3
         nvAEv5kfNCsFkgciB5xarKksON+EtaNV4p4OMqMrQE179x6rCLDKW3+PRtNXPwXoKNB7
         mB714s9mMi1E+5VeCjcmwm8EpHjxx8CY2ZMjWrn4uo5YuED9Y2fcINOinFw98ky31bJk
         wb1Lz1dhvDicp3WHZ1KGz4DxEXlVMgnApNlywgCFP+EXP1dHdvDcNV7T4/qKIGIffTKW
         kDRA==
X-Gm-Message-State: AJcUukewaQ2w/vF0qRNDU8GFWd7HVwfX+iszg5LDYFAviBQI0ECfkMKt
        DkHoS+zhlRvYY3yA10WDlV7nu7u5o6x+wKejPk4Kng==
X-Google-Smtp-Source: ALg8bN44sb6V59wT0E57n2ppjt6KdRNDkuTas+wvVPNZa5NcKymJZFMolYJhsDQuYfAgjc9cxwY1ADlmreG088YZETA=
X-Received: by 2002:a9d:1ea7:: with SMTP id n36mr35579193otn.217.1549273726342;
 Mon, 04 Feb 2019 01:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20190130114150.27807-1-omosnace@redhat.com> <20190130114150.27807-6-omosnace@redhat.com>
 <20190130170911.GZ50184@devbig004.ftw2.facebook.com> <CAFqZXNt0jNg2-bNbtsCX2=7bcb_GaxCnHfSyck=GksXBTkWJ-g@mail.gmail.com>
 <ebe3c70e-2bde-9fca-bb05-b46173e09b69@schaufler-ca.com>
In-Reply-To: <ebe3c70e-2bde-9fca-bb05-b46173e09b69@schaufler-ca.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 4 Feb 2019 10:48:35 +0100
Message-ID: <CAFqZXNuGUE4oq-=PK9mb=9V5wiETQR4UHYs5XF44-aWoZRrqdg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] kernfs: initialize security of newly created nodes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Tejun Heo <tj@kernel.org>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 31, 2019 at 5:39 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 1/31/2019 2:20 AM, Ondrej Mosnacek wrote:
> > Hi Tejun,
> >
> > On Wed, Jan 30, 2019 at 6:09 PM Tejun Heo <tj@kernel.org> wrote:
> >> Hello,
> >>
> >> On Wed, Jan 30, 2019 at 12:41:50PM +0100, Ondrej Mosnacek wrote:
> >>> @@ -673,6 +698,12 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
> >>>                       goto err_out3;
> >>>       }
> >>>
> >>> +     if (parent) {
> >>> +             ret = kernfs_node_init_security(parent, kn);
> >>> +             if (ret)
> >>> +                     goto err_out3;
> >>> +     }
> >> So, doing this unconditionally isn't a good idea.  kernfs doesn't use
> >> the usual dentry/inode because there are machines with 6, even 7 digit
> >> number of kernfs nodes and some of them even failed to boot due to
> >> memory shortage.  Please don't blow it up by default.
> > Hm, I see... basically the only thing that gets allocated in
> > kernfs_node_init_security() by default (at least under SELinux/ no
> > LSM) is the kernfs_iattrs structures, so I assume you are pointing at
> > that. I think this can be easily fixed, if we again use the assumption
> > that whenever the parent node has only default attributes
> > (parent->iattrs == NULL), then the child node should also have just
> > default attributes (and so we don't need to call kernfs_iattrs() on it
> > nor call the security hook). Something along these lines:
> >
> > [...]
> > +static int kernfs_node_init_security(struct kernfs_node *parent,
> > +                                    struct kernfs_node *kn)
> > +{
> > +       struct kernfs_iattrs *attrs, *pattrs;
> > +       struct qstr q;
> > +
> > +       pattrs = parent->iattrs;
> > +       if (!pattrs)
> > +               return 0;
> > +
> > +       attrs = kernfs_iattrs(kn);
> > +       if (!attrs)
> > +               return -ENOMEM;
> > +
> > +       q.name = kn->name;
> > +       q.hash_len = hashlen_string(parent, kn->name);
> > [...]
> >
> > Technically this might make some LSMs unhappy, if they want to set
> > some non-default context even if parent is all default,
>
> The only possibility I see as a potential problem is a kernfs
> mounted with the smackfstransmute=Something option. This sets
> the security.SMACK64 to "Something" and the security.SMACK64TRANSMUTE
> to true on the root node. But that doesn't seem like a rational
> thing to do for a kernfs based filesystem.

Actually... I am now experimenting with a slightly different
kernfs_node_init_security() implementation that should allow for
calling the hook every time and only allocating kernfs_iattrs when it
detects that the hook actually did add some security xattrs. It is
somewhat more hacky and complex, but it should provide the best
possible compromise. I will post it for review soon.

>
> > but this is
> > already impossible now and in this case I think we have no better
> > choice than sacrificing a bit of flexibility for memory efficiency,
> > which is apparently critical here.
> >
> > Tejun, Casey, would the above modification be fine with you?
>
> I *think so*, but I can't say 100% that I really understand the
> entire issue.
>
> >
> > --
> > Ondrej Mosnacek <omosnace at redhat dot com>
> > Associate Software Engineer, Security Technologies
> > Red Hat, Inc.
> >

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
