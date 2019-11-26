Return-Path: <SRS0=SqeD=ZS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01104C432C0
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 15:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B096020727
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 15:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgMbb1Wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfKZPCq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:02:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29390 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbfKZPCq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Nov 2019 10:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574780565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fA3WAC860Iw2GAVHYH8kSyvdCQYNpnc3pG9TSRmlwk4=;
        b=IgMbb1Wp35SN/CKc4zWkASp2rpi65Zm93NXpzF8/r+v51YjZ18SjxRU/ecE+2j2jgQA9ot
        SKkbgJc61/EbxMvp1y7H/aWR6plPVRKU4+PZ8XbE8EqNwnYuSbt0iLhzXkFA8jCXMnTFS4
        1jcE+lmCNDeu8iBwuSzura9COxjvkG0=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-6z4LmBbcNtGA1GSOVpCPIQ-1; Tue, 26 Nov 2019 10:02:42 -0500
Received: by mail-ot1-f69.google.com with SMTP id 60so10136021otd.19
        for <selinux@vger.kernel.org>; Tue, 26 Nov 2019 07:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fmYoaL2+kamohU5nbObW5a2k4SI+QExyOB/GMmR7YwQ=;
        b=DsWrtxNUWkAQ4m5IrHO+ZHWx3ffy+iHV0hS9vaho73mRnVSJAfAkaIMTG1ztpPHuOf
         da3WkfQCbJbBPaX1Mn2pxTe5G39Oh9p+EvHXrLNamXHulBwRs/gzoiZAg+zAksYW2Ekr
         cgHrw+t5Yg8FTS0OA4ET/J14uFnGounH6smfnCTFwYm7EgJSl1IpgROUz7YPIc61/JLa
         rcgMp2Kt9ZiTbS17pGfXmiyFKmkjXRf1pJGiiMx37609rkMIaF98pq+ghW40bQ/Xfyr6
         dtdPz9wl2mpTvk+PLoIK/A4pkVH6vN/Skaf5W31oZS7zY35SkNejlSReFZbITZQmaGQo
         OiVw==
X-Gm-Message-State: APjAAAU+fsMSUOxQsVS2G6q7R1fTFQ5JEukGkcGsODfh0ShWwWpD4iRf
        A9uIMaRvttquMKeyqJMuFzF+VTmZVkd11sRcb8OTaUg+sQcA24m1ACD6s5798WTcG+HZ8FHKYAa
        An3QSGm+4YzVSD4CII0/dyDwMaB4sOhy3Rw==
X-Received: by 2002:aca:b445:: with SMTP id d66mr4100024oif.103.1574780561917;
        Tue, 26 Nov 2019 07:02:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzytfMx4lsQqy3nRUBTgzWxmNM7GmwI2gmS56AiV6dxgUoTq1B8yZr/BkDaaL5RhqRHVKju8/eAFF2moH3tzpU=
X-Received: by 2002:aca:b445:: with SMTP id d66mr4099980oif.103.1574780561520;
 Tue, 26 Nov 2019 07:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20191126120623.736870-1-omosnace@redhat.com> <c765adb1e61950cb0f2aea6cbb7d4b94797b2a31.camel@btinternet.com>
 <2723e1c7-7e17-b8fc-757d-4a126ded8354@tycho.nsa.gov>
In-Reply-To: <2723e1c7-7e17-b8fc-757d-4a126ded8354@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 26 Nov 2019 16:02:43 +0100
Message-ID: <CAFqZXNtaDV0d1riR2kc-ygW_bfUUE+r7y0vL_4+xJ97Ff7W_sA@mail.gmail.com>
Subject: Re: [PATCH testsuite v3] policy: use the kernel_request_load_module() interface
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>
X-MC-Unique: 6z4LmBbcNtGA1GSOVpCPIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 26, 2019 at 3:54 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/26/19 9:51 AM, Richard Haines wrote:
> > On Tue, 2019-11-26 at 13:06 +0100, Ondrej Mosnacek wrote:
> >> ...instead of open-coding the rules. Also define a fallback to allow
> >> the
> >> policy to build even if the interface is not defined.
> >>
> >> Fixes: f5e5a0b8d005 ("selinux-testsuite: Add key_socket tests")
> >> Cc: Richard Haines <richard_c_haines@btinternet.com>
> >> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> >> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >> ---
> >>
> >> Change in v3: use different approach as suggested by Stephen
> >> Change in v2: update also tests/Makefile for consistency
> >>
> >>   policy/test_key_socket.te | 8 ++++----
> >>   policy/test_policy.if     | 6 ++++++
> >>   2 files changed, 10 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/policy/test_key_socket.te b/policy/test_key_socket.te
> >> index cde426b..f1c1606 100644
> >> --- a/policy/test_key_socket.te
> >> +++ b/policy/test_key_socket.te
> >> @@ -13,7 +13,7 @@ typeattribute test_key_sock_t keysockdomain;
> >>   allow test_key_sock_t self:capability { net_admin };
> >>   allow test_key_sock_t self:key_socket { create write read setopt };
> >>   # For CONFIG_NET_KEY=3Dm
> >> -allow test_key_sock_t kernel_t:system { module_request };
> >> +kernel_request_load_module(test_key_sock_t)
> >>
> >>   ################## Deny capability { net_admin }
> >> ##########################
> >>   #
> >> @@ -29,7 +29,7 @@ typeattribute test_key_sock_no_net_admin_t
> >> testdomain;
> >>   typeattribute test_key_sock_no_net_admin_t keysockdomain;
> >>
> >>   allow test_key_sock_no_net_admin_t self:key_socket { create write
> >> read setopt };
> >> -allow test_key_sock_no_net_admin_t kernel_t:system { module_request
> >> };
> >> +kernel_request_load_module(test_key_sock_t)
> >
> > All the new entries have (test_key_sock_t) ??
> > Anyway if you run the tests in the order they appear in 'test' script,
> > then it just so happens that the module will be loaded for
> > test_key_sock_t as it's first. I added the others just to cover the
> > cases where I sometimes run out of sequence, so you could remove these
> > if required.

*facepalm*

Yes, sorry, I messed up the copy-paste...

>
> Good catch!  Somehow I missed that.  Could probably just have a single
> kernel_request_load_module(keysockdomain) line?

There is one domain (test_key_sock_no_create_t) that doesn't have the
rule, so probably not.

>
> >
> >>
> >>   ####################### Deny key_socket { create }
> >> ##########################
> >>   type test_key_sock_no_create_t;
> >> @@ -50,7 +50,7 @@ typeattribute test_key_sock_no_write_t
> >> keysockdomain;
> >>
> >>   allow test_key_sock_no_write_t self:capability { net_admin };
> >>   allow test_key_sock_no_write_t self:key_socket { create read setopt
> >> };
> >> -allow test_key_sock_no_write_t kernel_t:system { module_request };
> >> +kernel_request_load_module(test_key_sock_t)
> >>
> >>   ####################### Deny key_socket { read }
> >> ##########################
> >>   type test_key_sock_no_read_t;
> >> @@ -61,7 +61,7 @@ typeattribute test_key_sock_no_read_t
> >> keysockdomain;
> >>
> >>   allow test_key_sock_no_read_t self:capability { net_admin };
> >>   allow test_key_sock_no_read_t self:key_socket { create write setopt
> >> };
> >> -allow test_key_sock_no_read_t kernel_t:system { module_request };
> >> +kernel_request_load_module(test_key_sock_t)
> >>
> >>   #
> >>   ########### Allow these domains to be entered from sysadm domain
> >> ############
> >> diff --git a/policy/test_policy.if b/policy/test_policy.if
> >> index e1175e8..3f163cb 100644
> >> --- a/policy/test_policy.if
> >> +++ b/policy/test_policy.if
> >> @@ -82,3 +82,9 @@ interface(`userdom_search_admin_dir', `
> >>       userdom_search_user_home_content($1)
> >>   ')
> >>   ')
> >> +
> >> +# If the macro isn't defined, then most probably module_request
> >> permission
> >> +# is just not supported (and relevant operations should be just
> >> allowed).
> >> +ifdef(`kernel_request_load_module', `', ` dnl
> >> +interface(`kernel_request_load_module', `')
> >> +')
> >
>


--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

