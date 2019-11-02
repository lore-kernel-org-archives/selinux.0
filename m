Return-Path: <SRS0=8S61=Y2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C61ACA9EC7
	for <selinux@archiver.kernel.org>; Sat,  2 Nov 2019 20:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B34721783
	for <selinux@archiver.kernel.org>; Sat,  2 Nov 2019 20:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfKBUSq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 2 Nov 2019 16:18:46 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:43037 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfKBUSq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 2 Nov 2019 16:18:46 -0400
X-Originating-IP: 90.30.224.191
Received: from windsurf.home (apoitiers-658-1-73-191.w90-30.abo.wanadoo.fr [90.30.224.191])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 59457C0002;
        Sat,  2 Nov 2019 20:18:44 +0000 (UTC)
Date:   Sat, 2 Nov 2019 21:18:43 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 1/4] libselinux: compile Python bytecode when installing
 Python files
Message-ID: <20191102211843.70b6037f@windsurf.home>
In-Reply-To: <20191102172812.22492-1-nicolas.iooss@m4x.org>
References: <20191102172812.22492-1-nicolas.iooss@m4x.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello Nicolas,

On Sat,  2 Nov 2019 18:28:09 +0100
Nicolas Iooss <nicolas.iooss@m4x.org> wrote:

> When selinux module is imported from a Python script, the content of
> __init__.py is compiled into bytecode and the result is saved into a
> file if it is allowed. For example, when root runs with Python 3.7 a
> script that uses "import selinux" on a system where SELinux is in
> permissive mode, this file may be created:
> 
>     /usr/lib/python3.7/site-packages/selinux/__pycache__/__init__.cpython-37.pyc
> 
> Prevent this file from being dynamically created by creating it when
> libselinux is installed, using "python -m compileall".
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

As far as I know, this not typically done by "setup.py install", and
this is generally left to distributions.

In the context of Buildroot [1], we do the byte-compilation all at once
at the very end of the build of all packages. Having individual
packages do their own byte-compilation would be annoying.

If you would like to have this byte-compilation done by the SELinux
Makefile, could you make it optional (even if you decide to enable it
by default) ?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
