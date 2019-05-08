Return-Path: <SRS0=Lq8N=TI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D7EC04A6B
	for <selinux@archiver.kernel.org>; Wed,  8 May 2019 21:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B715C206A3
	for <selinux@archiver.kernel.org>; Wed,  8 May 2019 21:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="sQJcSsgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfEHVrr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 May 2019 17:47:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33684 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfEHVrr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 May 2019 17:47:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id x132so39494lfd.0
        for <selinux@vger.kernel.org>; Wed, 08 May 2019 14:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KWdBpehfU7fGp6F4+EMfaZWNMBJ4N9LIgc0IJ8YlaU=;
        b=sQJcSsgVBpUiW9/dp2EhnC5IE90kh9KPTg1JLy9lqJRX55/Z2YssPoM2ZGpqgaeTGX
         iM6XoWZOSPHbDMXPCb0rDCbG4bOYNAS5AsOEhP1/o/HP+aV8ayi+WR4SKt/9ST7gMOm1
         wBQC4hfR3izU2GcqMMgCQDQaonDwRMY9yuEGrDqlbDNLM/ibIw3wjPzcGpmnzxIo1QzH
         t/my2JstqfAoXG+liGRmO8ZwKP50QAdV101d1KV8eDz28mJREDdq5Wwac8jRIwdM9JsN
         gSf8Bf11Kb6F5tnO65fEEeMD1XAdpHSbQrk2hrxUo0AaTUuV5aSRgNPh+YXRyp98qN4G
         ek3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KWdBpehfU7fGp6F4+EMfaZWNMBJ4N9LIgc0IJ8YlaU=;
        b=YswE/mkxKsDpjNyByi0kH3NFubvOyvfXsX5Pfp7fvKfceTrUPJDDZzNoVWyqWkSXFP
         vWQrk6C55LnVMu/4NLCN63eMyIMIYfF43BWteTVbvI/PR/PBTn2K0ime2sbdYtCAiPWM
         FHylPGax/MH8IbUrPcKryzP3v6NaDM74uPYOP4vx0S+SQYgz+7bWKMNO6QGYxZ6WdH7I
         SiaGXwTMMiR6p+1slWGNjR8pC6lOQBn3jYtSOdNAjUUzrBKYdhBhWc67KebgaU5Gt6Xc
         AwcEL613pQfNofKyvctmvckKBiUdp/zEUaia7PUreA9zX713HGaNPOFB0QnrvYQo3UPW
         ICOw==
X-Gm-Message-State: APjAAAU2UO9RZDkIXvXCG+iaD26NE241i4wjYio/U3UHRvr0HfG8qg+8
        8vdJPcv7VbXUbGyldTpUvvxeRD3f8CV2v95s+x9r
X-Google-Smtp-Source: APXvYqwfHTN7jF0fpqil4BUeasee8e1nJ5DufZ7FCjbREONvZg+rbKNJIG03NSaQbVwXMLivzdL7FfQ3i7yPLDwGdNs=
X-Received: by 2002:a19:9e47:: with SMTP id h68mr188400lfe.91.1557352064142;
 Wed, 08 May 2019 14:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <1557296477-4694-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1557296477-4694-1-git-send-email-hofrat@osadl.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 May 2019 17:47:32 -0400
Message-ID: <CAHC9VhSU7pzWby78gHkYKm3t1LopSCoHBfmp=uBc+mF234K8mg@mail.gmail.com>
Subject: Re: [PATCH RFC] selinux: provide __le variables explicitly
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        peter enderborg <peter.enderborg@sony.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 8, 2019 at 2:27 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> While the endiannes is being handled properly sparse was unable to verify
> this due to type inconsistency. So introduce an additional __le32
> respectively _le64 variable to be passed to le32/64_to_cpu() to allow
> sparse to verify proper typing. Note that this patch does not change
> the generated binary on little-endian systems - on 32bit powerpc it
> does change the binary.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
>
> Problem located by an experimental coccinelle script to locate
> patters that make sparse unhappy (false positives):
>
> sparse complaints on different architectures fixed by this patch are:
>
> ppc6xx_defconfig
>   CHECK   security/selinux/ss/ebitmap.c
> security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
>
> Little-endian systems:
>
> loongson3_defconfig
> security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
>
> x86_64_defconfig
> security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
>
> Patch was compile-tested with: x86_64_defconfig,loongson3_defconfig (both
> little-endian) and ppc603_defconfig (big-endian).
>
> On little-endian systems the patch has no impact on the generated binary
> (which is expected) but on the 32bit powerpc it does change the binary
> which is not expected but since I'm not able to generate the .lst files
> in security/selinux/ss/ due to the lack of a Makefile it is not clear
> if this is an unexpected side-effect or due only to the introduction of
> the additional variables. From my understanding the patch does not change
> the program logic so if the code was correct on big-endian systems before
> it should still be correct now.

This is a bit worrisome, but I tend to agree that this patch *should*
be correct.  I'm thinking you're probably right in that the resulting
binary difference could be due to the extra variable.  Have you tried
any other big-endian arches?

> Patch is against 5.1 (localversion-next is next-20190506)
>
>  security/selinux/ss/ebitmap.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index 8f624f8..09929fc 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -347,7 +347,9 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>  {
>         struct ebitmap_node *n = NULL;
>         u32 mapunit, count, startbit, index;
> +       __le32 ebitmap_start;
>         u64 map;
> +       __le64 mapbits;
>         __le32 buf[3];
>         int rc, i;
>
> @@ -381,12 +383,12 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>                 goto bad;
>
>         for (i = 0; i < count; i++) {
> -               rc = next_entry(&startbit, fp, sizeof(u32));
> +               rc = next_entry(&ebitmap_start, fp, sizeof(u32));
>                 if (rc < 0) {
>                         pr_err("SELinux: ebitmap: truncated map\n");
>                         goto bad;
>                 }
> -               startbit = le32_to_cpu(startbit);
> +               startbit = le32_to_cpu(ebitmap_start);
>
>                 if (startbit & (mapunit - 1)) {
>                         pr_err("SELinux: ebitmap start bit (%d) is "
> @@ -423,12 +425,12 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>                         goto bad;
>                 }
>
> -               rc = next_entry(&map, fp, sizeof(u64));
> +               rc = next_entry(&mapbits, fp, sizeof(u64));
>                 if (rc < 0) {
>                         pr_err("SELinux: ebitmap: truncated map\n");
>                         goto bad;
>                 }
> -               map = le64_to_cpu(map);
> +               map = le64_to_cpu(mapbits);
>
>                 index = (startbit - n->startbit) / EBITMAP_UNIT_SIZE;
>                 while (map) {
> --
> 2.1.4
>


-- 
paul moore
www.paul-moore.com
