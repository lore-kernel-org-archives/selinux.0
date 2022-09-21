Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8871BC6FA82
	for <selinux@archiver.kernel.org>; Wed, 21 Sep 2022 18:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiIUSgL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiIUSgE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Sep 2022 14:36:04 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BC6A3D00
        for <selinux@vger.kernel.org>; Wed, 21 Sep 2022 11:36:02 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t8-20020a9d5908000000b0063b41908168so4540434oth.8
        for <selinux@vger.kernel.org>; Wed, 21 Sep 2022 11:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=uOte57h0/R5GwB8WVgpayc4RYGm9J9o9urzAuX2++sQ=;
        b=FCYVGT/8Ki90d4QJMaa1euifNY9zxwu1LnQf5JoFN8CYJOrEkufl9nVdHcaJT9nk04
         w1oDfWUSsH2ityz5juMRkxessuMhZrKtCbxRzrv/cDnSUtjtvarkOFLKxKTulHsHm9u5
         0JU49tohyyg7PyPvCbw897SZwUgeJiZI6gs5OKvEYiX2MSUAecNMEuPvSnOhN1QsY7Wh
         pLt7KADnd20688t72qRyvk80sNeso/JzxSFWragV1F7sPayd/F2v0Q+Q7R97uv3BXdUw
         UGuk+gELuiHj6t7kfy8PVTejaOLa6XeCRkfvRFFtjrS19dH3rzfl3O00XMaXdmfS0H65
         Z6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uOte57h0/R5GwB8WVgpayc4RYGm9J9o9urzAuX2++sQ=;
        b=xl5//RSMJsNQMqYnUaw413AAJ5cjUNi2lJ4GOWGZ3bPNgd8jqGubIPcgmIgwLr3OBV
         +4cjv889y0DsfnJZFlnHVmUODwLD3RlkpAu7OCPDLuo1kRBQuQ53hLRlxvKGmgj4b9Va
         u+kJn8YVdGEe3LDCgA+h8CrcYwK+68yuOyqAfbrSGLCjICIUszWuKVM0KDP0wPbsRdBi
         JFLV1l2mkJD8CezlGXNzK7T5Sj9snhDqJ9ybHde75J3rRk0K+c+ZZFapW8ddOc14yrPp
         kiy46k5Wzduke0ANpvCUJxWkBb6iI/cR4CvHHZn9YExC4r2MK8da+4c/TGjUAUmqnAgf
         NTeg==
X-Gm-Message-State: ACrzQf1jh7N/mz9qQrlGRndML8Sg9vl4ZE+bgJcPTLgURiaSoCMTu6H1
        08BhXVMCTdtU7mkBkF23h00MjV9W7AtrE13vvPCYmN/jHA==
X-Google-Smtp-Source: AMsMyM53Xc9VFT1NwWlpzPu2aav1HOyWUah62dZ5ccN33zK7sDCkQdi63JZTe5yI8PkFujTKpZ20Ac5Wtu+/U3zGBTA=
X-Received: by 2002:a9d:1b70:0:b0:658:cfeb:d221 with SMTP id
 l103-20020a9d1b70000000b00658cfebd221mr12811911otl.34.1663785361312; Wed, 21
 Sep 2022 11:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <166369781344.135827.4622868911878878010.stgit@olly>
In-Reply-To: <166369781344.135827.4622868911878878010.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 21 Sep 2022 14:35:50 -0400
Message-ID: <CAHC9VhTi6qMDZs+w2BQMiViTau_UaXfbQBEx1Prh9aXfNSuO_g@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove runtime disable message in the
 install_policy.sh script
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 20, 2022 at 2:16 PM Paul Moore <paul@paul-moore.com> wrote:
>
> We are in the process of deprecating the runtime disable mechanism,
> let's not reference it in the scripts.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  scripts/selinux/install_policy.sh |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Merged into selinux/next.

-- 
paul-moore.com
