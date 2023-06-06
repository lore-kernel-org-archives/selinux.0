Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A198C7EE24
	for <selinux@archiver.kernel.org>; Tue,  6 Jun 2023 10:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjFFKCE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jun 2023 06:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjFFKCD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jun 2023 06:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E4AF3
        for <selinux@vger.kernel.org>; Tue,  6 Jun 2023 03:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686045672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=axJl9kAS0oLgwkpDP21VkRhXbEHO89mBGrVzHDjd7Nk=;
        b=EuUP7lKp6/OS++WRkkI12sXlPAwcAQywJOsJ4eoFn7tUIlkLZwk4m18GmaCX3fgNZpfJ1d
        7NkVBryDP9C/4dnhEdrm6Y4RXYjYN+IxugnuA5CuPZAwoZ3B33o4wh0Yxs028pfp0UnosQ
        z57vjdkrO/CFWld7pS/jjkukzVxWynE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-X231oeY8PTmY5lkV6L2eZQ-1; Tue, 06 Jun 2023 06:01:11 -0400
X-MC-Unique: X231oeY8PTmY5lkV6L2eZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77530185A791;
        Tue,  6 Jun 2023 10:01:10 +0000 (UTC)
Received: from localhost (unknown [10.45.224.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36C1CC1603B;
        Tue,  6 Jun 2023 10:01:10 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Topi Miettinen <toiwoton@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH v2] semanage, sepolicy: list also ports not attributed
 with port_type
In-Reply-To: <20230602190720.12623-1-toiwoton@gmail.com>
References: <20230602190720.12623-1-toiwoton@gmail.com>
Date:   Tue, 06 Jun 2023 12:01:09 +0200
Message-ID: <87o7lsj4ey.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Topi Miettinen <toiwoton@gmail.com> writes:

> For `semanage port -l` and `sepolicy network -t type`, show also ports
> which are not attributed with `port_type`. Such ports may exist in
> custom policies and even the attribute `port_type` may not be defined.
>
> This fixes the following error with `semanage port -l` (and similar
> error with `sepolicy network -t type`):
>
> Traceback (most recent call last):
>   File "/usr/sbin/semanage", line 975, in <module>
>     do_parser()
>   File "/usr/sbin/semanage", line 947, in do_parser
>     args.func(args)
>   File "/usr/sbin/semanage", line 441, in handlePort
>     OBJECT = object_dict['port'](args)
>              ^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3/dist-packages/seobject.py", line 1057, in __init__
>     self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
>                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^
> IndexError: list index out of range
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>
> ---
>
> v2: fix other cases and use better version courtesy of Petr Lautrbach
> ---
>  python/semanage/semanage-bash-completion.sh | 2 +-
>  python/semanage/seobject.py                 | 2 +-
>  python/sepolicy/sepolicy-bash-completion.sh | 2 +-
>  python/sepolicy/sepolicy/__init__.py        | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/python/semanage/semanage-bash-completion.sh b/python/semanage/semanage-bash-completion.sh
> index d0dd139f..1e3f6f9d 100644
> --- a/python/semanage/semanage-bash-completion.sh
> +++ b/python/semanage/semanage-bash-completion.sh
> @@ -37,7 +37,7 @@ __get_all_types () {
>      seinfo -t 2> /dev/null | tail -n +3 
>  }
>  __get_all_port_types () { 
> -    seinfo -aport_type -x 2>/dev/null | tail -n +2 
> +    sepolicy network -l
>  }

I support this change but it could have a side effect on distributions.
E.g. in Fedora we ship semanage bash completion in
policycoreutils-python-utils while sepolicy in policycoreutils-devel. On
the other hand seinfo is in setools-console package which is not required by
policycoreutils-python-utils so completions would not work anyway.

From upstream POV, it improves the situation so unless there's any other
objection from other distribution maintainers I would not block it..




>  __get_all_domains () { 
>      seinfo -adomain -x 2>/dev/null | tail -n +2 
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index d82da494..21a6fc91 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1055,7 +1055,7 @@ class portRecords(semanageRecords):
>      def __init__(self, args = None):
>          semanageRecords.__init__(self, args)
>          try:
> -            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
> +            self.valid_types = [x["type"] for x in list(list(sepolicy.info(sepolicy.PORT)))]

I know it's suggested by me. But looking on to it I see repeating list()
which is unnecessary. sepolicy.info() returns a generator and so the new
list could be constructed directly from it:

[x["type"] for x in sepolicy.info(sepolicy.PORT)]


>          except RuntimeError:
>              pass
>  
> diff --git a/python/sepolicy/sepolicy-bash-completion.sh b/python/sepolicy/sepolicy-bash-completion.sh
> index 13638e4d..467333b8 100644
> --- a/python/sepolicy/sepolicy-bash-completion.sh
> +++ b/python/sepolicy/sepolicy-bash-completion.sh
> @@ -52,7 +52,7 @@ __get_all_classes () {
>      seinfo -c 2> /dev/null | tail -n +2
>  }
>  __get_all_port_types () {
> -    seinfo -aport_type -x 2> /dev/null | tail -n +2
> +    sepolicy network -l
>  }

Here the change does not have any side effect and improves the
functionality

>  __get_all_domain_types () {
>      seinfo -adomain -x 2> /dev/null | tail -n +2
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index c177cdfc..76ac7797 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -989,7 +989,7 @@ def get_all_port_types():
>      global port_types
>      if port_types:
>          return port_types
> -    port_types = list(sorted(info(ATTRIBUTE, "port_type"))[0]["types"])
> +    port_types = [x["type"] for x in list(list(info(PORT)))]

[x["type"] for x in info(PORT)]

>      return port_types
>  
>  
> -- 
> 2.39.2

