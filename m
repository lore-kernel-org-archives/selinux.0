Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB247EB64DD
	for <selinux@archiver.kernel.org>; Thu, 29 Jun 2023 15:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjF2PJq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Jun 2023 11:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjF2PJp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Jun 2023 11:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456F230EE
        for <selinux@vger.kernel.org>; Thu, 29 Jun 2023 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688051342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RT4fAlXgqmyUxUoEWaYD1sTYwmai/xmNjF4ddEIWqy8=;
        b=AbABv16MIzIMGo2JyAsBMJ8JtQpdvJ+vf98UU0KDezIkAdusa1p8p+e6KY5DQZjCd68snG
        FqBNkdGRKfCdPkHGwy5n2l+XTWapr6utj2D+GT5L9FBgnaKbA8QEFnIWS+f6jo5IMAeEl2
        BjezaEss/Dr21w5L4bJjBh5GU26hkJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-xYrtCN4OM4uJlXs9bTuJ8Q-1; Thu, 29 Jun 2023 11:08:03 -0400
X-MC-Unique: xYrtCN4OM4uJlXs9bTuJ8Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CAA4800CB3;
        Thu, 29 Jun 2023 15:07:55 +0000 (UTC)
Received: from localhost (unknown [10.45.224.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DFD040C2063;
        Thu, 29 Jun 2023 15:07:55 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     Jeffery To <jeffery.to@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] python/sepolicy: Fix get_os_version except clause
In-Reply-To: <20230619063217.3165462-1-jeffery.to@gmail.com>
References: <20230619063217.3165462-1-jeffery.to@gmail.com>
Date:   Thu, 29 Jun 2023 17:07:54 +0200
Message-ID: <87fs6a1f3p.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Jeffery To <jeffery.to@gmail.com> writes:

> This adds more exceptions to be handled by the except clause in
> `get_os_version()`:
>
> * If the `distro` package is not installed, then `import distro` raises
>   a `ModuleNotFoundError` exception.
>
> * The distro documentation[1] lists `OSError` and `UnicodeError` as
>   exceptions that can be raised.
>
> * Older versions of distro (<= 1.6.0) may also raise
>   `subprocessCalledProcessError`[2].
>
> [1]: https://github.com/python-distro/distro/blob/v1.8.0/src/distro/distro.py#L749-L753
> [2]: https://github.com/python-distro/distro/blob/v1.6.0/distro.py#L726-L728
>
> Signed-off-by: Jeffery To <jeffery.to@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  python/sepolicy/sepolicy/__init__.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index c177cdfc529d..2d526c94a0c5 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -1240,11 +1240,12 @@ def boolean_desc(boolean):
>  
>  
>  def get_os_version():
> +    import subprocess
>      system_release = ""
>      try:
>          import distro
>          system_release = distro.name(pretty=True)
> -    except IOError:
> +    except (ModuleNotFoundError, OSError, IOError, UnicodeError, subprocess.CalledProcessError):
>          system_release = "Misc"
>  
>      return system_release
> -- 
> 2.39.2

