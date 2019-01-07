Return-Path: <SRS0=ZupP=PP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BF2C43387
	for <selinux@archiver.kernel.org>; Mon,  7 Jan 2019 11:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8161D205C9
	for <selinux@archiver.kernel.org>; Mon,  7 Jan 2019 11:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfAGL7T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:59:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfAGL7S (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 7 Jan 2019 06:59:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A70F37F6B2;
        Mon,  7 Jan 2019 11:59:18 +0000 (UTC)
Received: from workstation (unknown [10.40.205.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5209600C5;
        Mon,  7 Jan 2019 11:59:17 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 2/2] python/sepolgen: close /etc/selinux/sepolgen.conf after parsing it
References: <20190105154551.18768-1-nicolas.iooss@m4x.org>
        <20190105154551.18768-2-nicolas.iooss@m4x.org>
        <CAJfZ7=k4AVpMBRg1=DKuR0i3BM=CT=0DxVBjwydeWRe__dyX3A@mail.gmail.com>
Date:   Mon, 07 Jan 2019 12:59:16 +0100
In-Reply-To: <CAJfZ7=k4AVpMBRg1=DKuR0i3BM=CT=0DxVBjwydeWRe__dyX3A@mail.gmail.com>
        (Nicolas Iooss's message of "Sat, 5 Jan 2019 16:49:38 +0100")
Message-ID: <pjdsgy4oezv.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 07 Jan 2019 11:59:18 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Sat, Jan 5, 2019 at 4:46 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>>
>> sepolgen testsuite reports the following warning on a system with
>> /etc/selinux/sepolgen.conf:
>>
>>     .../src/./sepolgen/defaults.py:35: ResourceWarning: unclosed file
>>     <_io.TextIOWrapper name='/etc/selinux/sepolgen.conf' mode='r'
>>     encoding='UTF-8'>
>>
>> Fix this by properly closing the file in PathChooser.__init__().
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Oops, I already sent this patch a few weeks ago with three over
> patches but nobody has reviewed them. Should I merge it directly?
>
> Nicolas

Both patches merged. Thanks!


>
>> ---
>>  python/sepolgen/src/sepolgen/defaults.py | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/python/sepolgen/src/sepolgen/defaults.py b/python/sepolgen/src/sepolgen/defaults.py
>> index 199acfafe4cf..533a90412475 100644
>> --- a/python/sepolgen/src/sepolgen/defaults.py
>> +++ b/python/sepolgen/src/sepolgen/defaults.py
>> @@ -32,12 +32,13 @@ class PathChooser(object):
>>          self.config_pathname = pathname
>>          ignore = re.compile(r"^\s*(?:#.+)?$")
>>          consider = re.compile(r"^\s*(\w+)\s*=\s*(.+?)\s*$")
>> -        for lineno, line in enumerate(open(pathname)):
>> -            if ignore.match(line): continue
>> -            mo = consider.match(line)
>> -            if not mo:
>> -                raise ValueError("%s:%d: line is not in key = value format" % (pathname, lineno+1))
>> -            self.config[mo.group(1)] = mo.group(2)
>> +        with open(pathname, "r") as fd:
>> +            for lineno, line in enumerate(fd):
>> +                if ignore.match(line): continue
>> +                mo = consider.match(line)
>> +                if not mo:
>> +                    raise ValueError("%s:%d: line is not in key = value format" % (pathname, lineno+1))
>> +                self.config[mo.group(1)] = mo.group(2)
>>
>>      # We're only exporting one useful function, so why not be a function
>>      def __call__(self, testfilename, pathset="SELINUX_DEVEL_PATH"):
>> --
>> 2.20.1
>>
