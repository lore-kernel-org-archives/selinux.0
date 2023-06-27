Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBCFEB64DC
	for <selinux@archiver.kernel.org>; Tue, 27 Jun 2023 15:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjF0P5z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Jun 2023 11:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjF0P5s (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Jun 2023 11:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BBE2D63
        for <selinux@vger.kernel.org>; Tue, 27 Jun 2023 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687881422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/OeQmyiVFLEW5GI1xke7Nl9/+XXlPUBwmY+nlinH3hA=;
        b=L0L9tg4wvCQehgrII1Z1ZEOrmcyVGD+SbEtA5V7ZAfhQJMrLiT4H2v51ITTaLvx58hO0JV
        13WAPShNUyS5sGgH8lEVCtSjWSgCgA04J74V/w+3CoVVXDQT4ZCb0fK6FM3pVq4aDUJ7fy
        vaE/zcj8thmwjuoVsQcswnEvD4aczmE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-NBJwdJqwOGujcPk58fWnng-1; Tue, 27 Jun 2023 11:56:01 -0400
X-MC-Unique: NBJwdJqwOGujcPk58fWnng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4189C92E4C0;
        Tue, 27 Jun 2023 15:56:01 +0000 (UTC)
Received: from localhost (unknown [10.45.225.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3256C09A07;
        Tue, 27 Jun 2023 15:56:00 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     Topi Miettinen <toiwoton@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH v4] semanage, sepolicy: list also ports not attributed
 with port_type
In-Reply-To: <20230617113043.6359-1-toiwoton@gmail.com>
References: <20230617113043.6359-1-toiwoton@gmail.com>
Date:   Tue, 27 Jun 2023 17:56:00 +0200
Message-ID: <87o7l0292n.fsf@redhat.com>
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
> v4: keep types found with attribute port_type for compatibility with types
>     which are not portcons
> v3: use even better version, thanks to Petr Lautrbach
> v2: fix other cases and use better version courtesy of Petr Lautrbach
> ---
>  python/semanage/semanage-bash-completion.sh | 2 +-
>  python/semanage/seobject.py                 | 2 +-
>  python/sepolicy/sepolicy-bash-completion.sh | 2 +-
>  python/sepolicy/sepolicy/__init__.py        | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
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
>  __get_all_domains () { 
>      seinfo -adomain -x 2>/dev/null | tail -n +2 
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index d82da494..31e73ee9 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1055,7 +1055,7 @@ class portRecords(semanageRecords):
>      def __init__(self, args = None):
>          semanageRecords.__init__(self, args)
>          try:
> -            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
> +            self.valid_types = [x["type"] for x in [*sepolicy.info(sepolicy.ATTRIBUTE, "port_type"), *sepolicy.info(sepolicy.PORT)]]

 >>> valid_types = [x["type"] for x in [*sepolicy.info(sepolicy.ATTRIBUTE, "port_type"), *sepolicy.info(sepolicy.PORT)]]
 Traceback (most recent call last):
   File "<stdin>", line 1, in <module>
   File "<stdin>", line 1, in <listcomp>
 KeyError: 'type'


I guess you need something like:

self.valid_types = set(next(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))["types"] + [x["type"] for x in sepolicy.info(sepolicy.PORT)])

set() would drop duplicates, next() gets first value from the iterator
created by sepolicy.info()  and it's concatenated with type's from
sepolicy.info(sepolicy.PORT)



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
>  __get_all_domain_types () {
>      seinfo -adomain -x 2> /dev/null | tail -n +2
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index c177cdfc..be6ddc18 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -989,8 +989,8 @@ def get_all_port_types():
>      global port_types
>      if port_types:
>          return port_types
> -    port_types = list(sorted(info(ATTRIBUTE, "port_type"))[0]["types"])
> -    return port_types
> +    port_types = [x["type"] for x in [*info(ATTRIBUTE, "port_type"), *info(PORT)]]
> +    return sorted(port_types)
>  
>  
>  def get_all_bools():
> -- 
> 2.39.2

