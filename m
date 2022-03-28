Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEC6C433F5
	for <selinux@archiver.kernel.org>; Mon, 28 Mar 2022 09:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbiC1JDc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Mar 2022 05:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239614AbiC1JDc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Mar 2022 05:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03AC253E1B
        for <selinux@vger.kernel.org>; Mon, 28 Mar 2022 02:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648458109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C5HWUyNwnBgwRuTmYFVUsLeN7O76Qpn+gZ0dJBX42RA=;
        b=IrTH+VeVVd+ovUWlmp7fGm6wNm+azMK2qhJc4Pfwj1xDctV8NylwY+ikR4uIvCvdRuB/qn
        UiMbl1rvCIplGpAJNp2UUeAYstSFH15HBcZCIbDXT9Lx4hXae2v/i/8kl66uRHinX7gIn6
        CKxpz61PkFq8xHu0nK/l10ueBsDbLyE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-vtzDayrvOdqNWeZZiCi0XA-1; Mon, 28 Mar 2022 05:01:45 -0400
X-MC-Unique: vtzDayrvOdqNWeZZiCi0XA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F8F4803D65;
        Mon, 28 Mar 2022 09:01:45 +0000 (UTC)
Received: from localhost (unknown [10.40.194.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 404431417201;
        Mon, 28 Mar 2022 09:01:45 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] Add a file describing the security vulnerability
 handling process
In-Reply-To: <20220325173013.448231-1-jwcart2@gmail.com>
References: <20220325173013.448231-1-jwcart2@gmail.com>
Date:   Mon, 28 Mar 2022 11:01:44 +0200
Message-ID: <87v8vy30xz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> Add the file SECURITY.md which describes the SELinux userspace
> security vulnerability handling process including who to contact.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
>  SECURITY.md | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 SECURITY.md
>
> diff --git a/SECURITY.md b/SECURITY.md
> new file mode 100644
> index 00000000..37630585
> --- /dev/null
> +++ b/SECURITY.md
> @@ -0,0 +1,59 @@
> +The SELinux Userspace Security Vulnerability Handling Process
> +===============================================================================
> +https://github.com/SELinuxProject/selinux
> +
> +This document attempts to describe the processes through which sensitive
> +security relevant bugs can be responsibly disclosed to the SELinux userspace
> +project and how the project maintainers should handle these reports. Just like
> +the other SELinux userspace process documents, this document should be treated
> +as a guiding document and not a hard, unyielding set of regulations; the bug
> +reporters and project maintainers are encouraged to work together to address
> +the issues as best they can, in a manner which works best for all parties
> +involved.
> +
> +### Reporting Problems
> +
> +For serious problems or security vulnerabilities in the SELinux kernel code
> +please refer to the SELinux Kernel Subsystem Security Policy in the link below:
> +
> +* https://github.com/SELinuxProject/selinux-kernel/blob/main/SECURITY.md
> +
> +Problems with the SELinux userspace that are not suitable for immediate public
> +disclosure should be emailed to the current SELinux userspace maintainers, the
> +list is below. We typically request at most a 90 day time period to address
> +the issue before it is made public, but we will make every effort to address
> +the issue as quickly as possible and shorten the disclosure window.
> +
> +* Petr Lautrbach, plautrba@redhat.com
> +* Nicolas Iooss, nicolas.iooss@m4x.org
> +* Jeffrey Vander Stoep, jeffv@google.com
> +* Joshua Brindle, brindle@gmail.com
> +* James Carter, jwcart2@gmail.com
> +* Paul Moore, paul@paul-moore.com
> +* Jason Zaman, perfinion@gentoo.org
> +* Steve Lawrence, slawrence@tresys.com
> +* William Roberts, bill.c.roberts@gmail.com
> +* Ondrej Mosnacek, omosnace@redhat.com
> +
> +### Resolving Sensitive Security Issues
> +
> +Upon disclosure of a bug, the maintainers should work together to investigate
> +the problem and decide on a solution. In order to prevent an early disclosure
> +of the problem, those working on the solution should do so privately and
> +outside of the traditional SELinux userspace development practices. One
> +possible solution to this is to leverage the GitHub "Security" functionality to
> +create a private development fork that can be shared among the maintainers, and
> +optionally the reporter. A placeholder GitHub issue may be created, but details
> +should remain extremely limited until such time as the problem has been fixed
> +and responsibly disclosed. If a CVE, or other tag, has been assigned to the
> +problem, the GitHub issue title should include the vulnerability tag once the
> +problem has been disclosed.
> +
> +### Public Disclosure
> +
> +Whenever possible, responsible reporting and patching practices should be
> +followed, including notification to the linux-distros and oss-security mailing
> +lists.
> +
> +* https://oss-security.openwall.org/wiki/mailing-lists/distros
> +* https://oss-security.openwall.org/wiki/mailing-lists/oss-security
> -- 
> 2.34.1

