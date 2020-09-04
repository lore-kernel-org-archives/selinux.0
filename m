Return-Path: <SRS0=VTMH=CN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F52C43461
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 21:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E132087C
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 21:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="YCw0KBig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgIDVxe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Sep 2020 17:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgIDVxe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Sep 2020 17:53:34 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBABC061245
        for <selinux@vger.kernel.org>; Fri,  4 Sep 2020 14:53:33 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id z22so10439113ejl.7
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2020 14:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jNg27iV6ZItAX1i9WvBcKCyLaUSr/yFZulVErl2OY3Y=;
        b=YCw0KBig7sweI3K40HZD8JXe5aRtqsawVETXZ/i1IF3KKhmrTFG7vZUv9w7blpItO2
         uZdToPiGFORv0xEp7V348rzVbKaVFuifz0SdnPqxzxkKjmg8xZyO1gQLmQUJflPmO4UJ
         PYaJGK4l2wYUEOmzIuUdzPRtjzGD6eRr4saiqXkyseCNumorf6MAS5RG+f3VQiE1GwB/
         bz4ExDER2c1Lwo1vUXcDQBr7J6Y+OzJ35pmpNRiLWviMHWZuk+GIJEUPUP+B4SgVmrb9
         DjYRCJAV3/eYz511kYQrNAL3/+/OWXluzH/1bjhYx45zwjVJJhGQNKgggOgVBpKBUe0X
         XYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jNg27iV6ZItAX1i9WvBcKCyLaUSr/yFZulVErl2OY3Y=;
        b=W/li9GCgr5KFm1JJvWlXp3xnQA3w15TGss7Jt6ZtYADTZg95lb5yUhGSyfWfjYxkdA
         IiRZYMyzesnqgcFaPMkYH7opDmgKumuz2pIL56sm3FAroJbkYLw+S8zc06Wu+AQgTdON
         nIZW+uY0vtmqkcu44n03is4rb08cj7yFGNVFCsl8f4ICTLY+14f6jG8X6TjxwS2iUc1G
         TSAo0So5P8DWGHDrz5OGlwMp72acpVMutFUIQR9KN2bxYJbPoq/nDhDeEbVjeBvaCKus
         jUDhtvNRoQC/0/if7P8g9F8/ivCpGfJ2sL7JEJLr1AxrEZv1OarmherxKhAYz1Fa5ubl
         pZYg==
X-Gm-Message-State: AOAM5319r+XEVkKpUE0puIp+bKez5yd4xOKeSDVKvz0Tug/DF/Ztxv8W
        WtqoJE8iFoh4DuwTkMrvKSiUl8SPQIa+jkxXnHdK
X-Google-Smtp-Source: ABdhPJzOzNTggIkvhW7jMB/WAk/9OaUfUmIFluDsTgrwQTA3qZgrujpGyKOyNmcV1DSfTZmXKw8y8FROdfbmjmY28LE=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr9582131ejn.542.1599256412325;
 Fri, 04 Sep 2020 14:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com>
 <20200826145247.10029-6-casey@schaufler-ca.com> <CAHC9VhSh=r4w_3mZOUwmKN0UxCMxPNGKd=_vr_iGV06rvCNbSA@mail.gmail.com>
 <1eeef766-405f-3800-c0cf-3eb008f9673e@schaufler-ca.com>
In-Reply-To: <1eeef766-405f-3800-c0cf-3eb008f9673e@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 4 Sep 2020 17:53:21 -0400
Message-ID: <CAHC9VhSf8RWUnRPYLR6LLzbn-cvNg8J0wnZGwTOAe=dOqkvd0g@mail.gmail.com>
Subject: Re: [PATCH v20 05/23] net: Prepare UDS for security module stacking
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 4, 2020 at 5:35 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/4/2020 1:08 PM, Paul Moore wrote:
> > On Wed, Aug 26, 2020 at 11:07 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Change the data used in UDS SO_PEERSEC processing from a
> >> secid to a more general struct lsmblob. Update the
> >> security_socket_getpeersec_dgram() interface to use the
> >> lsmblob. There is a small amount of scaffolding code
> >> that will come out when the security_secid_to_secctx()
> >> code is brought in line with the lsmblob.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/security.h |  7 +++++--
> >>  include/net/af_unix.h    |  2 +-
> >>  include/net/scm.h        |  8 +++++---
> >>  net/ipv4/ip_sockglue.c   |  8 +++++---
> >>  net/unix/af_unix.c       |  6 +++---
> >>  security/security.c      | 18 +++++++++++++++---
> >>  6 files changed, 34 insertions(+), 15 deletions(-)
> > ...
> >
> >> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> >> index f42fdddecd41..a86da0cb5ec1 100644
> >> --- a/include/net/af_unix.h
> >> +++ b/include/net/af_unix.h
> >> @@ -36,7 +36,7 @@ struct unix_skb_parms {
> >>         kgid_t                  gid;
> >>         struct scm_fp_list      *fp;            /* Passed files         */
> >>  #ifdef CONFIG_SECURITY_NETWORK
> >> -       u32                     secid;          /* Security ID          */
> >> +       struct lsmblob          lsmblob;        /* Security LSM data    */
> > As mentioned in a previous revision, I remain concerned that this is
> > going to become a problem due to the size limit on unix_skb_parms.  I
> > would need to redo the math to be certain, but if I recall correctly
> > this would limit us to five LSMs assuming both that we don't need to
> > grow the per-LSM size of lsmblob *and* the netdev folks don't decide
> > to add more fields to the unix_skb_parms.
> >
> > I lost track of that earlier discussion so I'm not sure where it ended
> > up, but if there is a viable alternative it might be a good idea to
> > pursue it.
>
> Stephen had concerns about the lifecycle management involved. He also
> pointed out that I had taken a cowards way out when allocations failed.
> That could result in unexpected behavior when an allocation failed.
> Fixing that would have required a major re-write of the currently simple
> UDS attribute code, which I suspect would be as hard a sell to netdev as
> expanding the secid to a lsmblob. I also thought I'd gotten netdev on the
> CC: for this patch, but it looks like I missed it.
>
> I did start on the UDS attribute re-do, and discovered that I was going
> to have to introduce new failure paths, and that it might not be possible
> to maintain compatibility for all cases because of the new possibilities
> of failure.

... and you're hoping to not be responsible for this code by the time
this becomes a limiting issue? ;)

I understand the concerns you mention, they are all valid as far as
I'm concerned, but I think we are going to get burned by this code as
it currently stands.

-- 
paul moore
www.paul-moore.com
