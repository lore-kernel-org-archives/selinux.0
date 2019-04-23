Return-Path: <SRS0=RjX6=SZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DBDC10F03
	for <selinux@archiver.kernel.org>; Tue, 23 Apr 2019 16:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16BE21841
	for <selinux@archiver.kernel.org>; Tue, 23 Apr 2019 16:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="pZM7qywy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfDWQrs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:47:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43729 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfDWQrs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Apr 2019 12:47:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id i68so12301804lfi.10
        for <selinux@vger.kernel.org>; Tue, 23 Apr 2019 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=9IDGPct7n0X6gEY0Ft7+SYgAtRN6D88NdCnj4qhJNYI=;
        b=pZM7qywyucfpIZMZDgkkSwvOQjUx54T3OOru6c+lE4a8nWNnjOwyeGH8jQuDwdVj2j
         fL3iUZjCQMLJwaXM8JNNh8sL+ZN5B/IJQy6kR35nNCQb8ipEtaUqYqlt0BMERbTYn6oE
         0jNzqdtqES0PgowHoSARfZeC4NwEsS/l2MDpaqQf/L001Z92krn4iAUKCOyXfFEmrdi6
         aQ4fIFqy1Zj8RP52nyq1iKCAylJVM+6sxcvtxW+5K76ozL+sc3Vvkg0WdjWy8JL43UH0
         5JDhmzSAwKGai778N58Py4wKVk5ON2pKLl+O8m2kDFl89/FE8soSMD+7aH5vAlTLof0s
         Z97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9IDGPct7n0X6gEY0Ft7+SYgAtRN6D88NdCnj4qhJNYI=;
        b=jFmAPjj60owge/+QtcSK3SkdTQbxnfOy6BPVTn4ihi8Rb0Eo3+WGgqsXd2PMaUBmvv
         EBk0zVfe+9bCMiZ9TBUUqvxVGMa87NnEZMXbTSoEllQL53PU+OLu2ki2UN39r+v2tsU1
         /cpbP33BN+Q464Z4YJKE0W3D1OtutdG113ETRBU/NBtm3pUvu8h1CFO6cZgcdIJmfeQu
         JLtoD3IlFU0syms7z1GxnM90PMjUGy9Dk7gamuIzhinL1X0xOAHlZMRIax8qjLW+AtTI
         FNvB1CJxoobpHJQDN5lOceuc+e3lb7sVO7E7oNNKdCvchuhMT1wRAFsbuhcp98AzPPhU
         iXfw==
X-Gm-Message-State: APjAAAUjYW8XIvbh7vCbS6ugeWqAsq1NgooR+B8NR7Wrded76qOkvIxq
        3r3ECTCBYSSP9V+D6PGu2W6G6Fx1BMeeMkmfD3oxd1i6lg==
X-Google-Smtp-Source: APXvYqw6epChO5Xr7dhMGkmD1FSi3mVO4XtAGjVMIUZU8I7r3vM6ZPc3HL+m5730SUD8gokoU9yJQGhPmK3uq24ISoE=
X-Received: by 2002:ac2:4119:: with SMTP id b25mr14426418lfi.72.1556038065299;
 Tue, 23 Apr 2019 09:47:45 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Apr 2019 12:47:34 -0400
Message-ID: <CAHC9VhR4=sV7=R5K3QV-knRaN9Nc3u8SfsDB39UiKJV5ZPT3Ng@mail.gmail.com>
Subject: An update on my kernel "secnext" builds and testing
To:     selinux@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

A while back I started building Fedora Rawhide kernels with the
selinux/next and audit/next branches applied, making them available
via a Fedora COPR repository.  My hope was that this would help make
it easier for people to test/try the patches we had queued up for the
next merge window and also enable some additional work to do fully
automated testing of the selinux/next and audit/next trees.  While I'm
not sure how many people besides myself run the secnext kernel builds
on their test systems, I have finally gotten all the pieces in place
so that we have fully automated testing for the {selinux,audit}/next
trees.  It may have taken almost four years, but better late than
never :)

For those of you who are interested, the test results are sent to the
mailing list below (yes, it's a Google group, and no you don't need to
have a Google account).  The build notifications and test results are
sent to a separate list simply because I didn't want to spam the main
mailing lists.

* https://groups.google.com/forum/#!forum/kernel-secnext

In addition, I've run into enough problems with COPR over the years
that I've started to build my own kernel packages from the secnext
SRPMs.  While I really like the idea of COPR, the current
implementation is poorly suited for building kernel packages; perhaps
it will improve in the future, but it isn't a good solution now.  I
will still keep submitting kernel builds to COPR, so those who want to
use the secnext kernels from there will continue to have that as a
valid repository, but I'm unlikely to spend any significant time
working to resolve COPR specific build problems.  For those who want
to try the kernel packages that I'm building, you can find more
information at the link below:

* https://repo.paul-moore.com

At some point in the future I would like to also build secnext kernels
for other distros, but I need to spend a little bit of time learning
the "proper" way to patch and build kernel packages for those other
distros first.  I'm leaning towards Debian as the first non-Fedora
distro, but if anyone has a favorite distro, with good SELinux/audit
support, please let me know.

-Paul

-- 
paul moore
www.paul-moore.com
