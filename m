Return-Path: <SRS0=5LoH=RS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D01C43381
	for <selinux@archiver.kernel.org>; Fri, 15 Mar 2019 16:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8326221871
	for <selinux@archiver.kernel.org>; Fri, 15 Mar 2019 16:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbfCOQMz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:12:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729440AbfCOQMz (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 15 Mar 2019 12:12:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9418610FAF
        for <selinux@vger.kernel.org>; Fri, 15 Mar 2019 16:12:55 +0000 (UTC)
Received: from localhost (unknown [10.43.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A45A605CA
        for <selinux@vger.kernel.org>; Fri, 15 Mar 2019 16:12:55 +0000 (UTC)
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     "selinux\@vger.kernel.org" <selinux@vger.kernel.org>
Subject: ANN: SELinux userspace release 2019-03-15 / 2.9
Date:   Fri, 15 Mar 2019 17:12:53 +0100
Message-ID: <pjda7hw5d6i.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 15 Mar 2019 16:12:55 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The 2019-03-15 / 2.9 release for the SELinux userspace is now 
available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Thanks to all the contributors to this release!

User-visible changes:

* Spelling errors were fixed in libselinux man pages

* audit2allow supports xperms now. There are new '-x'/'--xperms' 
  options which
turn on generating of extended permisssion AV rules.

* semanage login is fixed in order not to log two audit events 
  which one of them
was correct.

* libsemanage resets umask before creating directories so that 
  file permissions
should not change after a change is committed. 

* Correct user name is used in ROLE_REMOVE audit events

* The noise produced by checkpolicy command line tool is reduced 
  now.

* A new option '-S' or '--sort' is added to checkpolicy to sort 
  the ocontexts
before writing out the binary policy.

* sepolicy and semanage accept aliases now.

* Deprecated at_console statement was removed from dbus 
  configuration.

* semanage export output includes ibpkey and ibendport now.

* audit2why can be run as non-root user now.

* Added russian translations for man pages

* setfiles can once again be used on SELinux-disabled hosts to 
  label files,

* setfiles and restorecon once again correctly ignore files with 
  customizable
types,

* semanage login no longer fails if used with a group that has 
  many members,

* semanage boolean no longer fails if listing for a policy store 
  other than the
active one.

* By default, /usr/bin/python3 is used by Python scripts and for 
  building modules
with python bindings.

Packaging-relevant changes:

* Usage of DESTDIR in restorecond is consistent with other 
  directories now

* By default, /usr/bin/python3 is used by Python scripts and for 
  building modules
with python bindings. It's possible to switch to Python 2 using 
the following commands:

$ pathfix.py -i/usr/bin/python `git grep -l -E 
'^#!.*/usr/bin/python'`
$ make PYTHON=/usr/bin/python` to use Python 2 .

Issues fixed:

* https://github.com/SELinuxProject/selinux/issues/81
* https://github.com/SELinuxProject/selinux/issues/97
* https://github.com/SELinuxProject/selinux/issues/108
* https://github.com/SELinuxProject/selinux/issues/109
* https://github.com/SELinuxProject/selinux/issues/119
* https://github.com/SELinuxProject/selinux/issues/121
* https://github.com/SELinuxProject/selinux/issues/123
