Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3807AC433F5
	for <selinux@archiver.kernel.org>; Tue, 17 May 2022 17:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbiEQRFf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 May 2022 13:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351317AbiEQRFa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 May 2022 13:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5206450443
        for <selinux@vger.kernel.org>; Tue, 17 May 2022 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652807126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x0SFnk4P5s3R2zfLrKISfBRpdDuyffMP5NnCNzi4anA=;
        b=DY+RnjanykBfqh2nTRO8XONWE9K+NUxuPdJg4huTPKK8Ii7PvuieXwOn9b4sBi4OcISoZa
        0ETj4ZAvHfjw7uW0ZK422HFfbiAA+1ZsE//7C+mIovJWqUcIgyrDiWXd4Uyc/VJowsJBPc
        Srd2UcQra67969ItooXhwLa4dGoEXxo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-VpJwXI8QN3aRdfWXr8swZQ-1; Tue, 17 May 2022 13:05:25 -0400
X-MC-Unique: VpJwXI8QN3aRdfWXr8swZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 158F5804181;
        Tue, 17 May 2022 17:05:25 +0000 (UTC)
Received: from localhost (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD0EA1410DDB;
        Tue, 17 May 2022 17:05:24 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] ci: declare git repository a safe directory
In-Reply-To: <20220517132622.3380-1-cgzones@googlemail.com>
References: <20220517132622.3380-1-cgzones@googlemail.com>
Date:   Tue, 17 May 2022 19:05:23 +0200
Message-ID: <87v8u46qek.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Since version 2.35.2, due to CVE-2022-24765, git refuses to operate by
> default on a repository owned by a different user.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

> ---
> test run: https://github.com/cgzones/selinux/actions/runs/2337320823
> ---
>  scripts/ci/fedora-test-runner.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-ru=
nner.sh
> index 3ce2c3a6..7676f6ea 100755
> --- a/scripts/ci/fedora-test-runner.sh
> +++ b/scripts/ci/fedora-test-runner.sh
> @@ -70,6 +70,7 @@ dnf install -y \
>  cd "$SELINUX_DIR"
>=20=20
>  # Show HEAD commit for sanity checking
> +git config --global --add safe.directory "$SELINUX_DIR"
>  git log --oneline -1
>=20=20
>  #
> --=20
> 2.36.1

