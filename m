Return-Path: <SRS0=kXWH=DX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3E9C433DF
	for <selinux@archiver.kernel.org>; Fri, 16 Oct 2020 04:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 407AA20874
	for <selinux@archiver.kernel.org>; Fri, 16 Oct 2020 04:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602824372;
	bh=xGkG4tBhj1yaUEa1ElqvFtPiAJQtTgrIFUX5OvBzXoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XuChnw/uZ8Fo8WR6LPzXPSlufiPlyTHOEmxwL/sMdNa/9r+80AqcZyog/a8xu7Vi0
	 mnbUdY3Eds7I9UNAA7blqw0OzlhJrgFZuB6114nTksQz62fpSi9+XwH1ysK4ps1ni7
	 TW7v1XQjKEKGYxFdvs9XWq9JBbg5E90VsliVlFjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbgJPE7b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Oct 2020 00:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732263AbgJPE7b (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 16 Oct 2020 00:59:31 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97886206D9;
        Fri, 16 Oct 2020 04:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602824371;
        bh=xGkG4tBhj1yaUEa1ElqvFtPiAJQtTgrIFUX5OvBzXoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fu2M0iSZuUsL/By8SLKqIbAUNHSuFrBc1gKdjVsg6c8H5INPFoyT9yW8y3PST7kcF
         skdTjz1Bh4rxh+YcT2C4asoVzLFeDtFjRkCdk+fXnoCYDUbeIWxNpYGVTTDuyOvtVy
         4Z1IHdIldxBfEHC68VnH2rTJUaFuCF7Qs4X2yvgk=
Date:   Fri, 16 Oct 2020 06:59:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     stable@vger.kernel.org, stephen.smalley.work@gmail.com,
        paul@paul-moore.com, selinux@vger.kernel.org, jmorris@namei.org,
        sashal@kernel.org
Subject: Re: [PATCH v5.4 1/3] selinux: Create function for selinuxfs
 directory cleanup
Message-ID: <20201016045927.GA461792@kroah.com>
References: <20201015192956.1797021-1-dburgener@linux.microsoft.com>
 <20201015192956.1797021-2-dburgener@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015192956.1797021-2-dburgener@linux.microsoft.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 15, 2020 at 03:29:54PM -0400, Daniel Burgener wrote:
> Separating the cleanup from the creation will simplify two things in
> future patches in this series.  First, the creation can be made generic,
> to create directories not tied to the selinux_fs_info structure.  Second,
> we will ultimately want to reorder creation and deletion so that the
> deletions aren't performed until the new directory structures have already
> been moved into place.
> 
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
> ---
>  security/selinux/selinuxfs.c | 39 +++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 14 deletions(-)

What is the git commit id of this patch upstream in Linus's tree?

Same for the other 2, we need those ids.

thanks,

gre gk-h
