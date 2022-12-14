Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D13C001B2
	for <selinux@archiver.kernel.org>; Wed, 14 Dec 2022 22:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiLNWDH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Dec 2022 17:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLNWDG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Dec 2022 17:03:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DB0286D1
        for <selinux@vger.kernel.org>; Wed, 14 Dec 2022 14:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671055348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FIfZDMz93+tMIUoDauhhPDBk4SBbL7tQwo8q9f07E80=;
        b=DA5Y037FDuET122pazScwA4qyAXV922AhV4RJzu7+g3TQfEFKgoszJ12BbHZ63RUi5Z9qa
        3gMqukSXEkagJJV6FOgXjATpii5QnXLaA9+PsT6QtHKbFDfae3cBIX4O+QCpsCk1flpZ6Z
        s3C/A5eYtpHWSHWPtsR3Cc5rDVL/wnU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-GPs9MDT0Mk-sNta1mDZHBg-1; Wed, 14 Dec 2022 17:02:26 -0500
X-MC-Unique: GPs9MDT0Mk-sNta1mDZHBg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE9D629A9D3F;
        Wed, 14 Dec 2022 22:02:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0B8D40C2064;
        Wed, 14 Dec 2022 22:02:24 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        mptcp@lists.linux.dev
Subject: [PATCH 0/2] lsm: introduce and use security_mptcp_add_subflow()
Date:   Wed, 14 Dec 2022 23:01:56 +0100
Message-Id: <cover.1671054577.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Paolo Abeni (2):
  security, lsm: Introduce security_mptcp_add_subflow()
  selinux: Implement mptcp_add_subflow hook

 include/linux/lsm_hook_defs.h |  1 +
 include/linux/lsm_hooks.h     |  9 +++++++++
 include/linux/security.h      |  6 ++++++
 net/mptcp/subflow.c           |  6 ++++++
 security/security.c           |  5 +++++
 security/selinux/hooks.c      | 30 ++++++++++++++++++++++++++++++
 6 files changed, 57 insertions(+)

-- 
2.38.1

