Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5EAC4332F
	for <selinux@archiver.kernel.org>; Tue, 31 Oct 2023 18:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjJaSXX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 Oct 2023 14:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjJaSXW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 31 Oct 2023 14:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05ABA3
        for <selinux@vger.kernel.org>; Tue, 31 Oct 2023 11:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698776554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eUnttDyWj43IMP6NZ2DcS/1li9X4hoxczEvp1z5Wdg4=;
        b=azz9CHVdEUorcqna9OtUZBwUS9oe2TgFcSOKXjftbsR+o6VioXZ/+6GUkGx7ZUooF5B+h6
        yOlRbjss1MMoxX9//VEcQ8ghESKn+dP4HPZWw2/2YTHm+pmOsMxPCuErIXtwFn3ahFC9rX
        gOaBNhzFOhUmO7VUVM1VDY+nqXrX7ro=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-BAgqqNSoM9yCWSedCtry7Q-1; Tue,
 31 Oct 2023 14:22:30 -0400
X-MC-Unique: BAgqqNSoM9yCWSedCtry7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22B213813F25;
        Tue, 31 Oct 2023 18:22:30 +0000 (UTC)
Received: from localhost (unknown [10.45.224.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D55192026D4C;
        Tue, 31 Oct 2023 18:22:29 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: Re: [PATCH] secilc/docs: fixes filecon example
In-Reply-To: <20230818181905.560882-1-dominick.grift@defensec.nl>
References: <20230818181905.560882-1-dominick.grift@defensec.nl>
Date:   Tue, 31 Oct 2023 19:22:28 +0100
Message-ID: <87il6mhct7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Dominick Grift <dominick.grift@defensec.nl> writes:

> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>



> ---
>  secilc/docs/cil_file_labeling_statements.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/secilc/docs/cil_file_labeling_statements.md b/secilc/docs/cil_file_labeling_statements.md
> index 73f73885..9e4e877d 100644
> --- a/secilc/docs/cil_file_labeling_statements.md
> +++ b/secilc/docs/cil_file_labeling_statements.md
> @@ -97,7 +97,7 @@ These examples use one named, one anonymous and one empty context definition:
>      (context runas_exec_context (u object_r exec low_low))
>  
>      (filecon "/system/bin/run-as" file runas_exec_context)
> -    (filecon "/dev/socket/wpa_wlan[0-9]" any u:object_r:wpa.socket:s0-s0)
> +    (filecon "/dev/socket/wpa_wlan[0-9]" any (u object_r wpa.socket ((s0)(s0))))
>      (filecon "/data/local/mine" dir ())
>  ```
>  
> -- 
> 2.40.1

