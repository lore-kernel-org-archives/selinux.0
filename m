Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059BBC636CC
	for <selinux@archiver.kernel.org>; Tue,  7 Feb 2023 11:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjBGLA2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Feb 2023 06:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjBGLAW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Feb 2023 06:00:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF6A2A981
        for <selinux@vger.kernel.org>; Tue,  7 Feb 2023 02:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675767575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jlFel+2YkedLl19NSkU1kI2oNwXDQCiygTymE2IkQPU=;
        b=U7/Tu+422daRt06/bgQPHDNaLsjXjQiHNzFWkH2RCmBnIqkRd3acv8lMjsNxKChIX2/o4c
        2Rvzw04NP5PHaTDTGtwcSAtsRODBaThuCdT5O4J4dVqzTkEpgAC+rubFsXIoN/0nfZjvD1
        HR23G1L0pGJKca+2nEM4cFgwaYx7Dww=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-X-wXBTjoPvOAw7jCJ9tFVA-1; Tue, 07 Feb 2023 05:59:30 -0500
X-MC-Unique: X-wXBTjoPvOAw7jCJ9tFVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3ABF8181E3EE;
        Tue,  7 Feb 2023 10:59:30 +0000 (UTC)
Received: from localhost (ovpn-194-64.brq.redhat.com [10.40.194.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E743818EC5;
        Tue,  7 Feb 2023 10:59:29 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     Chris PeBenito <pebenito@ieee.org>,
        SElinux mailing list <selinux@vger.kernel.org>
Subject: Re: ANN: SETools 4.4.1
In-Reply-To: <988e8169-e701-80c8-2b95-5fb2cc03e015@ieee.org>
References: <988e8169-e701-80c8-2b95-5fb2cc03e015@ieee.org>
Date:   Tue, 07 Feb 2023 11:59:29 +0100
Message-ID: <878rh9eo6m.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Chris PeBenito <pebenito@ieee.org> writes:

> An new release of SETools is available:
>
> https://github.com/SELinuxProject/setools/releases/tag/4.4.1
>
> Changes:
>
> * Replace deprecated NetworkX function use in information flow and 
> domain transition analysis. This function was removed in NetworkX 3.0.
>
> * Fix bug in apol copy and cut functions when copying from a tree view.
>
> * Fix bug with extended permission set construction when a range 
> includes 0x0.
>
> * Add sesearch -Sp option for permission subset match.
>
> * Fix error in man page description for sesearch -ep option.
>
> * Improve output stability in constraint, common, class, role, and user
> queries.
>
> * Updated permission map.
>
> * Fix bug in sechecker parsing of multiline values.
>
> * Other code cleanups not visible to users.

It looks like https://github.com/SELinuxProject/setools/pull/68 didn't
get into the release. Is it expected? If yes, would it be possible to
backport it to 4.4 branch for the next 4.4.x release please?

Thanks,

Petr

