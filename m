Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3523C433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 14:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526C864F0A
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 14:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCDOqM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 09:46:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232437AbhCDOqJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 09:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614869084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GPdtZigvQ84ftQUmZvnymoQoLZzwheNFbfKTjUoPfho=;
        b=FaPWnDOPq7/ieNsmuui7/lB8d5VHAim/q0ArcVi8uWvQj0pYWrhW03pGt0RwYXPP3zpePq
        TOijbJcaDG8xAYMPSHeE/Pv7J97+8yO6t7AhEJ61n4S2CUYhtRJGYavtOSg0Lvl6q0FIDX
        V03rGYbRS6+UJC8x2U6mPwE8bNvV1zs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-Yca3rjx1NveKpnkrGv4rfA-1; Thu, 04 Mar 2021 09:44:42 -0500
X-MC-Unique: Yca3rjx1NveKpnkrGv4rfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C3DD1009453
        for <selinux@vger.kernel.org>; Thu,  4 Mar 2021 14:44:38 +0000 (UTC)
Received: from localhost (unknown [10.40.196.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE71C19702;
        Thu,  4 Mar 2021 14:44:32 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     Zdenek Pytela <zpytela@redhat.com>
Subject: Re: [PATCH userspace] fixfiles: do not exclude /dev and /run in -C
 mode
In-Reply-To: <20210301171922.321907-1-omosnace@redhat.com>
References: <20210301171922.321907-1-omosnace@redhat.com>
Date:   Thu, 04 Mar 2021 15:44:31 +0100
Message-ID: <871rcv9dww.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:

> I can't think of a good reason why they should be excluded. On the
> contrary, excluding them can cause trouble very easily if some labeling
> rules for these directories change. For example, we changed the label
> for /dev/nvme* from nvme_device_t to fixed_disk_device_t in Fedora
> (updating the allow rules accordingly) and after policy update they
> ended up with an invalid context, causing denials.

I guess that /dev/ is there in order to avoid relabeling tty devices and block
the user from access:

[root@localhost ~]# ls -Z /dev/tty1
user_u:object_r:user_tty_device_t:s0 /dev/tty1

[root@localhost ~]# matchpathcon /dev/tty1
/dev/tty1       system_u:object_r:tty_device_t:s0


> Thus, remove /dev and /run from the excludes. While there, also add
> /root to the basic excludes to match the regex that excludes fc rules
> (that should be effectively no functional change).
>
> I did a sanity check on my system by running `restorecon -nv /dev /run`
> and it didn't report any label differences.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  policycoreutils/scripts/fixfiles | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> index 30dadb4f..6fb12e04 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -162,7 +162,7 @@ newer() {
>  #
>  diff_filecontext() {
>  EXCLUDEDIRS="`exclude_dirs_from_relabelling`"
> -for i in /sys /proc /dev /run /mnt /var/tmp /var/lib/BackupPC /home /tmp /dev; do
> +for i in /sys /proc /mnt /var/tmp /var/lib/BackupPC /home /root /tmp; do
>      [ -e $i ]  && EXCLUDEDIRS="${EXCLUDEDIRS} -e $i";
>  done
>  LogExcluded
> @@ -175,7 +175,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
>  	sed -r -e 's,:s0, ,g' $FC | sort -u | \
>  	/usr/bin/diff -b ${PREFCTEMPFILE} - | \
>  	    grep '^[<>]'|cut -c3-| grep ^/ | \
> -	    egrep -v '(^/home|^/root|^/tmp|^/dev)' |\
> +	    egrep -v '(^/home|^/root|^/tmp)' |\
>  	sed -r -e 's,[[:blank:]].*,,g' \
>  	       -e 's|\(([/[:alnum:]]+)\)\?|{\1,}|g' \
>  	       -e 's|([/[:alnum:]])\?|{\1,}|g' \
> -- 
> 2.29.2

