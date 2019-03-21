Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC68FC43381
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 12:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C0B218A5
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 12:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfCUMGd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:06:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfCUMGd (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 21 Mar 2019 08:06:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0710330BC643;
        Thu, 21 Mar 2019 12:06:33 +0000 (UTC)
Received: from localhost (ovpn-204-57.brq.redhat.com [10.40.204.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E24F60857;
        Thu, 21 Mar 2019 12:06:32 +0000 (UTC)
References: <20190321100439.7130-1-bigon@debian.org>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Laurent Bigonville <bigon@debian.org>
Subject: Re: [PATCH] restorecond: Do not link against libpcre
In-reply-to: <20190321100439.7130-1-bigon@debian.org>
Date:   Thu, 21 Mar 2019 13:06:30 +0100
Message-ID: <pjdk1gsig8p.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 21 Mar 2019 12:06:33 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Laurent Bigonville <bigon@debian.org> writes:

> From: Laurent Bigonville <bigon@bigon.be>
>
> For some reasons, restorecond was explicitly linking against 
> libpcre but
> the code is not using any of its symbols
>
> Closes: https://github.com/SELinuxProject/selinux/issues/137
>
> Signed-off-by: Laurent Bigonville <bigon@bigon.be>

It looks likes it was accidentally added by commit
50f0910cf05bdc1d10710c7c3fb748a178473387 ("libselinux: add support 
for pcre2")


Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
>  restorecond/Makefile | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/restorecond/Makefile b/restorecond/Makefile
> index b81f8c82..12452cd2 100644
> --- a/restorecond/Makefile
> +++ b/restorecond/Makefile
> @@ -19,17 +19,7 @@ DBUSLIB = $(shell $(PKG_CONFIG) --libs 
> dbus-glib-1)
>  CFLAGS ?= -g -Werror -Wall -W
>  override CFLAGS += $(DBUSFLAGS)
>  
> -USE_PCRE2 ?= n
> -ifeq ($(USE_PCRE2),y)
> -	PCRE_CFLAGS := -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 
> $(shell $(PKG_CONFIG) --cflags libpcre2-8)
> -	PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs libpcre2-8)
> -else
> -	PCRE_CFLAGS := $(shell $(PKG_CONFIG) --cflags libpcre)
> -	PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs libpcre)
> -endif
> -export PCRE_CFLAGS PCRE_LDLIBS
> -
> -override LDLIBS += -lselinux $(PCRE_LDLIBS) $(DBUSLIB)
> +override LDLIBS += -lselinux $(DBUSLIB)
>  
>  all: restorecond

