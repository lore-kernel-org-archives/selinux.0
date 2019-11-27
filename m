Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0C4C432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 14:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC3520678
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 14:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="njSczbCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfK0OAN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:00:13 -0500
Received: from mailomta29-sa.btinternet.com ([213.120.69.35]:38285 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726747AbfK0OAN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 09:00:13 -0500
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20191127140010.GNUD22185.sa-prd-fep-043.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Wed, 27 Nov 2019 14:00:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1574863210; 
        bh=rlaY1zQbk3KrYgYfdC6AnBBmdmTzZVhGmUKoVCHQoVw=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=njSczbCQNdn1+NQcrceqnDewC804bqE+cRlfYuRyGrTa1baazuMYHrijAFF1ADiFA6vKf8qw3/bTZgXeaHLH3vJrcjFmQbSwCFQ8UGllBTip34DQX4S9qvpPAlUN3JBL5F2JloaMrP8iUfCNP+9ToOFjS9U072/1fyREPYGCZsr5WTq0CbVCaTwvCpRMVTYp+x1yWI3oSjuHSKKIt4rmwYWHr2u3y8mPLgkJKj0qRHcRXgJUe8D+i2H4ezz9kR7O7fySCos/wzrwqIhIYJuhl0+6EiZpfFkOJMUl6h1PScfUVL0L/RZ9BAwqDkRGJmhyLaVtwX5MoZTflKtjHZqh6A==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.3.133]
X-OWM-Source-IP: 86.134.3.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrudeihedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculddquddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdefrddufeefnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdefrddufeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.3.133) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D8681A10C108871; Wed, 27 Nov 2019 14:00:10 +0000
Message-ID: <0430f9ce2cf78707c16113d7b3b4f5515d120dd6.camel@btinternet.com>
Subject: Re: [PATCH testsuite v5] policy: use the
 kernel_request_load_module() interface
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Date:   Wed, 27 Nov 2019 14:00:09 +0000
In-Reply-To: <20191127123319.814863-1-omosnace@redhat.com>
References: <20191127123319.814863-1-omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2019-11-27 at 13:33 +0100, Ondrej Mosnacek wrote:
> ...instead of open-coding the rules. Also define a fallback to allow
> the
> policy to build even if the interface is not defined.
> 
> Fixes: f5e5a0b8d005 ("selinux-testsuite: Add key_socket tests")
> Cc: Richard Haines <richard_c_haines@btinternet.com>
> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
> 
Thanks, ack from me

> Change in v5: call the macro only once for the whole domain
> Change in v4: fix copy-paste mistakes spotted by Richard
> Change in v3: use different approach as suggested by Stephen
> Change in v2: update also tests/Makefile for consistency
> 
>  policy/test_key_socket.te | 8 +++-----
>  policy/test_policy.if     | 6 ++++++
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/policy/test_key_socket.te b/policy/test_key_socket.te
> index cde426b..64d2cee 100644
> --- a/policy/test_key_socket.te
> +++ b/policy/test_key_socket.te
> @@ -12,8 +12,6 @@ typeattribute test_key_sock_t keysockdomain;
>  # key_socket rules:
>  allow test_key_sock_t self:capability { net_admin };
>  allow test_key_sock_t self:key_socket { create write read setopt };
> -# For CONFIG_NET_KEY=m
> -allow test_key_sock_t kernel_t:system { module_request };
>  
>  ################## Deny capability { net_admin }
> ##########################
>  #
> @@ -29,7 +27,6 @@ typeattribute test_key_sock_no_net_admin_t
> testdomain;
>  typeattribute test_key_sock_no_net_admin_t keysockdomain;
>  
>  allow test_key_sock_no_net_admin_t self:key_socket { create write
> read setopt };
> -allow test_key_sock_no_net_admin_t kernel_t:system { module_request
> };
>  
>  ####################### Deny key_socket { create }
> ##########################
>  type test_key_sock_no_create_t;
> @@ -50,7 +47,6 @@ typeattribute test_key_sock_no_write_t
> keysockdomain;
>  
>  allow test_key_sock_no_write_t self:capability { net_admin };
>  allow test_key_sock_no_write_t self:key_socket { create read setopt
> };
> -allow test_key_sock_no_write_t kernel_t:system { module_request };
>  
>  ####################### Deny key_socket { read }
> ##########################
>  type test_key_sock_no_read_t;
> @@ -61,10 +57,12 @@ typeattribute test_key_sock_no_read_t
> keysockdomain;
>  
>  allow test_key_sock_no_read_t self:capability { net_admin };
>  allow test_key_sock_no_read_t self:key_socket { create write setopt
> };
> -allow test_key_sock_no_read_t kernel_t:system { module_request };
>  
>  #
>  ########### Allow these domains to be entered from sysadm domain
> ############
>  #
>  miscfiles_domain_entry_test_files(keysockdomain)
>  userdom_sysadm_entry_spec_domtrans_to(keysockdomain)
> +
> +# For CONFIG_NET_KEY=m
> +kernel_request_load_module(keysockdomain)
> diff --git a/policy/test_policy.if b/policy/test_policy.if
> index e1175e8..3f163cb 100644
> --- a/policy/test_policy.if
> +++ b/policy/test_policy.if
> @@ -82,3 +82,9 @@ interface(`userdom_search_admin_dir', `
>      userdom_search_user_home_content($1)
>  ')
>  ')
> +
> +# If the macro isn't defined, then most probably module_request
> permission
> +# is just not supported (and relevant operations should be just
> allowed).
> +ifdef(`kernel_request_load_module', `', ` dnl
> +interface(`kernel_request_load_module', `')
> +')

