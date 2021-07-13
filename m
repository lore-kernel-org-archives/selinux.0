Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEF7C07E9A
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 02:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E37611F1
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 02:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhGMCZp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 22:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhGMCZo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jul 2021 22:25:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1C6C0613DD
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 19:22:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ga14so23529524ejc.6
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 19:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cq6im7c3WIg4fqNdcFRsI1EWbCtH+pfoQoKcbCM6LGA=;
        b=fm0pagTrnWzN3JeqiPR6bp2+uIZOfssHe470faTkgFfGPn9pyPVTrXwsI3aO8lQPlt
         Me/9+H9C6ZUe7jcvHB85o6DIqbEbVBF2rfFnoThoJXyTG1BC01AcuesXHQAv+5aYYf3y
         CwvWPJX1Rerqgj0VOyGJhjPKyzTkqiY7E6fZZgxSmRAngDMY4wRJXSa97tb38rYyyse3
         wPqDPptgETQcQ7L7YnIGxP9uAm41jMJT6I7XtnaCmPpO0FSZj/g5+a8bEq8d8PvQX6fF
         9fP8W7P3wOx94ShGbLzlS5/xdDGvVNGDHGDrgqLJZHn6g7qzROh/8oEK+NsZ7ebRvSbO
         Ze7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cq6im7c3WIg4fqNdcFRsI1EWbCtH+pfoQoKcbCM6LGA=;
        b=I7Sz4gcsNcASPrjTnPkJcouHdfBDBCy27shVN34YI/L53rdtjcUBK4kGQLUTreI2lM
         /MGo7M0Z8tnzIMoagqfN+7bKgUh/YDooKbjCL+21GiRmGaCCIp51QOkqlZH0LSVvw0GB
         rCrXpQunJaODIyaJ6iDB1GODXVYNdH3M+psBKLWBZId62SyYfBaub4TqATG5UPsXtKxq
         E1MUF6+ow8pF+pNnJh2pcqQeh4DeS4CexcSscmjaTZrxS/TAjnS6lJ3UCAvYGm21qMZU
         mqMcT7wf3HKXzzTt6zIyuru4AYBzkcXPhD+fETg6VTnfH1iji03DUXX/Zb9SNz3Ht4d8
         uCfQ==
X-Gm-Message-State: AOAM533fs19TT00ilIKDzFgWA8cRY8PIrm1qKsMwDWOwyAyLV9Axy7Ix
        8loU3SZrJmnXw1KgB54Z/V8yJZWRSgrtyGzqwyB2
X-Google-Smtp-Source: ABdhPJxkTYQ+aBP9HR+N8HdPsG1D5xUHPWka2s65PnUtscrmKvTdzBT7htu7inRiDpWVzCC1AJIVXPRnSXesJld2eDM=
X-Received: by 2002:a17:906:a202:: with SMTP id r2mr991530ejy.398.1626142974064;
 Mon, 12 Jul 2021 19:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210627202859.5124-1-toiwoton@gmail.com>
In-Reply-To: <20210627202859.5124-1-toiwoton@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Jul 2021 22:22:43 -0400
Message-ID: <CAHC9VhQ3ENTqxVRQnx7MP2==Dty+yuCDikaibeQw4MUCd4uw7g@mail.gmail.com>
Subject: Re: [PATCH v2] selinux-notebook: describe nosuid and NNP transitions
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jun 27, 2021 at 4:29 PM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> Describe cases where nosuid_transition or nnp_transition are needed.
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>  src/computing_security_contexts.md | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Merged with some minor typo fixes - thanks for your help and patience Topi!

-- 
paul moore
www.paul-moore.com
