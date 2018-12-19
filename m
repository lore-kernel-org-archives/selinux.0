Return-Path: <SRS0=VZrA=O4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B97C43387
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 12:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750D42133F
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 12:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbeLSMcq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:32:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbeLSMcq (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 19 Dec 2018 07:32:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2EC571E2F0;
        Wed, 19 Dec 2018 12:32:46 +0000 (UTC)
Received: from workstation (unknown [10.43.12.238])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 711C817197;
        Wed, 19 Dec 2018 12:32:44 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 1/1] python/sepolgen: always indent with 4 spaces
References: <20181215181724.31808-1-nicolas.iooss@m4x.org>
Date:   Wed, 19 Dec 2018 13:32:43 +0100
In-Reply-To: <20181215181724.31808-1-nicolas.iooss@m4x.org> (Nicolas Iooss's
        message of "Sat, 15 Dec 2018 19:17:24 +0100")
Message-ID: <pjdsgytu26s.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 19 Dec 2018 12:32:46 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> p_attribute_role_def() used tabs.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>


Merged. Thanks!

> ---
>  python/sepolgen/src/sepolgen/refparser.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
> index 97e2342c4693..9fb931828278 100644
> --- a/python/sepolgen/src/sepolgen/refparser.py
> +++ b/python/sepolgen/src/sepolgen/refparser.py
> @@ -757,9 +757,9 @@ def p_attribute_def(p):
>      p[0] = a
>  
>  def p_attribute_role_def(p):
> -	'attribute_role_def : ATTRIBUTE_ROLE IDENTIFIER SEMI'
> -	a = refpolicy.Attribute_Role(p[2])
> -	p[0] = a
> +    'attribute_role_def : ATTRIBUTE_ROLE IDENTIFIER SEMI'
> +    a = refpolicy.Attribute_Role(p[2])
> +    p[0] = a
>  
>  def p_typealias_def(p):
>      'typealias_def : TYPEALIAS IDENTIFIER ALIAS names SEMI'
