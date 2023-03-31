Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95ACC6FD18
	for <selinux@archiver.kernel.org>; Fri, 31 Mar 2023 12:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjCaMaQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Mar 2023 08:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjCaMaP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Mar 2023 08:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D4F1F786
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 05:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680265762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=85CtYycuBpJLv7QjszVb+IojezIRTfpozrfFnqlS6rk=;
        b=Zey90gjDwi3lLYAjHGAaHsdv5UjIVVsHqnQHMJVXaKswzoGiTmlOk/zUYPWOfwb3XuXb+W
        mJWmW4ZnfNOJC++KXdfnrERi+BgyeG0wKEPTr0m070Rmw8eljrde1rZx0aJ4hKesAht7Ue
        G2b1v4ecaF7xe9mcmtAtJPjQZ3yxaR4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-oCgxZphyMIycD_Od1SG6qg-1; Fri, 31 Mar 2023 08:29:21 -0400
X-MC-Unique: oCgxZphyMIycD_Od1SG6qg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1F9F858297
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 12:29:20 +0000 (UTC)
Received: from localhost (unknown [10.45.225.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 798EA1121314
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 12:29:20 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Subject: sesearch --neverallow
Date:   Fri, 31 Mar 2023 14:29:19 +0200
Message-ID: <87ileh5ckg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

I've got a question what is `sesearch --neverallow` good for and how to
make it work. I wasn't able to get any output from this command.

Is it supposed to work with current userspace and policies? How?

Thanks,

Petr



