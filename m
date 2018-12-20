Return-Path: <SRS0=ShWd=O5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B094C43387
	for <selinux@archiver.kernel.org>; Thu, 20 Dec 2018 22:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11BD218FE
	for <selinux@archiver.kernel.org>; Thu, 20 Dec 2018 22:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbeLTWfJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Dec 2018 17:35:09 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:34758 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbeLTWfJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Dec 2018 17:35:09 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 85D0A5648D9
        for <selinux@vger.kernel.org>; Thu, 20 Dec 2018 23:35:05 +0100 (CET)
Received: by mail-ot1-f45.google.com with SMTP id 81so3455836otj.2
        for <selinux@vger.kernel.org>; Thu, 20 Dec 2018 14:35:05 -0800 (PST)
X-Gm-Message-State: AJcUukeSXYbikIo0nsmk0ub3BOmKRHUgg3osVu8G6ug+M/hnF9sGMOZ5
        C7xCs60g4CfBM8Bjhv/fF7gMxaaB5dtM9xHMCPQ=
X-Google-Smtp-Source: ALg8bN6EhHNCOxO/D90X5MSBKFwYZRP2yryvz2qSWwLGIWlgOdj1CUhdai8dNrHhydVlu3K+3ho1QcheeZf+N0LLaRI=
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr30938oth.338.1545345304419;
 Thu, 20 Dec 2018 14:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20181220151420.30878-1-plautrba@redhat.com> <20181220151420.30878-2-plautrba@redhat.com>
In-Reply-To: <20181220151420.30878-2-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 20 Dec 2018 23:34:53 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nuM-z=P8n-V+C7GT+mWWYv59rGre-kxky2-mpRw-2Rmg@mail.gmail.com>
Message-ID: <CAJfZ7=nuM-z=P8n-V+C7GT+mWWYv59rGre-kxky2-mpRw-2Rmg@mail.gmail.com>
Subject: Re: [PATCH 1/4] python/semanage: move valid_types initialisations to
 class constructors
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Dec 20 23:35:06 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 20, 2018 at 4:14 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Based on idea from Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Fixes:
> $ sudo semanage
> Traceback (most recent call last):
>   File "/usr/sbin/semanage", line 28, in <module>
>     import seobject
>   File "/usr/lib/python3.7/site-packages/seobject.py", line 1045, in <module>
>     class portRecords(semanageRecords):
>   File "/usr/lib/python3.7/site-packages/seobject.py", line 1047, in portRecords
>     valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
>   File "/usr/lib/python3.7/site-packages/sepolicy/__init__.py", line 203, in <genexpr>
>     return ({
>   File "/usr/lib64/python3.7/site-packages/setools/typeattrquery.py", line 65, in results
>     for attr in self.policy.typeattributes():
> AttributeError: 'NoneType' object has no attribute 'typeattributes'
>
> https://github.com/SELinuxProject/selinux/issues/81
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Why are classes ibpkeyRecords and ibendportRecords not covered by the
changes from this patch?

Nicolas

> ---
>  python/semanage/seobject.py | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index efec0a55..2b43b65c 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1043,13 +1043,15 @@ class seluserRecords(semanageRecords):
>
>
>  class portRecords(semanageRecords):
> -    try:
> -        valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
> -    except RuntimeError:
> -        valid_types = []
> +
> +    valid_types = []
>
>      def __init__(self, args = None):
>          semanageRecords.__init__(self, args)
> +        try:
> +            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
> +        except RuntimeError:
> +            pass
>
>      def __genkey(self, port, proto):
>          if proto == "tcp":
> @@ -1823,14 +1825,16 @@ class ibendportRecords(semanageRecords):
>              print(rec)
>
>  class nodeRecords(semanageRecords):
> -    try:
> -        valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_type"))[0]["types"])
> -    except RuntimeError:
> -        valid_types = []
> +
> +    valid_types = []
>
>      def __init__(self, args = None):
>          semanageRecords.__init__(self, args)
>          self.protocol = ["ipv4", "ipv6"]
> +        try:
> +            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_type"))[0]["types"])
> +        except RuntimeError:
> +            pass
>
>      def validate(self, addr, mask, protocol):
>          newaddr = addr
> @@ -2264,14 +2268,17 @@ class interfaceRecords(semanageRecords):
>
>
>  class fcontextRecords(semanageRecords):
> -    try:
> -        valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "file_type"))[0]["types"])
> -        valid_types += list(list(sepolicy.info(sepolicy.ATTRIBUTE, "device_node"))[0]["types"])
> -    except RuntimeError:
> -        valid_types = []
> +
> +    valid_types = []
>
>      def __init__(self, args = None):
>          semanageRecords.__init__(self, args)
> +        try:
> +            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "file_type"))[0]["types"])
> +            self.valid_types += list(list(sepolicy.info(sepolicy.ATTRIBUTE, "device_node"))[0]["types"])
> +        except RuntimeError:
> +            pass
> +
>          self.equiv = {}
>          self.equiv_dist = {}
>          self.equal_ind = False
> --
> 2.20.1
>

