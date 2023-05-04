Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCEDC77B78
	for <selinux@archiver.kernel.org>; Thu,  4 May 2023 12:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjEDMFu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 May 2023 08:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjEDMFs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 May 2023 08:05:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9099E26B5
        for <selinux@vger.kernel.org>; Thu,  4 May 2023 05:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683201898;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hr/negEWDnLWAeecXvjgii5nd1srZuWLdMQxisS0JSE=;
        b=Yu/gLM2vX52fBbFXKLy8hzoJWocwO17FMEDL/d1veM8Uaja+/Nnmy8g7NDI2Z20mGLr8/V
        Bj/6Lo03ZIY9hmLDDkRB8HFJ93BOIXDoaP6/s038WASkxK3YbCWBQXoIJbCQXrYbEB0Y/n
        Qv2jadDRedGH5CaZ4iQ57SGEHILdXE8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-6gTQoDBrOQe7FbDo0RAQPw-1; Thu, 04 May 2023 08:04:57 -0400
X-MC-Unique: 6gTQoDBrOQe7FbDo0RAQPw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2310238221C8
        for <selinux@vger.kernel.org>; Thu,  4 May 2023 12:04:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B64C1492C3E
        for <selinux@vger.kernel.org>; Thu,  4 May 2023 12:04:56 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 0/4] python: Improve man pages
Date:   Thu,  4 May 2023 14:04:46 +0200
Message-Id: <20230504120450.771407-1-vmojzis@redhat.com>
In-Reply-To: <CAP+JOzQBSknYVqAqhu6WGwnTDBCXc-P1B73+MnfbcEyGi621CA@mail.gmail.com>
References: <CAP+JOzQBSknYVqAqhu6WGwnTDBCXc-P1B73+MnfbcEyGi621CA@mail.gmail.com>
Reply-To: <CAP+JOzQBSknYVqAqhu6WGwnTDBCXc-P1B73+MnfbcEyGi621CA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thank you for the review Jim.
I fixed all the issues, added missing signoffs and removed the "debug"
option alltogether, since it was unused (good catch).

Thanks,
Vit


