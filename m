Return-Path: <SRS0=TAN+=7Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD98C433E0
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 15:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CEB4206E6
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 15:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="jeZwLUh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgFCPvS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:51:18 -0400
Received: from mailomta21-sa.btinternet.com ([213.120.69.27]:52627 "EHLO
        sa-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726046AbgFCPvR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jun 2020 11:51:17 -0400
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-046.btinternet.com with ESMTP
          id <20200603155113.XXYO1271.sa-prd-fep-046.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Wed, 3 Jun 2020 16:51:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1591199473; 
        bh=LQnDomIeKK2XkL9pOdfiHcolqdMDUqcaKDxl3rLAICE=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=jeZwLUh8m2oZ8bULoMGUu66NidC2sACkCwrslIUti/sIowJKa/v6HOAcKtgwF6I1LKZq/Y1FF/bhKsORkOugcLQV9mQzFcasfDMqmcVNpvZ2fdocqQdpi24WVNAnD5chYqyqiyVBFC/lkDI/uZcqslqmIIgD97vi2Nc2bDQQzlMimF1Hex4TsHYOuvA8O1MQ71Uj2iZLf7RfQftjPpZp9Cr2gvjT2J0833iHRiNh5tSJ7p7wEl8lihdgWQwHzAds42pn64PmklJH60p2o/DqnWiOnBQz4mxNy2O21nteEMMxh5gMYeuKd9MgZq/oNx+fQckyj8m4S+Q7U3Hn+rufmQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.190.32.74]
X-OWM-Source-IP: 86.190.32.74 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrudefledgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeekgeeftdffkeeikedugedvkeejheeiffevveelgedtleduteevudelffdugffgieenucfkphepkeeirdduledtrdefvddrjeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudeltddrfedvrdejgedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.190.32.74) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A27DB140EB273; Wed, 3 Jun 2020 16:51:13 +0100
Message-ID: <e0db87ed5d1cfa9760877df3c553ab81ccbe06f3.camel@btinternet.com>
Subject: Re: [PATCH] selinux-testsuite: Review and rework sctp tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Date:   Wed, 03 Jun 2020 16:51:12 +0100
In-Reply-To: <CAFqZXNvLJudp0hydL5j6y1LmtcN9kNmLQ8f7eAC5+867tFYyQw@mail.gmail.com>
References: <20200603110048.19293-1-richard_c_haines@btinternet.com>
         <CAFqZXNvLJudp0hydL5j6y1LmtcN9kNmLQ8f7eAC5+867tFYyQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2020-06-03 at 16:50 +0200, Ondrej Mosnacek wrote:
> Hi Richard,
> 
> On Wed, Jun 3, 2020 at 1:01 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > The main changes have been to sctp_asconf_params_client.c and
> > sctp_asconf_params_server.c to make them more reliable for running
> > the
> > client and server on different systems.
> > 
> > Updated common code in sctp_common.c
> > 
> > Removed obsolete code that was used to test permissions that never
> > made it
> > to the final commit.
> > 
> > Also reviewed and updated tests to check policy rules for denying
> > access to all possible net/sctp kernel hooks as described in the
> > kernel
> > Documentation/security/SCTP.rst
> 
> This looks promising, but would it be possible to split the patch
> into
> a series of smaller changes? It is hard to review such a large patch
> that changes a lot of things at once...

I'll split into three patches 1) Remove obsolete 2) Update asconf/test
3) Update remaining tests

> 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> >  policy/test_sctp.te                    |  98 ++++--
> >  tests/sctp/.gitignore                  |   3 -
> >  tests/sctp/Makefile                    |   2 +-
> >  tests/sctp/sctp_asconf_params_client.c | 320 ++++++++-----------
> >  tests/sctp/sctp_asconf_params_server.c | 269 +++++++++-------
> >  tests/sctp/sctp_client.c               |   4 +-
> >  tests/sctp/sctp_common.c               | 189 ++++++++++-
> >  tests/sctp/sctp_common.h               |  12 +-
> >  tests/sctp/sctp_connectx.c             |  33 +-
> >  tests/sctp/sctp_peeloff_server.c       |  42 +--
> >  tests/sctp/sctp_server.c               |   4 +-
> >  tests/sctp/sctp_set_params.c           | 205 ------------
> >  tests/sctp/sctp_set_peer_addr.c        | 415 -------------------
> > ------
> >  tests/sctp/sctp_set_pri_addr.c         | 135 --------
> >  tests/sctp/test                        |  95 +++++-
> >  15 files changed, 688 insertions(+), 1138 deletions(-)
> >  delete mode 100644 tests/sctp/sctp_set_params.c
> >  delete mode 100644 tests/sctp/sctp_set_peer_addr.c
> >  delete mode 100644 tests/sctp/sctp_set_pri_addr.c
> > 
> > diff --git a/policy/test_sctp.te b/policy/test_sctp.te
> > index 3b16db1..380e442 100644
> > --- a/policy/test_sctp.te
> > +++ b/policy/test_sctp.te
> > @@ -60,6 +60,12 @@ corenet_sctp_bind_all_nodes(test_sctp_server_t)
> >  corenet_inout_generic_node(test_sctp_server_t)
> >  corenet_inout_generic_if(test_sctp_server_t)
> > 
> > +# Don't allow ports < 1024
> > +# neverallow test_sctp_server_t self:capability net_bind_service
> > +# neverallow test_sctp_server_t reserved_port_t:sctp_socket
> > name_bind;
> > +dontaudit test_sctp_server_t self:netlink_route_socket { create
> > getattr bind };
> > +dontaudit test_sctp_server_t self:udp_socket { getattr connect };
> 
> Could you clarify what these dontaudit rules are for?
> 
> That's the only thing that caught my eye after a quick glance. I'm
> still hoping you will be able to split up the patch into more
> digestible chunks, so I'm not going to look at it deeper just yet. If
> that proves impossible or too difficult, I'll try to review the patch
> as-is, but please understand that it may take a long time then...
> 
> Thanks,
> 

