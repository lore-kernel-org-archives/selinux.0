Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9BCC10DCE
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 00:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1834B206EB
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 00:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="kVqb8hwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCMAwj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:52:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43439 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCMAwj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Mar 2020 20:52:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id dc19so9812044edb.10
        for <selinux@vger.kernel.org>; Thu, 12 Mar 2020 17:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4AZlOrFy4byWTZzMS1WHXIrme5I1odQQb7ibcPzE6mg=;
        b=kVqb8hwzgLKyly9G+PRza6zlMumpYtH9+A6Gud4cCi5PJ1f+Oc9rWCI1DDW5wwRC+V
         sOeOPrpa05WOYlTLAUxwGciW9mGa3k3aCGeH/lWPmvdZCG0YADa4iKB1OaogvqIDyMJh
         vuPtuGHWpK7ydaceVlrBF8HjiJk8HPCzls9NugYdLo+Ccyrw78vg8wZLC2fxnMLOrWCS
         h5rd2WbLpjkF8uB57a57Cx1btSlLy7V6/LD/i0Oc+u4v6LD0RwpItPULgUM0pJDjdwe+
         5EhY1GfYVrwF1QCqEqTF1kO8eU05XusOXi0tGSeNXKu9UzaBeOXe/dtXgemmQTSVxLIR
         RE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4AZlOrFy4byWTZzMS1WHXIrme5I1odQQb7ibcPzE6mg=;
        b=jZVr/WsYJc/bKDOyngfyjUTlg36LeX4epOMgZQBjYickDqfdJ49sBQsbW7gdAEL3E8
         +oNthD1uwNJAvNBCtwoT33y8hEMqCwHH1ulrcGxV76EiKAabqJ5GFgdC/+favk3Fp5tz
         sQ8HZ9YfQVb3AB++E6qkRVkBXcePiAyxK0uZzzXRQJIAgfkJMhUbX189pVplh2MwiNOL
         9lyvW2TGXubB2hZNRjjmofW/vTNGxhfr3FmRcY49JVGyW6Hxayv69g+hc8dNB290PrwL
         OzTym1jNdpKS+uYPQugDUtitfFZnGxUoQRGQrRRWFlwCW9WT2ysrdVTsyDvP0RBmsEqB
         nA6A==
X-Gm-Message-State: ANhLgQ0hbPuKmNkNqZBKO0dIRe1PPGs86Mw9H0fl3x5IZpWElayuZcTd
        W8UACD/RJO3B5hMLCE0bKIvAUVHeJDhhPyC1ZNKF
X-Google-Smtp-Source: ADFU+vshBckhrvqXOB4t5WgoOQZI63V8dX2hUl+GFQc0kBcMIE37dtPJyBJWKDW1csn7jQpJDijl9q7P3JVdlg7sMzA=
X-Received: by 2002:a17:906:cb93:: with SMTP id mf19mr202988ejb.272.1584060757719;
 Thu, 12 Mar 2020 17:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200303225837.1557210-1-smayhew@redhat.com> <CAEjxPJ4JJDSn+BEb_BD+Lffd9MbEt9Yr6AOyTk5m7FONcZSdLg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4JJDSn+BEb_BD+Lffd9MbEt9Yr6AOyTk5m7FONcZSdLg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Mar 2020 20:52:26 -0400
Message-ID: <CAHC9VhThqgv_QzCyeVYkBASVmNg2qZGxHwcxXL7KN84kR7+XUQ@mail.gmail.com>
Subject: Re: [PATCH] NFS: Ensure security label is set for root inode
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Scott Mayhew <smayhew@redhat.com>, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com,
        Richard Haines <richard_c_haines@btinternet.com>,
        bfields@fieldses.org, Stephen Smalley <sds@tycho.nsa.gov>,
        linux-nfs@vger.kernel.org, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 10, 2020 at 11:53 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Mar 3, 2020 at 5:59 PM Scott Mayhew <smayhew@redhat.com> wrote:
> >
> > When using NFSv4.2, the security label for the root inode should be set
> > via a call to nfs_setsecurity() during the mount process, otherwise the
> > inode will appear as unlabeled for up to acdirmin seconds.  Currently
> > the label for the root inode is allocated, retrieved, and freed entirely
> > witin nfs4_proc_get_root().
> >
> > Add a field for the label to the nfs_fattr struct, and allocate & free
> > the label in nfs_get_root(), where we also add a call to
> > nfs_setsecurity().  Note that for the call to nfs_setsecurity() to
> > succeed, it's necessary to also move the logic calling
> > security_sb_{set,clone}_security() from nfs_get_tree_common() down into
> > nfs_get_root()... otherwise the SBLABEL_MNT flag will not be set in the
> > super_block's security flags and nfs_setsecurity() will silently fail.
> >
> > Reported-by: Richard Haines <richard_c_haines@btinternet.com>
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Tested-by: Stephen Smalley <sds@tycho.nsa.gov>

This all looks reasonable to me so I've merged it into selinux/next
(with some minor line width fixes); I was hoping some of the NFS guys
would lend an ACK but it has been well over a week with no objections
so I figure it is fair game.

Thanks for the patch, testing, and review everyone!

-- 
paul moore
www.paul-moore.com
