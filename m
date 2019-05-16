Return-Path: <SRS0=VlsA=TQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FADC04AAF
	for <selinux@archiver.kernel.org>; Thu, 16 May 2019 15:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1480F2082E
	for <selinux@archiver.kernel.org>; Thu, 16 May 2019 15:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfEPPhx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 May 2019 11:37:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEPPhx (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 16 May 2019 11:37:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A36330832E4
        for <selinux@vger.kernel.org>; Thu, 16 May 2019 15:37:53 +0000 (UTC)
Received: from localhost (unknown [10.43.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45A185D6A9
        for <selinux@vger.kernel.org>; Thu, 16 May 2019 15:37:53 +0000 (UTC)
User-agent: mu4e 1.0; emacs 26.2
From:   Petr Lautrbach <plautrba@redhat.com>
To:     "selinux\@vger.kernel.org" <selinux@vger.kernel.org>
Subject: ImportError: cannot import name '_selinux' from 'selinux' with swig-4.0.0
Date:   Thu, 16 May 2019 17:37:51 +0200
Message-ID: <pjdr28yxve8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 16 May 2019 15:37:53 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

selinux python module can't be imported when it's built using
swig-4.0.0:

>>> import selinux
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "/usr/lib64/python3.7/site-packages/selinux/__init__.py", 
  line 13, in <module>
    from . import _selinux
ImportError: cannot import name '_selinux' from 'selinux' 
(/usr/lib64/python3.7/site-packages/selinux/__init__.py)
>>>

You can see it at [1]

The reason is that swig changed the way how it generates 
__init__.py.
Now it uses:
from . import _selinux

I've started to rewrite libselinux in order not to build and 
install
python bindings manually, but to use python distutils [2]. It 
still fails
on travis but I was able to built it and use it on my local 
rawhide machine.


[1] 
https://groups.google.com/forum/#!topic/kernel-secnext/rGZxB39atVQ
[2] 
https://github.com/bachradsusi/SELinuxProject-selinux/commits/swig-use-python-distutils
