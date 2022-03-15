Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95271C433F5
	for <selinux@archiver.kernel.org>; Tue, 15 Mar 2022 08:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbiCOItJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Mar 2022 04:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344502AbiCOItI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Mar 2022 04:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCE9563AF
        for <selinux@vger.kernel.org>; Tue, 15 Mar 2022 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647334075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xutDdrlhHADxB9bab+qPVwazKXFfBw4SzSncDJdBK4s=;
        b=TuDF8vBjkRCNIAEvo46eLRSMWafIR5iwHE1H8GJuZt3r0aNPEN2VxHYld44z2DhQeU8uNt
        pM1IKg4rDsTN9ai/ELX5bXF1DBCi9D0HUCFMKM5p0JH52ZIAWmJr5TZxg+J0N6KX1eYoOn
        5tJlIMCp00zjqrHsigQjq6t8xCA7RsQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-O8S7m2vYOi6-jdNfpzXJEA-1; Tue, 15 Mar 2022 04:47:52 -0400
X-MC-Unique: O8S7m2vYOi6-jdNfpzXJEA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9610B801E80;
        Tue, 15 Mar 2022 08:47:51 +0000 (UTC)
Received: from localhost (unknown [10.40.192.239])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41501409B419;
        Tue, 15 Mar 2022 08:47:50 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        SElinux list <selinux@vger.kernel.org>
Cc:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Subject: Re: [PATCH] gui: do not recreate /etc/selinux/config
In-Reply-To: <5b0956dd-ad07-6209-7b68-d0574874876c@rosalinux.ru>
References: <5b0956dd-ad07-6209-7b68-d0574874876c@rosalinux.ru>
Date:   Tue, 15 Mar 2022 09:47:50 +0100
Message-ID: <87mthrtxe1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Mikhail Novosyolov <m.novosyolov@rosalinux.ru> writes:

> /etc/selinux/config.bck was created and then replaced /etc/selinux/config.
> /etc/selinux/config is often read by libselinux from non-root,
> it must have mode 0644, but, when umask is 077, it became not world-readable
> after running system-config-gui.
>
> Overwrite the existing file instead of creating a new one.
>
> Unfortunately, we may get a corrupted file if the GUI is closed when writing it,
> but writing takes only a bit of time, plus we save a backup for manual restoring in such case.
>

I don't think it's a good idea. The final operation needs to be atomic.

If you want to preserve mode and other attributes you can use
shutil.copystat(), what about this:

        fd = open(backup_path, "w")
        ...
        fd.close()
        shutil.copystat(path, backup_path)    


> At Github: https://github.com/SELinuxProject/selinux/pull/345
>
> Signed-off-by: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
> ---
>  gui/statusPage.py | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/gui/statusPage.py b/gui/statusPage.py
> index 766854b1..ded3929d 100644
> --- a/gui/statusPage.py
> +++ b/gui/statusPage.py
> @@ -18,6 +18,7 @@
>  ## Author: Dan Walsh
>  import os
>  import sys
> +import tempfile
>  from gi.repository import Gtk
>  import selinux
>  
> @@ -162,12 +163,20 @@ class statusPage:
>          self.enabled = enabled
>  
>      def write_selinux_config(self, enforcing, type):
> -        path = selinux.selinux_path() + "config"
> -        backup_path = path + ".bck"
> -        fd = open(path)
> -        lines = fd.readlines()
> -        fd.close()
> -        fd = open(backup_path, "w")
> +        selinux_path = selinux.selinux_path()
> +        path = selinux_path + "config"
> +        # Make a backup /etc/selinux/config.*.bck
> +        backup_path = tempfile.mkstemp(prefix="config.", dir=selinux_path, suffix=".bck")[1]
> +        fd1 = open(path, "r")
> +        lines = fd1.readlines()
> +        fd1.close()
> +        fd2 = open(backup_path, "a")
> +        for l in lines:
> +            fd2.write(l)
> +        fd2.close()
> +        # Write to path, not backup_path, to guarantee that file metadata
> +        # (permissions, xattrs, including SELinux labels etc.) is not lost.
> +        fd = open(path, "w")
>          for l in lines:
>              if l.startswith("SELINUX="):
>                  fd.write("SELINUX=%s\n" % enforcing)
> @@ -177,7 +186,9 @@ class statusPage:
>                  continue
>              fd.write(l)
>          fd.close()
> -        os.rename(backup_path, path)
> +        # Here we are sure that we are deleting our backup,
> +        # not another file or directory
> +        os.unlink(backup_path)
>  
>      def read_selinux_config(self):
>          self.initialtype = selinux.selinux_getpolicytype()[1]
> -- 
> 2.31.1

