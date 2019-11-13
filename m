Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D07C43331
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 08:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CB4222D3
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 08:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfKMIal (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:30:41 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:32953 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfKMIal (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 03:30:41 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7EB8456487A
        for <selinux@vger.kernel.org>; Wed, 13 Nov 2019 09:30:37 +0100 (CET)
Received: by mail-ot1-f44.google.com with SMTP id w24so421233otk.6
        for <selinux@vger.kernel.org>; Wed, 13 Nov 2019 00:30:37 -0800 (PST)
X-Gm-Message-State: APjAAAWZGFmTuj3vnJHEMtfof0MGlIETGF42JMb0Rb//JohYIdD6KCkC
        JGQgzHSzDvhhMHALyxCK+8utTHnAL312R98HhGM=
X-Google-Smtp-Source: APXvYqxcyTjy6Aahdle7fVxQdbgZ/wCvFzRR6BZ4i3b6+kbnmo7dhO98Ursr7DXlAM+WmW6mYuSVomVzpDA3xFf0jkU=
X-Received: by 2002:a9d:2ac7:: with SMTP id e65mr1933170otb.321.1573633836433;
 Wed, 13 Nov 2019 00:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20191111115315.1173097-1-nicolas.iooss@m4x.org>
 <20191111115315.1173097-2-nicolas.iooss@m4x.org> <bdf62121-254c-884c-f318-6f7f530cc006@tycho.nsa.gov>
In-Reply-To: <bdf62121-254c-884c-f318-6f7f530cc006@tycho.nsa.gov>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 13 Nov 2019 09:30:25 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nuaL0bcb3gWqtZF1ChxpPJjajAP98U73iym0zjiwM0QQ@mail.gmail.com>
Message-ID: <CAJfZ7=nuaL0bcb3gWqtZF1ChxpPJjajAP98U73iym0zjiwM0QQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] libselinux, libsemanage: fix python_exception.i dependencies
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
Cc:     Michael Shigorin <mike@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Nov 13 09:30:37 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 12, 2019 at 4:39 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 11/11/19 6:53 AM, Nicolas Iooss wrote:
> > selinuxswig_python_exception.i and semanageswig_python_exception.i need
> > to be regenerated when either an input header file changes or
> > exception.sh changes. Add the missing items to the respective Makefiles.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Wondering if we ought to be passing the dependencies as arguments to
> exception.sh and having it use them rather than a hardcoded header file
> path, but regardless:
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

I merged my three patches. Thanks for your review.

In my humble opinion, I find it simpler not to pass any argument to
the script, users can regenerate the files by running exception.sh
directly.

Nevertheless, when I wrote this patch, there is something that
surprised me. In libselinux, only functions in selinux.h are
considered when adding glue code to raise OSError from errno when a
function returns a negative value. Contrary to semanage.h, selinux.h
does not include every other libselinux headers. More precisely, "grep
'^extern int ' libselinux/include/selinux/*.h" shows some functions in
avc.h, label.h and restorecon.h that are not handled. For example
avc_netlink_open() documented in its manpage to return -1 and set
errno when an error occurs, but is not present in
selinuxswig_python_exception.i. Is this a bug?
If yes, fixing it requires changing the API of selinux Python module,
which could break some applications (a function would raise an
exception instead of returning -1).

Nicolas

