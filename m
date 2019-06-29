Return-Path: <SRS0=45Fk=U4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD709C5B57B
	for <selinux@archiver.kernel.org>; Sat, 29 Jun 2019 23:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9D620828
	for <selinux@archiver.kernel.org>; Sat, 29 Jun 2019 23:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561851707;
	bh=rsrWCT1gWBXhwYwjav4RT5F499BOt9LR6uAiC2FarEk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y0itfyXI8BUvm6qrdns+h0slQFevpcpPkJkVDO7gXzs1PxbZ6nNCw+rR1osl+tSdp
	 H66v/+cOnlGqkNZvKQb+PoayEXr79YORbkwpLAB/kevEJUkiVtX5pfes3Ago0xMPol
	 V2w/HyUy+xn490Sym/9fq0pNaUxZN2gSyt5jOcm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfF2Xlq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 29 Jun 2019 19:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfF2Xlq (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 29 Jun 2019 19:41:46 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DACB217D6
        for <selinux@vger.kernel.org>; Sat, 29 Jun 2019 23:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561851705;
        bh=rsrWCT1gWBXhwYwjav4RT5F499BOt9LR6uAiC2FarEk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=npBcNcLIiE2uXDRTErVbNMNksgqTwoR5rYaW4P9G33NeypGMd2H6GJYto2o9Nt76c
         HWPzVQVHXQy5LEr99/A8SMCWRQa7cxO09VFuwvdHfeTtRlRplPxo/QM1p66DwzCoZN
         eVpy5pf4JKohZYwkjeHyTqnCCa1sQj5ybejCQUJ4=
Received: by mail-wm1-f42.google.com with SMTP id g135so12362051wme.4
        for <selinux@vger.kernel.org>; Sat, 29 Jun 2019 16:41:45 -0700 (PDT)
X-Gm-Message-State: APjAAAVlt8q88iPmL1+V19JDqS1FrcesPbHpnDJ6sVLcTSTto8YlE61x
        1BbaG2ZLwlz6HWi1P0jVRAS1F8wN439sKZG46fMB6Q==
X-Google-Smtp-Source: APXvYqwdeBvakBA0L/3s2LRFItwvr/clOtF3C3J3lo2AUEE4bcCbWRIeob9VvzWqVWGgCZbPsWt/gloPdVy1TI6RLhM=
X-Received: by 2002:a7b:c450:: with SMTP id l16mr12338729wmi.0.1561851704154;
 Sat, 29 Jun 2019 16:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190619222401.14942-1-sean.j.christopherson@intel.com>
 <20190619222401.14942-11-sean.j.christopherson@intel.com> <960B34DE67B9E140824F1DCDEC400C0F6551877E@ORSMSX116.amr.corp.intel.com>
 <b36d6fd0-3135-e48d-ed84-d69853bd79f1@tycho.nsa.gov>
In-Reply-To: <b36d6fd0-3135-e48d-ed84-d69853bd79f1@tycho.nsa.gov>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 29 Jun 2019 16:41:32 -0700
X-Gmail-Original-Message-ID: <CALCETrWPzSaFUWi4q4Vq_0RrtNMFZAKkwKkya=p6cfB50x2tMQ@mail.gmail.com>
Message-ID: <CALCETrWPzSaFUWi4q4Vq_0RrtNMFZAKkwKkya=p6cfB50x2tMQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 10/12] security/selinux: Add enclave_load() implementation
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     "Xing, Cedric" <cedric.xing@intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 25, 2019 at 2:09 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 6/21/19 5:22 PM, Xing, Cedric wrote:
> >> From: Christopherson, Sean J
> >> Sent: Wednesday, June 19, 2019 3:24 PM
> >>
> >> Intended use of each permission:
> >>
> >>    - SGX_EXECDIRTY: dynamically load code within the enclave itself
> >>    - SGX_EXECUNMR: load unmeasured code into the enclave, e.g. Graphene
> >
> > Why does it matter whether a code page is measured or not?
>
> It won't be incorporated into an attestation?
>

Also, if there is, in parallel, a policy that limits the set of
enclave SIGSTRUCTs that are accepted, requiring all code be measured
makes it harder to subvert by writing incompetent or maliciously
incompetent enclaves.
