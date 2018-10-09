Return-Path: <SRS0=wI+O=MV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD8FC00449
	for <selinux@archiver.kernel.org>; Tue,  9 Oct 2018 02:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075BA213A2
	for <selinux@archiver.kernel.org>; Tue,  9 Oct 2018 02:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLqF2PFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075BA213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeJIJwB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Oct 2018 05:52:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45854 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbeJIJwB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Oct 2018 05:52:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id e10-v6so48772qtq.12
        for <selinux@vger.kernel.org>; Mon, 08 Oct 2018 19:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YEPQqaILBrMU2joPfWLEhAJQnEA1k5y0mRUyDItfiKE=;
        b=fLqF2PFkQRksuuImrUvrF0u4QqejO6LZZUqz42utPYy1h5t8+rQktiYiH5/tykPOMv
         /TC8pnXbE/nEvcBmSjK5vUGG/+Uv58e0EdfQiK4tVDYu2Ow+2sAxhv36KulDdtImRHCY
         hP3El/ZFoONyrknIooH7KXdkGSaiJfgXTS57+jaB3LZVDpdmp6cm8ciaev9TUjUVimkH
         x8d3rXcFOhVrCjVZVBtlKlFy3ZOD6tfBH4bMqf6FBymUG+3GgcQujaoDSh1E8NQgLImG
         E2hC2U2Pl4+FKuKvyO1CtyZmoDiMAtY7FWUsPuhTnYFFtZoRYavP9OSftWMyoJ23ntJp
         2EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YEPQqaILBrMU2joPfWLEhAJQnEA1k5y0mRUyDItfiKE=;
        b=bwMEtD78sBiJVKbKIZ9fq2ezQvR0jTd2PEhJspJC3diSSHzdPUnVgYntrhhvUyTdav
         eOVHCq8f7N1KjEQ5kNLoXDXp/1Aw0+ez3Dx2pnwUy2JD1IMjowvSvbX1HGdrAr4rKRh1
         knV1/YKfGxkn/h6AF6Sp6TuDaR+h9Du8S8/T19nDL5t95B9K0yAnqnG+EfCAqxHcjsJL
         hPboqrQqsAqqaHr0xBipUBhOyNhQZ5fQDpx2wojjIx7xoZUPYrf2uXkiBIu7WflmR+qf
         FjRUtK7ZA5bz0bmT9whfYobfIDdVovk5rUecU29qewObKyLZZF2j3g6QuSVoG0Zdl078
         YalA==
X-Gm-Message-State: ABuFfogVedpnUlTjERoT2GjsCiR+OS2QyXl3t0ji+ms7ip+YYykNZZBT
        xsNypVz1Wl9kxUuRc0xy8Wo=
X-Google-Smtp-Source: ACcGV62rhECFT70OhggYgXZ8SwGJ1mlOMTtJv2ofXOZGqz6H77yROimfXcPKepfLbtHGtfcGgM0dKg==
X-Received: by 2002:ac8:2278:: with SMTP id p53-v6mr20446075qtp.200.1539052641058;
        Mon, 08 Oct 2018 19:37:21 -0700 (PDT)
Received: from localhost.localdomain (pool-100-15-67-191.washdc.fios.verizon.net. [100.15.67.191])
        by smtp.gmail.com with ESMTPSA id y138-v6sm9975476qka.36.2018.10.08.19.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 19:37:20 -0700 (PDT)
Date:   Mon, 8 Oct 2018 22:37:18 -0400
From:   Chad Hanson <dahchanson@gmail.com>
To:     Chris PeBenito <pebenito@ieee.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, Joe Nall <joe@nall.com>,
        selinux@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>
Subject: Re: MLS dominance check behavior on el7
Message-ID: <20181009023718.GD2402@localhost.localdomain>
References: <41fbbd99-00ef-3953-1049-acf975ae6ffa@tycho.nsa.gov>
 <CAFPpqQHXmvCNLwkW3xmYX9PWFwwmfc7wD2kOz-KKEVip-BFLyA@mail.gmail.com>
 <CAFPpqQGyUWsXwmfAybHKWhuQ6jytaNn_ZO-BfeqxNTQZDb+uvg@mail.gmail.com>
 <4e7d4090-e271-b904-c5bb-24f69304625d@tycho.nsa.gov>
 <85bb9bec-2bda-34fa-1f7d-256470c4f38c@tycho.nsa.gov>
 <2E8FB4B5-598A-4741-9AC6-70C9995A48F9@nall.com>
 <052415f8-589e-909f-ac00-8e67c5c23e0d@tycho.nsa.gov>
 <62b6ac25-6528-79d4-a38d-7f75fe870a47@ieee.org>
 <6e21676a-249d-8b05-dd9f-09a3671f46f7@tycho.nsa.gov>
 <308ffdc6-6d82-cdd0-4863-c08432b8b8de@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <308ffdc6-6d82-cdd0-4863-c08432b8b8de@ieee.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 05, 2018 at 04:05:13PM -0400, Chris PeBenito wrote:
> On 10/04/2018 05:01 PM, Stephen Smalley wrote:
> >On 09/30/2018 10:43 AM, Chris PeBenito wrote:
> >>On 09/11/2018 04:20 PM, Stephen Smalley wrote:
> >>>On 09/11/2018 03:04 PM, Joe Nall wrote:
> >>>>>On Sep 11, 2018, at 1:29 PM, Stephen Smalley
> >>>>><sds@tycho.nsa.gov> On 09/11/2018 10:41 AM, Stephen
> >>>>>Smalley wrote:
> >>>>>>On 09/10/2018 06:30 PM, Ted Toth wrote:
> >>>>>BTW, I noticed there is another permission ("translate")
> >>>>>defined in the context class and its constraint is ((h1
> >>>>>dom h2) or (t1 == mlstranslate)).  I would have guessed
> >>>>>that it was intended as a front-end service check over
> >>>>>what processes could request context translations from
> >>>>>mcstrans or what contexts they could translate, but I
> >>>>>don't see it being used in mcstrans anywhere.  Is this a
> >>>>>legacy thing from early setransd/mcstransd days?  There is
> >>>>>a TODO comment in mcstrans process_request() that suggests
> >>>>>there was an intent to perform a dominance check between
> >>>>>the requester context and the specified context, but
> >>>>>that's not implemented.  Appears to be allowed in current
> >>>>>policy for all domains to the setrans_t domain itself.
> >>>>
> >>>>I think 'translate' predates my mcstransd work and dates
> >>>>from the original TCS implementation. There is an argument
> >>>>to implement that constraint, but we've been operating
> >>>>without it for so long it does not seem worthwhile.
> >>>
> >>>Well, I guess we ought to either implement it or delete the
> >>>permission definition from refpolicy.
> >>
> >>I'm fine removing it.  It's just the translate permission that
> >>is unused, not the whole class, correct?
> >
> >Correct. Only caveat is that removing translate will change the
> >permission index of contains, which could break a running
> >mcstransd upon a policy reload (doesn't use selinux_check_access
> >or even the avc; won't flush the class/perm string mapping on a
> >reload automatically).
> 
> Good point.  I think I'll remove all the rules and constraints and then
> rename the permission to unused or unused_perm.  Then the indices
> will be stable, but it will be clear the perm is unused.

We are not using this permission anymore, so I concur in removing it as
well.

-Chad
