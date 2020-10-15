Return-Path: <SRS0=0RAF=DW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666C2C433E7
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF51E22210
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="nWMJlIbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390022AbgJOREi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:04:38 -0400
Received: from mailomta7-sa.btinternet.com ([213.120.69.13]:16668 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389893AbgJOREi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Oct 2020 13:04:38 -0400
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20201015170435.EIRO3440.sa-prd-fep-044.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 15 Oct 2020 18:04:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1602781475; 
        bh=urAeFBn2iFxh7Tr1kXQVU+4pg69ciKmBx+mGJ30b1I8=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=nWMJlIbl8cSdy5ub4YOwmmQ6ZA2z+aoOAn0k3529v0GRo1tXixU6hMh9hA1GNx/+H+NAb8I630F2iAXNUaycIyQ/JwUCIzWpMVl0tLKmcKHtS70Cq5DNbnjXuTVBWAMI0IOou8QWzzPB6wQ6QPzuwRgs73Gq4PJx30skT2txw3OZO5uiW/+ozWD/N70KcyfeCTYX9KeP7bMNLl6XuNzvVivyLd40Wgn0mSNmZPGEF1lExsRtAyJEq1/VN+yrxYaUYa3iOkm4HjihMejPsmfsxrElLwvFBup1mOcVGj3KCkPqZRztsA59fwetxiMfMj2SGu6uE1LAePrWLbIOD1I1FQ==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [213.122.112.45]
X-OWM-Source-IP: 213.122.112.45 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrieefgddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeekgeeftdffkeeikedugedvkeejheeiffevveelgedtleduteevudelffdugffgieenucfkphepvddufedruddvvddrudduvddrgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedvudefrdduvddvrdduuddvrdeghedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (213.122.112.45) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED99EC91635DF43; Thu, 15 Oct 2020 18:04:35 +0100
Message-ID: <0697d164d1838dac05aee2b482c76caf5f5d025f.camel@btinternet.com>
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Update SCTP asconf
 client/server
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Date:   Thu, 15 Oct 2020 18:04:34 +0100
In-Reply-To: <CAFqZXNvSPvhHtKsa7W9HwC66Bvg2NH3tfGyow3QzZJ0C3RJEpg@mail.gmail.com>
References: <20200922085902.18315-1-richard_c_haines@btinternet.com>
         <CAFqZXNu0KqmZcTTZHOYbz-6tFbSU5Ss=-Y1JUHsmHMEU6jmb-A@mail.gmail.com>
         <3fd9d2c2603b156dacf9c5f5c3c4926dd870fd27.camel@btinternet.com>
         <CAFqZXNveK0C98H8nhYs4_za=ydMX6jtcJ++87-1XUDpO68ygwQ@mail.gmail.com>
         <680d1208ca13571d642824dffd7adbc4d83915d6.camel@btinternet.com>
         <CAFqZXNspQBJeM1v+aExWTc4Hk2+MZ8oFaLCUWANOusboSho2Dg@mail.gmail.com>
         <d257ed0dcdce297d1aa026773f34d27bc3d6dfba.camel@btinternet.com>
         <CAFqZXNvSPvhHtKsa7W9HwC66Bvg2NH3tfGyow3QzZJ0C3RJEpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-10-15 at 16:12 +0200, Ondrej Mosnacek wrote:
> On Thu, Oct 15, 2020 at 3:49 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > On Thu, 2020-10-15 at 12:28 +0200, Ondrej Mosnacek wrote:
> <snip>
> > Just a thought - have you tried running the server in one terminal
> > session and the client in another (I've plugged in your Fedora 32
> > addresses):
> > 
> > cd ...tests/sctp
> > echo 1 > /proc/sys/net/sctp/addip_enable
> > echo 1 > /proc/sys/net/sctp/addip_noauth_enable
> > runcon -t sctp_asconf_params_server_t ./sctp_asconf_params_server
> > 10.0.138.59 10.123.123.123 1035
> > 
> > cd ...tests/sctp
> > runcon -t sctp_asconf_deny_param_add_client_t
> > ./sctp_asconf_params_client 10.0.138.59 1035
> 
> Interesting... I just tried it a couple times and it's not behaving
> consistently - the first time I got "SCTP_PRIMARY_ADDR: Permission
> denied", then 'Dynamic Address Reconfiguration' twice in a row, then
> 7
> times  "SCTP_PRIMARY_ADDR: Permission denied", then 'Dynamic Address
> Reconfiguration' 5 times. and then again "SCTP_PRIMARY_ADDR:
> Permission denied".
> 
> I tried (manually) different delays between starting the server and
> starting the client, but there didn't seem to be a pattern.
> 

I wonder if this test is flaky. A bit of history:
When I first produced the SCTP patches I had different permissions for
SCTP_PARAM_SET_PRIMARY, SCTP_PARAM_ADD_IP etc. so that I could detect
these denials with allow 'self' rules. However the maintainers wanted
to keep things simple with just connect or bind permissions. This made
it a bit more difficult to test this case. As it so happened (until now
of course), the two LSM calls for SCTP_PARAM_SET_PRIMARY and
SCTP_PARAM_ADD_IP in sm_make_chunk.c triggered the following rule:

allow sctp_asconf_params_server_t
sctp_asconf_deny_param_add_client_t:sctp_socket connect;

therefore by not allowing this rule I could detect (using the tshark
trace output "Client returns ASCONF_ACK's with 'Request refused - no
authorization'") to prove this test case.

If this boils down to a timing problem, then the test needs to be
removed as I can't test this scenario, because the client needs the
connect permission to be able to connect to the server in the first
place.


