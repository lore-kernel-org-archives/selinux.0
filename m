Return-Path: <SRS0=MPXq=TJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DB8C04AB1
	for <selinux@archiver.kernel.org>; Thu,  9 May 2019 19:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303652173B
	for <selinux@archiver.kernel.org>; Thu,  9 May 2019 19:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPoxpqVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfEIT5F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 May 2019 15:57:05 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:40157 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfEIT5F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 May 2019 15:57:05 -0400
Received: by mail-io1-f47.google.com with SMTP id s20so2630769ioj.7
        for <selinux@vger.kernel.org>; Thu, 09 May 2019 12:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wPnFoDtgczvkAPjqDYWO+s0Fyp9pfSwG4EcZonQtbOE=;
        b=WPoxpqVvfijrRRf5RM1CUZYq7kZxFgco3qml4p8Osw+V/uheCs41Molwbzo5ZBMSD0
         2ctpPG5JdCQFc42Luy6FiRoHHhACnKS2q/tZoCxns3tuICiLRGtwYwBTnRIPesjF32OE
         GdllIFyUfaWourk7tjS9nYKYmkIFc0KbNgQh7BqZ7HKyz/6ujSRybhattEMM0UiUUqHX
         75gnuu1s9SnldZeOcMeHtNNQR7Jv7EyvJGogtn8Z4lbUgGci8NLjvLbew/IRLcEEUgn5
         oF+b55PV97FfkMmW989TJVlKtUz6LHwSe6XloNCKTK8XRb8D/cNaootEMa+rm1BiNMf/
         LcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wPnFoDtgczvkAPjqDYWO+s0Fyp9pfSwG4EcZonQtbOE=;
        b=sFWbEhpfVznIGM30uoGWmp6loEXkvql4/RX+0Lkdutv0DgJ9IpL8igGYe5Eoi6AGuS
         uVHADQm9TdmaX9UjCY2uHwYi6ifVLPgMcGfsxIlH9cIC8grhCYdIWFufqWqaxw+H/P/s
         4rl9P5b9pEPf+bmUlhZ/04A0tzkYFc0fmZP4cR6rvpGYsJ0IOEc+N40EUj89zZ293Vk/
         xUiu1L2NuLjx3JXiw40no9Jw1dpeunXXadg9wcyBAStqB2Eur25hbR4OvTdijNAcotcQ
         gAUKX8g6+9twcNGLgeHcivZCFTqTpQacXB8h5rtKbxBHMyZprkKLFeQ9UYuveZ/BbtYg
         QFew==
X-Gm-Message-State: APjAAAXECgoNX4ARMbzy1QAm00iykFgxVXd+nx93jyIlCcf5SvHaYwwW
        7vTAmDyZC+JeDpa/zPSNIfIIbSLXNvVuNmnUsEeLH69SAjc=
X-Google-Smtp-Source: APXvYqxVbF1mT4KMVLS609jt09Q9TZv2ukXRjTkyNHxhzOhPhbNwhHGp2B9Ef6DJvPF+9+LOTQS4QAr9RyvwhVRNQl8=
X-Received: by 2002:a5e:8904:: with SMTP id k4mr104905ioj.264.1557431824019;
 Thu, 09 May 2019 12:57:04 -0700 (PDT)
MIME-Version: 1.0
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Thu, 9 May 2019 12:56:52 -0700
Message-ID: <CABXk95D-4v2aT=sZk9NoeGJBGTy=7NTQ8+yKv5E4RvaODJgWLA@mail.gmail.com>
Subject: Mislabeled /proc/<pid>/ns/mnt files?
To:     selinux@vger.kernel.org, Joel Galenson <jgalenson@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I expected files here would have the process's context, but they
don't. The files are actually all symlinks so it's entirely possible
that the they shouldn't have the process's context. If that's the
case, how can I provide different labels for them? Neither "proc" nor
"unlabeled" are appropriate.

On a device with a 3.18 kernel they have the "proc" context:
sailfish:/ # ls -LZ1 /proc/1/ns
u:object_r:proc:s0 mnt
u:object_r:proc:s0 net

On a device with the 4.9 kernel the have the "unlabeled" context:
blueline:/ # ls -LZ1 /proc/1/ns
u:object_r:unlabeled:s0 cgroup
u:object_r:unlabeled:s0 mnt
u:object_r:unlabeled:s0 net
