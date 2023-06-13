Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED76C88CB8
	for <selinux@archiver.kernel.org>; Tue, 13 Jun 2023 09:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbjFMJpV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jun 2023 05:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240401AbjFMJoq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jun 2023 05:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93038CE
        for <selinux@vger.kernel.org>; Tue, 13 Jun 2023 02:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686649441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=52Wotd1NoGOFyzo13dRhC7Qv5meK2slYKiiuYooXQag=;
        b=fb/lLgr+qIdMCC+olvGm6u4V+NOgXsPFZ2Aa5UVhh04ZayGsUCQ4m4KJm01mQTwEgjJMYb
        sYiVMvKdX7PStrH4FmpVC+f8qr2XACFNBJvM9ic7Eort7+WqZMp6UG431xHk0xZwKISuKW
        yKfKxQyqZ92lVj7ad0Re+Z3+H1gFn54=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-Np06RWjBPlmh_bABMNg0FQ-1; Tue, 13 Jun 2023 05:44:00 -0400
X-MC-Unique: Np06RWjBPlmh_bABMNg0FQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B974B28EC113
        for <selinux@vger.kernel.org>; Tue, 13 Jun 2023 09:43:59 +0000 (UTC)
Received: from P1.redhat.com (unknown [10.45.225.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 391F3492CA6;
        Tue, 13 Jun 2023 09:43:59 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     vmojzis@redhat.com
Subject: 
Date:   Tue, 13 Jun 2023 11:42:41 +0200
Message-ID: <20230613094346.2667592-1-lautrbach@redhat.com>
In-Reply-To: <20230612162155.2604483-5-lautrbach@redhat.com>
References: <20230612162155.2604483-5-lautrbach@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Fixed typo in 1/4: prot=proto => proto=proto

