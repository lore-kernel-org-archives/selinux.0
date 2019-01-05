Return-Path: <SRS0=MvMz=PN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDA4C43387
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 15:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4B72085A
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 15:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfAEPtx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Jan 2019 10:49:53 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:43071 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfAEPtx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Jan 2019 10:49:53 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9FAF056122A
        for <selinux@vger.kernel.org>; Sat,  5 Jan 2019 16:49:50 +0100 (CET)
Received: by mail-ot1-f43.google.com with SMTP id k98so34524981otk.3
        for <selinux@vger.kernel.org>; Sat, 05 Jan 2019 07:49:50 -0800 (PST)
X-Gm-Message-State: AJcUukftZC8duqg6PUgi2uuUh7evG3Ysr3cpShZaSrbTWSH1mpsHZjvw
        GSwMUWoRxoPaur27jMXALiIa5w6wS/Xi/GM+XJ0=
X-Google-Smtp-Source: ALg8bN45HSkVW0glMDYi2lPRJMIFN6tUWuVn4SqNrf/aLzcAlPmqzqtzQH/GwV5hiBaisietqWyCVcRF9XTKIgFlCoQ=
X-Received: by 2002:a9d:70d5:: with SMTP id w21mr35143273otj.301.1546703389480;
 Sat, 05 Jan 2019 07:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20190105154551.18768-1-nicolas.iooss@m4x.org> <20190105154551.18768-2-nicolas.iooss@m4x.org>
In-Reply-To: <20190105154551.18768-2-nicolas.iooss@m4x.org>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 5 Jan 2019 16:49:38 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=k4AVpMBRg1=DKuR0i3BM=CT=0DxVBjwydeWRe__dyX3A@mail.gmail.com>
Message-ID: <CAJfZ7=k4AVpMBRg1=DKuR0i3BM=CT=0DxVBjwydeWRe__dyX3A@mail.gmail.com>
Subject: Re: [PATCH 2/2] python/sepolgen: close /etc/selinux/sepolgen.conf
 after parsing it
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan  5 16:49:51 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jan 5, 2019 at 4:46 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> sepolgen testsuite reports the following warning on a system with
> /etc/selinux/sepolgen.conf:
>
>     .../src/./sepolgen/defaults.py:35: ResourceWarning: unclosed file
>     <_io.TextIOWrapper name='/etc/selinux/sepolgen.conf' mode='r'
>     encoding='UTF-8'>
>
> Fix this by properly closing the file in PathChooser.__init__().
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Oops, I already sent this patch a few weeks ago with three over
patches but nobody has reviewed them. Should I merge it directly?

Nicolas

> ---
>  python/sepolgen/src/sepolgen/defaults.py | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/python/sepolgen/src/sepolgen/defaults.py b/python/sepolgen/src/sepolgen/defaults.py
> index 199acfafe4cf..533a90412475 100644
> --- a/python/sepolgen/src/sepolgen/defaults.py
> +++ b/python/sepolgen/src/sepolgen/defaults.py
> @@ -32,12 +32,13 @@ class PathChooser(object):
>          self.config_pathname = pathname
>          ignore = re.compile(r"^\s*(?:#.+)?$")
>          consider = re.compile(r"^\s*(\w+)\s*=\s*(.+?)\s*$")
> -        for lineno, line in enumerate(open(pathname)):
> -            if ignore.match(line): continue
> -            mo = consider.match(line)
> -            if not mo:
> -                raise ValueError("%s:%d: line is not in key = value format" % (pathname, lineno+1))
> -            self.config[mo.group(1)] = mo.group(2)
> +        with open(pathname, "r") as fd:
> +            for lineno, line in enumerate(fd):
> +                if ignore.match(line): continue
> +                mo = consider.match(line)
> +                if not mo:
> +                    raise ValueError("%s:%d: line is not in key = value format" % (pathname, lineno+1))
> +                self.config[mo.group(1)] = mo.group(2)
>
>      # We're only exporting one useful function, so why not be a function
>      def __call__(self, testfilename, pathset="SELINUX_DEVEL_PATH"):
> --
> 2.20.1
>

