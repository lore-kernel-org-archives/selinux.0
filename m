Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13393C77B73
	for <selinux@archiver.kernel.org>; Tue,  6 Jun 2023 15:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjFFPVH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jun 2023 11:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjFFPVG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jun 2023 11:21:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C719D1B5
        for <selinux@vger.kernel.org>; Tue,  6 Jun 2023 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686064823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mn+Hm38LqssF4uZ7+Z9ZKyYIVrtLJ8a2XaoEODPYGFo=;
        b=RwybeMqUkKxKsbilxdTuCWHs/Dd4NUb9r8FHjrt7oZTp3h7A1ht97uZQbhxo0JnuHH2Sqc
        bjbvmCqAeW5dJYy9uYyZgoZ029K9KgJsnVKLxZpjg9ylVR6xb5E+Lwo6I/eXFHw5htT0pP
        WoDufgBTzuXGPK/Z7K8yzu5dUG7f5kA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-YFPDpGcjMTi3gabMtrjR7A-1; Tue, 06 Jun 2023 11:20:21 -0400
X-MC-Unique: YFPDpGcjMTi3gabMtrjR7A-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f80c977f15so61022741cf.2
        for <selinux@vger.kernel.org>; Tue, 06 Jun 2023 08:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686064821; x=1688656821;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mn+Hm38LqssF4uZ7+Z9ZKyYIVrtLJ8a2XaoEODPYGFo=;
        b=HZknPcLrOOa/thWixfwfsL5k06mzfHP6OTzb3zV8pklicuw5VAF/hPCoSb/Inq4Krq
         vk8046fb8Jv/azii+7+NRYdHIhchGrOsKlwzCaLOHtS6WByNwi1qICpCXzkUdgEnjzH0
         2a8OhQMCKU4//XEq0L94w5OQX7a2Xdd04uHfMS8lfTs7NujH+kQbl/IWQEBHx0nnxXiO
         l9X1mzUPU1Eodb8wZbIsCj6be49c0fLHAJ42WlTOB+SBbON3gtjtG1zeU1xdQvBeLFEp
         mMmbXP8BYW2053QOJl5oBbTTgc4rfg7kedFREtgBcvczg/v/eKTtGC4y+ZOXXNJpQ7ig
         W3lA==
X-Gm-Message-State: AC+VfDxOrA8vv5F9CXeu1UKpkvr9zjs/lGsQipa3yfRm7uNtwWjX1FoN
        9RFTrUWufyYK02jlyt7y0f+/xUoOgMQYltjbu/Uh0q0DwJkBHlc5t3KqIEWeEpHZZQ6j1c3sPu5
        k+5w8065YviUWweOXgTxKPS7DEA==
X-Received: by 2002:ac8:7f03:0:b0:3f6:b9af:51eb with SMTP id f3-20020ac87f03000000b003f6b9af51ebmr3034496qtk.38.1686064820709;
        Tue, 06 Jun 2023 08:20:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4uVrRglMaHaHOfug+auVKSo45/laS1TkBUk2N8YOdobqfCvB8ZNiCjwmQpoO7V9TD40OXZ1Q==
X-Received: by 2002:ac8:7f03:0:b0:3f6:b9af:51eb with SMTP id f3-20020ac87f03000000b003f6b9af51ebmr3034448qtk.38.1686064820304;
        Tue, 06 Jun 2023 08:20:20 -0700 (PDT)
Received: from [192.168.0.116] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id g22-20020ac84696000000b003ef189ffa82sm2704028qto.90.2023.06.06.08.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 08:20:19 -0700 (PDT)
Message-ID: <ef52fcda-2eaa-ee5b-9325-b5d3d753820f@redhat.com>
Date:   Tue, 6 Jun 2023 17:20:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/4] python: improve format strings for proper
 localization
Content-Language: en-US
To:     Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
References: <20230517134934.709059-1-lautrbach@redhat.com>
From:   Vit Mojzis <vmojzis@redhat.com>
In-Reply-To: <20230517134934.709059-1-lautrbach@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/17/23 15:49, Petr Lautrbach wrote:
> If a string contains more than one unnamed argument it's hard for
> translators to proper localize as they don't know which value is
> represented by a unnamed argument. It also blocks them to use a
> different order of arguments which would make better sense in other
> languages.
> 
> Fixes:
> 
>      $ xgettext --default-domain=python -L Python --keyword=_ --keyword=N_ ../audit2allow/audit2allow ../chcat/chcat ../semanage/semanage ../semanage/seobject.py ../sepolgen/src/sepolgen/interfaces.py ../sepolicy/sepolicy/generate.py ../sepolicy/sepolicy/gui.py ../sepolicy/sepolicy/__init__.py ../sepolicy/sepolicy/interface.py ../sepolicy/sepolicy.py
>      ../chcat/chcat:220: warning: 'msgid' format string with unnamed arguments cannot be properly localized:
>                                   The translator cannot reorder the arguments.
>                                   Please consider using a format string with named arguments,
>                                   and a mapping instead of a tuple for the arguments.
>      ../semanage/seobject.py:1178: warning: 'msgid' format string with unnamed arguments cannot be properly localized:
>                                             The translator cannot reorder the arguments.
>                                             Please consider using a format string with named arguments,
>                                             and a mapping instead of a tuple for the arguments.
>      ...
> 
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> ---
>   python/chcat/chcat          |  2 +-
>   python/semanage/seobject.py | 92 ++++++++++++++++++-------------------
>   2 files changed, 47 insertions(+), 47 deletions(-)
> 
> diff --git a/python/chcat/chcat b/python/chcat/chcat
> index 68718ec5f102..ec34c05ffdfa 100755
> --- a/python/chcat/chcat
> +++ b/python/chcat/chcat
> @@ -217,7 +217,7 @@ def chcat_remove(orig, newcat, objects, login_ind):
>               else:
>                   cat = ""
>           else:
> -            print(_("%s is not in %s") % (f, orig))
> +            print(_("{target} is not in {category}").format(target=f, category=orig))
>               continue

The following (similar) string issues should also be fixed:
128: print(_("%s is already in %s") % (f, orig))
210: print(_("%s is not in %s") % (f, orig))


>   
>           if len(cat) == 0:
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index d82da4942987..8a891ca23bca 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1175,13 +1175,13 @@ class portRecords(semanageRecords):
>   
>           (rc, exists) = semanage_port_exists(self.sh, k)
>           if rc < 0:
> -            raise ValueError(_("Could not check if port %s/%s is defined") % (proto, port))
> +            raise ValueError(_("Could not check if port {proto}/{port} is defined").format(proto=proto, port=port))
>           if not exists:
> -            raise ValueError(_("Port %s/%s is not defined") % (proto, port))
> +            raise ValueError(_("Port {proto}/{port} is not defined").format(proto=proto, port=port))
>   
>           (rc, p) = semanage_port_query(self.sh, k)
>           if rc < 0:
> -            raise ValueError(_("Could not query port %s/%s") % (proto, port))
> +            raise ValueError(_("Could not query port {proto}/{port}").format(proto=proto, port=port))
>   
>           con = semanage_port_get_con(p)
>   
> @@ -1195,7 +1195,7 @@ class portRecords(semanageRecords):
>   
>           rc = semanage_port_modify_local(self.sh, k, p)
>           if rc < 0:
> -            raise ValueError(_("Could not modify port %s/%s") % (proto, port))
> +            raise ValueError(_("Could not modify port {proto}/{port}").format(proto=proto, port=port))
>   
>           semanage_port_key_free(k)
>           semanage_port_free(p)
> @@ -1241,19 +1241,19 @@ class portRecords(semanageRecords):
>           (k, proto_d, low, high) = self.__genkey(port, proto)
>           (rc, exists) = semanage_port_exists(self.sh, k)
>           if rc < 0:
> -            raise ValueError(_("Could not check if port %s/%s is defined") % (proto, port))
> +            raise ValueError(_("Could not check if port {proto}/{port} is defined").format(proto=proto, port=port))
>           if not exists:
> -            raise ValueError(_("Port %s/%s is not defined") % (proto, port))
> +            raise ValueError(_("Port {proto}/{port} is not defined").format(proto=proto, port=port))
>   
>           (rc, exists) = semanage_port_exists_local(self.sh, k)
>           if rc < 0:
> -            raise ValueError(_("Could not check if port %s/%s is defined") % (proto, port))
> +            raise ValueError(_("Could not check if port {proto}/{port} is defined").format(proto=proto, port=port))
>           if not exists:
> -            raise ValueError(_("Port %s/%s is defined in policy, cannot be deleted") % (proto, port))
> +            raise ValueError(_("Port {proto}/{port} is defined in policy, cannot be deleted").format(proto=proto, port=port))
>   
>           rc = semanage_port_del_local(self.sh, k)
>           if rc < 0:
> -            raise ValueError(_("Could not delete port %s/%s") % (proto, port))
> +            raise ValueError(_("Could not delete port {proto}/{port}").format(proto=proto, port=port))
>   
>           semanage_port_key_free(k)
>   
> @@ -1362,7 +1362,7 @@ class ibpkeyRecords(semanageRecords):
>   
>           (rc, k) = semanage_ibpkey_key_create(self.sh, subnet_prefix, low, high)
>           if rc < 0:
> -            raise ValueError(_("Could not create a key for %s/%s") % (subnet_prefix, pkey))
> +            raise ValueError(_("Could not create a key for {subnet_prefix}/{pkey}").format(subnet_prefix=subnet_prefix, pkey=pkey))
>           return (k, subnet_prefix, low, high)
>   
>       def __add(self, pkey, subnet_prefix, serange, type):
> @@ -1384,44 +1384,44 @@ class ibpkeyRecords(semanageRecords):
>   
>           (rc, exists) = semanage_ibpkey_exists(self.sh, k)
>           if rc < 0:
> -            raise ValueError(_("Could not check if ibpkey %s/%s is defined") % (subnet_prefix, pkey))
> +            raise ValueError(_("Could not check if ibpkey {subnet_prefix}/{pkey} is defined").formnat(subnet_prefix=subnet_prefix, pkey=pkey))
>           if exists:
> -            raise ValueError(_("ibpkey %s/%s already defined") % (subnet_prefix, pkey))
> +            raise ValueError(_("ibpkey {subnet_prefix}/{pkey} already defined").format(subnet_prefix=subnet_prefix, pkey=pkey))
>   
>           (rc, p) = semanage_ibpkey_create(self.sh)
>           if rc < 0:
> -            raise ValueError(_("Could not create ibpkey for %s/%s") % (subnet_prefix, pkey))
> +            raise ValueError(_("Could not create ibpkey for {subnet_prefix}/{pkey}").format(subnet_prefix=subnet_prefix, pkey=pkey))
>   
>           semanage_ibpkey_set_subnet_prefix(self.sh, p, subnet_prefix)
>           semanage_ibpkey_set_range(p, low, high)
>           (rc, con) = semanage_context_create(self.sh)
>           if rc < 0:
> -            raise ValueError(_("Could not create context for %s/%s") % (subnet_prefix, pkey))
> +            raise ValueError(_("Could not create context for {subnet_prefix}/{pkey}").format(subnet_prefix=subnet_prefix, pkey=pkey))
>   
>           rc = semanage_context_set_user(self.sh, con, "system_u")
>           if rc < 0:
> -            raise ValueError(_("Could not set user in ibpkey context for %s/%s") % (subnet_prefix, pkey))
> +            raise ValueError(_("Could not set user in ibpkey context for {subnet_prefix}/{pkey}").format(subnet_prefix=subnet_prefix, pkey=pkey))
>   
>           rc = semanage_context_set_role(self.sh, con, "object_r")
>           if rc < 0:
> -            raise ValueError(_("Could not set role in ibpkey context for %s/%s") % (subnet_prefix, pkey))
> +            raise ValueError(_("Could not set role in ibpkey context for {subnet_prefix}/{pkey}").format(subnet_prefix=subnet_prefix, pkey=pkey))
>   
>           rc = semanage_context_set_type(self.sh, con, type)
>           if rc < 0:
> -            raise ValueError(_("Could not set type in ibpkey context for %s/%s") % (subnet_prefix, pkey))
> +            raise ValueError(_("Could not set type in ibpkey context for {subnet_prefix}/{pkey}").format(subnet_prefix=subnet_prefix, pkey=pkey))
>   
>           if (is_mls_enabled == 1) and (serange != ""):
>               rc = semanage_context_set_mls(self.sh, con, serange)
>               if rc < 0:
> -                raise ValueError(_("Could not set mls fields in ibpkey context for %s/%s") % (subnet_prefix, pkey))
> +                raise ValueError(_("Could not set mls fields in ibpkey context for {subnet_prefix}/{pkey}").format(subnet_prefix=subnet_prefix, pkey=pkey))
>   
>           rc = semanage_ibpkey_set_con(self.sh, p, con)
>           if rc < 0:
> -            raise ValueError(_("Could not set ibpkey context for %s/%s") % (subnet_prefix, pkey))
> +            raise ValueError(_("Could not set ibpkey context for {subnet_prefix}/{pkey}").format(subnet_prefix=subnet_prefix, pkey=pkey))
>   
>           rc = semanage_ibpkey_modify_local(self.sh, k, p)
>           if rc < 0:
> -            raise ValueError(_("Could not add ibpkey %s/%s") % (subnet_prefix, pkey))
> +            raise ValueError(_("Could not add ibpkey {subnet_prefix}/{pkey}").format(subnet_prefix=subnet_prefix, pkey=pkey))
>   
>           semanage_context_free(con)
>           semanage_ibpkey_key_free(k)
> @@ -1448,13 +1448,13 @@ class ibpkeyRecords(semanageRecords):
>   
>           (rc, exists) = semanage_ibpkey_exists(self.sh, k)
>           if rc < 0:
> -            raise ValueError(_("Could not check if ibpkey %s/%s is defined") % (subnet_prefix, pkey))
> +            raise ValueError(_("Could not check if ibpkey {subnet_prefix}/{pkey} is defined").format(subnet_prefix=subnet_prefix, pkey=pkey))
>           if not exists:
> -            raise ValueError(_("ibpkey %s/%s is not defined") % (subnet_prefix, pkey))
> +            raise ValueError(_("ibpkey {subnet_prefix}/{pkey} is not defined").format(subnet_prefix=subnet_prefix, pkey=pkey))
>   
>           (rc, p) = semanage_ibpkey_query(self.sh, k)
>           if rc < 0:
> -            raise ValueError(_("Could not query ibpkey %s/%s") % (subnet_prefix, pkey))
> +            raise ValueError(_("Could not query ibpkey {subnet_prefix}/{pkey}").format(subnet_prefix=subnet_prefix, pkey=pkey))
>   
>           con = semanage_ibpkey_get_con(p)
>   
> @@ -1508,13 +1508,13 @@ class ibpkeyRecords(semanageRecords):
>   
>           (rc, exists) = semanage_ibpkey_exists_local(self.sh, k)
>           if rc < 0:
> -            raise ValueError(_("Could not check if ibpkey %s/%s is defined") % (subnet_prefix, pkey))
> +            raise ValueError(_("Could not check if ibpkey {subnet_prefix}/{pkey} is defined").format(subnet_prefix=subnet_prefix, pkey=pkey))
>           if not exists:
> -            raise ValueError(_("ibpkey %s/%s is defined in policy, cannot be deleted") % (subnet_prefix, pkey))
> +            raise ValueError(_("ibpkey {subnet_prefix}/{pkey} is defined in policy, cannot be deleted").format(subnet_prefix=subnet_prefix, pkey=pkey))
>   
>           rc = semanage_ibpkey_del_local(self.sh, k)
>           if rc < 0:
> -            raise ValueError(_("Could not delete ibpkey %s/%s") % (subnet_prefix, pkey))
> +            raise ValueError(_("Could not delete ibpkey {subnet_prefix}/{pkey}").format(subnet_prefix=subnet_prefix, pkey=pkey))
>   
>           semanage_ibpkey_key_free(k)
>   
> @@ -1617,7 +1617,7 @@ class ibendportRecords(semanageRecords):
>   
>           (rc, k) = semanage_ibendport_key_create(self.sh, ibdev_name, port)
>           if rc < 0:
> -            raise ValueError(_("Could not create a key for ibendport %s/%s") % (ibdev_name, ibendport))
> +            raise ValueError(_("Could not create a key for ibendport {ibdev_name}/{ibendport}").format(ibdev_name=ibdev_name, ibendport=ibendport))
>           return (k, ibdev_name, port)
>   
>       def __add(self, ibendport, ibdev_name, serange, type):
> @@ -1638,9 +1638,9 @@ class ibendportRecords(semanageRecords):
>   
>           (rc, exists) = semanage_ibendport_exists(self.sh, k)
>           if rc < 0:
> -            raise ValueError(_("Could not check if ibendport %s/%s is defined") % (ibdev_name, port))
> +            raise ValueError(_("Could not check if ibendport {ibdev_name}/{port} is defined").format(ibdev_name=ibdev_name, port=port))
>           if exists:
> -            raise ValueError(_("ibendport %s/%s already defined") % (ibdev_name, port))
> +            raise ValueError(_("ibendport {ibdev_name}/{port} already defined").format(ibdev_name=ibdev_name, port=port))
>   
>           (rc, p) = semanage_ibendport_create(self.sh)
>           if rc < 0:
> @@ -1650,32 +1650,32 @@ class ibendportRecords(semanageRecords):
>           semanage_ibendport_set_port(p, port)
>           (rc, con) = semanage_context_create(self.sh)
>           if rc < 0:
> -            raise ValueError(_("Could not create context for %s/%s") % (ibdev_name, port))
> +            raise ValueError(_("Could not create context for {ibendport}/{port}").format(ibdev_name=ibdev_name, port=port))
>   
>           rc = semanage_context_set_user(self.sh, con, "system_u")
>           if rc < 0:
> -            raise ValueError(_("Could not set user in ibendport context for %s/%s") % (ibdev_name, port))
> +            raise ValueError(_("Could not set user in ibendport context for {ibdev_name}/{port}").format(ibdev_name=ibdev_name, port=port))
>   
>           rc = semanage_context_set_role(self.sh, con, "object_r")
>           if rc < 0:
> -            raise ValueError(_("Could not set role in ibendport context for %s/%s") % (ibdev_name, port))
> +            raise ValueError(_("Could not set role in ibendport context for {ibdev_name}/{port}").format(ibdev_name=ibdev_name, port=port))
>   
>           rc = semanage_context_set_type(self.sh, con, type)
>           if rc < 0:
> -            raise ValueError(_("Could not set type in ibendport context for %s/%s") % (ibdev_name, port))
> +            raise ValueError(_("Could not set type in ibendport context for {ibdev_name}/{port}").format(ibdev_name=ibdev_name, port=port))
>   
>           if (is_mls_enabled == 1) and (serange != ""):
>               rc = semanage_context_set_mls(self.sh, con, serange)
>               if rc < 0:
> -                raise ValueError(_("Could not set mls fields in ibendport context for %s/%s") % (ibdev_name, port))
> +                raise ValueError(_("Could not set mls fields in ibendport context for {ibdev_name}/{port}").format(ibdev_name=ibdev_name, port=port))
>   
>           rc = semanage_ibendport_set_con(self.sh, p, con)
>           if rc < 0:
> -            raise ValueError(_("Could not set ibendport context for %s/%s") % (ibdev_name, port))
> +            raise ValueError(_("Could not set ibendport context for {ibdev_name}/{port}").format(ibdev_name=ibdev_name, port=port))
>   
>           rc = semanage_ibendport_modify_local(self.sh, k, p)
>           if rc < 0:
> -            raise ValueError(_("Could not add ibendport %s/%s") % (ibdev_name, port))
> +            raise ValueError(_("Could not add ibendport {ibdev_name}/{port}").format(ibdev_name=ibdev_name, port=port))
>   
>           semanage_context_free(con)
>           semanage_ibendport_key_free(k)
> @@ -1702,9 +1702,9 @@ class ibendportRecords(semanageRecords):
>   
>           (rc, exists) = semanage_ibendport_exists(self.sh, k)
>           if rc < 0:
> -            raise ValueError(_("Could not check if ibendport %s/%s is defined") % (ibdev_name, ibendport))
> +            raise ValueError(_("Could not check if ibendport {ibdev_name}/{ibendport} is defined").format(ibdev_name=ibdev_name, ibendport=ibendport))
>           if not exists:
> -            raise ValueError(_("ibendport %s/%s is not defined") % (ibdev_name, ibendport))
> +            raise ValueError(_("ibendport {ibdev_name}/{ibendport} is not defined").format(ibdev_name=ibdev_name, ibendport=ibendport))
>   
>           (rc, p) = semanage_ibendport_query(self.sh, k)
>           if rc < 0:
> @@ -1719,7 +1719,7 @@ class ibendportRecords(semanageRecords):
>   
>           rc = semanage_ibendport_modify_local(self.sh, k, p)
>           if rc < 0:
> -            raise ValueError(_("Could not modify ibendport %s/%s") % (ibdev_name, ibendport))
> +            raise ValueError(_("Could not modify ibendport {ibdev_name}/{ibendport}").format(ibdev_name=ibdev_name, ibendport=ibendport))
>   
>           semanage_ibendport_key_free(k)
>           semanage_ibendport_free(p)
> @@ -1741,11 +1741,11 @@ class ibendportRecords(semanageRecords):
>               port = semanage_ibendport_get_port(ibendport)
>               (k, ibdev_name, port) = self.__genkey(str(port), ibdev_name)
>               if rc < 0:
> -                raise ValueError(_("Could not create a key for %s/%d") % (ibdevname, port))
> +                raise ValueError(_("Could not create a key for {ibdev_name}/{port}").format(ibdev_name=ibdev_name, port=port))
>   
>               rc = semanage_ibendport_del_local(self.sh, k)
>               if rc < 0:
> -                raise ValueError(_("Could not delete the ibendport %s/%d") % (ibdev_name, port))
> +                raise ValueError(_("Could not delete the ibendport {ibdev_name}/{port}").format(ibdev_name=ibdev_name, port=port))
>               semanage_ibendport_key_free(k)
>   
>           self.commit()
> @@ -1754,19 +1754,19 @@ class ibendportRecords(semanageRecords):
>           (k, ibdev_name, port) = self.__genkey(ibendport, ibdev_name)
>           (rc, exists) = semanage_ibendport_exists(self.sh, k)
>           if rc < 0:
> -            raise ValueError(_("Could not check if ibendport %s/%s is defined") % (ibdev_name, ibendport))
> +            raise ValueError(_("Could not check if ibendport {ibdev_name}/{ibendport} is defined").format(ibdev_name=ibdev_name, ibendport=ibendport))
>           if not exists:
> -            raise ValueError(_("ibendport %s/%s is not defined") % (ibdev_name, ibendport))
> +            raise ValueError(_("ibendport {ibdev_name}/{ibendport} is not defined").format(ibdev_name=ibdev_name, ibendport=ibendport))
>   
>           (rc, exists) = semanage_ibendport_exists_local(self.sh, k)
>           if rc < 0:
> -            raise ValueError(_("Could not check if ibendport %s/%s is defined") % (ibdev_name, ibendport))
> +            raise ValueError(_("Could not check if ibendport {ibdev_name}/{ibendport} is defined").format(ibdev_name=ibdev_name, ibendport=ibendport))
>           if not exists:
> -            raise ValueError(_("ibendport %s/%s is defined in policy, cannot be deleted") % (ibdev_name, ibendport))
> +            raise ValueError(_("ibendport {ibdev_name}/{ibendport} is defined in policy, cannot be deleted").format(ibdev_name=ibdev_name, ibendport=ibendport))
>   
>           rc = semanage_ibendport_del_local(self.sh, k)
>           if rc < 0:
> -            raise ValueError(_("Could not delete ibendport %s/%s") % (ibdev_name, ibendport))
> +            raise ValueError(_("Could not delete ibendport {ibdev_name}/{ibendport}").format(ibdev_name=ibdev_name, ibendport=ibendport))
>   
>           semanage_ibendport_key_free(k)
>   

Most of these will probably not help with localization since the order 
of the values should not change, but to keep the format consistent, the 
following lines should be changed as well:

841: raise ValueError(_("Could not add role %s for %s") % (r, name))
853: raise ValueError(_("Could not add prefix %s for %s") % (r, prefix))
1086: raise ValueError(_("Could not create a key for %s/%s") % (proto, 
port))
1114: raise ValueError(_("Could not create port for %s/%s") % (proto, port))
1120: raise ValueError(_("Could not create context for %s/%s") % (proto, 
port))
1124: raise ValueError(_("Could not set user in port context for %s/%s") 
% (proto, port))
1128: raise ValueError(_("Could not set role in port context for %s/%s") 
% (proto, port))
1132: raise ValueError(_("Could not set type in port context for %s/%s") 
% (proto, port))
1137: raise ValueError(_("Could not set mls fields in port context for 
%s/%s") % (proto, port))
1141: raise ValueError(_("Could not set port context for %s/%s") % 
(proto, port))
1145: raise ValueError(_("Could not add port %s/%s") % (proto, port))
1463: raise ValueError(_("Could not modify ibpkey %s/%s") % 
(subnet_prefix, pkey))
1642: raise ValueError(_("Could not create ibendport for %s/%s") % 
(ibdev_name, port))
1706: raise ValueError(_("Could not query ibendport %s/%s") % 
(ibdev_name, ibendport))
2763: raise ValueError(_("Bad format %s: Record %s" % (name, b)))

Otherwise LGTM.

Vit

