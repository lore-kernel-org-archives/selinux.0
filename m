Return-Path: <SRS0=JJ8R=XP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE83C3A5A2
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 19:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD680208C0
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 19:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Osg7MIw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfITTaD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Sep 2019 15:30:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51209 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726234AbfITTaD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Sep 2019 15:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569007800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KBL2Zfmb487Ww6IKQyyvX4DxKwzDGMd+3kpogZGwicM=;
        b=Osg7MIw/+eMzGki0b6Jj6z/77KRjJ9QOrEZKqzx6zfwifvEaxgCEu30m0Q4/fwjlY9deUG
        ZZoJAqcDjG9BVaLX3R01B9lZ3/mWSGOXeFPDiQeyjnK4VuV9C84G+jy334+y3TcwiT5eNB
        xgfb8NDP+Lw5wEwUOD9wm+ERDjYSQMQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-7jkJdgTJM124IBxqov__9Q-1; Fri, 20 Sep 2019 15:29:59 -0400
Received: by mail-oi1-f198.google.com with SMTP id i83so1768018oia.19
        for <selinux@vger.kernel.org>; Fri, 20 Sep 2019 12:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Mzx4r8xv59tgz/xC/4HJ+lC8fzLwvtx0BtV+4auS/A=;
        b=QXQ1R3h+xZi7+VQIBMkWmJkz/VlHREJowcT2aOwXXkzuaQ1IugLKVu7RJR+fWMBlQb
         p1aT8SfhAzGaeoFaSs8l17AGPqaG5NRcPfH2jc8vhcEVU8RPxaEIDV+KYW4TZHM9Mh5B
         7X5uqEhT4B9+Yy6mIQOrD8S54w14kzSiweDG0i9Y44Cqs/U8kTCz5FDIkQdFpvtqZivZ
         DjUCfypi3aFgXu0QSWU/Bf0DvqGE67FKTb4Th/xpgfCcYHHzsxoXEVjpAUHkRwMLouQf
         EyWLxAiDSQi9iJ9zJetDoYBHuh4i63ERs3pFAQ1nS92r+VfGKnvzWesRkjZFNxiddI+T
         ytBA==
X-Gm-Message-State: APjAAAWj8wpl+reN850MP7f3v0B6rws2/Y7gle+HnP7fzWaO3D1cN9ks
        h3YyNhxoD4FBFf4XPYaQMzCykxldqjsHqKVGqlqDASAxPaevhEE6Lot4IpkVDMABVudK2Vv/674
        wxKkdUWZCYJHgnuMS3dNexsJdzu1gKGJYtA==
X-Received: by 2002:a9d:65cd:: with SMTP id z13mr5168552oth.22.1569007798448;
        Fri, 20 Sep 2019 12:29:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyKSjBRdaTSCxqEoVmGfYYQVqUG23uZPFdVGI4y85Rzzs7TxMcMPJJimSIybFGrUEUleq4xbv98cw8ZOTGzM3I=
X-Received: by 2002:a9d:65cd:: with SMTP id z13mr5168526oth.22.1569007798227;
 Fri, 20 Sep 2019 12:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190920115019.23144-1-omosnace@redhat.com> <b8968a99-e780-d530-9e90-9650a7da70fc@tycho.nsa.gov>
In-Reply-To: <b8968a99-e780-d530-9e90-9650a7da70fc@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 20 Sep 2019 21:29:47 +0200
Message-ID: <CAFqZXNvQN18jJPdj-7jFQ_r54mOkXgzsq8ET4f94Dwt46X7-tA@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/Makefile: check if BPF library is installed
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>
X-MC-Unique: 7jkJdgTJM124IBxqov__9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 20, 2019 at 3:02 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 9/20/19 7:50 AM, Ondrej Mosnacek wrote:
> > Check for the existence of the <bpf/bpf.h> header before enabling BPF
> > testing. Otherwise building the tests fails in an environment where
> > the kernel and policy support BPF, but the library is not installed.
> >
> > Fixes: 8f0f980a4ad5 ("selinux-testsuite: Add BPF tests")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   tests/Makefile | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/tests/Makefile b/tests/Makefile
> > index e5bdfff..e8cf008 100644
> > --- a/tests/Makefile
> > +++ b/tests/Makefile
> > @@ -43,10 +43,12 @@ endif
> >
> >   ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && =
echo true),true)
> >   ifneq ($(shell ./kvercmp $$(uname -r) 4.15),-1)
> > +ifneq (,$(wildcard $(INCLUDEDIR)/bpf/bpf.h))
> >   SUBDIRS +=3D bpf
> >   export CFLAGS +=3D -DHAVE_BPF
> >   endif
> >   endif
> > +endif
>
> I think Richard had something like this originally and I told him to
> take it out.  The rationale was that he added libbpf-devel as a required
> dependency to the README and we don't want to silently skip tests
> because someone forgot to install some package; I'd rather it fail at
> build time.

OK, that makes sense. My motivation was the situation on RHEL-8, where
the kernel and policy matches the existing checks, but there is no
libbpf-devel available (not even in our internal repos or EPEL), but
there really doesn't seem to be any better way to handle that other
than excluding based on distro name/version. For now I'll just
conditionally exclude the test in our wrapper script. (There is a lot
of conditional tweaks already, I might try to upstream them one day so
that they are not split awkwardly between upstream and downstream...)

>
> >
> >   ifeq ($(shell grep "^SELINUX_INFINIBAND_ENDPORT_TEST=3D" infiniband_e=
ndport/ibendport_test.conf | cut -d'=3D' -f 2),1)
> >   SUBDIRS +=3D infiniband_endport
> >
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

