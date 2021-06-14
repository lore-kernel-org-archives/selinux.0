Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF3EC2B9F4
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 21:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C32A61166
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 21:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhFNVaZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:30:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234356AbhFNVaY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Jun 2021 17:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623706101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RYZqV2QcVTGJp+9kQzTUW7d5kpFaSO22gkZ6p67dNno=;
        b=dXiIDk7xJYAOqG1CQcliSg61JL3flWWyL9yRyTgznJ8yt85kVZGcD+2efDX6ouj9qJ6wLF
        f7pQY1QrDoyXLLsjyi4SCneqkgRabmPzO88TB9kPjgZwzPBNnuH6HC6RdHgX/WLvsJOyqa
        68oq3QTa3uT2YifgzMKgUP7USUIwGtE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-tK6Rfjv7NXWei7skeaJShA-1; Mon, 14 Jun 2021 17:28:17 -0400
X-MC-Unique: tK6Rfjv7NXWei7skeaJShA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 368D68015D0;
        Mon, 14 Jun 2021 21:28:16 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-174.rdu2.redhat.com [10.10.114.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71CF960877;
        Mon, 14 Jun 2021 21:28:09 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id DA07F22054F; Mon, 14 Jun 2021 17:28:08 -0400 (EDT)
Date:   Mon, 14 Jun 2021 17:28:08 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel@lists.sourceforge.net, selinux@vger.kernel.org
Subject: Re: [RESEND] [PATCHv4 1/2] uapi: fuse: Add FUSE_SECURITY_CTX
Message-ID: <20210614212808.GD869400@redhat.com>
References: <20200722090758.3221812-1-chirantan@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722090758.3221812-1-chirantan@chromium.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 22, 2020 at 06:07:57PM +0900, Chirantan Ekbote wrote:
> Add the FUSE_SECURITY_CTX flag for the `flags` field of the
> fuse_init_out struct.  When this flag is set the kernel will append the
> security context for a newly created inode to the request (create,
> mkdir, mknod, and symlink).  The server is responsible for ensuring that
> the inode appears atomically with the requested security context.
> 
> For example, if the server is backed by a "real" linux file system then
> it can write the security context value to
> /proc/thread-self/attr/fscreate before making the syscall to create the
> inode.
> 
> Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>

Hi Chirantan,

I am wondering what's the status of this work now. Looks like it
was not merged.

We also need the capability to set selinux security xattrs on newly
created files in virtiofs.  

Will you be interested in reviving this work and send patches again
and copy the selinux as well as linux security module list
(linux-security-module@vger.kernel.org) as suggested by casey.

How are you managing in the meantime. Carrying patches in your own
kernel?

Thanks
Vivek

> ---
> Changes in v4:
>   * Added signoff to commit message.
> 
>  include/uapi/linux/fuse.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 373cada898159..e2099b45fd44b 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -172,6 +172,10 @@
>   *  - add FUSE_WRITE_KILL_PRIV flag
>   *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
>   *  - add map_alignment to fuse_init_out, add FUSE_MAP_ALIGNMENT flag
> + *
> + *  7.32
> + *  - add FUSE_SECURITY_CTX flag for fuse_init_out
> + *  - add security context to create, mkdir, symlink, and mknod requests
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -207,7 +211,7 @@
>  #define FUSE_KERNEL_VERSION 7
>  
>  /** Minor version number of this interface */
> -#define FUSE_KERNEL_MINOR_VERSION 31
> +#define FUSE_KERNEL_MINOR_VERSION 32
>  
>  /** The node ID of the root inode */
>  #define FUSE_ROOT_ID 1
> @@ -314,6 +318,7 @@ struct fuse_file_lock {
>   * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
>   * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
>   * FUSE_MAP_ALIGNMENT: map_alignment field is valid
> + * FUSE_SECURITY_CTX: add security context to create, mkdir, symlink, and mknod
>   */
>  #define FUSE_ASYNC_READ		(1 << 0)
>  #define FUSE_POSIX_LOCKS	(1 << 1)
> @@ -342,6 +347,7 @@ struct fuse_file_lock {
>  #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
>  #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
>  #define FUSE_MAP_ALIGNMENT	(1 << 26)
> +#define FUSE_SECURITY_CTX	(1 << 27)
>  
>  /**
>   * CUSE INIT request/reply flags
> -- 
> 2.27.0.383.g050319c2ae-goog
> 

