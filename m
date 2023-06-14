Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C737BEB64D9
	for <selinux@archiver.kernel.org>; Wed, 14 Jun 2023 10:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243155AbjFNKEX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Jun 2023 06:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243114AbjFNKEW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Jun 2023 06:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05C21B2
        for <selinux@vger.kernel.org>; Wed, 14 Jun 2023 03:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686737014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=21gY+LGDNrKmMydiwZ+WG9YmN+GGmQxTHbDAenytWcY=;
        b=Vz4S07vGfZQBGEfgb9X6zXdm2qtdpZ1EhyenQW29rYzf3zyHTa9pAHQVHjCp99KXdK2Pje
        ogcnfim98fPTZxQFWr4AO4bsh/U1EJKFHiEVW69CME26fB9L9izaIZcBoFRlFZnOSb+kYA
        CpAI02h74yFvzmeSK01H3pXK2j9vvW8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-PvvWr7uAPoiFcWysQg6-pg-1; Wed, 14 Jun 2023 06:03:33 -0400
X-MC-Unique: PvvWr7uAPoiFcWysQg6-pg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FAF1185A78E;
        Wed, 14 Jun 2023 10:03:33 +0000 (UTC)
Received: from localhost (unknown [10.45.224.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC40A1121314;
        Wed, 14 Jun 2023 10:03:32 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Topi Miettinen <toiwoton@gmail.com>, selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH v3] semanage, sepolicy: list also ports not attributed
 with port_type
In-Reply-To: <20230613180756.12978-1-toiwoton@gmail.com>
References: <20230613180756.12978-1-toiwoton@gmail.com>
Date:   Wed, 14 Jun 2023 12:03:29 +0200
Message-ID: <87bkhinyxa.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
> v3: use even better version, thanks to Petr Lautrbach
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
>  __get_all_domains () { 
>      seinfo -adomain -x 2>/dev/null | tail -n +2 
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index d82da494..323aae3f 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1055,7 +1055,7 @@ class portRecords(semanageRecords):
>      def __init__(self, args = None):
>          semanageRecords.__init__(self, args)
>          try:
> -            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
> +            self.valid_types = [x["type"] for x in sepolicy.info(sepolicy.PORT)]
>          except RuntimeError:
>              pass

It looked good to me but I was getting different number of types when I
searched for `port_type` attribute method and for `portcon` (seinfo
--portcon).

So I compared lists and checked differences and it turned out that this
would break using `semanage port -a ...` for all policies based on
refpolicy.

In refpolicy there are types with `port_type` attribute but without any
`portcon` statement, see this commit 
https://github.com/SELinuxProject/refpolicy/commit/a108d9db60747a887f626b99cce37738462dd3cd

SELinux notebook uses `port_type` attribute too -
https://github.com/SELinuxProject/selinux-notebook/blob/main/src/network_support.md#socket-controls-access-control-for-network-ports

I.e. using this change it would not be possible to add a new port mapping for
types like `stunnel_port_t`:

    # seinfo -aport_type -x | grep stunnel
        stunnel_port_t

    # semanage port -a -t stunnel_port_t -p tcp 12345
    ValueError: Type stunnel_port_t is invalid, must be a port type


Thanks,

Petr


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
> index c177cdfc..9d3b640b 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -989,7 +989,7 @@ def get_all_port_types():
>      global port_types
>      if port_types:
>          return port_types
> -    port_types = list(sorted(info(ATTRIBUTE, "port_type"))[0]["types"])
> +    port_types = [x["type"] for x in info(PORT)]
>      return port_types
>  
>  
> -- 
> 2.39.2

