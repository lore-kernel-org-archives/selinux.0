Return-Path: <SRS0=745E=5M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB59C43331
	for <selinux@archiver.kernel.org>; Fri, 27 Mar 2020 19:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8E52071B
	for <selinux@archiver.kernel.org>; Fri, 27 Mar 2020 19:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXLI/BlA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgC0TND (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:13:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46884 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgC0TND (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Mar 2020 15:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585336382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Oc8dYg4g2u24S1bNu0HETtlFTDrw1HgwHU8Ir4saYw=;
        b=HXLI/BlAzHfOF0OisHiIfVTMcPlWO95FTleQ8y8aCDsP2jeOQl2yLucQqWjMUPtpO4j/VI
        R1GzUUisND72ciVnk/CukfqjzLF9/5bi8mUyrrCMO7Q+VSsKYQURsxZClCxaGnyzYjlg6H
        XbnLfAnLcuWffkJyghIEWUJmXMP9+wE=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-ZjV6yFlcPgGGbWpdpRXncA-1; Fri, 27 Mar 2020 15:12:59 -0400
X-MC-Unique: ZjV6yFlcPgGGbWpdpRXncA-1
Received: by mail-oi1-f200.google.com with SMTP id f71so8745400oib.18
        for <selinux@vger.kernel.org>; Fri, 27 Mar 2020 12:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Oc8dYg4g2u24S1bNu0HETtlFTDrw1HgwHU8Ir4saYw=;
        b=EiMlBMC6JeOEt6D7i71vPvYBwCa3PTGvHPG49IrPF1OcHTmOyCB0OsUZcXVB2yQYZi
         7YD+fopKiM8iED2XYpGExRXIbrLkkRVsJTqzA8irNbxw3U9i5rXfZ66dt4grf9vISifN
         AiY/r15sgEqABwyw3zINwarsAo2uzozUyb1n0111T7sm22u2x4OTKgvxFE4apgegLOmi
         5cp1s44z+CWWKwMwWs9VYEu0uaHYysRjU48noZyvfeMIjKQIOgcqxapeRLb51b0KEGYI
         2moEaCaokfnXBCu6u4fNHuhEHDOxEVlzjhMElAQAIXeuoUVXwD/CrMGic68gZNWBWFUn
         sW9w==
X-Gm-Message-State: ANhLgQ1SGZFwzh1rRsrlqQ7h92zgx4cRW8xNrbTKteFFj/Z8I1afmcJC
        LGGCbLuPaLRCHNWSQZAxEzJ0l+36J1oTmAh9TxpyzE2vJYX8YRLc6AlrjnRG2Xkhj1lp6OBSgeo
        NlrLnJqPmd3tUI7hK6FE6X77enRbT9/jbBw==
X-Received: by 2002:aca:d68e:: with SMTP id n136mr277596oig.103.1585336378672;
        Fri, 27 Mar 2020 12:12:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsACpcEnJWkMk1eD2I2JNrU49JylUKVGA91I7qa40XYFi81Mb9S89pr2cjicYd0HuUdIFTJMqSVIq6jkvauVhM=
X-Received: by 2002:aca:d68e:: with SMTP id n136mr277579oig.103.1585336378410;
 Fri, 27 Mar 2020 12:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200327152107.95915-1-omosnace@redhat.com> <20200327152107.95915-3-omosnace@redhat.com>
 <cb990775-f602-8436-4460-f78b7ce3a96f@tycho.nsa.gov>
In-Reply-To: <cb990775-f602-8436-4460-f78b7ce3a96f@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 27 Mar 2020 20:12:47 +0100
Message-ID: <CAFqZXNv+f_VKWo9LOZpPdatfcUoPd4zrbr7Ae_iihe-4foS4zw@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: implement POLICYDB_VERSION_COMP_FTRANS
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Chris PeBenito <pebenito@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 27, 2020 at 6:08 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 3/27/20 11:21 AM, Ondrej Mosnacek wrote:
> > Implement a new, more space-efficient form of storing filename
> > transitions in the binary policy. The internal structures have already
> > been converted to this new representation; this patch just implements
> > reading/writing an equivalent representation from/to the binary policy.
> >
> > This new format reduces the size of Fedora policy from 7.6 MB to only
> > 3.3 MB (with policy optimization enabled in both cases). With the
> > unconfined module disabled, the size is reduced from 3.3 MB to 2.4 MB.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
>
> Haven't looked at the code yet, but something is wrong with the handling
> when it needs to dowgrade to an older policy version for a kernel that
> doesn't yet support this new version:
>
> $ sudo semodule -B
> libsepol.mls_read_range_helper: range overflow
> libsepol.context_read_and_validate: error reading MLS range of context
> libsepol.policydb_to_image: new policy image is invalid
> libsepol.policydb_to_image: could not create policy image
> SELinux:  Could not downgrade policy file
> /etc/selinux/targeted/policy/policy.33, searching for an older version.

Hm, haven't tried that... I reproduced it on my end and I believe I
have found the bug - filename_trans_read_one_new() is counting
p->filename_trans_count in a completely wrong way. It needs to add up
the cardinalities of all stype bitmaps, not just count the hashtab
entries...

I'll post a v2 tomorrow, in the meantime you can test with this patch on top:
https://github.com/WOnder93/selinux/commit/738263d5be83323da7b4008e37140ec7ef99db8d.patch

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

