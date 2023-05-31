Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085FCC77B7A
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 14:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbjEaOo4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 May 2023 10:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbjEaOoy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 May 2023 10:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F158D98
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 07:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685544249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kM1wFmDeqwUqTqiwnfT4C4XODZWeZZV6/8DI9vc3rGU=;
        b=BlcCHRDCthpZZ3jEmF4SbiA/nIfmc4AtJALhhofIohO9xiHTn5gY3jXZlOHPmfT6N7mdEa
        IRsbZ/bPFaRSjlKmGJFC70xO9cjmH30lJaUwaqm00WtZzYrPBuPQ8HRt7FLS4ZnVy+at3r
        i3tjFoMaM9UL+5sZk6vsxxT6flhfk8Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-4hwClW1NNjea2b-hgiPEmA-1; Wed, 31 May 2023 10:44:07 -0400
X-MC-Unique: 4hwClW1NNjea2b-hgiPEmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55CDB85A5BE
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 14:44:07 +0000 (UTC)
Received: from localhost (unknown [10.45.226.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12880112132C;
        Wed, 31 May 2023 14:44:06 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH 4/5] checkpolicy: Add examples to man pages
In-Reply-To: <20230524111535.1743163-4-vmojzis@redhat.com>
References: <20230524111535.1743163-1-vmojzis@redhat.com>
 <20230524111535.1743163-4-vmojzis@redhat.com>
Date:   Wed, 31 May 2023 16:44:06 +0200
Message-ID: <87wn0ok1c9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Vit Mojzis <vmojzis@redhat.com> writes:

> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  checkpolicy/checkpolicy.8 | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
> index 2984c238..aefa148c 100644
> --- a/checkpolicy/checkpolicy.8
> +++ b/checkpolicy/checkpolicy.8
> @@ -12,8 +12,8 @@ command.
>  .PP
>  .B checkpolicy
>  is a program that checks and compiles a SELinux security policy configuration
> -into a binary representation that can be loaded into the kernel.  If no 
> -input file name is specified,
> +into a binary representation that can be loaded into the kernel.
> +If no input file name is specified,
>  .B checkpolicy
>  will attempt to read from policy.conf or policy, depending on whether the \-b
>  flag is specified.
> @@ -64,6 +64,17 @@ Show version information.
>  .B \-h,\-\-help
>  Show usage information.
>  
> +.SH EXAMPLE
> +.nf
> +Generate policy.conf based on the system policy
> +# checkpolicy -b -M -F /etc/selinux/targeted/policy/policy.* -o policy.conf

Would not work on a system with multiple policy files:

# ls -l /etc/selinux/targeted/policy/
total 7016
-rw-r--r--. 1 root root 3590656 May 31 16:42 policy.32
-rw-r--r--. 1 root root 3590656 May 29 08:22 policy.33

# checkpolicy -b -M -F /etc/selinux/targeted/policy/policy.* -o policy.conf
usage:  checkpolicy [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M] [-c policyvers (15-33)] [-o output_file|-] [-S] [-O] [-t target_platform (selinux,xen)] [-E] [-V] [input_file]

In EXAMPLES I think it's safe to use policy.33 everywhere. 

> +Recompile system policy so that unknown permissions are denied (uses policy.conf from ^^).
> +Note that binary policy extension represents its version, which is subject to change
> +# checkpolicy -M -U deny -o /etc/selinux/targeted/policy/policy.33 policy.conf
> +# load_policy
> +Generate CIL representation of current system policy
> +# checkpolicy -b -M -C /etc/selinux/targeted/policy/policy.* -o policy.out
> +
>  .SH "SEE ALSO"
>  SELinux Reference Policy documentation at https://github.com/SELinuxProject/refpolicy/wiki
>  
> -- 
> 2.40.0

