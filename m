Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1D5C433FE
	for <selinux@archiver.kernel.org>; Fri, 30 Sep 2022 14:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiI3OjL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Sep 2022 10:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiI3OjJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Sep 2022 10:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F251A31216
        for <selinux@vger.kernel.org>; Fri, 30 Sep 2022 07:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664548748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=YLaClgGBTE4lHAq2JW4KIgdg44bp/kRv8CJRIv1VyRE=;
        b=XKyMdGjcpz9ghmwqUSgwtzLOsDPPwEiu2kqmZlgwEiQhGyjX7JH65Y6XXMcIRyUYvDHcH9
        VjIKuUEpLDwpRGQFOnUiirSOxDqg5K/nLddZk0vyCYWHh9A2nI4N8TXcxXrslDGzpxCQQD
        X5bHPhR84xSf9lvbrZkP03cDFqyY50o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-Gv0Ik8iuN-2Vk804mmcdUw-1; Fri, 30 Sep 2022 10:39:06 -0400
X-MC-Unique: Gv0Ik8iuN-2Vk804mmcdUw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B36E802801
        for <selinux@vger.kernel.org>; Fri, 30 Sep 2022 14:39:06 +0000 (UTC)
Received: from localhost (unknown [10.40.193.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F628492B04;
        Fri, 30 Sep 2022 14:39:06 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org, Milos Malik <mmalik@redhat.com>
Subject: bug report: semodule doesn't reject policices with duplicate fc's
Date:   Fri, 30 Sep 2022 16:39:03 +0200
Message-ID: <87y1u1rkoo.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

I've got a bug report from Milos Malik <mmalik@redhat.com> that the
current semodule does not reject policies with duplicate fc entries.

[root@fedora selinux]# semanage fcontext -l | grep '/var/run/passenger'
/var/run/passenger(/.*)?                           all files     system_u:object_r:passenger_var_run_t:s0

[root@fedora selinux]# cat mypolicy.fc 
/var/run/passenger(/.*)?        system_u:object_r:mail_home_rw_t:s0

...

[root@fedora selinux]# semodule -i mypolicy.pp
[root@fedora selinux]# 

Using -v, semodule rejects the policy as expected:

[root@fedora selinux]# semodule -v -i mypolicy.pp
Attempting to install module 'mypolicy.pp':
Ok: return value of 0.
Committing changes:
Found conflicting filecon rules
  at /var/lib/selinux/targeted/tmp/modules/400/mypolicy/cil:3
  at /var/lib/selinux/targeted/tmp/modules/100/passenger/cil:343
Problems processing filecon rules
Failed post db handling
Post process failed
semodule:  Failed!


I've bisected the problem to the commit
bc26ddc59c8dc76aefb841166f6e18672fb88adc ("libsepol/cil: Limit the
amount of reporting for context rule conflicts")

Before this commit semodule rejects duplicate fc's with/without -v:

[root@fedora selinux]# semodule -i mypolicy.pp
Problems processing filecon rules
Failed post db handling
Post process failed
semodule:  Failed!

[root@fedora selinux]# semodule -v -i mypolicy.pp
Attempting to install module 'mypolicy.pp':
Ok: return value of 0.
Committing changes:
Found conflicting filecon rules
  at /var/lib/selinux/targeted/tmp/modules/100/passenger/cil:343
  at /var/lib/selinux/targeted/tmp/modules/400/mypolicy/cil:3
Problems processing filecon rules
Failed post db handling
Post process failed
semodule:  Failed!



Petr

