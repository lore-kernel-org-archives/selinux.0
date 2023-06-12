Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E3EC88CB2
	for <selinux@archiver.kernel.org>; Mon, 12 Jun 2023 17:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbjFLRsH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jun 2023 13:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjFLRsG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jun 2023 13:48:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B081A5
        for <selinux@vger.kernel.org>; Mon, 12 Jun 2023 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686592035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1meqOgWGqvORcqyZrf3OiEArY/ojDaIa6ZSQZ4Lue7U=;
        b=Poy75INyHtfZRZxMv1GXd7u/Kf5+VdVUUlCV5xeQ6f76SlQrq9Jdgfc4u/ncmeZNkIc+36
        vXbcybYmX7Qt8mbe/gKA4ue3mv1OIUzgDVlYP4ubVR5sYY2GVsyPxHIctL66YPwiLMHpqj
        rce+l3ygitROnXJFNKkYOZAuL6WPyNM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-ZN8FB0aLO3u6W3qhZ-D3ww-1; Mon, 12 Jun 2023 13:47:14 -0400
X-MC-Unique: ZN8FB0aLO3u6W3qhZ-D3ww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52B6B8030D3
        for <selinux@vger.kernel.org>; Mon, 12 Jun 2023 17:47:14 +0000 (UTC)
Received: from localhost (unknown [10.45.226.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10F7E40C20F4;
        Mon, 12 Jun 2023 17:47:13 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] python/sepolicy: Fix template for confined user policy
 modules
In-Reply-To: <871qiqjmqv.fsf@redhat.com>
References: <20230601163430.2062951-1-vmojzis@redhat.com>
 <871qiqjmqv.fsf@redhat.com>
Date:   Mon, 12 Jun 2023 19:47:13 +0200
Message-ID: <87h6rco9ni.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <lautrbach@redhat.com> writes:

> Vit Mojzis <vmojzis@redhat.com> writes:
>
>> The following commit
>> https://github.com/SELinuxProject/refpolicy/commit/330b0fc3331d3b836691464734c96f3da3044490
>> changed the userdom_base_user_template, which now requires a role
>> corresponding to the user being created to be defined outside of the
>> template.
>> Similar change was also done to fedora-selinux/selinux-policy
>> https://github.com/fedora-selinux/selinux-policy/commit/e1e216b25df1bdb4eb7dbb8f73f32927ad6f3d1f
>>
>> Although I believe the template should define the role (just as it
>> defines the new user), that will require extensive changes to refpolicy.
>> In the meantime the role needs to be defined separately.
>>
>> Fixes:
>> \# sepolicy generate --term_user -n newuser
>> Created the following files:
>> /root/a/test/newuser.te # Type Enforcement file
>> /root/a/test/newuser.if # Interface file
>> /root/a/test/newuser.fc # File Contexts file
>> /root/a/test/newuser_selinux.spec # Spec file
>> /root/a/test/newuser.sh # Setup Script
>
> If you don't mind, I'd push it with indented text, i.e.
>
> Fixes:
>     # sepolicy generate --term_user -n newuser
>     Created the following files:
>     /root/a/test/newuser.te # Type Enforcement file
>     /root/a/test/newuser.if # Interface file
>     /root/a/test/newuser.fc # File Contexts file
>     /root/a/test/newuser_selinux.spec # Spec file
>     /root/a/test/newuser.sh # Setup Script
>
>
>
>> \# ./newuser.sh
>> Building and Loading Policy
>> + make -f /usr/share/selinux/devel/Makefile newuser.pp
>> Compiling targeted newuser module
>> Creating targeted newuser.pp policy package
>> rm tmp/newuser.mod tmp/newuser.mod.fc
>> + /usr/sbin/semodule -i newuser.pp
>> Failed to resolve roleattributeset statement at /var/lib/selinux/targeted/tmp/modules/400/newuser/cil:8
>> Failed to resolve AST
>> /usr/sbin/semodule:  Failed!
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>

Merged with reformatted commit message. Thanks!


>> ---
>>  python/sepolicy/sepolicy/templates/user.py | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/python/sepolicy/sepolicy/templates/user.py b/python/sepolicy/sepolicy/templates/user.py
>> index 1ff9d2ce..7081fbae 100644
>> --- a/python/sepolicy/sepolicy/templates/user.py
>> +++ b/python/sepolicy/sepolicy/templates/user.py
>> @@ -28,6 +28,8 @@ policy_module(TEMPLATETYPE, 1.0.0)
>>  #
>>  # Declarations
>>  #
>> +role TEMPLATETYPE_r;
>> +
>>  userdom_unpriv_user_template(TEMPLATETYPE)
>>  """
>>  
>> @@ -38,6 +40,8 @@ policy_module(TEMPLATETYPE, 1.0.0)
>>  #
>>  # Declarations
>>  #
>> +role TEMPLATETYPE_r;
>> +
>>  userdom_admin_user_template(TEMPLATETYPE)
>>  """
>>  
>> @@ -48,6 +52,7 @@ policy_module(TEMPLATETYPE, 1.0.0)
>>  #
>>  # Declarations
>>  #
>> +role TEMPLATETYPE_r;
>>  
>>  userdom_restricted_user_template(TEMPLATETYPE)
>>  """
>> @@ -59,6 +64,7 @@ policy_module(TEMPLATETYPE, 1.0.0)
>>  #
>>  # Declarations
>>  #
>> +role TEMPLATETYPE_r;
>>  
>>  userdom_restricted_xwindows_user_template(TEMPLATETYPE)
>>  """
>> @@ -89,6 +95,7 @@ gen_tunable(TEMPLATETYPE_manage_user_files, false)
>>  #
>>  # Declarations
>>  #
>> +role TEMPLATETYPE_r;
>>  
>>  userdom_base_user_template(TEMPLATETYPE)
>>  """
>> -- 
>> 2.40.0

