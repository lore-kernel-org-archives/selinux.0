Return-Path: <SRS0=3kls=PW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4C6C43387
	for <selinux@archiver.kernel.org>; Mon, 14 Jan 2019 08:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA2020659
	for <selinux@archiver.kernel.org>; Mon, 14 Jan 2019 08:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfANImQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:42:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58811 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbfANImQ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 14 Jan 2019 03:42:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C5A313AA1;
        Mon, 14 Jan 2019 08:42:16 +0000 (UTC)
Received: from workstation (ovpn-204-251.brq.redhat.com [10.40.204.251])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FD88608D9;
        Mon, 14 Jan 2019 08:42:15 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 1/1] python/sepolicy: initialize mislabeled_files in __init__()
References: <20190113174425.27403-1-nicolas.iooss@m4x.org>
Date:   Mon, 14 Jan 2019 09:42:12 +0100
In-Reply-To: <20190113174425.27403-1-nicolas.iooss@m4x.org> (Nicolas Iooss's
        message of "Sun, 13 Jan 2019 18:44:25 +0100")
Message-ID: <pjdfttvfx5n.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 14 Jan 2019 08:42:16 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> Using "sepolicy gui" sometimes leads to an exception when entering the
> Files tab:
>
>     Traceback (most recent call last):
>       File "python/sepolicy/sepolicy/gui.py", line 1345, in tab_change
>         self.show_mislabeled_files_only.set_visible(self.mislabeled_files)
>     AttributeError: 'SELinuxGui' object has no attribute 'mislabeled_files'
>
> Indeed, when application_selected() calls show_applications_page(), this
> function calls tab_change(), which can use mislabeled_files in this
> line:
>
>     self.show_mislabeled_files_only.set_visible(self.mislabeled_files)
>
> Make sure that mislabeled_files is initialized by defining it in
> __init__(), in order to fix this error. Its value will be properly set
> later, by calling several initializers, which is why the original
> assignment to False is kept in:
>
>     self.mislabeled_files = False
>     self.executable_files_initialize(app)
>     self.network_initialize(app)
>     self.writable_files_initialize(app)
>     self.transitions_into_initialize(app)
>     self.transitions_from_initialize(app)
>     self.application_files_initialize(app)
>     self.transitions_files_initialize(app)
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

> ---
>  python/sepolicy/sepolicy/gui.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
> index 9d413652f2ed..fde233ad98b1 100644
> --- a/python/sepolicy/sepolicy/gui.py
> +++ b/python/sepolicy/sepolicy/gui.py
> @@ -149,6 +149,7 @@ class SELinuxGui():
>          self.clear_entry = True
>          self.files_add = False
>          self.network_add = False
> +        self.mislabeled_files = False
>  
>          self.all_domains = []
>          self.installed_list = []
