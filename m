Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D74BC433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 20:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E8520656
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 20:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aW1gbBVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHXUBe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58611 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbgHXUBd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 16:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598299291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uscrMvCrVpuzBs8CCqTlviFEzNB9Ka9n9LSLMNlONOY=;
        b=aW1gbBVcqVCzvpcGarXB2wzf8AKhuqvkFcHVXgh1TlkEXhVWUCt4jBa8izb0etDlQBm5Qw
        CS5v+tzjnzDszkdSwLTtn5c3pbrWAYgBtMHg4pptJanvmdiXgagJIAyImT0QJ7EM8pGcwI
        Ti3eWQNT4gIQmPw9ezRLOl7lOuLWRjE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-tK_IHMl5PLy16ilVVlcEYw-1; Mon, 24 Aug 2020 16:01:30 -0400
X-MC-Unique: tK_IHMl5PLy16ilVVlcEYw-1
Received: by mail-lf1-f72.google.com with SMTP id v15so1186888lfd.20
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 13:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uscrMvCrVpuzBs8CCqTlviFEzNB9Ka9n9LSLMNlONOY=;
        b=NULpjZp8OCG/mM54z87AegROc68nc2wLEN29MuJl5M1IZRPmXUEJfxL2Y3IWFf6BxQ
         J+5ocV3QUgoxaCpOFBy09QFWXJeaRk7m6Z0dAHqoKxX/+yygbLRDjrl9GbYgn2C/nyF/
         XFZ4qGa1Jd/+OpinAQ55xhAxPOMiI1EsfHuT+uCognmHHZvu8zTzhBkeoGFWZZ+7YYC4
         /EbXvrs8VtvF0QguVACl+lHEgSamV6QuNksWUteDG261g62AoqZ0rb8DlUxzTcEzLYPb
         LpH9JfUCoydvzdlZXNIEOsVt/4UbEjlGgvzkRRo6ZyBoxoBfQF3o75fouoOnzZ3zOu7Q
         yhFQ==
X-Gm-Message-State: AOAM5310ZQqBlQeVKGdTNS6fyeVsxdI+pHvQQVXV7sjyzx8EYB3y8MWx
        iBDe82sOdMDc0yZiwxhNmoOfeCEHSmiBSBdNR7TE7C6pn0iHzDlUC9N4l2s4l7Kqz/JJBp9B3v8
        lt+HIp0gSIpC8cqciPOvwFt9ILwlBydkGmg==
X-Received: by 2002:a2e:7010:: with SMTP id l16mr3180388ljc.38.1598299288322;
        Mon, 24 Aug 2020 13:01:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlH+auARhq7SWPbHEI59342ZMN+shTt3ocQ8lwjHmShhNGjby6clQhLnKc2Mg8F5+NM25k106HjhZgrKaoXJ0=
X-Received: by 2002:a2e:7010:: with SMTP id l16mr3180369ljc.38.1598299288036;
 Mon, 24 Aug 2020 13:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200822010018.19453-1-nramas@linux.microsoft.com>
 <CAEjxPJ5Kok-TBfS=XQ+NUC5tuaZRkyLBOawG4UDky51_bsMnGw@mail.gmail.com>
 <418618c4-a0c6-6b28-6718-2726a29b83c5@linux.microsoft.com> <CAEjxPJ6-8WnZRJnADsn=RVakzJiESjEjK-f8nSkscpT7dnricQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6-8WnZRJnADsn=RVakzJiESjEjK-f8nSkscpT7dnricQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 24 Aug 2020 22:01:17 +0200
Message-ID: <CAFqZXNvVQ5U6Ea3gT32Z0hfWbu7GPR-mTF2z6-JZZJT57Heuuw@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 24, 2020 at 9:30 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Aug 24, 2020 at 2:13 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
> >
> > On 8/24/20 7:00 AM, Stephen Smalley wrote:
> >
> > >> +int security_read_policy_kernel(struct selinux_state *state,
> > >> +                               void **data, size_t *len)
> > >> +{
> > >> +       int rc;
> > >> +
> > >> +       rc = security_read_policy_len(state, len);
> > >> +       if (rc)
> > >> +               return rc;
> > >> +
> > >> +       *data = vmalloc(*len);
> > >> +       if (!*data)
> > >> +               return -ENOMEM;
> > >>
> > >> +       return security_read_selinux_policy(state, data, len);
> > >>   }
> > >
> > > See the discussion here:
> > > https://lore.kernel.org/selinux/20200824113015.1375857-1-omosnace@redhat.com/T/#t
> > >
> > > In order for this to be safe, you need to ensure that all callers of
> > > security_read_policy_kernel() have taken fsi->mutex in selinuxfs and
> > > any use of security_read_policy_len() occurs while holding the mutex.
> > > Otherwise, the length can change between security_read_policy_len()
> > > and security_read_selinux_policy() if policy is reloaded.
> > >
> >
> > "struct selinux_fs_info" is available when calling
> > security_read_policy_kernel() - currently in measure.c.
> > Only "struct selinux_state" is.
> >
> > Is Ondrej's re-try approach I need to use to workaround policy reload issue?
>
> No, I think perhaps we should move the mutex to selinux_state instead
> of selinux_fs_info.  selinux_fs_info has a pointer to selinux_state so
> it can then use it indirectly.  Note that your patches are going to
> conflict with other ongoing work in the selinux next branch that is
> refactoring policy load and converting the policy rwlock to RCU.

Yeah, and I'm experimenting with a patch on top of Stephen's RCU work
that would allow you to do this in a straightforward way without even
messing with the fsi->mutex. My patch may or may not be eventually
committed, but either way I'd recommend holding off on this for a
while until the dust settles around the RCU conversion.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

