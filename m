Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EA1C6377D
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 07:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC1560FF4
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 07:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhGVGaU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51952 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230367AbhGVGaU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Jul 2021 02:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626937855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6GDEyDpumTN5IUPI+gElXinoItS3oXeAjDccXnHKb+I=;
        b=Sd4ZcP7tNbqPIHSX98dxvGXM+kn6vzz+qgsm8WEFuJA5+RM06q8fFo6xPlmvH+j38037Z2
        G6WJzphs0GIbvjGv5j20eWPIQOzyeDCbb2K7Gd8RpCF6OLGzfChnnqog6vlSAY2ZMhUsIz
        N2p//wdNBwIeApv+Lf9teAIQAOLkvgM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-X0AUyQg-MAus0oy2nM1DIQ-1; Thu, 22 Jul 2021 03:10:54 -0400
X-MC-Unique: X0AUyQg-MAus0oy2nM1DIQ-1
Received: by mail-wr1-f69.google.com with SMTP id t8-20020a05600001c8b029013e2027cf9aso2068563wrx.9
        for <selinux@vger.kernel.org>; Thu, 22 Jul 2021 00:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6GDEyDpumTN5IUPI+gElXinoItS3oXeAjDccXnHKb+I=;
        b=XvwAEzaaq9lt1Cd4Ioh9TfE/4DEmZid0kIcuZd4z6NLHZl6kNBZkyXXmvVwaWGDm+j
         VQrWQTn9UECp9SUwdXmQaOAZAuOe8PWLbTp97qwF3F8cvda6C4Fc1J9O2+YkZjtR5hob
         k9S8OhxjtO3nnnLhaMeQXPiVpqTBuknVQQagJ2D3IVtGJr935143vRrvvBW1qrQaA3eL
         lfPdkbtlPoNjBEzu/Wh4rmLZsdP5tBlDLg6P0umCxa1/A2qKPc5lpBUzlg0rc7f/jFmH
         2FaCLvejEbYbojBPwM/lDKy+tS1K0zIL6fSNBFuUXHLi2W/N/+W+Nnv/zJZYGS8RAA6p
         CaUA==
X-Gm-Message-State: AOAM532f8RwEyDW4/Tb6NVKhLrq+a19mS9XYVOoQ7xzbrGc2YacFN5wp
        wz4UjXxcz8cW2T/+PTGT2tID6MEckqhpJRBCXaUxb1cgegFAJ9fiOVPdCnQ3EK5hA70w+S9w33E
        1jygvoh1MGeNRo8+spA==
X-Received: by 2002:a7b:cbda:: with SMTP id n26mr40603523wmi.179.1626937853063;
        Thu, 22 Jul 2021 00:10:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfG/aAXoKgHTRexPzO6AsTiTtPq6UsftoDAUnhc4K7JdYB/4vWvNVTHFlY/ZtfBDrgE5AXDg==
X-Received: by 2002:a7b:cbda:: with SMTP id n26mr40603506wmi.179.1626937852869;
        Thu, 22 Jul 2021 00:10:52 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id 6sm1861061wmi.3.2021.07.22.00.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 00:10:52 -0700 (PDT)
Message-ID: <e6200ddd38510216f9f32051ce1acff21fc9c6d0.camel@redhat.com>
Subject: Re: [PATCH RFC 0/9] sk_buff: optimize layout for GRO
From:   Paolo Abeni <pabeni@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Date:   Thu, 22 Jul 2021 09:10:51 +0200
In-Reply-To: <1252ad17-3460-5e6a-8f0d-05d91a1a7b96@schaufler-ca.com>
References: <cover.1626879395.git.pabeni@redhat.com>
         <1252ad17-3460-5e6a-8f0d-05d91a1a7b96@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

On Wed, 2021-07-21 at 11:15 -0700, Casey Schaufler wrote:
> On 7/21/2021 9:44 AM, Paolo Abeni wrote:
> > This is a very early draft - in a different world would be
> > replaced by hallway discussion at in-person conference - aimed at
> > outlining some ideas and collect feedback on the overall outlook.
> > There are still bugs to be fixed, more test and benchmark need, etc.
> > 
> > There are 3 main goals:
> > - [try to] avoid the overhead for uncommon conditions at GRO time
> >   (patches 1-4)
> > - enable backpressure for the veth GRO path (patches 5-6)
> > - reduce the number of cacheline used by the sk_buff lifecycle
> >   from 4 to 3, at least in some common scenarios (patches 1,7-9).
> >   The idea here is avoid the initialization of some fields and
> >   control their validity with a bitmask, as presented by at least
> >   Florian and Jesper in the past.
> 
> If I understand correctly, you're creating an optimized case
> which excludes ct, secmark, vlan and UDP tunnel. Is this correct,
> and if so, why those particular fields? What impact will this have
> in the non-optimal (with any of the excluded fields) case?

Thank you for the feedback.

There are 2 different relevant points:

- the GRO stage.
  packets carring any of CT, dst, sk or skb_ext will do 2 additional
conditionals per gro_receive WRT the current code. My understanding is
that having any of such field set at GRO receive time is quite
exceptional for real nic. All others packet will do 4 or 5 less
conditionals, and will traverse a little less code.

- sk_buff lifecycle
  * packets carrying vlan and UDP will not see any differences: sk_buff
lifecycle will stil use 4 cachelines, as currently does, and no
additional conditional is introduced.
  * packets carring nfct or secmark will see an additional conditional
every time such field is accessed. The number of cacheline used will
still be 4, as in the current code. My understanding is that when such
access happens, there is already a relevant amount of "additional" code
to be executed, the conditional overhead should not be measurable.

Cheers,

Paolo

