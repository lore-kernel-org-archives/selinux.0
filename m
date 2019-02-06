Return-Path: <SRS0=09KC=QN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FCEC169C4
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 20:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473642175B
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 20:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfBFU7X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:59:23 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:47536 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfBFU7X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Feb 2019 15:59:23 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1A00E564762
        for <selinux@vger.kernel.org>; Wed,  6 Feb 2019 21:59:21 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id u16so14453648otk.8
        for <selinux@vger.kernel.org>; Wed, 06 Feb 2019 12:59:21 -0800 (PST)
X-Gm-Message-State: AHQUAuZL9n+b2hDTlR3AxN50woREAgb5zV0FtcPf6paNIMui8AthKveU
        Pn/WU7cNjhy+ntgXsruBDLyHPcy4cd+9sLy5+Us=
X-Google-Smtp-Source: AHgI3Ibl54mQQin/O/UI9oF/X7fhuR/C9aIPe6/5IY/yi7DqOlucx4Lo9JnVeY/IwybTZqOeE2t7kdXbDASWL2C1nfE=
X-Received: by 2002:a05:6808:117:: with SMTP id b23mr138056oie.39.1549486760098;
 Wed, 06 Feb 2019 12:59:20 -0800 (PST)
MIME-Version: 1.0
References: <20190205085610.14029-1-vmojzis@redhat.com>
In-Reply-To: <20190205085610.14029-1-vmojzis@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 6 Feb 2019 21:59:08 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nLOTU-o5Q9TBmgKqumk=BHC2qHz=6393S=6MY24Jxwxg@mail.gmail.com>
Message-ID: <CAJfZ7=nLOTU-o5Q9TBmgKqumk=BHC2qHz=6393S=6MY24Jxwxg@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Add -S option to manpage
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Feb  6 21:59:21 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 5, 2019 at 9:56 AM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Thanks for your patch. Nevertheless the synopsis of the command in the
man page is still incomplete. Could you please update it too, and
while at it add the missing flags that are already documented in the
manpage too?

Nicolas

> ---
>  checkpolicy/checkpolicy.8 | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
> index 1c8805d5..a3e4acc0 100644
> --- a/checkpolicy/checkpolicy.8
> +++ b/checkpolicy/checkpolicy.8
> @@ -39,6 +39,9 @@ Write a binary policy file to the specified filename.
>  .B \-c policyvers
>  Specify the policy version, defaults to the latest.
>  .TP
> +.B \-S,\-\-sort
> +Sort ocontexts before writing out the binary policy. This option makes output of checkpolicy consistent with binary policies created by semanage and secilc.
> +.TP
>  .B \-t,\-\-target
>  Specify the target platform (selinux or xen).
>  .TP
> --
> 2.17.2
>

