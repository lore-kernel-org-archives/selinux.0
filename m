Return-Path: <SRS0=8S61=Y2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB320CA9EC7
	for <selinux@archiver.kernel.org>; Sat,  2 Nov 2019 19:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20872080F
	for <selinux@archiver.kernel.org>; Sat,  2 Nov 2019 19:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qoi0fSjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKBTwS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 2 Nov 2019 15:52:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37691 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726523AbfKBTwS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 2 Nov 2019 15:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572724336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LoSoIm4cpiQveZO1wT1MtbmrKER6Apjqtum6wbEGEaQ=;
        b=Qoi0fSjFi1uLvJla3FbdXGW7JUBcZcqZEwCYnLr+ySDQ8py6Jn8UbhVgHt1ZSx5P8rR1GP
        VYbO08if+ENnJf/PiaXRXelO+KiWGIT76BPNb04xsVLjMsUBPx4n0CeXdp3Avv0EfTzclg
        +VWlJBG1tnMXcGSiw1fhKe9tBBtgC9c=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-eu3jCIUWNuGgD574KBH_Bg-1; Sat, 02 Nov 2019 15:52:14 -0400
Received: by mail-oi1-f200.google.com with SMTP id q78so6803696oic.0
        for <selinux@vger.kernel.org>; Sat, 02 Nov 2019 12:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uuhyFmYA8cs/zK62+aexTxWDGKEYqvner8jV9Vo2ZN8=;
        b=byOsu/llIbsnk879g3e64K5u7akpEtY+N62lMrr7jmluhYlATQ0Lbb+qa5vUiMQDku
         jLp1N75SLLRrpPiGF5aqacqPuDqaQxDhrs5kTomWY8FAlkdg/jzL8vNd8d9XB6+wbiOK
         OIloTNEBc6dPZgk58Unk4HHBG0Ht7hift70MIZ3JKQoMSsczr7H8hv8PiWajA45GGJ9G
         IZmkbLh3jc43tP1wu/9XBJhpaS9rjRUkC1lsXWExdYkdLYPPex23Kno27+52+cZDRrL+
         /sSnwc9SXobJCsYTNVBa28i77ozzCgurDtoHBJHc+xaInsfpFeykQa16ij+Ww2AoQm1d
         S3wg==
X-Gm-Message-State: APjAAAUYVlIQJkSEgkKZXeuDyGapqSfLNhkhyHDel/oTjjNAx7twlnan
        Ppzt+IY9hoLI0YqWtCVcnuFDolqux0SsnA24nyuVk5cvUqDyHOeQOQD6ZB63AuRsiDzp3HyjowX
        OwykPJLikCpAvhxNkbJcDSDJiyF06dL2kag==
X-Received: by 2002:a9d:7756:: with SMTP id t22mr12994391otl.43.1572724333890;
        Sat, 02 Nov 2019 12:52:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwfF+5+0IlV96JySsc7ci8lu2Pc1v0h1qrBtiENXUDj2uo9qDzLBHkHz1+dlzaY06/dmajU+7RI2eIpeLvuc+s=
X-Received: by 2002:a9d:7756:: with SMTP id t22mr12994380otl.43.1572724333485;
 Sat, 02 Nov 2019 12:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191030101949.191788-1-jeffv@google.com> <5045a962-36e1-d7d0-2750-10e55c01975e@tycho.nsa.gov>
 <CABXk95B-woFimHCv3RuUdSJvEQ4C_KGvsT=qAQ6kup+eYov65w@mail.gmail.com>
 <7cc2b7c7-9f79-96e3-eccf-6661e7a51291@tycho.nsa.gov> <CABXk95CLsQx9gaQn+QxpuU5aj4mVCK5V9Y1ZeYhhsYk_-c5q_g@mail.gmail.com>
 <ef2bc55e-06d1-f8e7-1e73-e5afc6e50c02@tycho.nsa.gov> <CABXk95Di-Fz=Wao+4muid_dSMJ+jm19a3sgR8fddRbrx0iSvSQ@mail.gmail.com>
In-Reply-To: <CABXk95Di-Fz=Wao+4muid_dSMJ+jm19a3sgR8fddRbrx0iSvSQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 2 Nov 2019 20:52:02 +0100
Message-ID: <CAFqZXNtNz6Wzd32xbPpMKsDn1Axh61LOmYFAQ8q7KV7P_j4MMA@mail.gmail.com>
Subject: Re: [PATCH] selinux: sidtab: reverse lookup hash table
To:     Jeffrey Vander Stoep <jeffv@google.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>,
        Jovana Knezevic <jovanak@google.com>,
        Paul Moore <paul@paul-moore.com>
X-MC-Unique: eu3jCIUWNuGgD574KBH_Bg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 30, 2019 at 9:06 PM Jeffrey Vander Stoep <jeffv@google.com> wro=
te:
> On Wed, Oct 30, 2019 at 9:02 PM Stephen Smalley <sds@tycho.nsa.gov> wrote=
:
> > On 10/30/19 3:07 PM, Jeffrey Vander Stoep wrote:
> > > On Wed, Oct 30, 2019 at 7:57 PM Stephen Smalley <sds@tycho.nsa.gov> w=
rote:

<snip>

> > >> Wondering if we still need at least a write barrier in the code that
> > >> adds a node prior to hash_add() to ensure the node contents are sane=
.
> > >
> > > I'm not sure what you mean. Are you concerned about compiler reorderi=
ng?
> >
> > Compiler or processor.  Are we guaranteed that node->sid and
> > node->context are sane before the node is visible to the readers?  The
> > old sidtab code (before Ondrej's rewrite) used to issue a full wmb()
> > after setting the node->sid, node->context, and node->next prior to
> > linking the node into the list.
>
> Got it, thanks. I'll look into that and include it in v2 if necessary.

Note that the code is still using memory barriers in a similar way.
Specifically, it uses smp_load_acquire() and smp_store_release() to
correctly order reading/writing the count and the content of the
subtree needed to access the corresponding number of entries (see
commit 116f21bb967f ("selinux: avoid atomic_t usage in sidtab")).
These are helper macros that basically just do
READ_ONCE()/WRITE_ONCE() in combination with spm_mb() under the hood.
I think you should be able to use them here as well, but if they turn
out not to be suitable, you can just open code the combination as
needed.

<snip>

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

