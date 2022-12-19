Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39590C10F1B
	for <selinux@archiver.kernel.org>; Mon, 19 Dec 2022 17:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiLSRet (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Dec 2022 12:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiLSRes (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Dec 2022 12:34:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0A5BE2E
        for <selinux@vger.kernel.org>; Mon, 19 Dec 2022 09:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671471245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=566BxPRMWIWkdoo1gj5qaysR/Knf9uynC4l+eYaS2mY=;
        b=WzLUo6SGK67QOjG9Z1OdNSdOoF+STI0oFfIFmmHXSV1uXayi3NGLA+l3roUHNtDfGK/BoF
        yoAtsF6fTc9xMsQZBc0gySIk4lTWBRRZtdyKlkj5ce4XPh7oeulxM97zxzGh9F7aeLnBN3
        6w452dza093pdgn1jSTQIn6f6VHp6+E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-0AnJ2G5FMP2hrufpzkXtrw-1; Mon, 19 Dec 2022 12:34:03 -0500
X-MC-Unique: 0AnJ2G5FMP2hrufpzkXtrw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35EF485CBE6;
        Mon, 19 Dec 2022 17:34:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 249812166B26;
        Mon, 19 Dec 2022 17:34:01 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        mptcp@lists.linux.dev
Subject: [PATCH v2 0/2] lsm: introduce and use security_mptcp_add_subflow()
Date:   Mon, 19 Dec 2022 18:33:47 +0100
Message-Id: <cover.1671469167.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series is an attempt to solve the LSM labeling breakage
reported here:

https://lore.kernel.org/linux-security-module/CAHC9VhSQnhH3UL4gqzu+YiA1Q3YyLLCv88gLJOvw-0+uw5Lvkw@mail.gmail.com/

As per previous discussion, a new LSM hook is introduced and
invoked by the mptcp code to let LSMs set the appropriate label
for the newly created subflow.

I'm not sure the chosen hook name is a perfect fit, any suggestion
more then welcome.
The new hook requires both the mptcp socket reference and the
subflow socket reference, even if the provided LSM implementation
for selinux ends-up accessing only the subflow socket. Possibly
other LSM implementation could need or use the addtional parameter.

Tested vs the issue reproducer and mptcp self-tests.

v1 -> v2:
 - fix a few build issues with unusual configurations reported
   by bots

Paolo Abeni (2):
  security, lsm: Introduce security_mptcp_add_subflow()
  selinux: Implement mptcp_add_subflow hook

 include/linux/lsm_hook_defs.h |  1 +
 include/linux/lsm_hooks.h     |  9 +++++++++
 include/linux/security.h      |  6 ++++++
 net/mptcp/subflow.c           |  6 ++++++
 security/security.c           |  5 +++++
 security/selinux/hooks.c      | 27 +++++++++++++++++++++++++++
 security/selinux/netlabel.c   |  4 +++-
 7 files changed, 57 insertions(+), 1 deletion(-)

-- 
2.38.1

