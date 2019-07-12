Return-Path: <SRS0=P1AD=VJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135F5C742D2
	for <selinux@archiver.kernel.org>; Fri, 12 Jul 2019 17:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B77204FD
	for <selinux@archiver.kernel.org>; Fri, 12 Jul 2019 17:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfGLRub (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:50:31 -0400
Received: from namei.org ([65.99.196.166]:34888 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfGLRub (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 12 Jul 2019 13:50:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x6CHoFS1002647;
        Fri, 12 Jul 2019 17:50:15 GMT
Date:   Sat, 13 Jul 2019 03:50:15 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Nicholas Franck <nhfran2@tycho.nsa.gov>
cc:     paul@paul-moore.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, luto@amacapital.net,
        sds@tycho.nsa.gov, keescook@chromium.org, serge@hallyn.com,
        john.johansen@canonical.com, casey@schaufler-ca.com,
        mortonm@chromium.org
Subject: Re: [RFC PATCH] security,capability: pass object information to
 security_capable
In-Reply-To: <20190712173404.14417-1-nhfran2@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.21.1907130347010.1509@namei.org>
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 12 Jul 2019, Nicholas Franck wrote:

> +	case LSM_AUDIT_DATA_CAP: {
> +		const struct inode *inode;
> +
> +		if (a->u.cap_struct.cad) {
> +			switch (a->u.cap_struct.cad->type) {
> +			case CAP_AUX_DATA_INODE: {
> +				inode = a->u.cap_struct.cad->u.inode;
> +
> +				audit_log_format(ab, " dev=");
> +				audit_log_untrustedstring(ab,
> +					inode->i_sb->s_id);
> +				audit_log_format(ab, " ino=%lu",
> +					inode->i_ino);
> +				break;
> +			}
> +			}
> +		}
> +		audit_log_format(ab, " capability=%d ", a->u.cap_struct.cap);
>  		break;

Will this break any existing userspace log parsers?


-- 
James Morris
<jmorris@namei.org>

