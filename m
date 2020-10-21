Return-Path: <SRS0=8FG4=D4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EADC4363A
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 10:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE2A921707
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 10:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="taQ6rCrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439246AbgJUK7V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Oct 2020 06:59:21 -0400
Received: from mailomta8-sa.btinternet.com ([213.120.69.14]:14003 "EHLO
        sa-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439239AbgJUK7V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Oct 2020 06:59:21 -0400
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20201021105918.FLVC4250.sa-prd-fep-047.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Wed, 21 Oct 2020 11:59:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1603277958; 
        bh=DvF9eWRfBWQh+BDZMPR1APxC+vUC98SZjSJBmAvcyHA=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=taQ6rCrnZQc4k3jV/FS5G6Fyu6lu9WCP1DhPV2McLWXbrUSqg4PX3FrCrNukY08XHPDEkYKFQk8yRfso/Lgk7My1BAzKr7iaHV7YlSMDcPs37x7zJ2GYMoHwRgzy+2BBmB0qCMdglPegiWvK3xWl4jQyzhcaeD2x7hkZCBORF2xttSncfHrWX8QyQqLptEatJ/RPePkJMu3CYUDziHu9DMbC11E3RNy7AyvGkHCyJQIGrxDUbyEYfhEsXUIqXizPYVqxoG3EjpZCJnWwa3buHNG6RcwZS9+v/1noqeNne0RdCKIDjtWMj6bB6iN9NI2OD8mBkzGqnN/BC3lsLvFxgQ==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.183.71.117]
X-OWM-Source-IP: 86.183.71.117 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrjeehgdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepkeegfedtffekieekudegvdekjeehieffveevleegtdeludetveduleffudfggfeinecukfhppeekiedrudekfedrjedurdduudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudekfedrjedurdduudejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.183.71.117) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B6611713C670; Wed, 21 Oct 2020 11:59:18 +0100
Message-ID: <904b91b20152f3ca54569f57fa118552eda1c080.camel@btinternet.com>
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Update SCTP asconf
 client/server
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Date:   Wed, 21 Oct 2020 11:59:10 +0100
In-Reply-To: <CAFqZXNsRzKEKeJmRj+tPNb0PQ7U3+gFPV-raOC7w6hEpXScL=g@mail.gmail.com>
References: <20200922085902.18315-1-richard_c_haines@btinternet.com>
         <CAFqZXNu0KqmZcTTZHOYbz-6tFbSU5Ss=-Y1JUHsmHMEU6jmb-A@mail.gmail.com>
         <3fd9d2c2603b156dacf9c5f5c3c4926dd870fd27.camel@btinternet.com>
         <CAFqZXNveK0C98H8nhYs4_za=ydMX6jtcJ++87-1XUDpO68ygwQ@mail.gmail.com>
         <680d1208ca13571d642824dffd7adbc4d83915d6.camel@btinternet.com>
         <CAFqZXNspQBJeM1v+aExWTc4Hk2+MZ8oFaLCUWANOusboSho2Dg@mail.gmail.com>
         <d257ed0dcdce297d1aa026773f34d27bc3d6dfba.camel@btinternet.com>
         <CAFqZXNvSPvhHtKsa7W9HwC66Bvg2NH3tfGyow3QzZJ0C3RJEpg@mail.gmail.com>
         <0697d164d1838dac05aee2b482c76caf5f5d025f.camel@btinternet.com>
         <1f11e56714519b18f25539e88fc227868a098c03.camel@btinternet.com>
         <CAFqZXNsRzKEKeJmRj+tPNb0PQ7U3+gFPV-raOC7w6hEpXScL=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2020-10-20 at 13:55 +0200, Ondrej Mosnacek wrote:
> On Fri, Oct 16, 2020 at 3:02 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > On Thu, 2020-10-15 at 18:04 +0100, Richard Haines wrote:
> > > On Thu, 2020-10-15 at 16:12 +0200, Ondrej Mosnacek wrote:
> > > > On Thu, Oct 15, 2020 at 3:49 PM Richard Haines
> > > > <richard_c_haines@btinternet.com> wrote:
> > > > > On Thu, 2020-10-15 at 12:28 +0200, Ondrej Mosnacek wrote:
> > > > <snip>
> > > > > Just a thought - have you tried running the server in one
> > > > > terminal
> > > > > session and the client in another (I've plugged in your
> > > > > Fedora 32
> > > > > addresses):
> > > > > 
> > > > > cd ...tests/sctp
> > > > > echo 1 > /proc/sys/net/sctp/addip_enable
> > > > > echo 1 > /proc/sys/net/sctp/addip_noauth_enable
> > > > > runcon -t sctp_asconf_params_server_t
> > > > > ./sctp_asconf_params_server
> > > > > 10.0.138.59 10.123.123.123 1035
> > > > > 
> > > > > cd ...tests/sctp
> > > > > runcon -t sctp_asconf_deny_param_add_client_t
> > > > > ./sctp_asconf_params_client 10.0.138.59 1035
> > > > 
> > > > Interesting... I just tried it a couple times and it's not
> > > > behaving
> > > > consistently - the first time I got "SCTP_PRIMARY_ADDR:
> > > > Permission
> > > > denied", then 'Dynamic Address Reconfiguration' twice in a row,
> > > > then
> > > > 7
> > > > times  "SCTP_PRIMARY_ADDR: Permission denied", then 'Dynamic
> > > > Address
> > > > Reconfiguration' 5 times. and then again "SCTP_PRIMARY_ADDR:
> > > > Permission denied".
> > > > 
> > > > I tried (manually) different delays between starting the server
> > > > and
> > > > starting the client, but there didn't seem to be a pattern.
> > > > 
> > > 
> > > I wonder if this test is flaky. A bit of history:
> > > When I first produced the SCTP patches I had different
> > > permissions
> > > for
> > > SCTP_PARAM_SET_PRIMARY, SCTP_PARAM_ADD_IP etc. so that I could
> > > detect
> > > these denials with allow 'self' rules. However the maintainers
> > > wanted
> > > to keep things simple with just connect or bind permissions. This
> > > made
> > > it a bit more difficult to test this case. As it so happened
> > > (until
> > > now
> > > of course), the two LSM calls for SCTP_PARAM_SET_PRIMARY and
> > > SCTP_PARAM_ADD_IP in sm_make_chunk.c triggered the following
> > > rule:
> > > 
> > > allow sctp_asconf_params_server_t
> > > sctp_asconf_deny_param_add_client_t:sctp_socket connect;
> > > 
> > > therefore by not allowing this rule I could detect (using the
> > > tshark
> > > trace output "Client returns ASCONF_ACK's with 'Request refused -
> > > no
> > > authorization'") to prove this test case.
> > > 
> > > If this boils down to a timing problem, then the test needs to be
> > > removed as I can't test this scenario, because the client needs
> > > the
> > > connect permission to be able to connect to the server in the
> > > first
> > > place.
> > > 
> > 
> > This test does have timimg issues. I put the three asconf tests in
> > a
> > loop of 200 iterations. Sometimes all would pass, but other times
> > the
> > third test would fail with the error.
> > 
> > I guess there are two options: Revert the patch, or remove the
> > offending test. Any views !!!
> 
> And do you think that the timing issue can be fixed by better
> synchronizing the client and server programs or is it inherently
> unavoidable? If you think it could be fixed in some way (even if
> non-trivial), then I'd prefer to just comment out the test with a
> note
> to revisit it in the future (leaving the code in place for now). I'll
> try to look into it at some point, unless you're faster than me :)

I do have a possible new test for the 3rd asconf test that I've run
through 5000 interations without error, whereas the current one would
fail between 100 to 500 interations (I changed the 'tm.tv_sec = 3;'
client timer to 'tm.tv_usec = 50000;' so it ran faster). I hope to send
updates late next week. Note that I've had no problems running the 1st
and 2nd asconf tests in these loops.

> 

