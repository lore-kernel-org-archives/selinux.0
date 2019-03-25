Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ABEC43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 22:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD17205F4
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 22:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfCYWCw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:02:52 -0400
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:45511 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729664AbfCYWCw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 18:02:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 0B507182CED34;
        Mon, 25 Mar 2019 22:02:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: teeth41_35cd99897ba57
X-Filterd-Recvd-Size: 1924
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 22:02:49 +0000 (UTC)
Message-ID: <8a54298538371340d0a7fe762e742a88e12f43ba.camel@perches.com>
Subject: Re: [PATCH] Bad file pattern in MAINTAINERS section 'SELINUX
 SECURITY MODULE'
From:   Joe Perches <joe@perches.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Date:   Mon, 25 Mar 2019 15:02:48 -0700
In-Reply-To: <a0847fd8-0b9b-69f5-e9b8-1e1cd3b5052d@schaufler-ca.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
         <20190325212756.27603-1-joe@perches.com>
         <a0847fd8-0b9b-69f5-e9b8-1e1cd3b5052d@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2019-03-25 at 14:58 -0700, Casey Schaufler wrote:
> The include/linux/selinux.h file has been removed.
> Remove the entry from the MAINTAINERS file.

This looks like it doesn't apply correctly as there
are one too many spaces before each context lines.

> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e5a5d263f29..1039c34dff3c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13947,7 +13947,6 @@ W:	https://selinuxproject.org
>   W:	https://github.com/SELinuxProject
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
>   S:	Supported
> -F:	include/linux/selinux*
>   F:	security/selinux/
>   F:	scripts/selinux/
>   F:	Documentation/admin-guide/LSM/SELinux.rst
> 

