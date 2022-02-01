Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E46AC433F5
	for <selinux@archiver.kernel.org>; Tue,  1 Feb 2022 17:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241555AbiBARjA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Feb 2022 12:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241539AbiBARi7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Feb 2022 12:38:59 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565DAC06173B
        for <selinux@vger.kernel.org>; Tue,  1 Feb 2022 09:38:59 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id k25so56085423ejp.5
        for <selinux@vger.kernel.org>; Tue, 01 Feb 2022 09:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLyYRDKyhRNUUjbXm2Ujlcp19JICC/SXa1LXJLTz1vw=;
        b=ZHCEMwtbNECxtzlR4xf/pL7JGDS74huc3FBu6TDhhaLQlpYXfhy8Wl6S4qvRdofFBH
         c1ow5y0Ql7aYDXA8zVUXKEK5TMo+/uWsQFzD5B2Lp4mG3IjpN7rEyCknC0AR2yH1gi+I
         BntLiM4zr603lTqg3C7KccWKNXmT4MJcT8rCcWXqSXDZXsmKEwBTor/fvSGz7Ut4Lgtr
         qrUq8s5ofBqtQGCbBWlSeDEsqoLbE+2f2eny597bt8F/d6RndsWTHEWFLk1lE17hGeQq
         qdsHMCNAs7N14vJn78B3HuB81x+mEnpPBi5aotzsg/Y2Q4yso6ZAZCBglikMzUzkeB4X
         pp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLyYRDKyhRNUUjbXm2Ujlcp19JICC/SXa1LXJLTz1vw=;
        b=kkUMzpZTRpgcrWEmQBoUm+XfaE4o4xvik6ZQsueOcIdoau1S52G7e/Y1dihWgGG8JG
         BFTBIbewOuijSYJtZNs3Dn7WkGSIXd1jHApN29PGZmIclrl9M9D34ubTWP6QgJuoo+YZ
         Em0YgAJcgBHTrn3UDJi3z/Ndsb3l/QFBW8dkX5ekICXENray3WWUf1h9KE/zT9cTipMt
         3CNDr0o9CHDt6f5BxQyOkf3hMPIAUoXgdag44OGv3U5QExLxTp0ty/zD35B0C3NVi7t8
         Nw1Yfk+pJAOKXz3mublOUGkbiHra3fOYIqXax0dhH+p7oWh0Q3DbJSyvONQaL64OZy0d
         9Q+Q==
X-Gm-Message-State: AOAM532oOqppZ68ihabExE/bs0jWke27J4Xk1sIvi7lfyj+tSPX5BU+a
        Y9xqRYS26t4j0WQcKzuX6meSDOxWjHQYbnJ4EI/F
X-Google-Smtp-Source: ABdhPJyebN+dpNWSAfMvrBdvpCqX/+HsqwiQrSUCywFNNjsye8fHn+IkPzfiba5z+EpFvSDMghxGQu2DEwyQCm9iToU=
X-Received: by 2002:a17:907:3e1d:: with SMTP id hp29mr21640491ejc.701.1643737137815;
 Tue, 01 Feb 2022 09:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20220128202858.96935-1-vbendel@redhat.com> <20220128202858.96935-2-vbendel@redhat.com>
In-Reply-To: <20220128202858.96935-2-vbendel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Feb 2022 12:38:47 -0500
Message-ID: <CAHC9VhR78VGMPLv1xBRQEqzaPjJa_KvFE8OLmHa6J2pjaG6m1w@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: consistently clear cond_list on error paths
To:     vbendel@redhat.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 28, 2022 at 3:29 PM <vbendel@redhat.com> wrote:
> From: Vratislav Bendel <vbendel@redhat.com>
>
> Currently there are two users of policydb->cond_list: cond_read_list()
> and duplicate_policydb_cond_list(). On their error path one clears
> ->cond_list to NULL, but the other doesn't.
> Make the behavior consistent by resetting ->cond_list to NULL in
> cond_list_destroy(), which is called by both on the error path.

It's also important to see if there are any callers of
cond_list_destroy() which incorrectly might be making use of
policydb::cond_list after it has been freed; thankfully that does not
appear to be the case in any of the call paths I looked at just now.
As this is more a a style/Right-Thing-To-Do patch and not an immediate
bugfix I'm going to go and merge this into selinux/next.

Thanks Vratislav.

> Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
> ---
>  security/selinux/ss/conditional.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 2ec6e5cd25d9..1d0e5f326b62 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -152,6 +152,7 @@ static void cond_list_destroy(struct policydb *p)
>         for (i = 0; i < p->cond_list_len; i++)
>                 cond_node_destroy(&p->cond_list[i]);
>         kfree(p->cond_list);
> +       p->cond_list = NULL;
>  }
>
>  void cond_policydb_destroy(struct policydb *p)
> @@ -441,7 +442,6 @@ int cond_read_list(struct policydb *p, void *fp)
>         return 0;
>  err:
>         cond_list_destroy(p);
> -       p->cond_list = NULL;
>         return rc;
>  }
>
> --
> 2.26.3

-- 
paul-moore.com
