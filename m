Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB6FC3A5A6
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 07:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D34222C5
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 07:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uz4656Sh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfISHnm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:43:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57096 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729087AbfISHnm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 03:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568879021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmnJsXOfitDT8dD+Ui9mNqeU7wlvPkdjnKR062Pinuk=;
        b=Uz4656Sh8jQr8tWVabpfY/qzQsPXPSR64oVRKPhla7bI9IEVga8JNK7U8GhtYuz98Xig79
        py8fmsrb0eI/SXBOkbZgAZcmRomqeTTkYpzkl9tYRzewX2Uw5wxlwYej2f7P01O8+9SCC2
        tmxQyuz/8Bb19LNilr0oHqb/LrWPOeA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-LhZtsTQqNhKVn9TpQsz7-Q-1; Thu, 19 Sep 2019 03:43:39 -0400
Received: by mail-ot1-f72.google.com with SMTP id i7so1322534otp.2
        for <selinux@vger.kernel.org>; Thu, 19 Sep 2019 00:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfVRCKuBRwK+VOOEmsF3NEPuWHDJCZw6Jx7lw6gWcyQ=;
        b=FibJHGkZbAMVN4CjhV99Rp/M5T3P10uBQiz/OnTRUpUlHV2XATAL0aap64dn8P0W0c
         gN2IpEe97LbB9ImMahf9Qy9zNdi4VyKE1YEp6QJng7MeG0TzWGYT/3CENc7+/y3zhWEL
         BpQVaKiNsuP65FbzLClgXkTbkfKZE1//A+e3vZyblCCNW5BPdMVvvJUY7bOk7ycRYqyR
         Xxr+XYrvelbAFTIEhsnNatjqrLUv0rfZgnomradVaNHiYek6mk0qnF1iR7vMj91/01R/
         gwiRWyGqsll4XdrgFLbReck4XtmcS8j35ZvxS3gJO4o3t8vtkmfSdSyl8rjQPydVQbiY
         hkmA==
X-Gm-Message-State: APjAAAWbseo0dfIl3sF9nX5+K+BdliaYMcAGMlnsXth9vQOozJXCDl6L
        yuwhLuif0rqF1l5EWXk9cey9GSMvCwerDD7U8HFDEjAC18qs/udUJSpsQppFQ7s4YcNqbrq4sw5
        nkTYf/4CetXNani7rD2tVemqPK8WguymCmg==
X-Received: by 2002:aca:d581:: with SMTP id m123mr1296218oig.26.1568879018780;
        Thu, 19 Sep 2019 00:43:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz59F3AF12a6ZSRb7EuEN+dcBUuNIH7v3ikDgdX3+NuaJ5ehLMoesnZk3q/n9Z+l4GjY0jo+/XfTLczjFhYTG0=
X-Received: by 2002:aca:d581:: with SMTP id m123mr1296208oig.26.1568879018534;
 Thu, 19 Sep 2019 00:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190918125507.10778-1-sds@tycho.nsa.gov>
In-Reply-To: <20190918125507.10778-1-sds@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 19 Sep 2019 09:43:27 +0200
Message-ID: <CAFqZXNuZ00pFj_vyzJ3W3x2Fbs=NA+NDMCUR9fwpaerUfRU-pQ@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: apply perltidy to infiniband test scripts
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
X-MC-Unique: LhZtsTQqNhKVn9TpQsz7-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 18, 2019 at 2:55 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> The infiniband test scripts weren't compliant with perltidy so
> make check-syntax was failing.  Fix it.

Unfortunately there is some disconnect between the perltidy version
available in the Travis CI environment and the newer versions
available in more recent distributions... See this commit in the
audit-testsuite [1] - the decision is to follow the Travis format as
the common "standard" (there is really no better way until we patch
the Travis script to install newer peritidy somehow...).

Just in case you don't know, anyone can easily enable Travis CI on
their GitHub fork - just go to https://travis-ci.org/, log in with
your GitHub account, and switch the corresponding project to enabled.
That way you can just push a branch to your fork, it will be tested
and you will get a report to (just) your mailbox. I.e. you can do the
canonical syntax check without opening a PR against the upstream repo.

[1] https://github.com/linux-audit/audit-testsuite/commit/7ff3e434bc243e667=
ebb26a22b64176e662fddec

>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  tests/infiniband_endport/test | 2 +-
>  tests/infiniband_pkey/test    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/infiniband_endport/test b/tests/infiniband_endport/tes=
t
> index 0021e0d69af4..f071fbc18cf8 100755
> --- a/tests/infiniband_endport/test
> +++ b/tests/infiniband_endport/test
> @@ -40,7 +40,7 @@ ok( $result, 0 );
>
>  foreach (@denied_device_port) {
>      @dev_port_pair =3D split( / /, $_ );
> -    $result =3D system
> +    $result        =3D system
>  "runcon -t test_ibendport_manage_subnet_t smpquery PKeyTable -C $dev_por=
t_pair[0] -P $dev_port_pair[1] -D 1 2>/dev/null";
>
>      if ( $result >> 8 eq 0 ) {
> diff --git a/tests/infiniband_pkey/test b/tests/infiniband_pkey/test
> index 3ee4d13c8ffe..382c25913ca0 100755
> --- a/tests/infiniband_pkey/test
> +++ b/tests/infiniband_pkey/test
> @@ -32,7 +32,7 @@ close($f);
>
>  # The gid sysfs shows a fully expanded ipv6 address, just take the
>  # top half.
> -@tmp =3D unpack( '(a20)*', $gid );
> +@tmp           =3D unpack( '(a20)*', $gid );
>  $subnet_prefix =3D $tmp[0] . ":";
>
>  @labeled_pkeys =3D split( /,/, $conf{SELINUX_INFINIBAND_TEST_LABELED_PKE=
YS} );
> --
> 2.21.0
>

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

