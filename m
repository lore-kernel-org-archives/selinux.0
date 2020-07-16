Return-Path: <SRS0=s7s9=A3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77482C433E1
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 08:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C152067D
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 08:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgGPIwC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:52:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49435 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPIwC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jul 2020 04:52:02 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jvzcE-0002BZ-15; Thu, 16 Jul 2020 08:51:42 +0000
Date:   Thu, 16 Jul 2020 10:51:41 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] proc: allow access in init userns for map_files
 with CAP_CHECKPOINT_RESTORE
Message-ID: <20200716085141.nr4wyeh62ahjwupd@wittgenstein>
References: <20200715144954.1387760-1-areber@redhat.com>
 <20200715144954.1387760-5-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200715144954.1387760-5-areber@redhat.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 15, 2020 at 04:49:52PM +0200, Adrian Reber wrote:
> Opening files in /proc/pid/map_files when the current user is
> CAP_CHECKPOINT_RESTORE capable in the root namespace is useful for
> checkpointing and restoring to recover files that are unreachable via
> the file system such as deleted files, or memfd files.
> 
> Signed-off-by: Adrian Reber <areber@redhat.com>
> Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
> ---
>  fs/proc/base.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 65893686d1f1..cada783f229e 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2194,16 +2194,16 @@ struct map_files_info {
>  };
>  
>  /*
> - * Only allow CAP_SYS_ADMIN to follow the links, due to concerns about how the
> - * symlinks may be used to bypass permissions on ancestor directories in the
> - * path to the file in question.
> + * Only allow CAP_SYS_ADMIN and CAP_CHECKPOINT_RESTORE to follow the links, due
> + * to concerns about how the symlinks may be used to bypass permissions on
> + * ancestor directories in the path to the file in question.
>   */
>  static const char *
>  proc_map_files_get_link(struct dentry *dentry,
>  			struct inode *inode,
>  		        struct delayed_call *done)
>  {
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_CHECKPOINT_RESTORE))

So right now, when I'd do

git grep checkpoint_restore_ns_capable

I'd not hit that codepath which isn't great. So I'd suggest to use:

if (!checkpoint_restore_ns_capable(&init_user_ns))

at the end of the day, capable(<cap>) just calls
ns_capable(&init_user_ns, <cap>) anyway.

Thanks!
Christian
