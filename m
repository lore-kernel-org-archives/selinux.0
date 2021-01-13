Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F06C433E6
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 10:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E362339F
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 10:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbhAMK6W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 05:58:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727048AbhAMK6W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 05:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610535416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5mnxdraFFc27NKPKaDd5/PxGNaQDZhdz3BpuYoF4+jY=;
        b=EYzIWxYgCTBnk2L/61+d6p59OId9BJHbcLa2Pc/zg+UZmWVB7n1UAGGRgvsGd+5N8buq1n
        9TUA6UxHEOOBoq8DbVQAbvItJavdZLgd0qGxRJ53MV/0yG25rdW+FR2Fn8F0+n0uOc6kng
        9a4BMC+OntI/EPju47v6etD/n5CLJoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-52fHE9t9Mq2VGNsItg2Cnw-1; Wed, 13 Jan 2021 05:56:52 -0500
X-MC-Unique: 52fHE9t9Mq2VGNsItg2Cnw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D44E918C8C02;
        Wed, 13 Jan 2021 10:56:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-8.rdu2.redhat.com [10.10.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05A086A914;
        Wed, 13 Jan 2021 10:56:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <e6bd9820-8b77-57fc-f318-9b928e4d951b@schaufler-ca.com>
References: <e6bd9820-8b77-57fc-f318-9b928e4d951b@schaufler-ca.com> <1610099389-28329-1-git-send-email-pnagar@codeaurora.org> <0f467390-e018-6051-0014-ab475ed76863@schaufler-ca.com> <dab6357acbd63edd53099d106d111bf4@codeaurora.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, pnagar@codeaurora.org, arnd@arndb.de,
        jmorris@namei.org, serge@hallyn.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-arch@vger.kernel.org, psodagud@codeaurora.org,
        nmardana@codeaurora.org, dsule@codeaurora.org,
        Joe Perches <joe@perches.com>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] selinux: security: Move selinux_state to a separate page
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2646560.1610535404.1@warthog.procyon.org.uk>
Date:   Wed, 13 Jan 2021 10:56:44 +0000
Message-ID: <2646561.1610535404@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> >> How would this interact with or complement __read_mostly?
> >>
> > Currently, the mechanism we are working on developing is
> > independent of __read_mostly. This is something we can look more into
> > while working further on the mechanism.
> 
> Please either integrate the two or explain how they differ.
> It appears that you haven't considered how you might exploit
> or expand the existing mechanism.

I think __read_mostly is about grouping stuff together that's rarely going to
be read to make the CPU's data cache more efficient.  It doesn't stop people
writing to such a variable.

David

