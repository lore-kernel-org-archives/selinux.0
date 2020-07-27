Return-Path: <SRS0=Yzg2=BG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E0EC433EA
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 16:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17F920719
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 16:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595867362;
	bh=wVYeaaXiXzUaFNPG+whAj3/nPc4VyY++YQ4OxyWyDH0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=KRMFhNKe4KHt7wHae1w85rMqAkWeGBY4gPg8mE2QJmM9KEMgy4yEOGi3uE/Lhxtna
	 qDeC1mQtEgBnLTYJT0nxSXPTN6MZHVTobp5USPa/kU3LEse2Biaj7vfrr4SBDPbfs8
	 UJP+IRf7NRbcj4b6u6/0xhNUOYkw5H0DC1fsvN+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbgG0Q3T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:29:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgG0Q3T (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 27 Jul 2020 12:29:19 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0896A20719;
        Mon, 27 Jul 2020 16:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595867358;
        bh=wVYeaaXiXzUaFNPG+whAj3/nPc4VyY++YQ4OxyWyDH0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ngDbKbTENJLhs/GPlmvy4pP78KGL7NZ38+x8rytOXFcs7gJNeoBT85FCm35m9PKEV
         ulb8jIW+cwa8buMo4M0O/PxoZywEt0e7/CUcvKzuzbGfW/CsAksMuGPZ5V8SMwwEKM
         UiNoFjjyjpgYxMb+QACMp6QjAe06aKn1apn7Klhc=
Message-ID: <1595867355.4841.134.camel@kernel.org>
Subject: Re: [PATCH v3 08/19] fs/kernel_read_file: Remove redundant size
 argument
From:   Mimi Zohar <zohar@kernel.org>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Jul 2020 12:29:15 -0400
In-Reply-To: <20200724213640.389191-9-keescook@chromium.org>
References: <20200724213640.389191-1-keescook@chromium.org>
         <20200724213640.389191-9-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2020-07-24 at 14:36 -0700, Kees Cook wrote:
> In preparation for refactoring kernel_read_file*(), remove the redundant
> "size" argument which is not needed: it can be included in the return
> code, with callers adjusted. (VFS reads already cannot be larger than
> INT_MAX.)
> 
> Acked-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
