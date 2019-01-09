Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AFDC43387
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 12:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B432075C
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 12:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfAIMT2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:19:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfAIMT2 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 9 Jan 2019 07:19:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27714C050E08;
        Wed,  9 Jan 2019 12:19:28 +0000 (UTC)
Received: from workstation (unknown [10.43.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70DD8608DA;
        Wed,  9 Jan 2019 12:19:26 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 1/1] scripts/run-flake8: run on Python scripts not ending with .py
References: <20190105155953.19583-1-nicolas.iooss@m4x.org>
        <pjdef9nnvkb.fsf@redhat.com>
Date:   Wed, 09 Jan 2019 13:19:25 +0100
In-Reply-To: <pjdef9nnvkb.fsf@redhat.com> (Petr Lautrbach's message of "Tue,
        08 Jan 2019 14:11:16 +0100")
Message-ID: <pjd1s5mgh0y.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 09 Jan 2019 12:19:28 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>
>> When running flake8 on a directory, it does not analyze files without an
>> extension, like semanage_migrate_store, mlscolor-test, etc. Use grep to
>> find files with a Python shebang and build a list which is then given to
>> flake8.
>>
>> This commit is possible now that some clean-up patches have been
>> applied, such as commit 69c56bd2f6e9 ("python/chcat: improve the code
>> readability") and b7227aaec1da ("mcstrans: fix Python linter warnings on
>> test scripts") and 3cb974d2d2a7 ("semanage_migrate_store: fix many
>> Python linter warnings").
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>
> https://github.com/SELinuxProject/selinux/pull/128

And it's merged now.

>
>> ---
>>  scripts/run-flake8 | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/scripts/run-flake8 b/scripts/run-flake8
>> index 6ad029fa6852..24b1202fde99 100755
>> --- a/scripts/run-flake8
>> +++ b/scripts/run-flake8
>> @@ -4,6 +4,11 @@
>>  # Run on the base directory if no argument has been given
>>  if [ $# -eq 0 ] ; then
>>      cd "$(dirname -- "$0")/.." || exit $?
>> +
>> +    # Run on both files ending with .py and Python files without extension
>> +    # shellcheck disable=SC2046
>> +    set -- $( (find . -name '*.py' ; grep --exclude-dir=.git -l -e '^#!\s*/usr/bin/python' -e '^#!/usr/bin/env python' -r .) | sort -u )
>> +    echo "Analyzing $# Python scripts"
>>  fi
>>  
>>  # Assign each ignore warning on a line, in order to ease testing enabling the warning again
