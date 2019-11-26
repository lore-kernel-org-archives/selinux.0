Return-Path: <SRS0=SqeD=ZS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA71FC432C3
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 15:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9470B2071E
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 15:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="e0nTafAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfKZP7Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:59:25 -0500
Received: from mailomta4-re.btinternet.com ([213.120.69.97]:65314 "EHLO
        re-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726101AbfKZP7Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Nov 2019 10:59:25 -0500
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20191126155921.ZNQS11959.re-prd-fep-043.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Tue, 26 Nov 2019 15:59:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1574783961; 
        bh=LE2rbkux3k1fzrIn5GHhuxfI3Ip1xKx8NilOBoyeBtQ=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=e0nTafAtNN5XpVFYdMeKrphoBh+7GOLZZqhsOCcV8tOC7n1DVHjpc0bp/31Ra9ZDJDCQd3zenkUL+nxTOOZXbzFOUjwo/20iQQSz22e9C1RneYDUx8PLii/slEqubsxSKlnZCiPiSG+XNfXzdIMarzvP8gKU9pL1wmmI1W8+D5Bel5nIvHckPs0iOo+7nOFvbh8SxsGe2+UTjgnzCYqy/rTq33yNc3nT95MxKzzNrDK7DbIxWM0w1qVIIrdpY4auiTdU1spT7VY5po5nu3yI6NyjilkHThLwZ9/c/JCORiRbCz/hXUWe83o8CTGAVNO355EhMIYT/Tf5VrrY/gXFHw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.169]
X-OWM-Source-IP: 86.134.6.169 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrudeifedgkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculddquddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdeirdduieelnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdeirdduieelpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.169) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DB07BDD062EB203; Tue, 26 Nov 2019 15:59:21 +0000
Message-ID: <1dd92a7d6bbc03048a92ee5e3f37e9e17c0089de.camel@btinternet.com>
Subject: Re: [PATCH testsuite v3] policy: use the
 kernel_request_load_module() interface
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
Date:   Tue, 26 Nov 2019 15:59:20 +0000
In-Reply-To: <CAFqZXNtaDV0d1riR2kc-ygW_bfUUE+r7y0vL_4+xJ97Ff7W_sA@mail.gmail.com>
References: <20191126120623.736870-1-omosnace@redhat.com>
         <c765adb1e61950cb0f2aea6cbb7d4b94797b2a31.camel@btinternet.com>
         <2723e1c7-7e17-b8fc-757d-4a126ded8354@tycho.nsa.gov>
         <CAFqZXNtaDV0d1riR2kc-ygW_bfUUE+r7y0vL_4+xJ97Ff7W_sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2019-11-26 at 16:02 +0100, Ondrej Mosnacek wrote:
> On Tue, Nov 26, 2019 at 3:54 PM Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On 11/26/19 9:51 AM, Richard Haines wrote:
> > > On Tue, 2019-11-26 at 13:06 +0100, Ondrej Mosnacek wrote:
> > > > ...instead of open-coding the rules. Also define a fallback to
> > > > allow
> > > > the
> > > > policy to build even if the interface is not defined.
> > > > 
> > > > Fixes: f5e5a0b8d005 ("selinux-testsuite: Add key_socket tests")
> > > > Cc: Richard Haines <richard_c_haines@btinternet.com>
> > > > Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > > 
> > > > Change in v3: use different approach as suggested by Stephen
> > > > Change in v2: update also tests/Makefile for consistency
> > > > 
> > > >   policy/test_key_socket.te | 8 ++++----
> > > >   policy/test_policy.if     | 6 ++++++
> > > >   2 files changed, 10 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/policy/test_key_socket.te
> > > > b/policy/test_key_socket.te
> > > > index cde426b..f1c1606 100644
> > > > --- a/policy/test_key_socket.te
> > > > +++ b/policy/test_key_socket.te
> > > > @@ -13,7 +13,7 @@ typeattribute test_key_sock_t keysockdomain;
> > > >   allow test_key_sock_t self:capability { net_admin };
> > > >   allow test_key_sock_t self:key_socket { create write read
> > > > setopt };
> > > >   # For CONFIG_NET_KEY=m
> > > > -allow test_key_sock_t kernel_t:system { module_request };
> > > > +kernel_request_load_module(test_key_sock_t)
> > > > 
> > > >   ################## Deny capability { net_admin }
> > > > ##########################
> > > >   #
> > > > @@ -29,7 +29,7 @@ typeattribute test_key_sock_no_net_admin_t
> > > > testdomain;
> > > >   typeattribute test_key_sock_no_net_admin_t keysockdomain;
> > > > 
> > > >   allow test_key_sock_no_net_admin_t self:key_socket { create
> > > > write
> > > > read setopt };
> > > > -allow test_key_sock_no_net_admin_t kernel_t:system {
> > > > module_request
> > > > };
> > > > +kernel_request_load_module(test_key_sock_t)
> > > 
> > > All the new entries have (test_key_sock_t) ??
> > > Anyway if you run the tests in the order they appear in 'test'
> > > script,
> > > then it just so happens that the module will be loaded for
> > > test_key_sock_t as it's first. I added the others just to cover
> > > the
> > > cases where I sometimes run out of sequence, so you could remove
> > > these
> > > if required.
> 
> *facepalm*
> 
> Yes, sorry, I messed up the copy-paste...
> 
> > Good catch!  Somehow I missed that.  Could probably just have a
> > single
> > kernel_request_load_module(keysockdomain) line?
> 
> There is one domain (test_key_sock_no_create_t) that doesn't have the
> rule, so probably not.

That is probably one I didn't test out of sequence.

I'm currently writing the TUN/TAP tests and had the same problem as
I've left the default Fedora CONFIG_TUN=m.
I've added 'kernel_request_load_module(tuntapdomain)' to the test
module that allows tests in any order (as I usually run rmmod just as a
check).

I'll leave it to you guys to decide what is finally best for you.

> 
> > > >   ####################### Deny key_socket { create }
> > > > ##########################
> > > >   type test_key_sock_no_create_t;
> > > > @@ -50,7 +50,7 @@ typeattribute test_key_sock_no_write_t
> > > > keysockdomain;
> > > > 
> > > >   allow test_key_sock_no_write_t self:capability { net_admin };
> > > >   allow test_key_sock_no_write_t self:key_socket { create read
> > > > setopt
> > > > };
> > > > -allow test_key_sock_no_write_t kernel_t:system {
> > > > module_request };
> > > > +kernel_request_load_module(test_key_sock_t)
> > > > 
> > > >   ####################### Deny key_socket { read }
> > > > ##########################
> > > >   type test_key_sock_no_read_t;
> > > > @@ -61,7 +61,7 @@ typeattribute test_key_sock_no_read_t
> > > > keysockdomain;
> > > > 
> > > >   allow test_key_sock_no_read_t self:capability { net_admin };
> > > >   allow test_key_sock_no_read_t self:key_socket { create write
> > > > setopt
> > > > };
> > > > -allow test_key_sock_no_read_t kernel_t:system { module_request
> > > > };
> > > > +kernel_request_load_module(test_key_sock_t)
> > > > 
> > > >   #
> > > >   ########### Allow these domains to be entered from sysadm
> > > > domain
> > > > ############
> > > > diff --git a/policy/test_policy.if b/policy/test_policy.if
> > > > index e1175e8..3f163cb 100644
> > > > --- a/policy/test_policy.if
> > > > +++ b/policy/test_policy.if
> > > > @@ -82,3 +82,9 @@ interface(`userdom_search_admin_dir', `
> > > >       userdom_search_user_home_content($1)
> > > >   ')
> > > >   ')
> > > > +
> > > > +# If the macro isn't defined, then most probably
> > > > module_request
> > > > permission
> > > > +# is just not supported (and relevant operations should be
> > > > just
> > > > allowed).
> > > > +ifdef(`kernel_request_load_module', `', ` dnl
> > > > +interface(`kernel_request_load_module', `')
> > > > +')
> 
> 

