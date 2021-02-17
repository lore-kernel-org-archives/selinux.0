Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF3DC433E0
	for <selinux@archiver.kernel.org>; Wed, 17 Feb 2021 15:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E0664E2F
	for <selinux@archiver.kernel.org>; Wed, 17 Feb 2021 15:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhBQPaZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Feb 2021 10:30:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233726AbhBQP2F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Feb 2021 10:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613575598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KmvwAsPU5Je8cT+mtLCfRX/G2JDt0fQHE8GOW5FzMl0=;
        b=Qt6gYazKrr+2eYCWw/Ks9C1rMdaZ2hlcCeMq107h7wegBsv2gHzGqTTO8RPcTziEPPP6eW
        8BRkpbrdPUw4Jjs/I/Noczi16xD5qEQ6Y22JDfWp7m7AtN58PeAu8RNXwsDerGVsssPLfn
        4uE/3VAhCJSiG/V7as+qC/LA4o1Y/ks=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-W15FYVi-MC6ci1Entl_PRQ-1; Wed, 17 Feb 2021 10:26:36 -0500
X-MC-Unique: W15FYVi-MC6ci1Entl_PRQ-1
Received: by mail-yb1-f197.google.com with SMTP id x4so18292746ybj.22
        for <selinux@vger.kernel.org>; Wed, 17 Feb 2021 07:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmvwAsPU5Je8cT+mtLCfRX/G2JDt0fQHE8GOW5FzMl0=;
        b=fVZzXoxsej8jlwjAo2XoC5gd/F99syjpB81HSHB+SDnDxuPeMYiZfBBIbnyD9PSz8n
         v6nI6mR9DVCvea632ODFCeLEarg0nGPdwK82+TeYj1sXzHAWTrp8Ngeu4X3WoOQta8m2
         wIB57vde+ehM4N9a9FFqE7Spt/jL9x7DVwp6KU6XXbvQqTafUWM2OH/Z1/d0qXayTRJn
         b9mvVIhlzi/2Evah9ML3Lkhg2x86p2qU5l5mk1A/zfNc+iePpX928Oko2f1+m4XiwO6P
         co1lQ/eZf5xPxwqUWLAgkZcDV03MC7VtXY6wsosHb/Wi+Q5otb5NqzItpgQk1VKi7Zo8
         9rGg==
X-Gm-Message-State: AOAM531Lvx0JnBUarYblrLG9Vho97FIoaFPhWDcpflpQq56t0vMRgtHj
        CpcQolxTpmUkFbygpkyNPftmhzBaJ1GuFnJwgyjrM0gGIWSd6+9DBagZYPWmVFjNBh1WfQddExn
        gTPWsMHdSFqkLfVZ+7I/YHCalgAM5voLzvA==
X-Received: by 2002:a25:2c82:: with SMTP id s124mr9618225ybs.340.1613575595857;
        Wed, 17 Feb 2021 07:26:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwtdEtPLbjbFC9swAnhitJeJ0/zqounkNQIx92ygcEhJSZNMRREbtkPXm1FcZ+VDPR7bLGUc5a21jENyp/Rw1Y=
X-Received: by 2002:a25:2c82:: with SMTP id s124mr9618150ybs.340.1613575595136;
 Wed, 17 Feb 2021 07:26:35 -0800 (PST)
MIME-Version: 1.0
References: <20210216200839.1784987-1-vmojzis@redhat.com>
In-Reply-To: <20210216200839.1784987-1-vmojzis@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 17 Feb 2021 16:26:22 +0100
Message-ID: <CAFqZXNvzeyztWWyTzYMODc7DFPp6kLRu7vm=iavLPdu26hAB0w@mail.gmail.com>
Subject: Re: [PATCH] gui: fix "file type" selection in fcontextPage
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 16, 2021 at 9:11 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> A change in seobject.py file_type_str_to_option made the "file type"
> list not compatible with items in this ComboBox.
> See: 317743bbe2a235a5c68f1066b4153e0726a3118f
>
> Avoid this in the future by populating the ComboBox using keys from
> file_type_str_to_option.
>
> This change disables translations on the file types, but those cause
> other issues (adding file context fails the same way as with 'socket
> file' since the translated strings differ form
> file_type_str_to_option.keys, 'properties' of a file context entry
> shows no file type for the same reason).
>
> Fixes:
>  Traceback (most recent call last):
>   File "/usr/share/system-config-selinux/system-config-selinux.py", line 136, in add
>     self.tabs[self.notebook.get_current_page()].addDialog()
>   File "/usr/share/system-config-selinux/semanagePage.py", line 143, in addDialog
>     if self.add() is False:
>   File "/usr/share/system-config-selinux/fcontextPage.py", line 195, in add
>     (rc, out) = getstatusoutput("semanage fcontext -a -t %s -r %s -f '%s' '%s'" % (type, mls, seobject.file_type_str_to_option[ftype], fspec))
>  KeyError: 'socket file'

Your patch misses the Signed-off-by tag.

> ---
>  gui/fcontextPage.py          |  7 +++++++
>  gui/system-config-selinux.ui | 26 --------------------------
>  2 files changed, 7 insertions(+), 26 deletions(-)
>
> diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
> index 370bbee4..d26aa1b4 100644
> --- a/gui/fcontextPage.py
> +++ b/gui/fcontextPage.py
> @@ -102,6 +102,13 @@ class fcontextPage(semanagePage):
>          self.load()
>          self.fcontextEntry = xml.get_object("fcontextEntry")
>          self.fcontextFileTypeCombo = xml.get_object("fcontextFileTypeCombo")
> +        # Populate file type combo_box
> +        liststore = self.fcontextFileTypeCombo.get_model()
> +        for ftype in seobject.file_type_str_to_option.keys():
> +            iter = liststore.append()
> +            liststore.set_value(iter, 0, ftype)
> +        iter = liststore.get_iter_first()
> +        self.fcontextFileTypeCombo.set_active_iter(iter)
>          self.fcontextTypeEntry = xml.get_object("fcontextTypeEntry")
>          self.fcontextMLSEntry = xml.get_object("fcontextMLSEntry")
>
> diff --git a/gui/system-config-selinux.ui b/gui/system-config-selinux.ui
> index 7cc1cc53..e7b84a64 100644
> --- a/gui/system-config-selinux.ui
> +++ b/gui/system-config-selinux.ui
> @@ -401,32 +401,6 @@ Level</property>
>        <!-- column-name gchararray -->
>        <column type="gchararray"/>
>      </columns>
> -    <data>
> -      <row>
> -        <col id="0" translatable="yes">all files</col>
> -      </row>
> -      <row>
> -        <col id="0" translatable="yes">regular file</col>
> -      </row>
> -      <row>
> -        <col id="0" translatable="yes">directory</col>
> -      </row>
> -      <row>
> -        <col id="0" translatable="yes">character device</col>
> -      </row>
> -      <row>
> -        <col id="0" translatable="yes">block device</col>
> -      </row>
> -      <row>
> -        <col id="0" translatable="yes">socket file</col>
> -      </row>
> -      <row>
> -        <col id="0" translatable="yes">symbolic link</col>
> -      </row>
> -      <row>
> -        <col id="0" translatable="yes">named pipe</col>
> -      </row>
> -    </data>
>    </object>
>    <object class="GtkDialog" id="fcontextDialog">
>      <property name="can_focus">False</property>
> --
> 2.29.2
>

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

