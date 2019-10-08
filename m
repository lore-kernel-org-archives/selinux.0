Return-Path: <SRS0=qSAh=YB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99600C4360C
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 21:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671E52070B
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 21:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hmtv7fVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfJHVa4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Oct 2019 17:30:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33441 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbfJHVa4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Oct 2019 17:30:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id a22so355373ljd.0
        for <selinux@vger.kernel.org>; Tue, 08 Oct 2019 14:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E39R118ttRpenGNO8TUrYNqodmFcfVFLgePhuvMoIV8=;
        b=hmtv7fVVcmiPb43881R0mZZP9Z3rOUSlUzzSx71Kp4bi0yKdqRv53jCdXkwKPbndiT
         qLADcnWX65AwZzir3ou0L4ntFAS7Z8yfT46vdnjAuymYbsdY9LJ+/0l3avaVek+yAlOf
         0aUOJgUxgROT7oQsLS6qMRZ4kvxD8AHAyC+tiyjIPEDIf246t8NL4v0g3tJg4p9UTyG7
         qJC94D6uXQHVNsTsZRn5BBm9yMbsJykgUxi+oaqPFtKdBbqmuVnSd+aVzfhJ2Di80Qjf
         6JS6rXHzL22hFBTll9XaIlNeG1rN6lYE9qbkcrNKoA+Vkiqw9NmOiRzwhzF5+VQHUhxy
         vhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E39R118ttRpenGNO8TUrYNqodmFcfVFLgePhuvMoIV8=;
        b=hnOhMY2jacNzhYvNQJG+f/dx2CbsIfMNQc1sKlfwjUklznv8YSs1EJjMDZbQ/B5Z+t
         BWuCx83kJkFqjylzuigVGM452YZQciS8cchEYqV3dKj8Qb8235fKH7erBhnfY5zTp1pw
         CfntvTRWH0Nxpye3SFmdRSUVOnU+4JjWySNINW36GGVI+Ni9idv2xEXurogMfu/BEPuJ
         INKfd1rndWdRxbIUeSf9XW2ogCFvrbuleI4PtjA2nh6K5xmoMEbJ/JGevy91D3zkYMeQ
         g+lbEU8sWze+wbTm/Pa8/gG/MEmRB6i14APgvCLciuqn8+1x2Ere20Q09d6xJz2xNpwo
         p+8A==
X-Gm-Message-State: APjAAAWWoeq/sxNzxf5cdvO57/WE3KuFZhM6N4W3mk41WA5Foo4DABuR
        YnSRjTfpZJI5OlOpNs378C99W5bLp3urb2HPh7C7mc4=
X-Google-Smtp-Source: APXvYqx1Oy8Xq3cR8vj078jdlWbt15B16tbHexrTXHFHi757YkQxsGTvYPEQ9D+wvRftd5NfuxbIDsp9Urjy8iYMgq4=
X-Received: by 2002:a2e:1b52:: with SMTP id b79mr161049ljb.225.1570570252134;
 Tue, 08 Oct 2019 14:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190930131600.21473-1-omosnace@redhat.com> <c9cc5939-a6f3-73cd-7ff3-a83a04d36b17@tycho.nsa.gov>
In-Reply-To: <c9cc5939-a6f3-73cd-7ff3-a83a04d36b17@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Oct 2019 17:30:40 -0400
Message-ID: <CAHC9VhTVNgqOgRjgk37x0EyZQWBbrYJ1FND5hVMxZUJ5JcofPA@mail.gmail.com>
Subject: Re: [PATCH testsuite] selinux-testsuite: Add submount test
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 30, 2019 at 10:07 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 9/30/19 9:16 AM, Ondrej Mosnacek wrote:
> > Add a test that verifies that SELinux permissions are not checked when
> > mounting submounts. The test sets up a simple local NFS export on a
> > directory which has another filesystem mounted on its subdirectory.
> > Since the export is set up with the crossmnt option enabled, any client
> > mount will try to transparently mount any subdirectory that has a
> > filesystem mounted on it on the server, triggering an internal mount.
> > The test tries to access the automounted part of this export via a
> > client mount without having a permission to mount filesystems, expecting
> > it to succeed.
> >
> > The original bug this test is checking for has been fixed in kernel
> > commit 892620bb3454 ("selinux: always allow mounting submounts"), which
> > has been backported to 4.9+ stable kernels.
> >
> > The test first checks whether it is able to export and mount directories
> > via NFS and skips the actual tests if e.g. NFS daemon is not running.
> > This means that the testsuite can still be run without having the NFS
> > server installed and running.
>
> 1) We have to manually start nfs-server in order for the test to run;
> else it will be skipped automatically.  Do we want to start/stop the
> nfs-server as part of the test script?

My two cents are that I'm not sure we want to automatically start/stop
the NFS server with the usual "make test", perhaps we have a dedicated
NFS test target that does the setup-test-shutdown?  Other ideas are
welcome.

-- 
paul moore
www.paul-moore.com
