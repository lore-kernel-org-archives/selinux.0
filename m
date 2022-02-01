Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B761CC433F5
	for <selinux@archiver.kernel.org>; Tue,  1 Feb 2022 20:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbiBAUKC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbiBAUKC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Feb 2022 15:10:02 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50672C06173B
        for <selinux@vger.kernel.org>; Tue,  1 Feb 2022 12:10:02 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id s5so57452943ejx.2
        for <selinux@vger.kernel.org>; Tue, 01 Feb 2022 12:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4g0YkbFxUsgyGARhEjvGLbZmJcXGgSBGILpgJ+8TSE=;
        b=3PMWK+R0Ao0r5jyS4drWxik7QeUKSuqROHCNyCVYCvLbpJDzfCgUOP3q0y7WWCedHQ
         k84P62N12Cukok9HRZ77l6P+JhI2ICwqRlryYwtd48XqRHXINIQMGeR8+vP4CTRP9Szx
         0MNDbpy0OPYhjQflMq/meNJtFemo1huEEgZWnjAES9eono85UDK8GbEOCeF7oDQxRLW5
         wvF/Gk3Fm055MBu1sRpcC0MefNeFkJDEu8SpMgBRcremrmrQoMVqDla/IzNs/ySkr7Rj
         HanQ2f7mAI51W7i4SEz81GEgdIjcWrw+tFJ0Se1RcxAKXMR7xZx8Pb1vHGXlDcTcl/9O
         rhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4g0YkbFxUsgyGARhEjvGLbZmJcXGgSBGILpgJ+8TSE=;
        b=OgqpbkcisDSwrq+bAzrIF2CoMCdvMhQLA68X1hPy0/7Kj7LVzkQBOqaRIHyQE69L2D
         PlFwdmcmqv4G+21+g/uXOl4ECN+GCfZ+6HHIsNLkcr8ytLLkn8/aZS0SbX3qc1XAQTUC
         RAgt6UxH9L/kXk/rsWmEZClh6rHmONVCn7hicASJMFsdbo2cSl45YLsKQzzobeeFHm2R
         1eYa+tt/+aq2qlNmR7LMbMnPZsV5AtTN8GfkFQKzY9F2yfwFq29JML7ywLQsxq6zuvZg
         vGh67RC3gaj8yNlIjJIIoXLCa4hWxKc96BDiKx0CwM7togYNPrncNRH1KKO6i9CFeK29
         mUWg==
X-Gm-Message-State: AOAM532HTtdGCyfNE0hRT1BbLcYN7uyF8G3zCRbFCyBv+ktmPIFwcQZ7
        YMN1FaRG76yu1sccOM5zX4tCqi+Fy3YQgoS8lTXw
X-Google-Smtp-Source: ABdhPJwFjOhq4vsP3TIfvt4Ww+39EvmOZwoiTia7b3w5dbYPE154ZQx5w5AX+loab6qPZ/1uPHTSdYZmWjt741l0GYo=
X-Received: by 2002:a17:907:7f91:: with SMTP id qk17mr15459074ejc.29.1643746200682;
 Tue, 01 Feb 2022 12:10:00 -0800 (PST)
MIME-Version: 1.0
References: <20220128202858.96935-1-vbendel@redhat.com> <20220128202858.96935-2-vbendel@redhat.com>
 <CAHC9VhR78VGMPLv1xBRQEqzaPjJa_KvFE8OLmHa6J2pjaG6m1w@mail.gmail.com>
In-Reply-To: <CAHC9VhR78VGMPLv1xBRQEqzaPjJa_KvFE8OLmHa6J2pjaG6m1w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Feb 2022 15:09:49 -0500
Message-ID: <CAHC9VhRkL++m_jkqK+0D2rXc_LMbkH1SSFGmAJiGEeDu6rA-xQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: consistently clear cond_list on error paths
To:     vbendel@redhat.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 1, 2022 at 12:38 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Jan 28, 2022 at 3:29 PM <vbendel@redhat.com> wrote:
> > From: Vratislav Bendel <vbendel@redhat.com>
> >
> > Currently there are two users of policydb->cond_list: cond_read_list()
> > and duplicate_policydb_cond_list(). On their error path one clears
> > ->cond_list to NULL, but the other doesn't.
> > Make the behavior consistent by resetting ->cond_list to NULL in
> > cond_list_destroy(), which is called by both on the error path.
>
> It's also important to see if there are any callers of
> cond_list_destroy() which incorrectly might be making use of
> policydb::cond_list after it has been freed; thankfully that does not
> appear to be the case in any of the call paths I looked at just now.
> As this is more a a style/Right-Thing-To-Do patch and not an immediate
> bugfix I'm going to go and merge this into selinux/next.

After looking at patches 2/3 and 3/3, ignore the last sentence above
and see my comments below :)

> Thanks Vratislav.
>
> > Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
> > ---
> >  security/selinux/ss/conditional.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> > index 2ec6e5cd25d9..1d0e5f326b62 100644
> > --- a/security/selinux/ss/conditional.c
> > +++ b/security/selinux/ss/conditional.c
> > @@ -152,6 +152,7 @@ static void cond_list_destroy(struct policydb *p)
> >         for (i = 0; i < p->cond_list_len; i++)
> >                 cond_node_destroy(&p->cond_list[i]);
> >         kfree(p->cond_list);
> > +       p->cond_list = NULL;

While patch 1/3 may not be a candidate for selinux/stable-5.17 by
itself, patch 2/3 definitely qualifies.  Considering that both patches
are small, easily understood, and the likelihood of a merge conflict
between the two is high, why don't you squash 1/3 and 2/3 together so
we can submit this for selinux/stable-5.17?  In addition, put the two
lines which reset cond_list and cond_list_len together in v2, it's
cleaner that way, example below.  If you don't have time to do that
let me know and I can squash them together and move the
"p->cond_list_len = 0" line (don't worry, I'll preserve your
name/email as the patch author).

  static void cond_list_destroy(...)
  {

    /* ... */

    kfree(p->cond_list);
    p->cond_list = NULL;
    p->cond_list_len = 0;
  }

> >  }
> >
> >  void cond_policydb_destroy(struct policydb *p)
> > @@ -441,7 +442,6 @@ int cond_read_list(struct policydb *p, void *fp)
> >         return 0;
> >  err:
> >         cond_list_destroy(p);
> > -       p->cond_list = NULL;
> >         return rc;
> >  }

-- 
paul-moore.com
