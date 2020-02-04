Return-Path: <SRS0=kuBz=3Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206CDC35247
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 15:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24E32082E
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 15:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Owrd9+pz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgBDPt5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Feb 2020 10:49:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53406 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727378AbgBDPt4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Feb 2020 10:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580831395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jc0jwQ8Mrnulk4hcRGlXfLCKMEivRMsq7jO1NHpoXC0=;
        b=Owrd9+pzx0kfXsy8f/onzE7Bpu6Iho05fDb4L3wcOYaWdhnqq5aR0PEY2b+c7bHVkq+pxK
        RsklkuQ46fguDm5GPWfwCtVOWm6vQywbTbnqFxNZpkuk46GOVa339F3nIHpWtLfgK4GWSK
        AKYaLSC1sBm1p4cBJNKVNuasTJfCLS4=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-COfmqhmbNGSl_6VOT3HV-w-1; Tue, 04 Feb 2020 10:49:37 -0500
X-MC-Unique: COfmqhmbNGSl_6VOT3HV-w-1
Received: by mail-ot1-f72.google.com with SMTP id d16so11214122otq.19
        for <selinux@vger.kernel.org>; Tue, 04 Feb 2020 07:49:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jc0jwQ8Mrnulk4hcRGlXfLCKMEivRMsq7jO1NHpoXC0=;
        b=YDus/ZCkcx4WyD/gl3hf+luwIyUcY7bzJzMjp+aBCct6gBN35u+aVqgaPPEvgINNM6
         qQTUR7AkTvaAm/s7piAwc4CYz3EDoGSwUx9nxRoQMGvHiykwh7/vN37/E9kzT+/O9RWM
         luk9EwA52Y14BfJJQhjY+Rd55VCLdVbx+nqK4BwGQHlZmIMZ7ZAKGDIHgZfX5K09OU0t
         ImRM2z/aNxyOwWy8rmaeIlJGSyr0sTQW3f3b4ABagdn8eelzCNqmtefQH84PuhESjVZV
         5rHKJAGZ9qPdPRlFzUvbs2Gp5Gml5W9wUEZWSrn51GP7Jps7C1ChljJJyfiQrUUZLdCN
         8/lg==
X-Gm-Message-State: APjAAAX/gYtnx8HTYmPwcpkJA1qWM1dD1yB7UIc6NnUDP4zYtINms+rI
        RbwaAtkw8qXXwCD6CJqUXoheOAueIZR/B6yKeoUFCbDLmzRVEdoamx1msqEnlYqokTHNrsWv6+M
        2aYY2PxZzvlDfCiDkiyFLFINYODyFRwOQzQ==
X-Received: by 2002:aca:1708:: with SMTP id j8mr3906522oii.166.1580831376600;
        Tue, 04 Feb 2020 07:49:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/7pJYKxR0wQIzWWmQ6QzoKdiSTwKnxwtzbmml2Vsp/OVsGZOcyT2Pr2dG8+zqCPa3KsU9UiVHZDCr6yugfxo=
X-Received: by 2002:aca:1708:: with SMTP id j8mr3906505oii.166.1580831376283;
 Tue, 04 Feb 2020 07:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20200116213937.77795-1-dev@lynxeye.de> <2d1a3d66-c2ee-f7ea-a884-11ac9150d994@tycho.nsa.gov>
 <CAFqZXNtJ2h-HPwzV9t1bizVB2=xWh=s3jY5aqXG1x86b+oEMYg@mail.gmail.com> <f821809b-548d-fd95-6574-7c74c634353e@tycho.nsa.gov>
In-Reply-To: <f821809b-548d-fd95-6574-7c74c634353e@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 4 Feb 2020 16:49:24 +0100
Message-ID: <CAFqZXNvih96sEODRJhFvCmx50ROWMb6vF1dK3sUJe_Q4hLiSzw@mail.gmail.com>
Subject: Re: [PATCH RFC] selinux: policydb - convert filename trans hash to rhashtable
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Lucas Stach <dev@lynxeye.de>, Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 4, 2020 at 4:39 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/4/20 10:01 AM, Ondrej Mosnacek wrote:
> > On Fri, Jan 17, 2020 at 8:11 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 1/16/20 4:39 PM, Lucas Stach wrote:
> >>> The current hash is too small for current usages in, e.g. the Fedora standard
> >>> policy. On file creates a considerable amount of CPU time is spent walking the
> >>> the hash chains. Increasing the number of hash buckets somewhat mitigates the
> >>> issue, but doesn't completely get rid of the long hash chains.
> >>>
> >>> This patch does take the bit more invasive route by converting the filename
> >>> trans hash to a rhashtable to allow this hash to scale with load.
> >>>
> >>> fs_mark create benchmark on a SSD device, no ramdisk:
> >>> Count          Size       Files/sec     App Overhead
> >>> before:
> >>> 10000          512        512.3           147715
> >>> after:
> >>> 10000          512        572.3            75141
> >>>
> >>> filenametr_cmp(), which was the topmost function in the CPU cycle trace before
> >>> at ~5% of the overall CPU time, is now down in the noise.
> >>
> >> Thank you for working on this.  IMHO, Fedora overuses name-based type
> >> transitions but that's another topic. I haven't yet investigated the
> >> root cause but with your patch applied, I see some test failures related
> >> to name-based transitions:
> >>
> >> [...]
> >> #   Failed test at overlay/test line 439.
> >> overlay/test ................ 114/119 # Looks like you failed 1 test of 119.
> >> [...]
> >> filesystem/test ............. 3/70 File context error, expected:
> >>          test_filesystem_filenametranscon1_t
> >> got:
> >>          test_filesystem_filetranscon_t
> >>
> >> #   Failed test at filesystem/test line 279.
> >> File context error, expected:
> >>          test_filesystem_filenametranscon2_t
> >> got:
> >>          test_filesystem_filetranscon_t
> >>
> >> #   Failed test at filesystem/test line 286.
> >> filesystem/test ............. 68/70 # Looks like you failed 2 tests of 70.
> >>
> >> You can reproduce by cloning the selinux-testsuite from
> >> https://github.com/SELinuxProject/selinux-testsuite, applying the
> >> filesystem tests patch from
> >> https://patchwork.kernel.org/patch/11337659/,
> >> and following the README.md instructions.
> >
> > I think I figured out what's wrong - see below.
> > <snip>
> >>> @@ -441,6 +442,39 @@ static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
> >>>
> >>>    }
> >>>
> >>> +static const struct rhashtable_params filename_trans_hashparams = {
> >>> +     .nelem_hint             = 1024,
> >>> +     .head_offset            = offsetof(struct filename_trans, hash_head),
> >
> > You need to add:
> >
> > +.hashfn = filenametr_hash,
> >
> > here so that the key is correctly hashed on lookup. After applying
> > this fix, the selinux-testuite passes for me with this patch.
>
> Hmm..does that then make the .obj_hashfn assignment below unnecessary or
> is that required too?  I'm unclear on the difference.

No, they serve different purposes - hashfn is used to hash the key you
pass when you do the lookup, while obj_hashfn is used to hash the full
objects stored in the hash table. In general, these can be different
types, but here we use the same type for both, so the same function
can be reused for both callbacks.

>
> >
> >>> +     .obj_hashfn             = filenametr_hash,
> >>> +     .obj_cmpfn              = filenametr_cmp,
> >>> +};
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

