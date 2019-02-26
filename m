Return-Path: <SRS0=cnGJ=RB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C100CC43381
	for <selinux@archiver.kernel.org>; Tue, 26 Feb 2019 13:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9552B217F9
	for <selinux@archiver.kernel.org>; Tue, 26 Feb 2019 13:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfBZNWA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:22:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58483 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfBZNWA (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 26 Feb 2019 08:22:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1CDA307D846;
        Tue, 26 Feb 2019 13:21:59 +0000 (UTC)
Received: from workstation (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EA8160C03;
        Tue, 26 Feb 2019 13:21:58 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 1/3] Always use /usr/bin/python3 in Python scripts
References: <20190220160446.23150-1-plautrba@redhat.com>
        <20190220160446.23150-2-plautrba@redhat.com>
        <CAJfZ7=kL2D5K9J-+C8bK4KqeEV4qQed745AMrAZ+BhH=ODiihQ@mail.gmail.com>
Date:   Tue, 26 Feb 2019 14:21:57 +0100
In-Reply-To: <CAJfZ7=kL2D5K9J-+C8bK4KqeEV4qQed745AMrAZ+BhH=ODiihQ@mail.gmail.com>
        (Nicolas Iooss's message of "Thu, 21 Feb 2019 21:17:18 +0100")
Message-ID: <pjdo96ylm6i.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 26 Feb 2019 13:21:59 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Wed, Feb 20, 2019 at 5:04 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> For the 3 patches:
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged.

>> ---
>>  dbus/selinux_server.py                   | 2 +-
>>  libsemanage/utils/semanage_migrate_store | 2 +-
>>  mcstrans/share/util/mlscolor-test        | 2 +-
>>  mcstrans/share/util/mlstrans-test        | 2 +-
>>  python/semanage/semanage                 | 2 +-
>>  sandbox/start                            | 2 +-
>>  6 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
>> index 6e380e58..98ab53dd 100644
>> --- a/dbus/selinux_server.py
>> +++ b/dbus/selinux_server.py
>> @@ -1,4 +1,4 @@
>> -#!/usr/bin/python
>> +#!/usr/bin/python3
>>
>>  import dbus
>>  import dbus.service
>> diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
>> index 018b1a3e..c6caf3bf 100755
>> --- a/libsemanage/utils/semanage_migrate_store
>> +++ b/libsemanage/utils/semanage_migrate_store
>> @@ -1,4 +1,4 @@
>> -#!/usr/bin/python -E
>> +#!/usr/bin/python3 -E
>>
>>
>>  from __future__ import print_function
>> diff --git a/mcstrans/share/util/mlscolor-test b/mcstrans/share/util/mlscolor-test
>> index 03fc4be4..240e996d 100644
>> --- a/mcstrans/share/util/mlscolor-test
>> +++ b/mcstrans/share/util/mlscolor-test
>> @@ -1,4 +1,4 @@
>> -#!/usr/bin/python -E
>> +#!/usr/bin/python3 -E
>>  import sys
>>  import selinux
>>
>> diff --git a/mcstrans/share/util/mlstrans-test b/mcstrans/share/util/mlstrans-test
>> index c026d00e..085fa82d 100644
>> --- a/mcstrans/share/util/mlstrans-test
>> +++ b/mcstrans/share/util/mlstrans-test
>> @@ -1,4 +1,4 @@
>> -#!/usr/bin/python -E
>> +#!/usr/bin/python3 -E
>>  import sys
>>  import selinux
>>
>> diff --git a/python/semanage/semanage b/python/semanage/semanage
>> index d6d68248..144cc000 100644
>> --- a/python/semanage/semanage
>> +++ b/python/semanage/semanage
>> @@ -1,4 +1,4 @@
>> -#! /usr/bin/python3 -Es
>> +#!/usr/bin/python3 -Es
>>  # Copyright (C) 2012-2013 Red Hat
>>  # AUTHOR: Miroslav Grepl <mgrepl@redhat.com>
>>  # AUTHOR: David Quigley <selinux@davequigley.com>
>> diff --git a/sandbox/start b/sandbox/start
>> index 7f83532f..4ed3cb5c 100644
>> --- a/sandbox/start
>> +++ b/sandbox/start
>> @@ -1,4 +1,4 @@
>> -#! /usr/bin/python -Es
>> +#!/usr/bin/python3 -Es
>>  try:
>>      from subprocess import getstatusoutput
>>  except ImportError:
>> --
>> 2.20.1
>>
