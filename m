Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04622C433E1
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 03:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93A220829
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 03:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="g7Yp63tC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgG1DM4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jul 2020 23:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgG1DM4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jul 2020 23:12:56 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CEDC061794
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 20:12:54 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id v22so2891347edy.0
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 20:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lk9KtKM5l6YtY78vmqUYE4hlB7HC8y9WEzTmTN2pkoY=;
        b=g7Yp63tCIUSB5raZmq3kPod99EqaBbprbPkndjUWuDXNbhHTZTJjSbTfG9irsTACtO
         g9Y3VuH6iQ8hF0ypuRl0lTVEY+Sb8dF9ZMC0N60qqJtoSMYh/igws8x6PJR+UWRVqlwW
         1a0HFXBzMjec/Xt4CbVP3fDK0gjGpTMhZmu2bWf1IhPnFYjo/PNMjz6mXTnlYJEdSecw
         T4d9iFq4/1cQjN6TRnKZLbCZ4LELlBVJG50QUQBHmOS1FDYkWVmWSIr86AIY3pCMlBuY
         WErYt9IbFAGIOP3C2CB9rV47PaqMydp+jk7Aog/jtdH91hwrp6NknJYtd/sjSj8whtxA
         CjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lk9KtKM5l6YtY78vmqUYE4hlB7HC8y9WEzTmTN2pkoY=;
        b=lqcIxowZOnRiP481JLU0EmS4lljFqepA5XcV1ACxgn8gnT+SQD+Vs4GidoPIYRkVWp
         4nnqlgajty20yMfvet/2wsLS0ssxzSFz1++Bx/m242AZL/YmdGXqPUP8GAo17bsbIA/G
         fWCR5q+/hF3ezqO0FqDKfXF8XrobzHk1ADGnXwvpN8JpdCP5kRqP5DRzNRSEMLKWykEh
         8jyPfrmWYVdDaTyOv6kdxIQGvnuFWea8S5F64t15ZY1Vhx5TTwKPdmuRGQVzeVJnC7PC
         +HHvDwONKspxzuwajumE/ljBYGonhrEBAud2NMFUzEZYVsgXFGWpKynCHXhxfThnvLZr
         CjmA==
X-Gm-Message-State: AOAM530zSKQjVEEAFUZFA7zBKph/Y4mDyNESlclCDcI9pPJGrEx6oqCk
        CmqOJDPqGdQEModOMWP/OT6Fqr5kPEffJY/Lahme
X-Google-Smtp-Source: ABdhPJy41B4VrKp6HVdpZsZE4hJ0W9V3TjaMaI5MRdHoT8Mgihf24L9rzOyjeULNLIVJuzK1tbvrtPFXhuNdEB8wGUQ=
X-Received: by 2002:a50:93c5:: with SMTP id o63mr15922891eda.31.1595905973058;
 Mon, 27 Jul 2020 20:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200727130428.8234-1-toiwoton@gmail.com> <ypjlwo2pm56q.fsf@defensec.nl>
 <100b1c8c-a756-c6e5-5514-a8a9dc6fc117@gmail.com> <ypjlsgddm0gv.fsf@defensec.nl>
 <5ec03092-decb-d861-aeb3-800bc4ff0574@gmail.com> <ypjlo8o0n1a5.fsf@defensec.nl>
 <b1719aa3-1d5b-4f62-67f5-c7a207f11c0a@gmail.com>
In-Reply-To: <b1719aa3-1d5b-4f62-67f5-c7a207f11c0a@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Jul 2020 23:12:41 -0400
Message-ID: <CAHC9VhQTs6MSr_tBx3oL2oxAgwY98CgnhW68vdSgiA19iJKvUQ@mail.gmail.com>
Subject: Re: [PATCH v2] Improve network_support.md
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 27, 2020 at 5:44 PM Topi Miettinen <toiwoton@gmail.com> wrote:
> MLS is not very interesting for users in general and so neither will be
> CIPSO/CALIPSO. Maybe labeled IPSec could be useful in some controlled
> corporate environments where all parties are relatively trusted.

Don't forget that in most cases when you see "MLS" in the context of
SELinux, you should think "MLS" or "MCS".  While MLS may have limited
interest outside of a few specific types of users, MCS is what
underpins SELinux's virtualization and container security for most
users.

-- 
paul moore
www.paul-moore.com
