Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A084AC433FE
	for <selinux@archiver.kernel.org>; Mon, 17 Oct 2022 21:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiJQVHS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Oct 2022 17:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiJQVG5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Oct 2022 17:06:57 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD266AA18
        for <selinux@vger.kernel.org>; Mon, 17 Oct 2022 14:06:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id h13so12226747pfr.7
        for <selinux@vger.kernel.org>; Mon, 17 Oct 2022 14:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tCj+31+CXOc+1Zk5BhgDzv3CIwY05w+mZL1CbW88lq0=;
        b=UggvhIAOkET0y9p29VCswutkNxfrbdL7v8nMWt6rh3i7qeFEWvhAFh0YQ0V2wuLvZm
         zt0PX3ludefDV7hCar1xzfodehsqUrSo4QUwgnStKkdy2gHMbWLuouI4dWb3iYqST7cH
         ofjR0VMB1uFUorW42qchW1M6thoGduj8EEluMJ15fpdi4iVeaPqW3ccPOBYHbzdBB65g
         1tSHr7rnrxYjFJtMLfnTy/y7ApBMaL9dtLVVl4wmhCmN0YC9tjN0ZU2IIzQt2XEg9UdE
         lC+pZxtEOkJBQgPYXQD1/wV6hpMEp4B4GvSuvwIt29FXhMCMS79CL2jMDv8/TWVG5P9C
         ZHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCj+31+CXOc+1Zk5BhgDzv3CIwY05w+mZL1CbW88lq0=;
        b=8AfiWcQ/ocO41WaRYh+LwRFECyAui9sPVHU2A+Wdbcq5za1R2bvE7ddk226N+mV1TX
         1OCpOKH6C52q34+NZ9HyWzAPpJXEQyY28ZJujkvE2iaDFN9UaMlSLt01p+70ELe35XeN
         aFi3MvsVAFbh63GJuqoNZNf96pqAzCyviirotb0c5rb5ZNm858YD7brWpmTGse6etjQw
         FnOjWjDTOFRsG6mdAmt/+vMgrsEfCoo+mY1B7uoxaaciX4R6ETLxhY/JGvrDJ5pIvOjO
         nfnJIJ92XWRCcDCgAfv/6bUHdZgUaQDaTs03B4yt0kqFCaIaReVRmxCiE+w+blJsaPGc
         wABA==
X-Gm-Message-State: ACrzQf2E7HIgpPYLRduxLv6rPa1uwbKpTRwmNXAclUswV170T157F/Fh
        X3kv8BG3s2r1Z/ZMMJyTJ80fJREVFW1FfDDkHP8H1E3U4So=
X-Google-Smtp-Source: AMsMyM4nrN1sgX/tC82U+fudSk6s066FSPB4TROaavEc1ekdKGiPqvYw49w2CPL/MtelMzBa9DAh3KyBZWpj6Z3gLy8=
X-Received: by 2002:a65:5688:0:b0:3c2:1015:988e with SMTP id
 v8-20020a655688000000b003c21015988emr12239353pgs.280.1666040816127; Mon, 17
 Oct 2022 14:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221011143623.208283-1-plautrba@redhat.com>
In-Reply-To: <20221011143623.208283-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 17 Oct 2022 17:06:45 -0400
Message-ID: <CAP+JOzScOYaEduuNYRNV_agtr-2=YqKhTLzwZnOE8NqM3TOPzg@mail.gmail.com>
Subject: Re: [PATCH] gui: Fix export file chooser dialog
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 11, 2022 at 10:41 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> It wasn't possible to choose a directory in filechooser dialog using
> double-click - the dialog returned the directory name instead of
> listing the directory.
>
> Fixes:
> Traceback (most recent call last):
>   File "/usr/lib/python3.10/site-packages/sepolicy/gui.py", line 2593, in on_browse_select
>     self.export_config(filename)
>   File "/usr/lib/python3.10/site-packages/sepolicy/gui.py", line 2668, in export_config
>     fd = open(filename, 'w')
> IsADirectoryError: [Errno 21] Is a directory: '/root/Downloads'
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/sepolicy/sepolicy/sepolicy.glade | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/python/sepolicy/sepolicy/sepolicy.glade b/python/sepolicy/sepolicy/sepolicy.glade
> index 52407887fcfc..0724d6c8caa4 100644
> --- a/python/sepolicy/sepolicy/sepolicy.glade
> +++ b/python/sepolicy/sepolicy/sepolicy.glade
> @@ -168,7 +168,6 @@
>        <object class="GtkBox" id="filechooserdialog-vbox1">
>          <property name="can_focus">False</property>
>          <property name="orientation">vertical</property>
> -        <signal name="button-press-event" handler="on_choose_file" swapped="no"/>
>          <child internal-child="action_area">
>            <object class="GtkButtonBox" id="filechooserdialog-action_area1">
>              <property name="can_focus">False</property>
> --
> 2.37.3
>
