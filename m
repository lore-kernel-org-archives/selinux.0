Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79E7C7EE2A
	for <selinux@archiver.kernel.org>; Mon,  5 Jun 2023 08:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjFEI5c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Jun 2023 04:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjFEI5b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Jun 2023 04:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C52E49
        for <selinux@vger.kernel.org>; Mon,  5 Jun 2023 01:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685955368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9O+gqBvxtC5v/b1QUzlplhCVOceulodmwIOnOTrmDkY=;
        b=GulcC02jEvrAL6uGtRs3aUfeY34b/PfIsAWVu5KcVNQ1wWXzMTnT8doqTMqtjlyK97TZbN
        uToIaw6I8dNHdY9SWOqj9QUvkO2kqDo4Wu1IgEXgzG1ZxUSWVNMxCeZo8ek26KKEfy2SAf
        6p/NMed1zqmiVaYPPUjkZp1z05jFsBA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-GjwLRISpO3mtVFjSVh8vJg-1; Mon, 05 Jun 2023 04:56:04 -0400
X-MC-Unique: GjwLRISpO3mtVFjSVh8vJg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C9BD2A5956C;
        Mon,  5 Jun 2023 08:56:04 +0000 (UTC)
Received: from localhost (unknown [10.45.224.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3020F40C6EC4;
        Mon,  5 Jun 2023 08:56:04 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     Topi Miettinen <toiwoton@gmail.com>, selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH] sepolicy: clarify manual page of sepolicy interface
In-Reply-To: <20230604115726.11247-1-toiwoton@gmail.com>
References: <20230604115726.11247-1-toiwoton@gmail.com>
Date:   Mon, 05 Jun 2023 10:56:03 +0200
Message-ID: <877csijnj0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Topi Miettinen <toiwoton@gmail.com> writes:

> Expand the description to make it more clear what "interfaces" mean
> here. They're different from network interfaces used by SELinux
> command `semanage interface`.
>
> Add a note that the information comes from on-disk file which has been
> installed and it doesn't necessarily match the policy loaded to the
> kernel.
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

Thanks!

> ---
>  python/sepolicy/sepolicy-interface.8 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/python/sepolicy/sepolicy-interface.8 b/python/sepolicy/sepolicy-interface.8
> index 3e74ea62..c8985afb 100644
> --- a/python/sepolicy/sepolicy-interface.8
> +++ b/python/sepolicy/sepolicy-interface.8
> @@ -8,7 +8,11 @@ sepolicy-interface \- Print interface information based on the installed SELinux
>  .B sepolicy interface  [\-h] [\-c] [\-v] [\-a | \-u | \-l | \-i INTERFACE [INTERFACE ... ]]
>  
>  .SH "DESCRIPTION"
> -Use sepolicy interface to print interfaces information based on SELinux Policy.
> +Use sepolicy interface to print information of interface macros
> +between domains in SELinux policy modules, as used in Reference
> +Policy. The information is based on installed on-disk representation
> +of the SELinux Policy and it may be different from the policy which is
> +currently loaded.
>  
>  .SH "OPTIONS"
>  .TP
> -- 
> 2.39.2

