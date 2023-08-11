Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB83C0015E
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 10:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbjHKKOX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 06:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjHKKON (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 06:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D156C44AE
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 03:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691748688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cmLDdqxkuZz5bdvC8Qp8jVza1nYwv2S3u1+yYeuExvk=;
        b=JOouWgxfID14INwMLGYNbJZI1CptcJrWsEb46hGQHKrnS3P15klMd+w+cvJhgAORyyHkQ3
        /arsJ4lC70Xn41wqgmnbCa3GEiWUYy7qCY6FMah8dob8n5pD6zW4ue9JSuHuArnDdtVM3I
        2QAEovzOrNn7NwjHhKmQHmc4J7JEP5M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-ajooZs_ZOU-QpVUYdAOjvA-1; Fri, 11 Aug 2023 06:11:24 -0400
X-MC-Unique: ajooZs_ZOU-QpVUYdAOjvA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50A27805951;
        Fri, 11 Aug 2023 10:11:24 +0000 (UTC)
Received: from localhost (unknown [10.45.224.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8EA44A9004;
        Fri, 11 Aug 2023 10:11:23 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH 00/13 v2] Remove the Russian translations
In-Reply-To: <20230809201051.108944-1-jwcart2@gmail.com>
References: <20230809201051.108944-1-jwcart2@gmail.com>
Date:   Fri, 11 Aug 2023 12:11:23 +0200
Message-ID: <87a5uxsxbo.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> The Russian translations have not been maintained and are out of
> date, so remove them.
>
> Patch 9 in the first version was too large, so the only change
> in v2 is to split the removal of the Russian translations in
> the python directory into two patches.

Thanks!

It looks like it's still too big.

But being in CC I received everything so I created github PR with the
original set - https://github.com/SELinuxProject/selinux/pull/405

I'm going to review it and if I'd ack and use the original version I
pushed to github.

Petr





> James Carter (13):
>   checkpolicy: Remove the Russian translations
>   gui: Remove the Russian translations
>   libselinux: Remove the Russian translations
>   libselinux: Remove the Russian translations
>   libsemanage: Remove the Russian translations
>   libsepol: Remove the Russian translations
>   mcstrans: Remove the Russian translations
>   policycoreutils: Remove the Russian translations
>   python: Remove the Russian translations
>   python: Remove the Russian translations
>   restorecond: Remove the Russian translations
>   sandbox: Remove the Russian translations
>   semodule-utils: Remove the Russian translations
>
>  checkpolicy/ru/checkmodule.8                  |  55 -----
>  checkpolicy/ru/checkpolicy.8                  |  60 -----
>  gui/ru/selinux-polgengui.8                    |  35 ---
>  gui/ru/system-config-selinux.8                |  36 ---
>  libselinux/man/ru/man5/customizable_types.5   |  63 -----
>  libselinux/man/ru/man5/default_contexts.5     |  75 ------
>  libselinux/man/ru/man5/default_type.5         |  43 ----
>  libselinux/man/ru/man5/failsafe_context.5     |  68 ------
>  libselinux/man/ru/man5/file_contexts.5        |   1 -
>  .../man/ru/man5/file_contexts.homedirs.5      |   1 -
>  libselinux/man/ru/man5/file_contexts.local.5  |   1 -
>  libselinux/man/ru/man5/file_contexts.subs.5   |   1 -
>  .../man/ru/man5/file_contexts.subs_dist.5     |   1 -
>  libselinux/man/ru/man5/media.5                |   1 -
>  libselinux/man/ru/man5/removable_context.5    |  39 ----
>  libselinux/man/ru/man5/secolor.conf.5         | 180 --------------
>  libselinux/man/ru/man5/securetty_types.5      |  49 ----
>  libselinux/man/ru/man5/selabel_db.5           | 219 -----------------
>  libselinux/man/ru/man5/selabel_file.5         | 219 -----------------
>  libselinux/man/ru/man5/selabel_media.5        |  92 --------
>  libselinux/man/ru/man5/selabel_x.5            | 168 -------------
>  libselinux/man/ru/man5/sepgsql_contexts.5     |   1 -
>  libselinux/man/ru/man5/service_seusers.5      |  71 ------
>  libselinux/man/ru/man5/seusers.5              |  67 ------
>  libselinux/man/ru/man5/user_contexts.5        |  85 -------
>  .../man/ru/man5/virtual_domain_context.5      |  44 ----
>  .../man/ru/man5/virtual_image_context.5       |  46 ----
>  libselinux/man/ru/man5/x_contexts.5           |   1 -
>  libselinux/man/ru/man8/avcstat.8              |  35 ---
>  libselinux/man/ru/man8/booleans.8             |  46 ----
>  libselinux/man/ru/man8/getenforce.8           |  19 --
>  libselinux/man/ru/man8/getsebool.8            |  40 ----
>  libselinux/man/ru/man8/matchpathcon.8         |  62 -----
>  libselinux/man/ru/man8/sefcontext_compile.8   |  70 ------
>  libselinux/man/ru/man8/selinux.8              | 106 ---------
>  libselinux/man/ru/man8/selinuxenabled.8       |  21 --
>  libselinux/man/ru/man8/selinuxexeccon.8       |  28 ---
>  libselinux/man/ru/man8/setenforce.8           |  32 ---
>  libselinux/man/ru/man8/togglesebool.8         |  23 --
>  libsemanage/man/ru/man5/semanage.conf.5       | 117 ----------
>  libsepol/man/ru/man8/chkcon.8                 |  39 ----
>  mcstrans/man/ru/man5/setrans.conf.5           | 106 ---------
>  mcstrans/man/ru/man8/mcs.8                    |  24 --
>  mcstrans/man/ru/man8/mcstransd.8              |  32 ---
>  policycoreutils/load_policy/ru/load_policy.8  |  41 ----
>  policycoreutils/man/ru/man5/selinux_config.5  | 136 -----------
>  policycoreutils/newrole/ru/newrole.1          | 109 ---------
>  policycoreutils/run_init/ru/open_init_pty.8   |  42 ----
>  policycoreutils/run_init/ru/run_init.8        |  26 ---
>  policycoreutils/scripts/ru/fixfiles.8         |  94 --------
>  policycoreutils/secon/ru/secon.1              | 120 ----------
>  policycoreutils/semodule/ru/genhomedircon.8   |  25 --
>  policycoreutils/semodule/ru/semodule.8        | 133 -----------
>  policycoreutils/sestatus/ru/sestatus.8        |  79 -------
>  policycoreutils/sestatus/ru/sestatus.conf.5   |  97 --------
>  policycoreutils/setfiles/ru/restorecon.8      | 193 ---------------
>  .../setfiles/ru/restorecon_xattr.8            | 115 ---------
>  policycoreutils/setfiles/ru/setfiles.8        | 221 ------------------
>  policycoreutils/setsebool/ru/setsebool.8      |  27 ---
>  python/audit2allow/ru/audit2allow.1           | 210 -----------------
>  python/audit2allow/ru/audit2why.1             |   1 -
>  python/chcat/ru/chcat.8                       |  57 -----
>  python/semanage/ru/semanage-boolean.8         |  60 -----
>  python/semanage/ru/semanage-dontaudit.8       |  32 ---
>  python/semanage/ru/semanage-export.8          |  36 ---
>  python/semanage/ru/semanage-fcontext.8        |  84 -------
>  python/semanage/ru/semanage-ibendport.8       |  67 ------
>  python/semanage/ru/semanage-ibpkey.8          |  67 ------
>  python/semanage/ru/semanage-import.8          |  35 ---
>  python/semanage/ru/semanage-interface.8       |  62 -----
>  python/semanage/ru/semanage-login.8           |  67 ------
>  python/semanage/ru/semanage-module.8          |  61 -----
>  python/semanage/ru/semanage-node.8            |  59 -----
>  python/semanage/ru/semanage-permissive.8      |  47 ----
>  python/semanage/ru/semanage-port.8            |  69 ------
>  python/semanage/ru/semanage-user.8            |  70 ------
>  python/semanage/ru/semanage.8                 |  84 -------
>  python/sepolicy/ru/sepolgen.8                 |   1 -
>  python/sepolicy/ru/sepolicy-booleans.8        |  29 ---
>  python/sepolicy/ru/sepolicy-communicate.8     |  40 ----
>  python/sepolicy/ru/sepolicy-generate.8        | 173 --------------
>  python/sepolicy/ru/sepolicy-gui.8             |  29 ---
>  python/sepolicy/ru/sepolicy-interface.8       |  41 ----
>  python/sepolicy/ru/sepolicy-manpage.8         |  38 ---
>  python/sepolicy/ru/sepolicy-network.8         |  90 -------
>  python/sepolicy/ru/sepolicy-transition.8      |  34 ---
>  python/sepolicy/ru/sepolicy.8                 |  77 ------
>  restorecond/ru/restorecond.8                  |  41 ----
>  sandbox/ru/sandbox.5                          |  42 ----
>  sandbox/ru/sandbox.8                          | 100 --------
>  sandbox/ru/seunshare.8                        |  42 ----
>  .../semodule_expand/ru/semodule_expand.8      |  31 ---
>  .../semodule_link/ru/semodule_link.8          |  32 ---
>  .../semodule_package/ru/semodule_package.8    |  48 ----
>  .../semodule_package/ru/semodule_unpackage.8  |  24 --
>  95 files changed, 6060 deletions(-)
>  delete mode 100644 checkpolicy/ru/checkmodule.8
>  delete mode 100644 checkpolicy/ru/checkpolicy.8
>  delete mode 100644 gui/ru/selinux-polgengui.8
>  delete mode 100644 gui/ru/system-config-selinux.8
>  delete mode 100644 libselinux/man/ru/man5/customizable_types.5
>  delete mode 100644 libselinux/man/ru/man5/default_contexts.5
>  delete mode 100644 libselinux/man/ru/man5/default_type.5
>  delete mode 100644 libselinux/man/ru/man5/failsafe_context.5
>  delete mode 100644 libselinux/man/ru/man5/file_contexts.5
>  delete mode 100644 libselinux/man/ru/man5/file_contexts.homedirs.5
>  delete mode 100644 libselinux/man/ru/man5/file_contexts.local.5
>  delete mode 100644 libselinux/man/ru/man5/file_contexts.subs.5
>  delete mode 100644 libselinux/man/ru/man5/file_contexts.subs_dist.5
>  delete mode 100644 libselinux/man/ru/man5/media.5
>  delete mode 100644 libselinux/man/ru/man5/removable_context.5
>  delete mode 100644 libselinux/man/ru/man5/secolor.conf.5
>  delete mode 100644 libselinux/man/ru/man5/securetty_types.5
>  delete mode 100644 libselinux/man/ru/man5/selabel_db.5
>  delete mode 100644 libselinux/man/ru/man5/selabel_file.5
>  delete mode 100644 libselinux/man/ru/man5/selabel_media.5
>  delete mode 100644 libselinux/man/ru/man5/selabel_x.5
>  delete mode 100644 libselinux/man/ru/man5/sepgsql_contexts.5
>  delete mode 100644 libselinux/man/ru/man5/service_seusers.5
>  delete mode 100644 libselinux/man/ru/man5/seusers.5
>  delete mode 100644 libselinux/man/ru/man5/user_contexts.5
>  delete mode 100644 libselinux/man/ru/man5/virtual_domain_context.5
>  delete mode 100644 libselinux/man/ru/man5/virtual_image_context.5
>  delete mode 100644 libselinux/man/ru/man5/x_contexts.5
>  delete mode 100644 libselinux/man/ru/man8/avcstat.8
>  delete mode 100644 libselinux/man/ru/man8/booleans.8
>  delete mode 100644 libselinux/man/ru/man8/getenforce.8
>  delete mode 100644 libselinux/man/ru/man8/getsebool.8
>  delete mode 100644 libselinux/man/ru/man8/matchpathcon.8
>  delete mode 100644 libselinux/man/ru/man8/sefcontext_compile.8
>  delete mode 100644 libselinux/man/ru/man8/selinux.8
>  delete mode 100644 libselinux/man/ru/man8/selinuxenabled.8
>  delete mode 100644 libselinux/man/ru/man8/selinuxexeccon.8
>  delete mode 100644 libselinux/man/ru/man8/setenforce.8
>  delete mode 100644 libselinux/man/ru/man8/togglesebool.8
>  delete mode 100644 libsemanage/man/ru/man5/semanage.conf.5
>  delete mode 100644 libsepol/man/ru/man8/chkcon.8
>  delete mode 100644 mcstrans/man/ru/man5/setrans.conf.5
>  delete mode 100644 mcstrans/man/ru/man8/mcs.8
>  delete mode 100644 mcstrans/man/ru/man8/mcstransd.8
>  delete mode 100644 policycoreutils/load_policy/ru/load_policy.8
>  delete mode 100644 policycoreutils/man/ru/man5/selinux_config.5
>  delete mode 100644 policycoreutils/newrole/ru/newrole.1
>  delete mode 100644 policycoreutils/run_init/ru/open_init_pty.8
>  delete mode 100644 policycoreutils/run_init/ru/run_init.8
>  delete mode 100644 policycoreutils/scripts/ru/fixfiles.8
>  delete mode 100644 policycoreutils/secon/ru/secon.1
>  delete mode 100644 policycoreutils/semodule/ru/genhomedircon.8
>  delete mode 100644 policycoreutils/semodule/ru/semodule.8
>  delete mode 100644 policycoreutils/sestatus/ru/sestatus.8
>  delete mode 100644 policycoreutils/sestatus/ru/sestatus.conf.5
>  delete mode 100644 policycoreutils/setfiles/ru/restorecon.8
>  delete mode 100644 policycoreutils/setfiles/ru/restorecon_xattr.8
>  delete mode 100644 policycoreutils/setfiles/ru/setfiles.8
>  delete mode 100644 policycoreutils/setsebool/ru/setsebool.8
>  delete mode 100644 python/audit2allow/ru/audit2allow.1
>  delete mode 100644 python/audit2allow/ru/audit2why.1
>  delete mode 100644 python/chcat/ru/chcat.8
>  delete mode 100644 python/semanage/ru/semanage-boolean.8
>  delete mode 100644 python/semanage/ru/semanage-dontaudit.8
>  delete mode 100644 python/semanage/ru/semanage-export.8
>  delete mode 100644 python/semanage/ru/semanage-fcontext.8
>  delete mode 100644 python/semanage/ru/semanage-ibendport.8
>  delete mode 100644 python/semanage/ru/semanage-ibpkey.8
>  delete mode 100644 python/semanage/ru/semanage-import.8
>  delete mode 100644 python/semanage/ru/semanage-interface.8
>  delete mode 100644 python/semanage/ru/semanage-login.8
>  delete mode 100644 python/semanage/ru/semanage-module.8
>  delete mode 100644 python/semanage/ru/semanage-node.8
>  delete mode 100644 python/semanage/ru/semanage-permissive.8
>  delete mode 100644 python/semanage/ru/semanage-port.8
>  delete mode 100644 python/semanage/ru/semanage-user.8
>  delete mode 100644 python/semanage/ru/semanage.8
>  delete mode 100644 python/sepolicy/ru/sepolgen.8
>  delete mode 100644 python/sepolicy/ru/sepolicy-booleans.8
>  delete mode 100644 python/sepolicy/ru/sepolicy-communicate.8
>  delete mode 100644 python/sepolicy/ru/sepolicy-generate.8
>  delete mode 100644 python/sepolicy/ru/sepolicy-gui.8
>  delete mode 100644 python/sepolicy/ru/sepolicy-interface.8
>  delete mode 100644 python/sepolicy/ru/sepolicy-manpage.8
>  delete mode 100644 python/sepolicy/ru/sepolicy-network.8
>  delete mode 100644 python/sepolicy/ru/sepolicy-transition.8
>  delete mode 100644 python/sepolicy/ru/sepolicy.8
>  delete mode 100644 restorecond/ru/restorecond.8
>  delete mode 100644 sandbox/ru/sandbox.5
>  delete mode 100644 sandbox/ru/sandbox.8
>  delete mode 100644 sandbox/ru/seunshare.8
>  delete mode 100644 semodule-utils/semodule_expand/ru/semodule_expand.8
>  delete mode 100644 semodule-utils/semodule_link/ru/semodule_link.8
>  delete mode 100644 semodule-utils/semodule_package/ru/semodule_package.8
>  delete mode 100644 semodule-utils/semodule_package/ru/semodule_unpackage.8
>
> -- 
> 2.41.0

