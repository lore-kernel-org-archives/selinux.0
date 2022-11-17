Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB90CC4332F
	for <selinux@archiver.kernel.org>; Thu, 17 Nov 2022 12:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239627AbiKQMoQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Nov 2022 07:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbiKQMnv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Nov 2022 07:43:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ECD79E26
        for <selinux@vger.kernel.org>; Thu, 17 Nov 2022 04:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668688791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FNNCqextcUI24To/U3AKzB6/MXDcQ/R5Q62c+g3iiXc=;
        b=YiDC6hoGbAZrV8ahNbMHq2iUDzFqZLmq4X1FwCRLvB5mT4O4SP9+4K0pkP+xEG1UjIR4R6
        NlSvvEjbKHXEJ3QPv8ZCCMUP8DDSuKPsWpeaOcAB+WTJKwg95qsdqNt7+kh0L4Xa0D505h
        W2Frfs3YwzdyKaQd/QARVzcF68jeCmQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-c_Y6-A7iP-ejRMNof_tz5w-1; Thu, 17 Nov 2022 07:39:49 -0500
X-MC-Unique: c_Y6-A7iP-ejRMNof_tz5w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A120185A7A3;
        Thu, 17 Nov 2022 12:39:49 +0000 (UTC)
Received: from localhost (ovpn-193-43.brq.redhat.com [10.40.193.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E82E949BB60;
        Thu, 17 Nov 2022 12:39:48 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH v2 1/3] python/sepolicy: Fix sepolicy manpage -w ...
In-Reply-To: <CAP+JOzSM8QkAKiKVk+dUFagFu-zJ2GCzcjnY0mYqX3Hh=p7AUA@mail.gmail.com>
References: <20221115194552.338640-1-plautrba@redhat.com>
 <CAP+JOzSM8QkAKiKVk+dUFagFu-zJ2GCzcjnY0mYqX3Hh=p7AUA@mail.gmail.com>
Date:   Thu, 17 Nov 2022 13:39:48 +0100
Message-ID: <87mt8p21rf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Tue, Nov 15, 2022 at 2:58 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> From: Petr Lautrbach <lautrbach@redhat.com>
>>
>> Commit 7494bb1298b3 ("sepolicy: generate man pages in parallel")
>> improved sepolicy performance but broke `sepolicy manpage -w ...` as it
>> didn't collect data about domains and roles from ManPage() and so
>> HTMLManPages() generated only empty page. This is fixed now, domains
>> and roles are being collected and used for HTML pages.
>>
>> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> I ran `sepolicy manpage -w -d unconfined_t` and received the following error:
> """
> Traceback (most recent call last):
>   File "/usr/lib64/python3.10/multiprocessing/pool.py", line 125, in worker
>     result = (True, func(*args, **kwds))
>   File "/home/jim/local/usr/bin/./sepolicy", line 335, in manpage_work
>     return (m.manpage_domains, m.manpage_roles)
> AttributeError: 'ManPage' object has no attribute 'manpage_domains'
> """
>

I think you nee to remove "-Es" command line options from /home/jim/local/usr/bin/./sepolicy

    sed -i '1s/ -Es//' /home/jim/local/usr/bin/./sepolicy


> I don't get the error from the master branch, but I do confirm the bug
> you reported above.
>
> Thanks,
> Jim
>
>> ---
>>  python/sepolicy/sepolicy.py         | 13 +++++++++++--
>>  python/sepolicy/sepolicy/manpage.py | 12 +++++-------
>>  2 files changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
>> index 733d40484709..2ca02ee9a0cf 100755
>> --- a/python/sepolicy/sepolicy.py
>> +++ b/python/sepolicy/sepolicy.py
>> @@ -332,9 +332,10 @@ def manpage_work(domain, path, root, source_files, web):
>>      from sepolicy.manpage import ManPage
>>      m = ManPage(domain, path, root, source_files, web)
>>      print(m.get_man_page_path())
>> +    return (m.manpage_domains, m.manpage_roles)
>>
>>  def manpage(args):
>> -    from sepolicy.manpage import HTMLManPages, manpage_domains, manpage_roles, gen_domains
>> +    from sepolicy.manpage import HTMLManPages, gen_domains
>>
>>      path = args.path
>>      if not args.policy and args.root != "/":
>> @@ -347,9 +348,17 @@ def manpage(args):
>>      else:
>>          test_domains = args.domain
>>
>> +    manpage_domains = set()
>> +    manpage_roles = set()
>>      p = Pool()
>> +    async_results = []
>>      for domain in test_domains:
>> -        p.apply_async(manpage_work, [domain, path, args.root, args.source_files, args.web])
>> +        async_results.append(p.apply_async(manpage_work, [domain, path, args.root, args.source_files, args.web]))
>> +    results = map(lambda x: x.get(), async_results)
>> +    for result in results:
>> +        manpage_domains.update(set(result[0]))
>> +        manpage_roles.update(set(result[1]))
>> +
>>      p.close()
>>      p.join()
>>
>> diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
>> index 3e61e333193f..de72cb6cda5f 100755
>> --- a/python/sepolicy/sepolicy/manpage.py
>> +++ b/python/sepolicy/sepolicy/manpage.py
>> @@ -21,7 +21,7 @@
>>  #                                        02111-1307  USA
>>  #
>>  #
>> -__all__ = ['ManPage', 'HTMLManPages', 'manpage_domains', 'manpage_roles', 'gen_domains']
>> +__all__ = ['ManPage', 'HTMLManPages', 'gen_domains']
>>
>>  import string
>>  import selinux
>> @@ -147,10 +147,6 @@ def _gen_types():
>>  def prettyprint(f, trim):
>>      return " ".join(f[:-len(trim)].split("_"))
>>
>> -# for HTML man pages
>> -manpage_domains = []
>> -manpage_roles = []
>> -
>>  fedora_releases = ["Fedora17", "Fedora18"]
>>  rhel_releases = ["RHEL6", "RHEL7"]
>>
>> @@ -408,6 +404,8 @@ class ManPage:
>>      """
>>      modules_dict = None
>>      enabled_str = ["Disabled", "Enabled"]
>> +    manpage_domains = []
>> +    manpage_roles = []
>>
>>      def __init__(self, domainname, path="/tmp", root="/", source_files=False, html=False):
>>          self.html = html
>> @@ -453,10 +451,10 @@ class ManPage:
>>          if self.domainname + "_r" in self.all_roles:
>>              self.__gen_user_man_page()
>>              if self.html:
>> -                manpage_roles.append(self.man_page_path)
>> +                self.manpage_roles.append(self.man_page_path)
>>          else:
>>              if self.html:
>> -                manpage_domains.append(self.man_page_path)
>> +                self.manpage_domains.append(self.man_page_path)
>>              self.__gen_man_page()
>>          self.fd.close()
>>
>> --
>> 2.38.1
>>

