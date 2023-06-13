Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98818C7EE29
	for <selinux@archiver.kernel.org>; Tue, 13 Jun 2023 11:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241987AbjFMLWT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jun 2023 07:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242004AbjFMLV7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jun 2023 07:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6890E4
        for <selinux@vger.kernel.org>; Tue, 13 Jun 2023 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686655268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SESXhhWPBD3g3+slgn5BcnlTfoPcXfg2Nwp/UFldvWw=;
        b=hkENhQir9y6lNp4p+imgTsi9esgadDYxBN25L1vadvCAoJLIb+l8YtmW7KXsf3UWtTTLh6
        uOF/fduGABwvLhdo0k+TdS8Mp4S3zF6xjNPhsvrnzHvaUn4hLT4CfHhm5YkgkTJWtW8A5b
        Ru4kLYHShAcElMMxjJGhUnP3pUA+ZNI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-mES42_oiNYeBCP2OSMkHsg-1; Tue, 13 Jun 2023 07:20:59 -0400
X-MC-Unique: mES42_oiNYeBCP2OSMkHsg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF4BE29AB434
        for <selinux@vger.kernel.org>; Tue, 13 Jun 2023 11:20:58 +0000 (UTC)
Received: from P1.redhat.com (unknown [10.45.225.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EAE81121314;
        Tue, 13 Jun 2023 11:20:58 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     vmojzis@redhat.com
Subject: 
Date:   Tue, 13 Jun 2023 13:20:06 +0200
Message-ID: <20230613112054.2694389-1-lautrbach@redhat.com>
In-Reply-To: <20230613094346.2667592-5-lautrbach@redhat.com>
References: <20230613094346.2667592-5-lautrbach@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Fixed missing ')' in 1/4:

    python/chcat/chcat:125 print(_("{target} is already in {category}").format(target=f, category=orig)

