Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEB0C43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 13:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E812B20663
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 13:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="FSCqTGU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfLLNWj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:22:39 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:41470 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbfLLNWj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 08:22:39 -0500
Received: by mail-lj1-f180.google.com with SMTP id h23so2260579ljc.8
        for <selinux@vger.kernel.org>; Thu, 12 Dec 2019 05:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=XNUlUOvham8/sAafePfdWjW5Aqc15nPLcxF5UhPZ6JY=;
        b=FSCqTGU37bKpruD61WUIqPRS9O2Y0kE7kV+2IkIfQOizUv3WLPXf6uBu91QX/V6t70
         F1AcieSy8DmZsYg4+gxEk29iNL6VWpscZh7fOnCasbTDPz0ydP6shHsCIHWoUHv8r4ko
         FsPKYI+A5MdzmEA2HaiZUZ/4I+OMAqF2h3lRNocU4xGtS4odpid3XL0h3neUZ9CfhorQ
         Ncrth3uBD4W2KfrNDaf4By9rVgH4pr2OVvqiKCUIZpr227g5dTffHbH4+6CG9MFu64Lg
         t9mLuY2IqDppWYUkU+XjO4jji5WC3X2tdxd4W3mAe1w6Q2PUIa/DQgt1jI1jvm0bT9/I
         EkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XNUlUOvham8/sAafePfdWjW5Aqc15nPLcxF5UhPZ6JY=;
        b=Y16m9hYINeOa9ubRt/t94V635tMzrIChEUu1aDAlzPCtf4P351kPpJD99Zyjty6SY+
         +kmnBPNj8Fypj8I2vfquiPZvrya7qQwexKIwlaih/XIY+ht9Ld/5F1yDwFqMA2df5j//
         B1b9b5Xktou9xlN5ihfa/+OonNK8d94lmONfElH/rcTwYs+avUFYFQidkC0vdGJQRzby
         zegwewzMeu6CuU9bGrI3kj5tOXz6fPbcbbR3/t2u6XoymyRuyvnVi7TvXoRR08dYv0dg
         fptAEdwHHaxsewPPrWfs/NWq/uqAukp4XjYB9UdlbDoC9pNmKrqA+H2qf/6f2OJfDoBz
         ONgQ==
X-Gm-Message-State: APjAAAX7U/ReNHVCEUpHQ0rgVFwoLuirgHv46Wr+DemuWqwR2Ym934XR
        yH+HyjBrN6muDgTJitWAj6PERVQuZKgdApyW02qZVuo=
X-Google-Smtp-Source: APXvYqwDkRk3gSEht5YheRqYaP/H9ucGHL3lgDd0WeUzTXCrXxtFWkSnlsAtvs1vMSM1Y3BI0N4ds5sND50b4+T1OVI=
X-Received: by 2002:a2e:99cd:: with SMTP id l13mr5831898ljj.243.1576156957074;
 Thu, 12 Dec 2019 05:22:37 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Dec 2019 08:22:26 -0500
Message-ID: <CAHC9VhQUZetfpAYa1FcXnrZOkSuJ6ZMBqxYbvQWJzBSHHRj-dQ@mail.gmail.com>
Subject: SELinux namespaces working branch rebased
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

As a FYI, I just rebased the SELinux namespaces branch,
selinux/working-selinuxns, on top of the current selinux/next branch.
It builds and boots, but I have yet to do any further testing.

-- 
paul moore
www.paul-moore.com
