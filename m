Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CB3C433E0
	for <selinux@archiver.kernel.org>; Mon, 22 Feb 2021 18:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842F464EC3
	for <selinux@archiver.kernel.org>; Mon, 22 Feb 2021 18:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhBVS3v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Feb 2021 13:29:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232591AbhBVS3b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Feb 2021 13:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614018484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9EE9KfNzLqTV5rbLkn1NSG33VS+A80tLKK4EaZ1R8b8=;
        b=RIVtyWZthIQLYUkyljSQ0sPbTLaWXUZf7Sw4+0i6YibGCjYFTgK2haiuR63Zm3eOKXn59J
        DRbC2Jl0kPjbS3DOzpsAcGpdgD9POQNDs3vNPvULfZ1NtEsMADwAU3STo2cSZmPUHpnfyK
        3a1o0u5UmYJ6W7r1UeXh++ORTzlzfho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-Aw0mHMbLOdqw8WUDyjdliw-1; Mon, 22 Feb 2021 13:28:00 -0500
X-MC-Unique: Aw0mHMbLOdqw8WUDyjdliw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91FA9107ACE6;
        Mon, 22 Feb 2021 18:27:59 +0000 (UTC)
Received: from localhost (unknown [10.40.192.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C3B219C45;
        Mon, 22 Feb 2021 18:27:58 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     bauen1 <j2468h@googlemail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH v2] chcat: allow usage if binary policy is inaccessible
In-Reply-To: <6b298117-2dd0-322a-4de2-b8886731265a@gmail.com>
References: <CAEjxPJ5gK_DdNxpjMq8tvvhkq1hxsoE5vTNZAa=hiP-6s=an8Q@mail.gmail.com>
 <6b298117-2dd0-322a-4de2-b8886731265a@gmail.com>
Date:   Mon, 22 Feb 2021 19:27:57 +0100
Message-ID: <87wnv0555e.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

bauen1 <j2468h@googlemail.com> writes:

> Currently, chcat will crash when run as regular user, because import
> sepolicy throws an Exception when failing to access the binary policy
> under /etc/selinux/${POLICYNAME}/policy/ which is inaccessible to
> regular users.
>

I'd rather follow Nicolas suggestion so I've prepared a patch, see
below, which moves the policy initialization in sepolicy module before
it's used for the first time. It seems to solve the same problem in more
generic way. I need to run some tests on that and then they pass I'll
propose it here on the mailing list.


https://github.com/bachradsusi/SELinuxProject-selinux/commit/6a12939b613b273a6e96e1cc4cc096cdf7db5ac6

--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -178,15 +178,14 @@ def load_store_policy(store):
         return None
     policy(policy_file)
 
-try:
+def init_policy():
     policy_file = get_installed_policy()
     policy(policy_file)
-except ValueError as e:
-    if selinux.is_selinux_enabled() == 1:
-        raise e
-
 
 def info(setype, name=None):
+    if not _pol:
+        init_policy()
+
     if setype == TYPE:
         q = setools.TypeQuery(_pol)
         q.name = name
@@ -337,6 +336,8 @@ def _setools_rule_to_dict(rule):
 
 
 def search(types, seinfo=None):
+    if not _pol:
+        init_policy()
     if not seinfo:
         seinfo = {}
     valid_types = set([ALLOW, AUDITALLOW, NEVERALLOW, DONTAUDIT, TRANSITION, ROLE_ALLOW])



> Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
> ---
>
> v2:
>  Fix signed-off-by, improve commit message, but otherwise unchanged
>
>  python/chcat/chcat | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/python/chcat/chcat b/python/chcat/chcat
> index fdd2e46e..55408577 100755
> --- a/python/chcat/chcat
> +++ b/python/chcat/chcat
> @@ -28,7 +28,6 @@ import os
>  import pwd
>  import getopt
>  import selinux
> -import seobject
>
>  PROGNAME = "policycoreutils"
>  try:
> @@ -65,6 +64,7 @@ def verify_users(users):
>
>
>  def chcat_user_add(newcat, users):
> +    import seobject
>      errors = 0
>      logins = seobject.loginRecords()
>      seusers = logins.get_all()
> @@ -144,6 +144,7 @@ def chcat_add(orig, newcat, objects, login_ind):
>
>
>  def chcat_user_remove(newcat, users):
> +    import seobject
>      errors = 0
>      logins = seobject.loginRecords()
>      seusers = logins.get_all()
> @@ -233,6 +234,7 @@ def chcat_remove(orig, newcat, objects, login_ind):
>
>
>  def chcat_user_replace(newcat, users):
> +    import seobject
>      errors = 0
>      logins = seobject.loginRecords()
>      seusers = logins.get_all()
> @@ -376,6 +378,7 @@ def listcats():
>
>
>  def listusercats(users):
> +    import seobject
>      if len(users) == 0:
>          try:
>              users.append(os.getlogin())
> --
> 2.30.1

