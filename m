Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F10CEB64DD
	for <selinux@archiver.kernel.org>; Tue,  1 Aug 2023 07:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjHAHlJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Aug 2023 03:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjHAHlI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Aug 2023 03:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39561BCC
        for <selinux@vger.kernel.org>; Tue,  1 Aug 2023 00:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690875621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qvbtYEp1HxpsHQNgIHXrZn0VQQpMVa7blhd6sCw+EBw=;
        b=GQi5ffDS3MmGp009/ay9dJnrNfv0lXNM63WhW0iWd66RB9xbvnufTLL3K2cJ0JMQZyHAso
        61q0CPN8LIOvuI9RTjNPM3VE1qfiYlz5fk3gZgSyR/T5rOeROcE2mRg5FUyO7NG3pHJWDj
        mRYj/dB5vKCPv5XfYx/Q6daN5KtvN84=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-aG6KYNUHP4-sJj6b4xVNuw-1; Tue, 01 Aug 2023 03:40:17 -0400
X-MC-Unique: aG6KYNUHP4-sJj6b4xVNuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3593A1C34088;
        Tue,  1 Aug 2023 07:40:17 +0000 (UTC)
Received: from localhost (unknown [10.45.224.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB2DC1121325;
        Tue,  1 Aug 2023 07:40:16 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     Ian Pilcher <arequipeno@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: File context rule for file in /run not working
In-Reply-To: <e957f5f5-fc75-ed17-7f6d-9db44d3287a5@gmail.com>
References: <e957f5f5-fc75-ed17-7f6d-9db44d3287a5@gmail.com>
Date:   Tue, 01 Aug 2023 09:40:16 +0200
Message-ID: <87il9zxlb3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ian Pilcher <arequipeno@gmail.com> writes:

> # semanage fcontext -l | grep /run/acg
> /run/acg-httpd-reload    all files    system_u:object_r:acg_var_run_t:s0
>
> # ls -Z /run/acg-httpd-reload
> system_u:object_r:var_run_t:s0 /run/acg-httpd-reload
>
> # restorecon /run/acg-httpd-reload
>
> # ls -Z /run/acg-httpd-reload
> system_u:object_r:var_run_t:s0 /run/acg-httpd-reload
>
> What in the world am I doing wrong?
>
> (This rule is part of a policy module, and all of the other rules in the
> module work just fine.)
>

In Fedora there's an equal rule which substitutes /run to /var/run
before a label is generated:

   # semanage fcontext -l
   ...
   SELinux Distribution fcontext Equivalence 

   /run = /var/run

.i.e you need to specify fc rule using /var/run/... SPEC as /run/...
SPEC is overridden by the equal rule:

    # echo '(filecon "/run/myrpmvarrunt" file (system_u object_r rpm_var_run_t ((s0) (s0))))' > myrpmvarrunt.cil
    # semodule -i myrpmvarrunt.cil 
    # selabel_lookup -b file -k /run/myrpmvarrunt
    Default context: system_u:object_r:var_run_t:s0

    # echo '(filecon "/var/run/myrpmvarrunt" file (system_u object_r rpm_var_run_t ((s0) (s0))))' > myrpmvarrunt.cil
    # semodule -i myrpmvarrunt.cil 
    # selabel_lookup -b file -k /run/myrpmvarrunt
    Default context: system_u:object_r:rpm_var_run_t:s0

