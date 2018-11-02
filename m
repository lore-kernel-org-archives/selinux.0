Return-Path: <SRS0=O7VE=NN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB64C32789
	for <selinux@archiver.kernel.org>; Fri,  2 Nov 2018 16:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9BB2081B
	for <selinux@archiver.kernel.org>; Fri,  2 Nov 2018 16:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9BB2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeKCBZM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:25:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42705 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeKCBZM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Nov 2018 21:25:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id j3so2147388otl.9
        for <selinux@vger.kernel.org>; Fri, 02 Nov 2018 09:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSFDfVXZwf2G02cV4JcO7OiVjwSurDV44haWtrqBBQk=;
        b=W9JwjI6eP3rj6RqmSIvdzMQWVBFFml0LQvlwh3YQgJ4U+JP+LOcTVDeztqpJNy2mMG
         tReINzEc4dS3N6LTHNeqk+swtZJksJ2S+uJrapkuojzaIST9OVlycVa/SHPi4PT4/Yu5
         2V/Skpk6wBoZAxG4o4ZRQnErIrWxDF7+ooaTMVPtlovYki/UQ92CZDYPAmloAnTrFhjI
         vq0bhcGySkf/mharnq/5qhyl5dj9fsPT0cZ9QitDBTBwoJcGpsNz1MC67Bd/yi+P3rzR
         9OM6WBhlDJFeoKThxGLI8FmE4pwbYG33S0yOsVUP+3xh6Xw9cSBpTZeDa2UhHAD09R5h
         4c6w==
X-Gm-Message-State: AGRZ1gJvOG8cFZ98mmrvrzDMNG/ZVLklR8WI+W2wJUNMSxzwQFnitpx2
        qX3YpWKRuQWzKQIHrRlIeJSYuVkjRqT1rVlv1TWvrA==
X-Google-Smtp-Source: AJdET5cm7Al+sT5sBitA/G1fH0/UrK5ekvIaKIx4oZla6QeACKJiLpIWoPwVPz3YDEAdcB30gR1S/4+mX0Scaujm4bo=
X-Received: by 2002:a9d:5714:: with SMTP id p20mr6948348oth.250.1541175453636;
 Fri, 02 Nov 2018 09:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181031122718.18735-1-omosnace@redhat.com> <20181031122718.18735-3-omosnace@redhat.com>
 <974d4ce4-6ddc-bc4b-ecf0-8b8e7a5d4083@tycho.nsa.gov> <6e2f9128-e191-ebb3-0e87-74bfccb0767f@tycho.nsa.gov>
In-Reply-To: <6e2f9128-e191-ebb3-0e87-74bfccb0767f@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 2 Nov 2018 17:17:22 +0100
Message-ID: <CAFqZXNt96BwGmopxUaQWb6Mps-3BJp6oPj5iSS1cgqXY9m1=Qw@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: fix ENOMEM errors during policy reload
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 1, 2018 at 2:15 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/31/2018 04:31 PM, Stephen Smalley wrote:
> > We'd like to
> > replace the policy rwlock with RCU at some point; there is a very old
> > patch that tried to do that once before, which eliminated the policy
> > write lock altogether (policy switch became a single pointer update),
> > but no one has yet taken that back up.
>
> For reference, here is that old patch that tried converting the policy
> rwlock to RCU.  It applies on Linux v2.6.9 (yes, it is that old).  There
> was a more recent effort by Peter Enderborg to convert to RCU to deal
> with preempt disable holding, but I had some concerns with the approach
> to booleans, see [1]
>
> Aside from the locking aspects, the other reason I mention it is that I
> am unsure of the implications of your model of converting within the
> sidtab for a future migration to RCU, since that doesn't seem amenable
> to a read-copy-update sequence.

I would definitely like to experiment with the RCU conversion at some
point. I agree that the new model will probably need to be re-thought
again for that, but I don't think it would make it more difficult to
do everything right than it would be now.

I have another idea how to rewrite the sidtab that should be more
RCU-conversion-ready, so maybe I'll even drop this model after all...

>
> [1]
> https://lore.kernel.org/selinux/20180530141104.28569-1-peter.enderborg@sony.com/

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
