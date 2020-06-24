Return-Path: <SRS0=RPjD=AF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF27C433DF
	for <selinux@archiver.kernel.org>; Wed, 24 Jun 2020 07:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F1D206FA
	for <selinux@archiver.kernel.org>; Wed, 24 Jun 2020 07:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389988AbgFXHzU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:55:20 -0400
Received: from verein.lst.de ([213.95.11.211]:43252 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388655AbgFXHzU (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 24 Jun 2020 03:55:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 51CF468B02; Wed, 24 Jun 2020 09:55:16 +0200 (CEST)
Date:   Wed, 24 Jun 2020 09:55:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Jessica Yu <jeyu@kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v3 1/1] fs: move kernel_read_file* to its own include
 file
Message-ID: <20200624075516.GA20553@lst.de>
References: <20200617161218.18487-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617161218.18487-1-scott.branden@broadcom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
