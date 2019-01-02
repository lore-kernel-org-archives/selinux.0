Return-Path: <SRS0=NpCz=PK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5506CC43387
	for <selinux@archiver.kernel.org>; Wed,  2 Jan 2019 13:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6D2218CD
	for <selinux@archiver.kernel.org>; Wed,  2 Jan 2019 13:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfABNOI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Jan 2019 08:14:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfABNOI (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 2 Jan 2019 08:14:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E632B637EE;
        Wed,  2 Jan 2019 13:14:07 +0000 (UTC)
Received: from workstation (unknown [10.43.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DC955D757;
        Wed,  2 Jan 2019 13:14:06 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 1/4] python/semanage: move valid_types initialisations to class constructors
References: <20181220151420.30878-1-plautrba@redhat.com>
        <20181220151420.30878-2-plautrba@redhat.com>
        <CAJfZ7=nuM-z=P8n-V+C7GT+mWWYv59rGre-kxky2-mpRw-2Rmg@mail.gmail.com>
Date:   Wed, 02 Jan 2019 14:14:05 +0100
In-Reply-To: <CAJfZ7=nuM-z=P8n-V+C7GT+mWWYv59rGre-kxky2-mpRw-2Rmg@mail.gmail.com>
        (Nicolas Iooss's message of "Thu, 20 Dec 2018 23:34:53 +0100")
Message-ID: <pjd8t03urqa.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 02 Jan 2019 13:14:08 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Thu, Dec 20, 2018 at 4:14 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Based on idea from Nicolas Iooss <nicolas.iooss@m4x.org>
>>
>> Fixes:
>> $ sudo semanage
>> Traceback (most recent call last):
>>   File "/usr/sbin/semanage", line 28, in <module>
>>     import seobject
>>   File "/usr/lib/python3.7/site-packages/seobject.py", line 1045, in <module>
>>     class portRecords(semanageRecords):
>>   File "/usr/lib/python3.7/site-packages/seobject.py", line 1047, in portRecords
>>     valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
>>   File "/usr/lib/python3.7/site-packages/sepolicy/__init__.py", line 203, in <genexpr>
>>     return ({
>>   File "/usr/lib64/python3.7/site-packages/setools/typeattrquery.py", line 65, in results
>>     for attr in self.policy.typeattributes():
>> AttributeError: 'NoneType' object has no attribute 'typeattributes'
>>
>> https://github.com/SELinuxProject/selinux/issues/81
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Why are classes ibpkeyRecords and ibendportRecords not covered by the
> changes from this patch?

Because I missed that out. I'll send another set with ibendportRecords and
ibpkeyRecords covered.

Thanks!


>
> Nicolas
>
>> ---
>>  python/semanage/seobject.py | 33 ++++++++++++++++++++-------------
>>  1 file changed, 20 insertions(+), 13 deletions(-)
>>
>> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
>> index efec0a55..2b43b65c 100644
>> --- a/python/semanage/seobject.py
>> +++ b/python/semanage/seobject.py
>> @@ -1043,13 +1043,15 @@ class seluserRecords(semanageRecords):
>>
>>
>>  class portRecords(semanageRecords):
>> -    try:
>> -        valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
>> -    except RuntimeError:
>> -        valid_types = []
>> +
>> +    valid_types = []
>>
>>      def __init__(self, args = None):
>>          semanageRecords.__init__(self, args)
>> +        try:
>> +            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
>> +        except RuntimeError:
>> +            pass
>>
>>      def __genkey(self, port, proto):
>>          if proto == "tcp":
>> @@ -1823,14 +1825,16 @@ class ibendportRecords(semanageRecords):
>>              print(rec)
>>
>>  class nodeRecords(semanageRecords):
>> -    try:
>> -        valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_type"))[0]["types"])
>> -    except RuntimeError:
>> -        valid_types = []
>> +
>> +    valid_types = []
>>
>>      def __init__(self, args = None):
>>          semanageRecords.__init__(self, args)
>>          self.protocol = ["ipv4", "ipv6"]
>> +        try:
>> +            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_type"))[0]["types"])
>> +        except RuntimeError:
>> +            pass
>>
>>      def validate(self, addr, mask, protocol):
>>          newaddr = addr
>> @@ -2264,14 +2268,17 @@ class interfaceRecords(semanageRecords):
>>
>>
>>  class fcontextRecords(semanageRecords):
>> -    try:
>> -        valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "file_type"))[0]["types"])
>> -        valid_types += list(list(sepolicy.info(sepolicy.ATTRIBUTE, "device_node"))[0]["types"])
>> -    except RuntimeError:
>> -        valid_types = []
>> +
>> +    valid_types = []
>>
>>      def __init__(self, args = None):
>>          semanageRecords.__init__(self, args)
>> +        try:
>> +            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "file_type"))[0]["types"])
>> +            self.valid_types += list(list(sepolicy.info(sepolicy.ATTRIBUTE, "device_node"))[0]["types"])
>> +        except RuntimeError:
>> +            pass
>> +
>>          self.equiv = {}
>>          self.equiv_dist = {}
>>          self.equal_ind = False
>> --
>> 2.20.1
>>
